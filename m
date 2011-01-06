From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/3] t0001,t1510,t3301: use sane_unset which always returns with status 0
Date: Wed,  5 Jan 2011 18:30:02 -0600
Message-ID: <gmeXEearzUOUEst4-B2b8nKnIcuDy8iOxR9s9wmOFYzBZT5rwFSFsnedLx8orqTDP1ztkJap7K8@cipher.nrlssc.navy.mil>
References: <gmeXEearzUOUEst4-B2b8sVUo0XhywYUDm7rCJikom1xi9tIroh9GnJRv-bJTzbCbvqI-4DOU3A@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 06 01:45:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Padyk-0000Ch-Rb
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 01:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524Ab1AFAow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 19:44:52 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49407 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444Ab1AFAab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 19:30:31 -0500
Received: by mail.nrlssc.navy.mil id p060UPDu019978; Wed, 5 Jan 2011 18:30:25 -0600
In-Reply-To: <gmeXEearzUOUEst4-B2b8sVUo0XhywYUDm7rCJikom1xi9tIroh9GnJRv-bJTzbCbvqI-4DOU3A@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 Jan 2011 00:30:25.0636 (UTC) FILETIME=[E96F7240:01CBAD38]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164613>

From: Brandon Casey <drafnel@gmail.com>

On some shells (like /usr/xpg4/bin/sh on Solaris), unset will exit
non-zero when passed the name of a variable that has not been set.  Use
sane_unset instead so that the return value of unset can be ignored while
the && linkage of the test script can be preserved.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t0001-init.sh       |    8 +++---
 t/t1510-repo-setup.sh |   64 ++++++++++++++++++++++++------------------------
 t/t3301-notes.sh      |    2 +-
 3 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index af8b9c5..f684993 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -35,7 +35,7 @@ test_expect_success 'plain' '
 
 test_expect_success 'plain nested in bare' '
 	(
-		unset GIT_DIR GIT_WORK_TREE &&
+		sane_unset GIT_DIR GIT_WORK_TREE &&
 		git init --bare bare-ancestor.git &&
 		cd bare-ancestor.git &&
 		mkdir plain-nested &&
@@ -47,7 +47,7 @@ test_expect_success 'plain nested in bare' '
 
 test_expect_success 'plain through aliased command, outside any git repo' '
 	(
-		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG_NOGLOBAL &&
+		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG_NOGLOBAL &&
 		HOME=$(pwd)/alias-config &&
 		export HOME &&
 		mkdir alias-config &&
@@ -65,7 +65,7 @@ test_expect_success 'plain through aliased command, outside any git repo' '
 
 test_expect_failure 'plain nested through aliased command' '
 	(
-		unset GIT_DIR GIT_WORK_TREE &&
+		sane_unset GIT_DIR GIT_WORK_TREE &&
 		git init plain-ancestor-aliased &&
 		cd plain-ancestor-aliased &&
 		echo "[alias] aliasedinit = init" >>.git/config &&
@@ -78,7 +78,7 @@ test_expect_failure 'plain nested through aliased command' '
 
 test_expect_failure 'plain nested in bare through aliased command' '
 	(
-		unset GIT_DIR GIT_WORK_TREE &&
+		sane_unset GIT_DIR GIT_WORK_TREE &&
 		git init --bare bare-ancestor-aliased.git &&
 		cd bare-ancestor-aliased.git &&
 		echo "[alias] aliasedinit = init" >>config &&
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 500ffaf..c3798ce 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -80,7 +80,7 @@ test_repo() {
 #  - cwd can't be outside worktree
 
 test_expect_success '#0: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 0 0/sub &&
 	cd 0 && git init && cd ..
 '
@@ -123,7 +123,7 @@ EOF
 # GIT_WORK_TREE is ignored -> #0
 
 test_expect_success '#1: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 1 1/sub 1.wt 1.wt/sub 1/wt 1/wt/sub &&
 	cd 1 &&
 	git init &&
@@ -174,7 +174,7 @@ EOF
 #  - cwd can't be outside worktree
 
 test_expect_success '#2: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 2 2/sub &&
 	cd 2 && git init && cd ..
 '
@@ -241,7 +241,7 @@ EOF
 #  - cwd can be outside worktree
 
 test_expect_success '#3: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 3 3/sub 3/sub/sub 3.wt 3.wt/sub 3/wt 3/wt/sub &&
 	cd 3 && git init && cd ..
 '
@@ -504,7 +504,7 @@ EOF
 # core.worktree is ignored -> #0
 
 test_expect_success '#4: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 4 4/sub &&
 	cd 4 &&
 	git init &&
@@ -550,7 +550,7 @@ EOF
 # GIT_WORK_TREE/core.worktree are ignored -> #0
 
 test_expect_success '#5: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 5 5/sub &&
 	cd 5 &&
 	git init &&
@@ -602,7 +602,7 @@ EOF
 #  - cwd can be outside worktree
 
 test_expect_success '#6: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 6 6/sub 6/sub/sub 6.wt 6.wt/sub 6/wt 6/wt/sub &&
 	cd 6 && git init && cd ..
 '
@@ -889,7 +889,7 @@ EOF
 # core.worktree is overridden by GIT_WORK_TREE -> #3
 
 test_expect_success '#7: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 7 7/sub 7/sub/sub 7.wt 7.wt/sub 7/wt 7/wt/sub &&
 	cd 7 &&
 	git init &&
@@ -1155,7 +1155,7 @@ EOF
 # #0 except that git_dir is set by .git file
 
 test_expect_success '#8: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 8 8/sub &&
 	cd 8 &&
 	git init &&
@@ -1202,7 +1202,7 @@ EOF
 # #1 except that git_dir is set by .git file
 
 test_expect_success '#9: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 9 9/sub 9.wt 9.wt/sub 9/wt 9/wt/sub &&
 	cd 9 &&
 	git init &&
@@ -1251,7 +1251,7 @@ EOF
 # #2 except that git_dir is set by .git file
 
 test_expect_success '#10: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 10 10/sub &&
 	cd 10 &&
 	git init &&
@@ -1318,7 +1318,7 @@ EOF
 # #3 except that git_dir is set by .git file
 
 test_expect_success '#11: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 11 11/sub 11/sub/sub 11.wt 11.wt/sub 11/wt 11/wt/sub &&
 	cd 11 &&
 	git init &&
@@ -1586,7 +1586,7 @@ EOF
 
 
 test_expect_success '#12: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 12 12/sub 12/sub/sub 12.wt 12.wt/sub 12/wt 12/wt/sub &&
 	cd 12 &&
 	git init &&
@@ -1634,7 +1634,7 @@ EOF
 # #5 except that git_dir is set by .git file
 
 test_expect_success '#13: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 13 13/sub 13/sub/sub 13.wt 13.wt/sub 13/wt 13/wt/sub &&
 	cd 13 &&
 	git init &&
@@ -1684,7 +1684,7 @@ EOF
 # #6 except that git_dir is set by .git file
 
 test_expect_success '#14: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 14 14/sub 14/sub/sub 14.wt 14.wt/sub 14/wt 14/wt/sub &&
 	cd 14 &&
 	git init &&
@@ -1975,7 +1975,7 @@ EOF
 # #7 except that git_dir is set by .git file
 
 test_expect_success '#15: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 15 15/sub 15/sub/sub 15.wt 15.wt/sub 15/wt 15/wt/sub &&
 	cd 15 &&
 	git init &&
@@ -2247,7 +2247,7 @@ EOF
 #  - cwd can't be outside worktree
 
 test_expect_success '#16.1: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 16 16/sub &&
 	cd 16 &&
 	git init &&
@@ -2378,7 +2378,7 @@ EOF
 # GIT_WORK_TREE is ignored -> #16.1 (with warnings perhaps)
 
 test_expect_success '#17.1: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 17 17/sub &&
 	cd 17 &&
 	git init &&
@@ -2511,7 +2511,7 @@ EOF
 #  - cwd can't be outside worktree
 
 test_expect_success '#18: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 18 18/sub &&
 	cd 18 &&
 	git init &&
@@ -2578,7 +2578,7 @@ EOF
 # bare repo is overridden by GIT_WORK_TREE -> #3
 
 test_expect_success '#19: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 19 19/sub 19/sub/sub 19.wt 19.wt/sub 19/wt 19/wt/sub &&
 	cd 19 &&
 	git init &&
@@ -2844,7 +2844,7 @@ EOF
 # core.worktree is ignored -> #16.1
 
 test_expect_success '#20.1: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 20 20/sub &&
 	cd 20 &&
 	git init &&
@@ -2972,7 +2972,7 @@ EOF
 # GIT_WORK_TREE/core.worktree are ignored -> #20.1
 
 test_expect_success '#21.1: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 21 21/sub &&
 	cd 21 &&
 	git init &&
@@ -3108,7 +3108,7 @@ EOF
 #  - cwd can be outside worktree
 
 test_expect_success '#22.1: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 22 &&
 	cd 22 &&
 	git init &&
@@ -3439,7 +3439,7 @@ test_expect_success '#22.2: at root' '
 # core.worktree is overridden by GIT_WORK_TREE -> #19
 
 test_expect_success '#23: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 23 23/sub 23/sub/sub 23.wt 23.wt/sub 23/wt 23/wt/sub &&
 	cd 23 &&
 	git init &&
@@ -3706,7 +3706,7 @@ EOF
 # #16.2 except git_dir is set according to .git file
 
 test_expect_success '#24: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 24 24/sub &&
 	cd 24 &&
 	git init &&
@@ -3754,7 +3754,7 @@ EOF
 # #17.2 except git_dir is set according to .git file
 
 test_expect_success '#25: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 25 25/sub &&
 	cd 25 &&
 	git init &&
@@ -3804,7 +3804,7 @@ EOF
 # #18 except git_dir is set according to .git file
 
 test_expect_success '#26: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 26 26/sub &&
 	cd 26 &&
 	git init &&
@@ -3872,7 +3872,7 @@ EOF
 # #19 except git_dir is set according to .git file
 
 test_expect_success '#27: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 27 27/sub 27/sub/sub 27.wt 27.wt/sub 27/wt 27/wt/sub &&
 	cd 27 &&
 	git init &&
@@ -4140,7 +4140,7 @@ EOF
 # core.worktree is ignored -> #24
 
 test_expect_success '#28: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 28 28/sub &&
 	cd 28 &&
 	git init &&
@@ -4189,7 +4189,7 @@ EOF
 # GIT_WORK_TREE/core.worktree are ignored -> #28
 
 test_expect_success '#29: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 29 29/sub &&
 	cd 29 &&
 	git init &&
@@ -4239,7 +4239,7 @@ EOF
 # core.worktree and core.bare conflict, won't fly.
 
 test_expect_success '#30: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 30 &&
 	cd 30 &&
 	git init &&
@@ -4278,7 +4278,7 @@ test_expect_success '#30: at root' '
 # #23 except git_dir is set according to .git file
 
 test_expect_success '#31: setup' '
-	unset GIT_DIR GIT_WORK_TREE &&
+	sane_unset GIT_DIR GIT_WORK_TREE &&
 	mkdir 31 31/sub 31/sub/sub 31.wt 31.wt/sub 31/wt 31/wt/sub &&
 	cd 31 &&
 	git init &&
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index dc2e04a..1921ca3 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1067,7 +1067,7 @@ test_expect_success 'git notes copy diagnoses too many or too few parameters' '
 
 test_expect_success 'git notes get-ref (no overrides)' '
 	git config --unset core.notesRef &&
-	unset GIT_NOTES_REF &&
+	sane_unset GIT_NOTES_REF &&
 	test "$(git notes get-ref)" = "refs/notes/commits"
 '
 
-- 
1.7.3.1
