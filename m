Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0848C2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B3120825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3MccH4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgKLWoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgKLWoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:09 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8156CC0613D6
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:08 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d12so7652646wrr.13
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5vXD7GOeLAtXQHQwcrKc12mhkG8vErZHPUZH7Ag6D8Q=;
        b=M3MccH4NEPIy9sl35DRU2LgGVGoAC1wpU37DUMFgwEadElo+QgK+9fzLPJBBv2Wkdt
         Wn6qsaf1/VVUixyd7j480sXJ4enNC+XH3IySejRqLvRUBd+yCsf0DwlcY0x04KS0H56P
         6af48oMLnZccHiOQ4nv/U7MvORYSqmhAAQdsSioA6TQmvMvMmHORQ0EZZNSbiTRFkz35
         fyCkdk9cNDJs71OFVV+b6E/nWw9kH5E7FZADWsX75fF4hWDx2BLAxVdepZxZuCqD1+yv
         c3LvQnS7PfaWOYHVdC4MVbg80YgHnrPljC5L/fC9mvUG4qw8NMhCRRro0374eUJrkF3F
         lR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5vXD7GOeLAtXQHQwcrKc12mhkG8vErZHPUZH7Ag6D8Q=;
        b=c7mlelgvZrWE81PeA69GiRvOgV3iBHjQXJ4ZYc8yYkMrl8fz706255qT0Dn1W1SkWT
         HDltZMy1/z7D3tKO8595kj0IVpaXCqV5Aj5KpU06sZ5YphU6ijoGZHFrw0M6DThcutwn
         KBq0lAe7mzCIxyeNJI0EmNPTRPTx0XPsoA5F6niU9mmSXWbVthnLNQZJPMl0oMKaIy+W
         gPbfvC3UlGje+A3mSBQFhtZ6fOa3Ly3jzqLyS7ZomKgk6W5Y3qWygAPX8xv64pmJjj6c
         QY5a9DAA+gtZ5VBM07IsHahombo6dQeqsPq12/czYFKs0Ux6WUTtSnFmYw3hEqcpPywq
         WRXQ==
X-Gm-Message-State: AOAM532WVBHMB0X4x7gUO7j8xVZzpBXVvxOGYl6bvwVChYhSMaWAs9P8
        IkSg3z9HdM71hiCcxVlbT6sknvBp10U=
X-Google-Smtp-Source: ABdhPJz8KPLNwyAPfucbcq6vZ2AqfrUg+f1jNR+O65SW7LvxQj/WHwNWy13xOPogzmLqrTYBFYPtjQ==
X-Received: by 2002:adf:fec5:: with SMTP id q5mr2057998wrs.245.1605221046586;
        Thu, 12 Nov 2020 14:44:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm7638209wmn.19.2020.11.12.14.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:06 -0800 (PST)
Message-Id: <7a9349653dda0723b11484a9923e58fba11f254c.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:37 +0000
Subject: [PATCH 07/28] t3[5-9]*: adjust the references to the default branch
 name "main"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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
 t/t3500-cherry.sh                   | 12 ++++-----
 t/t3501-revert-cherry-pick.sh       |  4 +--
 t/t3502-cherry-pick-merge.sh        |  2 +-
 t/t3503-cherry-pick-root.sh         | 10 ++++----
 t/t3504-cherry-pick-rerere.sh       | 24 ++++++++---------
 t/t3505-cherry-pick-empty.sh        | 24 ++++++++---------
 t/t3506-cherry-pick-ff.sh           |  8 +++---
 t/t3507-cherry-pick-conflict.sh     |  2 +-
 t/t3508-cherry-pick-many-commits.sh | 38 +++++++++++++--------------
 t/t3509-cherry-pick-merge-df.sh     |  2 +-
 t/t3512-cherry-pick-submodule.sh    |  2 +-
 t/t3600-rm.sh                       | 10 ++++----
 t/t3701-add-interactive.sh          |  4 +--
 t/t3901-i18n-patch.sh               | 40 ++++++++++++++---------------
 t/t3903-stash.sh                    | 32 +++++++++++------------
 t/t3910-mac-os-precompose.sh        |  6 ++---
 t/test-lib.sh                       |  2 +-
 17 files changed, 111 insertions(+), 111 deletions(-)

diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index 2b8d9cb38e..2528e773a6 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -5,7 +5,7 @@
 
 test_description='git cherry should detect patches integrated upstream
 
-This test cherry-picks one local change of two into master branch, and
+This test cherry-picks one local change of two into main branch, and
 checks that git cherry only returns the second patch in the local branch
 '
 . ./test-lib.sh
@@ -32,7 +32,7 @@ test_expect_success \
      test_tick &&
      git commit -m "Add C." &&
 
-     git checkout -f master &&
+     git checkout -f main &&
      rm -f B C &&
 
      echo Third >> A &&
@@ -40,19 +40,19 @@ test_expect_success \
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
index 3669dfb1be..0adfdb4b6c 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -112,7 +112,7 @@ test_expect_success 'cherry-pick on unborn branch' '
 test_expect_success 'cherry-pick "-" to pick from previous branch' '
 	git checkout unborn &&
 	test_commit to-pick actual content &&
-	git checkout master &&
+	git checkout main &&
 	git cherry-pick - &&
 	echo content >expect &&
 	test_cmp expect actual
@@ -132,7 +132,7 @@ test_expect_success 'cherry-pick "-" is meaningless without checkout' '
 test_expect_success 'cherry-pick "-" works with arguments' '
 	git checkout -b side-branch &&
 	test_commit change actual change &&
-	git checkout master &&
+	git checkout main &&
 	git cherry-pick -s - &&
 	echo "Signed-off-by: C O Mitter <committer@example.com>" >expect &&
 	git cat-file commit HEAD | grep ^Signed-off-by: >signoff &&
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 8b635a196d..4d6ff14eb6 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 	echo new line >B &&
 	git commit -m "add line to B" B &&
 	git tag b &&
-	git checkout master &&
+	git checkout main &&
 	git merge side &&
 	git tag c
 
diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index e27f39d1e5..59496a56b7 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -30,7 +30,7 @@ test_expect_success setup '
 test_expect_success 'cherry-pick a root commit' '
 
 	git checkout second^0 &&
-	git cherry-pick master &&
+	git cherry-pick main &&
 	echo first >expect &&
 	test_cmp expect file1
 
@@ -38,14 +38,14 @@ test_expect_success 'cherry-pick a root commit' '
 
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
 
@@ -53,7 +53,7 @@ test_expect_success 'cherry-pick a root commit with an external strategy' '
 
 test_expect_success 'revert a root commit with an external strategy' '
 
-	git revert --strategy=resolve master &&
+	git revert --strategy=resolve main &&
 	test_path_is_missing file1
 
 '
@@ -65,7 +65,7 @@ test_expect_success 'cherry-pick two root commits' '
 	echo third >expect.file3 &&
 
 	git checkout second^0 &&
-	git cherry-pick master third &&
+	git cherry-pick main third &&
 
 	test_cmp expect.file1 file1 &&
 	test_cmp expect.file2 file2 &&
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index 80a0d08706..3804527e2e 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -6,8 +6,8 @@ test_description='cherry-pick should rerere for conflicts'
 
 test_expect_success setup '
 	test_commit foo &&
-	test_commit foo-master foo &&
-	test_commit bar-master bar &&
+	test_commit foo-main foo &&
+	test_commit bar-main bar &&
 
 	git checkout -b dev foo &&
 	test_commit foo-dev foo &&
@@ -16,7 +16,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'conflicting merge' '
-	test_must_fail git merge master
+	test_must_fail git merge main
 '
 
 test_expect_success 'fixup' '
@@ -29,7 +29,7 @@ test_expect_success 'fixup' '
 '
 
 test_expect_success 'cherry-pick conflict with --rerere-autoupdate' '
-	test_must_fail git cherry-pick --rerere-autoupdate foo..bar-master &&
+	test_must_fail git cherry-pick --rerere-autoupdate foo..bar-main &&
 	test_cmp foo-expect foo &&
 	git diff-files --quiet &&
 	test_must_fail git cherry-pick --continue &&
@@ -41,7 +41,7 @@ test_expect_success 'cherry-pick conflict with --rerere-autoupdate' '
 
 test_expect_success 'cherry-pick conflict repsects rerere.autoUpdate' '
 	test_config rerere.autoUpdate true &&
-	test_must_fail git cherry-pick foo..bar-master &&
+	test_must_fail git cherry-pick foo..bar-main &&
 	test_cmp foo-expect foo &&
 	git diff-files --quiet &&
 	test_must_fail git cherry-pick --continue &&
@@ -53,7 +53,7 @@ test_expect_success 'cherry-pick conflict repsects rerere.autoUpdate' '
 
 test_expect_success 'cherry-pick conflict with --no-rerere-autoupdate' '
 	test_config rerere.autoUpdate true &&
-	test_must_fail git cherry-pick --no-rerere-autoupdate foo..bar-master &&
+	test_must_fail git cherry-pick --no-rerere-autoupdate foo..bar-main &&
 	test_cmp foo-expect foo &&
 	test_must_fail git diff-files --quiet &&
 	git add foo &&
@@ -66,7 +66,7 @@ test_expect_success 'cherry-pick conflict with --no-rerere-autoupdate' '
 '
 
 test_expect_success 'cherry-pick --continue rejects --rerere-autoupdate' '
-	test_must_fail git cherry-pick --rerere-autoupdate foo..bar-master &&
+	test_must_fail git cherry-pick --rerere-autoupdate foo..bar-main &&
 	test_cmp foo-expect foo &&
 	git diff-files --quiet &&
 	test_must_fail git cherry-pick --continue --rerere-autoupdate >actual 2>&1 &&
@@ -79,25 +79,25 @@ test_expect_success 'cherry-pick --continue rejects --rerere-autoupdate' '
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
index 5f911bb529..07419a4e4a 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -17,7 +17,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit --allow-empty-message -m "" &&
 
-	git checkout master &&
+	git checkout main &&
 	git checkout -b empty-change-branch &&
 	test_tick &&
 	git commit --allow-empty -m "empty"
@@ -25,7 +25,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick an empty commit' '
-	git checkout master &&
+	git checkout main &&
 	test_expect_code 1 git cherry-pick empty-change-branch
 '
 
@@ -35,7 +35,7 @@ test_expect_success 'index lockfile was removed' '
 
 test_expect_success 'cherry-pick a commit with an empty message' '
 	test_when_finished "git reset --hard empty-message-branch~1" &&
-	git checkout master &&
+	git checkout main &&
 	git cherry-pick empty-message-branch
 '
 
@@ -44,12 +44,12 @@ test_expect_success 'index lockfile was removed' '
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
@@ -57,22 +57,22 @@ test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
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
@@ -84,15 +84,15 @@ test_expect_success 'cherry-pick a commit that becomes no-op (prep)' '
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
index 9d5adbc130..08b461dfcf 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -24,7 +24,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick using --ff fast forwards' '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick --ff second &&
@@ -32,7 +32,7 @@ test_expect_success 'cherry-pick using --ff fast forwards' '
 '
 
 test_expect_success 'cherry-pick not using --ff does not fast forwards' '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick second &&
@@ -49,7 +49,7 @@ test_expect_success 'cherry-pick not using --ff does not fast forwards' '
 # (This has been taken from t3502-cherry-pick-merge.sh)
 #
 test_expect_success 'merge setup' '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard first &&
 	echo new line >A &&
 	git add A &&
@@ -62,7 +62,7 @@ test_expect_success 'merge setup' '
 	test_tick &&
 	git commit -m "add line to B" B &&
 	git tag B &&
-	git checkout master &&
+	git checkout main &&
 	git merge side &&
 	git tag C &&
 	git checkout -b new A
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index a21adcf0e4..e0f77ba6ad 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -29,7 +29,7 @@ test_expect_success setup '
 	test_commit redundant-pick foo c redundant &&
 	git commit --allow-empty --allow-empty-message &&
 	git tag empty &&
-	git checkout master &&
+	git checkout main &&
 	git config advice.detachedhead false
 
 '
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 23070a7b73..bdb995235f 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -31,7 +31,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick first..fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick first..fourth &&
@@ -45,7 +45,7 @@ test_expect_success 'cherry-pick three one two works' '
 	test_commit one &&
 	test_commit two &&
 	test_commit three &&
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	git cherry-pick three one two &&
 	git diff --quiet three &&
@@ -56,28 +56,28 @@ two"
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
@@ -87,7 +87,7 @@ test_expect_success 'output to keep user entertained during multi-pick' '
 '
 
 test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick --strategy resolve first..fourth &&
@@ -99,23 +99,23 @@ test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
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
@@ -124,7 +124,7 @@ test_expect_success 'output during multi-pick indicates merge strategy' '
 '
 
 test_expect_success 'cherry-pick --ff first..fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick --ff first..fourth &&
@@ -134,7 +134,7 @@ test_expect_success 'cherry-pick --ff first..fourth works' '
 '
 
 test_expect_success 'cherry-pick -n first..fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick -n first..fourth &&
@@ -144,7 +144,7 @@ test_expect_success 'cherry-pick -n first..fourth works' '
 '
 
 test_expect_success 'revert first..fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard fourth &&
 	test_tick &&
 	git revert first..fourth &&
@@ -154,7 +154,7 @@ test_expect_success 'revert first..fourth works' '
 '
 
 test_expect_success 'revert ^first fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard fourth &&
 	test_tick &&
 	git revert ^first fourth &&
@@ -164,7 +164,7 @@ test_expect_success 'revert ^first fourth works' '
 '
 
 test_expect_success 'revert fourth fourth~1 fourth~2 works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard fourth &&
 	test_tick &&
 	git revert fourth fourth~1 fourth~2 &&
@@ -174,7 +174,7 @@ test_expect_success 'revert fourth fourth~1 fourth~2 works' '
 '
 
 test_expect_success 'cherry-pick -3 fourth works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick -3 fourth &&
@@ -184,7 +184,7 @@ test_expect_success 'cherry-pick -3 fourth works' '
 '
 
 test_expect_success 'cherry-pick --stdin works' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard first &&
 	test_tick &&
 	git rev-list --reverse first..fourth | git cherry-pick --stdin &&
diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index 1e5b3948df..dfc5e9f914 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -28,7 +28,7 @@ test_expect_success 'Setup rename across paths each below D/F conflicts' '
 
 test_expect_success 'Cherry-pick succeeds with rename across D/F conflicts' '
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	git cherry-pick branch
 '
 
diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index 6ece1d8573..ec09d7d8a8 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -35,7 +35,7 @@ test_expect_success 'unrelated submodule/file conflict is ignored' '
 		git add a_file &&
 		git commit -m "modify a file" &&
 
-		git checkout master &&
+		git checkout main &&
 
 		git submodule add ../sub sub &&
 		git submodule update sub &&
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index efec8d13b6..243087d9c6 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -483,16 +483,16 @@ test_expect_success 'setup submodule conflict' '
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
@@ -604,7 +604,7 @@ test_expect_success 'rm of a conflicted unpopulated submodule succeeds' '
 '
 
 test_expect_success 'rm of a populated submodule with a .git directory migrates git dir' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard &&
 	git submodule update &&
 	(
@@ -717,7 +717,7 @@ test_expect_success 'checking out a commit after submodule removal needs manual
 	git checkout HEAD^ &&
 	git submodule update &&
 	git checkout -q HEAD^ &&
-	git checkout -q master 2>actual &&
+	git checkout -q main 2>actual &&
 	test_i18ngrep "^warning: unable to rmdir '\''submod'\'':" actual &&
 	git status -s submod >actual &&
 	echo "?? submod/" >expected &&
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index ca04fac417..4abaa9be02 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -549,8 +549,8 @@ test_expect_success 'patch mode ignores unmerged entries' '
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
index 923eb01f0e..6a96959e06 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -45,7 +45,7 @@ test_expect_success setup '
 
 	# the first commit on the side branch is UTF-8
 	test_tick &&
-	git checkout -b side master^ &&
+	git checkout -b side main^ &&
 	echo Another file >yours &&
 	git add yours &&
 	git commit -s -m "Second on side" &&
@@ -69,7 +69,7 @@ test_expect_success setup '
 test_expect_success 'format-patch output (ISO-8859-1)' '
 	git config i18n.logoutputencoding ISO8859-1 &&
 
-	git format-patch --stdout master..HEAD^ >out-l1 &&
+	git format-patch --stdout main..HEAD^ >out-l1 &&
 	git format-patch --stdout HEAD^ >out-l2 &&
 	grep "^Content-Type: text/plain; charset=ISO8859-1" out-l1 &&
 	grep "^From: =?ISO8859-1?q?=C1=E9=ED=20=F3=FA?=" out-l1 &&
@@ -80,7 +80,7 @@ test_expect_success 'format-patch output (ISO-8859-1)' '
 test_expect_success 'format-patch output (UTF-8)' '
 	git config i18n.logoutputencoding UTF-8 &&
 
-	git format-patch --stdout master..HEAD^ >out-u1 &&
+	git format-patch --stdout main..HEAD^ >out-u1 &&
 	git format-patch --stdout HEAD^ >out-u2 &&
 	grep "^Content-Type: text/plain; charset=UTF-8" out-u1 &&
 	grep "^From: =?UTF-8?q?=C3=81=C3=A9=C3=AD=20=C3=B3=C3=BA?=" out-u1 &&
@@ -102,7 +102,7 @@ test_expect_success 'rebase (U/U)' '
 	# we want UTF-8 encoded name.
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 	git checkout -b test &&
-	git rebase master &&
+	git rebase main &&
 
 	check_encoding 2
 '
@@ -113,7 +113,7 @@ test_expect_success 'rebase (U/L)' '
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard side &&
-	git rebase master &&
+	git rebase main &&
 
 	check_encoding 2
 '
@@ -125,7 +125,7 @@ test_expect_success !MINGW 'rebase (L/L)' '
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard side &&
-	git rebase master &&
+	git rebase main &&
 
 	check_encoding 2 8859
 '
@@ -138,7 +138,7 @@ test_expect_success !MINGW 'rebase (L/U)' '
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard side &&
-	git rebase master &&
+	git rebase main &&
 
 	check_encoding 2 8859
 '
@@ -150,7 +150,7 @@ test_expect_success 'cherry-pick(U/U)' '
 	git config i18n.logoutputencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
 	git revert HEAD &&
@@ -165,7 +165,7 @@ test_expect_success !MINGW 'cherry-pick(L/L)' '
 	git config i18n.logoutputencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
 	git revert HEAD &&
@@ -180,7 +180,7 @@ test_expect_success 'cherry-pick(U/L)' '
 	git config i18n.logoutputencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
 	git revert HEAD &&
@@ -196,7 +196,7 @@ test_expect_success !MINGW 'cherry-pick(L/U)' '
 	git config i18n.logoutputencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
 	git revert HEAD &&
@@ -210,7 +210,7 @@ test_expect_success 'rebase --merge (U/U)' '
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard side &&
-	git rebase --merge master &&
+	git rebase --merge main &&
 
 	check_encoding 2
 '
@@ -221,7 +221,7 @@ test_expect_success 'rebase --merge (U/L)' '
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard side &&
-	git rebase --merge master &&
+	git rebase --merge main &&
 
 	check_encoding 2
 '
@@ -233,7 +233,7 @@ test_expect_success 'rebase --merge (L/L)' '
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard side &&
-	git rebase --merge master &&
+	git rebase --merge main &&
 
 	check_encoding 2 8859
 '
@@ -246,7 +246,7 @@ test_expect_success 'rebase --merge (L/U)' '
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard side &&
-	git rebase --merge master &&
+	git rebase --merge main &&
 
 	check_encoding 2 8859
 '
@@ -256,7 +256,7 @@ test_expect_success 'am (U/U)' '
 	git config i18n.commitencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git am out-u1 out-u2 &&
 
 	check_encoding 2
@@ -267,7 +267,7 @@ test_expect_success !MINGW 'am (L/L)' '
 	git config i18n.commitencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git am out-l1 out-l2 &&
 
 	check_encoding 2 8859
@@ -277,7 +277,7 @@ test_expect_success 'am (U/L)' '
 	# Apply ISO-8859-1 patches with UTF-8 commitencoding
 	git config i18n.commitencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
-	git reset --hard master &&
+	git reset --hard main &&
 
 	# am specifies --utf8 by default.
 	git am out-l1 out-l2 &&
@@ -290,7 +290,7 @@ test_expect_success 'am --no-utf8 (U/L)' '
 	git config i18n.commitencoding UTF-8 &&
 	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git am --no-utf8 out-l1 out-l2 2>err &&
 
 	# commit-tree will warn that the commit message does not contain valid UTF-8
@@ -305,7 +305,7 @@ test_expect_success !MINGW 'am (L/U)' '
 	git config i18n.commitencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	# mailinfo will re-code the commit message to the charset specified by
 	# i18n.commitencoding
 	git am out-u1 out-u2 &&
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 9f7ca98967..97374f393a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -220,14 +220,14 @@ test_expect_success 'stash branch' '
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
@@ -520,7 +520,7 @@ test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	git stash branch stash-branch ${STASH_ID} &&
-	test_when_finished "git reset --hard HEAD && git checkout master &&
+	test_when_finished "git reset --hard HEAD && git checkout main &&
 	git branch -D stash-branch" &&
 	test $(git ls-files --modified | wc -l) -eq 1
 '
@@ -536,7 +536,7 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	git stash branch stash-branch ${STASH_ID} &&
-	test_when_finished "git reset --hard HEAD && git checkout master &&
+	test_when_finished "git reset --hard HEAD && git checkout main &&
 	git branch -D stash-branch" &&
 	test $(git ls-files --modified | wc -l) -eq 1
 '
@@ -738,7 +738,7 @@ test_expect_success 'valid ref of the form "n", n < N' '
 	git stash &&
 	git stash show 0 &&
 	git stash branch tmp 0 &&
-	git checkout master &&
+	git checkout main &&
 	git stash &&
 	git stash apply 0 &&
 	git reset --hard &&
@@ -755,7 +755,7 @@ test_expect_success 'branch: do not drop the stash if the branch exists' '
 	git commit -m initial &&
 	echo bar >file &&
 	git stash &&
-	test_must_fail git stash branch master stash@{0} &&
+	test_must_fail git stash branch main stash@{0} &&
 	git rev-parse stash@{0} --
 '
 
@@ -768,7 +768,7 @@ test_expect_success 'branch: should not drop the stash if the apply fails' '
 	echo bar >file &&
 	git stash &&
 	echo baz >file &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	test_must_fail git stash branch new_branch stash@{0} &&
 	git rev-parse stash@{0} --
 '
@@ -902,7 +902,7 @@ test_expect_success 'push -m shows right message' '
 	>foo &&
 	git add foo &&
 	git stash push -m "test message" &&
-	echo "stash@{0}: On master: test message" >expect &&
+	echo "stash@{0}: On main: test message" >expect &&
 	git stash list -1 >actual &&
 	test_cmp expect actual
 '
@@ -911,7 +911,7 @@ test_expect_success 'push -m also works without space' '
 	>foo &&
 	git add foo &&
 	git stash push -m"unspaced test message" &&
-	echo "stash@{0}: On master: unspaced test message" >expect &&
+	echo "stash@{0}: On main: unspaced test message" >expect &&
 	git stash list -1 >actual &&
 	test_cmp expect actual
 '
@@ -968,7 +968,7 @@ test_expect_success 'push -mfoo uses right message' '
 	>foo &&
 	git add foo &&
 	git stash push -m"test mfoo" &&
-	echo "stash@{0}: On master: test mfoo" >expect &&
+	echo "stash@{0}: On main: test mfoo" >expect &&
 	git stash list -1 >actual &&
 	test_cmp expect actual
 '
@@ -977,7 +977,7 @@ test_expect_success 'push --message foo is synonym for -mfoo' '
 	>foo &&
 	git add foo &&
 	git stash push --message "test message foo" &&
-	echo "stash@{0}: On master: test message foo" >expect &&
+	echo "stash@{0}: On main: test message foo" >expect &&
 	git stash list -1 >actual &&
 	test_cmp expect actual
 '
@@ -986,7 +986,7 @@ test_expect_success 'push --message=foo is synonym for -mfoo' '
 	>foo &&
 	git add foo &&
 	git stash push --message="test message=foo" &&
-	echo "stash@{0}: On master: test message=foo" >expect &&
+	echo "stash@{0}: On main: test message=foo" >expect &&
 	git stash list -1 >actual &&
 	test_cmp expect actual
 '
@@ -995,7 +995,7 @@ test_expect_success 'push -m shows right message' '
 	>foo &&
 	git add foo &&
 	git stash push -m "test m foo" &&
-	echo "stash@{0}: On master: test m foo" >expect &&
+	echo "stash@{0}: On main: test m foo" >expect &&
 	git stash list -1 >actual &&
 	test_cmp expect actual
 '
@@ -1004,7 +1004,7 @@ test_expect_success 'create stores correct message' '
 	>foo &&
 	git add foo &&
 	STASH_ID=$(git stash create "create test message") &&
-	echo "On master: create test message" >expect &&
+	echo "On main: create test message" >expect &&
 	git show --pretty=%s -s ${STASH_ID} >actual &&
 	test_cmp expect actual
 '
@@ -1013,13 +1013,13 @@ test_expect_success 'create with multiple arguments for the message' '
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
index 54ce19e353..7e03823537 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -151,7 +151,7 @@ test_expect_success "git checkout link nfd" '
 	git checkout l.$Odiarnfd
 '
 test_expect_success "setup case mac2" '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard &&
 	git checkout -b mac_os_2
 '
@@ -163,7 +163,7 @@ test_expect_success "commit file d2.Adiarnfd/f.Adiarnfd" '
 	git commit -m "add d2.$Adiarnfd/f.$Adiarnfd" -- d2.$Adiarnfd/f.$Adiarnfd
 '
 test_expect_success "setup for long decomposed filename" '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard &&
 	git checkout -b mac_os_long_nfd_fn
 '
@@ -173,7 +173,7 @@ test_expect_success "Add long decomposed filename" '
 	git commit -m "Long filename"
 '
 test_expect_success "setup for long precomposed filename" '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard &&
 	git checkout -b mac_os_long_nfc_fn
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4ae87a5c4e..76ab747b53 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,7 @@ case "$TEST_NUMBER" in
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-2]*|3[0-4]*)
+[0-3]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

