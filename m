From: Edward Ned Harvey <git@nedharvey.com>
Subject: git and SSL certificates
Date: Fri, 24 Feb 2012 14:11:27 -0500
Message-ID: <000501ccf328$1efe1070$5cfa3150$@nedharvey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 20:11:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S10YS-0002nA-Bj
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 20:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859Ab2BXTLj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 14:11:39 -0500
Received: from relay.ihostexchange.net ([66.46.182.57]:14632 "EHLO
	relay.ihostexchange.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab2BXTLi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2012 14:11:38 -0500
Received: from bigsur (98.110.160.237) by smtp.ihostexchange.net
 (66.46.182.50) with Microsoft SMTP Server (TLS) id 8.3.213.0; Fri, 24 Feb
 2012 14:11:31 -0500
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AczzDcL2s5IYSQTRQyOHjKlZexE5uA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191445>

I have a git server hosted on https (github enterprise virtual applianc=
e),
using a valid signed cert from startcom, which passes all the SSL check=
s for
any browser I use on any OS (IE, Firefox, Safari, Chrome, on Ubuntu, Ma=
c
OSX, MS Win7) but when I connect to it using git, git complains about t=
he
cert, but it's platform dependent, and it doesn't seem to make any sens=
e...=A0
Does git have its own set of SSL trusted root CA's compiled in at build=
 time
or something?=A0 It seems weird that it's apparently not using the trus=
ted
root CA's from the OS...

I have not tried re-signing my cert using a different CA.=A0 I see gith=
ub uses
DigiCert.=A0 My clients do not complain about SSL cert when cloning fro=
m
github.

The test command is, simply:
git clone https://user@server.com/user/project.git
(Obviously, using a real username, a real servername, and a real projec=
t
name instead of the line above.)

** On OSX, it works no problem.=A0 This is OSX 10.7 Lion, upgraded from=
 10.6
SL, with 4.1 upgraded from XCode 3.2.6.=A0 Git version 1.7.4.4

** On ubuntu, oneiric x86_64, git version 1.7.5.4, it says:
error: server certificate verification failed. CAfile:
/etc/ssl/certs/ca-certificates.crt CRLfile: none while accessing
https://user@server.com/user/project.git/info/refs
fatal: HTTP request failed

This is annoying, because ... It names the location where it's searchin=
g for
the root certificates, so I thought maybe the startcom root CA wasn't i=
n
there, so I went and looked, and confirmed it's there.=A0 Compared the =
actual
pem encoded root ca cert string to the one that signed my server's cert=
, and
it's definitely there.

On linux, users are able to workaround using GIT_SSL_NO_VERIFY=3D1, but=
 that
kind of defeats the purpose.=A0 I don't want them doing this.

** On Win 7 64bit, tortoisegit 1.6.5.0 based on git 1.7.3.1, it says:
error: SSL certificate problem, verify that the CA cert is OK. Details:
error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate ver=
ify
failed while accessing https://user@server.com/user/project.git/info/re=
fs
fatal: HTTP request failed
Cloning into C:\workdir

I don't see any way to workaround, but haven't looked very hard for a
windows equivalent of GIT_SSL_NO_VERIFY

** On Win 7 64bit, cygwin git version 1.7.9, it says:
error: SSL certificate problem, verify that the CA cert is OK. Details:
error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate ver=
ify
failed while accessing https://user@server.com/user/project.git/info/re=
fs=20
fatal: HTTP request failed

Also, it ignores the presence of GIT_SSL_NO_VERIFY.=A0 So there isn't a=
ny
known workaround for cygwin.
