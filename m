Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E54EC64E7D
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F86B24655
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6s5qg0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgKQQMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgKQQMp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:45 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDEBC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 10so3807498wml.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p/ewD6CCGutyLFF+yvgktNBs/MPY3Kxf+Kl5VMsZ4yc=;
        b=N6s5qg0Tmw8E/rvMdwqUZswYWeCEpSolc5TYq7jytiVMDuQgAv7Wb91Xo8rXE9SbSC
         SMjn7m2iDuL6rCFsRZGis07jsrHiLfRolF2FoGZCqEw+wJtk78qTZ9KCZMjZ4264XSIw
         fef4WUCY+Wm9fGi6UQFQZXJzQjLWyr8STkYSYa0AFYrVeaHwP7wRaLalu3Hi7/Rvr4iz
         GhiBkyDg3vmWVBWfQikj/QThohWJCayKD+Up7Xfv9+iNLrKBObnV2f1yPd6dIQu1NKOg
         dDngp5QYw7C/7pv4ipv6pcaZYCdImNO+zDLRmxMa9YPZANkl1+eCydkX9zKmWZqZZh/z
         SmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p/ewD6CCGutyLFF+yvgktNBs/MPY3Kxf+Kl5VMsZ4yc=;
        b=rdFY+6IxrVy+tOpAAh9B7+Lp8EkOJdARmhieSKHkp8uXEXgchXnVdgchPw7VGyoddw
         kurCnKTKu+g6Zl77n1hABdPa6M7LcoLXMt5ZJtg+Ea/T4niVMPOqq0CD1eCTPKjAuI2e
         jwiozsttmkd8YpjSNUTX4/eVhlr2MSrDxKhq81q6qAZyU2yIkoBPyvJk/XXu7w5+Tv6T
         ZzM++8LkNMpBKKro2hF3TdZp8d17wtg43NWfq2LDmi6umn4kCNxkqxype5bcW9c4LhUk
         EfQcu+D9mW4w5WGAezlZdiwFJWHRwIWqp0MchK8UOP7yHQ4iMivwXFZqfKLEauhvFZpk
         YP6A==
X-Gm-Message-State: AOAM532oGPPH34Vs1ra/JJ3KBym5cqSDdFEYSSnBD0y4uirlzjFcTRD1
        wc4boRiOGYOMOX+/Ow5s77rJV/40GDI=
X-Google-Smtp-Source: ABdhPJzm5EtvbMx2t9Gb48T5rM830c7I3YLIhagCGLceExqXpKjLfIFo2rHQQtErXcvciOazrkcRWw==
X-Received: by 2002:a7b:c772:: with SMTP id x18mr380047wmk.185.1605629561553;
        Tue, 17 Nov 2020 08:12:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm2814243wmf.33.2020.11.17.08.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:41 -0800 (PST)
Message-Id: <332677cbf9dd889242b4e4105272988cd40a7758.1605629548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:12 +0000
Subject: [PATCH v2 12/27] t550*: adjust the references to the default branch
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
 t/t5500-fetch-pack.sh            |  28 +++----
 t/t5501-fetch-push-alternates.sh |   4 +-
 t/t5502-quickfetch.sh            |   6 +-
 t/t5503-tagfollow.sh             |  12 +--
 t/t5504-fetch-receive-strict.sh  |  20 ++---
 t/t5505-remote.sh                | 140 +++++++++++++++----------------
 t/t5506-remote-groups.sh         |   4 +-
 t/t5509-fetch-push-namespaces.sh |  30 +++----
 t/test-lib.sh                    |   2 +-
 9 files changed, 123 insertions(+), 123 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 3557374312..70e41ada01 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -407,14 +407,14 @@ test_expect_success 'in_vain resetted upon ACK' '
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
@@ -422,14 +422,14 @@ test_expect_success 'in_vain resetted upon ACK' '
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
 
@@ -637,7 +637,7 @@ test_expect_success 'shallow fetch with tags does not break the repository' '
 		mkdir repo2 &&
 		cd repo2 &&
 		git init &&
-		git fetch --depth=2 ../.git master:branch &&
+		git fetch --depth=2 ../.git main:branch &&
 		git fsck
 	)
 '
@@ -662,7 +662,7 @@ test_expect_success 'fetch-pack can fetch a raw sha1 that is advertised as a ref
 
 	git init client &&
 	git -C client fetch-pack ../server \
-		$(git -C server rev-parse refs/heads/master)
+		$(git -C server rev-parse refs/heads/main)
 '
 
 test_expect_success 'fetch-pack can fetch a raw sha1 overlapping a named ref' '
@@ -688,7 +688,7 @@ test_expect_success 'fetch-pack cannot fetch a raw sha1 that is not advertised a
 	# Some protocol versions (e.g. 2) support fetching
 	# unadvertised objects, so restrict this test to v0.
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -C client fetch-pack ../server \
-		$(git -C server rev-parse refs/heads/master^) 2>err &&
+		$(git -C server rev-parse refs/heads/main^) 2>err &&
 	test_i18ngrep "Server does not allow request for unadvertised object" err
 '
 
@@ -822,7 +822,7 @@ test_expect_success 'clone shallow since ...' '
 
 test_expect_success 'fetch shallow since ...' '
 	git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
-	git -C shallow11 log --pretty=tformat:%s origin/master >actual &&
+	git -C shallow11 log --pretty=tformat:%s origin/main >actual &&
 	cat >expected <<-\EOF &&
 	three
 	two
@@ -863,7 +863,7 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 	(
 	cd shallow-since-graph &&
 	test_commit base &&
-	test_commit master &&
+	test_commit main &&
 	git checkout -b other HEAD^ &&
 	test_commit other &&
 	git commit-graph write --reachable &&
@@ -874,7 +874,7 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 	$(echo "object-format=$(test_oid algo)" | packetize)
 	00010013deepen-since 1
 	$(echo "want $(git rev-parse other)" | packetize)
-	$(echo "have $(git rev-parse master)" | packetize)
+	$(echo "have $(git rev-parse main)" | packetize)
 	0000
 	EOF
 	)
@@ -896,7 +896,7 @@ test_expect_success 'shallow clone exclude tag two' '
 
 test_expect_success 'fetch exclude tag one' '
 	git -C shallow12 fetch --shallow-exclude one origin &&
-	git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
+	git -C shallow12 log --pretty=tformat:%s origin/main >actual &&
 	test_write_lines three two >expected &&
 	test_cmp expected actual
 '
@@ -910,11 +910,11 @@ test_expect_success 'fetching deepen' '
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
index 1bc57ac03f..0054163ce4 100755
--- a/t/t5501-fetch-push-alternates.sh
+++ b/t/t5501-fetch-push-alternates.sh
@@ -45,7 +45,7 @@ test_expect_success setup '
 test_expect_success 'pushing into a repository with the same alternate' '
 	(
 		cd one &&
-		git push ../receiver master:refs/heads/it
+		git push ../receiver main:refs/heads/it
 	) &&
 	(
 		cd receiver &&
@@ -57,7 +57,7 @@ test_expect_success 'pushing into a repository with the same alternate' '
 test_expect_success 'fetching from a repository with the same alternate' '
 	(
 		cd fetcher &&
-		git fetch ../one master:refs/heads/it &&
+		git fetch ../one main:refs/heads/it &&
 		count_objects >../fetcher.count
 	) &&
 	test_cmp one.count fetcher.count
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index 7a46cbdbe6..b163787a05 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -108,14 +108,14 @@ test_expect_success 'quickfetch should not copy from alternate' '
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
index 6dafbe4543..b3e5f810e0 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -11,7 +11,7 @@ test_description='test automatic tag following'
 #   L - A ------ O ------ B
 #    \   \                 \
 #     \   C - origin/cat    \
-#      origin/master           master
+#      origin/main           main
 
 test_expect_success setup '
 	test_tick &&
@@ -57,7 +57,7 @@ test_expect_success 'fetch A (new commit : 1 connection)' '
 	(
 		cd cloned &&
 		GIT_TRACE_PACKET=$UPATH git fetch &&
-		test $A = $(git rev-parse --verify origin/master)
+		test $A = $(git rev-parse --verify origin/main)
 	) &&
 	get_needs $U >actual &&
 	test_cmp expect actual
@@ -72,7 +72,7 @@ test_expect_success "create tag T on A, create C on branch cat" '
 	git add file &&
 	git commit -m C &&
 	C=$(git rev-parse --verify HEAD) &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'setup expect' '
@@ -123,7 +123,7 @@ test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
 	(
 		cd cloned &&
 		GIT_TRACE_PACKET=$UPATH git fetch &&
-		test $B = $(git rev-parse --verify origin/master) &&
+		test $B = $(git rev-parse --verify origin/main) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
 		test $S = $(git rev-parse --verify tag2)
 	) &&
@@ -138,7 +138,7 @@ want $S
 EOF
 '
 
-test_expect_success 'new clone fetch master and tags' '
+test_expect_success 'new clone fetch main and tags' '
 	test_might_fail git branch -D cat &&
 	rm -f $U &&
 	(
@@ -147,7 +147,7 @@ test_expect_success 'new clone fetch master and tags' '
 		git init &&
 		git remote add origin .. &&
 		GIT_TRACE_PACKET=$UPATH git fetch &&
-		test $B = $(git rev-parse --verify origin/master) &&
+		test $B = $(git rev-parse --verify origin/main) &&
 		test $S = $(git rev-parse --verify tag2) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
 		test $T = $(git rev-parse --verify tag1) &&
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 1a16ac4c0d..d2ba19ce68 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -25,7 +25,7 @@ test_expect_success 'fetch without strict' '
 		cd dst &&
 		git config fetch.fsckobjects false &&
 		git config transfer.fsckobjects false &&
-		test_must_fail git fetch ../.git master
+		test_must_fail git fetch ../.git main
 	)
 '
 
@@ -36,7 +36,7 @@ test_expect_success 'fetch with !fetch.fsckobjects' '
 		cd dst &&
 		git config fetch.fsckobjects false &&
 		git config transfer.fsckobjects true &&
-		test_must_fail git fetch ../.git master
+		test_must_fail git fetch ../.git main
 	)
 '
 
@@ -47,7 +47,7 @@ test_expect_success 'fetch with fetch.fsckobjects' '
 		cd dst &&
 		git config fetch.fsckobjects true &&
 		git config transfer.fsckobjects false &&
-		test_must_fail git fetch ../.git master
+		test_must_fail git fetch ../.git main
 	)
 '
 
@@ -57,13 +57,13 @@ test_expect_success 'fetch with transfer.fsckobjects' '
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
 
@@ -75,7 +75,7 @@ test_expect_success 'push without strict' '
 		git config fetch.fsckobjects false &&
 		git config transfer.fsckobjects false
 	) &&
-	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
 
@@ -87,13 +87,13 @@ test_expect_success 'push with !receive.fsckobjects' '
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
@@ -104,7 +104,7 @@ test_expect_success 'push with receive.fsckobjects' '
 		git config receive.fsckobjects true &&
 		git config transfer.fsckobjects false
 	) &&
-	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
 
@@ -115,7 +115,7 @@ test_expect_success 'push with transfer.fsckobjects' '
 		cd dst &&
 		git config transfer.fsckobjects true
 	) &&
-	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index eaa6e90220..540d65aa22 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -17,7 +17,7 @@ setup_repository () {
 	git add elif &&
 	test_tick &&
 	git commit -m "Second" &&
-	git checkout master
+	git checkout main
 	)
 }
 
@@ -60,8 +60,8 @@ test_expect_success C_LOCALE_OUTPUT 'remote information for the origin' '
 	(
 		cd test &&
 		tokens_match origin "$(git remote)" &&
-		check_remote_track origin master side &&
-		check_tracking_branch origin HEAD master side
+		check_remote_track origin main side &&
+		check_tracking_branch origin HEAD main side
 	)
 '
 
@@ -70,7 +70,7 @@ test_expect_success 'add another remote' '
 		cd test &&
 		git remote add -f second ../two &&
 		tokens_match "origin second" "$(git remote)" &&
-		check_tracking_branch second master side another &&
+		check_tracking_branch second main side another &&
 		git for-each-ref "--format=%(refname)" refs/remotes |
 		sed -e "/^refs\/remotes\/origin\//d" \
 		    -e "/^refs\/remotes\/second\//d" >actual &&
@@ -81,8 +81,8 @@ test_expect_success 'add another remote' '
 test_expect_success C_LOCALE_OUTPUT 'check remote-tracking' '
 	(
 		cd test &&
-		check_remote_track origin master side &&
-		check_remote_track second master side another
+		check_remote_track origin main side &&
+		check_remote_track second main side another
 	)
 '
 
@@ -99,7 +99,7 @@ test_expect_success 'remote forces tracking branches' '
 test_expect_success 'remove remote' '
 	(
 		cd test &&
-		git symbolic-ref refs/remotes/second/HEAD refs/remotes/second/master &&
+		git symbolic-ref refs/remotes/second/HEAD refs/remotes/second/main &&
 		git remote rm second
 	)
 '
@@ -108,7 +108,7 @@ test_expect_success C_LOCALE_OUTPUT 'remove remote' '
 	(
 		cd test &&
 		tokens_match origin "$(git remote)" &&
-		check_remote_track origin master side &&
+		check_remote_track origin main side &&
 		git for-each-ref "--format=%(refname)" refs/remotes |
 		sed -e "/^refs\/remotes\/origin\//d" >actual &&
 		test_must_be_empty actual
@@ -121,13 +121,13 @@ test_expect_success 'remove remote protects local branches' '
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
@@ -153,7 +153,7 @@ test_expect_success 'remove errors out early when deleting non-existent branch'
 
 test_expect_success 'remove remote with a branch without configured merge' '
 	test_when_finished "(
-		git -C test checkout master;
+		git -C test checkout main;
 		git -C test branch -D two;
 		git -C test config --remove-section remote.two;
 		git -C test config --remove-section branch.second;
@@ -163,9 +163,9 @@ test_expect_success 'remove remote with a branch without configured merge' '
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
@@ -211,7 +211,7 @@ cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
   Push  URL: $(pwd)/one
-  HEAD branch: master
+  HEAD branch: main
   Remote branches:
     main new (next fetch will store in remotes/origin)
     side tracked
@@ -221,14 +221,14 @@ cat >test/expect <<EOF
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
@@ -237,16 +237,16 @@ EOF
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
@@ -258,10 +258,10 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'show' '
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
@@ -274,7 +274,7 @@ cat >test/expect <<EOF
   Push  URL: $(pwd)/one
   HEAD branch: (not queried)
   Remote branches: (status not queried)
-    master
+    main
     side
   Local branches configured for 'git pull':
     ahead merges with remote main
@@ -322,7 +322,7 @@ test_expect_success 'set-head --auto' '
 	(
 		cd test &&
 		git remote set-head --auto origin &&
-		echo refs/remotes/origin/master >expect &&
+		echo refs/remotes/origin/main >expect &&
 		git symbolic-ref refs/remotes/origin/HEAD >output &&
 		test_cmp expect output
 	)
@@ -333,7 +333,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'set-head --auto has no problem w/mu
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		git remote set-head --auto two >output 2>&1 &&
-		echo "two/HEAD set to master" >expect &&
+		echo "two/HEAD set to main" >expect &&
 		test_i18ncmp expect output
 	)
 '
@@ -347,7 +347,7 @@ test_expect_success 'set-head explicit' '
 		cd test &&
 		git remote set-head origin side2 &&
 		git symbolic-ref refs/remotes/origin/HEAD >output &&
-		git remote set-head origin master &&
+		git remote set-head origin main &&
 		test_cmp expect output
 	)
 '
@@ -410,7 +410,7 @@ test_expect_success 'fetch mirrors act as mirrors during fetch' '
 	(
 		cd mirror-fetch/parent &&
 		git branch new &&
-		git branch -m master renamed
+		git branch -m main renamed
 	) &&
 	(
 		cd mirror-fetch/child &&
@@ -424,7 +424,7 @@ test_expect_success 'fetch mirrors can prune' '
 	(
 		cd mirror-fetch/child &&
 		git remote prune parent &&
-		test_must_fail git rev-parse --verify refs/heads/master
+		test_must_fail git rev-parse --verify refs/heads/main
 	)
 '
 
@@ -477,14 +477,14 @@ test_expect_success 'push mirrors act as mirrors during push' '
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
 
@@ -610,10 +610,10 @@ test_expect_success 'reject --no-no-tags' '
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
 
@@ -630,11 +630,11 @@ test_expect_success 'update' '
 
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
 
@@ -673,11 +673,11 @@ test_expect_success 'update --prune' '
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
 
@@ -697,7 +697,7 @@ test_expect_success 'update default' '
 
 cat >one/expect <<\EOF
   drosophila/another
-  drosophila/master
+  drosophila/main
   drosophila/side
 EOF
 
@@ -751,14 +751,14 @@ test_expect_success 'rename a remote' '
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
@@ -804,7 +804,7 @@ test_expect_success 'rename does not update a non-default fetch refspec' '
 		git config remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
 		git remote rename origin upstream &&
 		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/origin/*" &&
-		git rev-parse -q origin/master
+		git rev-parse -q origin/main
 	)
 '
 
@@ -824,7 +824,7 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 		cd four.three &&
 		git remote add o git://example.com/repo.git &&
 		git remote rename o upstream &&
-		test "$(git rev-parse origin/master)" = "$(git rev-parse master)"
+		test "$(git rev-parse origin/main)" = "$(git rev-parse main)"
 	)
 '
 
@@ -840,11 +840,11 @@ test_expect_success 'remove a remote' '
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
@@ -885,9 +885,9 @@ test_expect_success 'remove a remote removes repo remote.pushDefault but keeps g
 
 cat >remotes_origin <<EOF
 URL: $(pwd)/one
-Push: refs/heads/master:refs/heads/upstream
+Push: refs/heads/main:refs/heads/upstream
 Push: refs/heads/next:refs/heads/upstream2
-Pull: refs/heads/master:refs/heads/origin
+Pull: refs/heads/main:refs/heads/origin
 Pull: refs/heads/next:refs/heads/origin2
 EOF
 
@@ -903,11 +903,11 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
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
@@ -927,8 +927,8 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
 		test "$(git config remote.origin.url)" = "$origin_url" &&
-		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin" &&
-		test "$(git config remote.origin.push)" = "HEAD:refs/heads/master"
+		test "$(git config remote.origin.fetch)" = "refs/heads/main:refs/heads/origin" &&
+		test "$(git config remote.origin.push)" = "HEAD:refs/heads/main"
 	)
 '
 
@@ -951,7 +951,7 @@ test_expect_success 'remote prune to cause a dangling symref' '
 	(
 		cd one &&
 		git checkout side2 &&
-		git branch -D master
+		git branch -D main
 	) &&
 	(
 		cd eight &&
@@ -994,22 +994,22 @@ test_expect_success 'remote set-branches' '
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
@@ -1025,7 +1025,7 @@ test_expect_success 'remote set-branches' '
 		git config --get-all remote.scratch.fetch >config-result &&
 		sort <config-result >../actual.add &&
 
-		git remote set-branches scratch maint master next &&
+		git remote set-branches scratch maint main next &&
 		git config --get-all remote.scratch.fetch >config-result &&
 		sort <config-result >../actual.replace &&
 
@@ -1035,7 +1035,7 @@ test_expect_success 'remote set-branches' '
 
 		git config --unset-all remote.scratch.fetch &&
 		git config remote.scratch.fetch \
-			refs/heads/master:refs/remotes/scratch/master &&
+			refs/heads/main:refs/remotes/scratch/main &&
 		git config --add remote.scratch.fetch \
 			+refs/heads/next:refs/remotes/scratch/next &&
 		git config --get-all remote.scratch.fetch >config-result &&
@@ -1055,14 +1055,14 @@ test_expect_success 'remote set-branches' '
 
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
@@ -1308,7 +1308,7 @@ test_extra_arg () {
 test_extra_arg add nick url
 test_extra_arg rename origin newname
 test_extra_arg remove origin
-test_extra_arg set-head origin master
+test_extra_arg set-head origin main
 # set-branches takes any number of args
 test_extra_arg get-url origin newurl
 test_extra_arg set-url origin newurl oldurl
@@ -1325,7 +1325,7 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 	test_when_finished "(cd test && git tag -d some-tag)" &&
 	(
 		cd test &&
-		git tag -a -m "Some tag" some-tag master &&
+		git tag -a -m "Some tag" some-tag main &&
 		exit_with=true &&
 		for type in commit tag tree blob
 		do
@@ -1351,7 +1351,7 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 test_expect_success PREPARE_FOR_MAIN_BRANCH 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
 	(
 		cd two &&
-		git tag -a -m "Some tag" my-tag master &&
+		git tag -a -m "Some tag" my-tag main &&
 		git update-ref refs/trees/my-head-tree HEAD^{tree} &&
 		git update-ref refs/blobs/my-file-blob HEAD:file
 	) &&
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index 83d5558c0e..f2df3944e0 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -31,8 +31,8 @@ repo_fetched() {
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
index a67f792adf..ad4a3f5c6e 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -27,9 +27,9 @@ test_expect_success setup '
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
@@ -56,7 +56,7 @@ test_expect_success 'pulling from a repository using a ref namespace' '
 		cd puller &&
 		git remote add -f pushee-namespaced "ext::git --namespace=namespace %s ../pushee" &&
 		git for-each-ref refs/ >actual &&
-		printf "$commit1 commit\trefs/remotes/pushee-namespaced/master\n" >expected &&
+		printf "$commit1 commit\trefs/remotes/pushee-namespaced/main\n" >expected &&
 		printf "$commit0 commit\trefs/tags/0\n" >>expected &&
 		printf "$commit1 commit\trefs/tags/1\n" >>expected &&
 		test_cmp expected actual
@@ -76,7 +76,7 @@ test_expect_success 'mirroring a repository using a ref namespace' '
 	(
 		cd mirror &&
 		git for-each-ref refs/ >actual &&
-		printf "$commit1 commit\trefs/namespaces/namespace/refs/heads/master\n" >expected &&
+		printf "$commit1 commit\trefs/namespaces/namespace/refs/heads/main\n" >expected &&
 		printf "$commit0 commit\trefs/namespaces/namespace/refs/tags/0\n" >>expected &&
 		printf "$commit1 commit\trefs/namespaces/namespace/refs/tags/1\n" >>expected &&
 		test_cmp expected actual
@@ -87,7 +87,7 @@ test_expect_success 'hide namespaced refs with transfer.hideRefs' '
 	GIT_NAMESPACE=namespace \
 		git -C pushee -c transfer.hideRefs=refs/tags \
 		ls-remote "ext::git %s ." >actual &&
-	printf "$commit1\trefs/heads/master\n" >expected &&
+	printf "$commit1\trefs/heads/main\n" >expected &&
 	test_cmp expected actual
 '
 
@@ -95,7 +95,7 @@ test_expect_success 'check that transfer.hideRefs does not match unstripped refs
 	GIT_NAMESPACE=namespace \
 		git -C pushee -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
 		ls-remote "ext::git %s ." >actual &&
-	printf "$commit1\trefs/heads/master\n" >expected &&
+	printf "$commit1\trefs/heads/main\n" >expected &&
 	printf "$commit0\trefs/tags/0\n" >>expected &&
 	printf "$commit1\trefs/tags/1\n" >>expected &&
 	test_cmp expected actual
@@ -105,23 +105,23 @@ test_expect_success 'hide full refs with transfer.hideRefs' '
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
@@ -157,9 +157,9 @@ test_expect_success 'denyCurrentBranch and unborn branch with ref namespace' '
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
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 155bfad454..ca86f666e6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,7 @@ case "$TEST_NUMBER" in
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-4]*|5[0-4]*)
+[0-4]*|5[0-4]*|550*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

