From: Kevin Ballard <kevin@sb.org>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 19:03:13 -0500
Message-ID: <1973E1D5-C8CC-4979-A085-85A2C5A13E57@sb.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <34F43A68-6041-42BE-85BD-3EF971875C0F@sb.org> <alpine.LFD.1.00.0801111356000.3148@woody.linux-foundation.org> <200801120026.01930.robin.rosenberg@dewire.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-10-598178401; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 01:03:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDTqg-0005vT-BP
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759639AbYALADR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 19:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759020AbYALADR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:03:17 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:34178 "EHLO
	randymail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754814AbYALADQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 19:03:16 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a7.g.dreamhost.com (Postfix) with ESMTP id 779D9B7525;
	Fri, 11 Jan 2008 16:03:15 -0800 (PST)
In-Reply-To: <200801120026.01930.robin.rosenberg@dewire.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70227>


--Apple-Mail-10-598178401
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

Speaking of normalizing composed sequences, could that be the cause =20
for the following?

kevin@KBALLARD:~/Dev/git> ls
kevin@KBALLARD:~/Dev/git> ls -a
./          ../         .git/       .gitignore
kevin@KBALLARD:~/Dev/git> git reset --hard
HEAD is now at 58beb2c... Trim leading / off of paths in git-svn =20
prop_walk
kevin@KBALLARD:~/Dev/git> git st
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	gitweb/test/M=E4rchen
nothing added to commit but untracked files present (use "git add" to =20=

track)

Some further exploration seems to support my cause:

kevin@KBALLARD:~/Dev/git> git ls-files gitweb/test
"gitweb/test/M\303\244rchen"
gitweb/test/file with spaces
gitweb/test/file+plus+sign
kevin@KBALLARD:~/Dev/git/gitweb/test> ls M=E4rchen | xxd
0000000: 4d61 cc88 7263 6865 6e0a                 Ma..rchen.

As you can see, git has the file tracked using M\303\244rchen, where =20
\303\244 (or 0xC3A4, or U+00E4) is Latin Small Letter A With =20
Diaeresis, but the filesystem reports it as "Ma\xCC\x88rchen" where =20
0xCC88 (or U+0308) is Combining Diaeresis.

In other words, the git repository itself exhibits a problem under OS =20=

X. I'm not sure if I didn't notice this untracked file before, or if =20
the filesystem (or the index) actually used the other form previously, =20=

but regardless there's a problem that I believe would be present even =20=

if I was using Case-Sensitive HFS+.

-Kevin Ballard

On Jan 11, 2008, at 6:26 PM, Robin Rosenberg wrote:

> Could we just have a lookup table index extension for identifying the
> duplicates (when checking is enabled using core configuration option =20=

> #3324)?
> That table would keep a mapping from a normalized form (maybe include
> canonical encoding while we're at it) to the actual octet =20
> sequence(s) used.

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-10-598178401
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEDsG8BKvlrEW0HUBIxWIgjUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDQyMzIxMjM0OVoXDTA4MDQyMjIxMjM0
OVowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAN/koURrN2ndrAiuAuHHrdFz+hLGQ7ZsXloGnObjALGOFY3Kmk2FCwAJPIha5GfM
YFmZIoqxs+DbOWOn6KZ9hcQ5wf4EOgokayrEs3G72T+G8ZE4aXrw0CWJzKLjaIQeDZNZoHA44jlZ
dG70wtZske898IoPz6YHpkcXiulllATfd8Pa7EgjPri5hKFiRXKI52OsOQTX6cNMMZJUIm8DvfQ5
jmDyAtywNZGSGeUAMbWnpuLq7H18zpye2Q1hr+p4kucazMb+i7OHXPvX7yx2jMjhN5jw/gYkuzQQ
JExp1fJyAZQ/av/ZgaxWchhhi4ziFXIlX3B09DTlOQlF53P3fi0CAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAw/qc6zq+0Qy2
XaodDlt2L6Vq1DzaVWjV152BFjidmsyhyCkCuyYdAcDp17opIfrNCBbOX5DdY6cpFpnSCxCZeIEB
PDc3TaaFPtzr8qrpcNDohRSdt+qFLUeMHzlidAiAjvjI3tPKv3JLTakWdQR/XPHsg4mWoaVQU2hM
HOQBw8EwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBD
b25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYD
VQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDsG8BKvlrEW0HUBIxWI
gjUwCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDgwMTEyMDAwMzE0WjAjBgkqhkiG9w0BCQQxFgQUjLZGx0W5Tt+XZLZwkE1YwEHV27AwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAJQx6smb1kTlNm7ovW6SaNBowamJZBi5sN2qPa9CRhhUvIeoKjFVzBpRNZmALAuAuKD4b28h
LladC8m0j86rMKX0X/nnydnhmuqpV37YX3GnKmCppBnr5ZDSzek5SRd7L0H1Sy70Lz6Yi5D/MN93
ZXKg0o+pi0pwYBtmsZA8NuLUMdtjd4Uqc6s1q+1JVEb48QIv22xrxzDFxs3NL+LLyuPn4WReNio+
sE0VT+1rUOVUARYDAqIrmAUZk70hXc3YKEWxWO0THFxO3qD6EEw9hV4VeTWmwld3xEYg9SJq5Obm
28TkqH2sx+XsDuF8FuyRVFYLj3Y+gASagQsFdXm3SvcAAAAAAAA=

--Apple-Mail-10-598178401--
