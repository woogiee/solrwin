# generate
$cert = New-SelfSignedCertificate -FriendlyName "solr" -DnsName "solr" -CertStoreLocation 'cert:\LocalMachine' -NotAfter (Get-Date).AddYears(1)

# trust
$store = New-Object System.Security.Cryptography.X509Certificates.X509Store "Root", "LocalMachine"
$store.Open("ReadWrite")
$store.Add($cert)
$store.Close()

# export
$cert | Export-PfxCertificate -FilePath (Join-Path $PSScriptRoot "\certs\solr-ssl.keystore.pfx") -Password (ConvertTo-SecureString -String "secret" -Force -AsPlainText) -Force | Out-Null

# remove untrusted copy
$cert | Remove-Item
