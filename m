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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD54C64E75
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FC6246BB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKYcYvvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgKRXpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgKRXpD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35442C0613D6
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c198so3281258wmd.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0DSwimQBY/2D/TWB3yfV305o1UKOF1PI/+sbEzaTNJM=;
        b=gKYcYvvwMeNF+Xe4TMV+5bWdoqDTBB7WURHTPpKHcmPEBd/lLTMlHSHINqAxOSbKJB
         zjzLskRF3+94bO2/f4jIv13y0Q4fx8qfZpP8ZnHlIEcj71znu7Squ0tkLkWSn/Eq4b4F
         talvF0C9bb34STeXQolZBSyOPOC04pKGRLw3vNiyDAGmZBonDm39F5p8s0cijRJKAXKk
         Ny6RsCk0YCwTaVZ1EG53leHyN7RGsfuUF5XEolixyfuza0C/XtAxsa8dcXDhrYOHhyWG
         eCRDLwjrNSLQCLKqWs9jJdn4K/LInP3FIj2aRCncz8GKN5zsGugolAfG+OfUMYpYY1cV
         RLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0DSwimQBY/2D/TWB3yfV305o1UKOF1PI/+sbEzaTNJM=;
        b=VS18Kvnr0S4co00OQums86W8IiSiZSgM/EWIRRHZoZgYHRwp7EW4TLrI/FGoPg8zYY
         GUUa9VDCCGnNdnLkguWRkC3JM/xysrVmD29oMjvmm5q9g9E4WyB02hAQgxjR6Hhm36kM
         UIvJsQ0RZEcFDzQN6xdOiuGpGRX/8HiO6mjcE6JOGDP710h3Ryb6mRPkln0qI3wIqUFS
         sNfetpJnX9Zu603I/mcn2Bs37LqFGDsLO9+7gKzTT3bB+cYeSNhOVOMduNsZaQz7mKMn
         X96+c18Z5Pje6+Rva7VzkzXOrOuccaThh7MAFjisMYDnzbHXbAZiat+BttXfTAbI6H/O
         1zGQ==
X-Gm-Message-State: AOAM531AH0pEKW7Wm7bqe71NShrFQHPstKRT3guE84C7644mlNYTpKYc
        axN+DCguwp1+odXMPm5mqiCDFBac7i0=
X-Google-Smtp-Source: ABdhPJxP/7Egzl1MyKUwmr46GWC6n43moe9pPQpZvu8mZOiJKgyki4m9hCutv3PMpgVBQaH6EyqheA==
X-Received: by 2002:a1c:3d6:: with SMTP id 205mr1551427wmd.85.1605743101093;
        Wed, 18 Nov 2020 15:45:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25sm6152382wmh.16.2020.11.18.15.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:00 -0800 (PST)
Message-Id: <d9d1d14681c474a10c34efbd5bbf2fe856e21553.1605743087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:29 +0000
Subject: [PATCH v3 11/28] t5[0-4]*: adjust the references to the default
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

Carefully excluding t5310, which is developed independently of the
current patch series at the time of writing, we now use `main` as
default branch in t5[0-4]*. This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t5[0-4]*.sh &&
	   git checkout HEAD -- t5310\*)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5150-request-pull.sh                | 36 +++++++-------
 t/t5304-prune.sh                       |  4 +-
 t/t5305-include-tag.sh                 |  4 +-
 t/t5312-prune-corruption.sh            | 18 +++----
 t/t5317-pack-objects-filter-objects.sh |  4 +-
 t/t5322-pack-objects-sparse.sh         |  4 +-
 t/t5323-pack-redundant.sh              | 66 +++++++++++++-------------
 t/t5400-send-pack.sh                   | 62 ++++++++++++------------
 t/t5401-update-hooks.sh                | 24 +++++-----
 t/t5402-post-merge-hook.sh             |  4 +-
 t/t5403-post-checkout-hook.sh          |  8 ++--
 t/t5404-tracking-branches.sh           | 10 ++--
 t/t5405-send-pack-rewind.sh            |  8 ++--
 t/t5407-post-rewrite-hook.sh           |  4 +-
 t/t5410-receive-pack-alternates.sh     |  6 +--
 15 files changed, 131 insertions(+), 131 deletions(-)

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 752e1fb2d2..db4e15fd59 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -2,7 +2,7 @@
 
 test_description='Test workflows involving pull request.'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -34,13 +34,13 @@ test_expect_success 'setup' '
 		test_tick &&
 		git commit -m "\"Thirty days\", a reminder of month lengths" &&
 		git tag -m "version 1" -a initial &&
-		git push --tags origin master
+		git push --tags origin main
 	) &&
 	(
 		cd local &&
 		git remote add upstream "$trash_url/upstream.git" &&
 		git fetch upstream &&
-		git pull upstream master &&
+		git pull upstream main &&
 		cat <<-\EOT >>mnemonic.txt &&
 		Of twyecescore-eightt is but eine,
 		And all the remnante be thrycescore-eine.
@@ -62,7 +62,7 @@ test_expect_success 'setup' '
 		git commit -a -m "Adapt to use modern, simpler English
 
 But keep the old version, too, in case some people prefer it." &&
-		git checkout master
+		git checkout main
 	)
 
 '
@@ -132,7 +132,7 @@ test_expect_success 'pull request when forgot to push' '
 	(
 		cd local &&
 		git checkout initial &&
-		git merge --ff-only master &&
+		git merge --ff-only main &&
 		test_must_fail git request-pull initial "$downstream_url" \
 			2>../err
 	) &&
@@ -148,9 +148,9 @@ test_expect_success 'pull request after push' '
 	(
 		cd local &&
 		git checkout initial &&
-		git merge --ff-only master &&
-		git push origin master:for-upstream &&
-		git request-pull initial origin master:for-upstream >../request
+		git merge --ff-only main &&
+		git push origin main:for-upstream &&
+		git request-pull initial origin main:for-upstream >../request
 	) &&
 	sed -nf read-request.sed <request >digest &&
 	{
@@ -175,9 +175,9 @@ test_expect_success 'request asks HEAD to be pulled' '
 	(
 		cd local &&
 		git checkout initial &&
-		git merge --ff-only master &&
-		git push --tags origin master simplify &&
-		git push origin master:for-upstream &&
+		git merge --ff-only main &&
+		git push --tags origin main simplify &&
+		git push origin main:for-upstream &&
 		git request-pull initial "$downstream_url" >../request
 	) &&
 	sed -nf read-request.sed <request >digest &&
@@ -218,7 +218,7 @@ test_expect_success 'pull request format' '
 	(
 		cd local &&
 		git checkout initial &&
-		git merge --ff-only master &&
+		git merge --ff-only main &&
 		git push origin tags/full &&
 		git request-pull initial "$downstream_url" tags/full >../request
 	) &&
@@ -246,9 +246,9 @@ test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison' '
 		OPTIONS_KEEPDASHDASH=Yes &&
 		export OPTIONS_KEEPDASHDASH &&
 		git checkout initial &&
-		git merge --ff-only master &&
-		git push origin master:for-upstream &&
-		git request-pull -- initial "$downstream_url" master:for-upstream >../request
+		git merge --ff-only main &&
+		git push origin main:for-upstream &&
+		git request-pull -- initial "$downstream_url" main:for-upstream >../request
 	)
 
 '
@@ -260,7 +260,7 @@ test_expect_success 'request-pull quotes regex metacharacters properly' '
 	(
 		cd local &&
 		git checkout initial &&
-		git merge --ff-only master &&
+		git merge --ff-only main &&
 		git tag -mrelease v2.0 &&
 		git push origin refs/tags/v2.0:refs/tags/v2-0 &&
 		test_must_fail git request-pull initial "$downstream_url" tags/v2.0 \
@@ -278,7 +278,7 @@ test_expect_success 'pull request with mismatched object' '
 	(
 		cd local &&
 		git checkout initial &&
-		git merge --ff-only master &&
+		git merge --ff-only main &&
 		git push origin HEAD:refs/tags/full &&
 		test_must_fail git request-pull initial "$downstream_url" tags/full \
 			2>../err
@@ -295,7 +295,7 @@ test_expect_success 'pull request with stale object' '
 	(
 		cd local &&
 		git checkout initial &&
-		git merge --ff-only master &&
+		git merge --ff-only main &&
 		git push origin refs/tags/full &&
 		git tag -f -m"Thirty-one days" full &&
 		test_must_fail git request-pull initial "$downstream_url" tags/full \
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index bd5f71e396..b447ce56a9 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -4,7 +4,7 @@
 #
 
 test_description='prune'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -122,7 +122,7 @@ test_expect_success 'prune: do not prune detached HEAD with no reflog' '
 test_expect_success 'prune: prune former HEAD after checking out branch' '
 
 	head_oid=$(git rev-parse HEAD) &&
-	git checkout --quiet master &&
+	git checkout --quiet main &&
 	git prune -v >prune_actual &&
 	grep "$head_oid" prune_actual
 
diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index 2e56887ed5..44bd9ef45f 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='git pack-object --include-tag'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -114,7 +114,7 @@ test_expect_success 'check unpacked result (have all objects)' '
 
 test_expect_success 'single-branch clone can transfer tag' '
 	rm -rf clone.git &&
-	git clone --no-local --single-branch -b master . clone.git &&
+	git clone --no-local --single-branch -b main . clone.git &&
 	git -C clone.git fsck
 '
 
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index c70b5db2a0..11423b3cb2 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -8,7 +8,7 @@ bail out or to proceed using it as a reachable tip, but it is _not_
 OK to proceed as if it did not exist. Otherwise we might silently
 delete objects that cannot be recovered.
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -19,7 +19,7 @@ test_expect_success 'disable reflogs' '
 '
 
 test_expect_success 'create history reachable only from a bogus-named ref' '
-	test_tick && git commit --allow-empty -m master &&
+	test_tick && git commit --allow-empty -m main &&
 	base=$(git rev-parse HEAD) &&
 	test_tick && git commit --allow-empty -m bogus &&
 	bogus=$(git rev-parse HEAD) &&
@@ -54,7 +54,7 @@ test_expect_success 'clean up bogus ref' '
 '
 
 # We create two new objects here, "one" and "two". Our
-# master branch points to "two", which is deleted,
+# main branch points to "two", which is deleted,
 # corrupting the repository. But we'd like to make sure
 # that the otherwise unreachable "one" is not pruned
 # (since it is the user's best bet for recovering
@@ -84,7 +84,7 @@ test_expect_success 'pruning with a corrupted tip does not drop history' '
 test_expect_success 'pack-refs does not silently delete broken loose ref' '
 	git pack-refs --all --prune &&
 	echo $missing >expect &&
-	git rev-parse refs/heads/master >actual &&
+	git rev-parse refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -92,25 +92,25 @@ test_expect_success 'pack-refs does not silently delete broken loose ref' '
 # actually pack it, as it is perfectly reasonable to
 # skip processing a broken ref
 test_expect_success 'create packed-refs file with broken ref' '
-	rm -f .git/refs/heads/master &&
+	rm -f .git/refs/heads/main &&
 	cat >.git/packed-refs <<-EOF &&
-	$missing refs/heads/master
+	$missing refs/heads/main
 	$recoverable refs/heads/other
 	EOF
 	echo $missing >expect &&
-	git rev-parse refs/heads/master >actual &&
+	git rev-parse refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'pack-refs does not silently delete broken packed ref' '
 	git pack-refs --all --prune &&
-	git rev-parse refs/heads/master >actual &&
+	git rev-parse refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'pack-refs does not drop broken refs during deletion' '
 	git update-ref -d refs/heads/other &&
-	git rev-parse refs/heads/master >actual &&
+	git rev-parse refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index f19c521292..13ed3eb136 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -2,7 +2,7 @@
 
 test_description='git pack-objects using object filtering'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -385,7 +385,7 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=master:pattern >filter.pack <<-EOF &&
+	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=main:pattern >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r4 index-pack ../filter.pack &&
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index c92658d026..61cb907a90 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='pack-objects object selection using sparse algorithm'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -21,7 +21,7 @@ test_expect_success 'setup repo' '
 	git commit -m "Initialized trees" &&
 	for i in $(test_seq 1 3)
 	do
-		git checkout -b topic$i master &&
+		git checkout -b topic$i main &&
 		echo change-$i >f$i/f$i/data.txt &&
 		git commit -a -m "Changed f$i/f$i/data.txt"
 	done &&
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 3903148926..89c8688647 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -6,7 +6,7 @@
 test_description='Test git pack-redundant
 
 In order to test git-pack-redundant, we will create a number of objects and
-packs in the repository `master.git`. The relationship between packs (P1-P8)
+packs in the repository `main.git`. The relationship between packs (P1-P8)
 and objects (T, A-R) is showed in the following chart. Objects of a pack will
 be marked with letter x, while objects of redundant packs will be marked with
 exclamation point, and redundant pack itself will be marked with asterisk.
@@ -25,7 +25,7 @@ exclamation point, and redundant pack itself will be marked with asterisk.
     ALL | x x x x x x x x x x x x x x x x x x x
 
 Another repository `shared.git` has unique objects (X-Z), while other objects
-(marked with letter s) are shared through alt-odb (of `master.git`). The
+(marked with letter s) are shared through alt-odb (of `main.git`). The
 relationship between packs and objects is as follows:
 
 	| T A B C D E F G H I J K L M N O P Q R   X Y Z
@@ -36,7 +36,7 @@ relationship between packs and objects is as follows:
 
 . ./test-lib.sh
 
-master_repo=master.git
+main_repo=main.git
 shared_repo=shared.git
 
 # Create commits in <repo> and assign each commit's oid to shell variables
@@ -69,7 +69,7 @@ create_commits_in () {
 		shift ||
 		return 1
 	done &&
-	git -C "$repo" update-ref refs/heads/master $oid
+	git -C "$repo" update-ref refs/heads/main $oid
 }
 
 # Create pack in <repo> and assign pack id to variable given in the 2nd argument
@@ -107,9 +107,9 @@ format_packfiles () {
 	sort
 }
 
-test_expect_success 'setup master repo' '
-	git init --bare "$master_repo" &&
-	create_commits_in "$master_repo" A B C D E F G H I J K L M N O P Q R
+test_expect_success 'setup main repo' '
+	git init --bare "$main_repo" &&
+	create_commits_in "$main_repo" A B C D E F G H I J K L M N O P Q R
 '
 
 #############################################################################
@@ -124,8 +124,8 @@ test_expect_success 'setup master repo' '
 #     ALL | x x x x x x x x x x x x x x         x
 #
 #############################################################################
-test_expect_success 'master: no redundant for pack 1, 2, 3' '
-	create_pack_in "$master_repo" P1 <<-EOF &&
+test_expect_success 'main: no redundant for pack 1, 2, 3' '
+	create_pack_in "$main_repo" P1 <<-EOF &&
 		$T
 		$A
 		$B
@@ -135,7 +135,7 @@ test_expect_success 'master: no redundant for pack 1, 2, 3' '
 		$F
 		$R
 		EOF
-	create_pack_in "$master_repo" P2 <<-EOF &&
+	create_pack_in "$main_repo" P2 <<-EOF &&
 		$B
 		$C
 		$D
@@ -144,7 +144,7 @@ test_expect_success 'master: no redundant for pack 1, 2, 3' '
 		$H
 		$I
 		EOF
-	create_pack_in "$master_repo" P3 <<-EOF &&
+	create_pack_in "$main_repo" P3 <<-EOF &&
 		$F
 		$I
 		$J
@@ -153,7 +153,7 @@ test_expect_success 'master: no redundant for pack 1, 2, 3' '
 		$M
 		EOF
 	(
-		cd "$master_repo" &&
+		cd "$main_repo" &&
 		git pack-redundant --all >out &&
 		test_must_be_empty out
 	)
@@ -173,22 +173,22 @@ test_expect_success 'master: no redundant for pack 1, 2, 3' '
 #     ALL | x x x x x x x x x x x x x x x x x   x
 #
 #############################################################################
-test_expect_success 'master: one of pack-2/pack-3 is redundant' '
-	create_pack_in "$master_repo" P4 <<-EOF &&
+test_expect_success 'main: one of pack-2/pack-3 is redundant' '
+	create_pack_in "$main_repo" P4 <<-EOF &&
 		$J
 		$K
 		$L
 		$M
 		$P
 		EOF
-	create_pack_in "$master_repo" P5 <<-EOF &&
+	create_pack_in "$main_repo" P5 <<-EOF &&
 		$G
 		$H
 		$N
 		$O
 		EOF
 	(
-		cd "$master_repo" &&
+		cd "$main_repo" &&
 		cat >expect <<-EOF &&
 			P3:$P3
 			EOF
@@ -214,18 +214,18 @@ test_expect_success 'master: one of pack-2/pack-3 is redundant' '
 #     ALL | x x x x x x x x x x x x x x x x x x x
 #
 #############################################################################
-test_expect_success 'master: pack 2, 4, and 6 are redundant' '
-	create_pack_in "$master_repo" P6 <<-EOF &&
+test_expect_success 'main: pack 2, 4, and 6 are redundant' '
+	create_pack_in "$main_repo" P6 <<-EOF &&
 		$N
 		$O
 		$Q
 		EOF
-	create_pack_in "$master_repo" P7 <<-EOF &&
+	create_pack_in "$main_repo" P7 <<-EOF &&
 		$P
 		$Q
 		EOF
 	(
-		cd "$master_repo" &&
+		cd "$main_repo" &&
 		cat >expect <<-EOF &&
 			P2:$P2
 			P4:$P4
@@ -254,12 +254,12 @@ test_expect_success 'master: pack 2, 4, and 6 are redundant' '
 #     ALL | x x x x x x x x x x x x x x x x x x x
 #
 #############################################################################
-test_expect_success 'master: pack-8 (subset of pack-1) is also redundant' '
-	create_pack_in "$master_repo" P8 <<-EOF &&
+test_expect_success 'main: pack-8 (subset of pack-1) is also redundant' '
+	create_pack_in "$main_repo" P8 <<-EOF &&
 		$A
 		EOF
 	(
-		cd "$master_repo" &&
+		cd "$main_repo" &&
 		cat >expect <<-EOF &&
 			P2:$P2
 			P4:$P4
@@ -272,18 +272,18 @@ test_expect_success 'master: pack-8 (subset of pack-1) is also redundant' '
 	)
 '
 
-test_expect_success 'master: clean loose objects' '
+test_expect_success 'main: clean loose objects' '
 	(
-		cd "$master_repo" &&
+		cd "$main_repo" &&
 		git prune-packed &&
 		find objects -type f | sed -e "/objects\/pack\//d" >out &&
 		test_must_be_empty out
 	)
 '
 
-test_expect_success 'master: remove redundant packs and pass fsck' '
+test_expect_success 'main: remove redundant packs and pass fsck' '
 	(
-		cd "$master_repo" &&
+		cd "$main_repo" &&
 		git pack-redundant --all | xargs rm &&
 		git fsck &&
 		git pack-redundant --all >out &&
@@ -292,12 +292,12 @@ test_expect_success 'master: remove redundant packs and pass fsck' '
 '
 
 # The following test cases will execute inside `shared.git`, instead of
-# inside `master.git`.
+# inside `main.git`.
 test_expect_success 'setup shared.git' '
-	git clone --mirror "$master_repo" "$shared_repo" &&
+	git clone --mirror "$main_repo" "$shared_repo" &&
 	(
 		cd "$shared_repo" &&
-		printf "../../$master_repo/objects\n" >objects/info/alternates
+		printf "../../$main_repo/objects\n" >objects/info/alternates
 	)
 '
 
@@ -312,7 +312,7 @@ test_expect_success 'shared: all packs are redundant, but no output without --al
 #############################################################################
 # Chart of packs and objects for this test case
 #
-#     ================= master.git ================
+#     ================= main.git ================
 #         | T A B C D E F G H I J K L M N O P Q R  <----------+
 #     ----+--------------------------------------             |
 #     P1  | x x x x x x x                       x             |
@@ -394,7 +394,7 @@ test_expect_success 'shared: no redundant without --alt-odb' '
 #############################################################################
 # Chart of packs and objects for this test case
 #
-#     ================= master.git ================
+#     ================= main.git ================
 #         | T A B C D E F G H I J K L M N O P Q R  <----------------+
 #     ----+--------------------------------------                   |
 #     P1  | x x x x x x x                       x                   |
@@ -426,7 +426,7 @@ test_expect_success 'shared: one pack is redundant with --alt-odb' '
 #############################################################################
 # Chart of packs and objects for this test case
 #
-#     ================= master.git ================
+#     ================= main.git ================
 #         | T A B C D E F G H I J K L M N O P Q R  <----------------+
 #     ----+--------------------------------------                   |
 #     P1  | x x x x x x x                       x                   |
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 6be028f3e2..3f81f16e13 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -6,7 +6,7 @@
 test_description='See why rewinding head breaks send-pack
 
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -69,20 +69,20 @@ test_expect_success 'pack the destination repository' '
 '
 
 test_expect_success 'refuse pushing rewound head without --force' '
-	pushed_head=$(git rev-parse --verify master) &&
-	victim_orig=$(cd victim && git rev-parse --verify master) &&
-	test_must_fail git send-pack ./victim master &&
-	victim_head=$(cd victim && git rev-parse --verify master) &&
+	pushed_head=$(git rev-parse --verify main) &&
+	victim_orig=$(cd victim && git rev-parse --verify main) &&
+	test_must_fail git send-pack ./victim main &&
+	victim_head=$(cd victim && git rev-parse --verify main) &&
 	test "$victim_head" = "$victim_orig" &&
 	# this should update
-	git send-pack --force ./victim master &&
-	victim_head=$(cd victim && git rev-parse --verify master) &&
+	git send-pack --force ./victim main &&
+	victim_head=$(cd victim && git rev-parse --verify main) &&
 	test "$victim_head" = "$pushed_head"
 '
 
 test_expect_success 'push can be used to delete a ref' '
-	( cd victim && git branch extra master ) &&
-	git send-pack ./victim :extra master &&
+	( cd victim && git branch extra main ) &&
+	git send-pack ./victim :extra main &&
 	( cd victim &&
 	  test_must_fail git rev-parse --verify extra )
 '
@@ -92,9 +92,9 @@ test_expect_success 'refuse deleting push with denyDeletes' '
 		cd victim &&
 		test_might_fail git branch -D extra &&
 		git config receive.denyDeletes true &&
-		git branch extra master
+		git branch extra main
 	) &&
-	test_must_fail git send-pack ./victim :extra master
+	test_must_fail git send-pack ./victim :extra main
 '
 
 test_expect_success 'cannot override denyDeletes with git -c send-pack' '
@@ -102,10 +102,10 @@ test_expect_success 'cannot override denyDeletes with git -c send-pack' '
 		cd victim &&
 		test_might_fail git branch -D extra &&
 		git config receive.denyDeletes true &&
-		git branch extra master
+		git branch extra main
 	) &&
 	test_must_fail git -c receive.denyDeletes=false \
-					send-pack ./victim :extra master
+					send-pack ./victim :extra main
 '
 
 test_expect_success 'override denyDeletes with git -c receive-pack' '
@@ -113,11 +113,11 @@ test_expect_success 'override denyDeletes with git -c receive-pack' '
 		cd victim &&
 		test_might_fail git branch -D extra &&
 		git config receive.denyDeletes true &&
-		git branch extra master
+		git branch extra main
 	) &&
 	git send-pack \
 		--receive-pack="git -c receive.denyDeletes=false receive-pack" \
-		./victim :extra master
+		./victim :extra main
 '
 
 test_expect_success 'denyNonFastforwards trumps --force' '
@@ -126,9 +126,9 @@ test_expect_success 'denyNonFastforwards trumps --force' '
 		test_might_fail git branch -D extra &&
 		git config receive.denyNonFastforwards true
 	) &&
-	victim_orig=$(cd victim && git rev-parse --verify master) &&
-	test_must_fail git send-pack --force ./victim master^:master &&
-	victim_head=$(cd victim && git rev-parse --verify master) &&
+	victim_orig=$(cd victim && git rev-parse --verify main) &&
+	test_must_fail git send-pack --force ./victim main^:main &&
+	victim_head=$(cd victim && git rev-parse --verify main) &&
 	test "$victim_orig" = "$victim_head"
 '
 
@@ -213,41 +213,41 @@ rewound_push_setup() {
 
 test_expect_success 'pushing explicit refspecs respects forcing' '
 	rewound_push_setup &&
-	parent_orig=$(cd parent && git rev-parse --verify master) &&
+	parent_orig=$(cd parent && git rev-parse --verify main) &&
 	(
 		cd child &&
 		test_must_fail git send-pack ../parent \
-			refs/heads/master:refs/heads/master
+			refs/heads/main:refs/heads/main
 	) &&
-	parent_head=$(cd parent && git rev-parse --verify master) &&
+	parent_head=$(cd parent && git rev-parse --verify main) &&
 	test "$parent_orig" = "$parent_head" &&
 	(
 		cd child &&
 		git send-pack ../parent \
-			+refs/heads/master:refs/heads/master
+			+refs/heads/main:refs/heads/main
 	) &&
-	parent_head=$(cd parent && git rev-parse --verify master) &&
-	child_head=$(cd child && git rev-parse --verify master) &&
+	parent_head=$(cd parent && git rev-parse --verify main) &&
+	child_head=$(cd child && git rev-parse --verify main) &&
 	test "$parent_head" = "$child_head"
 '
 
 test_expect_success 'pushing wildcard refspecs respects forcing' '
 	rewound_push_setup &&
-	parent_orig=$(cd parent && git rev-parse --verify master) &&
+	parent_orig=$(cd parent && git rev-parse --verify main) &&
 	(
 		cd child &&
 		test_must_fail git send-pack ../parent \
 			"refs/heads/*:refs/heads/*"
 	) &&
-	parent_head=$(cd parent && git rev-parse --verify master) &&
+	parent_head=$(cd parent && git rev-parse --verify main) &&
 	test "$parent_orig" = "$parent_head" &&
 	(
 		cd child &&
 		git send-pack ../parent \
 			"+refs/heads/*:refs/heads/*"
 	) &&
-	parent_head=$(cd parent && git rev-parse --verify master) &&
-	child_head=$(cd child && git rev-parse --verify master) &&
+	parent_head=$(cd parent && git rev-parse --verify main) &&
+	child_head=$(cd child && git rev-parse --verify main) &&
 	test "$parent_head" = "$child_head"
 '
 
@@ -255,7 +255,7 @@ test_expect_success 'deny pushing to delete current branch' '
 	rewound_push_setup &&
 	(
 		cd child &&
-		test_must_fail git send-pack ../parent :refs/heads/master 2>errs
+		test_must_fail git send-pack ../parent :refs/heads/main 2>errs
 	)
 '
 
@@ -286,9 +286,9 @@ test_expect_success 'receive-pack de-dupes .have lines' '
 	local=$(git -C fork rev-parse HEAD) &&
 	shared=$(git -C shared rev-parse only-shared) &&
 	cat >expect <<-EOF &&
-	$local refs/heads/master
+	$local refs/heads/main
 	$local refs/remotes/origin/HEAD
-	$local refs/remotes/origin/master
+	$local refs/remotes/origin/main
 	$shared .have
 	EOF
 
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 956d69f5b1..6012cc8172 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -15,11 +15,11 @@ test_expect_success setup '
 	git update-index a &&
 	tree1=$(git write-tree) &&
 	commit1=$(echo modify | git commit-tree $tree1 -p $commit0) &&
-	git update-ref refs/heads/master $commit0 &&
+	git update-ref refs/heads/main $commit0 &&
 	git update-ref refs/heads/tofail $commit1 &&
 	git clone --bare ./. victim.git &&
 	GIT_DIR=victim.git git update-ref refs/heads/tofail $commit1 &&
-	git update-ref refs/heads/master $commit1 &&
+	git update-ref refs/heads/main $commit1 &&
 	git update-ref refs/heads/tofail $commit0
 '
 
@@ -38,7 +38,7 @@ echo "$@" >>$GIT_DIR/update.args
 read x; printf %s "$x" >$GIT_DIR/update.stdin
 echo STDOUT update $1
 echo STDERR update $1 >&2
-test "$1" = refs/heads/master || exit
+test "$1" = refs/heads/main || exit
 EOF
 chmod u+x victim.git/hooks/update
 
@@ -62,11 +62,11 @@ chmod u+x victim.git/hooks/post-update
 
 test_expect_success push '
 	test_must_fail git send-pack --force ./victim.git \
-		master tofail >send.out 2>send.err
+		main tofail >send.out 2>send.err
 '
 
 test_expect_success 'updated as expected' '
-	test $(GIT_DIR=victim.git git rev-parse master) = $commit1 &&
+	test $(GIT_DIR=victim.git git rev-parse main) = $commit1 &&
 	test $(GIT_DIR=victim.git git rev-parse tofail) = $commit1
 '
 
@@ -82,24 +82,24 @@ test_expect_success 'hooks ran' '
 '
 
 test_expect_success 'pre-receive hook input' '
-	(echo $commit0 $commit1 refs/heads/master &&
+	(echo $commit0 $commit1 refs/heads/main &&
 	 echo $commit1 $commit0 refs/heads/tofail
 	) | test_cmp - victim.git/pre-receive.stdin
 '
 
 test_expect_success 'update hook arguments' '
-	(echo refs/heads/master $commit0 $commit1 &&
+	(echo refs/heads/main $commit0 $commit1 &&
 	 echo refs/heads/tofail $commit1 $commit0
 	) | test_cmp - victim.git/update.args
 '
 
 test_expect_success 'post-receive hook input' '
-	echo $commit0 $commit1 refs/heads/master |
+	echo $commit0 $commit1 refs/heads/main |
 	test_cmp - victim.git/post-receive.stdin
 '
 
 test_expect_success 'post-update hook arguments' '
-	echo refs/heads/master |
+	echo refs/heads/main |
 	test_cmp - victim.git/post-update.args
 '
 
@@ -120,8 +120,8 @@ test_expect_success 'send-pack produced no output' '
 cat <<EOF >expect
 remote: STDOUT pre-receive
 remote: STDERR pre-receive
-remote: STDOUT update refs/heads/master
-remote: STDERR update refs/heads/master
+remote: STDOUT update refs/heads/main
+remote: STDERR update refs/heads/main
 remote: STDOUT update refs/heads/tofail
 remote: STDERR update refs/heads/tofail
 remote: error: hook declined to update refs/heads/tofail
@@ -143,7 +143,7 @@ test_expect_success 'pre-receive hook that forgets to read its input' '
 
 	for v in $(test_seq 100 999)
 	do
-		git branch branch_$v master || return
+		git branch branch_$v main || return
 	done &&
 	git push ./victim.git "+refs/heads/*:refs/heads/*"
 '
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 27fc6ec4f3..3e5e19c719 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -4,7 +4,7 @@
 #
 
 test_description='Test the post-merge hook.'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -18,7 +18,7 @@ test_expect_success setup '
 	git update-index a &&
 	tree1=$(git write-tree) &&
 	commit1=$(echo modify | git commit-tree $tree1 -p $commit0) &&
-	git update-ref refs/heads/master $commit0 &&
+	git update-ref refs/heads/main $commit0 &&
 	git clone ./. clone1 &&
 	GIT_DIR=clone1/.git git update-index --add a &&
 	git clone ./. clone2 &&
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index ed91aadd95..1ec9e23be7 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -4,7 +4,7 @@
 #
 
 test_description='Test the post-checkout hook.'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 
 test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
 	test_when_finished "rm -f .git/post-checkout.args" &&
-	git checkout master &&
+	git checkout main &&
 	read old new flag <.git/post-checkout.args &&
 	test $old = $new && test $flag = 1
 '
@@ -44,14 +44,14 @@ test_expect_success 'post-checkout receives the right args with HEAD changed ' '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
 	test_when_finished "rm -f .git/post-checkout.args" &&
-	git checkout master -- three.t &&
+	git checkout main -- three.t &&
 	read old new flag <.git/post-checkout.args &&
 	test $old = $new && test $flag = 0
 '
 
 test_expect_success 'post-checkout is triggered on rebase' '
 	test_when_finished "rm -f .git/post-checkout.args" &&
-	git checkout -b rebase-test master &&
+	git checkout -b rebase-test main &&
 	rm -f .git/post-checkout.args &&
 	git rebase rebase-on-me &&
 	read old new flag <.git/post-checkout.args &&
diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index da37b22fc5..cc07889667 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -2,7 +2,7 @@
 
 test_description='tracking branch update checks for git push'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -33,9 +33,9 @@ test_expect_success 'prepare pushable branches' '
 	git checkout -b b2 origin/b2 &&
 	echo aa-b2 >>file &&
 	git commit -a -m aa-b2 &&
-	git checkout master &&
-	echo aa-master >>file &&
-	git commit -a -m aa-master
+	git checkout main &&
+	echo aa-main >>file &&
+	git commit -a -m aa-main
 '
 
 test_expect_success 'mixed-success push returns error' '
@@ -43,7 +43,7 @@ test_expect_success 'mixed-success push returns error' '
 '
 
 test_expect_success 'check tracking branches updated correctly after push' '
-	test "$(git rev-parse origin/master)" = "$(git rev-parse master)"
+	test "$(git rev-parse origin/main)" = "$(git rev-parse main)"
 '
 
 test_expect_success 'check tracking branches not updated for failed refs' '
diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
index 1f5b33b562..11f03239a0 100755
--- a/t/t5405-send-pack-rewind.sh
+++ b/t/t5405-send-pack-rewind.sh
@@ -2,7 +2,7 @@
 
 test_description='forced push to replace commit we do not have'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -16,7 +16,7 @@ test_expect_success setup '
 	mkdir another && (
 		cd another &&
 		git init &&
-		git fetch --update-head-ok .. master:master
+		git fetch --update-head-ok .. main:main
 	) &&
 
 	>file2 && git add file2 && test_tick &&
@@ -28,7 +28,7 @@ test_expect_success 'non forced push should die not segfault' '
 
 	(
 		cd another &&
-		test_must_fail git push .. master:master
+		test_must_fail git push .. main:main
 	)
 
 '
@@ -37,7 +37,7 @@ test_expect_success 'forced push should succeed' '
 
 	(
 		cd another &&
-		git push .. +master:master
+		git push .. +main:main
 	)
 
 '
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 78bffa64d7..5bb23cc3a4 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -4,7 +4,7 @@
 #
 
 test_description='Test the post-rewrite hook.'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup' '
 	git checkout A^0 &&
 	test_commit E bar E &&
 	test_commit F foo F &&
-	git checkout master
+	git checkout main
 '
 
 mkdir .git/hooks
diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
index 30a4e6bb1a..0b28e4e452 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack-alternates.sh
@@ -2,7 +2,7 @@
 
 test_description='git receive-pack with alternate ref filtering'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -10,9 +10,9 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 test_expect_success 'setup' '
 	test_commit base &&
 	git clone -s --bare . fork &&
-	git checkout -b public/branch master &&
+	git checkout -b public/branch main &&
 	test_commit public &&
-	git checkout -b private/branch master &&
+	git checkout -b private/branch main &&
 	test_commit private
 '
 
-- 
gitgitgadget

