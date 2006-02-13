From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 2/2] send-email: Add --cc
Date: Mon, 13 Feb 2006 03:22:04 -0500
Message-ID: <1139818924460-git-send-email-ryan@michonline.com>
References: <11398189241095-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 09:22:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Yyw-0002Dc-CE
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 09:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWBMIWr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 03:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWBMIWr
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 03:22:47 -0500
Received: from mail.autoweb.net ([198.172.237.26]:40897 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751345AbWBMIWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 03:22:46 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F8Yyq-0001k5-2D; Mon, 13 Feb 2006 03:22:45 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F8Yyl-000284-Mq; Mon, 13 Feb 2006 03:22:41 -0500
Received: from localhost
	([127.0.0.1] helo=mythryan2 ident=ryan)
	by mythical with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F8YyC-0002pL-HO; Mon, 13 Feb 2006 03:22:04 -0500
In-Reply-To: <11398189241095-git-send-email-ryan@michonline.com>
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Spam-Score: -2.5
X-Spam-Report: Spam detection software, running on the system "h4x0r5.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Since Junio used this in an example, and I've personally
	tried to use it, I suppose the option should actually exist.
	Signed-off-by: Ryan Anderson <ryan@michonline.com> --- [...] 
	Content analysis details:   (-2.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.4 X_MAILER_SPAM          X-Mailer: header is bulk email fingerprint
	-0.0 SPF_PASS               SPF: sender matches SPF record
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	-1.3 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16051>

Since Junio used this in an example, and I've personally tried to use it, I
suppose the option should actually exist.

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

 Documentation/git-send-email.txt |    3 +++
 git-send-email.perl              |    8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

6d18725b9d46259162cfe54c9e0e369558394816
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index c2f52f5..8c58685 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -24,6 +24,9 @@ OPTIONS
 -------
 The options available are:
 
+--cc::
+	Specify a starting "Cc:" value for each email.
+
 --chain-reply-to, --no-chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
diff --git a/git-send-email.perl b/git-send-email.perl
index abffca5..13b85dd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -31,7 +31,7 @@ sub cleanup_compose_files();
 my $compose_filename = ".msg.$$";
 
 # Variables we fill in automatically, or via prompting:
-my (@to,@cc,$initial_reply_to,$initial_subject,@files,$from,$compose);
+my (@to,@cc,@initial_cc,$initial_reply_to,$initial_subject,@files,$from,$compose);
 
 # Behavior modification variables
 my ($chain_reply_to, $smtp_server, $quiet, $suppress_from, $no_signed_off_cc) = (1, "localhost", 0, 0, 0);
@@ -48,6 +48,7 @@ my $rc = GetOptions("from=s" => \$from,
                     "in-reply-to=s" => \$initial_reply_to,
 		    "subject=s" => \$initial_subject,
 		    "to=s" => \@to,
+		    "cc=s" => \@initial_cc,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
 		    "compose" => \$compose,
@@ -199,6 +200,9 @@ Options:
 
    --to           Specify the primary "To:" line of the email.
 
+   --cc           Specify an initial "Cc:" list for the entire series
+                  of emails.
+
    --compose      Use \$EDITOR to edit an introductory message for the
                   patch series.
 
@@ -298,7 +302,7 @@ $subject = $initial_subject;
 foreach my $t (@files) {
 	open(F,"<",$t) or die "can't open file $t";
 
-	@cc = ();
+	@cc = @initial_cc;
 	my $found_mbox = 0;
 	my $header_done = 0;
 	$message = "";
-- 
1.2.0.g6d18
