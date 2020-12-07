Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MONEY_NOHTML,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B36C197BF
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 15:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBB32371F
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 15:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgLGPUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 10:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGPUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 10:20:25 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6550C061793
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 07:19:44 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id k10so11773841wmi.3
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 07:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JvwpCP99ee8qED2wZqdP6Jz6bXKtIvfuS7LneiM5A6k=;
        b=XVDnPBudJTvmaguEJPh5HCB12oHW0RRh0CEdSSDdVJxdFh0es+mb57oG8V2OORmXsJ
         VvQWx+dTBCKZJ7B52RkcgfHP4LoXBDtwzxpHN3j0cg8VWG76E3xrXII+Mob2qLXy+Wtj
         nxNLB1ScTOeKIVcL2oICMPNp5LF5nXfJkkl/mFmpBUz/aXZmJvK5T0tUl1aGLSlpcO9L
         DLl1jl5Ay3NcssMqZHSt4sk07NksXjPuvZ4FWSJY84drfNwbw0cKwnR7PK+2//BuLE6t
         a1Gfg3KEYvWZ0oFuX8h++YOda8PmzSgDZJr/E5dkMER3PjLj6NtCAkdFT4uapeZJKOya
         ojfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JvwpCP99ee8qED2wZqdP6Jz6bXKtIvfuS7LneiM5A6k=;
        b=ueXU1qiOSJUlLkuGwd5o8Nez+Ww8HaAi7BWOffjFvzNJNpZuoRT1V0n2n1s4DXGV7p
         F9pz7scno+gj0U1brmRZDD86XAzfm0NNCCj169eKn+NEnHBle+ZEbz9Pc2f/UGYZdJ5x
         FCfBIbah81NxHRydTMjSc8YueK9LY8BydOX3eyhGpf/LPUSiajWFBQ6kxIkg5hQ8m4EA
         6RyR9FZUElV15bjT62evGYuXaO6svmWRRGhtg7FK+RhGCJ0an9L/Rg2KSCr5Miyndi7B
         wg8F72+Wz6LZ9P1KTdqJuJfLJqXMRIaBO71WgzgHgV7NbbZTv+dlDkzDhp9wmIoalxk7
         a5UQ==
X-Gm-Message-State: AOAM532rugXonBj2aYjt1WmaCD5BJgHdOVI4AKAYz/V8Wd/kMDbVevpg
        j57hlW3o0yDwv8y3uq0IUFQ90mosRhc=
X-Google-Smtp-Source: ABdhPJzyH7QO5lAdY/O9+ZZ8pAHUGNDVTpYXfDR8etZ5CWhDt982CE3k1wdGpTnEOk4yZYZsW+wDqw==
X-Received: by 2002:a1c:a9c4:: with SMTP id s187mr19274341wme.116.1607354382756;
        Mon, 07 Dec 2020 07:19:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s205sm10119629wmf.46.2020.12.07.07.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 07:19:41 -0800 (PST)
Message-Id: <pull.811.v2.git.1607354380671.gitgitgadget@gmail.com>
In-Reply-To: <pull.811.git.1607264857628.gitgitgadget@gmail.com>
References: <pull.811.git.1607264857628.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Dec 2020 15:19:40 +0000
Subject: [PATCH v2] t7064: avoid relying on a specific default branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To allow us to consider a change in the default behavior of `git init`
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
    
    Changes since v1:
    
     * Fixed a typo and a grammatical construct that was not quite English
       in the commit message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-811%2Fdscho%2Ft7064-and-the-default-branch-name-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-811/dscho/t7064-and-the-default-branch-name-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/811

Range-diff vs v1:

 1:  f956ec3ba55 ! 1:  1d5591c69a5 t7064: avoid relying on a specific default branch name
     @@ Metadata
       ## Commit message ##
          t7064: avoid relying on a specific default branch name
      
     -    To allow us considering a change in the default bahvior of `git init`
     +    To allow us to consider a change in the default behavior of `git init`
          where it uses a more inclusive name for the initial branch, we must
          first teach the test suite not to rely on a specific default branch
          name. In this patch, we teach t7064 that trick.


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
