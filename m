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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBACC64E90
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E7A246BB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4ALMUmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgKRXpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbgKRXpC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:02 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595A0C061A49
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 1so4756758wme.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uVv++0vC2i2wbBxQMU1g9Tu2B3CtNfnuuf4gDUJscZA=;
        b=k4ALMUmVs5qe24MEs3GTwrRITqDFZ67ETZhmTkLVBMFSwtE3UouJ0oH6wnu/sSfHpP
         Jn3Iele5XLRb04ZyDmuiODUvev+TqZfyDhf63S3PcvDMOWd7Bz5VIH8etnBU4EzXTH4i
         6/oAAGTmfw0H4L2UQbK2PU61ANFpYfF41u60/iOd/TJKx4mLB5JzgVeCzkgi01xh+S8B
         0gqpdmSYN7Ccw3uj9E1E7RyIFFcHHZVYAxhyyA3qb/hTI9o/NxpCFLnvSVAu/aL7n1r4
         DU5BWU+2hO03NqnKybfYpGZI6NbMB/duha1AxBJu0di8SeSi7J+7p61P54fCDlf0iLwd
         qlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uVv++0vC2i2wbBxQMU1g9Tu2B3CtNfnuuf4gDUJscZA=;
        b=MweCerwSvPq38zEKs2oDqtKODPXnh0Hipr31Su9KMP8seA23WyZ3hQotKPpoco2NMf
         k3RixShtEIOwJp717PS64w2kiBBCdcMuXcV6zuhkRm4cBNZzjW+GLQjYibDGpGi94JmC
         r8RNmUvAbRcEnZJxbrVrjIDbKetbqDXPlMp5O+19gq788bn3GoeNHXAty14jO9aVd4Mr
         ivEAxAOxHgdNrpxzB2KwY/M9SBh58tLPpV+2Kb6aWbHrBCSoxU7avktLDj/x1yeMnTmL
         9OZ/MNloXYd+/qlUvev73UTpAmhExk1UkTJlcv4RvkmUrypGkU6BXaMkTC99EQNxz+HW
         JuMg==
X-Gm-Message-State: AOAM530S3jo3QMFgpHbP6nwepg12jigmZ7RI0UzZi+e8nkiC3nMjItl+
        GS/EJSYJIgOVOFX1vvIB24O5Te1jsZQ=
X-Google-Smtp-Source: ABdhPJzTXENjIFIptaVT7+0vzL6iJsvbFJtuMnJxXafKY943XSYJP8CpUR3SRehgx2mr8qU1v3MBvg==
X-Received: by 2002:a1c:7d10:: with SMTP id y16mr1571271wmc.142.1605743098253;
        Wed, 18 Nov 2020 15:44:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y20sm6155800wma.15.2020.11.18.15.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:44:57 -0800 (PST)
Message-Id: <db3a10475007b9fd616dc19465bc475822bcd679.1605743087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:26 +0000
Subject: [PATCH v3 08/28] t3[5-9]*: adjust the references to the default
 branch name "main"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t3[5-9]*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3500-cherry.sh                   | 14 +++++-----
 t/t3501-revert-cherry-pick.sh       |  6 ++---
 t/t3502-cherry-pick-merge.sh        |  4 +--
 t/t3503-cherry-pick-root.sh         | 12 ++++-----
 t/t3504-cherry-pick-rerere.sh       | 26 +++++++++---------
 t/t3505-cherry-pick-empty.sh        | 26 +++++++++---------
 t/t3506-cherry-pick-ff.sh           | 10 +++----
 t/t3507-cherry-pick-conflict.sh     |  4 +--
 t/t3508-cherry-pick-many-commits.sh | 40 +++++++++++++--------------
 t/t3509-cherry-pick-merge-df.sh     |  4 +--
 t/t3512-cherry-pick-submodule.sh    |  4 +--
 t/t3600-rm.sh                       | 12 ++++-----
 t/t3701-add-interactive.sh          |  6 ++---
 t/t3901-i18n-patch.sh               | 42 ++++++++++++++---------------
 t/t3903-stash.sh                    | 34 +++++++++++------------
 t/t3910-mac-os-precompose.sh        |  8 +++---
 16 files changed, 126 insertions(+), 126 deletions(-)

diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index 99905dd49a..0458a58b4b 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -5,10 +5,10 @@
 
 test_description='git cherry should detect patches integrated upstream
 
-This test cherry-picks one local change of two into master branch, and
+This test cherry-picks one local change of two into main branch, and
 checks that git cherry only returns the second patch in the local branch
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -35,7 +35,7 @@ test_expect_success \
      test_tick &&
      git commit -m "Add C." &&
 
-     git checkout -f master &&
+     git checkout -f main &&
      rm -f B C &&
 
      echo Third >> A &&
@@ -43,19 +43,19 @@ test_expect_success \
      test_tick &&
      git commit -m "Modify A." &&
 
-     expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* + .*"
+     expr "$(echo $(git cherry main my-topic-branch) )" : "+ [^ ]* + .*"
 '
 
 test_expect_success \
     'check that cherry with limit returns only the top patch'\
-    'expr "$(echo $(git cherry master my-topic-branch my-topic-branch^1) )" : "+ [^ ]*"
+    'expr "$(echo $(git cherry main my-topic-branch my-topic-branch^1) )" : "+ [^ ]*"
 '
 
 test_expect_success \
     'cherry-pick one of the 2 patches, and check cherry recognized one and only one as new' \
     'git cherry-pick my-topic-branch^0 &&
-     echo $(git cherry master my-topic-branch) &&
-     expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* - .*"
+     echo $(git cherry main my-topic-branch) &&
+     expr "$(echo $(git cherry main my-topic-branch) )" : "+ [^ ]* - .*"
 '
 
 test_expect_success 'cherry ignores whitespace' '
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 6a10714e22..9d100cd188 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -10,7 +10,7 @@ test_description='test cherry-pick and revert with renames
 
 '
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -115,7 +115,7 @@ test_expect_success 'cherry-pick on unborn branch' '
 test_expect_success 'cherry-pick "-" to pick from previous branch' '
 	git checkout unborn &&
 	test_commit to-pick actual content &&
-	git checkout master &&
+	git checkout main &&
 	git cherry-pick - &&
 	echo content >expect &&
 	test_cmp expect actual
@@ -135,7 +135,7 @@ test_expect_success 'cherry-pick "-" is meaningless without checkout' '
 test_expect_success 'cherry-pick "-" works with arguments' '
 	git checkout -b side-branch &&
 	test_commit change actual change &&
-	git checkout master &&
+	git checkout main &&
 	git cherry-pick -s - &&
 	echo "Signed-off-by: C O Mitter <committer@example.com>" >expect &&
 	git cat-file commit HEAD | grep ^Signed-off-by: >signoff &&
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 774ad9ce14..5495eacfec 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -8,7 +8,7 @@ test_description='cherry picking and reverting a merge
 
 '
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -28,7 +28,7 @@ test_expect_success setup '
 	echo new line >B &&
 	git commit -m "add line to B" B &&
 	git tag b &&
-	git checkout master &&
+	git checkout main &&
 	git merge side &&
 	git tag c
 
diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index 00c622d5dc..95fe4feaee 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -2,7 +2,7 @@
 
 test_description='test cherry-picking (and reverting) a root commit'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -33,7 +33,7 @@ test_expect_success setup '
 test_expect_success 'cherry-pick a root commit' '
 
 	git checkout second^0 &&
-	git cherry-pick master &&
+	git cherry-pick main &&
 	echo first >expect &&
 	test_cmp expect file1
 
@@ -41,14 +41,14 @@ test_expect_success 'cherry-pick a root commit' '
 
 test_expect_success 'revert a root commit' '
 
-	git revert master &&
+	git revert main &&
 	test_path_is_missing file1
 
 '
 
 test_expect_success 'cherry-pick a root commit with an external strategy' '
 
-	git cherry-pick --strategy=resolve master &&
+	git cherry-pick --strategy=resolve main &&
 	echo first >expect &&
 	test_cmp expect file1
 
@@ -56,7 +56,7 @@ test_expect_success 'cherry-pick a root commit with an external strategy' '
 
 test_expect_success 'revert a root commit with an external strategy' '
 
-	git revert --strategy=resolve master &&
+	git revert --strategy=resolve main &&
 	test_path_is_missing file1
 
 '
@@ -68,7 +68,7 @@ test_expect_success 'cherry-pick two root commits' '
 	echo third >expect.file3 &&
 
 	git checkout second^0 &&
-	git cherry-pick master third &&
+	git cherry-pick main third &&
 
 	test_cmp expect.file1 file1 &&
 	test_cmp expect.file2 file2 &&
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index 860ba0b496..9198535874 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -2,15 +2,15 @@
 
 test_description='cherry-pick should rerere for conflicts'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
 test_expect_success setup '
 	test_commit foo &&
-	test_commit foo-master foo &&
-	test_commit bar-master bar &&
+	test_commit foo-main foo &&
+	test_commit bar-main bar &&
 
 	git checkout -b dev foo &&
 	test_commit foo-dev foo &&
@@ -19,7 +19,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'conflicting merge' '
-	test_must_fail git merge master
+	test_must_fail git merge main
 '
 
 test_expect_success 'fixup' '
@@ -32,7 +32,7 @@ test_expect_success 'fixup' '
 '
 
 test_expect_success 'cherry-pick conflict with --rerere-autoupdate' '
-	test_must_fail git cherry-pick --rerere-autoupdate foo..bar-master &&
+	test_must_fail git cherry-pick --rerere-autoupdate foo..bar-main &&
 	test_cmp foo-expect foo &&
 	git diff-files --quiet &&
 	test_must_fail git cherry-pick --continue &&
@@ -44,7 +44,7 @@ test_expect_success 'cherry-pick conflict with --rerere-autoupdate' '
 
 test_expect_success 'cherry-pick conflict repsects rerere.autoUpdate' '
 	test_config rerere.autoUpdate true &&
-	test_must_fail git cherry-pick foo..bar-master &&
+	test_must_fail git cherry-pick foo..bar-main &&
 	test_cmp foo-expect foo &&
 	git diff-files --quiet &&
 	test_must_fail git cherry-pick --continue &&
@@ -56,7 +56,7 @@ test_expect_success 'cherry-pick conflict repsects rerere.autoUpdate' '
 
 test_expect_success 'cherry-pick conflict with --no-rerere-autoupdate' '
 	test_config rerere.autoUpdate true &&
-	test_must_fail git cherry-pick --no-rerere-autoupdate foo..bar-master &&
+	test_must_fail git cherry-pick --no-rerere-autoupdate foo..bar-main &&
 	test_cmp foo-expect foo &&
 	test_must_fail git diff-files --quiet &&
 	git add foo &&
@@ -69,7 +69,7 @@ test_expect_success 'cherry-pick conflict with --no-rerere-autoupdate' '
 '
 
 test_expect_success 'cherry-pick --continue rejects --rerere-autoupdate' '
-	test_must_fail git cherry-pick --rerere-autoupdate foo..bar-master &&
+	test_must_fail git cherry-pick --rerere-autoupdate foo..bar-main &&
 	test_cmp foo-expect foo &&
 	git diff-files --quiet &&
 	test_must_fail git cherry-pick --continue --rerere-autoupdate >actual 2>&1 &&
@@ -82,25 +82,25 @@ test_expect_success 'cherry-pick --continue rejects --rerere-autoupdate' '
 '
 
 test_expect_success 'cherry-pick --rerere-autoupdate more than once' '
-	test_must_fail git cherry-pick --rerere-autoupdate --rerere-autoupdate foo..bar-master &&
+	test_must_fail git cherry-pick --rerere-autoupdate --rerere-autoupdate foo..bar-main &&
 	test_cmp foo-expect foo &&
 	git diff-files --quiet &&
 	git cherry-pick --abort &&
-	test_must_fail git cherry-pick --rerere-autoupdate --no-rerere-autoupdate --rerere-autoupdate foo..bar-master &&
+	test_must_fail git cherry-pick --rerere-autoupdate --no-rerere-autoupdate --rerere-autoupdate foo..bar-main &&
 	test_cmp foo-expect foo &&
 	git diff-files --quiet &&
 	git cherry-pick --abort &&
-	test_must_fail git cherry-pick --rerere-autoupdate --no-rerere-autoupdate foo..bar-master &&
+	test_must_fail git cherry-pick --rerere-autoupdate --no-rerere-autoupdate foo..bar-main &&
 	test_must_fail git diff-files --quiet &&
 	git cherry-pick --abort
 '
 
 test_expect_success 'cherry-pick conflict without rerere' '
 	test_config rerere.enabled false &&
-	test_must_fail git cherry-pick foo-master &&
+	test_must_fail git cherry-pick foo-main &&
 	grep ===== foo &&
 	grep foo-dev foo &&
-	grep foo-master foo
+	grep foo-main foo
 '
 
 test_done
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index 20cd4052d4..eba3c38d5a 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -2,7 +2,7 @@
 
 test_description='test cherry-picking an empty commit'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -20,7 +20,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit --allow-empty-message -m "" &&
 
-	git checkout master &&
+	git checkout main &&
 	git checkout -b empty-change-branch &&
 	test_tick &&
 	git commit --allow-empty -m "empty"
@@ -28,7 +28,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick an empty commit' '
-	git checkout master &&
+	git checkout main &&
 	test_expect_code 1 git cherry-pick empty-change-branch
 '
 
@@ -38,7 +38,7 @@ test_expect_success 'index lockfile was removed' '
 
 test_expect_success 'cherry-pick a commit with an empty message' '
 	test_when_finished "git reset --hard empty-message-branch~1" &&
-	git checkout master &&
+	git checkout main &&
 	git cherry-pick empty-message-branch
 '
 
@@ -47,12 +47,12 @@ test_expect_success 'index lockfile was removed' '
 '
 
 test_expect_success 'cherry-pick a commit with an empty message with --allow-empty-message' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git cherry-pick --allow-empty-message empty-message-branch
 '
 
 test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
-	git checkout master &&
+	git checkout main &&
 	echo fourth >>file2 &&
 	git add file2 &&
 	git commit -m "fourth" &&
@@ -60,22 +60,22 @@ test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
 '
 
 test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
-	git checkout master &&
+	git checkout main &&
 	git cherry-pick --allow-empty empty-change-branch
 '
 
 test_expect_success 'cherry pick with --keep-redundant-commits' '
-	git checkout master &&
+	git checkout main &&
 	git cherry-pick --keep-redundant-commits HEAD^
 '
 
 test_expect_success 'cherry-pick a commit that becomes no-op (prep)' '
-	git checkout master &&
+	git checkout main &&
 	git branch fork &&
 	echo foo >file2 &&
 	git add file2 &&
 	test_tick &&
-	git commit -m "add file2 on master" &&
+	git commit -m "add file2 on main" &&
 
 	git checkout fork &&
 	echo foo >file2 &&
@@ -87,15 +87,15 @@ test_expect_success 'cherry-pick a commit that becomes no-op (prep)' '
 test_expect_success 'cherry-pick a no-op without --keep-redundant' '
 	git reset --hard &&
 	git checkout fork^0 &&
-	test_must_fail git cherry-pick master
+	test_must_fail git cherry-pick main
 '
 
 test_expect_success 'cherry-pick a no-op with --keep-redundant' '
 	git reset --hard &&
 	git checkout fork^0 &&
-	git cherry-pick --keep-redundant-commits master &&
+	git cherry-pick --keep-redundant-commits main &&
 	git show -s --format=%s >actual &&
-	echo "add file2 on master" >expect &&
+	echo "add file2 on main" >expect &&
 	test_cmp expect actual
 '
 
diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index a105a782f6..7e11bd4a4c 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -2,7 +2,7 @@
 
 test_description='test cherry-picking with --ff option'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -27,7 +27,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick using --ff fast forwards' '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick --ff second &&
@@ -35,7 +35,7 @@ test_expect_success 'cherry-pick using --ff fast forwards' '
 '
 
 test_expect_success 'cherry-pick not using --ff does not fast forwards' '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick second &&
@@ -52,7 +52,7 @@ test_expect_success 'cherry-pick not using --ff does not fast forwards' '
 # (This has been taken from t3502-cherry-pick-merge.sh)
 #
 test_expect_success 'merge setup' '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard first &&
 	echo new line >A &&
 	git add A &&
@@ -65,7 +65,7 @@ test_expect_success 'merge setup' '
 	test_tick &&
 	git commit -m "add line to B" B &&
 	git tag B &&
-	git checkout master &&
+	git checkout main &&
 	git merge side &&
 	git tag C &&
 	git checkout -b new A
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index e94264e578..5f4564c830 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -9,7 +9,7 @@ test_description='test cherry-pick and revert with conflicts
 
 '
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -32,7 +32,7 @@ test_expect_success setup '
 	test_commit redundant-pick foo c redundant &&
 	git commit --allow-empty --allow-empty-message &&
 	git tag empty &&
-	git checkout master &&
+	git checkout main &&
 	git config advice.detachedhead false
 
 '
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index b967bf0639..ec7a2c9fcf 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -2,7 +2,7 @@
 
 test_description='test cherry-picking many commits'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -34,7 +34,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick first..fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick first..fourth &&
@@ -48,7 +48,7 @@ test_expect_success 'cherry-pick three one two works' '
 	test_commit one &&
 	test_commit two &&
 	test_commit three &&
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	git cherry-pick three one two &&
 	git diff --quiet three &&
@@ -59,28 +59,28 @@ two"
 '
 
 test_expect_success 'cherry-pick three one two: fails' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_must_fail git cherry-pick three one two:
 '
 
 test_expect_success 'output to keep user entertained during multi-pick' '
 	cat <<-\EOF >expected &&
-	[master OBJID] second
+	[main OBJID] second
 	 Author: A U Thor <author@example.com>
 	 Date: Thu Apr 7 15:14:13 2005 -0700
 	 1 file changed, 1 insertion(+)
-	[master OBJID] third
+	[main OBJID] third
 	 Author: A U Thor <author@example.com>
 	 Date: Thu Apr 7 15:15:13 2005 -0700
 	 1 file changed, 1 insertion(+)
-	[master OBJID] fourth
+	[main OBJID] fourth
 	 Author: A U Thor <author@example.com>
 	 Date: Thu Apr 7 15:16:13 2005 -0700
 	 1 file changed, 1 insertion(+)
 	EOF
 
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick first..fourth >actual &&
@@ -90,7 +90,7 @@ test_expect_success 'output to keep user entertained during multi-pick' '
 '
 
 test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick --strategy resolve first..fourth &&
@@ -102,23 +102,23 @@ test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
 test_expect_success 'output during multi-pick indicates merge strategy' '
 	cat <<-\EOF >expected &&
 	Trying simple merge.
-	[master OBJID] second
+	[main OBJID] second
 	 Author: A U Thor <author@example.com>
 	 Date: Thu Apr 7 15:14:13 2005 -0700
 	 1 file changed, 1 insertion(+)
 	Trying simple merge.
-	[master OBJID] third
+	[main OBJID] third
 	 Author: A U Thor <author@example.com>
 	 Date: Thu Apr 7 15:15:13 2005 -0700
 	 1 file changed, 1 insertion(+)
 	Trying simple merge.
-	[master OBJID] fourth
+	[main OBJID] fourth
 	 Author: A U Thor <author@example.com>
 	 Date: Thu Apr 7 15:16:13 2005 -0700
 	 1 file changed, 1 insertion(+)
 	EOF
 
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick --strategy resolve first..fourth >actual &&
@@ -127,7 +127,7 @@ test_expect_success 'output during multi-pick indicates merge strategy' '
 '
 
 test_expect_success 'cherry-pick --ff first..fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick --ff first..fourth &&
@@ -137,7 +137,7 @@ test_expect_success 'cherry-pick --ff first..fourth works' '
 '
 
 test_expect_success 'cherry-pick -n first..fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick -n first..fourth &&
@@ -147,7 +147,7 @@ test_expect_success 'cherry-pick -n first..fourth works' '
 '
 
 test_expect_success 'revert first..fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard fourth &&
 	test_tick &&
 	git revert first..fourth &&
@@ -157,7 +157,7 @@ test_expect_success 'revert first..fourth works' '
 '
 
 test_expect_success 'revert ^first fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard fourth &&
 	test_tick &&
 	git revert ^first fourth &&
@@ -167,7 +167,7 @@ test_expect_success 'revert ^first fourth works' '
 '
 
 test_expect_success 'revert fourth fourth~1 fourth~2 works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard fourth &&
 	test_tick &&
 	git revert fourth fourth~1 fourth~2 &&
@@ -177,7 +177,7 @@ test_expect_success 'revert fourth fourth~1 fourth~2 works' '
 '
 
 test_expect_success 'cherry-pick -3 fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick -3 fourth &&
@@ -187,7 +187,7 @@ test_expect_success 'cherry-pick -3 fourth works' '
 '
 
 test_expect_success 'cherry-pick --stdin works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git rev-list --reverse first..fourth | git cherry-pick --stdin &&
diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index 83cab7b2ed..f4159246e1 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='Test cherry-pick with directory/file conflicts'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -31,7 +31,7 @@ test_expect_success 'Setup rename across paths each below D/F conflicts' '
 
 test_expect_success 'Cherry-pick succeeds with rename across D/F conflicts' '
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	git cherry-pick branch
 '
 
diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index ff33c6d5c9..822f2d4bfb 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -2,7 +2,7 @@
 
 test_description='cherry-pick can handle submodules'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -38,7 +38,7 @@ test_expect_success 'unrelated submodule/file conflict is ignored' '
 		git add a_file &&
 		git commit -m "modify a file" &&
 
-		git checkout master &&
+		git checkout main &&
 
 		git submodule add ../sub sub &&
 		git submodule update sub &&
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 3baa64bf99..dff1228669 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -5,7 +5,7 @@
 
 test_description='Test of the various options to git rm.'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -486,16 +486,16 @@ test_expect_success 'setup submodule conflict' '
 	echo 1 >nitfol &&
 	git add nitfol &&
 	git commit -m "added nitfol 1" &&
-	git checkout -b branch2 master &&
+	git checkout -b branch2 main &&
 	echo 2 >nitfol &&
 	git add nitfol &&
 	git commit -m "added nitfol 2" &&
-	git checkout -b conflict1 master &&
+	git checkout -b conflict1 main &&
 	git -C submod fetch &&
 	git -C submod checkout branch1 &&
 	git add submod &&
 	git commit -m "submod 1" &&
-	git checkout -b conflict2 master &&
+	git checkout -b conflict2 main &&
 	git -C submod checkout branch2 &&
 	git add submod &&
 	git commit -m "submod 2"
@@ -607,7 +607,7 @@ test_expect_success 'rm of a conflicted unpopulated submodule succeeds' '
 '
 
 test_expect_success 'rm of a populated submodule with a .git directory migrates git dir' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard &&
 	git submodule update &&
 	(
@@ -720,7 +720,7 @@ test_expect_success 'checking out a commit after submodule removal needs manual
 	git checkout HEAD^ &&
 	git submodule update &&
 	git checkout -q HEAD^ &&
-	git checkout -q master 2>actual &&
+	git checkout -q main 2>actual &&
 	test_i18ngrep "^warning: unable to rmdir '\''submod'\'':" actual &&
 	git status -s submod >actual &&
 	echo "?? submod/" >expected &&
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 9be7527531..8c7f23cc53 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='add -i basic tests'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -552,8 +552,8 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	test_commit non-conflict &&
 	git checkout -b side &&
 	test_commit side conflict.t &&
-	git checkout master &&
-	test_commit master conflict.t &&
+	git checkout main &&
+	test_commit main conflict.t &&
 	test_must_fail git merge side &&
 	echo changed >non-conflict.t &&
 	echo y | git add -p >output &&
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index bde27227b6..4f16a735d9 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -5,7 +5,7 @@
 
 test_description='i18n settings and format-patch | am pipe'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -48,7 +48,7 @@ test_expect_success setup '
 
 	# the first commit on the side branch is UTF-8
 	test_tick &&
-	git checkout -b side master^ &&
+	git checkout -b side main^ &&
 	echo Another file >yours &&
 	git add yours &&
 	git commit -s -m "Second on side" &&
@@ -72,7 +72,7 @@ test_expect_success setup '
 test_expect_success 'format-patch output (ISO-8859-1)' '
 	git config i18n.logoutputencoding ISO8859-1 &&
 
-	git format-patch --stdout master..HEAD^ >out-l1 &&
+	git format-patch --stdout main..HEAD^ >out-l1 &&
 	git format-patch --stdout HEAD^ >out-l2 &&
 	grep "^Content-Type: text/plain; charset=ISO8859-1" out-l1 &&
 	grep "^From: =?ISO8859-1?q?=C1=E9=ED=20=F3=FA?=" out-l1 &&
@@ -83,7 +83,7 @@ test_expect_success 'format-patch output (ISO-8859-1)' '
 test_expect_success 'format-patch output (UTF-8)' '
 	git config i18n.logoutputencoding UTF-8 &&
 
-	git format-patch --stdout master..HEAD^ >out-u1 &&
+	git format-patch --stdout main..HEAD^ >out-u1 &&
 	git format-patch --stdout HEAD^ >out-u2 &&
 	grep "^Content-Type: text/plain; charset=UTF-8" out-u1 &&
 	grep "^From: =?UTF-8?q?=C3=81=C3=A9=C3=AD=20=C3=B3=C3=BA?=" out-u1 &&
@@ -105,7 +105,7 @@ test_expect_success 'rebase (U/U)' '
 	# we want UTF-8 encoded name.
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 	git checkout -b test &&
-	git rebase master &&
+	git rebase main &&
 
 	check_encoding 2
 '
@@ -116,7 +116,7 @@ test_expect_success 'rebase (U/L)' '
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard side &&
-	git rebase master &&
+	git rebase main &&
 
 	check_encoding 2
 '
@@ -128,7 +128,7 @@ test_expect_success !MINGW 'rebase (L/L)' '
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard side &&
-	git rebase master &&
+	git rebase main &&
 
 	check_encoding 2 8859
 '
@@ -141,7 +141,7 @@ test_expect_success !MINGW 'rebase (L/U)' '
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard side &&
-	git rebase master &&
+	git rebase main &&
 
 	check_encoding 2 8859
 '
@@ -153,7 +153,7 @@ test_expect_success 'cherry-pick(U/U)' '
 	git config i18n.logoutputencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
 	git revert HEAD &&
@@ -168,7 +168,7 @@ test_expect_success !MINGW 'cherry-pick(L/L)' '
 	git config i18n.logoutputencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
 	git revert HEAD &&
@@ -183,7 +183,7 @@ test_expect_success 'cherry-pick(U/L)' '
 	git config i18n.logoutputencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
 	git revert HEAD &&
@@ -199,7 +199,7 @@ test_expect_success !MINGW 'cherry-pick(L/U)' '
 	git config i18n.logoutputencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
 	git revert HEAD &&
@@ -213,7 +213,7 @@ test_expect_success 'rebase --merge (U/U)' '
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard side &&
-	git rebase --merge master &&
+	git rebase --merge main &&
 
 	check_encoding 2
 '
@@ -224,7 +224,7 @@ test_expect_success 'rebase --merge (U/L)' '
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard side &&
-	git rebase --merge master &&
+	git rebase --merge main &&
 
 	check_encoding 2
 '
@@ -236,7 +236,7 @@ test_expect_success 'rebase --merge (L/L)' '
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard side &&
-	git rebase --merge master &&
+	git rebase --merge main &&
 
 	check_encoding 2 8859
 '
@@ -249,7 +249,7 @@ test_expect_success 'rebase --merge (L/U)' '
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard side &&
-	git rebase --merge master &&
+	git rebase --merge main &&
 
 	check_encoding 2 8859
 '
@@ -259,7 +259,7 @@ test_expect_success 'am (U/U)' '
 	git config i18n.commitencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git am out-u1 out-u2 &&
 
 	check_encoding 2
@@ -270,7 +270,7 @@ test_expect_success !MINGW 'am (L/L)' '
 	git config i18n.commitencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git am out-l1 out-l2 &&
 
 	check_encoding 2 8859
@@ -280,7 +280,7 @@ test_expect_success 'am (U/L)' '
 	# Apply ISO-8859-1 patches with UTF-8 commitencoding
 	git config i18n.commitencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
-	git reset --hard master &&
+	git reset --hard main &&
 
 	# am specifies --utf8 by default.
 	git am out-l1 out-l2 &&
@@ -293,7 +293,7 @@ test_expect_success 'am --no-utf8 (U/L)' '
 	git config i18n.commitencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git am --no-utf8 out-l1 out-l2 2>err &&
 
 	# commit-tree will warn that the commit message does not contain valid UTF-8
@@ -308,7 +308,7 @@ test_expect_success !MINGW 'am (L/U)' '
 	git config i18n.commitencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	# mailinfo will re-code the commit message to the charset specified by
 	# i18n.commitencoding
 	git am out-u1 out-u2 &&
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 49d52c46ad..84b039e573 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -5,7 +5,7 @@
 
 test_description='Test git stash'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -223,14 +223,14 @@ test_expect_success 'stash branch' '
 	git commit file -m second &&
 	git stash branch stashbranch &&
 	test refs/heads/stashbranch = $(git symbolic-ref HEAD) &&
-	test $(git rev-parse HEAD) = $(git rev-parse master^) &&
+	test $(git rev-parse HEAD) = $(git rev-parse main^) &&
 	git diff --cached >output &&
 	diff_cmp expect output &&
 	git diff >output &&
 	diff_cmp expect1 output &&
 	git add file &&
 	git commit -m alternate\ second &&
-	git diff master..stashbranch >output &&
+	git diff main..stashbranch >output &&
 	diff_cmp output expect2 &&
 	test 0 = $(git stash list | wc -l)
 '
@@ -523,7 +523,7 @@ test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	git stash branch stash-branch ${STASH_ID} &&
-	test_when_finished "git reset --hard HEAD && git checkout master &&
+	test_when_finished "git reset --hard HEAD && git checkout main &&
 	git branch -D stash-branch" &&
 	test $(git ls-files --modified | wc -l) -eq 1
 '
@@ -539,7 +539,7 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	git stash branch stash-branch ${STASH_ID} &&
-	test_when_finished "git reset --hard HEAD && git checkout master &&
+	test_when_finished "git reset --hard HEAD && git checkout main &&
 	git branch -D stash-branch" &&
 	test $(git ls-files --modified | wc -l) -eq 1
 '
@@ -741,7 +741,7 @@ test_expect_success 'valid ref of the form "n", n < N' '
 	git stash &&
 	git stash show 0 &&
 	git stash branch tmp 0 &&
-	git checkout master &&
+	git checkout main &&
 	git stash &&
 	git stash apply 0 &&
 	git reset --hard &&
@@ -758,7 +758,7 @@ test_expect_success 'branch: do not drop the stash if the branch exists' '
 	git commit -m initial &&
 	echo bar >file &&
 	git stash &&
-	test_must_fail git stash branch master stash@{0} &&
+	test_must_fail git stash branch main stash@{0} &&
 	git rev-parse stash@{0} --
 '
 
@@ -771,7 +771,7 @@ test_expect_success 'branch: should not drop the stash if the apply fails' '
 	echo bar >file &&
 	git stash &&
 	echo baz >file &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	test_must_fail git stash branch new_branch stash@{0} &&
 	git rev-parse stash@{0} --
 '
@@ -905,7 +905,7 @@ test_expect_success 'push -m shows right message' '
 	>foo &&
 	git add foo &&
 	git stash push -m "test message" &&
-	echo "stash@{0}: On master: test message" >expect &&
+	echo "stash@{0}: On main: test message" >expect &&
 	git stash list -1 >actual &&
 	test_cmp expect actual
 '
@@ -914,7 +914,7 @@ test_expect_success 'push -m also works without space' '
 	>foo &&
 	git add foo &&
 	git stash push -m"unspaced test message" &&
-	echo "stash@{0}: On master: unspaced test message" >expect &&
+	echo "stash@{0}: On main: unspaced test message" >expect &&
 	git stash list -1 >actual &&
 	test_cmp expect actual
 '
@@ -971,7 +971,7 @@ test_expect_success 'push -mfoo uses right message' '
 	>foo &&
 	git add foo &&
 	git stash push -m"test mfoo" &&
-	echo "stash@{0}: On master: test mfoo" >expect &&
+	echo "stash@{0}: On main: test mfoo" >expect &&
 	git stash list -1 >actual &&
 	test_cmp expect actual
 '
@@ -980,7 +980,7 @@ test_expect_success 'push --message foo is synonym for -mfoo' '
 	>foo &&
 	git add foo &&
 	git stash push --message "test message foo" &&
-	echo "stash@{0}: On master: test message foo" >expect &&
+	echo "stash@{0}: On main: test message foo" >expect &&
 	git stash list -1 >actual &&
 	test_cmp expect actual
 '
@@ -989,7 +989,7 @@ test_expect_success 'push --message=foo is synonym for -mfoo' '
 	>foo &&
 	git add foo &&
 	git stash push --message="test message=foo" &&
-	echo "stash@{0}: On master: test message=foo" >expect &&
+	echo "stash@{0}: On main: test message=foo" >expect &&
 	git stash list -1 >actual &&
 	test_cmp expect actual
 '
@@ -998,7 +998,7 @@ test_expect_success 'push -m shows right message' '
 	>foo &&
 	git add foo &&
 	git stash push -m "test m foo" &&
-	echo "stash@{0}: On master: test m foo" >expect &&
+	echo "stash@{0}: On main: test m foo" >expect &&
 	git stash list -1 >actual &&
 	test_cmp expect actual
 '
@@ -1007,7 +1007,7 @@ test_expect_success 'create stores correct message' '
 	>foo &&
 	git add foo &&
 	STASH_ID=$(git stash create "create test message") &&
-	echo "On master: create test message" >expect &&
+	echo "On main: create test message" >expect &&
 	git show --pretty=%s -s ${STASH_ID} >actual &&
 	test_cmp expect actual
 '
@@ -1016,13 +1016,13 @@ test_expect_success 'create with multiple arguments for the message' '
 	>foo &&
 	git add foo &&
 	STASH_ID=$(git stash create test untracked) &&
-	echo "On master: test untracked" >expect &&
+	echo "On main: test untracked" >expect &&
 	git show --pretty=%s -s ${STASH_ID} >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'create in a detached state' '
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	git checkout HEAD~1 &&
 	>foo &&
 	git add foo &&
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index a2d1cdec6d..a0b9208ce8 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -5,7 +5,7 @@
 
 test_description='utf-8 decomposed (nfd) converted to precomposed (nfc)'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -154,7 +154,7 @@ test_expect_success "git checkout link nfd" '
 	git checkout l.$Odiarnfd
 '
 test_expect_success "setup case mac2" '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard &&
 	git checkout -b mac_os_2
 '
@@ -166,7 +166,7 @@ test_expect_success "commit file d2.Adiarnfd/f.Adiarnfd" '
 	git commit -m "add d2.$Adiarnfd/f.$Adiarnfd" -- d2.$Adiarnfd/f.$Adiarnfd
 '
 test_expect_success "setup for long decomposed filename" '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard &&
 	git checkout -b mac_os_long_nfd_fn
 '
@@ -176,7 +176,7 @@ test_expect_success "Add long decomposed filename" '
 	git commit -m "Long filename"
 '
 test_expect_success "setup for long precomposed filename" '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard &&
 	git checkout -b mac_os_long_nfc_fn
 '
-- 
gitgitgadget

