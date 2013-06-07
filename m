From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v6 5/7] add tests for rebasing merged history
Date: Thu,  6 Jun 2013 23:11:41 -0700
Message-ID: <1370585503-11374-6-git-send-email-martinvonz@gmail.com>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
 <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 08:20:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukq1x-0000qE-Gn
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 08:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528Ab3FGGUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 02:20:01 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:51063 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab3FGGUA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 02:20:00 -0400
Received: by mail-qa0-f74.google.com with SMTP id g10so128448qah.5
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 23:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=FcdP2BOCNLQxa5x+fjSaIz4aI0oxThi+yFvqI1W8dYI=;
        b=ChYR9kTanf+kh7r2uyg/gvdFoyavVdOTdDC6qiyHFvZPEzU3PZyHkPdGr39T76p8NQ
         QFymmcshciafnzGSY8jdfb65fUEHfH1HhaLtFy1MjkcRT5Qb/Q3Gqatf9E6Ye5q57TIT
         QAZ1qTocNRah1Q/1dFPpYX9fzQOQQp47bHmjGeTxAB/MctZCE4VBhqKgzddYAiMrrRL3
         pLy6ZyCbiU+DTdrL0jk2lC6ZNyYtp6atwpbwhu3YG3djON4HMJz0smREqmFQSS7T2J7M
         cScerKD6wQbmjWmiBnXioEs0Z+5o2aUBLU6Ti2Bp+nH7Ni9+lRE5Y1u4dPJ+HUPjnfeL
         NXPQ==
X-Received: by 10.236.150.103 with SMTP id y67mr14275584yhj.21.1370585510498;
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o42si7050435yhe.5.2013.06.06.23.11.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 49EB731C1BD;
	Thu,  6 Jun 2013 23:11:50 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id EBB771008F4; Thu,  6 Jun 2013 23:11:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlhyo6a+8ZzhVSw2Wl0N8ojFgmQjkxIt3s3hfMjFSpZYO7xXsPamGbqeoY06NTWtFgvN8LZrBqPiMuEPPxuevUD2v9VNCO4jaCRZ7B3WUKArPRv2NCZfXzUiVI26nSX1LWG4GD4OXznlmqNTK2p/62tKR7S2rqVK0h2kQH5EMjwinZQJVrX89EUjCyPATfAAjwlSTBj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226606>

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 t/t3400-rebase.sh                 |  31 +----
 t/t3401-rebase-partial.sh         |  45 -------
 t/t3404-rebase-interactive.sh     |  10 +-
 t/t3409-rebase-preserve-merges.sh |  53 --------
 t/t3425-rebase-topology-merges.sh | 258 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 260 insertions(+), 137 deletions(-)
 delete mode 100755 t/t3401-rebase-partial.sh
 create mode 100755 t/t3425-rebase-topology-merges.sh

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b58fa1a..b436ef4 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -40,13 +40,6 @@ test_expect_success 'prepare repository with topic branches' '
 	echo Side >>C &&
 	git add C &&
 	git commit -m "Add C" &&
-	git checkout -b nonlinear my-topic-branch &&
-	echo Edit >>B &&
-	git add B &&
-	git commit -m "Modify B" &&
-	git merge side &&
-	git checkout -b upstream-merged-nonlinear &&
-	git merge master &&
 	git checkout -f my-topic-branch &&
 	git tag topic
 '
@@ -106,31 +99,9 @@ test_expect_success 'rebase from ambiguous branch name' '
 	git rebase master
 '
 
-test_expect_success 'rebase after merge master' '
-	git checkout --detach refs/tags/topic &&
-	git branch -D topic &&
-	git reset --hard topic &&
-	git merge master &&
-	git rebase master &&
-	! (git show | grep "^Merge:")
-'
-
-test_expect_success 'rebase of history with merges is linearized' '
-	git checkout nonlinear &&
-	test 4 = $(git rev-list master.. | wc -l) &&
-	git rebase master &&
-	test 3 = $(git rev-list master.. | wc -l)
-'
-
-test_expect_success 'rebase of history with merges after upstream merge is linearized' '
-	git checkout upstream-merged-nonlinear &&
-	test 5 = $(git rev-list master.. | wc -l) &&
-	git rebase master &&
-	test 3 = $(git rev-list master.. | wc -l)
-'
-
 test_expect_success 'rebase a single mode change' '
 	git checkout master &&
+	git branch -D topic &&
 	echo 1 >X &&
 	git add X &&
 	test_tick &&
diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
deleted file mode 100755
index 7ba1797..0000000
--- a/t/t3401-rebase-partial.sh
+++ /dev/null
@@ -1,45 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2006 Yann Dirson, based on t3400 by Amos Waterland
-#
-
-test_description='git rebase should detect patches integrated upstream
-
-This test cherry-picks one local change of two into master branch, and
-checks that git rebase succeeds with only the second patch in the
-local branch.
-'
-. ./test-lib.sh
-
-test_expect_success 'prepare repository with topic branch' '
-	test_commit A &&
-	git checkout -b my-topic-branch &&
-	test_commit B &&
-	test_commit C &&
-	git checkout -f master &&
-	test_commit A2 A.t
-'
-
-test_expect_success 'pick top patch from topic branch into master' '
-	git cherry-pick C &&
-	git checkout -f my-topic-branch
-'
-
-test_debug '
-	git cherry master &&
-	git format-patch -k --stdout --full-index master >/dev/null &&
-	gitk --all & sleep 1
-'
-
-test_expect_success 'rebase topic branch against new master and check git am did not get halted' '
-	git rebase master &&
-	test_path_is_missing .git/rebase-apply
-'
-
-test_expect_success 'rebase --merge topic branch that was partially merged upstream' '
-	git reset --hard C &&
-	git rebase --merge master &&
-	test_path_is_missing .git/rebase-merge
-'
-
-test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index a58406d..ffcaf02 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -477,19 +477,11 @@ test_expect_success 'interrupted squash works as expected (case 2)' '
 	test $one = $(git rev-parse HEAD~2)
 '
 
-test_expect_success 'ignore patch if in upstream' '
-	HEAD=$(git rev-parse HEAD) &&
-	git checkout -b has-cherry-picked HEAD^ &&
+test_expect_success '--continue tries to commit, even for "edit"' '
 	echo unrelated > file7 &&
 	git add file7 &&
 	test_tick &&
 	git commit -m "unrelated change" &&
-	git cherry-pick $HEAD &&
-	EXPECT_COUNT=1 git rebase -i $HEAD &&
-	test $HEAD = $(git rev-parse HEAD^)
-'
-
-test_expect_success '--continue tries to commit, even for "edit"' '
 	parent=$(git rev-parse HEAD^) &&
 	test_tick &&
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 6de4e22..2e0c364 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -11,14 +11,6 @@ Run "git rebase -p" and check that merges are properly carried along
 GIT_AUTHOR_EMAIL=bogus_email_address
 export GIT_AUTHOR_EMAIL
 
-# Clone 1 (trivial merge):
-#
-# A1--A2  <-- origin/master
-#  \   \
-#   B1--M  <-- topic
-#    \
-#     B2  <-- origin/topic
-#
 # Clone 2 (conflicting merge):
 #
 # A1--A2--B3   <-- origin/master
@@ -36,16 +28,6 @@ export GIT_AUTHOR_EMAIL
 #     \--A3    <-- topic2
 #      \
 #       B2     <-- origin/topic
-#
-# Clone 4 (merge using second parent as base):
-#
-# A1--A2--B3   <-- origin/master
-#  \
-#   B1--A3--M  <-- topic
-#    \     /
-#     \--A4    <-- topic2
-#      \
-#       B2     <-- origin/topic
 
 test_expect_success 'setup for merge-preserving rebase' \
 	'echo First > A &&
@@ -58,20 +40,6 @@ test_expect_success 'setup for merge-preserving rebase' \
 	git checkout -f master &&
 	echo Third >> A &&
 	git commit -a -m "Modify A2" &&
-
-	git clone ./. clone1 &&
-	(cd clone1 &&
-	git checkout -b topic origin/topic &&
-	git merge origin/master
-	) &&
-
-	git clone ./. clone4 &&
-	(
-		cd clone4 &&
-		git checkout -b topic origin/topic &&
-		git merge origin/master
-	) &&
-
 	echo Fifth > B &&
 	git add B &&
 	git commit -m "Add different B" &&
@@ -101,16 +69,6 @@ test_expect_success 'setup for merge-preserving rebase' \
 	git commit -a -m "Modify B2"
 '
 
-test_expect_success 'rebase -p fakes interactive rebase' '
-	(
-	cd clone1 &&
-	git fetch &&
-	git rebase -p origin/topic &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge remote-tracking branch " | wc -l)
-	)
-'
-
 test_expect_success '--continue works after a conflict' '
 	(
 	cd clone2 &&
@@ -138,15 +96,4 @@ test_expect_success 'rebase -p preserves no-ff merges' '
 	)
 '
 
-test_expect_success 'rebase -p works when base inside second parent' '
-	(
-	cd clone4 &&
-	git fetch &&
-	git rebase -p HEAD^2 &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify B" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge remote-tracking branch " | wc -l)
-	)
-'
-
 test_done
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
new file mode 100755
index 0000000..5400a05
--- /dev/null
+++ b/t/t3425-rebase-topology-merges.sh
@@ -0,0 +1,258 @@
+#!/bin/sh
+
+test_description='rebase topology tests with merges'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_revision_subjects () {
+	expected="$1"
+	shift
+	set -- $(git log --format=%s --no-walk=unsorted "$@")
+	test "$expected" = "$*"
+}
+
+# a---b-----------c
+#      \           \
+#       d-------e   \
+#        \       \   \
+#         n---o---w---v
+#              \
+#               z
+test_expect_success 'setup of non-linear-history' '
+	test_commit a &&
+	test_commit b &&
+	test_commit c &&
+	git checkout b &&
+	test_commit d &&
+	test_commit e
+
+	git checkout c &&
+	test_commit g &&
+	revert h g &&
+	git checkout d &&
+	cherry_pick G g &&
+	test_commit i &&
+	git checkout b &&
+	test_commit f
+
+	git checkout d &&
+	test_commit n &&
+	test_commit o &&
+	test_merge w e &&
+	test_merge v c &&
+	git checkout o &&
+	test_commit z
+'
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* after merge from upstream" "
+		reset_rebase &&
+		git rebase $* e w &&
+		test_cmp_rev e HEAD~2 &&
+		test_linear_range 'n o' e..
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+
+test_run_rebase () {
+	result=$1
+	shift
+	expected=$1
+	shift
+	test_expect_$result "rebase $* of non-linear history is linearized in place" "
+		reset_rebase &&
+		git rebase $* d w &&
+		test_cmp_rev d HEAD~3 &&
+		test_linear_range "\'"$expected"\'" d..
+	"
+}
+#TODO: make order consistent across all flavors of rebase
+test_run_rebase success 'e n o' ''
+test_run_rebase success 'e n o' -m
+test_run_rebase success 'n o e' -i
+
+test_run_rebase () {
+	result=$1
+	shift
+	expected=$1
+	shift
+	test_expect_$result "rebase $* of non-linear history is linearized upstream" "
+		reset_rebase &&
+		git rebase $* c w &&
+		test_cmp_rev c HEAD~4 &&
+		test_linear_range "\'"$expected"\'" c..
+	"
+}
+#TODO: make order consistent across all flavors of rebase
+test_run_rebase success 'd e n o' ''
+test_run_rebase success 'd e n o' -m
+test_run_rebase success 'd n o e' -i
+
+test_run_rebase () {
+	result=$1
+	shift
+	expected=$1
+	shift
+	test_expect_$result "rebase $* of non-linear history with merges after upstream merge is linearized" "
+		reset_rebase &&
+		git rebase $* c v &&
+		test_cmp_rev c HEAD~4 &&
+		test_linear_range "\'"$expected"\'" c..
+	"
+}
+#TODO: make order consistent across all flavors of rebase
+test_run_rebase success 'd e n o' ''
+test_run_rebase success 'd e n o' -m
+test_run_rebase success 'd n o e' -i
+
+test_expect_success "rebase -p is no-op in non-linear history" "
+	reset_rebase &&
+	git rebase -p d w &&
+	test_cmp_rev w HEAD
+"
+
+test_expect_success "rebase -p is no-op when base inside second parent" "
+	reset_rebase &&
+	git rebase -p e w &&
+	test_cmp_rev w HEAD
+"
+
+test_expect_failure "rebase -p --root on non-linear history is a no-op" "
+	reset_rebase &&
+	git rebase -p --root w &&
+	test_cmp_rev w HEAD
+"
+
+test_expect_success "rebase -p re-creates merge from side branch" "
+	reset_rebase &&
+	git rebase -p z w &&
+	test_cmp_rev z HEAD^ &&
+	test_cmp_rev w^2 HEAD^2
+"
+
+test_expect_success "rebase -p re-creates internal merge" "
+	reset_rebase &&
+	git rebase -p c w &&
+	test_cmp_rev c HEAD~4 &&
+	test_cmp_rev HEAD^2^ HEAD~3 &&
+	test_revision_subjects 'd n e o w' HEAD~3 HEAD~2 HEAD^2 HEAD^ HEAD
+"
+
+test_expect_success "rebase -p can re-create two branches on onto" "
+	reset_rebase &&
+	git rebase -p --onto c d w &&
+	test_cmp_rev c HEAD~3 &&
+	test_cmp_rev c HEAD^2^ &&
+	test_revision_subjects 'n e o w' HEAD~2 HEAD^2 HEAD^ HEAD
+"
+
+#       f
+#      /
+# a---b---c---g---h
+#      \
+#       d---G---i
+#        \       \
+#         e-------u
+#
+# uppercase = cherry-picked
+# h = reverted g
+test_expect_success 'setup of non-linear-history for patch-equivalence tests' '
+	git checkout e &&
+	test_merge u i
+'
+
+test_expect_success "rebase -p re-creates history around dropped commit matching upstream" "
+	reset_rebase &&
+	git rebase -p h u &&
+	test_cmp_rev h HEAD~3 &&
+	test_cmp_rev HEAD^2^ HEAD~2 &&
+	test_revision_subjects 'd i e u' HEAD~2 HEAD^2 HEAD^ HEAD
+"
+
+test_expect_success "rebase -p --onto in merged history drops patches in upstream" "
+	reset_rebase &&
+	git rebase -p --onto f h u &&
+	test_cmp_rev f HEAD~3 &&
+	test_cmp_rev HEAD^2^ HEAD~2 &&
+	test_revision_subjects 'd i e u' HEAD~2 HEAD^2 HEAD^ HEAD
+"
+
+test_expect_success "rebase -p --onto in merged history does not drop patches in onto" "
+	reset_rebase &&
+	git rebase -p --onto h f u &&
+	test_cmp_rev h HEAD~3 &&
+	test_cmp_rev HEAD^2~2 HEAD~2 &&
+	test_revision_subjects 'd G i e u' HEAD~2 HEAD^2^ HEAD^2 HEAD^ HEAD
+"
+
+# a---b---c---g---h
+#      \
+#       d---G---s
+#        \   \ /
+#         \   X
+#          \ / \
+#           e---t
+#
+# uppercase = cherry-picked
+# h = reverted g
+test_expect_success 'setup of non-linear-history for dropping whole side' '
+	git checkout G &&
+	test_merge s e &&
+	git checkout e &&
+	test_merge t G
+'
+
+test_expect_failure "rebase -p drops merge commit when entire first-parent side is dropped" "
+	reset_rebase &&
+	git rebase -p h s &&
+	test_cmp_rev h HEAD~2 &&
+	test_linear_range 'd e' h..
+"
+
+test_expect_success "rebase -p drops merge commit when entire second-parent side is dropped" "
+	reset_rebase &&
+	git rebase -p h t &&
+	test_cmp_rev h HEAD~2 &&
+	test_linear_range 'd e' h..
+"
+
+# a---b---c
+#      \
+#       d---e
+#        \   \
+#         n---r
+#          \
+#           o
+#
+# r = tree-same with n
+test_expect_success 'setup of non-linear-history for empty commits' '
+	git checkout n &&
+	git merge --no-commit e &&
+	git reset n . &&
+	git commit -m r &&
+	git reset --hard &&
+	git clean -f &&
+	git tag r
+'
+
+test_expect_success "rebase -p re-creates empty internal merge commit" "
+	reset_rebase &&
+	git rebase -p c r &&
+	test_cmp_rev c HEAD~3 &&
+	test_cmp_rev HEAD^2^ HEAD~2 &&
+	test_revision_subjects 'd e n r' HEAD~2 HEAD^2 HEAD^ HEAD
+"
+
+test_expect_success "rebase -p re-creates empty merge commit" "
+	reset_rebase &&
+	git rebase -p o r &&
+	test_cmp_rev e HEAD^2 &&
+	test_cmp_rev o HEAD^ &&
+	test_revision_subjects 'r' HEAD
+"
+
+test_done
-- 
1.8.3.497.g83fddbe
