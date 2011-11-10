From: "Pitucha, Stanislaw Izaak" <stanislaw.pitucha@hp.com>
Subject: RE: Disappearing change on pull rebase
Date: Thu, 10 Nov 2011 13:35:40 +0000
Message-ID: <3FF1328CB05DB74898F769F1BA17812C3E49B74699@GVW1348EXA.americas.hpqcorp.net>
References: <3FF1328CB05DB74898F769F1BA17812C3E49B74671@GVW1348EXA.americas.hpqcorp.net>
 <B5934593-5EE9-4A9F-96D5-0E36B696EFBD@jetbrains.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=SHA1;
	protocol="application/x-pkcs7-signature";
	boundary="----=_NextPart_000_03EB_01CC9FAD.A35CD370"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 14:36:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROUoB-0003GZ-2P
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 14:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504Ab1KJNgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 08:36:42 -0500
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:33246 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab1KJNgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 08:36:41 -0500
Received: from G9W0369G.americas.hpqcorp.net (g9w0369g.houston.hp.com [16.216.193.232])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g5t0006.atlanta.hp.com (Postfix) with ESMTPS id 4890EC064
	for <git@vger.kernel.org>; Thu, 10 Nov 2011 13:36:40 +0000 (UTC)
Received: from G1W0394.americas.hpqcorp.net (16.236.31.4) by
 G9W0369G.americas.hpqcorp.net (16.216.193.232) with Microsoft SMTP Server
 (TLS) id 14.1.289.1; Thu, 10 Nov 2011 13:35:42 +0000
Received: from GVW1348EXA.americas.hpqcorp.net ([16.238.72.128]) by
 G1W0394.americas.hpqcorp.net ([16.236.31.4]) with mapi; Thu, 10 Nov 2011
 13:35:42 +0000
Thread-Topic: Disappearing change on pull rebase
Thread-Index: AcyfrBAo9+L7NDp2SSeDxXYKtdIviQAASGRA
In-Reply-To: <B5934593-5EE9-4A9F-96D5-0E36B696EFBD@jetbrains.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185228>

------=_NextPart_000_03EB_01CC9FAD.A35CD370
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

As mentioned in the original mail - the merge commit did have changes. =
Here's the log of reproducing it. The line containing "2" in changelog =
is gone from master after pull --rebase.

$ git init fake_upstream
Initialized empty Git repository in /tmp/fake_upstream/.git/
$ cd fake_upstream/=20
fake_upstream$ echo some_content > test
fake_upstream$ echo 1 > changelog
fake_upstream$ git add test changelog=20
fake_upstream$ git commit -m 'first commit'
[master (root-commit) b1b683d] first commit
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 changelog
 create mode 100644 test
fake_upstream$ cd ..

$ git clone /tmp/fake_upstream/ disappearing_commit
Cloning into disappearing_commit...
done.
$ cd disappearing_commit/
disappearing_commit$ git checkout -b some-branch
Switched to a new branch 'some-branch'
disappearing_commit$ echo blah >> test
disappearing_commit$ git commit test -m 'branch modification'
[some-branch 528f166] branch modification
 1 files changed, 1 insertions(+), 0 deletions(-)
disappearing_commit$ git checkout master
Switched to branch 'master'

disappearing_commit$ git merge --no-ff --no-commit some-branch
Automatic merge went well; stopped before committing as requested
disappearing_commit$ echo 2 >> changelog=20
disappearing_commit$ git add changelog
disappearing_commit$ git commit
[master e41e4c9] Merge branch 'some-branch'

disappearing_commit$ git show
commit e41e4c963a72528e3b2b5945ca419e19cdba1e4b
Merge: b1b683d 528f166
Author: Stanislaw Pitucha <stanislaw.pitucha@hp.com>
Date:   Thu Nov 10 13:30:04 2011 +0000

    Merge branch 'some-branch'

diff --cc changelog
index d00491f,d00491f..1191247
--- a/changelog
+++ b/changelog
@@@ -1,1 -1,1 +1,2 @@@
  1
++2
disappearing_commit$ git pull --rebase
First, rewinding head to replay your work on top of it...
Applying: branch modification
disappearing_commit$ git show
commit ef8f5e40db9fe7efbd4e493ff68b12327acde283
Author: Stanislaw Pitucha <stanislaw.pitucha@hp.com>
Date:   Thu Nov 10 13:29:33 2011 +0000

    branch modification

diff --git a/test b/test
index 6e099dc..2f3f685 100644
--- a/test
+++ b/test
@@ -1 +1,2 @@
 some_content
+blah


Regards,
Stanis=C5=82aw Pitucha
Cloud Services=20
Hewlett Packard

------=_NextPart_000_03EB_01CC9FAD.A35CD370
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIScjCCBBkw
ggMBAhBhcMtJjF+YRSnnsKbZUFt6MA0GCSqGSIb3DQEBBQUAMIHKMQswCQYDVQQGEwJVUzEXMBUG
A1UEChMOVmVyaVNpZ24sIEluYy4xHzAdBgNVBAsTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsxOjA4
BgNVBAsTMShjKSAxOTk5IFZlcmlTaWduLCBJbmMuIC0gRm9yIGF1dGhvcml6ZWQgdXNlIG9ubHkx
RTBDBgNVBAMTPFZlcmlTaWduIENsYXNzIDIgUHVibGljIFByaW1hcnkgQ2VydGlmaWNhdGlvbiBB
dXRob3JpdHkgLSBHMzAeFw05OTEwMDEwMDAwMDBaFw0zNjA3MTYyMzU5NTlaMIHKMQswCQYDVQQG
EwJVUzEXMBUGA1UEChMOVmVyaVNpZ24sIEluYy4xHzAdBgNVBAsTFlZlcmlTaWduIFRydXN0IE5l
dHdvcmsxOjA4BgNVBAsTMShjKSAxOTk5IFZlcmlTaWduLCBJbmMuIC0gRm9yIGF1dGhvcml6ZWQg
dXNlIG9ubHkxRTBDBgNVBAMTPFZlcmlTaWduIENsYXNzIDIgUHVibGljIFByaW1hcnkgQ2VydGlm
aWNhdGlvbiBBdXRob3JpdHkgLSBHMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK8K
DcLVLNtnuS3llCfdpb7gsE2Ps2FWPNZ8w/TNPobLooji4dikacW14r/BpkdQXkY5i9WWurVvFL8Q
zicTngVHmzF6E9gf2dMCN4utLEfwjoEGpw0wDOv3PA8gHdxyRu6lAshbw8lWaUzFGMGRewvVEwCb
vO/DSD5GYCCFKtWQts2LoMwy3bf9QFWyUBxWrsyNd03HIE2nMXbvaJKKkB4IgVayrWmjUtDLHMQj
PR+Z/kzoFmOOxgiO9jH20vrldt21HJKjSc3NAc1ozalpuqPrHQ2cpCCmwaDF0UZMF23SrGY/lozg
hNQ2/yJZxfkRYKhfBH3yGvYlQmEPxEq4PokCAwEAATANBgkqhkiG9w0BAQUFAAOCAQEANCYVPMCN
TUNJHb3pIZLXZpy33sW40ORdX3YiwCb5hDo6+Yy1++xg8ejOBLDI3acDjzDzmN+k5qQx39McC0bc
ciA/ru4FPKQzPws5rHB4c0uZK98wwlSwqDtVof4WKM1CvXRugNsnRKfORF3UG5CYDR5ClLEALATQ
dKMCBSJjY82DtfvBbWJraXX9XXBBufW/fN++wTJzIiGLWIF7FZF6uuNkSLB/+zYl2pXQ8SQUF90Y
gGtGIzlU9Y5iCQQdlJCmm+Yl4kJFqriQrb4Ij6kLQhiUz3I54bFD4CjPt+dabBNrSbP/4xh8iYsz
Xawz16f52jpVyVgQ+arvWrbPS0vfKjCCBmEwggVJoAMCAQICEFHz5uyygZHVFZ4pmbCHOnswDQYJ
KoZIhvcNAQEFBQAwgcoxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5WZXJpU2lnbiwgSW5jLjEfMB0G
A1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29yazE6MDgGA1UECxMxKGMpIDE5OTkgVmVyaVNpZ24s
IEluYy4gLSBGb3IgYXV0aG9yaXplZCB1c2Ugb25seTFFMEMGA1UEAxM8VmVyaVNpZ24gQ2xhc3Mg
MiBQdWJsaWMgUHJpbWFyeSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSAtIEczMB4XDTA5MDkwMjAw
MDAwMFoXDTE0MDkwMTIzNTk1OVowgfcxCzAJBgNVBAYTAlVTMSAwHgYDVQQKExdIZXdsZXR0LVBh
Y2thcmQgQ29tcGFueTEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29yazE7MDkGA1UECxMy
VGVybXMgb2YgdXNlIGF0IGh0dHBzOi8vd3d3LnZlcmlzaWduLmNvbS9ycGEgKGMpMDkxNTAzBgNV
BAsTLENsYXNzIDIgTWFuYWdlZCBQS0kgSW5kaXZpZHVhbCBTdWJzY3JpYmVyIENBMTEwLwYDVQQD
EyhDb2xsYWJvcmF0aW9uIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IEcyMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAp2FraNquqoVkDEvLUMsw6HMhjon+yi1v/kajA27jIrdyhRMj4g+P
BveBTHrtA7w97Rx1UKPP6CvOaAE5xUtoW9ajYZtO5kdiUFyzWHsbUgSjKy+yNO4QoHeEzaQi/JWU
OYev/AV5YYJoEDIysosEELS1/M64iE2Utzr+LxiWhdaqSRE4jigbm4Dy4ayLzqAv5f7oILrJNZ6S
hqLiGGCpP+7relTyRgFXmEX/SKN/a39JwZoKSNUdIkYyr7wmNI9+zylheDJghuk+kZDAD3NXv4EG
VMUfOg5UEdhAJ0Lw40D4pqKa2ej1H0UipK1EEdRTm94RzfE8z8vDP8+dcgOqCwIDAQABo4ICEjCC
Ag4wEgYDVR0TAQH/BAgwBgEB/wIBADBwBgNVHSAEaTBnMGUGC2CGSAGG+EUBBxcCMFYwKAYIKwYB
BQUHAgEWHGh0dHBzOi8vd3d3LnZlcmlzaWduLmNvbS9jcHMwKgYIKwYBBQUHAgIwHhocaHR0cHM6
Ly93d3cudmVyaXNpZ24uY29tL3JwYTA0BgNVHR8ELTArMCmgJ6AlhiNodHRwOi8vY3JsLnZlcmlz
aWduLmNvbS9wY2EyLWczLmNybDAOBgNVHQ8BAf8EBAMCAQYwLgYDVR0RBCcwJaQjMCExHzAdBgNV
BAMTFlByaXZhdGVMYWJlbDQtMjA0OC0xNDIwHQYDVR0OBBYEFCJ906SrV6xWf6l/QUQalbxb+Kvu
MIHwBgNVHSMEgegwgeWhgdCkgc0wgcoxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5WZXJpU2lnbiwg
SW5jLjEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29yazE6MDgGA1UECxMxKGMpIDE5OTkg
VmVyaVNpZ24sIEluYy4gLSBGb3IgYXV0aG9yaXplZCB1c2Ugb25seTFFMEMGA1UEAxM8VmVyaVNp
Z24gQ2xhc3MgMiBQdWJsaWMgUHJpbWFyeSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSAtIEczghBh
cMtJjF+YRSnnsKbZUFt6MA0GCSqGSIb3DQEBBQUAA4IBAQAvUbxneMj/3SU5WlUKapv9ZGIeeNSf
6/t6gKUUsCT2A1KQMlZmK7/gn4ndrXWdch7Uafl6WkPlBcunYRGvJ6YkJCP4uV86Lwv68mK6REwJ
FMiKHy/qFnRaoI+pLfaIlMQ9l7Q2DRnNLSyCBl9b02PaGzX+XQQxGhLiE89Z1E+ajicWG1zRzBUb
Px46ptQUjfjYPNyP4cLWT5rJ7olc9/mRyfIO4nGU8lRjGcuKwxZhOP+TftJgd/fRYf68Kf2Bkue4
cdrI2UUgYD02GBL/S8E8FBsOrAoJ5N6cEYacwT2BZgHzYrxTC5ZyxzY9TWtGldxEH/moJ5OLtF+K
auJWhaACMIIH7DCCBtSgAwIBAgIQSm3k9/toMcn6DmzGTStNqzANBgkqhkiG9w0BAQUFADCB9zEL
MAkGA1UEBhMCVVMxIDAeBgNVBAoTF0hld2xldHQtUGFja2FyZCBDb21wYW55MR8wHQYDVQQLExZW
ZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTswOQYDVQQLEzJUZXJtcyBvZiB1c2UgYXQgaHR0cHM6Ly93
d3cudmVyaXNpZ24uY29tL3JwYSAoYykwOTE1MDMGA1UECxMsQ2xhc3MgMiBNYW5hZ2VkIFBLSSBJ
bmRpdmlkdWFsIFN1YnNjcmliZXIgQ0ExMTAvBgNVBAMTKENvbGxhYm9yYXRpb24gQ2VydGlmaWNh
dGlvbiBBdXRob3JpdHkgRzIwHhcNMTEwMzE0MDAwMDAwWhcNMTMwMzEzMjM1OTU5WjCBqTEgMB4G
A1UEChQXSGV3bGV0dC1QYWNrYXJkIENvbXBhbnkxJjAkBgNVBAsUHUVtcGxveW1lbnQgU3RhdHVz
IC0gRW1wbG95ZWVzMRIwEAYDVQQLEwlTL01JTUUgRzIxIDAeBgNVBAMTF1N0YW5pc2xhdyBJemFh
ayBQaXR1Y2hhMScwJQYJKoZIhvcNAQkBFhhzdGFuaXNsYXcucGl0dWNoYUBocC5jb20wggEiMA0G
CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC13AtQqRmF7uO4vGbI5TpogyhI5SU+R/dQha6Vco3L
vVFGrfCtWKBAtqoSBAVXjkAXYbDLLigngNyzTEGi+cGNhymJCAWovHmNvxLK6YmOiwQXRjaauNfM
BxhjnyZsSgRge65HTgQ8x2d1Tv8ewqAAqwW/8IQfWI4H/tQkGSC8apks7RHbhqK5y5iXgac3kgTy
OpCPsj8/GsYLBAaZ9PWL4PnWOq1QCjRo9nVsg/6iV4D0Z++maD+HCrEfSgKDDPR8y71Pydx6nVne
CHjxbHHjrHg79AfOLNQz3rnV9tybgcVzdMq7xQ+Xc4B98LxHF9TfFi7Kd9AfZULk6BYLLql5AgMB
AAGjggO+MIIDujAjBgNVHREEHDAagRhzdGFuaXNsYXcucGl0dWNoYUBocC5jb20wDAYDVR0TAQH/
BAIwADAOBgNVHQ8BAf8EBAMCBaAwWQYDVR0fBFIwUDBOoEygSoZIaHR0cDovL29uc2l0ZWNybC52
ZXJpc2lnbi5jb20vSGV3bGV0dFBhY2thcmRDb21wYW55U01JTUVHMi9MYXRlc3RDUkwuY3JsMB8G
A1UdIwQYMBaAFCJ906SrV6xWf6l/QUQalbxb+KvuMB0GA1UdDgQWBBSLVHc3wZOTMWu8Uvpz1ipY
BtHkrDCCATIGCCsGAQUFBwEBBIIBJDCCASAwJwYIKwYBBQUHMAGGG2h0dHA6Ly9ocC1vY3NwLnZl
cmlzaWduLmNvbTCB9AYIKwYBBQUHMAKkgecwgeQxMTAvBgNVBAMTKENvbGxhYm9yYXRpb24gQ2Vy
dGlmaWNhdGlvbiBBdXRob3JpdHkgRzIxMDAuBgNVBAsTJ0NsYXNzIDIgT25TaXRlIEluZGl2aWR1
YWwgU3Vic2NyaWJlciBDQTE6MDgGA1UECxMxVGVybXMgb2YgdXNlIGF0IGh0dHBzOi8vd3d3LnZl
cmlzaWduLmNvbS9ycGEoYykwOTEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29yazEgMB4G
A1UEChMXSGV3bGV0dC1QYWNrYXJkIENvbXBhbnkwggE9BgNVHSAEggE0MIIBMDCCASwGC2CGSAGG
+EUBBxcCMIIBGzAoBggrBgEFBQcCARYcaHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL3JwYTCB7gYI
KwYBBQUHAgIwgeEwHhYXSGV3bGV0dC1QYWNrYXJkIENvbXBhbnkwAwIBAhqBvkF1dGhvcml0eSB0
byBiaW5kIEhQIGRvZXMgbm90IGNvcnJlc3BvbmQgd2l0aCB1c2Ugb3IgcG9zc2Vzc2lvbiBvZiB0
aGlzIGNlcnRpZmljYXRlLiBJc3N1ZWQgdG8gZmFjaWxpdGF0ZSBjb21tdW5pY2F0aW9uIHdpdGgg
SFAuIFZlcmlTaWduJ3MgQ1BTIGluY29ycC4gQnkgcmVmZXJlbmNlIGxpYWIuIGx0ZC4gKGMpOTcg
VmVyaVNpZ24wFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwQwSwYJKoZIhvcNAQkPBD4wPDAOBggqhkiG
9w0DAgICAIAwDgYIKoZIhvcNAwICAgBAMA4GCCqGSIb3DQMEAgIAgDAKBggqhkiG9w0DBzANBgkq
hkiG9w0BAQUFAAOCAQEApP04g1cJvwiHd3n7iMIbfVfizPtNRI3T+EmwO/OXxgTp5+nFap8+P7+7
bEyA5VTxGF88YpV2RQ38A/SUBnmF20RfwLbj8PKBUW7f7S50sljnGKNejYd8f2cc/jXeXLs2y9rr
v9jiK38EYPfGCWIk+4TZ7ncAP9DChqhqkK1N0PRr9FX6KthftNM6e2eepEJ0GGCJ5FxEb9kcXH8b
LZu3xqUSCmTdbIEprw58FeDFewUTk3s+Xi2R7kPUN3pj/X1FCn1zL+Rztgt6bC8JCQLJMpf/LO8Y
GpgQLahb0tofxgp+yQLI/KvyW3TCB52yOWDfepZmsFhXNRliuOKsQJBFyTGCBZgwggWUAgEBMIIB
DDCB9zELMAkGA1UEBhMCVVMxIDAeBgNVBAoTF0hld2xldHQtUGFja2FyZCBDb21wYW55MR8wHQYD
VQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTswOQYDVQQLEzJUZXJtcyBvZiB1c2UgYXQgaHR0
cHM6Ly93d3cudmVyaXNpZ24uY29tL3JwYSAoYykwOTE1MDMGA1UECxMsQ2xhc3MgMiBNYW5hZ2Vk
IFBLSSBJbmRpdmlkdWFsIFN1YnNjcmliZXIgQ0ExMTAvBgNVBAMTKENvbGxhYm9yYXRpb24gQ2Vy
dGlmaWNhdGlvbiBBdXRob3JpdHkgRzICEEpt5Pf7aDHJ+g5sxk0rTaswCQYFKw4DAhoFAKCCA18w
GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTExMTEwMTMzNTQwWjAj
BgkqhkiG9w0BCQQxFgQU7flf7wQBsVQD8B6M8gOWozP+fDwwgbcGCSqGSIb3DQEJDzGBqTCBpjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG
9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwCgYIKoZIhvcNAgUwggEfBgkr
BgEEAYI3EAQxggEQMIIBDDCB9zELMAkGA1UEBhMCVVMxIDAeBgNVBAoTF0hld2xldHQtUGFja2Fy
ZCBDb21wYW55MR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTswOQYDVQQLEzJUZXJt
cyBvZiB1c2UgYXQgaHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL3JwYSAoYykwOTE1MDMGA1UECxMs
Q2xhc3MgMiBNYW5hZ2VkIFBLSSBJbmRpdmlkdWFsIFN1YnNjcmliZXIgQ0ExMTAvBgNVBAMTKENv
bGxhYm9yYXRpb24gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgRzICEEpt5Pf7aDHJ+g5sxk0rTasw
ggEhBgsqhkiG9w0BCRACCzGCARCgggEMMIH3MQswCQYDVQQGEwJVUzEgMB4GA1UEChMXSGV3bGV0
dC1QYWNrYXJkIENvbXBhbnkxHzAdBgNVBAsTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsxOzA5BgNV
BAsTMlRlcm1zIG9mIHVzZSBhdCBodHRwczovL3d3dy52ZXJpc2lnbi5jb20vcnBhIChjKTA5MTUw
MwYDVQQLEyxDbGFzcyAyIE1hbmFnZWQgUEtJIEluZGl2aWR1YWwgU3Vic2NyaWJlciBDQTExMC8G
A1UEAxMoQ29sbGFib3JhdGlvbiBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBHMgIQSm3k9/toMcn6
DmzGTStNqzANBgkqhkiG9w0BAQEFAASCAQA+WxbChaGoBmDH0VrDW8qZ8THKwllrByAFPNNFy1QH
AlZuXOXjdhtmsEm4AwEgSmymPCv+vJSePS4d4k9uGKFwBK1OWoYO+RUfEAXIQOtxHCN5U5kbWaC6
gZfq/f4Xr7lyg/CgFksR2XILmw18QGXm+VBegnCJlX5GgnuJx3C919d+zXrx8mquFeR/Mua42UMJ
oq1PgYRp8bwgTVkKfgZQpwhbI+AtCJTWwRomZ7LUf4arbKFIKONl2VKtHew7btoi6rtp+IZKEEYa
hN79KRGSROBqWSZfXKnwesmQx7dUvA1xybZOKLPPaYgY4Bupx5R8IVsFqIxz67NHu4gwf5KeAAAA
AAAA

------=_NextPart_000_03EB_01CC9FAD.A35CD370--
