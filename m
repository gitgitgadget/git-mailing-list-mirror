Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC11C432C3
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470F520672
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBsgH57j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKWUuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:50:52 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:50996 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKWUuv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 15:50:51 -0500
Received: by mail-wm1-f41.google.com with SMTP id l17so11174077wmh.0
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 12:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=giCq+4Wo3c6a6h+BNHWQHHxYtS9MvLxTE1NAzpw+Rkw=;
        b=fBsgH57jR+g6AdD4k5rINR8Rv1nf28NC+MmxxEzKWlkKLlCEzd5+8jf5VSJKQRHEUy
         1ZSIsRlT1jiXpIALXT4QJgzAikpi24cLUWi7xo4WO5MR7WhXPXuCE+ZF1i2mcZPT8ylL
         Hpzh3f1p57BG7ggcnTxPDLmdoR0vbPeNwHIdLcM6sHY0Gq45moUROaOH8MBmEI5uV/bA
         YYXgWZwlJE1CbttV5Otkn1aEofI6CFb/bkqe1ic1rj1nz9e7K7AfiY8p5yivCE40mrzj
         pJfr0ZNN+hSsbHYGLSYKLAuNxtekagRauzzlFHFz6wg+yJEcJT1D6IPLRTz1R9H0H8QO
         jCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=giCq+4Wo3c6a6h+BNHWQHHxYtS9MvLxTE1NAzpw+Rkw=;
        b=kcbAS/oodz+uzwyDHFnCYGf01r5Qln/pey0dAaTHMclaCtJwiawufxd4FfIAEHZC6M
         7c85nM5cEMAq0JbSx26JiQeRH3LajtzB7xK27TnzHDpBqHQAp2U2VhZ5m2AHoouVCJaY
         S3bvjbQkeRn1n7tuBmzzWk+hkbMUQw62Q9TkVIwNbN3IFGlvuwULL+e1huqjtRxI9S7v
         SYvCv6w+8/oDQgYmWQbZds+veUdvyGj8lXQr/pevqQBM6agCTQwtT3QqydhaU+RUtzrp
         yG+kv7DkYzVDNWnxlPotIj8bOUJIoAVQmtN4J5NUzjfNgmEx3j8DjUcOe8zbcKT0Fwy3
         dhyw==
X-Gm-Message-State: APjAAAUvfRqjQmBe/cQ8Bm7Edj9oXsyAfAiXwxwSTm1S/ZiU520hYuqr
        dOJrE+8+G2j+8RGjtfdPJnttecgC
X-Google-Smtp-Source: APXvYqxDwZ8xy7F3jk5jywSNmOmMQPHTDJAR97zvuunlQ7X6HNSKRBRd7J0lWS0wB11vHmdoe1EcBg==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr21706650wma.177.1574542246474;
        Sat, 23 Nov 2019 12:50:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm3124293wmk.29.2019.11.23.12.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 12:50:46 -0800 (PST)
Message-Id: <b614336f3df5f433478eb1c1bdaa443919196347.1574542242.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.git.1574542242.gitgitgadget@gmail.com>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 20:50:37 +0000
Subject: [PATCH 3/8] tests: stop testing `git rebase --preserve-merges`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
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
 azure-pipelines.yml                       |   2 -
 t/t3404-rebase-interactive.sh             |  76 -----------
 t/t3408-rebase-multi-line.sh              |  10 --
 t/t3409-rebase-preserve-merges.sh         | 127 ------------------
 t/t3410-rebase-preserve-dropped-merges.sh |  90 -------------
 t/t3411-rebase-preserve-around-merges.sh  |  80 ------------
 t/t3412-rebase-root.sh                    |  37 ------
 t/t3414-rebase-preserve-onto.sh           |  85 ------------
 t/t3418-rebase-continue.sh                |  15 ---
 t/t3421-rebase-topology-linear.sh         |  19 ---
 t/t3422-rebase-incompatible-options.sh    |  11 --
 t/t3425-rebase-topology-merges.sh         | 151 ----------------------
 t/t3427-rebase-subtree.sh                 |  19 ---
 t/t5520-pull.sh                           |  18 ---
 t/t7505-prepare-commit-msg-hook.sh        |   1 -
 t/t7517-per-repo-email.sh                 |  13 --
 t/test-lib.sh                             |   4 -
 17 files changed, 758 deletions(-)
 delete mode 100755 t/t3409-rebase-preserve-merges.sh
 delete mode 100755 t/t3410-rebase-preserve-dropped-merges.sh
 delete mode 100755 t/t3411-rebase-preserve-around-merges.sh
 delete mode 100755 t/t3414-rebase-preserve-onto.sh

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index af2a5ea484..c75f27a7fa 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -106,7 +106,6 @@ jobs:
       HOME: $(Build.SourcesDirectory)
       MSYSTEM: MINGW64
       NO_SVN_TESTS: 1
-      GIT_TEST_SKIP_REBASE_P: 1
   - powershell: |
       if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
         cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
@@ -265,7 +264,6 @@ jobs:
       HOME: $(Build.SourcesDirectory)
       MSYSTEM: MINGW64
       NO_SVN_TESTS: 1
-      GIT_TEST_SKIP_REBASE_P: 1
   - powershell: |
       if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
         cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index bf0dc756d2..c14a664604 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -345,82 +345,6 @@ test_expect_success 'retain authorship when squashing' '
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
-	git checkout -b to-be-preserved master^ &&
-	: > unrelated-file &&
-	git add unrelated-file &&
-	test_tick &&
-	git commit -m "unrelated" &&
-	git checkout -b another-branch master &&
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
-	git rebase -i -p --onto branch1 master &&
-	git update-index --refresh &&
-	git diff-files --quiet &&
-	git diff-index --quiet --cached HEAD -- &&
-	test $(git rev-parse HEAD~6) = $(git rev-parse branch1) &&
-	test $(git rev-parse HEAD~4^2) = $(git rev-parse to-be-preserved) &&
-	test $(git rev-parse HEAD^^2^) = $(git rev-parse HEAD^^^) &&
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
index d2bd7c17b0..126845a97c 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -52,14 +52,4 @@ test_expect_success rebase '
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
index 3b340f1ece..0000000000
--- a/t/t3409-rebase-preserve-merges.sh
+++ /dev/null
@@ -1,127 +0,0 @@
-#!/bin/sh
-#
-# Copyright(C) 2008 Stephen Habermann & Andreas Ericsson
-#
-test_description='git rebase -p should preserve merges
-
-Run "git rebase -p" and check that merges are properly carried along
-'
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
-# A1--A2--B3   <-- origin/master
-#  \       \
-#   B1------M  <-- topic
-#    \
-#     B2       <-- origin/topic
-#
-# Clone 3 (no-ff merge):
-#
-# A1--A2--B3   <-- origin/master
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
-	git checkout -f master &&
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
-		test_must_fail git merge origin/master &&
-		echo Resolved >B &&
-		git add B &&
-		git commit -m "Merge origin/master into topic"
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
index 2e29866993..0000000000
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
index fb45e7bf7b..0000000000
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
index 21632a984e..7ba343198a 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -86,17 +86,6 @@ test_expect_success 'pre-rebase got correct input (4)' '
 	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,work4
 '
 
-test_expect_success REBASE_P 'rebase -i -p with linear history' '
-	git checkout -b work5 other &&
-	git rebase -i -p --root --onto master &&
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
@@ -120,13 +109,6 @@ commit work6~4
 1
 EOF
 
-test_expect_success REBASE_P 'rebase -i -p with merge' '
-	git checkout -b work6 other &&
-	git rebase -i -p --root --onto master &&
-	log_with_names work6 > rebased6 &&
-	test_cmp expect-side rebased6
-'
-
 test_expect_success 'set up second root and merge' '
 	git symbolic-ref HEAD refs/heads/third &&
 	rm .git/index &&
@@ -155,13 +137,6 @@ commit work7~5
 1
 EOF
 
-test_expect_success REBASE_P 'rebase -i -p with two roots' '
-	git checkout -b work7 other &&
-	git rebase -i -p --root --onto master &&
-	log_with_names work7 > rebased7 &&
-	test_cmp expect-third rebased7
-'
-
 test_expect_success 'setup pre-rebase hook that fails' '
 	mkdir -p .git/hooks &&
 	cat >.git/hooks/pre-rebase <<EOF &&
@@ -261,21 +236,9 @@ commit conflict3~6
 1
 EOF
 
-test_expect_success REBASE_P 'rebase -i -p --root with conflict (first part)' '
-	git checkout -b conflict3 other &&
-	test_must_fail git rebase -i -p --root --onto master &&
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
index 72e04b5386..0000000000
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
index 7a2da972fd..ce78b6b97b 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -106,20 +106,6 @@ test_expect_success 'rebase -i --continue handles merge strategy and options' '
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
@@ -255,7 +241,6 @@ test_rerere_autoupdate
 test_rerere_autoupdate -m
 GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
 test_rerere_autoupdate -i
-test_have_prereq !REBASE_P || test_rerere_autoupdate --preserve-merges
 unset GIT_SEQUENCE_EDITOR
 
 test_expect_success 'the todo command "break" works' '
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index b847064f91..40375aff58 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -29,7 +29,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_expect_success 'setup branches and remote tracking' '
 	git tag -l >tags &&
@@ -53,7 +52,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -70,7 +68,6 @@ test_run_rebase success ''
 test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -87,7 +84,6 @@ test_run_rebase success ''
 test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -102,7 +98,6 @@ test_run_rebase success ''
 test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 #       f
 #      /
@@ -142,7 +137,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -157,7 +151,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -172,7 +165,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -187,7 +179,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 # a---b---c---j!
 #      \
@@ -215,7 +206,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -230,7 +220,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -245,7 +234,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 test_run_rebase success --rebase-merges
 
 #       m
@@ -285,7 +273,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -300,7 +287,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -315,7 +301,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -331,7 +316,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -346,7 +330,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -360,7 +343,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -375,6 +357,5 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_done
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 50e7960702..c1c9772ac2 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -65,15 +65,4 @@ test_rebase_am_only --ignore-whitespace
 test_rebase_am_only --committer-date-is-author-date
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
index fd8efe84fe..88874c1e50 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -106,155 +106,4 @@ test_run_rebase success 'd n o e' ''
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
index bec48e6a1f..ffe385e493 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -66,25 +66,6 @@ test_expect_success 'setup' '
 	git commit -m "Empty commit" --allow-empty
 '
 
-# FAILURE: Does not preserve master4.
-test_expect_failure REBASE_P 'Rebase -Xsubtree --preserve-merges --onto commit' '
-	reset_rebase &&
-	git checkout -b rebase-preserve-merges to-rebase &&
-	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~)" = "master4" &&
-	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
-'
-
-# FAILURE: Does not preserve master4.
-test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit' '
-	reset_rebase &&
-	git checkout -b rebase-keep-empty to-rebase &&
-	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~2)" = "master4" &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
-	verbose test "$(commit_message HEAD)" = "Empty commit"
-'
-
 test_expect_success 'Rebase -Xsubtree --keep-empty --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-onto to-rebase &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 41b799e336..e5f679af33 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -461,15 +461,6 @@ test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_success REBASE_P \
-	'pull.rebase=preserve rebases and merges keep-merge' '
-	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase preserve &&
-	git pull . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
-'
-
 test_expect_success 'pull.rebase=interactive' '
 	write_script "$TRASH_DIRECTORY/fake-editor" <<-\EOF &&
 	echo I was here >fake.out &&
@@ -515,15 +506,6 @@ test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_success REBASE_P \
-	'--rebase=preserve rebases and merges keep-merge' '
-	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase true &&
-	git pull --rebase=preserve . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
-'
-
 test_expect_success '--rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	! git pull --rebase=invalid . copy
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 94f85cdf83..1b4a7725fb 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -247,7 +247,6 @@ test_rebase () {
 }
 
 test_rebase success
-test_have_prereq !REBASE_P || test_rebase success -p
 
 test_expect_success 'with hook (cherry-pick)' '
 	test_when_finished "git checkout -f master" &&
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index b2401cec3e..0dec7f756b 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -72,19 +72,6 @@ test_expect_success 'noop interactive rebase does not care about ident' '
 	git rebase -i HEAD^
 '
 
-test_expect_success REBASE_P \
-	'fast-forward rebase does not care about ident (preserve)' '
-	git checkout -B tmp side-without-commit &&
-	git rebase -p master
-'
-
-test_expect_success REBASE_P \
-	'non-fast-forward rebase refuses to write commits (preserve)' '
-	test_when_finished "git rebase --abort || true" &&
-	git checkout -B tmp side-with-commit &&
-	test_must_fail git rebase -p master
-'
-
 test_expect_success 'author.name overrides user.name' '
 	test_config user.name user &&
 	test_config user.email user@example.com &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 46c4440843..0ef620f975 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1634,7 +1634,3 @@ test_lazy_prereq CURL '
 test_lazy_prereq SHA1 '
 	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
 '
-
-test_lazy_prereq REBASE_P '
-	test -z "$GIT_TEST_SKIP_REBASE_P"
-'
-- 
gitgitgadget

