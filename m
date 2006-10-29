X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 2/2] git-send-email: Read the default SMTP server from the GIT config file
Date: Sun, 29 Oct 2006 22:31:39 +0300
Message-ID: <11621503001930-git-send-email-vsu@altlinux.ru>
References: <11621502993406-git-send-email-vsu@altlinux.ru>
NNTP-Posting-Date: Sun, 29 Oct 2006 19:32:07 +0000 (UTC)
Cc: Ryan Anderson <rda@google.com>, git@vger.kernel.org,
	Sergey Vlasov <vsu@altlinux.ru>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.3.3.ge502
In-Reply-To: <11621502993406-git-send-email-vsu@altlinux.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30442>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeGNo-00006V-Qk for gcvg-git@gmane.org; Sun, 29 Oct
 2006 20:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965349AbWJ2Tbo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 14:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965352AbWJ2Tbn
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 14:31:43 -0500
Received: from master.altlinux.org ([62.118.250.235]:30993 "EHLO
 master.altlinux.org") by vger.kernel.org with ESMTP id S965349AbWJ2Tbn (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 14:31:43 -0500
Received: by master.altlinux.org (Postfix, from userid 584) id 107DDE3A65;
 Sun, 29 Oct 2006 22:31:42 +0300 (MSK)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Make the default value for --smtp-server configurable through the
'sendemail.smtpserver' option in .git/config (or $HOME/.gitconfig).

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 Documentation/git-send-email.txt |    8 +++++---
 git-send-email.perl              |    3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ec0e201..4c8d907 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -68,9 +68,11 @@ The options available are:
 --smtp-server::
 	If set, specifies the outgoing SMTP server to use.  A full
 	pathname of a sendmail-like program can be specified instead;
-	the program must support the `-i` option.  Defaults to
-	`/usr/sbin/sendmail` or `/usr/lib/sendmail` if such program is
-	available, or to `localhost` otherwise.
+	the program must support the `-i` option.  Default value can
+	be specified by the 'sendemail.smtpserver' configuration
+	option; the built-in default is `/usr/sbin/sendmail` or
+	`/usr/lib/sendmail` if such program is available, or
+	`localhost` otherwise.
 
 --subject::
    	Specify the initial subject of the email thread.
diff --git a/git-send-email.perl b/git-send-email.perl
index c42dc3b..4c87c20 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -231,6 +231,9 @@ if (!defined $initial_reply_to && $promp
 }
 
 if (!$smtp_server) {
+	$smtp_server = $repo->config('sendemail.smtpserver');
+}
+if (!$smtp_server) {
 	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
 		if (-x $_) {
 			$smtp_server = $_;
-- 
1.4.3.3.ge502
