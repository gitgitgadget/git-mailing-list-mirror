From: Kevin Ballard <kevin@sb.org>
Subject: handle_alias() inside .git dir
Date: Sat, 2 Feb 2008 04:02:20 -0500
Message-ID: <837649D4-465F-4C85-BBE8-B004637EDEF7@sb.org>
Mime-Version: 1.0 (Apple Message framework v919.1)
Content-Type: multipart/signed; boundary=Apple-Mail-8-297441427; micalg=sha1; protocol="application/pkcs7-signature"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 02 10:04:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLEI3-0004mN-PR
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 10:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757460AbYBBJC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 04:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760563AbYBBJC0
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 04:02:26 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:51000 "EHLO
	randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932414AbYBBJCX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Feb 2008 04:02:23 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id 1EA64AF850
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 01:02:21 -0800 (PST)
X-Mailer: Apple Mail (2.919.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72234>


--Apple-Mail-8-297441427
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

It seems that using any aliases while inside a .git dir will end up  
setting the work tree to the current dir, even though it's clearly not  
a work tree. This means that having an alias like `git config alias.st  
= status` and running `git st` inside a .git dir will proceed to spit  
out a listing that claims that every file in the project is missing  
rather than displaying an error about not being in a work tree like  
`git status` will show.

This happens because setup_git_directory_gently() ends up setting  
GIT_DIR_ENVIRONMENT to "." if it detects that we are in the .git  
directory, and then a subsequent call to setup_git_directory() calls  
setup_git_directory_gently() again, which sees the GIT_DIR_ENVIRONMENT  
and ends up calling set_work_tree(). The comment to set_work_tree()  
says it's only called if GIT_DIR is set and calls what it does "old  
behavior". I assume it exists for some sort of backwards  
compatibility, but in quick testing simply commenting out line 266 of  
setup.c (the call to set_work_tree) makes `git st` work as expected.  
I'm not sure if this will have any adverse effect on anything else.  
Does anybody know if this will cause problems?

Another option that seems like it should work is checking if we're a  
bare repo, and if not then setting the work tree to our parent dir,  
assuming any relevant config values or env variables aren't set that  
would point elsewhere. I would try and implement this but after  
looking at it for a few minutes, I fear 4AM is not the best of times  
to try and figure out how this code works.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-8-297441427
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
DxcNMDgwMjAyMDkwMjIxWjAjBgkqhkiG9w0BCQQxFgQUeJhm2P1jSGpV/U1f9VhsCkNU3B8wgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBANlbHD4g8lWpd4wS7lM0YInuuV7vLPrklFMBmmO0wLARtL/OTXhJb+kvrF7Q53DfqC5fl67I
A5kTbGAs1vHND3v37AF9Xh3oThewn4VWUQvSTexOxpZ3y3Jxr6GTZuHD1t8SI+RU3FSdBkJkfi0c
32d99CfXg81NLljZ/Peand0o4nLzRskj0FqPrmeqfe7uCfiuv2gdOSo83ZGLJecYteaQFz6/0z1y
sSEl7ZQViFaHThv2Ud31NgbehqQJ8SnRzw/NNZRzUujH8JjAt9mulBMrZxfDcZRV+GN13FoK04sg
KCxfhNJeGL/XQ5vrFSXcFO5GnlPISxk2AzWdp6dj5VgAAAAAAAA=

--Apple-Mail-8-297441427--
