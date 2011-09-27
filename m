From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3] git-remote-mediawiki: obey advice.pushNonFastForward
Date: Tue, 27 Sep 2011 19:55:00 +0200
Message-ID: <1317146100-22938-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1317146100-22938-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 27 19:55:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8bsP-00057c-8Q
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 19:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab1I0RzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 13:55:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55088 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab1I0RzN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 13:55:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8RHqwKM003354
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Sep 2011 19:52:58 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1R8bs4-0008VA-CF; Tue, 27 Sep 2011 19:55:08 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1R8bs4-0005yk-B6; Tue, 27 Sep 2011 19:55:08 +0200
X-Mailer: git-send-email 1.7.7.rc0.75.g56f27
In-Reply-To: <1317146100-22938-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 27 Sep 2011 19:52:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8RHqwKM003354
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1317750781.10634@dVMaSScx/TqLoLty/SB2Ug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182259>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 9bb58ab..b809792 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -603,13 +603,16 @@ sub mw_import_ref {
 }
 
 sub error_non_fast_forward {
-	# Native git-push would show this after the summary.
-	# We can't ask it to display it cleanly, so print it
-	# ourselves before.
-	print STDERR "To prevent you from losing history, non-fast-forward updates were rejected\n";
-	print STDERR "Merge the remote changes (e.g. 'git pull') before pushing again. See the\n";
-	print STDERR "'Note about fast-forwards' section of 'git push --help' for details.\n";
-
+	my $advice = run_git("config --bool advice.pushNonFastForward");
+	chomp($advice);
+	if ($advice ne "false") {
+		# Native git-push would show this after the summary.
+		# We can't ask it to display it cleanly, so print it
+		# ourselves before.
+		print STDERR "To prevent you from losing history, non-fast-forward updates were rejected\n";
+		print STDERR "Merge the remote changes (e.g. 'git pull') before pushing again. See the\n";
+		print STDERR "'Note about fast-forwards' section of 'git push --help' for details.\n";
+	}
 	print STDOUT "error $_[0] \"non-fast-forward\"\n";
 	return 0;
 }
-- 
1.7.7.rc0.75.g56f27
