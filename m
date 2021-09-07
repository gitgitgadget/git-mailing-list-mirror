Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F988C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4656F61090
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbhIGVG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346281AbhIGVGY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:06:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC1DC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:05:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t18so86935wrb.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NdlUb2pGXVPj+oM8eDUCm9FcOvmNjzQ2CV0p90DIGPY=;
        b=KXUtNBfp5bvxm+lD+wtuOIE2xm7I35djEC1DyWnC3yyAcAHmv2Z9wewvx0wmfyyFKt
         02RnlhZ3vDFf14QaCNvxZ0zYsAmB9SEYnSD5soMPLrTiv9oEBt+17SMgZk8T89Z/ZFkM
         t6O2w8yxzwrBK1UzoN7Ngh3CALvENoWm9044Xaof95uBGY0mlJ7aJu2zz/violVr3Dru
         VTHjKy8g2yU/96kZ+VW95ngGxR6Ae0tYYQMy3IyQR7LNjdCfGZ4uHrTqM4mD7fsMqg4c
         OHJvBHg5jkSee4SFI7DFeb7RimvMoxLZCFaEuDCKu55L6p3sCrCCob9CG2IQPZ1sjMGv
         JvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NdlUb2pGXVPj+oM8eDUCm9FcOvmNjzQ2CV0p90DIGPY=;
        b=dfCe+lCCLXc2YcTNVT3vJl95N+8EL/dU4H/CZVRB2zUuhgZCnkD3/tBJ8owbEcMzS1
         bJUvP7ec+Z2m+9Z1o7Ec/rS3XbQez62iJ3Kybp0KHW7oOCQ9mNdbgvtDgh6OtD9ITT2e
         VOCWWEwWVGToJhut/XtgUkC+nX4JB1Dc/vIRgWSjM8cfHb27OXg8Obv1yoOrG8G3Lh9R
         QFJhUZ2UWgp/P/sM4WIp5Evv38TG47+9TM6LvV5l8l33mqpMZS+KSCzPOdbDxME3HtUV
         a1YwK0ppWH38xUTfzissfAR/U7i/2O/HGTuv4ADmHm40M9fYXYQ8dfLDdMtvAPmuP1Dg
         gKMg==
X-Gm-Message-State: AOAM533zf9Bs5yMrxKIuogS4bctbvf8hPPqAkDLqlUbctoSuMNurgZJz
        xZUK5+BGy0XWl1wRdcvKxgylY+9qM68=
X-Google-Smtp-Source: ABdhPJzwXp1WZTlD8K3SL4lxKpDLQr3DNNfubyX8QJSYZhBGGthSwLxDxq56HgzOvBxFZbwOsrM/xA==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr344345wrn.294.1631048716219;
        Tue, 07 Sep 2021 14:05:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm120779wma.16.2021.09.07.14.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:05:15 -0700 (PDT)
Message-Id: <e4b683f0cd6300cdda78075a03665db369c9a0aa.1631048713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 21:05:04 +0000
Subject: [PATCH v3 03/11] tests: stop testing `git rebase --preserve-merges`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This backend has been deprecated in favor of `git rebase
--rebase-merges`.

In preparation for dropping it, let's remove all the regression tests
that would need it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml                |   1 -
 t/t3404-rebase-interactive.sh             |  76 -----------
 t/t3408-rebase-multi-line.sh              |  10 --
 t/t3409-rebase-preserve-merges.sh         | 130 -------------------
 t/t3410-rebase-preserve-dropped-merges.sh |  90 -------------
 t/t3411-rebase-preserve-around-merges.sh  |  80 ------------
 t/t3412-rebase-root.sh                    |  37 ------
 t/t3414-rebase-preserve-onto.sh           |  85 ------------
 t/t3418-rebase-continue.sh                |  15 ---
 t/t3421-rebase-topology-linear.sh         |  19 ---
 t/t3422-rebase-incompatible-options.sh    |  11 --
 t/t3425-rebase-topology-merges.sh         | 151 ----------------------
 t/t3427-rebase-subtree.sh                 |  26 +---
 t/t5520-pull.sh                           |  18 ---
 t/t7505-prepare-commit-msg-hook.sh        |   1 -
 t/t7517-per-repo-email.sh                 |  13 --
 t/test-lib.sh                             |   4 -
 17 files changed, 3 insertions(+), 764 deletions(-)
 delete mode 100755 t/t3409-rebase-preserve-merges.sh
 delete mode 100755 t/t3410-rebase-preserve-dropped-merges.sh
 delete mode 100755 t/t3411-rebase-preserve-around-merges.sh
 delete mode 100755 t/t3414-rebase-preserve-onto.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 47876a4f02e..6115755c4df 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -198,7 +198,6 @@ jobs:
       shell: bash
       env:
         NO_SVN_TESTS: 1
-        GIT_TEST_SKIP_REBASE_P: 1
       run: ci/run-test-slice.sh ${{matrix.nr}} 10
     - name: ci/print-test-failures.sh
       if: failure()
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 66bcbbf9528..827b0450b9f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -351,82 +351,6 @@ test_expect_success 'retain authorship when squashing' '
 	git show HEAD | grep "^Author: Twerp Snog"
 '
 
-test_expect_success REBASE_P '-p handles "no changes" gracefully' '
-	HEAD=$(git rev-parse HEAD) &&
-	git rebase -i -p HEAD^ &&
-	git update-index --refresh &&
-	git diff-files --quiet &&
-	git diff-index --quiet --cached HEAD -- &&
-	test $HEAD = $(git rev-parse HEAD)
-'
-
-test_expect_failure REBASE_P 'exchange two commits with -p' '
-	git checkout H &&
-	(
-		set_fake_editor &&
-		FAKE_LINES="2 1" git rebase -i -p HEAD~2
-	) &&
-	test H = $(git cat-file commit HEAD^ | sed -ne \$p) &&
-	test G = $(git cat-file commit HEAD | sed -ne \$p)
-'
-
-test_expect_success REBASE_P 'preserve merges with -p' '
-	git checkout -b to-be-preserved primary^ &&
-	: > unrelated-file &&
-	git add unrelated-file &&
-	test_tick &&
-	git commit -m "unrelated" &&
-	git checkout -b another-branch primary &&
-	echo B > file1 &&
-	test_tick &&
-	git commit -m J file1 &&
-	test_tick &&
-	git merge to-be-preserved &&
-	echo C > file1 &&
-	test_tick &&
-	git commit -m K file1 &&
-	echo D > file1 &&
-	test_tick &&
-	git commit -m L1 file1 &&
-	git checkout HEAD^ &&
-	echo 1 > unrelated-file &&
-	test_tick &&
-	git commit -m L2 unrelated-file &&
-	test_tick &&
-	git merge another-branch &&
-	echo E > file1 &&
-	test_tick &&
-	git commit -m M file1 &&
-	git checkout -b to-be-rebased &&
-	test_tick &&
-	git rebase -i -p --onto branch1 primary &&
-	git update-index --refresh &&
-	git diff-files --quiet &&
-	git diff-index --quiet --cached HEAD -- &&
-	test_cmp_rev HEAD~6 branch1 &&
-	test_cmp_rev HEAD~4^2 to-be-preserved &&
-	test_cmp_rev HEAD^^2^ HEAD^^^ &&
-	test $(git show HEAD~5:file1) = B &&
-	test $(git show HEAD~3:file1) = C &&
-	test $(git show HEAD:file1) = E &&
-	test $(git show HEAD:unrelated-file) = 1
-'
-
-test_expect_success REBASE_P 'edit ancestor with -p' '
-	(
-		set_fake_editor &&
-		FAKE_LINES="1 2 edit 3 4" git rebase -i -p HEAD~3
-	) &&
-	echo 2 > unrelated-file &&
-	test_tick &&
-	git commit -m L2-modified --amend unrelated-file &&
-	git rebase --continue &&
-	git update-index --refresh &&
-	git diff-files --quiet &&
-	git diff-index --quiet --cached HEAD -- &&
-	test $(git show HEAD:unrelated-file) = 2
-'
-
 test_expect_success '--continue tries to commit' '
 	git reset --hard D &&
 	test_tick &&
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
index ab0960e6d99..cde3562e3a6 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -55,14 +55,4 @@ test_expect_success rebase '
 	test_cmp expect actual
 
 '
-test_expect_success REBASE_P rebasep '
-
-	git checkout side-merge &&
-	git rebase -p side &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
-	git cat-file commit side-merge-original | sed -e "1,/^\$/d" >expect &&
-	test_cmp expect actual
-
-'
-
 test_done
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
deleted file mode 100755
index ec8062a66ac..00000000000
--- a/t/t3409-rebase-preserve-merges.sh
+++ /dev/null
@@ -1,130 +0,0 @@
-#!/bin/sh
-#
-# Copyright(C) 2008 Stephen Habermann & Andreas Ericsson
-#
-test_description='git rebase -p should preserve merges
-
-Run "git rebase -p" and check that merges are properly carried along
-'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
-export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-
-. ./test-lib.sh
-
-if ! test_have_prereq REBASE_P; then
-	skip_all='skipping git rebase -p tests, as asked for'
-	test_done
-fi
-
-GIT_AUTHOR_EMAIL=bogus_email_address
-export GIT_AUTHOR_EMAIL
-
-# Clone 2 (conflicting merge):
-#
-# A1--A2--B3   <-- origin/main
-#  \       \
-#   B1------M  <-- topic
-#    \
-#     B2       <-- origin/topic
-#
-# Clone 3 (no-ff merge):
-#
-# A1--A2--B3   <-- origin/main
-#  \
-#   B1------M  <-- topic
-#    \     /
-#     \--A3    <-- topic2
-#      \
-#       B2     <-- origin/topic
-#
-# Clone 4 (same as Clone 3)
-
-test_expect_success 'setup for merge-preserving rebase' \
-	'echo First > A &&
-	git add A &&
-	git commit -m "Add A1" &&
-	git checkout -b topic &&
-	echo Second > B &&
-	git add B &&
-	git commit -m "Add B1" &&
-	git checkout -f main &&
-	echo Third >> A &&
-	git commit -a -m "Modify A2" &&
-	echo Fifth > B &&
-	git add B &&
-	git commit -m "Add different B" &&
-
-	git clone ./. clone2 &&
-	(
-		cd clone2 &&
-		git checkout -b topic origin/topic &&
-		test_must_fail git merge origin/main &&
-		echo Resolved >B &&
-		git add B &&
-		git commit -m "Merge origin/main into topic"
-	) &&
-
-	git clone ./. clone3 &&
-	(
-		cd clone3 &&
-		git checkout -b topic2 origin/topic &&
-		echo Sixth > A &&
-		git commit -a -m "Modify A3" &&
-		git checkout -b topic origin/topic &&
-		git merge --no-ff topic2
-	) &&
-
-	git clone ./. clone4 &&
-	(
-		cd clone4 &&
-		git checkout -b topic2 origin/topic &&
-		echo Sixth > A &&
-		git commit -a -m "Modify A3" &&
-		git checkout -b topic origin/topic &&
-		git merge --no-ff topic2
-	) &&
-
-	git checkout topic &&
-	echo Fourth >> B &&
-	git commit -a -m "Modify B2"
-'
-
-test_expect_success '--continue works after a conflict' '
-	(
-	cd clone2 &&
-	git fetch &&
-	test_must_fail git rebase -p origin/topic &&
-	test 2 = $(git ls-files B | wc -l) &&
-	echo Resolved again > B &&
-	test_must_fail git rebase --continue &&
-	grep "^@@@ " .git/rebase-merge/patch &&
-	git add B &&
-	git rebase --continue &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Add different" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge origin" | wc -l)
-	)
-'
-
-test_expect_success 'rebase -p preserves no-ff merges' '
-	(
-	cd clone3 &&
-	git fetch &&
-	git rebase -p origin/topic &&
-	test 3 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge branch" | wc -l)
-	)
-'
-
-test_expect_success 'rebase -p ignores merge.log config' '
-	(
-	cd clone4 &&
-	git fetch &&
-	git -c merge.log=1 rebase -p origin/topic &&
-	echo >expected &&
-	git log --format="%b" -1 >current &&
-	test_cmp expected current
-	)
-'
-
-test_done
diff --git a/t/t3410-rebase-preserve-dropped-merges.sh b/t/t3410-rebase-preserve-dropped-merges.sh
deleted file mode 100755
index 2e29866993c..00000000000
--- a/t/t3410-rebase-preserve-dropped-merges.sh
+++ /dev/null
@@ -1,90 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2008 Stephen Haberman
-#
-
-test_description='git rebase preserve merges
-
-This test runs git rebase with preserve merges and ensures commits
-dropped by the --cherry-pick flag have their childrens parents
-rewritten.
-'
-. ./test-lib.sh
-
-if ! test_have_prereq REBASE_P; then
-	skip_all='skipping git rebase -p tests, as asked for'
-	test_done
-fi
-
-# set up two branches like this:
-#
-# A - B - C - D - E
-#   \
-#     F - G - H
-#       \
-#         I
-#
-# where B, D and G touch the same file.
-
-test_expect_success 'setup' '
-	test_commit A file1 &&
-	test_commit B file1 1 &&
-	test_commit C file2 &&
-	test_commit D file1 2 &&
-	test_commit E file3 &&
-	git checkout A &&
-	test_commit F file4 &&
-	test_commit G file1 3 &&
-	test_commit H file5 &&
-	git checkout F &&
-	test_commit I file6
-'
-
-# A - B - C - D - E
-#   \             \ \
-#     F - G - H -- L \        -->   L
-#       \            |               \
-#         I -- G2 -- J -- K           I -- K
-# G2 = same changes as G
-test_expect_success 'skip same-resolution merges with -p' '
-	git checkout H &&
-	test_must_fail git merge E &&
-	test_commit L file1 23 &&
-	git checkout I &&
-	test_commit G2 file1 3 &&
-	test_must_fail git merge E &&
-	test_commit J file1 23 &&
-	test_commit K file7 file7 &&
-	git rebase -i -p L &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse L) &&
-	test "23" = "$(cat file1)" &&
-	test "I" = "$(cat file6)" &&
-	test "file7" = "$(cat file7)"
-'
-
-# A - B - C - D - E
-#   \             \ \
-#     F - G - H -- L2 \        -->   L2
-#       \             |                \
-#         I -- G3 --- J2 -- K2           I -- G3 -- K2
-# G2 = different changes as G
-test_expect_success 'keep different-resolution merges with -p' '
-	git checkout H &&
-	test_must_fail git merge E &&
-	test_commit L2 file1 23 &&
-	git checkout I &&
-	test_commit G3 file1 4 &&
-	test_must_fail git merge E &&
-	test_commit J2 file1 24 &&
-	test_commit K2 file7 file7 &&
-	test_must_fail git rebase -i -p L2 &&
-	echo 234 > file1 &&
-	git add file1 &&
-	git rebase --continue &&
-	test $(git rev-parse HEAD^^^) = $(git rev-parse L2) &&
-	test "234" = "$(cat file1)" &&
-	test "I" = "$(cat file6)" &&
-	test "file7" = "$(cat file7)"
-'
-
-test_done
diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
deleted file mode 100755
index fb45e7bf7bd..00000000000
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ /dev/null
@@ -1,80 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2008 Stephen Haberman
-#
-
-test_description='git rebase preserve merges
-
-This test runs git rebase with -p and tries to squash a commit from after
-a merge to before the merge.
-'
-. ./test-lib.sh
-
-if ! test_have_prereq REBASE_P; then
-	skip_all='skipping git rebase -p tests, as asked for'
-	test_done
-fi
-
-. "$TEST_DIRECTORY"/lib-rebase.sh
-
-set_fake_editor
-
-# set up two branches like this:
-#
-# A1 - B1 - D1 - E1 - F1
-#       \        /
-#        -- C1 --
-
-test_expect_success 'setup' '
-	test_commit A1 &&
-	test_commit B1 &&
-	test_commit C1 &&
-	git reset --hard B1 &&
-	test_commit D1 &&
-	test_merge E1 C1 &&
-	test_commit F1
-'
-
-# Should result in:
-#
-# A1 - B1 - D2 - E2
-#       \        /
-#        -- C1 --
-#
-test_expect_success 'squash F1 into D1' '
-	FAKE_LINES="1 squash 4 2 3" git rebase -i -p B1 &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse C1)" &&
-	test "$(git rev-parse HEAD~2)" = "$(git rev-parse B1)" &&
-	git tag E2
-'
-
-# Start with:
-#
-# A1 - B1 - D2 - E2
-#  \
-#   G1 ---- L1 ---- M1
-#    \             /
-#     H1 -- J1 -- K1
-#      \         /
-#        -- I1 --
-#
-# And rebase G1..M1 onto E2
-
-test_expect_success 'rebase two levels of merge' '
-	git checkout A1 &&
-	test_commit G1 &&
-	test_commit H1 &&
-	test_commit I1 &&
-	git checkout -b branch3 H1 &&
-	test_commit J1 &&
-	test_merge K1 I1 &&
-	git checkout -b branch2 G1 &&
-	test_commit L1 &&
-	test_merge M1 K1 &&
-	GIT_EDITOR=: git rebase -i -p E2 &&
-	test "$(git rev-parse HEAD~3)" = "$(git rev-parse E2)" &&
-	test "$(git rev-parse HEAD~2)" = "$(git rev-parse HEAD^2^2~2)" &&
-	test "$(git rev-parse HEAD^2^1^1)" = "$(git rev-parse HEAD^2^2^1)"
-'
-
-test_done
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index fda62c65bd5..19c6f4acbf6 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -89,17 +89,6 @@ test_expect_success 'pre-rebase got correct input (4)' '
 	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,work4
 '
 
-test_expect_success REBASE_P 'rebase -i -p with linear history' '
-	git checkout -b work5 other &&
-	git rebase -i -p --root --onto main &&
-	git log --pretty=tformat:"%s" > rebased5 &&
-	test_cmp expect rebased5
-'
-
-test_expect_success REBASE_P 'pre-rebase got correct input (5)' '
-	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,
-'
-
 test_expect_success 'set up merge history' '
 	git checkout other^ &&
 	git checkout -b side &&
@@ -123,13 +112,6 @@ commit work6~4
 1
 EOF
 
-test_expect_success REBASE_P 'rebase -i -p with merge' '
-	git checkout -b work6 other &&
-	git rebase -i -p --root --onto main &&
-	log_with_names work6 > rebased6 &&
-	test_cmp expect-side rebased6
-'
-
 test_expect_success 'set up second root and merge' '
 	git symbolic-ref HEAD refs/heads/third &&
 	rm .git/index &&
@@ -158,13 +140,6 @@ commit work7~5
 1
 EOF
 
-test_expect_success REBASE_P 'rebase -i -p with two roots' '
-	git checkout -b work7 other &&
-	git rebase -i -p --root --onto main &&
-	log_with_names work7 > rebased7 &&
-	test_cmp expect-third rebased7
-'
-
 test_expect_success 'setup pre-rebase hook that fails' '
 	mkdir -p .git/hooks &&
 	cat >.git/hooks/pre-rebase <<EOF &&
@@ -264,21 +239,9 @@ commit conflict3~6
 1
 EOF
 
-test_expect_success REBASE_P 'rebase -i -p --root with conflict (first part)' '
-	git checkout -b conflict3 other &&
-	test_must_fail git rebase -i -p --root --onto main &&
-	git ls-files -u | grep "B$"
-'
-
 test_expect_success 'fix the conflict' '
 	echo 3 > B &&
 	git add B
 '
 
-test_expect_success REBASE_P 'rebase -i -p --root with conflict (second part)' '
-	git rebase --continue &&
-	log_with_names conflict3 >out &&
-	test_cmp expect-conflict-p out
-'
-
 test_done
diff --git a/t/t3414-rebase-preserve-onto.sh b/t/t3414-rebase-preserve-onto.sh
deleted file mode 100755
index 72e04b5386a..00000000000
--- a/t/t3414-rebase-preserve-onto.sh
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2009 Greg Price
-#
-
-test_description='git rebase -p should respect --onto
-
-In a rebase with --onto, we should rewrite all the commits that
-aren'"'"'t on top of $ONTO, even if they are on top of $UPSTREAM.
-'
-. ./test-lib.sh
-
-if ! test_have_prereq REBASE_P; then
-	skip_all='skipping git rebase -p tests, as asked for'
-	test_done
-fi
-
-. "$TEST_DIRECTORY"/lib-rebase.sh
-
-# Set up branches like this:
-# A1---B1---E1---F1---G1
-#  \    \             /
-#   \    \--C1---D1--/
-#    H1
-
-test_expect_success 'setup' '
-	test_commit A1 &&
-	test_commit B1 &&
-	test_commit C1 &&
-	test_commit D1 &&
-	git reset --hard B1 &&
-	test_commit E1 &&
-	test_commit F1 &&
-	test_merge G1 D1 &&
-	git reset --hard A1 &&
-	test_commit H1
-'
-
-# Now rebase merge G1 from both branches' base B1, both should move:
-# A1---B1---E1---F1---G1
-#  \    \             /
-#   \    \--C1---D1--/
-#    \
-#     H1---E2---F2---G2
-#      \             /
-#       \--C2---D2--/
-
-test_expect_success 'rebase from B1 onto H1' '
-	git checkout G1 &&
-	git rebase -p --onto H1 B1 &&
-	test "$(git rev-parse HEAD^1^1^1)" = "$(git rev-parse H1)" &&
-	test "$(git rev-parse HEAD^2^1^1)" = "$(git rev-parse H1)"
-'
-
-# On the other hand if rebase from E1 which is within one branch,
-# then the other branch stays:
-# A1---B1---E1---F1---G1
-#  \    \             /
-#   \    \--C1---D1--/
-#    \             \
-#     H1-----F3-----G3
-
-test_expect_success 'rebase from E1 onto H1' '
-	git checkout G1 &&
-	git rebase -p --onto H1 E1 &&
-	test "$(git rev-parse HEAD^1^1)" = "$(git rev-parse H1)" &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse D1)"
-'
-
-# And the same if we rebase from a commit in the second-parent branch.
-# A1---B1---E1---F1----G1
-#  \    \          \   /
-#   \    \--C1---D1-\-/
-#    \               \
-#     H1------D3------G4
-
-test_expect_success 'rebase from C1 onto H1' '
-	git checkout G1 &&
-	git rev-list --first-parent --pretty=oneline C1..G1 &&
-	git rebase -p --onto H1 C1 &&
-	test "$(git rev-parse HEAD^2^1)" = "$(git rev-parse H1)" &&
-	test "$(git rev-parse HEAD^1)" = "$(git rev-parse F1)"
-'
-
-test_done
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index f4c2ee02bc9..b62c16026fc 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -109,20 +109,6 @@ test_expect_success 'rebase -i --continue handles merge strategy and options' '
 	test -f funny.was.run
 '
 
-test_expect_success REBASE_P 'rebase passes merge strategy options correctly' '
-	rm -fr .git/rebase-* &&
-	git reset --hard commit-new-file-F3-on-topic-branch &&
-	test_commit theirs-to-merge &&
-	git reset --hard HEAD^ &&
-	test_commit some-commit &&
-	test_tick &&
-	git merge --no-ff theirs-to-merge &&
-	FAKE_LINES="1 edit 2 3" git rebase -i -f -p -m \
-		-s recursive --strategy-option=theirs HEAD~2 &&
-	test_commit force-change &&
-	git rebase --continue
-'
-
 test_expect_success 'rebase -r passes merge strategy options correctly' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
@@ -258,7 +244,6 @@ test_rerere_autoupdate
 test_rerere_autoupdate -m
 GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
 test_rerere_autoupdate -i
-test_have_prereq !REBASE_P || test_rerere_autoupdate --preserve-merges
 unset GIT_SEQUENCE_EDITOR
 
 test_expect_success 'the todo command "break" works' '
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 4a9204b4b64..62d86d557da 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -29,7 +29,6 @@ test_run_rebase () {
 test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_expect_success 'setup branches and remote tracking' '
 	git tag -l >tags &&
@@ -53,7 +52,6 @@ test_run_rebase () {
 test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -70,7 +68,6 @@ test_run_rebase success --apply
 test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -87,7 +84,6 @@ test_run_rebase success --apply
 test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -102,7 +98,6 @@ test_run_rebase success --apply
 test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 #       f
 #      /
@@ -142,7 +137,6 @@ test_run_rebase () {
 test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -157,7 +151,6 @@ test_run_rebase () {
 test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -172,7 +165,6 @@ test_run_rebase () {
 test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -187,7 +179,6 @@ test_run_rebase () {
 test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 # a---b---c---j!
 #      \
@@ -215,7 +206,6 @@ test_run_rebase () {
 test_run_rebase failure --apply
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -229,7 +219,6 @@ test_run_rebase () {
 }
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -243,7 +232,6 @@ test_run_rebase () {
 }
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 test_run_rebase success --rebase-merges
 
 #       m
@@ -283,7 +271,6 @@ test_run_rebase () {
 test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -298,7 +285,6 @@ test_run_rebase () {
 test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -313,7 +299,6 @@ test_run_rebase () {
 test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -329,7 +314,6 @@ test_run_rebase () {
 test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -344,7 +328,6 @@ test_run_rebase () {
 test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -358,7 +341,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -373,6 +355,5 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_done
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index c8234062c6c..eb0a3d9d487 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -63,15 +63,4 @@ test_rebase_am_only () {
 test_rebase_am_only --whitespace=fix
 test_rebase_am_only -C4
 
-test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
-	git checkout B^0 &&
-	test_must_fail git rebase --preserve-merges --signoff A
-'
-
-test_expect_success REBASE_P \
-	'--preserve-merges incompatible with --rebase-merges' '
-	git checkout B^0 &&
-	test_must_fail git rebase --preserve-merges --rebase-merges A
-'
-
 test_done
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index e42faa44e74..63acc1ea4da 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -106,155 +106,4 @@ test_run_rebase success 'd n o e' --apply
 test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
-if ! test_have_prereq REBASE_P; then
-	skip_all='skipping git rebase -p tests, as asked for'
-	test_done
-fi
-
-test_expect_success "rebase -p is no-op in non-linear history" "
-	reset_rebase &&
-	git rebase -p d w &&
-	test_cmp_rev w HEAD
-"
-
-test_expect_success "rebase -p is no-op when base inside second parent" "
-	reset_rebase &&
-	git rebase -p e w &&
-	test_cmp_rev w HEAD
-"
-
-test_expect_failure "rebase -p --root on non-linear history is a no-op" "
-	reset_rebase &&
-	git rebase -p --root w &&
-	test_cmp_rev w HEAD
-"
-
-test_expect_success "rebase -p re-creates merge from side branch" "
-	reset_rebase &&
-	git rebase -p z w &&
-	test_cmp_rev z HEAD^ &&
-	test_cmp_rev w^2 HEAD^2
-"
-
-test_expect_success "rebase -p re-creates internal merge" "
-	reset_rebase &&
-	git rebase -p c w &&
-	test_cmp_rev c HEAD~4 &&
-	test_cmp_rev HEAD^2^ HEAD~3 &&
-	test_revision_subjects 'd n e o w' HEAD~3 HEAD~2 HEAD^2 HEAD^ HEAD
-"
-
-test_expect_success "rebase -p can re-create two branches on onto" "
-	reset_rebase &&
-	git rebase -p --onto c d w &&
-	test_cmp_rev c HEAD~3 &&
-	test_cmp_rev c HEAD^2^ &&
-	test_revision_subjects 'n e o w' HEAD~2 HEAD^2 HEAD^ HEAD
-"
-
-#       f
-#      /
-# a---b---c---g---h
-#      \
-#       d---gp--i
-#        \       \
-#         e-------u
-#
-# gp = cherry-picked g
-# h = reverted g
-test_expect_success 'setup of non-linear-history for patch-equivalence tests' '
-	git checkout e &&
-	test_merge u i
-'
-
-test_expect_success "rebase -p re-creates history around dropped commit matching upstream" "
-	reset_rebase &&
-	git rebase -p h u &&
-	test_cmp_rev h HEAD~3 &&
-	test_cmp_rev HEAD^2^ HEAD~2 &&
-	test_revision_subjects 'd i e u' HEAD~2 HEAD^2 HEAD^ HEAD
-"
-
-test_expect_success "rebase -p --onto in merged history drops patches in upstream" "
-	reset_rebase &&
-	git rebase -p --onto f h u &&
-	test_cmp_rev f HEAD~3 &&
-	test_cmp_rev HEAD^2^ HEAD~2 &&
-	test_revision_subjects 'd i e u' HEAD~2 HEAD^2 HEAD^ HEAD
-"
-
-test_expect_success "rebase -p --onto in merged history does not drop patches in onto" "
-	reset_rebase &&
-	git rebase -p --onto h f u &&
-	test_cmp_rev h HEAD~3 &&
-	test_cmp_rev HEAD^2~2 HEAD~2 &&
-	test_revision_subjects 'd gp i e u' HEAD~2 HEAD^2^ HEAD^2 HEAD^ HEAD
-"
-
-# a---b---c---g---h
-#      \
-#       d---gp--s
-#        \   \ /
-#         \   X
-#          \ / \
-#           e---t
-#
-# gp = cherry-picked g
-# h = reverted g
-test_expect_success 'setup of non-linear-history for dropping whole side' '
-	git checkout gp &&
-	test_merge s e &&
-	git checkout e &&
-	test_merge t gp
-'
-
-test_expect_failure "rebase -p drops merge commit when entire first-parent side is dropped" "
-	reset_rebase &&
-	git rebase -p h s &&
-	test_cmp_rev h HEAD~2 &&
-	test_linear_range 'd e' h..
-"
-
-test_expect_success "rebase -p drops merge commit when entire second-parent side is dropped" "
-	reset_rebase &&
-	git rebase -p h t &&
-	test_cmp_rev h HEAD~2 &&
-	test_linear_range 'd e' h..
-"
-
-# a---b---c
-#      \
-#       d---e
-#        \   \
-#         n---r
-#          \
-#           o
-#
-# r = tree-same with n
-test_expect_success 'setup of non-linear-history for empty commits' '
-	git checkout n &&
-	git merge --no-commit e &&
-	git reset n . &&
-	git commit -m r &&
-	git reset --hard &&
-	git clean -f &&
-	git tag r
-'
-
-test_expect_success "rebase -p re-creates empty internal merge commit" "
-	reset_rebase &&
-	git rebase -p c r &&
-	test_cmp_rev c HEAD~3 &&
-	test_cmp_rev HEAD^2^ HEAD~2 &&
-	test_revision_subjects 'd e n r' HEAD~2 HEAD^2 HEAD^ HEAD
-"
-
-test_expect_success "rebase -p re-creates empty merge commit" "
-	reset_rebase &&
-	git rebase -p o r &&
-	test_cmp_rev e HEAD^2 &&
-	test_cmp_rev o HEAD^ &&
-	test_revision_subjects 'r' HEAD
-"
-
 test_done
diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index e78c7e37969..48b76f82325 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -36,11 +36,10 @@ commit_message() {
 # where the root commit adds three files: topic_1.t, topic_2.t and topic_3.t.
 #
 # This commit history is then rebased onto `topic_3` with the
-# `-Xsubtree=files_subtree` option in three different ways:
+# `-Xsubtree=files_subtree` option in two different ways:
 #
-# 1. using `--preserve-merges`
-# 2. using `--preserve-merges` and --keep-empty
-# 3. without specifying a rebase backend
+# 1. without specifying a rebase backend
+# 2. using the `--rebase-merges` backend
 
 test_expect_success 'setup' '
 	test_commit README &&
@@ -69,25 +68,6 @@ test_expect_success 'setup' '
 	git commit -m "Empty commit" --allow-empty
 '
 
-# FAILURE: Does not preserve topic_4.
-test_expect_failure REBASE_P 'Rebase -Xsubtree --preserve-merges --onto commit' '
-	reset_rebase &&
-	git checkout -b rebase-preserve-merges to-rebase &&
-	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-main main &&
-	verbose test "$(commit_message HEAD~)" = "topic_4" &&
-	verbose test "$(commit_message HEAD)" = "files_subtree/topic_5"
-'
-
-# FAILURE: Does not preserve topic_4.
-test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit' '
-	reset_rebase &&
-	git checkout -b rebase-keep-empty to-rebase &&
-	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-main main &&
-	verbose test "$(commit_message HEAD~2)" = "topic_4" &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/topic_5" &&
-	verbose test "$(commit_message HEAD)" = "Empty commit"
-'
-
 test_expect_success 'Rebase -Xsubtree --empty=ask --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-onto to-rebase &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index bb9b6b900eb..a2924036ad4 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -546,15 +546,6 @@ test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	test_cmp expect actual
 '
 
-test_expect_success REBASE_P \
-	'pull.rebase=preserve rebases and merges keep-merge' '
-	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase preserve &&
-	git pull . copy &&
-	test_cmp_rev HEAD^^ copy &&
-	test_cmp_rev HEAD^2 keep-merge
-'
-
 test_expect_success 'pull.rebase=interactive' '
 	write_script "$TRASH_DIRECTORY/fake-editor" <<-\EOF &&
 	echo I was here >fake.out &&
@@ -606,15 +597,6 @@ test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	test_cmp expect actual
 '
 
-test_expect_success REBASE_P \
-	'--rebase=preserve rebases and merges keep-merge' '
-	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase true &&
-	git pull --rebase=preserve . copy &&
-	test_cmp_rev HEAD^^ copy &&
-	test_cmp_rev HEAD^2 keep-merge
-'
-
 test_expect_success '--rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_must_fail git pull --rebase=invalid . copy
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 7a8194ce720..2a07c708679 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -250,7 +250,6 @@ test_rebase () {
 }
 
 test_rebase success
-test_have_prereq !REBASE_P || test_rebase success -p
 
 test_expect_success 'with hook (cherry-pick)' '
 	test_when_finished "git checkout -f main" &&
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index 405420ae4d8..163ae804685 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -75,19 +75,6 @@ test_expect_success 'noop interactive rebase does not care about ident' '
 	git rebase -i HEAD^
 '
 
-test_expect_success REBASE_P \
-	'fast-forward rebase does not care about ident (preserve)' '
-	git checkout -B tmp side-without-commit &&
-	git rebase -p main
-'
-
-test_expect_success REBASE_P \
-	'non-fast-forward rebase refuses to write commits (preserve)' '
-	test_when_finished "git rebase --abort || true" &&
-	git checkout -B tmp side-with-commit &&
-	test_must_fail git rebase -p main
-'
-
 test_expect_success 'author.name overrides user.name' '
 	test_config user.name user &&
 	test_config user.email user@example.com &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index abcfbed6d61..11a9c8a6516 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1708,10 +1708,6 @@ test_lazy_prereq SHA1 '
 	esac
 '
 
-test_lazy_prereq REBASE_P '
-	test -z "$GIT_TEST_SKIP_REBASE_P"
-'
-
 # Ensure that no test accidentally triggers a Git command
 # that runs the actual maintenance scheduler, affecting a user's
 # system permanently.
-- 
gitgitgadget

