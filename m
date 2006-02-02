From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 2/2] git-send-email: Add --quiet to reduce some of the chatter when sending emails.
Date: Thu, 2 Feb 2006 11:56:06 -0500
Message-ID: <11388993664094-git-send-email-ryan@michonline.com>
References: <11388993663675-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 17:59:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4hlH-0005Ww-OK
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 17:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWBBQ4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 11:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWBBQ4o
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 11:56:44 -0500
Received: from mail.autoweb.net ([198.172.237.26]:25518 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932168AbWBBQ4o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 11:56:44 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F4hlC-000524-65
	for git@vger.kernel.org; Thu, 02 Feb 2006 11:56:43 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F4hlA-00029D-SN; Thu, 02 Feb 2006 11:56:41 -0500
Received: from localhost
	([127.0.0.1] helo=mythryan2 ident=ryan)
	by mythical with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F4hkc-0000OM-KA; Thu, 02 Feb 2006 11:56:06 -0500
In-Reply-To: <11388993663675-git-send-email-ryan@michonline.com>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15511>

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

 git-send-email.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

3dcbd6298dc6fb4a903404cb9c47e3690bf2e01a
diff --git a/git-send-email.perl b/git-send-email.perl
index 51b7513..ca1fa37 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -34,7 +34,7 @@ my $compose_filename = ".msg.$$";
 my (@to,@cc,$initial_reply_to,$initial_subject,@files,$from,$compose);
 
 # Behavior modification variables
-my ($chain_reply_to, $smtp_server) = (1, "localhost");
+my ($chain_reply_to, $smtp_server, $quiet) = (1, "localhost", 0);
 
 # Example reply to:
 #$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
@@ -51,6 +51,7 @@ my $rc = GetOptions("from=s" => \$from,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
 		    "compose" => \$compose,
+		    "quiet" => \$quiet,
 	 );
 
 # Now, let's fill any that aren't set in with defaults:
@@ -267,8 +268,10 @@ sub send_message
 
 	sendmail(%mail) or die $Mail::Sendmail::error;
 
-	print "OK. Log says:\n", $Mail::Sendmail::log;
-	print "\n\n"
+	unless ($quiet) {
+		print "OK. Log says:\n", $Mail::Sendmail::log;
+		print "\n\n"
+	}
 }
 
 
-- 
1.1.4.g3dcbd
