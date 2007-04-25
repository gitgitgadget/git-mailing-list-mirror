From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Convert t6022 to use git-merge instead of git-pull
Date: Wed, 25 Apr 2007 22:07:18 +0200
Message-ID: <20070425200718.GB30061@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 22:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgnm3-0001dz-V9
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 22:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993042AbXDYUHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 16:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993045AbXDYUHW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 16:07:22 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:12311 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993042AbXDYUHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 16:07:20 -0400
Received: from tigra.home (Fac4b.f.strato-dslnet.de [195.4.172.75])
	by post.webmailer.de (klopstock mo63) (RZmta 5.6)
	with ESMTP id F07523j3PGWWUR ; Wed, 25 Apr 2007 22:07:18 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D1D8A277BD;
	Wed, 25 Apr 2007 22:07:18 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id CB5A5BDDE; Wed, 25 Apr 2007 22:07:18 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFqtlg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45559>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t6022-merge-rename.sh |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index b608e20..99817de 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -79,10 +79,10 @@ git commit -m "blue renames A->C, M->N" &&
 
 git checkout master'
 
-test_expect_success 'pull renaming branch into unrenaming one' \
+test_expect_success 'merge renaming branch into unrenaming one' \
 '
 	git show-branch
-	git pull . white && {
+	git merge white && {
 		echo "BAD: should have conflicted"
 		return 1
 	}
@@ -108,12 +108,12 @@ test_expect_success 'pull renaming branch into unrenaming one' \
 	}
 '
 
-test_expect_success 'pull renaming branch into another renaming one' \
+test_expect_success 'merge renaming branch into another renaming one' \
 '
 	rm -f B
 	git reset --hard
 	git checkout red
-	git pull . white && {
+	git merge white && {
 		echo "BAD: should have conflicted"
 		return 1
 	}
@@ -138,11 +138,11 @@ test_expect_success 'pull renaming branch into another renaming one' \
 	}
 '
 
-test_expect_success 'pull unrenaming branch into renaming one' \
+test_expect_success 'merge unrenaming branch into renaming one' \
 '
 	git reset --hard
 	git show-branch
-	git pull . master && {
+	git merge master && {
 		echo "BAD: should have conflicted"
 		return 1
 	}
@@ -167,11 +167,11 @@ test_expect_success 'pull unrenaming branch into renaming one' \
 	}
 '
 
-test_expect_success 'pull conflicting renames' \
+test_expect_success 'merge conflicting renames' \
 '
 	git reset --hard
 	git show-branch
-	git pull . blue && {
+	git merge blue && {
 		echo "BAD: should have conflicted"
 		return 1
 	}
@@ -209,7 +209,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git reset --hard
 	git show-branch
 	echo >A this file should not matter
-	git pull . white && {
+	git merge white && {
 		echo "BAD: should have conflicted"
 		return 1
 	}
@@ -226,7 +226,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git show-branch
 	rm -f A
 	echo >A this file should not matter
-	git pull . red && {
+	git merge red && {
 		echo "BAD: should have conflicted"
 		return 1
 	}
@@ -243,7 +243,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git checkout -f master
 	git tag -f anchor
 	git show-branch
-	git pull . yellow || {
+	git merge yellow || {
 		echo "BAD: should have cleanly merged"
 		return 1
 	}
@@ -263,7 +263,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 	git show-branch
 	echo >>M one line addition
 	cat M >M.saved
-	git pull . yellow && {
+	git merge yellow && {
 		echo "BAD: should have complained"
 		return 1
 	}
@@ -284,7 +284,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 	echo >>M one line addition
 	cat M >M.saved
 	git update-index M
-	git pull . yellow && {
+	git merge yellow && {
 		echo "BAD: should have complained"
 		return 1
 	}
@@ -303,7 +303,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git tag -f anchor
 	git show-branch
 	echo >M this file should not matter
-	git pull . master || {
+	git merge master || {
 		echo "BAD: should have cleanly merged"
 		return 1
 	}
-- 
1.5.2.rc0.63.gdfc8-dirty
