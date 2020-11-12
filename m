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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608F3C64E69
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A4920825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTJnnB5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgKLWo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgKLWoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:24 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A9DC0613D4
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:23 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k2so7719213wrx.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oJvoE+6n2GDioCEPeHOUv6BYBRtQQoyaYZ4NbOTYoYc=;
        b=CTJnnB5APKiD7mMd3TMtE0zay5UdrxjxbmaPsFg0AFmlKQ7UwJX5U4pMonR52fRRsH
         +Omh6smpCECVVjWUswwPvHKPkGF5SRXiriV/o7K52F0L1TJhcXHgfcgqymBUHwQ/3t94
         LxaV2mMS62wczQtCyp4KeYBT2UI4L2ktcbt7Tp3TqHgfRmB1xeuFI/2RkObqHgJe7la+
         krHQ6X5Leu5nwzxnfvesg/Y+MS9qk8pb2gyl6XSsspZQdbf5FRL8Otg52A3e5/DwKhNs
         7w2MkxISgcVLe0s3mKW7Pxkv8VztBIP7r00NjvLMhGEZ0Zp8PKCRCZjBhHPjDO20fFKh
         vzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oJvoE+6n2GDioCEPeHOUv6BYBRtQQoyaYZ4NbOTYoYc=;
        b=qeLdUb0q0QHLL2w6vawAm2ieoV6FlYGBnIjmMP2n5zR4+gQBYWYkXLC0q0vV84JX4I
         kRKv1kjvRDROfWeJRNYBc3kE/sGw7wi4z9goox33RC5Vaz4fKp8uJkMegKHDBC4P+2cB
         8vQ4sRuvYBdvwGVlFFatZ5nZ9VxeJPNSJX00u0C4s8m+2PkX5e9mVTWiS6eiUWtVNULH
         XSMVHNor2K5CdOlTdzn2LVmHVjV6sWrQFaC1yIUZxFexXlyNC4MEa2+5AcJg2C/5ef/I
         LxbFGMDPP5kBlgzJmz9XydMJjPRNKT6YRhl9W42obUxhWlMjBD8C3+rvH6hwMOq26F5i
         +JSw==
X-Gm-Message-State: AOAM533DZgAIAZdP+hxx5jS9aBVquyq4wOUPTUIjJnCoWKmVehYAIHVJ
        bDQwdT2LbB0OMEkUY74GYa+fo/dLo5s=
X-Google-Smtp-Source: ABdhPJwUPO7BXrDBTfiKEOWz7CC58Zw98ofaberDyYqzFk127zP0m3lSd7iqRpuyVCtppINPVfIFpg==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr2098802wrv.359.1605221062148;
        Thu, 12 Nov 2020 14:44:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm3634307wrw.4.2020.11.12.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:21 -0800 (PST)
Message-Id: <09b611a3598553b0576fd174ff0ac66a8584ba22.1605221040.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:57 +0000
Subject: [PATCH 27/28] tests: drop prereq `PREPARE_FOR_MAIN_BRANCH` where no
 longer needed
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

We introduced the `PREPARE_FOR_MAIN_BRANCH` prereq for the sole purpose
of allowing us to perform the non-trivial adjustments regarding the
`master` -> `main` rename before the automatable ones.

Now that the transition is almost complete, we can stop using it in most
instances. The only exception is t9902: at the time of writing, there
are other patches in flight that touch this test script, therefore the
transition to `main` is postponed to a later date.

This patch is the result of this command:

	sed -i 's/PREPARE_FOR_MAIN_BRANCH[ ,]//' t/t[0-9]*.sh &&
	git checkout HEAD -- t/t9902\*

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1400-update-ref.sh              |  4 +--
 t/t3200-branch.sh                  |  6 ++---
 t/t3201-branch-contains.sh         |  2 +-
 t/t3203-branch-output.sh           |  2 +-
 t/t3205-branch-color.sh            |  2 +-
 t/t5505-remote.sh                  |  8 +++---
 t/t5510-fetch.sh                   |  4 +--
 t/t5526-fetch-submodules.sh        | 42 +++++++++++++++---------------
 t/t5703-upload-pack-ref-in-want.sh |  2 +-
 t/t6302-for-each-ref-filter.sh     | 12 ++++-----
 10 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 3265a8c58e..127efff136 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -585,7 +585,7 @@ test_expect_success 'stdin fails on unbalanced quotes' '
 	grep "fatal: badly quoted argument: \\\"main" err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin fails on invalid escape' '
+test_expect_success 'stdin fails on invalid escape' '
 	echo "create $a \"ma\zn\"" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
 	grep "fatal: badly quoted argument: \\\"ma\\\\zn\\\"" err
@@ -704,7 +704,7 @@ test_expect_success 'stdin succeeds with quoted argument' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin succeeds with escaped character' '
+test_expect_success 'stdin succeeds with escaped character' '
 	git update-ref -d $a &&
 	echo "create $a \"ma\\151n\"" >stdin &&
 	git update-ref --stdin <stdin &&
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 63036e0369..430f5af21b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -321,7 +321,7 @@ test_expect_success 'git branch --list -v with --abbrev' '
 
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch --column' '
+test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expect <<\EOF &&
   a/b/c   bam     foo     l     * main    n       o/p     r
@@ -358,7 +358,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch with column.*' '
+test_expect_success 'git branch with column.*' '
 	git config column.ui column &&
 	git config column.branch "dense" &&
 	COLUMNS=80 git branch >actual &&
@@ -375,7 +375,7 @@ test_expect_success 'git branch --column -v should fail' '
 	test_must_fail git branch --column -v
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch -v with column.ui ignored' '
+test_expect_success 'git branch -v with column.ui ignored' '
 	git config column.ui column &&
 	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
 	git config --unset column.ui &&
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 110cfef820..f39ae97264 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -242,7 +242,7 @@ test_expect_success 'branch --merged combined with --no-merged' '
 # Here "topic" tracks "main" with one extra commit, and "zzz" points to the
 # same tip as main The name "zzz" must come alphabetically after "topic"
 # as we process them in that order.
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'branch --merged with --verbose' '
+test_expect_success 'branch --merged with --verbose' '
 	git branch --track topic main &&
 	git branch zzz topic &&
 	git checkout topic &&
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 727c9d9caa..211eb8357f 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -329,7 +329,7 @@ test_expect_success '--color overrides auto-color' '
 	test_cmp expect.color actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'verbose output lists worktree path' '
+test_expect_success 'verbose output lists worktree path' '
 	one=$(git rev-parse --short HEAD) &&
 	two=$(git rev-parse --short main) &&
 	cat >expect <<-EOF &&
diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index 9f2fb785d2..2eb619231d 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -28,7 +28,7 @@ test_expect_success 'regular output shows colors' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'verbose output shows colors' '
+test_expect_success 'verbose output shows colors' '
 	oid=$(git rev-parse --short HEAD) &&
 	cat >expect <<-EOF &&
 	* <CYAN>main               <RESET> $oid foo
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 540d65aa22..869109a2c6 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -234,7 +234,7 @@ cat >test/expect <<EOF
     main  pushes to another (up to date)
 EOF
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'show' '
+test_expect_success 'show' '
 	(
 		cd test &&
 		git config --add remote.origin.fetch refs/heads/main:refs/heads/upstream &&
@@ -285,7 +285,7 @@ cat >test/expect <<EOF
     refs/tags/lastbackup forces to refs/tags/lastbackup
 EOF
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'show -n' '
+test_expect_success 'show -n' '
 	mv one one.unreachable &&
 	(
 		cd test &&
@@ -328,7 +328,7 @@ test_expect_success 'set-head --auto' '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'set-head --auto has no problem w/multiple HEADs' '
+test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 	(
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
@@ -1348,7 +1348,7 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
+test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
 	(
 		cd two &&
 		git tag -a -m "Some tag" my-tag main &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 206e3be695..f8bcaeca08 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -942,7 +942,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch aligned output' '
+test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
 	git clone . full-output &&
 	test_commit looooooooooooong-tag &&
 	(
@@ -957,7 +957,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch aligned outpu
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch compact output' '
+test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
 	git clone . compact &&
 	test_commit extraaa &&
 	(
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index f45ba02b8a..356ce31d48 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -61,7 +61,7 @@ test_expect_success setup '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "fetch --recurse-submodules recurses into submodules" '
+test_expect_success "fetch --recurse-submodules recurses into submodules" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -71,7 +71,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "fetch --recurse-submodules recurses
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "submodule.recurse option triggers recursive fetch" '
+test_expect_success "submodule.recurse option triggers recursive fetch" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -81,7 +81,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "submodule.recurse option triggers r
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "fetch --recurse-submodules -j2 has the same output behaviour" '
+test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -111,7 +111,7 @@ test_expect_success "fetch --no-recurse-submodules only fetches superproject" '
 	test_must_be_empty actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "using fetchRecurseSubmodules=true in .gitmodules recurses into submodules" '
+test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses into submodules" '
 	(
 		cd downstream &&
 		git config -f .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
@@ -141,7 +141,7 @@ test_expect_success "using fetchRecurseSubmodules=false in .git/config overrides
 	test_must_be_empty actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "--recurse-submodules overrides fetchRecurseSubmodules setting from .git/config" '
+test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setting from .git/config" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
@@ -170,7 +170,7 @@ test_expect_success "--quiet propagates to parallel submodules" '
 	test_must_be_empty actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "--dry-run propagates to submodules" '
+test_expect_success "--dry-run propagates to submodules" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -180,7 +180,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "--dry-run propagates to submodules"
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "Without --dry-run propagates to submodules" '
+test_expect_success "Without --dry-run propagates to submodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
@@ -189,7 +189,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Without --dry-run propagates to sub
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "recurseSubmodules=true propagates into submodules" '
+test_expect_success "recurseSubmodules=true propagates into submodules" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -200,7 +200,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "recurseSubmodules=true propagates i
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "--recurse-submodules overrides config in submodule" '
+test_expect_success "--recurse-submodules overrides config in submodule" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -225,7 +225,7 @@ test_expect_success "--no-recurse-submodules overrides config setting" '
 	test_must_be_empty actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion doesn't happen when no new commits are fetched in the superproject" '
+test_expect_success "Recursion doesn't happen when no new commits are fetched in the superproject" '
 	(
 		cd downstream &&
 		(
@@ -239,7 +239,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion doesn't happen when no ne
 	test_must_be_empty actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion stops when no new submodule commits are fetched" '
+test_expect_success "Recursion stops when no new submodule commits are fetched" '
 	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -255,7 +255,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion stops when no new submodu
 	test_must_be_empty actual.out
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion doesn't happen when new superproject commits don't change any submodules" '
+test_expect_success "Recursion doesn't happen when new superproject commits don't change any submodules" '
 	add_upstream_commit &&
 	head1=$(git rev-parse --short HEAD) &&
 	echo a > file &&
@@ -272,7 +272,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion doesn't happen when new s
 	test_i18ncmp expect.err.file actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion picks up config in submodule" '
+test_expect_success "Recursion picks up config in submodule" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules &&
@@ -301,7 +301,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion picks up config in submod
 	test_must_be_empty actual.out
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion picks up all submodules when necessary" '
+test_expect_success "Recursion picks up all submodules when necessary" '
 	add_upstream_commit &&
 	(
 		cd submodule &&
@@ -334,7 +334,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion picks up all submodules w
 	test_must_be_empty actual.out
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
+test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
 	add_upstream_commit &&
 	(
 		cd submodule &&
@@ -361,7 +361,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' do
 	test_must_be_empty actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
+test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
 	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -389,7 +389,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' re
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
+test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
 	add_upstream_commit &&
 	head1=$(git rev-parse --short HEAD) &&
 	echo a >> file &&
@@ -406,7 +406,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' st
 	test_i18ncmp expect.err.file actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "'fetch.recurseSubmodules=on-demand' overrides global config" '
+test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules
@@ -434,7 +434,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'fetch.recurseSubmodules=on-demand'
 	test_i18ncmp expect.err.2 actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "'submodule.<sub>.fetchRecurseSubmodules=on-demand' overrides fetch.recurseSubmodules" '
+test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' overrides fetch.recurseSubmodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules
@@ -462,7 +462,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'submodule.<sub>.fetchRecurseSubmod
 	test_i18ncmp expect.err.2 actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "don't fetch submodule when newly recorded commits are already present" '
+test_expect_success "don't fetch submodule when newly recorded commits are already present" '
 	(
 		cd submodule &&
 		git checkout -q HEAD^^
@@ -485,7 +485,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "don't fetch submodule when newly re
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "'fetch.recurseSubmodules=on-demand' works also without .gitmodules entry" '
+test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .gitmodules entry" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index bbf03a8f66..fe89ea55b1 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -383,7 +383,7 @@ test_expect_success 'server is initially behind - ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'server loses a ref - ref in want' '
+test_expect_success 'server loses a ref - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index f5a55c1991..7a45bbf048 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -113,7 +113,7 @@ test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'left alignment is default' '
+test_expect_success 'left alignment is default' '
 	cat >expect <<-\EOF &&
 	refname is refs/heads/main    |refs/heads/main
 	refname is refs/heads/side    |refs/heads/side
@@ -131,7 +131,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'left alignment is default' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'middle alignment' '
+test_expect_success 'middle alignment' '
 	cat >expect <<-\EOF &&
 	|  refname is refs/heads/main  |refs/heads/main
 	|  refname is refs/heads/side  |refs/heads/side
@@ -149,7 +149,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'middle alignment' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'right alignment' '
+test_expect_success 'right alignment' '
 	cat >expect <<-\EOF &&
 	|    refname is refs/heads/main|refs/heads/main
 	|    refname is refs/heads/side|refs/heads/side
@@ -184,7 +184,7 @@ EOF
 test_align_permutations() {
 	while read -r option
 	do
-		test_expect_success PREPARE_FOR_MAIN_BRANCH "align:$option" '
+		test_expect_success "align:$option" '
 			git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
 			test_cmp expect actual
 		'
@@ -213,7 +213,7 @@ EOF
 
 # Individual atoms inside %(align:...) and %(end) must not be quoted.
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'alignment with format quote' "
+test_expect_success 'alignment with format quote' "
 	cat >expect <<-\EOF &&
 	|'       '\''main| A U Thor'\''       '|
 	|'       '\''side| A U Thor'\''       '|
@@ -231,7 +231,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'alignment with format quote' "
 	test_cmp expect actual
 "
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'nested alignment with quote formatting' "
+test_expect_success 'nested alignment with quote formatting' "
 	cat >expect <<-\EOF &&
 	|'           main               '|
 	|'           side               '|
-- 
gitgitgadget

