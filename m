From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: [PATCH] send-email: Ask for in-reply message ID even if from and to is already known
Date: Tue,  1 Jun 2010 20:08:50 +0200
Message-ID: <1275415730-15360-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
References: <vpqtypmn4bm.fsf@bauges.imag.fr>
Cc: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 20:09:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJVu1-0004zO-S1
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 20:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab0FASJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 14:09:14 -0400
Received: from jack.hrz.tu-chemnitz.de ([134.109.132.46]:48856 "EHLO
	jack.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab0FASJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 14:09:13 -0400
Received: from 77-64-189-43.dynamic.primacom.net ([77.64.189.43] helo=localhost.localdomain)
	by jack.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alexander.stein@informatik.tu-chemnitz.de>)
	id 1OJVtn-0002i4-Gf; Tue, 01 Jun 2010 20:09:12 +0200
X-Mailer: git-send-email 1.6.4.4
In-Reply-To: <vpqtypmn4bm.fsf@bauges.imag.fr>
X-Spam-Score: -0.9 (/)
X-Spam-Report: --- Start der SpamAssassin 3.3.0 Textanalyse (-0.9 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 TVD_RCVD_IP TVD_RCVD_IP
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 113af25641a082a643d611852bb712c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148151>

This patch removes the prompting variable so git send-email always asks
for a in-reply message ID (unless specified on command line) even when
sendemail.from and sendemail.to is set in ~/.gitconfig or .git/config

Signed-off-by: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
---
 git-send-email.perl |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 111c981..4487472 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -136,7 +136,7 @@ my $auth;
 sub unique_email_list(@);
 sub cleanup_compose_files();
 
-# Variables we fill in automatically, or via prompting:
+# Variables we fill in automatically:
 my (@to,$no_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
 	$initial_reply_to,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
@@ -669,19 +669,16 @@ sub ask {
 	return undef;
 }
 
-my $prompting = 0;
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter || '';
 	$sender = ask("Who should the emails appear to be from? [$sender] ",
 	              default => $sender);
 	print "Emails will be sent from: ", $sender, "\n";
-	$prompting++;
 }
 
 if (!@to) {
 	my $to = ask("Who should the emails be sent to? ");
 	push @to, parse_address_line($to) if defined $to; # sanitized/validated later
-	$prompting++;
 }
 
 sub expand_aliases {
@@ -703,7 +700,7 @@ sub expand_one_alias {
 @initial_cc = expand_aliases(@initial_cc);
 @bcclist = expand_aliases(@bcclist);
 
-if ($thread && !defined $initial_reply_to && $prompting) {
+if ($thread && !defined $initial_reply_to) {
 	$initial_reply_to = ask(
 		"Message-ID to be used as In-Reply-To for the first email? ");
 }
-- 
1.6.4.4
