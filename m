Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MONEY_NOHTML,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3447FC433FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 14:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBD42313E
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 14:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgLFO2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 09:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgLFO2V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 09:28:21 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E2AC0613D1
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 06:27:41 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id i2so10152458wrs.4
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 06:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kvdUHA0BwrKTuQQYh/44FFBTik4AYvKFkO1RW953erQ=;
        b=sUmCEXeJezZJV5pe/Gng6pba8NIEPeGyzmbqVXDF0WM3j1gKkF5kU3YfBPac+O/33c
         MtxIxE67M5/LIUilZyAyYWEHrZ3LMW8R8PjwjqtWDoFYAaSBk2NVsz+Krn8W8Ubt5UbW
         BQvUPQ7vR6tYj0fK4jW3k3fOoOZP2yU76R9uJqQw8FaGFMomy+PWTGkY1msdPE+GwbOR
         vYptlPc4zN1FM7Wcz4hoctEdV81YdDnyJylx8Qn/AzHJ1E1WhbsZc5HQxPZEf47jzCxN
         n1aNfrx6fUUum2FswEFNvaX4NiYTVAj91M7cOgRNplTh577NRUhiTsWMziWo2OVF3tOs
         dnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kvdUHA0BwrKTuQQYh/44FFBTik4AYvKFkO1RW953erQ=;
        b=NLIDOM7JsKesUolKC/DzQQkl7eaT7aclhEGT0mX5dJQfgiIYKwSNyQ0wx+UMifI+DY
         5QN9SQuTPHeSzs7nC1DlvLfn28HxfcGMYSVbtSFAZDvxq0BSE4d4V5yBv5sMcrUxwRX4
         GygzxFbVk1EAkaswykBXod0KTO9W1toqq5Yu8YYO5AkFfMujnxT527Y6IR/KCe7P8+LG
         4tmp8Je2tq+JMsQcizGEemEEOoYBDlya+adZBKpfZ/WBvb25a+JEKoNtz/AxcnTXc4pA
         0yC1jBmg+73RoQgpewU+vUJhT3J9f0yALg+mpJBO1cvOPBtVqS1Yq1sHSzZhp/DdDHdt
         ofdQ==
X-Gm-Message-State: AOAM533ht0327ACvKCZHKaZ7+0Od0fivmxe5Yrpnm6Eky4PXyBMD5ntW
        9dp8dYlDEiGkoM5t4R60qJjnCmVRj7I=
X-Google-Smtp-Source: ABdhPJw96/eONatMizWhe0EvHuqdclwwPkLtqAMGvZannjGmxRxQal0MYvQNWQRFbQqKFulQzdYcRA==
X-Received: by 2002:a5d:4242:: with SMTP id s2mr6476876wrr.187.1607264859427;
        Sun, 06 Dec 2020 06:27:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm10237819wmi.41.2020.12.06.06.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 06:27:38 -0800 (PST)
Message-Id: <pull.811.git.1607264857628.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Dec 2020 14:27:37 +0000
Subject: [PATCH] t7064: avoid relying on a specific default branch name
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

To allow us considering a change in the default bahvior of `git init`
where it uses a more inclusive name for the initial branch, we must
first teach the test suite not to rely on a specific default branch
name. In this patch, we teach t7064 that trick.

To that end, we set a specific name for the initial branch. Ideally, we
would simply start out by calling `git branch -M initial-branch`, but
there is a bug in `git branch -M` that does not allow renaming branches
unless they already have commits. This will be fixed in the
`js/init-defaultbranch-advice` topic, and until that time, we use the
equivalent (but less intuitive) `git checkout -f --orphan`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t7064: avoid relying on a specific default branch name
    
    This one goes on top of
    sj/untracked-files-in-submodule-directory-is-not-dirty.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-811%2Fdscho%2Ft7064-and-the-default-branch-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-811/dscho/t7064-and-the-default-branch-name-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/811

 t/t7064-wtstatus-pv2.sh | 111 ++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 55 deletions(-)

diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 78cd86be3ae..0a93f6e4c2a 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -9,6 +9,7 @@ This test exercises porcelain V2 output for git status.'
 
 
 test_expect_success setup '
+	git checkout -f --orphan initial-branch &&
 	test_tick &&
 	git config core.autocrlf false &&
 	echo x >file_x &&
@@ -22,7 +23,7 @@ test_expect_success setup '
 test_expect_success 'before initial commit, nothing added, only untracked' '
 	cat >expect <<-EOF &&
 	# branch.oid (initial)
-	# branch.head master
+	# branch.head initial-branch
 	? actual
 	? dir1/
 	? expect
@@ -45,7 +46,7 @@ test_expect_success 'before initial commit, things added' '
 
 	cat >expect <<-EOF &&
 	# branch.oid (initial)
-	# branch.head master
+	# branch.head initial-branch
 	1 A. N... 000000 100644 100644 $ZERO_OID $OID_A dir1/file_a
 	1 A. N... 000000 100644 100644 $ZERO_OID $OID_B dir1/file_b
 	1 A. N... 000000 100644 100644 $ZERO_OID $OID_X file_x
@@ -62,7 +63,7 @@ test_expect_success 'before initial commit, things added' '
 test_expect_success 'before initial commit, things added (-z)' '
 	lf_to_nul >expect <<-EOF &&
 	# branch.oid (initial)
-	# branch.head master
+	# branch.head initial-branch
 	1 A. N... 000000 100644 100644 $ZERO_OID $OID_A dir1/file_a
 	1 A. N... 000000 100644 100644 $ZERO_OID $OID_B dir1/file_b
 	1 A. N... 000000 100644 100644 $ZERO_OID $OID_X file_x
@@ -81,7 +82,7 @@ test_expect_success 'make first commit, comfirm HEAD oid and branch' '
 	H0=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
 	# branch.oid $H0
-	# branch.head master
+	# branch.head initial-branch
 	? actual
 	? expect
 	EOF
@@ -98,7 +99,7 @@ test_expect_success 'after first commit, create unstaged changes' '
 
 	cat >expect <<-EOF &&
 	# branch.oid $H0
-	# branch.head master
+	# branch.head initial-branch
 	1 .M N... 100644 100644 100644 $OID_X $OID_X file_x
 	1 .D N... 100644 100644 000000 $OID_Z $OID_Z file_z
 	? actual
@@ -126,7 +127,7 @@ test_expect_success 'after first commit, stage existing changes' '
 
 	cat >expect <<-EOF &&
 	# branch.oid $H0
-	# branch.head master
+	# branch.head initial-branch
 	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
 	1 D. N... 100644 000000 000000 $OID_Z $ZERO_OID file_z
 	? actual
@@ -143,7 +144,7 @@ test_expect_success 'rename causes 2 path lines' '
 
 	q_to_tab >expect <<-EOF &&
 	# branch.oid $H0
-	# branch.head master
+	# branch.head initial-branch
 	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
 	1 D. N... 100644 000000 000000 $OID_Z $ZERO_OID file_z
 	2 R. N... 100644 100644 100644 $OID_Y $OID_Y R100 renamed_yQfile_y
@@ -161,7 +162,7 @@ test_expect_success 'rename causes 2 path lines (-z)' '
 	## Lines use NUL path separator and line terminator, so double transform here.
 	q_to_nul <<-EOF | lf_to_nul >expect &&
 	# branch.oid $H0
-	# branch.head master
+	# branch.head initial-branch
 	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
 	1 D. N... 100644 000000 000000 $OID_Z $ZERO_OID file_z
 	2 R. N... 100644 100644 100644 $OID_Y $OID_Y R100 renamed_yQfile_y
@@ -179,7 +180,7 @@ test_expect_success 'make second commit, confirm clean and new HEAD oid' '
 
 	cat >expect <<-EOF &&
 	# branch.oid $H1
-	# branch.head master
+	# branch.head initial-branch
 	? actual
 	? expect
 	EOF
@@ -231,7 +232,7 @@ test_expect_success 'create and commit permanent ignore file' '
 
 	cat >expect <<-EOF &&
 	# branch.oid $H1
-	# branch.head master
+	# branch.head initial-branch
 	EOF
 
 	git status --porcelain=v2 --branch >actual &&
@@ -257,14 +258,14 @@ test_expect_success 'verify --intent-to-add output' '
 test_expect_success 'verify AA (add-add) conflict' '
 	test_when_finished "git reset --hard" &&
 
-	git branch AA_A master &&
+	git branch AA_A initial-branch &&
 	git checkout AA_A &&
 	echo "Branch AA_A" >conflict.txt &&
 	OID_AA_A=$(git hash-object -t blob -- conflict.txt) &&
 	git add conflict.txt &&
 	git commit -m "branch aa_a" &&
 
-	git branch AA_B master &&
+	git branch AA_B initial-branch &&
 	git checkout AA_B &&
 	echo "Branch AA_B" >conflict.txt &&
 	OID_AA_B=$(git hash-object -t blob -- conflict.txt) &&
@@ -290,7 +291,7 @@ test_expect_success 'verify AA (add-add) conflict' '
 test_expect_success 'verify UU (edit-edit) conflict' '
 	test_when_finished "git reset --hard" &&
 
-	git branch UU_ANC master &&
+	git branch UU_ANC initial-branch &&
 	git checkout UU_ANC &&
 	echo "Ancestor" >conflict.txt &&
 	OID_UU_ANC=$(git hash-object -t blob -- conflict.txt) &&
@@ -328,18 +329,18 @@ test_expect_success 'verify UU (edit-edit) conflict' '
 '
 
 test_expect_success 'verify upstream fields in branch header' '
-	git checkout master &&
+	git checkout initial-branch &&
 	test_when_finished "rm -rf sub_repo" &&
 	git clone . sub_repo &&
 	(
-		## Confirm local master tracks remote master.
+		## Confirm local initial-branch tracks remote initial-branch.
 		cd sub_repo &&
 		HUF=$(git rev-parse HEAD) &&
 
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		EOF
 
@@ -355,8 +356,8 @@ test_expect_success 'verify upstream fields in branch header' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +1 -0
 		EOF
 
@@ -367,9 +368,9 @@ test_expect_success 'verify upstream fields in branch header' '
 		git status --porcelain=v2 --untracked-files=all >actual &&
 		test_must_be_empty actual &&
 
-		## Test upstream-gone case. Fake this by pointing origin/master at
-		## a non-existing commit.
-		OLD=$(git rev-parse origin/master) &&
+		## Test upstream-gone case. Fake this by pointing
+		## origin/initial-branch at a non-existing commit.
+		OLD=$(git rev-parse origin/initial-branch) &&
 		NEW=$ZERO_OID &&
 		mv .git/packed-refs .git/old-packed-refs &&
 		sed "s/$OLD/$NEW/g" <.git/old-packed-refs >.git/packed-refs &&
@@ -378,8 +379,8 @@ test_expect_success 'verify upstream fields in branch header' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		EOF
 
 		git status --porcelain=v2 --branch --untracked-files=all >actual &&
@@ -388,19 +389,19 @@ test_expect_success 'verify upstream fields in branch header' '
 '
 
 test_expect_success 'verify --[no-]ahead-behind with V2 format' '
-	git checkout master &&
+	git checkout initial-branch &&
 	test_when_finished "rm -rf sub_repo" &&
 	git clone . sub_repo &&
 	(
-		## Confirm local master tracks remote master.
+		## Confirm local initial-branch tracks remote initial-branch.
 		cd sub_repo &&
 		HUF=$(git rev-parse HEAD) &&
 
 		# Confirm --no-ahead-behind reports traditional branch.ab with 0/0 for equal branches.
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		EOF
 
@@ -410,8 +411,8 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		# Confirm --ahead-behind reports traditional branch.ab with 0/0.
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		EOF
 
@@ -428,8 +429,8 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		# Confirm --no-ahead-behind reports branch.ab with ?/? for non-equal branches.
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +? -?
 		EOF
 
@@ -439,8 +440,8 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		# Confirm --ahead-behind reports traditional branch.ab with 1/0.
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +1 -0
 		EOF
 
@@ -458,7 +459,7 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 '
 
 test_expect_success 'create and add submodule, submodule appears clean (A. S...)' '
-	git checkout master &&
+	git checkout initial-branch &&
 	git clone . sub_repo &&
 	git clone . super_repo &&
 	(	cd super_repo &&
@@ -471,8 +472,8 @@ test_expect_success 'create and add submodule, submodule appears clean (A. S...)
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 A. S... 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -496,8 +497,8 @@ test_expect_success 'untracked changes in added submodule (AM S..U)' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 AM S..U 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -521,8 +522,8 @@ test_expect_success 'untracked changes in added submodule (A. S...) (untracked i
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 A. S... 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -546,8 +547,8 @@ test_expect_success 'staged changes in added submodule (AM S.M.)' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -573,8 +574,8 @@ test_expect_success 'staged and unstaged changes in added (AM S.M.)' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -600,8 +601,8 @@ test_expect_success 'staged and untracked changes in added submodule (AM S.MU)'
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 AM S.MU 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -627,8 +628,8 @@ test_expect_success 'staged and untracked changes in added submodule (AM S.M.) (
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -654,8 +655,8 @@ test_expect_success 'commit within the submodule appears as new commit in super
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 AM SC.. 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -677,8 +678,8 @@ test_expect_success 'stage submodule in super and commit' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +1 -0
 		EOF
 
@@ -698,8 +699,8 @@ test_expect_success 'make unstaged changes in existing submodule (.M S.M.)' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +1 -0
 		1 .M S.M. 160000 160000 160000 $HSUB $HSUB sub1
 		EOF

base-commit: ffb5546b3be1cdf9e029ac373f309d0fe23ddd0b
-- 
gitgitgadget
