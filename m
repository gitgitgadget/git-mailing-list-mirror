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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE900C8300C
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D525246BB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vauMgSEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgKRXpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgKRXpN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:13 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A378CC0617A7
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:11 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o15so4325928wru.6
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0LOGttpXAtJOoddKxUkAVphiF7vr+KCq+STs3+9YsRE=;
        b=vauMgSEIrqPFHGvAwjFslPzU+DzHIiXYty4QDDkZAjbbFwEzbRO6RABvkyhbyUVrD0
         JwB30OVP1b+dP7CJVqpILNw/j0mqUMiUwMWit7yt0RAooOHCT1OxJAlejqGMZ+dlg0K2
         DYleu19LOwrK15ZV5WiM/1PspX641UefJ9wHfzml+sZ4AqIK4EU41rOOF9dNkVpVhjo/
         TvjA5QZe52dwowhi6wZJfCtW6zlVuFm+lW1wwBEcTe8sUxyhDg3RXvRKAy+UcKOjoghQ
         C6EJo4Rr1SnwziNYLBRL+7BzngFD27YKBPEYLVoOjCbFuf2lBUDNMPOJtFF/M+nfl4eK
         UDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0LOGttpXAtJOoddKxUkAVphiF7vr+KCq+STs3+9YsRE=;
        b=hH8PQy0O18S0nrlhsqSN6HA8LQzwihO9WTmYoqOXnLwff/5C0wEG48zVmo+6sU9IED
         MPqueaMTOPgUmOKduexdpZBSCXRtDq0FdyFyOnVZBG8jrOVGe4s8qGGWSnm0od1K6lpu
         ao/Ehm9fz7c0Y0czMek9bSC/7Y2PxdJqcBgIJEDLnEn1OpWHAscgqU9JTIqbmd2DDzla
         HQ9+ld1feNPIsx6zZd97MujKEqZKxXa2sL0lY1JCUbFdmhKdLXxbDCrEmHRmkgoxck6J
         xWRQk0wX8eY4fAXeZ+zGM7/g1BaGdwu37pvgq3gUHH3GwrQnmfI4jAQnGGBrSooORtTX
         numA==
X-Gm-Message-State: AOAM533ZbW99up7eTqRrqDkMmhwM2RmA4Olkv/W6NDzE4gINCTRkLVV4
        gBUsqSarZKcn4brG+3xcxVyAi1SB0oM=
X-Google-Smtp-Source: ABdhPJyXEAvsPadJwMBFPI4Wdq5PxfF1u+JQsTgcr/O4uZ1mYbA2mYCJmjSdBhRCfUdykZrQNPvOEg==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr6863980wru.44.1605743109382;
        Wed, 18 Nov 2020 15:45:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm35284561wrn.55.2020.11.18.15.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:08 -0800 (PST)
Message-Id: <3dbc83c6a16e9d579c540852a486d94fbb70cfb2.1605743088.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:38 +0000
Subject: [PATCH v3 20/28] t6[4-9]*: adjust the references to the default
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
		-e 's/Master/Main/g' -- t6[4-9]*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6400-merge-df.sh                       |  8 ++--
 t/t6402-merge-rename.sh                   | 48 +++++++++++------------
 t/t6404-recursive-merge.sh                |  6 +--
 t/t6405-merge-symlinks.sh                 | 16 ++++----
 t/t6406-merge-attr.sh                     | 26 ++++++------
 t/t6407-merge-binary.sh                   |  8 ++--
 t/t6409-merge-subtree.sh                  | 18 ++++-----
 t/t6411-merge-filemode.sh                 | 12 +++---
 t/t6412-merge-large-rename.sh             |  8 ++--
 t/t6413-merge-crlf.sh                     |  4 +-
 t/t6414-merge-rename-nocruft.sh           |  4 +-
 t/t6415-merge-dir-to-symlink.sh           | 24 ++++++------
 t/t6416-recursive-corner-cases.sh         | 30 +++++++-------
 t/t6417-merge-ours-theirs.sh              | 30 +++++++-------
 t/t6418-merge-text-auto.sh                | 14 +++----
 t/t6419-merge-ignorecase.sh               | 12 +++---
 t/t6422-merge-rename-corner-cases.sh      | 14 +++----
 t/t6425-merge-rename-delete.sh            |  4 +-
 t/t6427-diff3-conflict-markers.sh         | 16 ++++----
 t/t6430-merge-recursive.sh                | 20 +++++-----
 t/t6432-merge-recursive-space-options.sh  |  8 ++--
 t/t6433-merge-toplevel.sh                 | 10 ++---
 t/t6434-merge-recursive-rename-options.sh |  8 ++--
 t/t6436-merge-overwrite.sh                |  4 +-
 t/t6437-submodule-merge.sh                | 16 ++++----
 t/t6439-merge-co-error-msgs.sh            |  8 ++--
 t/t6501-freshen-objects.sh                |  4 +-
 27 files changed, 190 insertions(+), 190 deletions(-)

diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 5fab2d2dd7..38700d29b5 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -4,7 +4,7 @@
 #
 
 test_description='Test merge with directory/file conflicts'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -27,12 +27,12 @@ test_expect_success 'prepare repository' '
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
@@ -50,7 +50,7 @@ test_expect_success 'F/D conflict' '
 	git add . &&
 	git commit -m para &&
 
-	git merge master
+	git merge main
 '
 
 test_expect_success 'setup modify/delete + directory/file conflict' '
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 227c2feb08..425dad97d5 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='Merge-recursive merging renames'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -57,9 +57,9 @@ test_expect_success 'setup' '
 	git branch change &&
 	git branch change+rename &&
 
-	sed -e "/^g /s/.*/g : master changes a line/" <A >A+ &&
+	sed -e "/^g /s/.*/g : main changes a line/" <A >A+ &&
 	mv A+ A &&
-	git commit -a -m "master updates A" &&
+	git commit -a -m "main updates A" &&
 
 	git checkout yellow &&
 	rm -f M &&
@@ -97,7 +97,7 @@ test_expect_success 'setup' '
 	git update-index --add B &&
 	git commit -q -a -m "changed and renamed" &&
 
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'pull renaming branch into unrenaming one' \
@@ -112,7 +112,7 @@ test_expect_success 'pull renaming branch into unrenaming one' \
 	sed -ne "/^g/{
 	p
 	q
-	}" B | grep master &&
+	}" B | grep main &&
 	git diff --exit-code white N
 '
 
@@ -137,7 +137,7 @@ test_expect_success 'pull unrenaming branch into renaming one' \
 '
 	git reset --hard &&
 	git show-branch &&
-	test_expect_code 1 git pull . master &&
+	test_expect_code 1 git pull . main &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
 	git ls-files -s N >n.stages &&
@@ -190,7 +190,7 @@ test_expect_success 'interference with untracked working tree file' '
 test_expect_success 'interference with untracked working tree file' '
 	git reset --hard &&
 	rm -f A M &&
-	git checkout -f master &&
+	git checkout -f main &&
 	git tag -f anchor &&
 	git show-branch &&
 	git pull . yellow &&
@@ -201,7 +201,7 @@ test_expect_success 'interference with untracked working tree file' '
 test_expect_success 'updated working tree file should prevent the merge' '
 	git reset --hard &&
 	rm -f A M &&
-	git checkout -f master &&
+	git checkout -f main &&
 	git tag -f anchor &&
 	git show-branch &&
 	echo >>M one line addition &&
@@ -214,7 +214,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 test_expect_success 'updated working tree file should prevent the merge' '
 	git reset --hard &&
 	rm -f A M &&
-	git checkout -f master &&
+	git checkout -f main &&
 	git tag -f anchor &&
 	git show-branch &&
 	echo >>M one line addition &&
@@ -232,7 +232,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git tag -f anchor &&
 	git show-branch &&
 	echo >M this file should not matter &&
-	git pull . master &&
+	git pull . main &&
 	test_path_is_file M &&
 	! {
 		git ls-files -s |
@@ -767,7 +767,7 @@ test_expect_success 'setup avoid unnecessary update, dir->(file,nothing)' '
 	git rm -rf df &&
 	git commit -mB &&
 
-	git checkout master &&
+	git checkout main &&
 	git rm -rf df &&
 	echo bla >df &&
 	git add -A &&
@@ -775,7 +775,7 @@ test_expect_success 'setup avoid unnecessary update, dir->(file,nothing)' '
 '
 
 test_expect_success 'avoid unnecessary update, dir->(file,nothing)' '
-	git checkout -q master^0 &&
+	git checkout -q main^0 &&
 	test-tool chmtime --get -3600 df >expect &&
 	git merge side &&
 	test-tool chmtime --get df >actual &&
@@ -797,14 +797,14 @@ test_expect_success 'setup avoid unnecessary update, modify/delete' '
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
@@ -826,13 +826,13 @@ test_expect_success 'setup avoid unnecessary update, rename/add-dest' '
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
@@ -882,15 +882,15 @@ test_expect_success 'setup for use of extended merge markers' '
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
@@ -905,14 +905,14 @@ test_expect_success 'merge master into rename has correct extended markers' '
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
@@ -948,13 +948,13 @@ test_expect_success 'setup spurious "refusing to lose untracked" message' '
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
index bdf8169456..c7ab7048f5 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='Test merge without common ancestors'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -22,11 +22,11 @@ test_expect_success 'setup tests' '
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
index 140e9e6ce6..7435fce71e 100755
--- a/t/t6405-merge-symlinks.sh
+++ b/t/t6405-merge-symlinks.sh
@@ -8,7 +8,7 @@ test_description='merging symlinks on filesystem w/o symlink support.
 This tests that git merge-recursive writes merge results as plain files
 if core.symlinks is false.'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup' '
 	git branch b-file &&
 	l=$(printf file | git hash-object -t blob -w --stdin) &&
 	echo "120000 $l	symlink" | git update-index --index-info &&
-	git commit -m master &&
+	git commit -m main &&
 	git checkout b-symlink &&
 	l=$(printf file-different | git hash-object -t blob -w --stdin) &&
 	echo "120000 $l	symlink" | git update-index --index-info &&
@@ -33,28 +33,28 @@ test_expect_success 'setup' '
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
index 7fe4034d58..d5a4ac2d81 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -5,7 +5,7 @@
 
 test_description='per path merge controlled by merge attribute'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -22,10 +22,10 @@ test_expect_success setup '
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
@@ -67,7 +67,7 @@ test_expect_success merge '
 		echo "union merge=union"
 	} >.gitattributes &&
 
-	if git merge master
+	if git merge main
 	then
 		echo Gaah, should have conflicted
 		false
@@ -90,7 +90,7 @@ test_expect_success 'check merge result in working tree' '
 	grep "<<<<<<<" text &&
 	cmp binary-orig binary &&
 	! grep "<<<<<<<" union &&
-	grep Master union &&
+	grep Main union &&
 	grep Side union
 
 '
@@ -118,13 +118,13 @@ test_expect_success 'custom merge backend' '
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
@@ -139,7 +139,7 @@ test_expect_success 'custom merge backend' '
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
 
-	if git merge master
+	if git merge main
 	then
 		echo "Eh? should have conflicted"
 		false
@@ -149,9 +149,9 @@ test_expect_success 'custom merge backend' '
 
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
@@ -179,7 +179,7 @@ test_expect_success 'up-to-date merge without common ancestor' '
 	test_tick &&
 	(
 		cd repo1 &&
-		git fetch ../repo2 master &&
+		git fetch ../repo2 main &&
 		git merge --allow-unrelated-histories FETCH_HEAD
 	)
 '
@@ -204,7 +204,7 @@ test_expect_success 'custom merge does not lock index' '
 	# By packaging the command in test_when_finished, we get both
 	# the correctness check and the clean-up.
 	test_when_finished "kill \$(cat sleep.pid)" &&
-	git merge master
+	git merge main
 '
 
 test_done
diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index 826deacfd7..d4273f2575 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -2,7 +2,7 @@
 
 test_description='ask merge-recursive to merge binary files'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 	git ls-files -s a >E0 &&
 	git ls-files -s m | sed -e "s/ 0	/ 3	/" >E3 &&
 	test_tick &&
-	git commit -m "master adds some" &&
+	git commit -m "main adds some" &&
 
 	git checkout side &&
 	echo rezrov >>m &&
@@ -42,7 +42,7 @@ test_expect_success resolve '
 	rm -f a* m* &&
 	git reset --hard anchor &&
 
-	if git merge -s resolve master
+	if git merge -s resolve main
 	then
 		echo Oops, should not have succeeded
 		false
@@ -57,7 +57,7 @@ test_expect_success recursive '
 	rm -f a* m* &&
 	git reset --hard anchor &&
 
-	if git merge -s recursive master
+	if git merge -s recursive main
 	then
 		echo Oops, should not have succeeded
 		false
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index e2c1cfc9fe..d406b2343c 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -2,7 +2,7 @@
 
 test_description='subtree merge strategy'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -17,10 +17,10 @@ test_expect_success setup '
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
 
@@ -39,7 +39,7 @@ test_expect_success 'setup branch sub' '
 '
 
 test_expect_success 'setup topic branch' '
-	git checkout -b topic master &&
+	git checkout -b topic main &&
 	git merge -s ours --no-commit --allow-unrelated-histories sub &&
 	git read-tree --prefix=dir/ -u sub &&
 	git commit -m "initial merge of sub into topic" &&
@@ -80,8 +80,8 @@ test_expect_success 'setup' '
 
 test_expect_success 'initial merge' '
 	git remote add -f gui ../git-gui &&
-	git merge -s ours --no-commit --allow-unrelated-histories gui/master &&
-	git read-tree --prefix=git-gui/ -u gui/master &&
+	git merge -s ours --no-commit --allow-unrelated-histories gui/main &&
+	git read-tree --prefix=git-gui/ -u gui/main &&
 	git commit -m "Merge git-gui as our subdirectory" &&
 	git checkout -b work &&
 	git ls-files -s >actual &&
@@ -111,10 +111,10 @@ test_expect_success 'merge update' '
 
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
index 7b66abfdbb..f54c915d6a 100755
--- a/t/t6411-merge-filemode.sh
+++ b/t/t6411-merge-filemode.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='merge: handle file mode'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -10,11 +10,11 @@ test_expect_success 'set up mode change in one branch' '
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
@@ -42,12 +42,12 @@ do_one_mode resolve b1 a1
 
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
@@ -79,7 +79,7 @@ do_both_modes resolve
 
 test_expect_success 'set up delete/modechange scenario' '
 	git reset --hard &&
-	git checkout -b deletion master &&
+	git checkout -b deletion main &&
 	git rm file1 &&
 	git commit -m deletion
 '
diff --git a/t/t6412-merge-large-rename.sh b/t/t6412-merge-large-rename.sh
index d6840078c4..c50d315722 100755
--- a/t/t6412-merge-large-rename.sh
+++ b/t/t6412-merge-large-rename.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='merging with large rename matrix'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -33,7 +33,7 @@ test_rename() {
 	test_expect_success "rename ($1, $2)" '
 	n='$1' &&
 	expect='$2' &&
-	git checkout -f master &&
+	git checkout -f main &&
 	test_might_fail git branch -D test$n &&
 	git reset --hard initial &&
 	for i in $(count $n); do
@@ -53,8 +53,8 @@ test_rename() {
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
index 3bd8e3e899..affea255fe 100755
--- a/t/t6413-merge-crlf.sh
+++ b/t/t6413-merge-crlf.sh
@@ -8,7 +8,7 @@ test_description='merge conflict in crlf repo
 
 '
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -27,7 +27,7 @@ test_expect_success setup '
 	echo line from b | append_cr >file &&
 	git commit -m "add line from b" file &&
 	git tag b &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'Check "ours" is CRLF' '
diff --git a/t/t6414-merge-rename-nocruft.sh b/t/t6414-merge-rename-nocruft.sh
index 42824dcf49..d7e3c1fa6e 100755
--- a/t/t6414-merge-rename-nocruft.sh
+++ b/t/t6414-merge-rename-nocruft.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='Merge-recursive merging renames'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -68,7 +68,7 @@ test_expect_success 'setup' '
 	git update-index A &&
 	git commit -m "blue modify A" &&
 
-	git checkout master
+	git checkout main
 '
 
 # This test broke in 65ac6e9c3f47807cb603af07a6a9e1a43bc119ae
diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-symlink.sh
index 32c0b62496..2ce104aca7 100755
--- a/t/t6415-merge-dir-to-symlink.sh
+++ b/t/t6415-merge-dir-to-symlink.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='merging when a directory was replaced with a symlink'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -22,7 +22,7 @@ test_expect_success 'create a commit where dir a/b changed to symlink' '
 
 test_expect_success 'checkout does not clobber untracked symlink' '
 	git checkout HEAD^0 &&
-	git reset --hard master &&
+	git reset --hard main &&
 	git rm --cached a/b &&
 	git commit -m "untracked symlink remains" &&
 	test_must_fail git checkout start^0
@@ -30,7 +30,7 @@ test_expect_success 'checkout does not clobber untracked symlink' '
 
 test_expect_success 'a/b-2/c/d is kept when clobbering symlink b' '
 	git checkout HEAD^0 &&
-	git reset --hard master &&
+	git reset --hard main &&
 	git rm --cached a/b &&
 	git commit -m "untracked symlink remains" &&
 	git checkout -f start^0 &&
@@ -39,7 +39,7 @@ test_expect_success 'a/b-2/c/d is kept when clobbering symlink b' '
 
 test_expect_success 'checkout should not have deleted a/b-2/c/d' '
 	git checkout HEAD^0 &&
-	git reset --hard master &&
+	git reset --hard main &&
 	 git checkout start^0 &&
 	 test_path_is_file a/b-2/c/d
 '
@@ -56,7 +56,7 @@ test_expect_success 'setup for merge test' '
 test_expect_success 'Handle D/F conflict, do not lose a/b-2/c/d in merge (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
-	git merge -s resolve master &&
+	git merge -s resolve main &&
 	test_path_is_file a/b-2/c/d
 '
 
@@ -67,7 +67,7 @@ test_expect_success SYMLINKS 'a/b was resolved as symlink' '
 test_expect_success 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
-	git merge -s recursive master &&
+	git merge -s recursive main &&
 	test_path_is_file a/b-2/c/d
 '
 
@@ -77,7 +77,7 @@ test_expect_success SYMLINKS 'a/b was resolved as symlink' '
 
 test_expect_success 'Handle F/D conflict, do not lose a/b-2/c/d in merge (resolve)' '
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	git merge -s resolve baseline^0 &&
 	test_path_is_file a/b-2/c/d
 '
@@ -88,7 +88,7 @@ test_expect_success SYMLINKS 'a/b was resolved as symlink' '
 
 test_expect_success 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	git merge -s recursive baseline^0 &&
 	test_path_is_file a/b-2/c/d
 '
@@ -101,7 +101,7 @@ test_expect_failure 'do not lose untracked in merge (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	>a/b/c/e &&
-	test_must_fail git merge -s resolve master &&
+	test_must_fail git merge -s resolve main &&
 	test_path_is_file a/b/c/e &&
 	test_path_is_file a/b-2/c/d
 '
@@ -110,7 +110,7 @@ test_expect_success 'do not lose untracked in merge (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	>a/b/c/e &&
-	test_must_fail git merge -s recursive master &&
+	test_must_fail git merge -s recursive main &&
 	test_path_is_file a/b/c/e &&
 	test_path_is_file a/b-2/c/d
 '
@@ -119,14 +119,14 @@ test_expect_success 'do not lose modifications in merge (resolve)' '
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
index 3d515a8e31..84f5082366 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -2,7 +2,7 @@
 
 test_description='recursive merge corner cases involving criss-cross merges'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -388,7 +388,7 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete' '
 		test_line_count = 2 out &&
 
 		git rev-parse >expect       \
-			master:file    B:file &&
+			main:file    B:file &&
 		git rev-parse   >actual      \
 			:1:file      :2:file &&
 		test_cmp expect actual
@@ -410,7 +410,7 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
 		test_line_count = 2 out &&
 
 		git rev-parse >expect       \
-			master:file    B:file &&
+			main:file    B:file &&
 		git rev-parse   >actual      \
 			:1:file      :3:file &&
 		test_cmp expect actual
@@ -1556,12 +1556,12 @@ test_expect_failure 'check conflicting modes for regular file' '
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
@@ -1666,7 +1666,7 @@ test_expect_success 'check nested conflicts' '
 		cd nested_conflicts &&
 
 		git clean -f &&
-		MASTER=$(git rev-parse --short master) &&
+		MAIN=$(git rev-parse --short main) &&
 		git checkout L2^0 &&
 
 		# Merge must fail; there is a conflict
@@ -1682,24 +1682,24 @@ test_expect_success 'check nested conflicts' '
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
@@ -1751,12 +1751,12 @@ test_expect_success 'check nested conflicts' '
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
@@ -1837,7 +1837,7 @@ test_expect_success 'check virtual merge base with nested conflicts' '
 	(
 		cd virtual_merge_base_has_nested_conflicts &&
 
-		MASTER=$(git rev-parse --short master) &&
+		MAIN=$(git rev-parse --short main) &&
 		git checkout L3^0 &&
 
 		# Merge must fail; there is a conflict
@@ -1860,13 +1860,13 @@ test_expect_success 'check virtual merge base with nested conflicts' '
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
index e7883f890a..ac9aee9a66 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='Merge-recursive ours and theirs variants'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -23,11 +23,11 @@ test_expect_success setup '
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
@@ -37,7 +37,7 @@ test_expect_success 'plain recursive - should conflict' '
 '
 
 test_expect_success 'recursive favouring theirs' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git merge -s recursive -Xtheirs side &&
 	! grep nine file &&
 	grep nueve file &&
@@ -47,7 +47,7 @@ test_expect_success 'recursive favouring theirs' '
 '
 
 test_expect_success 'recursive favouring ours' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git merge -s recursive -X ours side &&
 	grep nine file &&
 	! grep nueve file &&
@@ -59,26 +59,26 @@ test_expect_success 'recursive favouring ours' '
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
index 91b43de00d..1e0296dd17 100755
--- a/t/t6418-merge-text-auto.sh
+++ b/t/t6418-merge-text-auto.sh
@@ -2,17 +2,17 @@
 
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
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -67,7 +67,7 @@ test_expect_success setup '
 	git commit -m "add line from b" &&
 	git tag b &&
 
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'set up fuzz_conflict() helper' '
@@ -198,7 +198,7 @@ test_expect_success 'Test delete/normalize conflict' '
 	git reset --hard initial &&
 	git rm file &&
 	git commit -m "remove file" &&
-	git checkout master &&
+	git checkout main &&
 	git reset --hard a^ &&
 	git merge side &&
 	test_path_is_missing file
diff --git a/t/t6419-merge-ignorecase.sh b/t/t6419-merge-ignorecase.sh
index 9996a94431..b64b75acf5 100755
--- a/t/t6419-merge-ignorecase.sh
+++ b/t/t6419-merge-ignorecase.sh
@@ -2,7 +2,7 @@
 
 test_description='git-merge with case-changing rename on case-insensitive file system'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -23,18 +23,18 @@ test_expect_success 'merge with case-changing rename' '
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
@@ -43,13 +43,13 @@ test_expect_success 'merge with case-changing rename on both sides' '
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
index 9fb4e72ca3..bf4ce3c63d 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -3,7 +3,7 @@
 test_description="recursive merge corner cases w/ renames but not criss-crosses"
 # t6036 has corner cases that involve both criss-cross merges and renames
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -1133,7 +1133,7 @@ test_conflicts_with_adds_and_renames() {
 	# Setup:
 	#          L
 	#         / \
-	#     master   ?
+	#     main   ?
 	#         \ /
 	#          R
 	#
@@ -1263,7 +1263,7 @@ test_conflicts_with_adds_and_renames() {
 				:2:three           \
 				:3:three           &&
 			git rev-parse >expected        \
-				master:irrelevant_file \
+				main:irrelevant_file \
 				file_v2                \
 				file_v4                &&
 			test_cmp expected actual &&
@@ -1293,12 +1293,12 @@ test_conflicts_with_adds_and_renames add    add
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
@@ -1379,7 +1379,7 @@ test_expect_success 'check nested conflicts from rename/rename(2to1)' '
 		test_line_count = 1 out &&
 
 		# Compare :2:three to expected values
-		git cat-file -p master:one >base &&
+		git cat-file -p main:one >base &&
 		git cat-file -p L:three >ours &&
 		git cat-file -p R:one >theirs &&
 		test_must_fail git merge-file    \
@@ -1390,7 +1390,7 @@ test_expect_success 'check nested conflicts from rename/rename(2to1)' '
 		test_cmp expect L-three &&
 
 		# Compare :2:three to expected values
-		git cat-file -p master:two >base &&
+		git cat-file -p main:two >base &&
 		git cat-file -p L:two >ours &&
 		git cat-file -p R:three >theirs &&
 		test_must_fail git merge-file    \
diff --git a/t/t6425-merge-rename-delete.sh b/t/t6425-merge-rename-delete.sh
index e58e3dfba1..459b431a60 100755
--- a/t/t6425-merge-rename-delete.sh
+++ b/t/t6425-merge-rename-delete.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='Merge-recursive rename/delete conflict message'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -15,7 +15,7 @@ test_expect_success 'rename/delete' '
 	git mv A B &&
 	git commit -m "rename" &&
 
-	git checkout master &&
+	git checkout main &&
 	git rm A &&
 	git commit -m "delete" &&
 
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index 3ae2d07ae1..25c4b720e7 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -2,7 +2,7 @@
 
 test_description='recursive merge diff3 style conflict markers'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -46,7 +46,7 @@ test_expect_success 'check no merge base' '
 # Setup:
 #          L1
 #         /  \
-#     master    ?
+#     main    ?
 #         \  /
 #          R1
 #
@@ -93,18 +93,18 @@ test_expect_success 'check unique merge base' '
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
@@ -194,10 +194,10 @@ test_expect_success 'rebase --merge describes parent of commit being picked' '
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
@@ -206,7 +206,7 @@ test_expect_success 'rebase --apply describes fake ancestor base' '
 	(
 		cd rebase &&
 		git rebase --abort &&
-		test_must_fail git -c merge.conflictstyle=diff3 rebase --apply master &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase --apply main &&
 		grep "||||||| constructed merge base" file
 	)
 '
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index acb2868260..ffcc01fe65 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -2,7 +2,7 @@
 
 test_description='merge-recursive backend test'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -38,7 +38,7 @@ test_expect_success 'setup 1' '
 	git add a d/e &&
 
 	test_tick &&
-	git commit -m "master modifies a and d/e" &&
+	git commit -m "main modifies a and d/e" &&
 	c1=$(git rev-parse --verify HEAD) &&
 	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
@@ -469,7 +469,7 @@ test_expect_success SYMLINKS 'dir in working tree with symlink ancestor does not
 		git checkout -b branch1 &&
 		git commit --allow-empty -m "empty commit" &&
 
-		git checkout master &&
+		git checkout main &&
 		git rm foo &&
 		mkdir foo &&
 		>foo/bar &&
@@ -478,7 +478,7 @@ test_expect_success SYMLINKS 'dir in working tree with symlink ancestor does not
 
 		git checkout branch1 &&
 
-		git cherry-pick master &&
+		git cherry-pick main &&
 		test_path_is_dir foo &&
 		test_path_is_file foo/bar
 	)
@@ -493,8 +493,8 @@ test_expect_success 'reset and 3-way merge' '
 
 test_expect_success 'reset and bind merge' '
 
-	git reset --hard master &&
-	git read-tree --prefix=M/ master &&
+	git reset --hard main &&
+	git read-tree --prefix=M/ main &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o1 0	M/a" &&
@@ -508,7 +508,7 @@ test_expect_success 'reset and bind merge' '
 	) >expected &&
 	test_cmp expected actual &&
 
-	git read-tree --prefix=a1/ master &&
+	git read-tree --prefix=a1/ main &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o1 0	M/a" &&
@@ -526,7 +526,7 @@ test_expect_success 'reset and bind merge' '
 	) >expected &&
 	test_cmp expected actual &&
 
-	git read-tree --prefix=z/ master &&
+	git read-tree --prefix=z/ main &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o1 0	M/a" &&
@@ -602,11 +602,11 @@ test_expect_success 'merge-recursive w/ empty work tree - theirs has rename' '
 
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
index 1333cbb148..db4b77e63d 100755
--- a/t/t6432-merge-recursive-space-options.sh
+++ b/t/t6432-merge-recursive-space-options.sh
@@ -2,16 +2,16 @@
 
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
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -90,7 +90,7 @@ test_expect_success 'setup' '
 	mv text.txt+ text.txt &&
 	git commit -a -m "Remove cruft" &&
 
-	git checkout master &&
+	git checkout main &&
 	sed -e "
 			s/\(not in his right mind\),\(.*\)/\1;\2Q/
 			s/Quite correct\(.*\)/It is too correct\1Q/
diff --git a/t/t6433-merge-toplevel.sh b/t/t6433-merge-toplevel.sh
index 2d51b2d08c..b16031465f 100755
--- a/t/t6433-merge-toplevel.sh
+++ b/t/t6433-merge-toplevel.sh
@@ -2,13 +2,13 @@
 
 test_description='"git merge" top-level frontend'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
 t3033_reset () {
-	git checkout -B master two &&
+	git checkout -B main two &&
 	git branch -f left three &&
 	git branch -f right four
 }
@@ -24,7 +24,7 @@ test_expect_success setup '
 	test_commit four &&
 	git checkout --orphan newroot &&
 	test_commit five &&
-	git checkout master
+	git checkout main
 '
 
 # Local branches
@@ -64,7 +64,7 @@ test_expect_success 'merge octopus, non-fast-forward (ff)' '
 test_expect_success 'merge octopus, fast-forward (does not ff)' '
 	t3033_reset &&
 	git merge left right &&
-	# two (master) is not an ancestor of three (left) and four (right)
+	# two (main) is not an ancestor of three (left) and four (right)
 	test_must_fail git rev-parse --verify HEAD^4 &&
 	git rev-parse HEAD^1 HEAD^2 HEAD^3 | sort >actual &&
 	git rev-parse two three four | sort >expect &&
@@ -121,7 +121,7 @@ test_expect_success 'merge FETCH_HEAD octopus fast-forward (does not ff)' '
 	t3033_reset &&
 	git fetch . left right &&
 	git merge FETCH_HEAD &&
-	# two (master) is not an ancestor of three (left) and four (right)
+	# two (main) is not an ancestor of three (left) and four (right)
 	test_must_fail git rev-parse --verify HEAD^4 &&
 	git rev-parse HEAD^1 HEAD^2 HEAD^3 | sort >actual &&
 	git rev-parse two three four | sort >expect &&
diff --git a/t/t6434-merge-recursive-rename-options.sh b/t/t6434-merge-recursive-rename-options.sh
index 7e877e96e2..a11707835b 100755
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
@@ -26,7 +26,7 @@ they are rounded down (see, e.g., Documentation/diff-generate-patch.txt, which
 mentions this in a different context).
 '
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -121,7 +121,7 @@ test_expect_success 'setup repo' '
 	get_expected_stages 2 &&
 	get_expected_stages 3 &&
 	check_50="false" &&
-	tail="HEAD^ -- HEAD master"
+	tail="HEAD^ -- HEAD main"
 '
 
 test_expect_success 'setup thresholds' '
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index 7d5691c1b4..362ae37a12 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -4,7 +4,7 @@ test_description='git-merge
 
 Do not overwrite changes.'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -196,7 +196,7 @@ test_expect_success 'set up unborn branch and content' '
 '
 
 test_expect_success 'will not clobber WT/index when merging into unborn' '
-	git merge master &&
+	git merge main &&
 	grep foo tracked-file &&
 	git show :tracked-file >expect &&
 	grep foo expect &&
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 14fa46edf3..0f92bcf326 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -2,7 +2,7 @@
 
 test_description='merging with submodules'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -30,7 +30,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m root &&
 
-	git checkout -b a master &&
+	git checkout -b a main &&
 	(cd sub &&
 	 echo A > file &&
 	 git add file &&
@@ -40,7 +40,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m a &&
 
-	git checkout -b b master &&
+	git checkout -b b main &&
 	(cd sub &&
 	 echo B > file &&
 	 git add file &&
@@ -257,22 +257,22 @@ test_expect_success 'setup for recursive merge with submodule' '
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
index e5542ceb24..e176475ed5 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -2,7 +2,7 @@
 
 test_description='unpack-trees error messages'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -21,7 +21,7 @@ test_expect_success 'setup' '
 	git add two three four five &&
 	git commit -m Second &&
 
-	git checkout master &&
+	git checkout main &&
 	echo other >two &&
 	echo other >three &&
 	echo other >four &&
@@ -86,7 +86,7 @@ test_expect_success 'cannot switch branches because of local changes' '
 	echo two >rep/two &&
 	git add rep/one rep/two &&
 	git commit -m Fourth &&
-	git checkout master &&
+	git checkout main &&
 	echo uno >rep/one &&
 	echo dos >rep/two &&
 	test_must_fail git checkout branch 2>out &&
@@ -131,7 +131,7 @@ test_expect_success 'not_uptodate_dir porcelain checkout error' '
 	>rep2 &&
 	git add rep rep2 &&
 	git commit -m "added test as a file" &&
-	git checkout master &&
+	git checkout main &&
 	>rep/untracked-file &&
 	>rep2/untracked-file &&
 	test_must_fail git checkout branch 2>out &&
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index bda5069044..75210f012b 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -25,7 +25,7 @@
 #      to refer to an existing tree).
 
 test_description='check pruning of dependent objects'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -70,7 +70,7 @@ for repack in '' true; do
 		git checkout -b experiment &&
 		commit abandon &&
 		maybe_repack &&
-		git checkout master &&
+		git checkout main &&
 		git branch -D experiment
 	'
 
-- 
gitgitgadget

