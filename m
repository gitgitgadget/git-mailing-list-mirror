Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5B0C64E7C
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B74246BB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR8jmrr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgKRXpJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgKRXpF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15B7C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:04 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 10so5176950wml.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2xyyG3wYF3x7I28+UAX/4FXdpIGeZrUr/kQ0ImlH5Io=;
        b=RR8jmrr2BrqsTVZwQ+03R3kq0seNlVQDxbIpb8QXfkLlLdArTCaN7XhiX24MGrAVVH
         P6DrplBABnRgvBmVbM88XbyHTnFiBAfOGM5YFrthpkCHAYtWP0L3DrHbm9j3uAetaz4+
         xI9XsUeHNECnCJZIUIGgF8KnY7XcO2QtnLcgfvkciOlbFBI8kAsapQgE+RfW5tPGJdC4
         k4pL5lZvBoqY3LBof2p56VfMNFY7b6rQ0OwP3qrA1ThgULS/2qrSk2OZHWqqxQgQJvto
         aGcPZSR86KGN0VyvMuUjFLcxvYm9Luoo/1HIBkAnKlN0I1MaAKpynXI+mY3lbETTVdbh
         Ovxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2xyyG3wYF3x7I28+UAX/4FXdpIGeZrUr/kQ0ImlH5Io=;
        b=hI0RVMewlrKntTfeWJwpcgvSSmWUMIkxmLboSDvI9qOatstEiwfNVj8GnnKJ7/u2u3
         FwvSfwNgDiaorKHsM5MGBfrffYW34JDJ+8ACbY0t5dRolApjETBj38Y8vP4JtVvkAsF2
         t+3GL3PQrABYpB2lpHgnguhjcrJIySQwqZLze2du0qSIGJyo4dCd345ajM/OJVRfAJAN
         UKnZOQSNIuq0GdnownzcXdJU8l3Muwx6T+xxz+c63/p++4wnVEfxLDogl2tTnO+jWaMx
         SxAbEdd6MVP5qk/kRCy6tWCYJYOAaLX55WVeaha3HqR1dcjbgBvojOZPvCDm7cwIC/x+
         dlEw==
X-Gm-Message-State: AOAM530n+PCD//ovbEPN5Vcj9VfH1F0ty54CVJEIOwmfKUzhWipH07FK
        Nt4LTcDN14PZLEq2wHjAMyJ9Vmn9FaE=
X-Google-Smtp-Source: ABdhPJx8XyJ2dAAVmid1/S7HoHKTUUfy7xaLjFdAAl3vqJhObd/8+n5icixxeSlCwbpsDO0Hn3mKFg==
X-Received: by 2002:a1c:2888:: with SMTP id o130mr771644wmo.95.1605743102716;
        Wed, 18 Nov 2020 15:45:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm3197133wmb.5.2020.11.18.15.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:02 -0800 (PST)
Message-Id: <4d7eb7dc28094557fe72348382bf692d2e542478.1605743087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:31 +0000
Subject: [PATCH v3 13/28] t550*: adjust the references to the default branch
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

This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t550*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5500-fetch-pack.sh            |  30 +++----
 t/t5501-fetch-push-alternates.sh |   6 +-
 t/t5502-quickfetch.sh            |   8 +-
 t/t5503-tagfollow.sh             |  14 +--
 t/t5504-fetch-receive-strict.sh  |  22 ++---
 t/t5505-remote.sh                | 142 +++++++++++++++----------------
 t/t5506-remote-groups.sh         |   6 +-
 t/t5509-fetch-push-namespaces.sh |  32 +++----
 8 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 4edb8c196e..1f4cc873a8 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -5,7 +5,7 @@
 
 test_description='Testing multi_ack pack fetching'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -410,14 +410,14 @@ test_expect_success 'in_vain resetted upon ACK' '
 	rm -rf myserver myclient &&
 	git init myserver &&
 
-	# Linked list of commits on master. The first is common; the rest are
+	# Linked list of commits on main. The first is common; the rest are
 	# not.
-	test_commit -C myserver first_master_commit &&
+	test_commit -C myserver first_main_commit &&
 	git clone "file://$(pwd)/myserver" myclient &&
 	test_commit_bulk -C myclient 255 &&
 
 	# Another linked list of commits on anotherbranch with no connection to
-	# master. The first is common; the rest are not.
+	# main. The first is common; the rest are not.
 	git -C myserver checkout --orphan anotherbranch &&
 	test_commit -C myserver first_anotherbranch_commit &&
 	git -C myclient fetch origin anotherbranch:refs/heads/anotherbranch &&
@@ -425,14 +425,14 @@ test_expect_success 'in_vain resetted upon ACK' '
 	test_commit_bulk -C myclient 255 &&
 
 	# The new commit that the client wants to fetch.
-	git -C myserver checkout master &&
+	git -C myserver checkout main &&
 	test_commit -C myserver to_fetch &&
 
 	# The client will send (as "have"s) all 256 commits in anotherbranch
 	# first. The 256th commit is common between the client and the server,
 	# and should reset in_vain. This allows negotiation to continue until
 	# the client reports that first_anotherbranch_commit is common.
-	git -C myclient fetch --progress origin master 2>log &&
+	git -C myclient fetch --progress origin main 2>log &&
 	test_i18ngrep "Total 3 " log
 '
 
@@ -640,7 +640,7 @@ test_expect_success 'shallow fetch with tags does not break the repository' '
 		mkdir repo2 &&
 		cd repo2 &&
 		git init &&
-		git fetch --depth=2 ../.git master:branch &&
+		git fetch --depth=2 ../.git main:branch &&
 		git fsck
 	)
 '
@@ -665,7 +665,7 @@ test_expect_success 'fetch-pack can fetch a raw sha1 that is advertised as a ref
 
 	git init client &&
 	git -C client fetch-pack ../server \
-		$(git -C server rev-parse refs/heads/master)
+		$(git -C server rev-parse refs/heads/main)
 '
 
 test_expect_success 'fetch-pack can fetch a raw sha1 overlapping a named ref' '
@@ -691,7 +691,7 @@ test_expect_success 'fetch-pack cannot fetch a raw sha1 that is not advertised a
 	# Some protocol versions (e.g. 2) support fetching
 	# unadvertised objects, so restrict this test to v0.
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -C client fetch-pack ../server \
-		$(git -C server rev-parse refs/heads/master^) 2>err &&
+		$(git -C server rev-parse refs/heads/main^) 2>err &&
 	test_i18ngrep "Server does not allow request for unadvertised object" err
 '
 
@@ -825,7 +825,7 @@ test_expect_success 'clone shallow since ...' '
 
 test_expect_success 'fetch shallow since ...' '
 	git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
-	git -C shallow11 log --pretty=tformat:%s origin/master >actual &&
+	git -C shallow11 log --pretty=tformat:%s origin/main >actual &&
 	cat >expected <<-\EOF &&
 	three
 	two
@@ -866,7 +866,7 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 	(
 	cd shallow-since-graph &&
 	test_commit base &&
-	test_commit master &&
+	test_commit main &&
 	git checkout -b other HEAD^ &&
 	test_commit other &&
 	git commit-graph write --reachable &&
@@ -877,7 +877,7 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 	$(echo "object-format=$(test_oid algo)" | packetize)
 	00010013deepen-since 1
 	$(echo "want $(git rev-parse other)" | packetize)
-	$(echo "have $(git rev-parse master)" | packetize)
+	$(echo "have $(git rev-parse main)" | packetize)
 	0000
 	EOF
 	)
@@ -899,7 +899,7 @@ test_expect_success 'shallow clone exclude tag two' '
 
 test_expect_success 'fetch exclude tag one' '
 	git -C shallow12 fetch --shallow-exclude one origin &&
-	git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
+	git -C shallow12 log --pretty=tformat:%s origin/main >actual &&
 	test_write_lines three two >expected &&
 	test_cmp expected actual
 '
@@ -913,11 +913,11 @@ test_expect_success 'fetching deepen' '
 	test_commit three &&
 	git clone --depth 1 "file://$(pwd)/." deepen &&
 	test_commit four &&
-	git -C deepen log --pretty=tformat:%s master >actual &&
+	git -C deepen log --pretty=tformat:%s main >actual &&
 	echo three >expected &&
 	test_cmp expected actual &&
 	git -C deepen fetch --deepen=1 &&
-	git -C deepen log --pretty=tformat:%s origin/master >actual &&
+	git -C deepen log --pretty=tformat:%s origin/main >actual &&
 	cat >expected <<-\EOF &&
 	four
 	three
diff --git a/t/t5501-fetch-push-alternates.sh b/t/t5501-fetch-push-alternates.sh
index 96ce28b6ba..66f19a4ef2 100755
--- a/t/t5501-fetch-push-alternates.sh
+++ b/t/t5501-fetch-push-alternates.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='fetch/push involving alternates'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -48,7 +48,7 @@ test_expect_success setup '
 test_expect_success 'pushing into a repository with the same alternate' '
 	(
 		cd one &&
-		git push ../receiver master:refs/heads/it
+		git push ../receiver main:refs/heads/it
 	) &&
 	(
 		cd receiver &&
@@ -60,7 +60,7 @@ test_expect_success 'pushing into a repository with the same alternate' '
 test_expect_success 'fetching from a repository with the same alternate' '
 	(
 		cd fetcher &&
-		git fetch ../one master:refs/heads/it &&
+		git fetch ../one main:refs/heads/it &&
 		count_objects >../fetcher.count
 	) &&
 	test_cmp one.count fetcher.count
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index e15a472e4c..8c05c7715b 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -2,7 +2,7 @@
 
 test_description='test quickfetch from local'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -111,14 +111,14 @@ test_expect_success 'quickfetch should not copy from alternate' '
 				q
 			}"
 	) ) &&
-	origin_master=$( (
+	origin_main=$( (
 		cd quickclone &&
-		git rev-parse origin/master
+		git rev-parse origin/main
 	) ) &&
 	echo "loose objects: $obj_cnt, packfiles: $pck_cnt" &&
 	test $obj_cnt -eq 0 &&
 	test $pck_cnt -eq 0 &&
-	test z$origin_master = z$(git rev-parse master)
+	test z$origin_main = z$(git rev-parse main)
 
 '
 
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 525dd21ecb..195fc64dd4 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -2,7 +2,7 @@
 
 test_description='test automatic tag following'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -14,7 +14,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 #   L - A ------ O ------ B
 #    \   \                 \
 #     \   C - origin/cat    \
-#      origin/master           master
+#      origin/main           main
 
 test_expect_success setup '
 	test_tick &&
@@ -60,7 +60,7 @@ test_expect_success 'fetch A (new commit : 1 connection)' '
 	(
 		cd cloned &&
 		GIT_TRACE_PACKET=$UPATH git fetch &&
-		test $A = $(git rev-parse --verify origin/master)
+		test $A = $(git rev-parse --verify origin/main)
 	) &&
 	get_needs $U >actual &&
 	test_cmp expect actual
@@ -75,7 +75,7 @@ test_expect_success "create tag T on A, create C on branch cat" '
 	git add file &&
 	git commit -m C &&
 	C=$(git rev-parse --verify HEAD) &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'setup expect' '
@@ -126,7 +126,7 @@ test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
 	(
 		cd cloned &&
 		GIT_TRACE_PACKET=$UPATH git fetch &&
-		test $B = $(git rev-parse --verify origin/master) &&
+		test $B = $(git rev-parse --verify origin/main) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
 		test $S = $(git rev-parse --verify tag2)
 	) &&
@@ -141,7 +141,7 @@ want $S
 EOF
 '
 
-test_expect_success 'new clone fetch master and tags' '
+test_expect_success 'new clone fetch main and tags' '
 	test_might_fail git branch -D cat &&
 	rm -f $U &&
 	(
@@ -150,7 +150,7 @@ test_expect_success 'new clone fetch master and tags' '
 		git init &&
 		git remote add origin .. &&
 		GIT_TRACE_PACKET=$UPATH git fetch &&
-		test $B = $(git rev-parse --verify origin/master) &&
+		test $B = $(git rev-parse --verify origin/main) &&
 		test $S = $(git rev-parse --verify tag2) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
 		test $T = $(git rev-parse --verify tag1) &&
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 7fe21b176d..6e5a9c20e7 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='fetch/receive strict mode'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -28,7 +28,7 @@ test_expect_success 'fetch without strict' '
 		cd dst &&
 		git config fetch.fsckobjects false &&
 		git config transfer.fsckobjects false &&
-		test_must_fail git fetch ../.git master
+		test_must_fail git fetch ../.git main
 	)
 '
 
@@ -39,7 +39,7 @@ test_expect_success 'fetch with !fetch.fsckobjects' '
 		cd dst &&
 		git config fetch.fsckobjects false &&
 		git config transfer.fsckobjects true &&
-		test_must_fail git fetch ../.git master
+		test_must_fail git fetch ../.git main
 	)
 '
 
@@ -50,7 +50,7 @@ test_expect_success 'fetch with fetch.fsckobjects' '
 		cd dst &&
 		git config fetch.fsckobjects true &&
 		git config transfer.fsckobjects false &&
-		test_must_fail git fetch ../.git master
+		test_must_fail git fetch ../.git main
 	)
 '
 
@@ -60,13 +60,13 @@ test_expect_success 'fetch with transfer.fsckobjects' '
 	(
 		cd dst &&
 		git config transfer.fsckobjects true &&
-		test_must_fail git fetch ../.git master
+		test_must_fail git fetch ../.git main
 	)
 '
 
 cat >exp <<EOF
 To dst
-!	refs/heads/master:refs/heads/test	[remote rejected] (missing necessary objects)
+!	refs/heads/main:refs/heads/test	[remote rejected] (missing necessary objects)
 Done
 EOF
 
@@ -78,7 +78,7 @@ test_expect_success 'push without strict' '
 		git config fetch.fsckobjects false &&
 		git config transfer.fsckobjects false
 	) &&
-	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
 
@@ -90,13 +90,13 @@ test_expect_success 'push with !receive.fsckobjects' '
 		git config receive.fsckobjects false &&
 		git config transfer.fsckobjects true
 	) &&
-	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
 
 cat >exp <<EOF
 To dst
-!	refs/heads/master:refs/heads/test	[remote rejected] (unpacker error)
+!	refs/heads/main:refs/heads/test	[remote rejected] (unpacker error)
 EOF
 
 test_expect_success 'push with receive.fsckobjects' '
@@ -107,7 +107,7 @@ test_expect_success 'push with receive.fsckobjects' '
 		git config receive.fsckobjects true &&
 		git config transfer.fsckobjects false
 	) &&
-	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
 
@@ -118,7 +118,7 @@ test_expect_success 'push with transfer.fsckobjects' '
 		cd dst &&
 		git config transfer.fsckobjects true
 	) &&
-	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 2b6e1f50f8..f7e3c9b1e7 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -2,7 +2,7 @@
 
 test_description='git remote porcelain-ish'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -20,7 +20,7 @@ setup_repository () {
 	git add elif &&
 	test_tick &&
 	git commit -m "Second" &&
-	git checkout master
+	git checkout main
 	)
 }
 
@@ -63,8 +63,8 @@ test_expect_success C_LOCALE_OUTPUT 'remote information for the origin' '
 	(
 		cd test &&
 		tokens_match origin "$(git remote)" &&
-		check_remote_track origin master side &&
-		check_tracking_branch origin HEAD master side
+		check_remote_track origin main side &&
+		check_tracking_branch origin HEAD main side
 	)
 '
 
@@ -73,7 +73,7 @@ test_expect_success 'add another remote' '
 		cd test &&
 		git remote add -f second ../two &&
 		tokens_match "origin second" "$(git remote)" &&
-		check_tracking_branch second master side another &&
+		check_tracking_branch second main side another &&
 		git for-each-ref "--format=%(refname)" refs/remotes |
 		sed -e "/^refs\/remotes\/origin\//d" \
 		    -e "/^refs\/remotes\/second\//d" >actual &&
@@ -84,8 +84,8 @@ test_expect_success 'add another remote' '
 test_expect_success C_LOCALE_OUTPUT 'check remote-tracking' '
 	(
 		cd test &&
-		check_remote_track origin master side &&
-		check_remote_track second master side another
+		check_remote_track origin main side &&
+		check_remote_track second main side another
 	)
 '
 
@@ -102,7 +102,7 @@ test_expect_success 'remote forces tracking branches' '
 test_expect_success 'remove remote' '
 	(
 		cd test &&
-		git symbolic-ref refs/remotes/second/HEAD refs/remotes/second/master &&
+		git symbolic-ref refs/remotes/second/HEAD refs/remotes/second/main &&
 		git remote rm second
 	)
 '
@@ -111,7 +111,7 @@ test_expect_success C_LOCALE_OUTPUT 'remove remote' '
 	(
 		cd test &&
 		tokens_match origin "$(git remote)" &&
-		check_remote_track origin master side &&
+		check_remote_track origin main side &&
 		git for-each-ref "--format=%(refname)" refs/remotes |
 		sed -e "/^refs\/remotes\/origin\//d" >actual &&
 		test_must_be_empty actual
@@ -124,13 +124,13 @@ test_expect_success 'remove remote protects local branches' '
 		cat >expect1 <<-\EOF &&
 		Note: A branch outside the refs/remotes/ hierarchy was not removed;
 		to delete it, use:
-		  git branch -d master
+		  git branch -d main
 		EOF
 		cat >expect2 <<-\EOF &&
 		Note: Some branches outside the refs/remotes/ hierarchy were not removed;
 		to delete them, use:
 		  git branch -d foobranch
-		  git branch -d master
+		  git branch -d main
 		EOF
 		git tag footag &&
 		git config --add remote.oops.fetch "+refs/*:refs/*" &&
@@ -156,7 +156,7 @@ test_expect_success 'remove errors out early when deleting non-existent branch'
 
 test_expect_success 'remove remote with a branch without configured merge' '
 	test_when_finished "(
-		git -C test checkout master;
+		git -C test checkout main;
 		git -C test branch -D two;
 		git -C test config --remove-section remote.two;
 		git -C test config --remove-section branch.second;
@@ -166,9 +166,9 @@ test_expect_success 'remove remote with a branch without configured merge' '
 		cd test &&
 		git remote add two ../two &&
 		git fetch two &&
-		git checkout -b second two/master^0 &&
+		git checkout -b second two/main^0 &&
 		git config branch.second.remote two &&
-		git checkout master &&
+		git checkout main &&
 		git remote rm two
 	)
 '
@@ -214,7 +214,7 @@ cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
   Push  URL: $(pwd)/one
-  HEAD branch: master
+  HEAD branch: main
   Remote branches:
     main new (next fetch will store in remotes/origin)
     side tracked
@@ -224,14 +224,14 @@ cat >test/expect <<EOF
     octopus  merges with remote topic-a
                 and with remote topic-b
                 and with remote topic-c
-    rebase  rebases onto remote master
+    rebase  rebases onto remote main
   Local refs configured for 'git push':
     main pushes to main     (local out of date)
     main pushes to upstream (create)
 * remote two
   Fetch URL: ../two
   Push  URL: ../three
-  HEAD branch: master
+  HEAD branch: main
   Local refs configured for 'git push':
     ahead forces to main    (fast-forwardable)
     main  pushes to another (up to date)
@@ -240,16 +240,16 @@ EOF
 test_expect_success PREPARE_FOR_MAIN_BRANCH 'show' '
 	(
 		cd test &&
-		git config --add remote.origin.fetch refs/heads/master:refs/heads/upstream &&
+		git config --add remote.origin.fetch refs/heads/main:refs/heads/upstream &&
 		git fetch &&
-		git checkout -b ahead origin/master &&
+		git checkout -b ahead origin/main &&
 		echo 1 >>file &&
 		test_tick &&
 		git commit -m update file &&
-		git checkout master &&
-		git branch --track octopus origin/master &&
-		git branch --track rebase origin/master &&
-		git branch -d -r origin/master &&
+		git checkout main &&
+		git branch --track octopus origin/main &&
+		git branch --track rebase origin/main &&
+		git branch -d -r origin/main &&
 		git config --add remote.two.url ../two &&
 		git config --add remote.two.pushurl ../three &&
 		git config branch.rebase.rebase true &&
@@ -261,10 +261,10 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'show' '
 			git commit -m update file
 		) &&
 		git config --add remote.origin.push : &&
-		git config --add remote.origin.push refs/heads/master:refs/heads/upstream &&
+		git config --add remote.origin.push refs/heads/main:refs/heads/upstream &&
 		git config --add remote.origin.push +refs/tags/lastbackup &&
-		git config --add remote.two.push +refs/heads/ahead:refs/heads/master &&
-		git config --add remote.two.push refs/heads/master:refs/heads/another &&
+		git config --add remote.two.push +refs/heads/ahead:refs/heads/main &&
+		git config --add remote.two.push refs/heads/main:refs/heads/another &&
 		git remote show origin two >output &&
 		git branch -d rebase octopus &&
 		test_i18ncmp expect output
@@ -277,7 +277,7 @@ cat >test/expect <<EOF
   Push  URL: $(pwd)/one
   HEAD branch: (not queried)
   Remote branches: (status not queried)
-    master
+    main
     side
   Local branches configured for 'git pull':
     ahead merges with remote main
@@ -325,7 +325,7 @@ test_expect_success 'set-head --auto' '
 	(
 		cd test &&
 		git remote set-head --auto origin &&
-		echo refs/remotes/origin/master >expect &&
+		echo refs/remotes/origin/main >expect &&
 		git symbolic-ref refs/remotes/origin/HEAD >output &&
 		test_cmp expect output
 	)
@@ -336,7 +336,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'set-head --auto has no problem w/mu
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		git remote set-head --auto two >output 2>&1 &&
-		echo "two/HEAD set to master" >expect &&
+		echo "two/HEAD set to main" >expect &&
 		test_i18ncmp expect output
 	)
 '
@@ -350,7 +350,7 @@ test_expect_success 'set-head explicit' '
 		cd test &&
 		git remote set-head origin side2 &&
 		git symbolic-ref refs/remotes/origin/HEAD >output &&
-		git remote set-head origin master &&
+		git remote set-head origin main &&
 		test_cmp expect output
 	)
 '
@@ -413,7 +413,7 @@ test_expect_success 'fetch mirrors act as mirrors during fetch' '
 	(
 		cd mirror-fetch/parent &&
 		git branch new &&
-		git branch -m master renamed
+		git branch -m main renamed
 	) &&
 	(
 		cd mirror-fetch/child &&
@@ -427,7 +427,7 @@ test_expect_success 'fetch mirrors can prune' '
 	(
 		cd mirror-fetch/child &&
 		git remote prune parent &&
-		test_must_fail git rev-parse --verify refs/heads/master
+		test_must_fail git rev-parse --verify refs/heads/main
 	)
 '
 
@@ -480,14 +480,14 @@ test_expect_success 'push mirrors act as mirrors during push' '
 	(
 		cd mirror-push/private &&
 		git branch new &&
-		git branch -m master renamed &&
+		git branch -m main renamed &&
 		git push public
 	) &&
 	(
 		cd mirror-push/private &&
 		git rev-parse --verify refs/heads/new &&
 		git rev-parse --verify refs/heads/renamed &&
-		test_must_fail git rev-parse --verify refs/heads/master
+		test_must_fail git rev-parse --verify refs/heads/main
 	)
 '
 
@@ -613,10 +613,10 @@ test_expect_success 'reject --no-no-tags' '
 '
 
 cat >one/expect <<\EOF
-  apis/master
+  apis/main
   apis/side
   drosophila/another
-  drosophila/master
+  drosophila/main
   drosophila/side
 EOF
 
@@ -633,11 +633,11 @@ test_expect_success 'update' '
 
 cat >one/expect <<\EOF
   drosophila/another
-  drosophila/master
+  drosophila/main
   drosophila/side
-  manduca/master
+  manduca/main
   manduca/side
-  megaloprepus/master
+  megaloprepus/main
   megaloprepus/side
 EOF
 
@@ -676,11 +676,11 @@ test_expect_success 'update --prune' '
 '
 
 cat >one/expect <<-\EOF
-  apis/master
+  apis/main
   apis/side
-  manduca/master
+  manduca/main
   manduca/side
-  megaloprepus/master
+  megaloprepus/main
   megaloprepus/side
 EOF
 
@@ -700,7 +700,7 @@ test_expect_success 'update default' '
 
 cat >one/expect <<\EOF
   drosophila/another
-  drosophila/master
+  drosophila/main
   drosophila/side
 EOF
 
@@ -754,14 +754,14 @@ test_expect_success 'rename a remote' '
 	git clone one four &&
 	(
 		cd four &&
-		git config branch.master.pushRemote origin &&
+		git config branch.main.pushRemote origin &&
 		git remote rename origin upstream &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
-		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/master" &&
-		test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
+		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/main" &&
+		test "$(git rev-parse upstream/main)" = "$(git rev-parse main)" &&
 		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
-		test "$(git config branch.master.remote)" = "upstream" &&
-		test "$(git config branch.master.pushRemote)" = "upstream" &&
+		test "$(git config branch.main.remote)" = "upstream" &&
+		test "$(git config branch.main.pushRemote)" = "upstream" &&
 		test "$(git config --global remote.pushDefault)" = "origin"
 	)
 '
@@ -807,7 +807,7 @@ test_expect_success 'rename does not update a non-default fetch refspec' '
 		git config remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
 		git remote rename origin upstream &&
 		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/origin/*" &&
-		git rev-parse -q origin/master
+		git rev-parse -q origin/main
 	)
 '
 
@@ -827,7 +827,7 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 		cd four.three &&
 		git remote add o git://example.com/repo.git &&
 		git remote rename o upstream &&
-		test "$(git rev-parse origin/master)" = "$(git rev-parse master)"
+		test "$(git rev-parse origin/main)" = "$(git rev-parse main)"
 	)
 '
 
@@ -843,11 +843,11 @@ test_expect_success 'remove a remote' '
 	git clone one four.five &&
 	(
 		cd four.five &&
-		git config branch.master.pushRemote origin &&
+		git config branch.main.pushRemote origin &&
 		git remote remove origin &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
-		test_must_fail git config branch.master.remote &&
-		test_must_fail git config branch.master.pushRemote &&
+		test_must_fail git config branch.main.remote &&
+		test_must_fail git config branch.main.pushRemote &&
 		test "$(git config --global remote.pushDefault)" = "origin"
 	)
 '
@@ -888,9 +888,9 @@ test_expect_success 'remove a remote removes repo remote.pushDefault but keeps g
 
 cat >remotes_origin <<EOF
 URL: $(pwd)/one
-Push: refs/heads/master:refs/heads/upstream
+Push: refs/heads/main:refs/heads/upstream
 Push: refs/heads/next:refs/heads/upstream2
-Pull: refs/heads/master:refs/heads/origin
+Pull: refs/heads/main:refs/heads/origin
 Pull: refs/heads/next:refs/heads/origin2
 EOF
 
@@ -906,11 +906,11 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 		test_path_is_missing .git/remotes/origin &&
 		test "$(git config remote.origin.url)" = "$origin_url" &&
 		cat >push_expected <<-\EOF &&
-		refs/heads/master:refs/heads/upstream
+		refs/heads/main:refs/heads/upstream
 		refs/heads/next:refs/heads/upstream2
 		EOF
 		cat >fetch_expected <<-\EOF &&
-		refs/heads/master:refs/heads/origin
+		refs/heads/main:refs/heads/origin
 		refs/heads/next:refs/heads/origin2
 		EOF
 		git config --get-all remote.origin.push >push_actual &&
@@ -930,8 +930,8 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
 		test "$(git config remote.origin.url)" = "$origin_url" &&
-		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin" &&
-		test "$(git config remote.origin.push)" = "HEAD:refs/heads/master"
+		test "$(git config remote.origin.fetch)" = "refs/heads/main:refs/heads/origin" &&
+		test "$(git config remote.origin.push)" = "HEAD:refs/heads/main"
 	)
 '
 
@@ -954,7 +954,7 @@ test_expect_success 'remote prune to cause a dangling symref' '
 	(
 		cd one &&
 		git checkout side2 &&
-		git branch -D master
+		git branch -D main
 	) &&
 	(
 		cd eight &&
@@ -997,22 +997,22 @@ test_expect_success 'remote set-branches' '
 	EOF
 	sort <<-\EOF >expect.replace &&
 	+refs/heads/maint:refs/remotes/scratch/maint
-	+refs/heads/master:refs/remotes/scratch/master
+	+refs/heads/main:refs/remotes/scratch/main
 	+refs/heads/next:refs/remotes/scratch/next
 	EOF
 	sort <<-\EOF >expect.add-two &&
 	+refs/heads/maint:refs/remotes/scratch/maint
-	+refs/heads/master:refs/remotes/scratch/master
+	+refs/heads/main:refs/remotes/scratch/main
 	+refs/heads/next:refs/remotes/scratch/next
 	+refs/heads/seen:refs/remotes/scratch/seen
 	+refs/heads/t/topic:refs/remotes/scratch/t/topic
 	EOF
 	sort <<-\EOF >expect.setup-ffonly &&
-	refs/heads/master:refs/remotes/scratch/master
+	refs/heads/main:refs/remotes/scratch/main
 	+refs/heads/next:refs/remotes/scratch/next
 	EOF
 	sort <<-\EOF >expect.respect-ffonly &&
-	refs/heads/master:refs/remotes/scratch/master
+	refs/heads/main:refs/remotes/scratch/main
 	+refs/heads/next:refs/remotes/scratch/next
 	+refs/heads/seen:refs/remotes/scratch/seen
 	EOF
@@ -1028,7 +1028,7 @@ test_expect_success 'remote set-branches' '
 		git config --get-all remote.scratch.fetch >config-result &&
 		sort <config-result >../actual.add &&
 
-		git remote set-branches scratch maint master next &&
+		git remote set-branches scratch maint main next &&
 		git config --get-all remote.scratch.fetch >config-result &&
 		sort <config-result >../actual.replace &&
 
@@ -1038,7 +1038,7 @@ test_expect_success 'remote set-branches' '
 
 		git config --unset-all remote.scratch.fetch &&
 		git config remote.scratch.fetch \
-			refs/heads/master:refs/remotes/scratch/master &&
+			refs/heads/main:refs/remotes/scratch/main &&
 		git config --add remote.scratch.fetch \
 			+refs/heads/next:refs/remotes/scratch/next &&
 		git config --get-all remote.scratch.fetch >config-result &&
@@ -1058,14 +1058,14 @@ test_expect_success 'remote set-branches' '
 
 test_expect_success 'remote set-branches with --mirror' '
 	echo "+refs/*:refs/*" >expect.initial &&
-	echo "+refs/heads/master:refs/heads/master" >expect.replace &&
+	echo "+refs/heads/main:refs/heads/main" >expect.replace &&
 	git clone --mirror .git/ setbranches-mirror &&
 	(
 		cd setbranches-mirror &&
 		git remote rename origin scratch &&
 		git config --get-all remote.scratch.fetch >../actual.initial &&
 
-		git remote set-branches scratch heads/master &&
+		git remote set-branches scratch heads/main &&
 		git config --get-all remote.scratch.fetch >../actual.replace
 	) &&
 	test_cmp expect.initial actual.initial &&
@@ -1311,7 +1311,7 @@ test_extra_arg () {
 test_extra_arg add nick url
 test_extra_arg rename origin newname
 test_extra_arg remove origin
-test_extra_arg set-head origin master
+test_extra_arg set-head origin main
 # set-branches takes any number of args
 test_extra_arg get-url origin newurl
 test_extra_arg set-url origin newurl oldurl
@@ -1328,7 +1328,7 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 	test_when_finished "(cd test && git tag -d some-tag)" &&
 	(
 		cd test &&
-		git tag -a -m "Some tag" some-tag master &&
+		git tag -a -m "Some tag" some-tag main &&
 		exit_with=true &&
 		for type in commit tag tree blob
 		do
@@ -1354,7 +1354,7 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 test_expect_success PREPARE_FOR_MAIN_BRANCH 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
 	(
 		cd two &&
-		git tag -a -m "Some tag" my-tag master &&
+		git tag -a -m "Some tag" my-tag main &&
 		git update-ref refs/trees/my-head-tree HEAD^{tree} &&
 		git update-ref refs/blobs/my-file-blob HEAD:file
 	) &&
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index bf3aa85da5..8f150c0793 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='git remote group handling'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -34,8 +34,8 @@ repo_fetched() {
 test_expect_success 'setup' '
 	mkdir one && (cd one && git init) &&
 	mkdir two && (cd two && git init) &&
-	git remote add -m master one one &&
-	git remote add -m master two two
+	git remote add -m main one one &&
+	git remote add -m main two two
 '
 
 test_expect_success 'no group updates all' '
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index f234dba91a..31553b48df 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='fetch/push involving ref namespaces'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -30,9 +30,9 @@ test_expect_success setup '
 test_expect_success 'pushing into a repository using a ref namespace' '
 	(
 		cd original &&
-		git push pushee-namespaced master &&
+		git push pushee-namespaced main &&
 		git ls-remote pushee-namespaced >actual &&
-		printf "$commit1\trefs/heads/master\n" >expected &&
+		printf "$commit1\trefs/heads/main\n" >expected &&
 		test_cmp expected actual &&
 		git push pushee-namespaced --tags &&
 		git ls-remote pushee-namespaced >actual &&
@@ -59,7 +59,7 @@ test_expect_success 'pulling from a repository using a ref namespace' '
 		cd puller &&
 		git remote add -f pushee-namespaced "ext::git --namespace=namespace %s ../pushee" &&
 		git for-each-ref refs/ >actual &&
-		printf "$commit1 commit\trefs/remotes/pushee-namespaced/master\n" >expected &&
+		printf "$commit1 commit\trefs/remotes/pushee-namespaced/main\n" >expected &&
 		printf "$commit0 commit\trefs/tags/0\n" >>expected &&
 		printf "$commit1 commit\trefs/tags/1\n" >>expected &&
 		test_cmp expected actual
@@ -79,7 +79,7 @@ test_expect_success 'mirroring a repository using a ref namespace' '
 	(
 		cd mirror &&
 		git for-each-ref refs/ >actual &&
-		printf "$commit1 commit\trefs/namespaces/namespace/refs/heads/master\n" >expected &&
+		printf "$commit1 commit\trefs/namespaces/namespace/refs/heads/main\n" >expected &&
 		printf "$commit0 commit\trefs/namespaces/namespace/refs/tags/0\n" >>expected &&
 		printf "$commit1 commit\trefs/namespaces/namespace/refs/tags/1\n" >>expected &&
 		test_cmp expected actual
@@ -90,7 +90,7 @@ test_expect_success 'hide namespaced refs with transfer.hideRefs' '
 	GIT_NAMESPACE=namespace \
 		git -C pushee -c transfer.hideRefs=refs/tags \
 		ls-remote "ext::git %s ." >actual &&
-	printf "$commit1\trefs/heads/master\n" >expected &&
+	printf "$commit1\trefs/heads/main\n" >expected &&
 	test_cmp expected actual
 '
 
@@ -98,7 +98,7 @@ test_expect_success 'check that transfer.hideRefs does not match unstripped refs
 	GIT_NAMESPACE=namespace \
 		git -C pushee -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
 		ls-remote "ext::git %s ." >actual &&
-	printf "$commit1\trefs/heads/master\n" >expected &&
+	printf "$commit1\trefs/heads/main\n" >expected &&
 	printf "$commit0\trefs/tags/0\n" >>expected &&
 	printf "$commit1\trefs/tags/1\n" >>expected &&
 	test_cmp expected actual
@@ -108,23 +108,23 @@ test_expect_success 'hide full refs with transfer.hideRefs' '
 	GIT_NAMESPACE=namespace \
 		git -C pushee -c transfer.hideRefs="^refs/namespaces/namespace/refs/tags" \
 		ls-remote "ext::git %s ." >actual &&
-	printf "$commit1\trefs/heads/master\n" >expected &&
+	printf "$commit1\trefs/heads/main\n" >expected &&
 	test_cmp expected actual
 '
 
 test_expect_success 'try to update a hidden ref' '
-	test_config -C pushee transfer.hideRefs refs/heads/master &&
-	test_must_fail git -C original push pushee-namespaced master
+	test_config -C pushee transfer.hideRefs refs/heads/main &&
+	test_must_fail git -C original push pushee-namespaced main
 '
 
 test_expect_success 'try to update a ref that is not hidden' '
-	test_config -C pushee transfer.hideRefs refs/namespaces/namespace/refs/heads/master &&
-	git -C original push pushee-namespaced master
+	test_config -C pushee transfer.hideRefs refs/namespaces/namespace/refs/heads/main &&
+	git -C original push pushee-namespaced main
 '
 
 test_expect_success 'try to update a hidden full ref' '
-	test_config -C pushee transfer.hideRefs "^refs/namespaces/namespace/refs/heads/master" &&
-	test_must_fail git -C original push pushee-namespaced master
+	test_config -C pushee transfer.hideRefs "^refs/namespaces/namespace/refs/heads/main" &&
+	test_must_fail git -C original push pushee-namespaced main
 '
 
 test_expect_success 'set up ambiguous HEAD' '
@@ -160,9 +160,9 @@ test_expect_success 'denyCurrentBranch and unborn branch with ref namespace' '
 		cd original &&
 		git init unborn &&
 		git remote add unborn-namespaced "ext::git --namespace=namespace %s unborn" &&
-		test_must_fail git push unborn-namespaced HEAD:master &&
+		test_must_fail git push unborn-namespaced HEAD:main &&
 		git -C unborn config receive.denyCurrentBranch updateInstead &&
-		git push unborn-namespaced HEAD:master
+		git push unborn-namespaced HEAD:main
 	)
 '
 
-- 
gitgitgadget

