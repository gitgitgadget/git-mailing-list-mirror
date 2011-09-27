From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v2] send-email: auth plain/login fix
Date: Tue, 27 Sep 2011 23:36:59 +0200
Message-ID: <1317159419-23166-1-git-send-email-zbyszek@in.waw.pl>
References: <m3fwjjp69m.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: gitster@pobox.com, joe@perches.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 23:37:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8fLi-000272-5v
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 23:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab1I0Vhy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 17:37:54 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:41294 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab1I0Vhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 17:37:53 -0400
Received: from 86-85-n1.aster.pl ([85.222.86.85] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1R8fLZ-0004oW-U4; Tue, 27 Sep 2011 23:37:50 +0200
X-Mailer: git-send-email 1.7.6.234.gb0b18.dirty
In-Reply-To: <m3fwjjp69m.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182267>

git send-email was not authenticating properly when communicating over
TLS with a server supporting only AUTH PLAIN and AUTH LOGIN. This is
e.g. the standard server setup under debian with exim4 and probably
everywhere where system accounts are used.

The solution comes from this forum thread:
http://www.perlmonks.org/?node_id=3D904354

This patch is tested by sending it :)

Before:
Net::SMTP>>> Net::SMTP(2.31)
Net::SMTP>>>   Net::Cmd(2.29)
Net::SMTP>>>     Exporter(5.64_01)
Net::SMTP>>>   IO::Socket::INET(1.31)
Net::SMTP>>>     IO::Socket(1.31)
Net::SMTP>>>       IO::Handle(1.28)
=2E..
Net::SMTP=3DGLOB(0x238f668)>>> STARTTLS
Net::SMTP=3DGLOB(0x238f668)<<< 220 2.0.0 Ready to start TLS
Net::SMTP::SSL=3DGLOB(0x238f668)>>> EHLO localhost.localdomain
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 250-yyy.yyy.yyy Hello xxx.xxx [xxx.=
xxx.xxx.xxx], pleased to meet you
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 250-PIPELINING
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 250-8BITMIME
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 250-SIZE 80000000
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 250-DSN
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 250-AUTH=3DLOGIN PLAIN
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 250-AUTH LOGIN PLAIN
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 250-DELIVERBY
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 250 HELP
Password:
Net::SMTP::SSL=3DGLOB(0x238f668)>>> AUTH
Net::SMTP::SSL=3DGLOB(0x238f668)<<< 501 5.5.2 AUTH mechanism must be sp=
ecified
5.5.2 AUTH mechanism must be specified

After:
Net::SMTP=3DGLOB(0x1ac4a60)>>> STARTTLS
Net::SMTP=3DGLOB(0x1ac4a60)<<< 220 2.0.0 Ready to start TLS
Net::SMTP::SSL=3DGLOB(0x1ac4a60)>>> EHLO localhost.localdomain
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 250-yyy.yyy.yyy Hello xxx.xxx [xxx.=
xxx.xxx.xxx], pleased to meet you
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 250-PIPELINING
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 250-8BITMIME
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 250-SIZE 80000000
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 250-DSN
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 250-AUTH=3DLOGIN PLAIN
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 250-AUTH LOGIN PLAIN
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 250-DELIVERBY
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 250 HELP
Password:
Net::SMTP::SSL=3DGLOB(0x1ac4a60)>>> AUTH LOGIN
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 334 VXNlcm5hbWU6
Net::SMTP::SSL=3DGLOB(0x1ac4a60)>>> emJ5c3plaw=3D=3D
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 334 UGFzc3dvcmQ6
Net::SMTP::SSL=3DGLOB(0x1ac4a60)>>> dGVzdA=3D=3D
Net::SMTP::SSL=3DGLOB(0x1ac4a60)<<< 535 5.7.0 authentication failed
5.7.0 authentication failed

The password is incorrect in this snippet, but the protocol works corre=
ctly.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 v2: - added sign-off as requested, although the patch is as trivial
       as it gets
     - the import is performed only if it will be used

 git-send-email.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 37dfbe7..5a22d18 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1098,6 +1098,8 @@ X-Mailer: git-send-email $gitversion
 		}
=20
 		if (defined $smtp_authuser) {
+			require Authen::SASL;
+			Authen::SASL->import(qw(Perl));
=20
 			if (!defined $smtp_authpass) {
=20
--=20
1.7.6
