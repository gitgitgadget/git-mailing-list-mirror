From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-pull.sh: better warning message for "git pull" on detached head.
Date: Wed,  8 Apr 2009 09:24:03 +0200
Message-ID: <1239175443-7693-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vk55wvutb.fsf@gitster.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 09:29:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrSE0-0003Dy-Mg
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 09:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762304AbZDHH0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 03:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762249AbZDHH0h
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 03:26:37 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:46589 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758083AbZDHH0d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 03:26:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n387OGLF018408;
	Wed, 8 Apr 2009 09:24:16 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LrS8t-0001fa-U3; Wed, 08 Apr 2009 09:24:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LrS8t-00020g-RL; Wed, 08 Apr 2009 09:24:15 +0200
X-Mailer: git-send-email 1.6.2.2.449.g92961.dirty
In-Reply-To: <7vk55wvutb.fsf@gitster.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 08 Apr 2009 09:24:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116056>

Otherwise, git complains about not finding a branch to pull from in
'branch..merge', which is hardly understandable. While we're there,
reword the sentences slightly.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-pull.sh |   42 +++++++++++++++++++++++++-----------------
 1 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 8a26763..8c75027 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -90,23 +90,31 @@ error_on_no_merge_candidates () {
 
 	curr_branch=${curr_branch#refs/heads/}
 
-	echo "You asked me to pull without telling me which branch you"
-	echo "want to merge with, and 'branch.${curr_branch}.merge' in"
-	echo "your configuration file does not tell me either.  Please"
-	echo "name which branch you want to merge on the command line and"
-	echo "try again (e.g. 'git pull <repository> <refspec>')."
-	echo "See git-pull(1) for details on the refspec."
-	echo
-	echo "If you often merge with the same branch, you may want to"
-	echo "configure the following variables in your configuration"
-	echo "file:"
-	echo
-	echo "    branch.${curr_branch}.remote = <nickname>"
-	echo "    branch.${curr_branch}.merge = <remote-ref>"
-	echo "    remote.<nickname>.url = <url>"
-	echo "    remote.<nickname>.fetch = <refspec>"
-	echo
-	echo "See git-config(1) for details."
+	if [ -z "$curr_branch" ]; then
+		echo "You are not currently on a branch, so I cannot use any"
+		echo "'branch.<branchname>.merge' in your configuration file."
+		echo "Please specify which branch you want to merge on the command"
+		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
+		echo "See git-pull(1) for details."
+	else
+		echo "You asked me to pull without telling me which branch you"
+		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
+		echo "your configuration file does not tell me either.	Please"
+		echo "specify which branch you want to merge on the command line and"
+		echo "try again (e.g. 'git pull <repository> <refspec>')."
+		echo "See git-pull(1) for details."
+		echo
+		echo "If you often merge with the same branch, you may want to"
+		echo "configure the following variables in your configuration"
+		echo "file:"
+		echo
+		echo "    branch.${curr_branch}.remote = <nickname>"
+		echo "    branch.${curr_branch}.merge = <remote-ref>"
+		echo "    remote.<nickname>.url = <url>"
+		echo "    remote.<nickname>.fetch = <refspec>"
+		echo
+		echo "See git-config(1) for details."
+	fi
 	exit 1
 }
 
-- 
1.6.2.2.449.g92961.dirty
