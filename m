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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7B4C64E69
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665F0246BC
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdplW/mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgKRXpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgKRXpA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:00 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF9DC061A48
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:44:59 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id o15so4324679wru.6
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=slt1KetHl9k5qhiFMOFU21CjUG/qP+OhXeLNZWuTM3Q=;
        b=UdplW/mfLSgOpK/EFqzPQZ7EVIqY//9Swkn5s9rlgpGBaUoCnOyuOm9SqVbz2kEtWf
         bD4HCh3Z5UodEGSPPJsfT6Wb4OlLnsVhicHnEHdSgP5FDvVdGi6FCq8YzFoApoPbMcHv
         lepK9zrWFRZy3PIpGV+aiMEUwBBjfOzHlohqQDnLN1jbLCJho77EsrpzutiOF2cPml/Z
         1q3zol1QReBSV9RNl3WKQtNM8ZVjgQwBL6yi9JzR2fJmUrSVHbTiYMLkc4aHaO+gC9qv
         pef83wGMH5TLtwkPJbI1wqyDGOtyT0QAN3db5EXeTcJKc5oVftkpo+9xbbeuG+KLDBU0
         lckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=slt1KetHl9k5qhiFMOFU21CjUG/qP+OhXeLNZWuTM3Q=;
        b=JifxFd19yxzUCQCpZuNnUGZPY9UXENam+vIOxWcWqA4zjdgWGNeiNS3zK7ZhPYJp46
         aeyy2xx1Hhx7x2st8WCqvQIJmD+TKe9sUKqeg6N4s+DAABxD2yZVnkg3iKJXgH255lGv
         iSYsdK2TbMc2ceITG5QrLpFNhMizKs1KwAHxufkd3TMaHx1BqG3ULQo5YqPImlkr30/f
         Tpsw48qNWrAUFbCIwdUgwffopDPw0wu5fuDrBKQyacDeMb9OWgLC5K4OihdkNF/VfO97
         dYH28e3fHbhKtAcWetC/2vHhJx1AVG6B8QpJmpnZO++PkOmg5ghtbSKT5AB6ncebRT9g
         S3Ww==
X-Gm-Message-State: AOAM53095cIISYinz5x0YQIfBIB8PCrrj4wMj0qVwOJohfc2srj9zUGY
        1eJ5KAl46qDE1MZDxexglyWh+vLM+UA=
X-Google-Smtp-Source: ABdhPJwkImtvEONWwATjFw5SZI/fPyMo845MGTWhMqtr+ydoRXBBfMrGSB221V5ZFrwYAb9zO3doIw==
X-Received: by 2002:adf:a40c:: with SMTP id d12mr7285065wra.154.1605743097248;
        Wed, 18 Nov 2020 15:44:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a128sm6662955wmf.5.2020.11.18.15.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:44:56 -0800 (PST)
Message-Id: <c0d02e4d9d91d34c0d39470b0851cf56a91030ce.1605743087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:25 +0000
Subject: [PATCH v3 07/28] t34*: adjust the references to the default branch
 name "main"
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

Carefully excluding t3404, which sees independent development elsewhere
at the time of writing, we use `main` as the default branch name in
t34*. This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t34*.sh &&
	   git checkout HEAD -- t34\*)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3400-rebase.sh                 | 62 +++++++++++++++----------------
 t/t3402-rebase-merge.sh           | 46 +++++++++++------------
 t/t3403-rebase-skip.sh            |  8 ++--
 t/t3405-rebase-malformed.sh       | 10 ++---
 t/t3406-rebase-message.sh         | 26 ++++++-------
 t/t3407-rebase-abort.sh           | 20 +++++-----
 t/t3408-rebase-multi-line.sh      |  4 +-
 t/t3409-rebase-preserve-merges.sh | 12 +++---
 t/t3412-rebase-root.sh            | 30 +++++++--------
 t/t3413-rebase-hook.sh            | 44 +++++++++++-----------
 t/t3415-rebase-autosquash.sh      |  4 +-
 t/t3416-rebase-onto-threedots.sh  | 56 ++++++++++++++--------------
 t/t3418-rebase-continue.sh        | 26 ++++++-------
 t/t3419-rebase-patch-id.sh        | 14 +++----
 t/t3420-rebase-autostash.sh       | 10 ++---
 t/t3423-rebase-reword.sh          |  6 +--
 t/t3427-rebase-subtree.sh         | 22 +++++------
 t/t3430-rebase-merges.sh          | 18 ++++-----
 t/t3431-rebase-fork-point.sh      | 34 ++++++++---------
 t/t3432-rebase-fast-forward.sh    | 36 +++++++++---------
 t/t3434-rebase-i18n.sh            | 10 ++---
 t/t3435-rebase-gpg-sign.sh        |  6 +--
 t/t3436-rebase-more-options.sh    |  2 +-
 23 files changed, 253 insertions(+), 253 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 61577591d0..5e88a10f8d 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -8,7 +8,7 @@ test_description='git rebase assorted tests
 This test runs git rebase and checks that the author information is not lost
 among other things.
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -27,15 +27,15 @@ test_expect_success 'prepare repository with topic branches' '
 	git update-index --add Y &&
 	git commit -m "Add Y." &&
 	git checkout -b filemove &&
-	git reset --soft master &&
+	git reset --soft main &&
 	mkdir D &&
 	git mv A D/A &&
 	git commit -m "Move A." &&
-	git checkout -b my-topic-branch master &&
+	git checkout -b my-topic-branch main &&
 	echo Second >B &&
 	git update-index --add B &&
 	git commit -m "Add B." &&
-	git checkout -f master &&
+	git checkout -f main &&
 	echo Third >>A &&
 	git update-index A &&
 	git commit -m "Modify A." &&
@@ -49,23 +49,23 @@ test_expect_success 'prepare repository with topic branches' '
 
 test_expect_success 'rebase on dirty worktree' '
 	echo dirty >>A &&
-	test_must_fail git rebase master
+	test_must_fail git rebase main
 '
 
 test_expect_success 'rebase on dirty cache' '
 	git add A &&
-	test_must_fail git rebase master
+	test_must_fail git rebase main
 '
 
-test_expect_success 'rebase against master' '
+test_expect_success 'rebase against main' '
 	git reset --hard HEAD &&
-	git rebase master
+	git rebase main
 '
 
 test_expect_success 'rebase sets ORIG_HEAD to pre-rebase state' '
 	git checkout -b orig-head topic &&
 	pre="$(git rev-parse --verify HEAD)" &&
-	git rebase master &&
+	git rebase main &&
 	test_cmp_rev "$pre" ORIG_HEAD &&
 	test_cmp_rev ! "$pre" HEAD
 '
@@ -96,19 +96,19 @@ test_expect_success 'HEAD was detached during rebase' '
 
 test_expect_success 'rebase from ambiguous branch name' '
 	git checkout -b topic side &&
-	git rebase master
+	git rebase main
 '
 
 test_expect_success 'rebase off of the previous branch using "-"' '
-	git checkout master &&
+	git checkout main &&
 	git checkout HEAD^ &&
 	git rebase @{-1} >expect.messages &&
-	git merge-base master HEAD >expect.forkpoint &&
+	git merge-base main HEAD >expect.forkpoint &&
 
-	git checkout master &&
+	git checkout main &&
 	git checkout HEAD^ &&
 	git rebase - >actual.messages &&
-	git merge-base master HEAD >actual.forkpoint &&
+	git merge-base main HEAD >actual.forkpoint &&
 
 	test_cmp expect.forkpoint actual.forkpoint &&
 	# the next one is dubious---we may want to say "-",
@@ -117,7 +117,7 @@ test_expect_success 'rebase off of the previous branch using "-"' '
 '
 
 test_expect_success 'rebase a single mode change' '
-	git checkout master &&
+	git checkout main &&
 	git branch -D topic &&
 	echo 1 >X &&
 	git add X &&
@@ -129,7 +129,7 @@ test_expect_success 'rebase a single mode change' '
 	test_chmod +x A &&
 	test_tick &&
 	git commit -m modechange &&
-	GIT_TRACE=1 git rebase master
+	GIT_TRACE=1 git rebase main
 '
 
 test_expect_success 'rebase is not broken by diff.renames' '
@@ -165,11 +165,11 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 test_expect_success 'rebase works with format.useAutoBase' '
 	test_config format.useAutoBase true &&
 	git checkout topic &&
-	git rebase master
+	git rebase main
 '
 
 test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg (--merge)' '
-	git checkout -b default-base master &&
+	git checkout -b default-base main &&
 	git checkout -b default topic &&
 	git config branch.default.remote . &&
 	git config branch.default.merge refs/heads/default-base &&
@@ -187,7 +187,7 @@ test_expect_success 'default to common base in @{upstream}s reflog if no upstrea
 '
 
 test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg (--apply)' '
-	git checkout -B default-base master &&
+	git checkout -B default-base main &&
 	git checkout -B default topic &&
 	git config branch.default.remote . &&
 	git config branch.default.merge refs/heads/default-base &&
@@ -229,13 +229,13 @@ test_expect_success 'cherry-picked commits and fork-point work together' '
 
 test_expect_success 'rebase --apply -q is quiet' '
 	git checkout -b quiet topic &&
-	git rebase --apply -q master >output.out 2>&1 &&
+	git rebase --apply -q main >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
 test_expect_success 'rebase --merge -q is quiet' '
 	git checkout -B quiet topic &&
-	git rebase --merge -q master >output.out 2>&1 &&
+	git rebase --merge -q main >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
@@ -297,7 +297,7 @@ test_expect_success 'rebase commit with an ancient timestamp' '
 '
 
 test_expect_success 'rebase with "From " line in commit message' '
-	git checkout -b preserve-from master~1 &&
+	git checkout -b preserve-from main~1 &&
 	cat >From_.msg <<EOF &&
 Somebody embedded an mbox in a commit message
 
@@ -313,7 +313,7 @@ EOF
 	>From_ &&
 	git add From_ &&
 	git commit -F From_.msg &&
-	git rebase master &&
+	git rebase main &&
 	git log -1 --pretty=format:%B >out &&
 	test_cmp From_.msg out
 '
@@ -360,12 +360,12 @@ test_expect_success 'rebase --apply and .gitattributes' '
 		git cherry-pick test &&
 
 		git checkout test &&
-		git rebase master &&
+		git rebase main &&
 		grep "smudged" a.txt &&
 
 		git checkout removal &&
 		git reset --hard &&
-		git rebase master &&
+		git rebase main &&
 		grep "clean" a.txt
 	)
 '
@@ -405,20 +405,20 @@ test_expect_success 'rebase -c rebase.useBuiltin=false warning' '
 '
 
 test_expect_success 'switch to branch checked out here' '
-	git checkout master &&
-	git rebase master master
+	git checkout main &&
+	git rebase main main
 '
 
 test_expect_success 'switch to branch not checked out' '
-	git checkout master &&
+	git checkout main &&
 	git branch other &&
-	git rebase master other
+	git rebase main other
 '
 
 test_expect_success 'refuse to switch to branch checked out elsewhere' '
-	git checkout master &&
+	git checkout main &&
 	git worktree add wt &&
-	test_must_fail git -C wt rebase master master 2>err &&
+	test_must_fail git -C wt rebase main main 2>err &&
 	test_i18ngrep "already checked out" err
 '
 
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index d79a11b686..cfde68f193 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -5,7 +5,7 @@
 
 test_description='git rebase --merge test'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -22,10 +22,10 @@ test_expect_success setup '
 	git commit -m"initial" &&
 	git branch side &&
 	echo "11 $T" >>original &&
-	git commit -a -m"master updates a bit." &&
+	git commit -a -m"main updates a bit." &&
 
 	echo "12 $T" >>original &&
-	git commit -a -m"master updates a bit more." &&
+	git commit -a -m"main updates a bit more." &&
 
 	git checkout side &&
 	(echo "0 $T" && cat original) >renamed &&
@@ -50,13 +50,13 @@ test_expect_success setup '
 '
 
 test_expect_success 'reference merge' '
-	git merge -s recursive -m "reference merge" master
+	git merge -s recursive -m "reference merge" main
 '
 
 PRE_REBASE=$(git rev-parse test-rebase)
 test_expect_success rebase '
 	git checkout test-rebase &&
-	GIT_TRACE=1 git rebase --merge master
+	GIT_TRACE=1 git rebase --merge main
 '
 
 test_expect_success 'test-rebase@{1} is pre rebase' '
@@ -75,24 +75,24 @@ test_expect_success 'merge and rebase should match' '
 '
 
 test_expect_success 'rebase the other way' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git rebase --merge side
 '
 
 test_expect_success 'rebase -Xtheirs' '
-	git checkout -b conflicting master~2 &&
+	git checkout -b conflicting main~2 &&
 	echo "AB $T" >> original &&
 	git commit -mconflicting original &&
-	git rebase -Xtheirs master &&
+	git rebase -Xtheirs main &&
 	grep AB original &&
 	! grep 11 original
 '
 
 test_expect_success 'rebase -Xtheirs from orphan' '
-	git checkout --orphan orphan-conflicting master~2 &&
+	git checkout --orphan orphan-conflicting main~2 &&
 	echo "AB $T" >> original &&
 	git commit -morphan-conflicting original &&
-	git rebase -Xtheirs master &&
+	git rebase -Xtheirs main &&
 	grep AB original &&
 	! grep 11 original
 '
@@ -110,9 +110,9 @@ test_expect_success 'merge and rebase should match' '
 
 test_expect_success 'picking rebase' '
 	git reset --hard side &&
-	git rebase --merge --onto master side^^ &&
-	mb=$(git merge-base master HEAD) &&
-	if test "$mb" = "$(git rev-parse master)"
+	git rebase --merge --onto main side^^ &&
+	mb=$(git merge-base main HEAD) &&
+	if test "$mb" = "$(git rev-parse main)"
 	then
 		echo happy
 	else
@@ -143,11 +143,11 @@ test_expect_success 'rebase -s funny -Xopt' '
 	EOF
 	chmod +x test-bin/git-merge-funny &&
 	git reset --hard &&
-	git checkout -b test-funny master^ &&
+	git checkout -b test-funny main^ &&
 	test_commit funny &&
 	(
 		PATH=./test-bin:$PATH &&
-		git rebase -s funny -Xopt master
+		git rebase -s funny -Xopt main
 	) &&
 	test -f funny.was.run
 '
@@ -168,7 +168,7 @@ test_expect_success 'rebase --skip works with two conflicts in a row' '
 test_expect_success '--reapply-cherry-picks' '
 	git init repo &&
 
-	# O(1-10) -- O(1-11) -- O(0-10) master
+	# O(1-10) -- O(1-11) -- O(0-10) main
 	#        \
 	#         -- O(1-11) -- O(1-12) otherbranch
 
@@ -190,18 +190,18 @@ test_expect_success '--reapply-cherry-picks' '
 	git -C repo commit -a -m "add 12 in another branch" &&
 
 	# Regular rebase fails, because the 1-11 commit is deduplicated
-	test_must_fail git -C repo rebase --merge master 2> err &&
+	test_must_fail git -C repo rebase --merge main 2> err &&
 	test_i18ngrep "error: could not apply.*add 12 in another branch" err &&
 	git -C repo rebase --abort &&
 
 	# With --reapply-cherry-picks, it works
-	git -C repo rebase --merge --reapply-cherry-picks master
+	git -C repo rebase --merge --reapply-cherry-picks main
 '
 
 test_expect_success '--reapply-cherry-picks refrains from reading unneeded blobs' '
 	git init server &&
 
-	# O(1-10) -- O(1-11) -- O(1-12) master
+	# O(1-10) -- O(1-11) -- O(1-12) main
 	#        \
 	#         -- O(0-10) otherbranch
 
@@ -223,18 +223,18 @@ test_expect_success '--reapply-cherry-picks refrains from reading unneeded blobs
 	test_config -C server uploadpack.allowanysha1inwant 1 &&
 
 	git clone --filter=blob:none "file://$(pwd)/server" client &&
-	git -C client checkout origin/master &&
+	git -C client checkout origin/main &&
 	git -C client checkout origin/otherbranch &&
 
 	# Sanity check to ensure that the blobs from the merge base and "add
 	# 11" are missing
 	git -C client rev-list --objects --all --missing=print >missing_list &&
-	MERGE_BASE_BLOB=$(git -C server rev-parse master^^:file.txt) &&
-	ADD_11_BLOB=$(git -C server rev-parse master^:file.txt) &&
+	MERGE_BASE_BLOB=$(git -C server rev-parse main^^:file.txt) &&
+	ADD_11_BLOB=$(git -C server rev-parse main^:file.txt) &&
 	grep "[?]$MERGE_BASE_BLOB" missing_list &&
 	grep "[?]$ADD_11_BLOB" missing_list &&
 
-	git -C client rebase --merge --reapply-cherry-picks origin/master &&
+	git -C client rebase --merge --reapply-cherry-picks origin/main &&
 
 	# The blob from the merge base had to be fetched, but not "add 11"
 	git -C client rev-list --objects --all --missing=print >missing_list &&
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index c9936cb1d9..e26762d0b2 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -5,7 +5,7 @@
 
 test_description='git rebase --merge --skip tests'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -51,7 +51,7 @@ test_expect_success setup '
 	'
 
 test_expect_success 'rebase with git am -3 (default)' '
-	test_must_fail git rebase master
+	test_must_fail git rebase main
 '
 
 test_expect_success 'rebase --skip can not be used with other options' '
@@ -67,7 +67,7 @@ test_expect_success 'rebase moves back to skip-reference' '
 	test refs/heads/skip-reference = $(git symbolic-ref HEAD) &&
 	git branch post-rebase &&
 	git reset --hard pre-rebase &&
-	test_must_fail git rebase master &&
+	test_must_fail git rebase main &&
 	echo "hello" > hello &&
 	git add hello &&
 	git rebase --continue &&
@@ -78,7 +78,7 @@ test_expect_success 'rebase moves back to skip-reference' '
 test_expect_success 'checkout skip-merge' 'git checkout -f skip-merge'
 
 test_expect_success 'rebase with --merge' '
-	test_must_fail git rebase --merge master
+	test_must_fail git rebase --merge main
 '
 
 test_expect_success 'rebase --skip with --merge' '
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index d8f6d2e3cb..2524331861 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -2,7 +2,7 @@
 
 test_description='rebase should handle arbitrary git message'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -55,7 +55,7 @@ test_expect_success setup '
 	git add file3 &&
 	git commit --allow-empty-message -m "" &&
 
-	git checkout master &&
+	git checkout main &&
 
 	echo One >file1 &&
 	test_tick &&
@@ -65,7 +65,7 @@ test_expect_success setup '
 
 test_expect_success 'rebase commit with multi-line subject' '
 
-	git rebase master multi-line-subject &&
+	git rebase main multi-line-subject &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >F1 &&
 
 	test_cmp F0 F1 &&
@@ -73,14 +73,14 @@ test_expect_success 'rebase commit with multi-line subject' '
 '
 
 test_expect_success 'rebase commit with diff in message' '
-	git rebase master diff-in-message &&
+	git rebase main diff-in-message &&
 	git cat-file commit HEAD | sed -e "1,/^$/d" >G1 &&
 	test_cmp G0 G1 &&
 	test_cmp G G0
 '
 
 test_expect_success 'rebase -m commit with empty message' '
-	git rebase -m master empty-message-merge
+	git rebase -m main empty-message-merge
 '
 
 test_expect_success 'rebase -i commit with empty message' '
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 863db3ac4c..c02729d5ea 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -2,7 +2,7 @@
 
 test_description='messages from rebase operation'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -21,27 +21,27 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'rebase -m' '
-	git rebase -m master >actual &&
+	git rebase -m main >actual &&
 	test_must_be_empty actual
 '
 
-test_expect_success 'rebase against master twice' '
-	git rebase --apply master >out &&
+test_expect_success 'rebase against main twice' '
+	git rebase --apply main >out &&
 	test_i18ngrep "Current branch topic is up to date" out
 '
 
-test_expect_success 'rebase against master twice with --force' '
-	git rebase --force-rebase --apply master >out &&
+test_expect_success 'rebase against main twice with --force' '
+	git rebase --force-rebase --apply main >out &&
 	test_i18ngrep "Current branch topic is up to date, rebase forced" out
 '
 
-test_expect_success 'rebase against master twice from another branch' '
+test_expect_success 'rebase against main twice from another branch' '
 	git checkout topic^ &&
-	git rebase --apply master topic >out &&
+	git rebase --apply main topic >out &&
 	test_i18ngrep "Current branch topic is up to date" out
 '
 
-test_expect_success 'rebase fast-forward to master' '
+test_expect_success 'rebase fast-forward to main' '
 	git checkout topic^ &&
 	git rebase --apply topic >out &&
 	test_i18ngrep "Fast-forwarded HEAD to topic" out
@@ -49,21 +49,21 @@ test_expect_success 'rebase fast-forward to master' '
 
 test_expect_success 'rebase --stat' '
 	git reset --hard start &&
-	git rebase --stat master >diffstat.txt &&
+	git rebase --stat main >diffstat.txt &&
 	grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase w/config rebase.stat' '
 	git reset --hard start &&
 	git config rebase.stat true &&
-	git rebase master >diffstat.txt &&
+	git rebase main >diffstat.txt &&
 	grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase -n overrides config rebase.stat config' '
 	git reset --hard start &&
 	git config rebase.stat true &&
-	git rebase -n master >diffstat.txt &&
+	git rebase -n main >diffstat.txt &&
 	! grep "^ fileX |  *1 +$" diffstat.txt
 '
 
@@ -116,7 +116,7 @@ test_expect_success 'rebase -i onto unrelated history' '
 	git init unrelated &&
 	test_commit -C unrelated 1 &&
 	git -C unrelated remote add -f origin "$PWD" &&
-	git -C unrelated branch --set-upstream-to=origin/master &&
+	git -C unrelated branch --set-upstream-to=origin/main &&
 	git -C unrelated -c core.editor=true rebase -i -v --stat >actual &&
 	test_i18ngrep "Changes to " actual &&
 	test_i18ngrep "5 files changed" actual
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index e3c1851f40..7c381fbc89 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -2,7 +2,7 @@
 
 test_description='git rebase --abort tests'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -40,7 +40,7 @@ testrebase() {
 		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
-		test_must_fail git rebase$type master &&
+		test_must_fail git rebase$type main &&
 		test_path_is_dir "$dotest" &&
 		git rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
@@ -51,10 +51,10 @@ testrebase() {
 		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
-		test_must_fail git rebase$type master &&
+		test_must_fail git rebase$type main &&
 		test_path_is_dir "$dotest" &&
 		test_must_fail git rebase --skip &&
-		test $(git rev-parse HEAD) = $(git rev-parse master) &&
+		test $(git rev-parse HEAD) = $(git rev-parse main) &&
 		git rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
 		test ! -d "$dotest"
@@ -64,13 +64,13 @@ testrebase() {
 		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
-		test_must_fail git rebase$type master &&
+		test_must_fail git rebase$type main &&
 		test_path_is_dir "$dotest" &&
 		echo c > a &&
 		echo d >> a &&
 		git add a &&
 		test_must_fail git rebase --continue &&
-		test $(git rev-parse HEAD) != $(git rev-parse master) &&
+		test $(git rev-parse HEAD) != $(git rev-parse main) &&
 		git rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
 		test ! -d "$dotest"
@@ -81,7 +81,7 @@ testrebase() {
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		git reflog show to-rebase > reflog_before &&
-		test_must_fail git rebase$type master &&
+		test_must_fail git rebase$type main &&
 		git rebase --abort &&
 		git reflog show to-rebase > reflog_after &&
 		test_cmp reflog_before reflog_after &&
@@ -92,7 +92,7 @@ testrebase() {
 		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
-		test_must_fail git rebase$type master &&
+		test_must_fail git rebase$type main &&
 		test_must_fail git rebase -v --abort &&
 		test_must_fail git rebase --abort -v &&
 		git rebase --abort
@@ -106,7 +106,7 @@ test_expect_success 'rebase --apply --quit' '
 	cd "$work_dir" &&
 	# Clean up the state from the previous one
 	git reset --hard pre-rebase &&
-	test_must_fail git rebase --apply master &&
+	test_must_fail git rebase --apply main &&
 	test_path_is_dir .git/rebase-apply &&
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
@@ -118,7 +118,7 @@ test_expect_success 'rebase --merge --quit' '
 	cd "$work_dir" &&
 	# Clean up the state from the previous one
 	git reset --hard pre-rebase &&
-	test_must_fail git rebase --merge master &&
+	test_must_fail git rebase --merge main &&
 	test_path_is_dir .git/rebase-merge &&
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
index 6dd56c4c15..ab0960e6d9 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -2,7 +2,7 @@
 
 test_description='rebasing a commit with multi-line first paragraph.'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -49,7 +49,7 @@ But otherwise with a sane description." side2 &&
 test_expect_success rebase '
 
 	git checkout side &&
-	git rebase master &&
+	git rebase main &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	git cat-file commit side@{1} | sed -e "1,/^\$/d" >expect &&
 	test_cmp expect actual
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 609efc96f9..ec8062a66a 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -6,7 +6,7 @@ test_description='git rebase -p should preserve merges
 
 Run "git rebase -p" and check that merges are properly carried along
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -21,7 +21,7 @@ export GIT_AUTHOR_EMAIL
 
 # Clone 2 (conflicting merge):
 #
-# A1--A2--B3   <-- origin/master
+# A1--A2--B3   <-- origin/main
 #  \       \
 #   B1------M  <-- topic
 #    \
@@ -29,7 +29,7 @@ export GIT_AUTHOR_EMAIL
 #
 # Clone 3 (no-ff merge):
 #
-# A1--A2--B3   <-- origin/master
+# A1--A2--B3   <-- origin/main
 #  \
 #   B1------M  <-- topic
 #    \     /
@@ -47,7 +47,7 @@ test_expect_success 'setup for merge-preserving rebase' \
 	echo Second > B &&
 	git add B &&
 	git commit -m "Add B1" &&
-	git checkout -f master &&
+	git checkout -f main &&
 	echo Third >> A &&
 	git commit -a -m "Modify A2" &&
 	echo Fifth > B &&
@@ -58,10 +58,10 @@ test_expect_success 'setup for merge-preserving rebase' \
 	(
 		cd clone2 &&
 		git checkout -b topic origin/topic &&
-		test_must_fail git merge origin/master &&
+		test_must_fail git merge origin/main &&
 		echo Resolved >B &&
 		git add B &&
-		git commit -m "Merge origin/master into topic"
+		git commit -m "Merge origin/main into topic"
 	) &&
 
 	git clone ./. clone3 &&
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 07597643c5..fda62c65bd 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -4,7 +4,7 @@ test_description='git rebase --root
 
 Tests if git rebase --root --onto <newparent> can rebase the root commit.
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -27,7 +27,7 @@ test_expect_success 'prepare repository' '
 
 test_expect_success 'rebase --root fails with too many args' '
 	git checkout -B fail other &&
-	test_must_fail git rebase --onto master --root fail fail
+	test_must_fail git rebase --onto main --root fail fail
 '
 
 test_expect_success 'setup pre-rebase hook' '
@@ -47,7 +47,7 @@ EOF
 
 test_expect_success 'rebase --root --onto <newbase>' '
 	git checkout -b work other &&
-	git rebase --root --onto master &&
+	git rebase --root --onto main &&
 	git log --pretty=tformat:"%s" > rebased &&
 	test_cmp expect rebased
 '
@@ -58,7 +58,7 @@ test_expect_success 'pre-rebase got correct input (1)' '
 
 test_expect_success 'rebase --root --onto <newbase> <branch>' '
 	git branch work2 other &&
-	git rebase --root --onto master work2 &&
+	git rebase --root --onto main work2 &&
 	git log --pretty=tformat:"%s" > rebased2 &&
 	test_cmp expect rebased2
 '
@@ -69,7 +69,7 @@ test_expect_success 'pre-rebase got correct input (2)' '
 
 test_expect_success 'rebase -i --root --onto <newbase>' '
 	git checkout -b work3 other &&
-	git rebase -i --root --onto master &&
+	git rebase -i --root --onto main &&
 	git log --pretty=tformat:"%s" > rebased3 &&
 	test_cmp expect rebased3
 '
@@ -80,7 +80,7 @@ test_expect_success 'pre-rebase got correct input (3)' '
 
 test_expect_success 'rebase -i --root --onto <newbase> <branch>' '
 	git branch work4 other &&
-	git rebase -i --root --onto master work4 &&
+	git rebase -i --root --onto main work4 &&
 	git log --pretty=tformat:"%s" > rebased4 &&
 	test_cmp expect rebased4
 '
@@ -91,7 +91,7 @@ test_expect_success 'pre-rebase got correct input (4)' '
 
 test_expect_success REBASE_P 'rebase -i -p with linear history' '
 	git checkout -b work5 other &&
-	git rebase -i -p --root --onto master &&
+	git rebase -i -p --root --onto main &&
 	git log --pretty=tformat:"%s" > rebased5 &&
 	test_cmp expect rebased5
 '
@@ -125,7 +125,7 @@ EOF
 
 test_expect_success REBASE_P 'rebase -i -p with merge' '
 	git checkout -b work6 other &&
-	git rebase -i -p --root --onto master &&
+	git rebase -i -p --root --onto main &&
 	log_with_names work6 > rebased6 &&
 	test_cmp expect-side rebased6
 '
@@ -160,7 +160,7 @@ EOF
 
 test_expect_success REBASE_P 'rebase -i -p with two roots' '
 	git checkout -b work7 other &&
-	git rebase -i -p --root --onto master &&
+	git rebase -i -p --root --onto main &&
 	log_with_names work7 > rebased7 &&
 	test_cmp expect-third rebased7
 '
@@ -176,14 +176,14 @@ EOF
 
 test_expect_success 'pre-rebase hook stops rebase' '
 	git checkout -b stops1 other &&
-	test_must_fail git rebase --root --onto master &&
+	test_must_fail git rebase --root --onto main &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops1 &&
 	test 0 = $(git rev-list other...stops1 | wc -l)
 '
 
 test_expect_success 'pre-rebase hook stops rebase -i' '
 	git checkout -b stops2 other &&
-	test_must_fail git rebase --root --onto master &&
+	test_must_fail git rebase --root --onto main &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops2 &&
 	test 0 = $(git rev-list other...stops2 | wc -l)
 '
@@ -193,7 +193,7 @@ test_expect_success 'remove pre-rebase hook' '
 '
 
 test_expect_success 'set up a conflict' '
-	git checkout master &&
+	git checkout main &&
 	echo conflict > B &&
 	git add B &&
 	git commit -m conflict
@@ -201,7 +201,7 @@ test_expect_success 'set up a conflict' '
 
 test_expect_success 'rebase --root with conflict (first part)' '
 	git checkout -b conflict1 other &&
-	test_must_fail git rebase --root --onto master &&
+	test_must_fail git rebase --root --onto main &&
 	git ls-files -u | grep "B$"
 '
 
@@ -228,7 +228,7 @@ test_expect_success 'rebase --root with conflict (second part)' '
 
 test_expect_success 'rebase -i --root with conflict (first part)' '
 	git checkout -b conflict2 other &&
-	test_must_fail git rebase -i --root --onto master &&
+	test_must_fail git rebase -i --root --onto main &&
 	git ls-files -u | grep "B$"
 '
 
@@ -266,7 +266,7 @@ EOF
 
 test_expect_success REBASE_P 'rebase -i -p --root with conflict (first part)' '
 	git checkout -b conflict3 other &&
-	test_must_fail git rebase -i -p --root --onto master &&
+	test_must_fail git rebase -i -p --root --onto main &&
 	git ls-files -u | grep "B$"
 '
 
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index 86a1b82d65..b4acb3be5c 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -2,7 +2,7 @@
 
 test_description='git rebase with its hook(s)'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -21,7 +21,7 @@ test_expect_success setup '
 	git add git &&
 	test_tick &&
 	git commit -m side &&
-	git checkout master &&
+	git checkout main &&
 	git log --pretty=oneline --abbrev-commit --graph --all &&
 	git branch test side
 '
@@ -29,14 +29,14 @@ test_expect_success setup '
 test_expect_success 'rebase' '
 	git checkout test &&
 	git reset --hard side &&
-	git rebase master &&
+	git rebase main &&
 	test "z$(cat git)" = zworld
 '
 
 test_expect_success 'rebase -i' '
 	git checkout test &&
 	git reset --hard side &&
-	EDITOR=true git rebase -i master &&
+	EDITOR=true git rebase -i main &&
 	test "z$(cat git)" = zworld
 '
 
@@ -52,53 +52,53 @@ EOF
 test_expect_success 'pre-rebase hook gets correct input (1)' '
 	git checkout test &&
 	git reset --hard side &&
-	git rebase master &&
+	git rebase main &&
 	test "z$(cat git)" = zworld &&
-	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,
+	test "z$(cat .git/PRE-REBASE-INPUT)" = zmain,
 
 '
 
 test_expect_success 'pre-rebase hook gets correct input (2)' '
 	git checkout test &&
 	git reset --hard side &&
-	git rebase master test &&
+	git rebase main test &&
 	test "z$(cat git)" = zworld &&
-	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,test
+	test "z$(cat .git/PRE-REBASE-INPUT)" = zmain,test
 '
 
 test_expect_success 'pre-rebase hook gets correct input (3)' '
 	git checkout test &&
 	git reset --hard side &&
-	git checkout master &&
-	git rebase master test &&
+	git checkout main &&
+	git rebase main test &&
 	test "z$(cat git)" = zworld &&
-	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,test
+	test "z$(cat .git/PRE-REBASE-INPUT)" = zmain,test
 '
 
 test_expect_success 'pre-rebase hook gets correct input (4)' '
 	git checkout test &&
 	git reset --hard side &&
-	EDITOR=true git rebase -i master &&
+	EDITOR=true git rebase -i main &&
 	test "z$(cat git)" = zworld &&
-	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,
+	test "z$(cat .git/PRE-REBASE-INPUT)" = zmain,
 
 '
 
 test_expect_success 'pre-rebase hook gets correct input (5)' '
 	git checkout test &&
 	git reset --hard side &&
-	EDITOR=true git rebase -i master test &&
+	EDITOR=true git rebase -i main test &&
 	test "z$(cat git)" = zworld &&
-	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,test
+	test "z$(cat .git/PRE-REBASE-INPUT)" = zmain,test
 '
 
 test_expect_success 'pre-rebase hook gets correct input (6)' '
 	git checkout test &&
 	git reset --hard side &&
-	git checkout master &&
-	EDITOR=true git rebase -i master test &&
+	git checkout main &&
+	EDITOR=true git rebase -i main test &&
 	test "z$(cat git)" = zworld &&
-	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,test
+	test "z$(cat .git/PRE-REBASE-INPUT)" = zmain,test
 '
 
 test_expect_success 'setup pre-rebase hook that fails' '
@@ -113,7 +113,7 @@ EOF
 test_expect_success 'pre-rebase hook stops rebase (1)' '
 	git checkout test &&
 	git reset --hard side &&
-	test_must_fail git rebase master &&
+	test_must_fail git rebase main &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
 	test 0 = $(git rev-list HEAD...side | wc -l)
 '
@@ -121,7 +121,7 @@ test_expect_success 'pre-rebase hook stops rebase (1)' '
 test_expect_success 'pre-rebase hook stops rebase (2)' '
 	git checkout test &&
 	git reset --hard side &&
-	test_must_fail env EDITOR=: git rebase -i master &&
+	test_must_fail env EDITOR=: git rebase -i main &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
 	test 0 = $(git rev-list HEAD...side | wc -l)
 '
@@ -129,7 +129,7 @@ test_expect_success 'pre-rebase hook stops rebase (2)' '
 test_expect_success 'rebase --no-verify overrides pre-rebase (1)' '
 	git checkout test &&
 	git reset --hard side &&
-	git rebase --no-verify master &&
+	git rebase --no-verify main &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
 	test "z$(cat git)" = zworld
 '
@@ -137,7 +137,7 @@ test_expect_success 'rebase --no-verify overrides pre-rebase (1)' '
 test_expect_success 'rebase --no-verify overrides pre-rebase (2)' '
 	git checkout test &&
 	git reset --hard side &&
-	EDITOR=true git rebase --no-verify -i master &&
+	EDITOR=true git rebase --no-verify -i main &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
 	test "z$(cat git)" = zworld
 '
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 35eb8e2bb2..e7087befd4 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -2,7 +2,7 @@
 
 test_description='auto squash'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -410,7 +410,7 @@ test_expect_success 'wrapped original subject' '
 
 test_expect_success 'abort last squash' '
 	test_when_finished "test_might_fail git rebase --abort" &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 
 	git checkout -b some-squashes &&
 	git commit --allow-empty -m first &&
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index d0476fbb28..3716a42e81 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -2,20 +2,20 @@
 
 test_description='git rebase --onto A...B'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-rebase.sh"
 
-# Rebase only the tip commit of "topic" on merge base between "master"
-# and "topic".  Cannot do this for "side" with "master" because there
+# Rebase only the tip commit of "topic" on merge base between "main"
+# and "topic".  Cannot do this for "side" with "main" because there
 # is no single merge base.
 #
 #
 #	    F---G topic                             G'
 #	   /                                       /
-# A---B---C---D---E master        -->       A---B---C---D---E
+# A---B---C---D---E main        -->       A---B---C---D---E
 #      \   \ /
 #	\   x
 #	 \ / \
@@ -29,7 +29,7 @@ test_expect_success setup '
 	git branch topic &&
 	git checkout side &&
 	test_commit H &&
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git merge H &&
 	git tag D &&
@@ -45,83 +45,83 @@ test_expect_success setup '
 	test_commit K
 '
 
-test_expect_success 'rebase --onto master...topic' '
+test_expect_success 'rebase --onto main...topic' '
 	git reset --hard &&
 	git checkout topic &&
 	git reset --hard G &&
 
-	git rebase --onto master...topic F &&
+	git rebase --onto main...topic F &&
 	git rev-parse HEAD^1 >actual &&
 	git rev-parse C^0 >expect &&
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase --onto master...' '
+test_expect_success 'rebase --onto main...' '
 	git reset --hard &&
 	git checkout topic &&
 	git reset --hard G &&
 
-	git rebase --onto master... F &&
+	git rebase --onto main... F &&
 	git rev-parse HEAD^1 >actual &&
 	git rev-parse C^0 >expect &&
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase --onto master...side' '
+test_expect_success 'rebase --onto main...side' '
 	git reset --hard &&
 	git checkout side &&
 	git reset --hard K &&
 
-	test_must_fail git rebase --onto master...side J
+	test_must_fail git rebase --onto main...side J
 '
 
-test_expect_success 'rebase -i --onto master...topic' '
+test_expect_success 'rebase -i --onto main...topic' '
 	git reset --hard &&
 	git checkout topic &&
 	git reset --hard G &&
 	set_fake_editor &&
-	EXPECT_COUNT=1 git rebase -i --onto master...topic F &&
+	EXPECT_COUNT=1 git rebase -i --onto main...topic F &&
 	git rev-parse HEAD^1 >actual &&
 	git rev-parse C^0 >expect &&
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase -i --onto master...' '
+test_expect_success 'rebase -i --onto main...' '
 	git reset --hard &&
 	git checkout topic &&
 	git reset --hard G &&
 	set_fake_editor &&
-	EXPECT_COUNT=1 git rebase -i --onto master... F &&
+	EXPECT_COUNT=1 git rebase -i --onto main... F &&
 	git rev-parse HEAD^1 >actual &&
 	git rev-parse C^0 >expect &&
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase -i --onto master...side' '
+test_expect_success 'rebase -i --onto main...side' '
 	git reset --hard &&
 	git checkout side &&
 	git reset --hard K &&
 
 	set_fake_editor &&
-	test_must_fail git rebase -i --onto master...side J
+	test_must_fail git rebase -i --onto main...side J
 '
 
 test_expect_success 'rebase --keep-base --onto incompatible' '
-	test_must_fail git rebase --keep-base --onto master...
+	test_must_fail git rebase --keep-base --onto main...
 '
 
 test_expect_success 'rebase --keep-base --root incompatible' '
 	test_must_fail git rebase --keep-base --root
 '
 
-test_expect_success 'rebase --keep-base master from topic' '
+test_expect_success 'rebase --keep-base main from topic' '
 	git reset --hard &&
 	git checkout topic &&
 	git reset --hard G &&
 
-	git rebase --keep-base master &&
+	git rebase --keep-base main &&
 	git rev-parse C >base.expect &&
-	git merge-base master HEAD >base.actual &&
+	git merge-base main HEAD >base.actual &&
 	test_cmp base.expect base.actual &&
 
 	git rev-parse HEAD~2 >actual &&
@@ -129,23 +129,23 @@ test_expect_success 'rebase --keep-base master from topic' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase --keep-base master from side' '
+test_expect_success 'rebase --keep-base main from side' '
 	git reset --hard &&
 	git checkout side &&
 	git reset --hard K &&
 
-	test_must_fail git rebase --keep-base master
+	test_must_fail git rebase --keep-base main
 '
 
-test_expect_success 'rebase -i --keep-base master from topic' '
+test_expect_success 'rebase -i --keep-base main from topic' '
 	git reset --hard &&
 	git checkout topic &&
 	git reset --hard G &&
 
 	set_fake_editor &&
-	EXPECT_COUNT=2 git rebase -i --keep-base master &&
+	EXPECT_COUNT=2 git rebase -i --keep-base main &&
 	git rev-parse C >base.expect &&
-	git merge-base master HEAD >base.actual &&
+	git merge-base main HEAD >base.actual &&
 	test_cmp base.expect base.actual &&
 
 	git rev-parse HEAD~2 >actual &&
@@ -153,13 +153,13 @@ test_expect_success 'rebase -i --keep-base master from topic' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase -i --keep-base master from side' '
+test_expect_success 'rebase -i --keep-base main from side' '
 	git reset --hard &&
 	git checkout side &&
 	git reset --hard K &&
 
 	set_fake_editor &&
-	test_must_fail git rebase -i --keep-base master
+	test_must_fail git rebase -i --keep-base main
 '
 
 test_done
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 445cb843ba..0838f4e798 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -2,7 +2,7 @@
 
 test_description='git rebase --continue tests'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -18,13 +18,13 @@ test_expect_success 'setup' '
 	git checkout -b topic HEAD^ &&
 	test_commit "commit-new-file-F2-on-topic-branch" F2 22 &&
 
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'interactive rebase --continue works with touched file' '
 	rm -fr .git/rebase-* &&
 	git reset --hard &&
-	git checkout master &&
+	git checkout main &&
 
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
 	test-tool chmtime =-60 F1 &&
@@ -34,9 +34,9 @@ test_expect_success 'interactive rebase --continue works with touched file' '
 test_expect_success 'non-interactive rebase --continue works with touched file' '
 	rm -fr .git/rebase-* &&
 	git reset --hard &&
-	git checkout master &&
+	git checkout main &&
 
-	test_must_fail git rebase --onto master master topic &&
+	test_must_fail git rebase --onto main main topic &&
 	echo "Resolved" >F2 &&
 	git add F2 &&
 	test-tool chmtime =-60 F1 &&
@@ -64,7 +64,7 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	chmod +x test-bin/git-merge-funny &&
 	(
 		PATH=./test-bin:$PATH &&
-		test_must_fail git rebase -s funny -Xopt master topic
+		test_must_fail git rebase -s funny -Xopt main topic
 	) &&
 	test -f funny.was.run &&
 	rm funny.was.run &&
@@ -96,7 +96,7 @@ test_expect_success 'rebase -i --continue handles merge strategy and options' '
 	chmod +x test-bin/git-merge-funny &&
 	(
 		PATH=./test-bin:$PATH &&
-		test_must_fail git rebase -i -s funny -Xopt -Xfoo master topic
+		test_must_fail git rebase -i -s funny -Xopt -Xfoo main topic
 	) &&
 	test -f funny.was.run &&
 	rm funny.was.run &&
@@ -191,11 +191,11 @@ test_expect_success '--skip after failed fixup cleans commit message' '
 test_expect_success 'setup rerere database' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-	git checkout master &&
+	git checkout main &&
 	test_commit "commit-new-file-F3" F3 3 &&
 	test_config rerere.enabled true &&
 	git update-ref refs/heads/topic commit-new-file-F3-on-topic-branch &&
-	test_must_fail git rebase -m master topic &&
+	test_must_fail git rebase -m main topic &&
 	echo "Resolved" >F2 &&
 	cp F2 expected-F2 &&
 	git add F2 &&
@@ -210,7 +210,7 @@ test_expect_success 'setup rerere database' '
 prepare () {
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-	git checkout master &&
+	git checkout main &&
 	test_config rerere.enabled true
 }
 
@@ -218,7 +218,7 @@ test_rerere_autoupdate () {
 	action=$1 &&
 	test_expect_success "rebase $action --continue remembers --rerere-autoupdate" '
 		prepare &&
-		test_must_fail git rebase $action --rerere-autoupdate master topic &&
+		test_must_fail git rebase $action --rerere-autoupdate main topic &&
 		test_cmp expected-F2 F2 &&
 		git diff-files --quiet &&
 		test_must_fail git rebase --continue &&
@@ -230,7 +230,7 @@ test_rerere_autoupdate () {
 	test_expect_success "rebase $action --continue honors rerere.autoUpdate" '
 		prepare &&
 		test_config rerere.autoupdate true &&
-		test_must_fail git rebase $action master topic &&
+		test_must_fail git rebase $action main topic &&
 		test_cmp expected-F2 F2 &&
 		git diff-files --quiet &&
 		test_must_fail git rebase --continue &&
@@ -242,7 +242,7 @@ test_rerere_autoupdate () {
 	test_expect_success "rebase $action --continue remembers --no-rerere-autoupdate" '
 		prepare &&
 		test_config rerere.autoupdate true &&
-		test_must_fail git rebase $action --no-rerere-autoupdate master topic &&
+		test_must_fail git rebase $action --no-rerere-autoupdate main topic &&
 		test_cmp expected-F2 F2 &&
 		test_must_fail git diff-files --quiet &&
 		git add F2 &&
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index c5fe58d68b..295040f2fe 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -2,7 +2,7 @@
 
 test_description='git rebase - test patch id computation'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -27,7 +27,7 @@ test_expect_success 'setup' '
 
 test_expect_success 'setup: 500 lines' '
 	rm -f .gitattributes &&
-	git checkout -q -f master &&
+	git checkout -q -f main &&
 	git reset --hard root &&
 	test_seq 500 >file &&
 	git add file &&
@@ -43,7 +43,7 @@ test_expect_success 'setup: 500 lines' '
 	git add newfile &&
 	git commit -q -m "add small file" &&
 
-	git cherry-pick master >/dev/null 2>&1
+	git cherry-pick main >/dev/null 2>&1
 '
 
 test_expect_success 'setup attributes' '
@@ -51,18 +51,18 @@ test_expect_success 'setup attributes' '
 '
 
 test_expect_success 'detect upstream patch' '
-	git checkout -q master &&
+	git checkout -q main &&
 	scramble file &&
 	git add file &&
 	git commit -q -m "change big file again" &&
 	git checkout -q other^{} &&
-	git rebase master &&
-	git rev-list master...HEAD~ >revs &&
+	git rebase main &&
+	git rev-list main...HEAD~ >revs &&
 	test_must_be_empty revs
 '
 
 test_expect_success 'do not drop patch' '
-	git branch -f squashed master &&
+	git branch -f squashed main &&
 	git checkout -q -f squashed &&
 	git reset -q --soft HEAD~2 &&
 	git commit -q -m squashed &&
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 95facc49aa..4caa014c71 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -4,7 +4,7 @@
 #
 
 test_description='git rebase --autostash tests'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -24,12 +24,12 @@ test_expect_success setup '
 	git add . &&
 	test_tick &&
 	git commit -m "third commit" &&
-	git checkout -b unrelated-onto-branch master &&
+	git checkout -b unrelated-onto-branch main &&
 	echo unrelated >file4 &&
 	git add . &&
 	test_tick &&
 	git commit -m "unrelated commit" &&
-	git checkout -b related-onto-branch master &&
+	git checkout -b related-onto-branch main &&
 	echo conflicting-change >file2 &&
 	git add . &&
 	test_tick &&
@@ -308,7 +308,7 @@ test_expect_success 'autostash is saved on editor failure with conflict' '
 '
 
 test_expect_success 'autostash with dirty submodules' '
-	test_when_finished "git reset --hard && git checkout master" &&
+	test_when_finished "git reset --hard && git checkout main" &&
 	git checkout -b with-submodule &&
 	git submodule add ./ sub &&
 	test_tick &&
@@ -327,7 +327,7 @@ test_expect_success 'branch is left alone when possible' '
 
 test_expect_success 'never change active branch' '
 	git checkout -b not-the-feature-branch unrelated-onto-branch &&
-	test_when_finished "git reset --hard && git checkout master" &&
+	test_when_finished "git reset --hard && git checkout main" &&
 	echo changed >file0 &&
 	git rebase --autostash not-the-feature-branch feature-branch &&
 	test_cmp_rev not-the-feature-branch unrelated-onto-branch
diff --git a/t/t3423-rebase-reword.sh b/t/t3423-rebase-reword.sh
index 6963750794..4859bb8f72 100755
--- a/t/t3423-rebase-reword.sh
+++ b/t/t3423-rebase-reword.sh
@@ -7,7 +7,7 @@ test_description='git rebase interactive with rewording'
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
 test_expect_success 'setup' '
-	test_commit master file-1 test &&
+	test_commit main file-1 test &&
 
 	git checkout -b stuff &&
 
@@ -22,7 +22,7 @@ test_expect_success 'reword without issues functions as intended' '
 
 	set_fake_editor &&
 	FAKE_LINES="pick 1 reword 2" FAKE_COMMIT_MESSAGE="feature_b_reworded" \
-		git rebase -i -v master &&
+		git rebase -i -v main &&
 
 	test "$(git log -1 --format=%B)" = "feature_b_reworded" &&
 	test $(git rev-list --count HEAD) = 3
@@ -35,7 +35,7 @@ test_expect_success 'reword after a conflict preserves commit' '
 
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="reword 2" \
-		git rebase -i -v master &&
+		git rebase -i -v main &&
 
 	git checkout --theirs file-2 &&
 	git add file-2 &&
diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 254ed18452..e78c7e3796 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -4,7 +4,7 @@ test_description='git rebase tests for -Xsubtree
 
 This test runs git rebase and tests the subtree strategy.
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -20,7 +20,7 @@ commit_message() {
 #
 # topic_1 - topic_2 - topic_3
 #                             \
-# README ---------------------- Add subproject master - topic_4 - files_subtree/topic_5
+# README ---------------------- Add subproject main - topic_4 - files_subtree/topic_5
 #
 # Where the merge moves the files topic_[123].t into the subdirectory
 # files_subtree/ and topic_4 as well as files_subtree/topic_5 add files to that
@@ -31,7 +31,7 @@ commit_message() {
 # an empty commit is added on top. The pre-rebase commit history looks like
 # this:
 #
-# Add subproject master - topic_4 - files_subtree/topic_5 - Empty commit
+# Add subproject main - topic_4 - files_subtree/topic_5 - Empty commit
 #
 # where the root commit adds three files: topic_1.t, topic_2.t and topic_3.t.
 #
@@ -51,11 +51,11 @@ test_expect_success 'setup' '
 	test_commit -C files topic_3 &&
 
 	: perform subtree merge into files_subtree/ &&
-	git fetch files refs/heads/master:refs/heads/files-master &&
+	git fetch files refs/heads/main:refs/heads/files-main &&
 	git merge -s ours --no-commit --allow-unrelated-histories \
-		files-master &&
-	git read-tree --prefix=files_subtree -u files-master &&
-	git commit -m "Add subproject master" &&
+		files-main &&
+	git read-tree --prefix=files_subtree -u files-main &&
+	git commit -m "Add subproject main" &&
 
 	: add two extra commits to rebase &&
 	test_commit -C files_subtree topic_4 &&
@@ -73,7 +73,7 @@ test_expect_success 'setup' '
 test_expect_failure REBASE_P 'Rebase -Xsubtree --preserve-merges --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-preserve-merges to-rebase &&
-	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
+	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-main main &&
 	verbose test "$(commit_message HEAD~)" = "topic_4" &&
 	verbose test "$(commit_message HEAD)" = "files_subtree/topic_5"
 '
@@ -82,7 +82,7 @@ test_expect_failure REBASE_P 'Rebase -Xsubtree --preserve-merges --onto commit'
 test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-keep-empty to-rebase &&
-	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
+	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-main main &&
 	verbose test "$(commit_message HEAD~2)" = "topic_4" &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/topic_5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
@@ -91,7 +91,7 @@ test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --
 test_expect_success 'Rebase -Xsubtree --empty=ask --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-onto to-rebase &&
-	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --onto files-master master &&
+	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --onto files-main main &&
 	: first pick results in no changes &&
 	git rebase --skip &&
 	verbose test "$(commit_message HEAD~2)" = "topic_4" &&
@@ -102,7 +102,7 @@ test_expect_success 'Rebase -Xsubtree --empty=ask --onto commit' '
 test_expect_success 'Rebase -Xsubtree --empty=ask --rebase-merges --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-merges-onto to-rebase &&
-	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --rebase-merges --onto files-master --root &&
+	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --rebase-merges --onto files-main --root &&
 	: first pick results in no changes &&
 	git rebase --skip &&
 	verbose test "$(commit_message HEAD~2)" = "topic_4" &&
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 22d929bd31..6748070df5 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -12,13 +12,13 @@ Initial setup:
 
     -- B --                   (first)
    /       \
- A - C - D - E - H            (master)
+ A - C - D - E - H            (main)
    \    \       /
     \    F - G                (second)
      \
       Conflicting-G
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -40,7 +40,7 @@ test_expect_success 'setup' '
 	git checkout -b first &&
 	test_commit B &&
 	b=$(git rev-parse --short HEAD) &&
-	git checkout master &&
+	git checkout main &&
 	test_commit C &&
 	c=$(git rev-parse --short HEAD) &&
 	test_commit D &&
@@ -55,7 +55,7 @@ test_expect_success 'setup' '
 	f=$(git rev-parse --short HEAD) &&
 	test_commit G &&
 	g=$(git rev-parse --short HEAD) &&
-	git checkout master &&
+	git checkout main &&
 	git merge --no-commit G &&
 	test_tick &&
 	git commit -m H &&
@@ -85,7 +85,7 @@ test_expect_success 'create completely different structure' '
 	EOF
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 	test_tick &&
-	git rebase -i -r A master &&
+	git rebase -i -r A main &&
 	test_cmp_graph <<-\EOF
 	*   Merge the topic branch '\''onebranch'\''
 	|\
@@ -186,7 +186,7 @@ test_expect_success 'fast-forward merge -c still rewords' '
 '
 
 test_expect_success 'with a branch tip that was cherry-picked already' '
-	git checkout -b already-upstream master &&
+	git checkout -b already-upstream main &&
 	base="$(git rev-parse --verify HEAD)" &&
 
 	test_commit A1 &&
@@ -214,7 +214,7 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 '
 
 test_expect_success 'do not rebase cousins unless asked for' '
-	git checkout -b cousins master &&
+	git checkout -b cousins main &&
 	before="$(git rev-parse --verify HEAD)" &&
 	test_tick &&
 	git rebase -r HEAD^ &&
@@ -343,7 +343,7 @@ test_expect_success 'a "merge" into a root commit is a fast-forward' '
 test_expect_success 'A root commit can be a cousin, treat it that way' '
 	git checkout --orphan khnum &&
 	test_commit yama &&
-	git checkout -b asherah master &&
+	git checkout -b asherah main &&
 	test_commit shamkat &&
 	git merge --allow-unrelated-histories khnum &&
 	test_tick &&
@@ -370,7 +370,7 @@ test_expect_success 'labels that are object IDs are rewritten' '
 	git checkout -b third B &&
 	test_commit I &&
 	third=$(git rev-parse HEAD) &&
-	git checkout -b labels master &&
+	git checkout -b labels main &&
 	git merge --no-commit third &&
 	test_tick &&
 	git commit -m "Merge commit '\''$third'\'' into labels" &&
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index af862e5bcc..2dab893c75 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -5,16 +5,16 @@
 
 test_description='git rebase --fork-point test'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-# A---B---D---E    (master)
+# A---B---D---E    (main)
 #      \
 #       C*---F---G (side)
 #
-# C was formerly part of master but master was rewound to remove C
+# C was formerly part of main but main was rewound to remove C
 #
 test_expect_success setup '
 	test_commit A &&
@@ -33,7 +33,7 @@ test_rebase () {
 	expected="$1" &&
 	shift &&
 	test_expect_success "git rebase $*" "
-		git checkout master &&
+		git checkout main &&
 		git reset --hard E &&
 		git checkout side &&
 		git reset --hard G &&
@@ -51,26 +51,26 @@ test_rebase 'G F C E D B A' --no-fork-point
 test_rebase 'G F C D B A' --no-fork-point --onto D
 test_rebase 'G F C B A' --no-fork-point --keep-base
 
-test_rebase 'G F E D B A' --fork-point refs/heads/master
-test_rebase 'G F E D B A' --fork-point master
+test_rebase 'G F E D B A' --fork-point refs/heads/main
+test_rebase 'G F E D B A' --fork-point main
 
-test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
-test_rebase 'G F D B A' --fork-point --onto D master
+test_rebase 'G F D B A' --fork-point --onto D refs/heads/main
+test_rebase 'G F D B A' --fork-point --onto D main
 
-test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
-test_rebase 'G F B A' --fork-point --keep-base master
+test_rebase 'G F B A' --fork-point --keep-base refs/heads/main
+test_rebase 'G F B A' --fork-point --keep-base main
 
-test_rebase 'G F C E D B A' refs/heads/master
-test_rebase 'G F C E D B A' master
+test_rebase 'G F C E D B A' refs/heads/main
+test_rebase 'G F C E D B A' main
 
-test_rebase 'G F C D B A' --onto D refs/heads/master
-test_rebase 'G F C D B A' --onto D master
+test_rebase 'G F C D B A' --onto D refs/heads/main
+test_rebase 'G F C D B A' --onto D main
 
-test_rebase 'G F C B A' --keep-base refs/heads/master
-test_rebase 'G F C B A' --keep-base master
+test_rebase 'G F C B A' --keep-base refs/heads/main
+test_rebase 'G F C B A' --keep-base main
 
 test_expect_success 'git rebase --fork-point with ambigous refname' '
-	git checkout master &&
+	git checkout main &&
 	git checkout -b one &&
 	git checkout side &&
 	git tag one &&
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 112a18d630..5086e14c02 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -5,7 +5,7 @@
 
 test_description='ensure rebase fast-forwards commits when possible'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -87,19 +87,19 @@ test_rebase_same_head_ () {
 
 changes='no changes'
 test_rebase_same_head success noop same success work same
-test_rebase_same_head success noop same success work same master
+test_rebase_same_head success noop same success work same main
 test_rebase_same_head success noop same success work diff --onto B B
 test_rebase_same_head success noop same success work diff --onto B... B
-test_rebase_same_head success noop same success work same --onto master... master
-test_rebase_same_head success noop same success work same --keep-base master
+test_rebase_same_head success noop same success work same --onto main... main
+test_rebase_same_head success noop same success work same --keep-base main
 test_rebase_same_head success noop same success work same --keep-base
 test_rebase_same_head success noop same success work same --no-fork-point
 test_rebase_same_head success noop same success work same --keep-base --no-fork-point
-test_rebase_same_head success noop same success work same --fork-point master
+test_rebase_same_head success noop same success work same --fork-point main
 test_rebase_same_head success noop same success work diff --fork-point --onto B B
 test_rebase_same_head success noop same success work diff --fork-point --onto B... B
-test_rebase_same_head success noop same success work same --fork-point --onto master... master
-test_rebase_same_head success noop same success work same --keep-base --keep-base master
+test_rebase_same_head success noop same success work same --fork-point --onto main... main
+test_rebase_same_head success noop same success work same --keep-base --keep-base main
 
 test_expect_success 'add work same to side' '
 	test_commit E
@@ -107,22 +107,22 @@ test_expect_success 'add work same to side' '
 
 changes='our changes'
 test_rebase_same_head success noop same success work same
-test_rebase_same_head success noop same success work same master
+test_rebase_same_head success noop same success work same main
 test_rebase_same_head success noop same success work diff --onto B B
 test_rebase_same_head success noop same success work diff --onto B... B
-test_rebase_same_head success noop same success work same --onto master... master
-test_rebase_same_head success noop same success work same --keep-base master
+test_rebase_same_head success noop same success work same --onto main... main
+test_rebase_same_head success noop same success work same --keep-base main
 test_rebase_same_head success noop same success work same --keep-base
 test_rebase_same_head success noop same success work same --no-fork-point
 test_rebase_same_head success noop same success work same --keep-base --no-fork-point
-test_rebase_same_head success noop same success work same --fork-point master
+test_rebase_same_head success noop same success work same --fork-point main
 test_rebase_same_head success noop same success work diff --fork-point --onto B B
 test_rebase_same_head success noop same success work diff --fork-point --onto B... B
-test_rebase_same_head success noop same success work same --fork-point --onto master... master
-test_rebase_same_head success noop same success work same --fork-point --keep-base master
+test_rebase_same_head success noop same success work same --fork-point --onto main... main
+test_rebase_same_head success noop same success work same --fork-point --keep-base main
 
 test_expect_success 'add work same to upstream' '
-	git checkout master &&
+	git checkout main &&
 	test_commit F &&
 	git checkout side
 '
@@ -130,12 +130,12 @@ test_expect_success 'add work same to upstream' '
 changes='our and their changes'
 test_rebase_same_head success noop same success work diff --onto B B
 test_rebase_same_head success noop same success work diff --onto B... B
-test_rebase_same_head success noop same success work diff --onto master... master
-test_rebase_same_head success noop same success work diff --keep-base master
+test_rebase_same_head success noop same success work diff --onto main... main
+test_rebase_same_head success noop same success work diff --keep-base main
 test_rebase_same_head success noop same success work diff --keep-base
 test_rebase_same_head failure work same success work diff --fork-point --onto B B
 test_rebase_same_head failure work same success work diff --fork-point --onto B... B
-test_rebase_same_head success noop same success work diff --fork-point --onto master... master
-test_rebase_same_head success noop same success work diff --fork-point --keep-base master
+test_rebase_same_head success noop same success work diff --fork-point --onto main... main
+test_rebase_same_head success noop same success work diff --fork-point --keep-base main
 
 test_done
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index 26fd33cbed..e6fef696bb 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -7,14 +7,14 @@ test_description='rebase with changing encoding
 
 Initial setup:
 
-1 - 2              master
+1 - 2              main
  \
   3 - 4            first
    \
     5 - 6          second
 '
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -44,7 +44,7 @@ test_expect_success 'rebase --rebase-merges update encoding eucJP to UTF-8' '
 	git config i18n.commitencoding eucJP &&
 	git merge -F "$TEST_DIRECTORY/t3434/eucJP.txt" second &&
 	git config i18n.commitencoding UTF-8 &&
-	git rebase --rebase-merges master &&
+	git rebase --rebase-merges main &&
 	compare_msg eucJP.txt eucJP UTF-8
 '
 
@@ -53,7 +53,7 @@ test_expect_success 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP
 	git config i18n.commitencoding eucJP &&
 	git merge -F "$TEST_DIRECTORY/t3434/eucJP.txt" second &&
 	git config i18n.commitencoding ISO-2022-JP &&
-	git rebase --rebase-merges master &&
+	git rebase --rebase-merges main &&
 	compare_msg eucJP.txt eucJP ISO-2022-JP
 '
 
@@ -69,7 +69,7 @@ test_rebase_continue_update_encode () {
 		git config i18n.commitencoding $old &&
 		git commit -F "$TEST_DIRECTORY/t3434/$msgfile" &&
 		git config i18n.commitencoding $new &&
-		test_must_fail git rebase -m master &&
+		test_must_fail git rebase -m main &&
 		test -f .git/rebase-merge/message &&
 		git stripspace <.git/rebase-merge/message >two.t &&
 		git add two.t &&
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index d169bc511d..ec10766858 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -5,7 +5,7 @@
 
 test_description='test rebase --[no-]gpg-sign'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -49,7 +49,7 @@ test_expect_success 'setup: merge commit' '
 	test_commit fork-point &&
 	git switch -c side &&
 	test_commit three &&
-	git switch master &&
+	git switch main &&
 	git merge --no-ff side &&
 	git tag merged
 '
@@ -67,7 +67,7 @@ test_rebase_gpg_sign   false -i --no-gpg-sign --gpg-sign
 test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
 	git reset --hard merged &&
 	git config commit.gpgsign true &&
-	git rebase -p --no-gpg-sign --onto=one fork-point master &&
+	git rebase -p --no-gpg-sign --onto=one fork-point main &&
 	test_must_fail git verify-commit HEAD
 '
 
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index eaaf4c8d1d..4d106642ba 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup' '
 	test_commit commit2 foo foo2 &&
 	test_commit commit3 foo foo3 &&
 
-	git checkout --orphan master &&
+	git checkout --orphan main &&
 	rm foo &&
 	test_write_lines "line 1" "        line 2" "line 3" >file &&
 	git commit -am "add file" &&
-- 
gitgitgadget

