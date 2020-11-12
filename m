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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DC4C388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92AE220825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHCf5LSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgKLWoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgKLWoS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:18 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E03C0617A6
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:18 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a3so6828068wmb.5
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DjvfBrwuguFELN7iz+RJxG68TiAbzsT71XBzWApuLGo=;
        b=IHCf5LSuNWP0HDp0lUCEtXLZDflgPGQUYiy1UiIlzHL0uCBo1gF7zZ1ydEQgN2vmWF
         jnQJVuvBKxzlTfppWWwY2+sEXYlc4Gkkx0JK4shhBbl+AZHwNx80PAsC/V3fRG0Ybip3
         1j8hr/dHKkZVvVzGGlXNvX/7jAO/AVEumOKtytDyLDVPDi68jKJZmAlc88nDUdOg4uxC
         7y3wy986GWDsCJ7yQaFqnlqX//E8nwyYvVCrMHKQUzRXfI2S9E44JT4lqVP4/gksc5Lt
         iGok3hsYZNd1EvHh7y/4JvSCwx7EvDAC9/ePelQ8k9xkcjlF4oxETJezPgZ3WNdo6Gew
         ENxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DjvfBrwuguFELN7iz+RJxG68TiAbzsT71XBzWApuLGo=;
        b=QghzSXf5tQ7pJbWsEEJjXwAKkO5Z+A+28+qTgQT9wutLB3ULEWPvx/Ih+8wr+lj/Xf
         RSnySK9WkiNcCXpXgv6JCjCV5Ko1gMctAFGe9KplMB1yZ4RQ2G3WnoxKtZT7VaWIy4kt
         XRn2U5XzwzFuq4vkOHwAG/oyY3a+5DXq+11nsFH1/eLbu+Uh9JN2LRBpqcj5QPa5lzjv
         35m2104lQJhzEZoWjAzz/SOLhY61HddkXcJxBwmRuBmcO0G1o0v3kP3UVW6aQS5GJqG3
         uzhhuviTWpvrHHm3ShHQ9GqyCKGhdJWXRsbBSfbLOHUSX4Fh5tqxeUbTEp/12lJ65XsF
         LEKg==
X-Gm-Message-State: AOAM5309GeauzkAnQKnQsO9Mat7P56JFlgOwhq3qosDUusqkghGzXyW7
        nhiG7EwMP5kar06enFLw2B7NpnoulHE=
X-Google-Smtp-Source: ABdhPJxL1DqaH4Q6awcmOyO68HElyKPL2QLuJEEzmqMl8v6f7Nq4rSFwiTcTN0SovaamdcYGBo/QPw==
X-Received: by 2002:a1c:ab57:: with SMTP id u84mr40288wme.99.1605221055974;
        Thu, 12 Nov 2020 14:44:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y20sm7861977wma.15.2020.11.12.14.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:15 -0800 (PST)
Message-Id: <1ef276c97efc63ca714b51083b364e3d6eac9ed4.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:49 +0000
Subject: [PATCH 19/28] t6[4-9]*: adjust the references to the default branch
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
		-e 's/Master/Main/g' -- t6[4-9]*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6400-merge-df.sh                       |  6 +--
 t/t6402-merge-rename.sh                   | 46 +++++++++++------------
 t/t6404-recursive-merge.sh                |  4 +-
 t/t6405-merge-symlinks.sh                 | 14 +++----
 t/t6406-merge-attr.sh                     | 24 ++++++------
 t/t6407-merge-binary.sh                   |  6 +--
 t/t6409-merge-subtree.sh                  | 16 ++++----
 t/t6411-merge-filemode.sh                 | 10 ++---
 t/t6412-merge-large-rename.sh             |  6 +--
 t/t6413-merge-crlf.sh                     |  2 +-
 t/t6414-merge-rename-nocruft.sh           |  2 +-
 t/t6415-merge-dir-to-symlink.sh           | 22 +++++------
 t/t6416-recursive-corner-cases.sh         | 28 +++++++-------
 t/t6417-merge-ours-theirs.sh              | 28 +++++++-------
 t/t6418-merge-text-auto.sh                | 12 +++---
 t/t6419-merge-ignorecase.sh               | 10 ++---
 t/t6422-merge-rename-corner-cases.sh      | 12 +++---
 t/t6425-merge-rename-delete.sh            |  2 +-
 t/t6427-diff3-conflict-markers.sh         | 14 +++----
 t/t6430-merge-recursive.sh                | 18 ++++-----
 t/t6432-merge-recursive-space-options.sh  |  6 +--
 t/t6433-merge-toplevel.sh                 |  8 ++--
 t/t6434-merge-recursive-rename-options.sh |  6 +--
 t/t6436-merge-overwrite.sh                |  2 +-
 t/t6437-submodule-merge.sh                | 14 +++----
 t/t6439-merge-co-error-msgs.sh            |  6 +--
 t/t6501-freshen-objects.sh                |  2 +-
 t/test-lib.sh                             |  2 +-
 28 files changed, 164 insertions(+), 164 deletions(-)

diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 9da0838216..f7907df3af 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -24,12 +24,12 @@ test_expect_success 'prepare repository' '
 '
 
 test_expect_success 'Merge with d/f conflicts' '
-	test_expect_code 1 git merge -m "merge msg" master
+	test_expect_code 1 git merge -m "merge msg" main
 '
 
 test_expect_success 'F/D conflict' '
 	git reset --hard &&
-	git checkout master &&
+	git checkout main &&
 	rm .git/index &&
 
 	mkdir before &&
@@ -47,7 +47,7 @@ test_expect_success 'F/D conflict' '
 	git add . &&
 	git commit -m para &&
 
-	git merge master
+	git merge main
 '
 
 test_expect_success 'setup modify/delete + directory/file conflict' '
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 3f64f62224..82b1b00d5b 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -54,9 +54,9 @@ test_expect_success 'setup' '
 	git branch change &&
 	git branch change+rename &&
 
-	sed -e "/^g /s/.*/g : master changes a line/" <A >A+ &&
+	sed -e "/^g /s/.*/g : main changes a line/" <A >A+ &&
 	mv A+ A &&
-	git commit -a -m "master updates A" &&
+	git commit -a -m "main updates A" &&
 
 	git checkout yellow &&
 	rm -f M &&
@@ -94,7 +94,7 @@ test_expect_success 'setup' '
 	git update-index --add B &&
 	git commit -q -a -m "changed and renamed" &&
 
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'pull renaming branch into unrenaming one' \
@@ -109,7 +109,7 @@ test_expect_success 'pull renaming branch into unrenaming one' \
 	sed -ne "/^g/{
 	p
 	q
-	}" B | grep master &&
+	}" B | grep main &&
 	git diff --exit-code white N
 '
 
@@ -134,7 +134,7 @@ test_expect_success 'pull unrenaming branch into renaming one' \
 '
 	git reset --hard &&
 	git show-branch &&
-	test_expect_code 1 git pull . master &&
+	test_expect_code 1 git pull . main &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
 	git ls-files -s N >n.stages &&
@@ -187,7 +187,7 @@ test_expect_success 'interference with untracked working tree file' '
 test_expect_success 'interference with untracked working tree file' '
 	git reset --hard &&
 	rm -f A M &&
-	git checkout -f master &&
+	git checkout -f main &&
 	git tag -f anchor &&
 	git show-branch &&
 	git pull . yellow &&
@@ -198,7 +198,7 @@ test_expect_success 'interference with untracked working tree file' '
 test_expect_success 'updated working tree file should prevent the merge' '
 	git reset --hard &&
 	rm -f A M &&
-	git checkout -f master &&
+	git checkout -f main &&
 	git tag -f anchor &&
 	git show-branch &&
 	echo >>M one line addition &&
@@ -211,7 +211,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 test_expect_success 'updated working tree file should prevent the merge' '
 	git reset --hard &&
 	rm -f A M &&
-	git checkout -f master &&
+	git checkout -f main &&
 	git tag -f anchor &&
 	git show-branch &&
 	echo >>M one line addition &&
@@ -229,7 +229,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git tag -f anchor &&
 	git show-branch &&
 	echo >M this file should not matter &&
-	git pull . master &&
+	git pull . main &&
 	test_path_is_file M &&
 	! {
 		git ls-files -s |
@@ -764,7 +764,7 @@ test_expect_success 'setup avoid unnecessary update, dir->(file,nothing)' '
 	git rm -rf df &&
 	git commit -mB &&
 
-	git checkout master &&
+	git checkout main &&
 	git rm -rf df &&
 	echo bla >df &&
 	git add -A &&
@@ -772,7 +772,7 @@ test_expect_success 'setup avoid unnecessary update, dir->(file,nothing)' '
 '
 
 test_expect_success 'avoid unnecessary update, dir->(file,nothing)' '
-	git checkout -q master^0 &&
+	git checkout -q main^0 &&
 	test-tool chmtime --get -3600 df >expect &&
 	git merge side &&
 	test-tool chmtime --get df >actual &&
@@ -794,14 +794,14 @@ test_expect_success 'setup avoid unnecessary update, modify/delete' '
 	git rm -f file &&
 	git commit -m "Delete file" &&
 
-	git checkout master &&
+	git checkout main &&
 	echo bla >file &&
 	git add -A &&
 	git commit -m "Modify file"
 '
 
 test_expect_success 'avoid unnecessary update, modify/delete' '
-	git checkout -q master^0 &&
+	git checkout -q main^0 &&
 	test-tool chmtime --get -3600 file >expect &&
 	test_must_fail git merge side &&
 	test-tool chmtime --get file >actual &&
@@ -823,13 +823,13 @@ test_expect_success 'setup avoid unnecessary update, rename/add-dest' '
 	git add -A &&
 	git commit -m "Add file copy" &&
 
-	git checkout master &&
+	git checkout main &&
 	git mv file newfile &&
 	git commit -m "Rename file"
 '
 
 test_expect_success 'avoid unnecessary update, rename/add-dest' '
-	git checkout -q master^0 &&
+	git checkout -q main^0 &&
 	test-tool chmtime --get -3600 newfile >expect &&
 	git merge side &&
 	test-tool chmtime --get newfile >actual &&
@@ -879,15 +879,15 @@ test_expect_success 'setup for use of extended merge markers' '
 	git mv original_file renamed_file &&
 	git commit -mB &&
 
-	git checkout master &&
+	git checkout main &&
 	echo 8.5 >>original_file &&
 	git add original_file &&
 	git commit -mC
 '
 
-test_expect_success 'merge master into rename has correct extended markers' '
+test_expect_success 'merge main into rename has correct extended markers' '
 	git checkout rename^0 &&
-	test_must_fail git merge -s recursive master^0 &&
+	test_must_fail git merge -s recursive main^0 &&
 
 	cat >expected <<-\EOF &&
 	1
@@ -902,14 +902,14 @@ test_expect_success 'merge master into rename has correct extended markers' '
 	9
 	=======
 	8.5
-	>>>>>>> master^0:original_file
+	>>>>>>> main^0:original_file
 	EOF
 	test_cmp expected renamed_file
 '
 
-test_expect_success 'merge rename into master has correct extended markers' '
+test_expect_success 'merge rename into main has correct extended markers' '
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	test_must_fail git merge -s recursive rename^0 &&
 
 	cat >expected <<-\EOF &&
@@ -945,13 +945,13 @@ test_expect_success 'setup spurious "refusing to lose untracked" message' '
 	git mv original_file renamed_file &&
 	git commit -mB &&
 
-	git checkout master &&
+	git checkout main &&
 	git rm original_file &&
 	git commit -mC
 '
 
 test_expect_success 'no spurious "refusing to lose untracked" message' '
-	git checkout master^0 &&
+	git checkout main^0 &&
 	test_must_fail git merge rename^0 2>errors.txt &&
 	! grep "refusing to lose untracked file" errors.txt
 '
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index b1c3d4dda4..410a17865b 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -19,11 +19,11 @@ test_expect_success 'setup tests' '
 	git add a1 &&
 	GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
 
-	git checkout -b A master &&
+	git checkout -b A main &&
 	echo A >a1 &&
 	GIT_AUTHOR_DATE="2006-12-12 23:00:01" git commit -m A a1 &&
 
-	git checkout -b B master &&
+	git checkout -b B main &&
 	echo B >a1 &&
 	GIT_AUTHOR_DATE="2006-12-12 23:00:02" git commit -m B a1 &&
 
diff --git a/t/t6405-merge-symlinks.sh b/t/t6405-merge-symlinks.sh
index 6c0a90d044..160c2c10f6 100755
--- a/t/t6405-merge-symlinks.sh
+++ b/t/t6405-merge-symlinks.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup' '
 	git branch b-file &&
 	l=$(printf file | git hash-object -t blob -w --stdin) &&
 	echo "120000 $l	symlink" | git update-index --index-info &&
-	git commit -m master &&
+	git commit -m main &&
 	git checkout b-symlink &&
 	l=$(printf file-different | git hash-object -t blob -w --stdin) &&
 	echo "120000 $l	symlink" | git update-index --index-info &&
@@ -30,28 +30,28 @@ test_expect_success 'setup' '
 	git commit -m b-file
 '
 
-test_expect_success 'merge master into b-symlink, which has a different symbolic link' '
+test_expect_success 'merge main into b-symlink, which has a different symbolic link' '
 	git checkout b-symlink &&
-	test_must_fail git merge master
+	test_must_fail git merge main
 '
 
 test_expect_success 'the merge result must be a file' '
 	test_path_is_file symlink
 '
 
-test_expect_success 'merge master into b-file, which has a file instead of a symbolic link' '
+test_expect_success 'merge main into b-file, which has a file instead of a symbolic link' '
 	git reset --hard &&
 	git checkout b-file &&
-	test_must_fail git merge master
+	test_must_fail git merge main
 '
 
 test_expect_success 'the merge result must be a file' '
 	test_path_is_file symlink
 '
 
-test_expect_success 'merge b-file, which has a file instead of a symbolic link, into master' '
+test_expect_success 'merge b-file, which has a file instead of a symbolic link, into main' '
 	git reset --hard &&
-	git checkout master &&
+	git checkout main &&
 	test_must_fail git merge b-file
 '
 
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 76a55f838c..c559b5a3e6 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -19,10 +19,10 @@ test_expect_success setup '
 	git branch side &&
 	for f in text binary union
 	do
-		echo Master >>$f && git add $f || return 1
+		echo Main >>$f && git add $f || return 1
 	done &&
 	test_tick &&
-	git commit -m Master &&
+	git commit -m Main &&
 
 	git checkout side &&
 	for f in text binary union
@@ -64,7 +64,7 @@ test_expect_success merge '
 		echo "union merge=union"
 	} >.gitattributes &&
 
-	if git merge master
+	if git merge main
 	then
 		echo Gaah, should have conflicted
 		false
@@ -87,7 +87,7 @@ test_expect_success 'check merge result in working tree' '
 	grep "<<<<<<<" text &&
 	cmp binary-orig binary &&
 	! grep "<<<<<<<" union &&
-	grep Master union &&
+	grep Main union &&
 	grep Side union
 
 '
@@ -115,13 +115,13 @@ test_expect_success 'custom merge backend' '
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
 
-	git merge master &&
+	git merge main &&
 
 	cmp binary union &&
 	sed -e 1,3d text >check-1 &&
-	o=$(git unpack-file master^:text) &&
+	o=$(git unpack-file main^:text) &&
 	a=$(git unpack-file side^:text) &&
-	b=$(git unpack-file master:text) &&
+	b=$(git unpack-file main:text) &&
 	sh -c "./custom-merge $o $a $b 0 text" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
@@ -136,7 +136,7 @@ test_expect_success 'custom merge backend' '
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
 
-	if git merge master
+	if git merge main
 	then
 		echo "Eh? should have conflicted"
 		false
@@ -146,9 +146,9 @@ test_expect_success 'custom merge backend' '
 
 	cmp binary union &&
 	sed -e 1,3d text >check-1 &&
-	o=$(git unpack-file master^:text) &&
+	o=$(git unpack-file main^:text) &&
 	a=$(git unpack-file anchor:text) &&
-	b=$(git unpack-file master:text) &&
+	b=$(git unpack-file main:text) &&
 	sh -c "./custom-merge $o $a $b 0 text" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
@@ -176,7 +176,7 @@ test_expect_success 'up-to-date merge without common ancestor' '
 	test_tick &&
 	(
 		cd repo1 &&
-		git fetch ../repo2 master &&
+		git fetch ../repo2 main &&
 		git merge --allow-unrelated-histories FETCH_HEAD
 	)
 '
@@ -201,7 +201,7 @@ test_expect_success 'custom merge does not lock index' '
 	# By packaging the command in test_when_finished, we get both
 	# the correctness check and the clean-up.
 	test_when_finished "kill \$(cat sleep.pid)" &&
-	git merge master
+	git merge main
 '
 
 test_done
diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index 4e6c7cb77e..a76c85ec1e 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -20,7 +20,7 @@ test_expect_success setup '
 	git ls-files -s a >E0 &&
 	git ls-files -s m | sed -e "s/ 0	/ 3	/" >E3 &&
 	test_tick &&
-	git commit -m "master adds some" &&
+	git commit -m "main adds some" &&
 
 	git checkout side &&
 	echo rezrov >>m &&
@@ -39,7 +39,7 @@ test_expect_success resolve '
 	rm -f a* m* &&
 	git reset --hard anchor &&
 
-	if git merge -s resolve master
+	if git merge -s resolve main
 	then
 		echo Oops, should not have succeeded
 		false
@@ -54,7 +54,7 @@ test_expect_success recursive '
 	rm -f a* m* &&
 	git reset --hard anchor &&
 
-	if git merge -s recursive master
+	if git merge -s recursive main
 	then
 		echo Oops, should not have succeeded
 		false
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index b8e8b6f642..55ae58584a 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -14,10 +14,10 @@ test_expect_success setup '
 	echo >>hello world &&
 	git add hello &&
 	git commit -m second &&
-	git checkout master &&
+	git checkout main &&
 	for i in mundo $s; do echo $i; done >hello &&
 	git add hello &&
-	git commit -m master
+	git commit -m main
 
 '
 
@@ -36,7 +36,7 @@ test_expect_success 'setup branch sub' '
 '
 
 test_expect_success 'setup topic branch' '
-	git checkout -b topic master &&
+	git checkout -b topic main &&
 	git merge -s ours --no-commit --allow-unrelated-histories sub &&
 	git read-tree --prefix=dir/ -u sub &&
 	git commit -m "initial merge of sub into topic" &&
@@ -77,8 +77,8 @@ test_expect_success 'setup' '
 
 test_expect_success 'initial merge' '
 	git remote add -f gui ../git-gui &&
-	git merge -s ours --no-commit --allow-unrelated-histories gui/master &&
-	git read-tree --prefix=git-gui/ -u gui/master &&
+	git merge -s ours --no-commit --allow-unrelated-histories gui/main &&
+	git read-tree --prefix=git-gui/ -u gui/main &&
 	git commit -m "Merge git-gui as our subdirectory" &&
 	git checkout -b work &&
 	git ls-files -s >actual &&
@@ -108,10 +108,10 @@ test_expect_success 'merge update' '
 
 test_expect_success 'initial ambiguous subtree' '
 	cd ../git &&
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b topic_2 &&
-	git merge -s ours --no-commit gui/master &&
-	git read-tree --prefix=git-gui2/ -u gui/master &&
+	git merge -s ours --no-commit gui/main &&
+	git read-tree --prefix=git-gui2/ -u gui/main &&
 	git commit -m "Merge git-gui2 as our subdirectory" &&
 	git checkout -b work2 &&
 	git ls-files -s >actual &&
diff --git a/t/t6411-merge-filemode.sh b/t/t6411-merge-filemode.sh
index 87741efad3..7ded226de4 100755
--- a/t/t6411-merge-filemode.sh
+++ b/t/t6411-merge-filemode.sh
@@ -7,11 +7,11 @@ test_expect_success 'set up mode change in one branch' '
 	: >file1 &&
 	git add file1 &&
 	git commit -m initial &&
-	git checkout -b a1 master &&
+	git checkout -b a1 main &&
 	: >dummy &&
 	git add dummy &&
 	git commit -m a &&
-	git checkout -b b1 master &&
+	git checkout -b b1 main &&
 	test_chmod +x file1 &&
 	git add file1 &&
 	git commit -m b1
@@ -39,12 +39,12 @@ do_one_mode resolve b1 a1
 
 test_expect_success 'set up mode change in both branches' '
 	git reset --hard HEAD &&
-	git checkout -b a2 master &&
+	git checkout -b a2 main &&
 	: >file2 &&
 	H=$(git hash-object file2) &&
 	test_chmod +x file2 &&
 	git commit -m a2 &&
-	git checkout -b b2 master &&
+	git checkout -b b2 main &&
 	: >file2 &&
 	git add file2 &&
 	git commit -m b2 &&
@@ -76,7 +76,7 @@ do_both_modes resolve
 
 test_expect_success 'set up delete/modechange scenario' '
 	git reset --hard &&
-	git checkout -b deletion master &&
+	git checkout -b deletion main &&
 	git rm file1 &&
 	git commit -m deletion
 '
diff --git a/t/t6412-merge-large-rename.sh b/t/t6412-merge-large-rename.sh
index 80777386dc..489ebd9bb7 100755
--- a/t/t6412-merge-large-rename.sh
+++ b/t/t6412-merge-large-rename.sh
@@ -30,7 +30,7 @@ test_rename() {
 	test_expect_success "rename ($1, $2)" '
 	n='$1' &&
 	expect='$2' &&
-	git checkout -f master &&
+	git checkout -f main &&
 	test_might_fail git branch -D test$n &&
 	git reset --hard initial &&
 	for i in $(count $n); do
@@ -50,8 +50,8 @@ test_rename() {
 	git add . &&
 	git commit -m change+rename=$n &&
 	case "$expect" in
-		ok) git merge master ;;
-		 *) test_must_fail git merge master ;;
+		ok) git merge main ;;
+		 *) test_must_fail git merge main ;;
 	esac
 	'
 }
diff --git a/t/t6413-merge-crlf.sh b/t/t6413-merge-crlf.sh
index e8d65eefb5..feaf9ef1a0 100755
--- a/t/t6413-merge-crlf.sh
+++ b/t/t6413-merge-crlf.sh
@@ -24,7 +24,7 @@ test_expect_success setup '
 	echo line from b | append_cr >file &&
 	git commit -m "add line from b" file &&
 	git tag b &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'Check "ours" is CRLF' '
diff --git a/t/t6414-merge-rename-nocruft.sh b/t/t6414-merge-rename-nocruft.sh
index a25e730460..81fa89331c 100755
--- a/t/t6414-merge-rename-nocruft.sh
+++ b/t/t6414-merge-rename-nocruft.sh
@@ -65,7 +65,7 @@ test_expect_success 'setup' '
 	git update-index A &&
 	git commit -m "blue modify A" &&
 
-	git checkout master
+	git checkout main
 '
 
 # This test broke in 65ac6e9c3f47807cb603af07a6a9e1a43bc119ae
diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-symlink.sh
index 2eddcc7664..3bbabbee49 100755
--- a/t/t6415-merge-dir-to-symlink.sh
+++ b/t/t6415-merge-dir-to-symlink.sh
@@ -19,7 +19,7 @@ test_expect_success 'create a commit where dir a/b changed to symlink' '
 
 test_expect_success 'checkout does not clobber untracked symlink' '
 	git checkout HEAD^0 &&
-	git reset --hard master &&
+	git reset --hard main &&
 	git rm --cached a/b &&
 	git commit -m "untracked symlink remains" &&
 	test_must_fail git checkout start^0
@@ -27,7 +27,7 @@ test_expect_success 'checkout does not clobber untracked symlink' '
 
 test_expect_success 'a/b-2/c/d is kept when clobbering symlink b' '
 	git checkout HEAD^0 &&
-	git reset --hard master &&
+	git reset --hard main &&
 	git rm --cached a/b &&
 	git commit -m "untracked symlink remains" &&
 	git checkout -f start^0 &&
@@ -36,7 +36,7 @@ test_expect_success 'a/b-2/c/d is kept when clobbering symlink b' '
 
 test_expect_success 'checkout should not have deleted a/b-2/c/d' '
 	git checkout HEAD^0 &&
-	git reset --hard master &&
+	git reset --hard main &&
 	 git checkout start^0 &&
 	 test_path_is_file a/b-2/c/d
 '
@@ -53,7 +53,7 @@ test_expect_success 'setup for merge test' '
 test_expect_success 'Handle D/F conflict, do not lose a/b-2/c/d in merge (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
-	git merge -s resolve master &&
+	git merge -s resolve main &&
 	test_path_is_file a/b-2/c/d
 '
 
@@ -64,7 +64,7 @@ test_expect_success SYMLINKS 'a/b was resolved as symlink' '
 test_expect_success 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
-	git merge -s recursive master &&
+	git merge -s recursive main &&
 	test_path_is_file a/b-2/c/d
 '
 
@@ -74,7 +74,7 @@ test_expect_success SYMLINKS 'a/b was resolved as symlink' '
 
 test_expect_success 'Handle F/D conflict, do not lose a/b-2/c/d in merge (resolve)' '
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	git merge -s resolve baseline^0 &&
 	test_path_is_file a/b-2/c/d
 '
@@ -85,7 +85,7 @@ test_expect_success SYMLINKS 'a/b was resolved as symlink' '
 
 test_expect_success 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	git merge -s recursive baseline^0 &&
 	test_path_is_file a/b-2/c/d
 '
@@ -98,7 +98,7 @@ test_expect_failure 'do not lose untracked in merge (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	>a/b/c/e &&
-	test_must_fail git merge -s resolve master &&
+	test_must_fail git merge -s resolve main &&
 	test_path_is_file a/b/c/e &&
 	test_path_is_file a/b-2/c/d
 '
@@ -107,7 +107,7 @@ test_expect_success 'do not lose untracked in merge (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	>a/b/c/e &&
-	test_must_fail git merge -s recursive master &&
+	test_must_fail git merge -s recursive main &&
 	test_path_is_file a/b/c/e &&
 	test_path_is_file a/b-2/c/d
 '
@@ -116,14 +116,14 @@ test_expect_success 'do not lose modifications in merge (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	echo more content >>a/b/c/d &&
-	test_must_fail git merge -s resolve master
+	test_must_fail git merge -s resolve main
 '
 
 test_expect_success 'do not lose modifications in merge (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	echo more content >>a/b/c/d &&
-	test_must_fail git merge -s recursive master
+	test_must_fail git merge -s recursive main
 '
 
 test_expect_success 'setup a merge where dir a/b-2 changed to symlink' '
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index dbccc3158a..b43ecb38b7 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -385,7 +385,7 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete' '
 		test_line_count = 2 out &&
 
 		git rev-parse >expect       \
-			master:file    B:file &&
+			main:file    B:file &&
 		git rev-parse   >actual      \
 			:1:file      :2:file &&
 		test_cmp expect actual
@@ -407,7 +407,7 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
 		test_line_count = 2 out &&
 
 		git rev-parse >expect       \
-			master:file    B:file &&
+			main:file    B:file &&
 		git rev-parse   >actual      \
 			:1:file      :3:file &&
 		test_cmp expect actual
@@ -1553,12 +1553,12 @@ test_expect_failure 'check conflicting modes for regular file' '
 # Setup:
 #          L1---L2
 #         /  \ /  \
-#     master    X    ?
+#     main    X    ?
 #         \  / \  /
 #          R1---R2
 #
 # Where:
-#   master has two files, named 'b' and 'a'
+#   main has two files, named 'b' and 'a'
 #   branches L1 and R1 both modify each of the two files in conflicting ways
 #
 #   L2 is a merge of R1 into L1; more on it later.
@@ -1663,7 +1663,7 @@ test_expect_success 'check nested conflicts' '
 		cd nested_conflicts &&
 
 		git clean -f &&
-		MASTER=$(git rev-parse --short master) &&
+		MAIN=$(git rev-parse --short main) &&
 		git checkout L2^0 &&
 
 		# Merge must fail; there is a conflict
@@ -1679,24 +1679,24 @@ test_expect_success 'check nested conflicts' '
 		test_line_count = 1 out &&
 
 		# Create a and b from virtual merge base X
-		git cat-file -p master:a >base &&
+		git cat-file -p main:a >base &&
 		git cat-file -p L1:a >ours &&
 		git cat-file -p R1:a >theirs &&
 		test_must_fail git merge-file --diff3 \
 			-L "Temporary merge branch 1" \
-			-L "$MASTER"  \
+			-L "$MAIN"  \
 			-L "Temporary merge branch 2" \
 			ours  \
 			base  \
 			theirs &&
 		sed -e "s/^\([<|=>]\)/\1\1/" ours >vmb_a &&
 
-		git cat-file -p master:b >base &&
+		git cat-file -p main:b >base &&
 		git cat-file -p L1:b >ours &&
 		git cat-file -p R1:b >theirs &&
 		test_must_fail git merge-file --diff3 \
 			-L "Temporary merge branch 1" \
-			-L "$MASTER"  \
+			-L "$MAIN"  \
 			-L "Temporary merge branch 2" \
 			ours  \
 			base  \
@@ -1748,12 +1748,12 @@ test_expect_success 'check nested conflicts' '
 # Setup:
 #          L1---L2---L3
 #         /  \ /  \ /  \
-#     master    X1   X2   ?
+#     main    X1   X2   ?
 #         \  / \  / \  /
 #          R1---R2---R3
 #
 # Where:
-#   master has one file named 'content'
+#   main has one file named 'content'
 #   branches L1 and R1 both modify each of the two files in conflicting ways
 #
 #   L<n> (n>1) is a merge of R<n-1> into L<n-1>
@@ -1834,7 +1834,7 @@ test_expect_success 'check virtual merge base with nested conflicts' '
 	(
 		cd virtual_merge_base_has_nested_conflicts &&
 
-		MASTER=$(git rev-parse --short master) &&
+		MAIN=$(git rev-parse --short main) &&
 		git checkout L3^0 &&
 
 		# Merge must fail; there is a conflict
@@ -1857,13 +1857,13 @@ test_expect_success 'check virtual merge base with nested conflicts' '
 		# Imitate X1 merge base, except without long enough conflict
 		# markers because a subsequent sed will modify them.  Put
 		# result into vmb.
-		git cat-file -p master:content >base &&
+		git cat-file -p main:content >base &&
 		git cat-file -p L:content >left &&
 		git cat-file -p R:content >right &&
 		cp left merged-once &&
 		test_must_fail git merge-file --diff3 \
 			-L "Temporary merge branch 1" \
-			-L "$MASTER"  \
+			-L "$MAIN"  \
 			-L "Temporary merge branch 2" \
 			merged-once \
 			base        \
diff --git a/t/t6417-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
index 0aebc6c028..4bb77b9779 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -20,11 +20,11 @@ test_expect_success setup '
 	sed -e "s/9/nueve/" >file <elif &&
 	git commit -a -m theirs &&
 
-	git checkout master^0
+	git checkout main^0
 '
 
 test_expect_success 'plain recursive - should conflict' '
-	git reset --hard master &&
+	git reset --hard main &&
 	test_must_fail git merge -s recursive side &&
 	grep nine file &&
 	grep nueve file &&
@@ -34,7 +34,7 @@ test_expect_success 'plain recursive - should conflict' '
 '
 
 test_expect_success 'recursive favouring theirs' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git merge -s recursive -Xtheirs side &&
 	! grep nine file &&
 	grep nueve file &&
@@ -44,7 +44,7 @@ test_expect_success 'recursive favouring theirs' '
 '
 
 test_expect_success 'recursive favouring ours' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git merge -s recursive -X ours side &&
 	grep nine file &&
 	! grep nueve file &&
@@ -56,26 +56,26 @@ test_expect_success 'recursive favouring ours' '
 test_expect_success 'binary file with -Xours/-Xtheirs' '
 	echo file binary >.gitattributes &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git merge -s recursive -X theirs side &&
 	git diff --exit-code side HEAD -- file &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git merge -s recursive -X ours side &&
-	git diff --exit-code master HEAD -- file
+	git diff --exit-code main HEAD -- file
 '
 
 test_expect_success 'pull passes -X to underlying merge' '
-	git reset --hard master && git pull -s recursive -Xours . side &&
-	git reset --hard master && git pull -s recursive -X ours . side &&
-	git reset --hard master && git pull -s recursive -Xtheirs . side &&
-	git reset --hard master && git pull -s recursive -X theirs . side &&
-	git reset --hard master && test_must_fail git pull -s recursive -X bork . side
+	git reset --hard main && git pull -s recursive -Xours . side &&
+	git reset --hard main && git pull -s recursive -X ours . side &&
+	git reset --hard main && git pull -s recursive -Xtheirs . side &&
+	git reset --hard main && git pull -s recursive -X theirs . side &&
+	git reset --hard main && test_must_fail git pull -s recursive -X bork . side
 '
 
 test_expect_success SYMLINKS 'symlink with -Xours/-Xtheirs' '
-	git reset --hard master &&
-	git checkout -b two master &&
+	git reset --hard main &&
+	git checkout -b two main &&
 	ln -s target-zero link &&
 	git add link &&
 	git commit -m "add link pointing to zero" &&
diff --git a/t/t6418-merge-text-auto.sh b/t/t6418-merge-text-auto.sh
index 30983d18b1..b8df80d2df 100755
--- a/t/t6418-merge-text-auto.sh
+++ b/t/t6418-merge-text-auto.sh
@@ -2,13 +2,13 @@
 
 test_description='CRLF merge conflict across text=auto change
 
-* [master] remove .gitattributes
+* [main] remove .gitattributes
  ! [side] add line from b
 --
  + [side] add line from b
-*  [master] remove .gitattributes
-*  [master^] add line from a
-*  [master~2] normalize file
+*  [main] remove .gitattributes
+*  [main^] add line from a
+*  [main~2] normalize file
 *+ [side^] Initial
 '
 
@@ -64,7 +64,7 @@ test_expect_success setup '
 	git commit -m "add line from b" &&
 	git tag b &&
 
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'set up fuzz_conflict() helper' '
@@ -195,7 +195,7 @@ test_expect_success 'Test delete/normalize conflict' '
 	git reset --hard initial &&
 	git rm file &&
 	git commit -m "remove file" &&
-	git checkout master &&
+	git checkout main &&
 	git reset --hard a^ &&
 	git merge side &&
 	test_path_is_missing file
diff --git a/t/t6419-merge-ignorecase.sh b/t/t6419-merge-ignorecase.sh
index 531850d834..d32bbb3359 100755
--- a/t/t6419-merge-ignorecase.sh
+++ b/t/t6419-merge-ignorecase.sh
@@ -20,18 +20,18 @@ test_expect_success 'merge with case-changing rename' '
 	>foo &&
 	git add foo &&
 	git commit -m "intervening commit" &&
-	git checkout master &&
+	git checkout main &&
 	git rm TestCase &&
 	>testcase &&
 	git add testcase &&
 	git commit -m "rename to testcase" &&
 	git checkout with-camel &&
-	git merge master -m "merge" &&
+	git merge main -m "merge" &&
 	test_path_is_file testcase
 '
 
 test_expect_success 'merge with case-changing rename on both sides' '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard baseline &&
 	git branch -D with-camel &&
 	git checkout -b with-camel &&
@@ -40,13 +40,13 @@ test_expect_success 'merge with case-changing rename on both sides' '
 	>foo &&
 	git add foo &&
 	git commit -m "intervening commit" &&
-	git checkout master &&
+	git checkout main &&
 	git rm TestCase &&
 	>testcase &&
 	git add testcase &&
 	git commit -m "rename to testcase" &&
 	git checkout with-camel &&
-	git merge master -m "merge" &&
+	git merge main -m "merge" &&
 	test_path_is_file testcase
 '
 
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index e40a1b686f..21c64b51be 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -1130,7 +1130,7 @@ test_conflicts_with_adds_and_renames() {
 	# Setup:
 	#          L
 	#         / \
-	#     master   ?
+	#     main   ?
 	#         \ /
 	#          R
 	#
@@ -1260,7 +1260,7 @@ test_conflicts_with_adds_and_renames() {
 				:2:three           \
 				:3:three           &&
 			git rev-parse >expected        \
-				master:irrelevant_file \
+				main:irrelevant_file \
 				file_v2                \
 				file_v4                &&
 			test_cmp expected actual &&
@@ -1290,12 +1290,12 @@ test_conflicts_with_adds_and_renames add    add
 # Setup:
 #          L
 #         / \
-#     master   ?
+#     main   ?
 #         \ /
 #          R
 #
 # Where:
-#   master has two files, named 'one' and 'two'.
+#   main has two files, named 'one' and 'two'.
 #   branches L and R both modify 'one', in conflicting ways.
 #   branches L and R both modify 'two', in conflicting ways.
 #   branch L also renames 'one' to 'three'.
@@ -1376,7 +1376,7 @@ test_expect_success 'check nested conflicts from rename/rename(2to1)' '
 		test_line_count = 1 out &&
 
 		# Compare :2:three to expected values
-		git cat-file -p master:one >base &&
+		git cat-file -p main:one >base &&
 		git cat-file -p L:three >ours &&
 		git cat-file -p R:one >theirs &&
 		test_must_fail git merge-file    \
@@ -1387,7 +1387,7 @@ test_expect_success 'check nested conflicts from rename/rename(2to1)' '
 		test_cmp expect L-three &&
 
 		# Compare :2:three to expected values
-		git cat-file -p master:two >base &&
+		git cat-file -p main:two >base &&
 		git cat-file -p L:two >ours &&
 		git cat-file -p R:three >theirs &&
 		test_must_fail git merge-file    \
diff --git a/t/t6425-merge-rename-delete.sh b/t/t6425-merge-rename-delete.sh
index f79d021590..2d39bf630e 100755
--- a/t/t6425-merge-rename-delete.sh
+++ b/t/t6425-merge-rename-delete.sh
@@ -12,7 +12,7 @@ test_expect_success 'rename/delete' '
 	git mv A B &&
 	git commit -m "rename" &&
 
-	git checkout master &&
+	git checkout main &&
 	git rm A &&
 	git commit -m "delete" &&
 
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index f7620e677c..b28966d0f4 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -43,7 +43,7 @@ test_expect_success 'check no merge base' '
 # Setup:
 #          L1
 #         /  \
-#     master    ?
+#     main    ?
 #         \  /
 #          R1
 #
@@ -90,18 +90,18 @@ test_expect_success 'check unique merge base' '
 		cd unique_merge_base &&
 
 		git checkout L^0 &&
-		MASTER=$(git rev-parse --short master) &&
+		MAIN=$(git rev-parse --short main) &&
 
 		test_must_fail git -c merge.conflictstyle=diff3 merge -s recursive R^0 &&
 
-		grep "|||||| $MASTER:content" renamed
+		grep "|||||| $MAIN:content" renamed
 	)
 '
 
 # Setup:
 #          L1---L2--L3
 #         /  \ /      \
-#     master    X1       ?
+#     main    X1       ?
 #         \  / \      /
 #          R1---R2--R3
 #
@@ -191,10 +191,10 @@ test_expect_success 'rebase --merge describes parent of commit being picked' '
 	(
 		cd rebase &&
 		test_commit base file &&
-		test_commit master file &&
+		test_commit main file &&
 		git checkout -b side HEAD^ &&
 		test_commit side file &&
-		test_must_fail git -c merge.conflictstyle=diff3 rebase --merge master &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase --merge main &&
 		grep "||||||| parent of" file
 	)
 '
@@ -203,7 +203,7 @@ test_expect_success 'rebase --apply describes fake ancestor base' '
 	(
 		cd rebase &&
 		git rebase --abort &&
-		test_must_fail git -c merge.conflictstyle=diff3 rebase --apply master &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase --apply main &&
 		grep "||||||| constructed merge base" file
 	)
 '
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index 9c08e63af2..4bc8cc764b 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -35,7 +35,7 @@ test_expect_success 'setup 1' '
 	git add a d/e &&
 
 	test_tick &&
-	git commit -m "master modifies a and d/e" &&
+	git commit -m "main modifies a and d/e" &&
 	c1=$(git rev-parse --verify HEAD) &&
 	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
@@ -466,7 +466,7 @@ test_expect_success SYMLINKS 'dir in working tree with symlink ancestor does not
 		git checkout -b branch1 &&
 		git commit --allow-empty -m "empty commit" &&
 
-		git checkout master &&
+		git checkout main &&
 		git rm foo &&
 		mkdir foo &&
 		>foo/bar &&
@@ -475,7 +475,7 @@ test_expect_success SYMLINKS 'dir in working tree with symlink ancestor does not
 
 		git checkout branch1 &&
 
-		git cherry-pick master &&
+		git cherry-pick main &&
 		test_path_is_dir foo &&
 		test_path_is_file foo/bar
 	)
@@ -490,8 +490,8 @@ test_expect_success 'reset and 3-way merge' '
 
 test_expect_success 'reset and bind merge' '
 
-	git reset --hard master &&
-	git read-tree --prefix=M/ master &&
+	git reset --hard main &&
+	git read-tree --prefix=M/ main &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o1 0	M/a" &&
@@ -505,7 +505,7 @@ test_expect_success 'reset and bind merge' '
 	) >expected &&
 	test_cmp expected actual &&
 
-	git read-tree --prefix=a1/ master &&
+	git read-tree --prefix=a1/ main &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o1 0	M/a" &&
@@ -523,7 +523,7 @@ test_expect_success 'reset and bind merge' '
 	) >expected &&
 	test_cmp expected actual &&
 
-	git read-tree --prefix=z/ master &&
+	git read-tree --prefix=z/ main &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o1 0	M/a" &&
@@ -599,11 +599,11 @@ test_expect_success 'merge-recursive w/ empty work tree - theirs has rename' '
 
 test_expect_success 'merge removes empty directories' '
 
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b rm &&
 	git rm d/e &&
 	git commit -mremoved-d/e &&
-	git checkout master &&
+	git checkout main &&
 	git merge -s recursive rm &&
 	test_path_is_missing d
 '
diff --git a/t/t6432-merge-recursive-space-options.sh b/t/t6432-merge-recursive-space-options.sh
index b56180ee4a..4eda1dd444 100755
--- a/t/t6432-merge-recursive-space-options.sh
+++ b/t/t6432-merge-recursive-space-options.sh
@@ -2,11 +2,11 @@
 
 test_description='merge-recursive space options
 
-* [master] Clarify
+* [main] Clarify
  ! [remote] Remove cruft
 --
  + [remote] Remove cruft
-*  [master] Clarify
+*  [main] Clarify
 *+ [remote^] Initial revision
 *   ok 1: setup
 '
@@ -87,7 +87,7 @@ test_expect_success 'setup' '
 	mv text.txt+ text.txt &&
 	git commit -a -m "Remove cruft" &&
 
-	git checkout master &&
+	git checkout main &&
 	sed -e "
 			s/\(not in his right mind\),\(.*\)/\1;\2Q/
 			s/Quite correct\(.*\)/It is too correct\1Q/
diff --git a/t/t6433-merge-toplevel.sh b/t/t6433-merge-toplevel.sh
index e29c284b9b..fdbd095cde 100755
--- a/t/t6433-merge-toplevel.sh
+++ b/t/t6433-merge-toplevel.sh
@@ -5,7 +5,7 @@ test_description='"git merge" top-level frontend'
 . ./test-lib.sh
 
 t3033_reset () {
-	git checkout -B master two &&
+	git checkout -B main two &&
 	git branch -f left three &&
 	git branch -f right four
 }
@@ -21,7 +21,7 @@ test_expect_success setup '
 	test_commit four &&
 	git checkout --orphan newroot &&
 	test_commit five &&
-	git checkout master
+	git checkout main
 '
 
 # Local branches
@@ -61,7 +61,7 @@ test_expect_success 'merge octopus, non-fast-forward (ff)' '
 test_expect_success 'merge octopus, fast-forward (does not ff)' '
 	t3033_reset &&
 	git merge left right &&
-	# two (master) is not an ancestor of three (left) and four (right)
+	# two (main) is not an ancestor of three (left) and four (right)
 	test_must_fail git rev-parse --verify HEAD^4 &&
 	git rev-parse HEAD^1 HEAD^2 HEAD^3 | sort >actual &&
 	git rev-parse two three four | sort >expect &&
@@ -118,7 +118,7 @@ test_expect_success 'merge FETCH_HEAD octopus fast-forward (does not ff)' '
 	t3033_reset &&
 	git fetch . left right &&
 	git merge FETCH_HEAD &&
-	# two (master) is not an ancestor of three (left) and four (right)
+	# two (main) is not an ancestor of three (left) and four (right)
 	test_must_fail git rev-parse --verify HEAD^4 &&
 	git rev-parse HEAD^1 HEAD^2 HEAD^3 | sort >actual &&
 	git rev-parse two three four | sort >expect &&
diff --git a/t/t6434-merge-recursive-rename-options.sh b/t/t6434-merge-recursive-rename-options.sh
index 3d9fae68c4..1203984101 100755
--- a/t/t6434-merge-recursive-rename-options.sh
+++ b/t/t6434-merge-recursive-rename-options.sh
@@ -5,11 +5,11 @@ test_description='merge-recursive rename options
 Test rename detection by examining rename/delete conflicts.
 
 * (HEAD -> rename) rename
-| * (master) delete
+| * (main) delete
 |/
 * base
 
-git diff --name-status base master
+git diff --name-status base main
 D	0-old
 D	1-old
 D	2-old
@@ -118,7 +118,7 @@ test_expect_success 'setup repo' '
 	get_expected_stages 2 &&
 	get_expected_stages 3 &&
 	check_50="false" &&
-	tail="HEAD^ -- HEAD master"
+	tail="HEAD^ -- HEAD main"
 '
 
 test_expect_success 'setup thresholds' '
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index dd9376842f..8efe96dc8c 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -193,7 +193,7 @@ test_expect_success 'set up unborn branch and content' '
 '
 
 test_expect_success 'will not clobber WT/index when merging into unborn' '
-	git merge master &&
+	git merge main &&
 	grep foo tracked-file &&
 	git show :tracked-file >expect &&
 	grep foo expect &&
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 3ead2b726f..d71e9410b9 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -27,7 +27,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m root &&
 
-	git checkout -b a master &&
+	git checkout -b a main &&
 	(cd sub &&
 	 echo A > file &&
 	 git add file &&
@@ -37,7 +37,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m a &&
 
-	git checkout -b b master &&
+	git checkout -b b main &&
 	(cd sub &&
 	 echo B > file &&
 	 git add file &&
@@ -254,22 +254,22 @@ test_expect_success 'setup for recursive merge with submodule' '
 	 (cd sub &&
 	  git init &&
 	  test_commit a &&
-	  git checkout -b sub-b master &&
+	  git checkout -b sub-b main &&
 	  test_commit b &&
-	  git checkout -b sub-c master &&
+	  git checkout -b sub-c main &&
 	  test_commit c &&
 	  git checkout -b sub-bc sub-b &&
 	  git merge sub-c &&
 	  git checkout -b sub-cb sub-c &&
 	  git merge sub-b &&
-	  git checkout master) &&
+	  git checkout main) &&
 	 git add sub &&
 	 git commit -m a &&
-	 git checkout -b top-b master &&
+	 git checkout -b top-b main &&
 	 (cd sub && git checkout sub-b) &&
 	 git add sub &&
 	 git commit -m b &&
-	 git checkout -b top-c master &&
+	 git checkout -b top-c main &&
 	 (cd sub && git checkout sub-c) &&
 	 git add sub &&
 	 git commit -m c &&
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 5c8894d94f..cd87fe6dd4 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -18,7 +18,7 @@ test_expect_success 'setup' '
 	git add two three four five &&
 	git commit -m Second &&
 
-	git checkout master &&
+	git checkout main &&
 	echo other >two &&
 	echo other >three &&
 	echo other >four &&
@@ -83,7 +83,7 @@ test_expect_success 'cannot switch branches because of local changes' '
 	echo two >rep/two &&
 	git add rep/one rep/two &&
 	git commit -m Fourth &&
-	git checkout master &&
+	git checkout main &&
 	echo uno >rep/one &&
 	echo dos >rep/two &&
 	test_must_fail git checkout branch 2>out &&
@@ -128,7 +128,7 @@ test_expect_success 'not_uptodate_dir porcelain checkout error' '
 	>rep2 &&
 	git add rep rep2 &&
 	git commit -m "added test as a file" &&
-	git checkout master &&
+	git checkout main &&
 	>rep/untracked-file &&
 	>rep2/untracked-file &&
 	test_must_fail git checkout branch 2>out &&
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 8a3bb4105b..2f2b89f229 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -67,7 +67,7 @@ for repack in '' true; do
 		git checkout -b experiment &&
 		commit abandon &&
 		maybe_repack &&
-		git checkout master &&
+		git checkout main &&
 		git branch -D experiment
 	'
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 307b75eafe..44b4bba0cb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,7 @@ case "$TEST_NUMBER" in
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-5]*|6[0-3]*)
+[0-6]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

