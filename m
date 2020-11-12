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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD5AC5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0E52223F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+/mm7f2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgKLWoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgKLWoG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:06 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCED7C0617A6
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p19so7054774wmg.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fT2o1bAFm7tzIiMa/7ibXHrRwbieWDmgsVYTfdtmbiY=;
        b=W+/mm7f2rsxnJjIeF0Uq1uexDcl4q0iW9qpGwFtGv+ET2+dcx04s+PjCbUIPvPe0fw
         WQxXR5e9ih9Y4u7M8hnum5NS00sisLlaeUqBQyxnjVoi8MbpN5x8Oh48tYvKHrHzeG2O
         z6DX37dvVVus9gwByUw8huMlBAGTzGJBf5qj3bCh7x0u4eDdGROXdjS/9jCq5A/7YPxd
         hLO7ttqB4f3B3rVE9WoeM97Fwb5BJKEi7jIIMny2Gtcl+6pH2vTnxPrYTkzP5uFGybAe
         j5utCv7t7YD3dbCdDbaVLSqnIeMv/e6aPjwoubaP/JPGgAolfhGzlI7WS4OKL/242LWl
         wwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fT2o1bAFm7tzIiMa/7ibXHrRwbieWDmgsVYTfdtmbiY=;
        b=Xwcss8Oz79Y7BQ+XBrE+RlFyV3SZXgmj+ipYXrCMCAUoQGAMdeqCLHTO2wjd5DPReH
         I4ohoFC2po/KUd/BYBqZLRpYQYGFvuh7u2lPjof/lyITt87NowI7A6aKHu6eFz5RgcwT
         CTCFIRtibjVPZi9w7oYsGYniufJjh8uMecGVAXzf/l0HgYimdBaQVjlAxgFNP1HZe/hJ
         J8qFw6cWwynozqswURwg2myoPIb0g1iIBgr78fqzaJsCQ+D43pHv/URbIKe3Cx5yMUN5
         FrGkssnji02+qC3rYdyBPnxXRXr1gn2sImRBOO2+ptD8Yatg8pfhv8UsUaGCa2mNgy/X
         gZcw==
X-Gm-Message-State: AOAM5304381MfMNxm/zNw3Q4kcBuj7PU8QYK0cnj6WPGV2SSDcInjFH3
        zSKuNx7tLp8/d4kxd91TjGUu/JwO0OE=
X-Google-Smtp-Source: ABdhPJyWV+t+gUYGy0eWzdx0ebOui2AHPVb8lQfe3EdXcu6Qqfc02hWfgOvmHLIW5hon9ILcikXWKw==
X-Received: by 2002:a1c:df89:: with SMTP id w131mr59003wmg.164.1605221042679;
        Thu, 12 Nov 2020 14:44:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b124sm7999294wmh.13.2020.11.12.14.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:02 -0800 (PST)
Message-Id: <830130fa9fff3bf39e9f5b0360160e9ff787deec.1605221038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:32 +0000
Subject: [PATCH 02/28] t[01]*: adjust the references to the default branch
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
		-e 's/Master/Main/g' -- t[01]*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0002-gitfile.sh                   |  6 +--
 t/t0020-crlf.sh                      |  8 ++--
 t/t0021-conversion.sh                | 40 ++++++++--------
 t/t0027-auto-crlf.sh                 |  4 +-
 t/t0028-working-tree-encoding.sh     |  4 +-
 t/t0041-usage.sh                     | 10 ++--
 t/t0050-filesystem.sh                |  6 +--
 t/t0060-path-utils.sh                |  4 +-
 t/t0100-previous.sh                  | 18 ++++----
 t/t1004-read-tree-m-u-wf.sh          | 40 ++++++++--------
 t/t1008-read-tree-overlay.sh         |  2 +-
 t/t1009-read-tree-new-index.sh       |  4 +-
 t/t1011-read-tree-sparse-checkout.sh |  2 +-
 t/t1021-rerere-in-workdir.sh         |  2 +-
 t/t1090-sparse-checkout-scope.sh     | 10 ++--
 t/t1091-sparse-checkout-builtin.sh   |  2 +-
 t/t1300-config.sh                    |  8 ++--
 t/t1301-shared-repo.sh               |  4 +-
 t/t1305-config-include.sh            |  2 +-
 t/t1309-early-config.sh              |  4 +-
 t/t1400-update-ref.sh                | 68 ++++++++++++++--------------
 t/t1402-check-ref-format.sh          | 28 ++++++------
 t/t1403-show-ref.sh                  | 18 ++++----
 t/t1405-main-ref-store.sh            | 42 ++++++++---------
 t/t1406-submodule-ref-store.sh       | 30 ++++++------
 t/t1407-worktree-ref-store.sh        | 32 ++++++-------
 t/t1408-packed-refs.sh               | 12 ++---
 t/t1410-reflog.sh                    | 56 +++++++++++------------
 t/t1411-reflog-show.sh               |  2 +-
 t/t1413-reflog-detach.sh             | 24 +++++-----
 t/t1414-reflog-walk.sh               | 12 ++---
 t/t1416-ref-transaction-hooks.sh     | 10 ++--
 t/t1430-bad-ref-name.sh              | 52 ++++++++++-----------
 t/t1450-fsck.sh                      |  2 +-
 t/t1500-rev-parse.sh                 |  4 +-
 t/t1503-rev-parse-verify.sh          | 28 ++++++------
 t/t1505-rev-parse-last.sh            |  8 ++--
 t/t1506-rev-parse-diagnosis.sh       |  4 +-
 t/t1507-rev-parse-upstream.sh        | 40 ++++++++--------
 t/t1508-at-combinations.sh           | 10 ++--
 t/t1511-rev-parse-caret.sh           | 26 +++++------
 t/t1512-rev-parse-disambiguation.sh  |  2 +-
 t/t1513-rev-parse-prefix.sh          |  4 +-
 t/t1514-rev-parse-push.sh            | 16 +++----
 t/t1700-split-index.sh               |  2 +-
 t/test-lib.sh                        |  7 +++
 46 files changed, 363 insertions(+), 356 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 960ed150cb..bbcfc8a0b5 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -96,7 +96,7 @@ test_expect_success 'enter_repo non-strict mode' '
 	git ls-remote enter_repo >actual &&
 	cat >expected <<-EOF &&
 	$head	HEAD
-	$head	refs/heads/master
+	$head	refs/heads/main
 	$head	refs/tags/foo
 	EOF
 	test_cmp expected actual
@@ -111,7 +111,7 @@ test_expect_success 'enter_repo linked checkout' '
 	git ls-remote foo >actual &&
 	cat >expected <<-EOF &&
 	$head	HEAD
-	$head	refs/heads/master
+	$head	refs/heads/main
 	$head	refs/tags/foo
 	EOF
 	test_cmp expected actual
@@ -122,7 +122,7 @@ test_expect_success 'enter_repo strict mode' '
 	git ls-remote --upload-pack="git upload-pack --strict" foo/.git >actual &&
 	cat >expected <<-EOF &&
 	$head	HEAD
-	$head	refs/heads/master
+	$head	refs/heads/main
 	$head	refs/tags/foo
 	EOF
 	test_cmp expected actual
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index b63ba62e5d..04bf4b1e82 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -318,8 +318,8 @@ test_expect_success 'checkout with existing .gitattributes' '
 	git add .gitattributes .file &&
 	git commit -m second &&
 
-	git checkout master~1 &&
-	git checkout master &&
+	git checkout main~1 &&
+	git checkout main &&
 	test "$(git diff-files --raw)" = ""
 
 '
@@ -331,8 +331,8 @@ test_expect_success 'checkout when deleting .gitattributes' '
 	git add .file2 &&
 	git commit -m third &&
 
-	git checkout master~1 &&
-	git checkout master &&
+	git checkout main~1 &&
+	git checkout main &&
 	has_cr .file2
 
 '
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index f6deaf498b..d0eeca4556 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -378,8 +378,8 @@ test_expect_success PERL 'required process filter should filter data' '
 		test_cmp_count expected.log debug.log &&
 
 		git commit -m "test commit 2" &&
-		MASTER=$(git rev-parse --verify master) &&
-		META="ref=refs/heads/master treeish=$MASTER" &&
+		MAIN=$(git rev-parse --verify main) &&
+		META="ref=refs/heads/main treeish=$MAIN" &&
 		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x=.r" &&
 
 		filter_git checkout --quiet --no-progress . &&
@@ -404,7 +404,7 @@ test_expect_success PERL 'required process filter should filter data' '
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
 
-		filter_git checkout --quiet --no-progress master &&
+		filter_git checkout --quiet --no-progress main &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
@@ -436,15 +436,15 @@ test_expect_success PERL 'required process filter should filter data for various
 		M3=$(git hash-object "testsubdir/test3 '\''sq'\'',\$x=.r") &&
 		EMPTY=$(git hash-object /dev/null) &&
 
-		MASTER=$(git rev-parse --verify master) &&
+		MAIN=$(git rev-parse --verify main) &&
 
 		cp "$TEST_ROOT/test.o" test5.r &&
 		git add test5.r &&
 		git commit -m "test commit 3" &&
 		git checkout empty-branch &&
-		filter_git rebase --onto empty-branch master^^ master &&
-		MASTER2=$(git rev-parse --verify master) &&
-		META="ref=refs/heads/master treeish=$MASTER2" &&
+		filter_git rebase --onto empty-branch main^^ main &&
+		MAIN2=$(git rev-parse --verify main) &&
+		META="ref=refs/heads/main treeish=$MAIN2" &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
@@ -458,8 +458,8 @@ test_expect_success PERL 'required process filter should filter data for various
 		test_cmp_exclude_clean expected.log debug.log &&
 
 		git reset --hard empty-branch &&
-		filter_git reset --hard $MASTER &&
-		META="treeish=$MASTER" &&
+		filter_git reset --hard $MAIN &&
+		META="treeish=$MAIN" &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
@@ -471,10 +471,10 @@ test_expect_success PERL 'required process filter should filter data for various
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
 
-		git branch old-master $MASTER &&
+		git branch old-main $MAIN &&
 		git reset --hard empty-branch &&
-		filter_git reset --hard old-master &&
-		META="ref=refs/heads/old-master treeish=$MASTER" &&
+		filter_git reset --hard old-main &&
+		META="ref=refs/heads/old-main treeish=$MAIN" &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
@@ -487,9 +487,9 @@ test_expect_success PERL 'required process filter should filter data for various
 		test_cmp_exclude_clean expected.log debug.log &&
 
 		git checkout -b merge empty-branch &&
-		git branch -f master $MASTER2 &&
-		filter_git merge master &&
-		META="treeish=$MASTER2" &&
+		git branch -f main $MAIN2 &&
+		filter_git merge main &&
+		META="treeish=$MAIN2" &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
@@ -502,8 +502,8 @@ test_expect_success PERL 'required process filter should filter data for various
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
 
-		filter_git archive master >/dev/null &&
-		META="ref=refs/heads/master treeish=$MASTER2" &&
+		filter_git archive main >/dev/null &&
+		META="ref=refs/heads/main treeish=$MAIN2" &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
@@ -516,7 +516,7 @@ test_expect_success PERL 'required process filter should filter data for various
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
 
-		TREE="$(git rev-parse $MASTER2^{tree})" &&
+		TREE="$(git rev-parse $MAIN2^{tree})" &&
 		filter_git archive $TREE >/dev/null &&
 		META="treeish=$TREE" &&
 		cat >expected.log <<-EOF &&
@@ -856,8 +856,8 @@ test_expect_success PERL 'delayed checkout in process filter' '
 	) &&
 
 	S=$(test_file_size "$TEST_ROOT/test.o") &&
-	PM="ref=refs/heads/master treeish=$(git -C repo rev-parse --verify master) " &&
-	M="${PM}blob=$(git -C repo rev-parse --verify master:test.a)" &&
+	PM="ref=refs/heads/main treeish=$(git -C repo rev-parse --verify main) " &&
+	M="${PM}blob=$(git -C repo rev-parse --verify main:test.a)" &&
 	cat >a.exp <<-EOF &&
 		START
 		init handshake complete
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 9fcd56fab3..51f74a3ddf 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -368,9 +368,9 @@ test_expect_success 'ls-files --eol -o Text/Binary' '
 	test_cmp expect actual
 '
 
-test_expect_success 'setup master' '
+test_expect_success 'setup main' '
 	echo >.gitattributes &&
-	git checkout -b master &&
+	git checkout -b main &&
 	git add .gitattributes &&
 	git commit -m "add .gitattributes" . &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nLINETWO\nLINETHREE"     >LF &&
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index bfc4fb9af5..9c48037884 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -215,7 +215,7 @@ test_expect_success 'error if encoding round trip is not the same during refresh
 	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16le) &&
 	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16le &&
 	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
-	git update-ref refs/heads/master $COMMIT &&
+	git update-ref refs/heads/main $COMMIT &&
 
 	test_must_fail git checkout HEAD^ 2>err.out &&
 	test_i18ngrep "error: .* overwritten by checkout:" err.out
@@ -231,7 +231,7 @@ test_expect_success 'error if encoding garbage is already in Git' '
 	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
 	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
 	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
-	git update-ref refs/heads/master $COMMIT &&
+	git update-ref refs/heads/main $COMMIT &&
 
 	git diff 2>err.out &&
 	test_i18ngrep "error: BOM is required" err.out
diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
index 5b927b76fe..6f93450597 100755
--- a/t/t0041-usage.sh
+++ b/t/t0041-usage.sh
@@ -41,8 +41,8 @@ test_expect_success 'tag usage error' '
 '
 
 test_expect_success 'branch --contains <existent_commit>' '
-	git branch --contains "master" >actual 2>actual.err &&
-	test_i18ngrep "master" actual &&
+	git branch --contains "main" >actual 2>actual.err &&
+	test_i18ngrep "main" actual &&
 	test_line_count = 0 actual.err
 '
 
@@ -54,7 +54,7 @@ test_expect_success 'branch --contains <inexistent_commit>' '
 '
 
 test_expect_success 'branch --no-contains <existent_commit>' '
-	git branch --no-contains "master" >actual 2>actual.err &&
+	git branch --no-contains "main" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_line_count = 0 actual.err
 '
@@ -73,7 +73,7 @@ test_expect_success 'branch usage error' '
 '
 
 test_expect_success 'for-each-ref --contains <existent_object>' '
-	git for-each-ref --contains "master" >actual 2>actual.err &&
+	git for-each-ref --contains "main" >actual 2>actual.err &&
 	test_line_count = 2 actual &&
 	test_line_count = 0 actual.err
 '
@@ -86,7 +86,7 @@ test_expect_success 'for-each-ref --contains <inexistent_object>' '
 '
 
 test_expect_success 'for-each-ref --no-contains <existent_object>' '
-	git for-each-ref --no-contains "master" >actual 2>actual.err &&
+	git for-each-ref --no-contains "main" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_line_count = 0 actual.err
 '
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 608673fb77..e3412b896b 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -65,7 +65,7 @@ test_expect_success "setup case tests" '
 	git mv camelcase tmp &&
 	git mv tmp CamelCase &&
 	git commit -m "rename" &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_expect_success 'rename (case change)' '
@@ -118,7 +118,7 @@ test_expect_success "setup unicode normalization tests" '
 	git mv $aumlcdiar tmp &&
 	git mv tmp "$auml" &&
 	git commit -m rename &&
-	git checkout -f master
+	git checkout -f main
 '
 
 $test_unicode 'rename (silent unicode normalization)' '
@@ -147,7 +147,7 @@ test_expect_success CASE_INSENSITIVE_FS 'checkout with no pathspec and a case in
 		git add gitweb &&
 		git commit -m "add gitweb/subdir/file" &&
 
-		git checkout master
+		git checkout main
 	)
 '
 
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 928eebbdc0..fab077b6f7 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -312,8 +312,8 @@ test_git_path GIT_COMMON_DIR=bar info/sparse-checkout     .git/info/sparse-check
 test_git_path GIT_COMMON_DIR=bar info//sparse-checkout    .git/info//sparse-checkout
 test_git_path GIT_COMMON_DIR=bar remotes/bar              bar/remotes/bar
 test_git_path GIT_COMMON_DIR=bar branches/bar             bar/branches/bar
-test_git_path GIT_COMMON_DIR=bar logs/refs/heads/master     bar/logs/refs/heads/master
-test_git_path GIT_COMMON_DIR=bar refs/heads/master          bar/refs/heads/master
+test_git_path GIT_COMMON_DIR=bar logs/refs/heads/main     bar/logs/refs/heads/main
+test_git_path GIT_COMMON_DIR=bar refs/heads/main          bar/refs/heads/main
 test_git_path GIT_COMMON_DIR=bar refs/bisect/foo          .git/refs/bisect/foo
 test_git_path GIT_COMMON_DIR=bar hooks/me                 bar/hooks/me
 test_git_path GIT_COMMON_DIR=bar config                   bar/config
diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index 58c0b7e9b6..dfb367b720 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -8,7 +8,7 @@ test_expect_success 'branch -d @{-1}' '
 	test_commit A &&
 	git checkout -b junk &&
 	git checkout - &&
-	test "$(git symbolic-ref HEAD)" = refs/heads/master &&
+	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
 	git branch -d @{-1} &&
 	test_must_fail git rev-parse --verify refs/heads/junk
 '
@@ -17,9 +17,9 @@ test_expect_success 'branch -d @{-12} when there is not enough switches yet' '
 	git reflog expire --expire=now &&
 	git checkout -b junk2 &&
 	git checkout - &&
-	test "$(git symbolic-ref HEAD)" = refs/heads/master &&
+	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
 	test_must_fail git branch -d @{-12} &&
-	git rev-parse --verify refs/heads/master
+	git rev-parse --verify refs/heads/main
 '
 
 test_expect_success 'merge @{-1}' '
@@ -28,19 +28,19 @@ test_expect_success 'merge @{-1}' '
 	git checkout A &&
 	test_commit C &&
 	test_commit D &&
-	git branch -f master B &&
+	git branch -f main B &&
 	git branch -f other &&
 	git checkout other &&
-	git checkout master &&
+	git checkout main &&
 	git merge @{-1} &&
 	git cat-file commit HEAD | grep "Merge branch '\''other'\''"
 '
 
 test_expect_success 'merge @{-1}~1' '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard B &&
 	git checkout other &&
-	git checkout master &&
+	git checkout main &&
 	git merge @{-1}~1 &&
 	git cat-file commit HEAD >actual &&
 	grep "Merge branch '\''other'\''" actual
@@ -48,11 +48,11 @@ test_expect_success 'merge @{-1}~1' '
 
 test_expect_success 'merge @{-100} before checking out that many branches yet' '
 	git reflog expire --expire=now &&
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard B &&
 	git branch -f other C &&
 	git checkout other &&
-	git checkout master &&
+	git checkout main &&
 	test_must_fail git merge @{-100}
 '
 
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 181956b241..c8a81f180f 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -20,17 +20,17 @@ test_expect_success 'two-way setup' '
 	git branch side &&
 	git tag -f branch-point &&
 
-	echo file2 is not tracked on the master branch anymore &&
+	echo file2 is not tracked on the main branch anymore &&
 	rm -f file2 subdir/file2 &&
 	git update-index --remove file2 subdir/file2 &&
-	git commit -a -m "master removes file2 and subdir/file2"
+	git commit -a -m "main removes file2 and subdir/file2"
 '
 
 test_expect_success 'two-way not clobbering' '
 
-	echo >file2 master creates untracked file2 &&
-	echo >subdir/file2 master creates untracked subdir/file2 &&
-	if err=$(read_tree_u_must_succeed -m -u master side 2>&1)
+	echo >file2 main creates untracked file2 &&
+	echo >subdir/file2 main creates untracked subdir/file2 &&
+	if err=$(read_tree_u_must_succeed -m -u main side 2>&1)
 	then
 		echo should have complained
 		false
@@ -43,7 +43,7 @@ echo file2 >.gitignore
 
 test_expect_success 'two-way with incorrect --exclude-per-directory (1)' '
 
-	if err=$(read_tree_u_must_succeed -m --exclude-per-directory=.gitignore master side 2>&1)
+	if err=$(read_tree_u_must_succeed -m --exclude-per-directory=.gitignore main side 2>&1)
 	then
 		echo should have complained
 		false
@@ -54,7 +54,7 @@ test_expect_success 'two-way with incorrect --exclude-per-directory (1)' '
 
 test_expect_success 'two-way with incorrect --exclude-per-directory (2)' '
 
-	if err=$(read_tree_u_must_succeed -m -u --exclude-per-directory=foo --exclude-per-directory=.gitignore master side 2>&1)
+	if err=$(read_tree_u_must_succeed -m -u --exclude-per-directory=foo --exclude-per-directory=.gitignore main side 2>&1)
 	then
 		echo should have complained
 		false
@@ -65,7 +65,7 @@ test_expect_success 'two-way with incorrect --exclude-per-directory (2)' '
 
 test_expect_success 'two-way clobbering a ignored file' '
 
-	read_tree_u_must_succeed -m -u --exclude-per-directory=.gitignore master side
+	read_tree_u_must_succeed -m -u --exclude-per-directory=.gitignore main side
 '
 
 rm -f .gitignore
@@ -81,21 +81,21 @@ test_expect_success 'three-way not complaining on an untracked path in both' '
 	git update-index --add file3 subdir/file3 &&
 	git commit -a -m "side adds file3 and removes file2" &&
 
-	git checkout master &&
-	echo >file2 file two is untracked on the master side &&
-	echo >subdir/file2 file two is untracked on the master side &&
+	git checkout main &&
+	echo >file2 file two is untracked on the main side &&
+	echo >subdir/file2 file two is untracked on the main side &&
 
-	read_tree_u_must_succeed -m -u branch-point master side
+	read_tree_u_must_succeed -m -u branch-point main side
 '
 
 test_expect_success 'three-way not clobbering a working tree file' '
 
 	git reset --hard &&
 	rm -f file2 subdir/file2 file3 subdir/file3 &&
-	git checkout master &&
-	echo >file3 file three created in master, untracked &&
-	echo >subdir/file3 file three created in master, untracked &&
-	if err=$(read_tree_u_must_succeed -m -u branch-point master side 2>&1)
+	git checkout main &&
+	echo >file3 file three created in main, untracked &&
+	echo >subdir/file3 file three created in main, untracked &&
+	if err=$(read_tree_u_must_succeed -m -u branch-point main side 2>&1)
 	then
 		echo should have complained
 		false
@@ -110,11 +110,11 @@ test_expect_success 'three-way not complaining on an untracked file' '
 
 	git reset --hard &&
 	rm -f file2 subdir/file2 file3 subdir/file3 &&
-	git checkout master &&
-	echo >file3 file three created in master, untracked &&
-	echo >subdir/file3 file three created in master, untracked &&
+	git checkout main &&
+	echo >file3 file three created in main, untracked &&
+	echo >subdir/file3 file three created in main, untracked &&
 
-	read_tree_u_must_succeed -m -u --exclude-per-directory=.gitignore branch-point master side
+	read_tree_u_must_succeed -m -u --exclude-per-directory=.gitignore branch-point main side
 '
 
 test_expect_success '3-way not overwriting local changes (setup)' '
diff --git a/t/t1008-read-tree-overlay.sh b/t/t1008-read-tree-overlay.sh
index cf96016844..2a757bd6d5 100755
--- a/t/t1008-read-tree-overlay.sh
+++ b/t/t1008-read-tree-overlay.sh
@@ -22,7 +22,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'multi-read' '
-	read_tree_must_succeed initial master side &&
+	read_tree_must_succeed initial main side &&
 	test_write_lines a b/c >expect &&
 	git ls-files >actual &&
 	test_cmp expect actual
diff --git a/t/t1009-read-tree-new-index.sh b/t/t1009-read-tree-new-index.sh
index 59b3aa4bc4..7302adfb20 100755
--- a/t/t1009-read-tree-new-index.sh
+++ b/t/t1009-read-tree-new-index.sh
@@ -12,13 +12,13 @@ test_expect_success setup '
 
 test_expect_success 'non-existent index file' '
 	rm -f new-index &&
-	GIT_INDEX_FILE=new-index git read-tree master
+	GIT_INDEX_FILE=new-index git read-tree main
 '
 
 test_expect_success 'empty index file' '
 	rm -f new-index &&
 	> new-index &&
-	GIT_INDEX_FILE=new-index git read-tree master
+	GIT_INDEX_FILE=new-index git read-tree main
 '
 
 test_done
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 140f459977..dfe9794a74 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -2,7 +2,7 @@
 
 test_description='sparse checkout tests
 
-* (tag: removed, master) removed
+* (tag: removed, main) removed
 | D	sub/added
 * (HEAD, tag: top) modified and added
 | M	init.t
diff --git a/t/t1021-rerere-in-workdir.sh b/t/t1021-rerere-in-workdir.sh
index 301e071ff7..a32b4a50e0 100755
--- a/t/t1021-rerere-in-workdir.sh
+++ b/t/t1021-rerere-in-workdir.sh
@@ -19,7 +19,7 @@ test_expect_success SYMLINKS setup '
 	test_tick &&
 	git commit -a -m goodbye &&
 
-	git checkout master
+	git checkout main
 '
 
 test_expect_success SYMLINKS 'rerere in workdir' '
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index f35a73dd20..6c253fd526 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -20,18 +20,18 @@ test_expect_success 'create feature branch' '
 	git commit -m "modification"
 '
 
-test_expect_success 'perform sparse checkout of master' '
+test_expect_success 'perform sparse checkout of main' '
 	git config --local --bool core.sparsecheckout true &&
 	echo "!/*" >.git/info/sparse-checkout &&
 	echo "/a" >>.git/info/sparse-checkout &&
 	echo "/c" >>.git/info/sparse-checkout &&
-	git checkout master &&
+	git checkout main &&
 	test_path_is_file a &&
 	test_path_is_missing b &&
 	test_path_is_file c
 '
 
-test_expect_success 'merge feature branch into sparse checkout of master' '
+test_expect_success 'merge feature branch into sparse checkout of main' '
 	git merge feature &&
 	test_path_is_file a &&
 	test_path_is_missing b &&
@@ -39,10 +39,10 @@ test_expect_success 'merge feature branch into sparse checkout of master' '
 	test "$(cat c)" = "modified"
 '
 
-test_expect_success 'return to full checkout of master' '
+test_expect_success 'return to full checkout of main' '
 	git checkout feature &&
 	echo "/*" >.git/info/sparse-checkout &&
-	git checkout master &&
+	git checkout main &&
 	test_path_is_file a &&
 	test_path_is_file b &&
 	test_path_is_file c &&
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 84acfc48b6..4ee16805bb 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -117,7 +117,7 @@ test_expect_success 'interaction with clone --no-checkout (unborn index)' '
 	test_path_is_missing clone_no_checkout/.git/index &&
 
 	# No branch is checked out until we manually switch to one
-	git -C clone_no_checkout switch master &&
+	git -C clone_no_checkout switch main &&
 	test_path_is_file clone_no_checkout/.git/index &&
 	check_files clone_no_checkout a folder1
 '
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 825d9a184f..11a8e641da 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1054,8 +1054,8 @@ test_expect_success 'check split_cmdline return' "
 	echo foo > foo &&
 	git add foo &&
 	git commit -m 'initial commit' &&
-	git config branch.master.mergeoptions 'echo \"' &&
-	test_must_fail git merge master
+	git config branch.main.mergeoptions 'echo \"' &&
+	test_must_fail git merge main
 "
 
 test_expect_success 'git -c "key=value" support' '
@@ -1769,11 +1769,11 @@ test_expect_success '--show-origin blob' '
 
 test_expect_success '--show-origin blob ref' '
 	cat >expect <<-\EOF &&
-	blob:master:custom.conf	user.custom=true
+	blob:main:custom.conf	user.custom=true
 	EOF
 	git add "$CUSTOM_CONFIG_FILE" &&
 	git commit -m "new config file" &&
-	git config --blob=master:"$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
+	git config --blob=main:"$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
 	test_cmp expect output
 '
 
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 2dc853d1be..b0236ffe4a 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -115,13 +115,13 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	umask 077 &&
 	git config core.sharedRepository group &&
 	git reflog expire --all &&
-	actual="$(ls -l .git/logs/refs/heads/master)" &&
+	actual="$(ls -l .git/logs/refs/heads/main)" &&
 	case "$actual" in
 	-rw-rw-*)
 		: happy
 		;;
 	*)
-		echo Ooops, .git/logs/refs/heads/master is not 0662 [$actual]
+		echo Ooops, .git/logs/refs/heads/main is not 0662 [$actual]
 		false
 		;;
 	esac
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index f1e1b289f9..938ca17d78 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -312,7 +312,7 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icas
 test_expect_success 'conditional include, onbranch' '
 	echo "[includeIf \"onbranch:foo-branch\"]path=bar9" >>.git/config &&
 	echo "[test]nine=9" >.git/bar9 &&
-	git checkout -b master &&
+	git checkout -b main &&
 	test_must_fail git config test.nine &&
 	git checkout -b foo-branch &&
 	echo 9 >expect &&
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index ebb8e1aecb..598e62eb4c 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -91,11 +91,11 @@ test_expect_failure 'ignore .git/ with invalid config' '
 
 test_expect_success 'early config and onbranch' '
 	echo "[broken" >broken &&
-	test_with_config "[includeif \"onbranch:master\"]path=../broken"
+	test_with_config "[includeif \"onbranch:main\"]path=../broken"
 '
 
 test_expect_success 'onbranch config outside of git repo' '
-	test_config_global includeIf.onbranch:master.path non-existent &&
+	test_config_global includeIf.onbranch:main.path non-existent &&
 	nongit git help
 '
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4c01e08551..3265a8c58e 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -8,7 +8,7 @@ test_description='Test git update-ref and basic ref logging'
 
 Z=$ZERO_OID
 
-m=refs/heads/master
+m=refs/heads/main
 n_dir=refs/heads/gu
 n=$n_dir/fixes
 outside=refs/foo
@@ -258,7 +258,7 @@ test_expect_success "(not) changed .git/$m" '
 	! test $B = $(git show-ref -s --verify $m)
 '
 
-rm -f .git/logs/refs/heads/master
+rm -f .git/logs/refs/heads/main
 test_expect_success "create $m (logged by touch)" '
 	test_config core.logAllRefUpdates false &&
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
@@ -294,7 +294,7 @@ test_expect_success 'symref empty directory removal' '
 	git branch e1/e2/r1 HEAD &&
 	git branch e1/r2 HEAD &&
 	git checkout e1/e2/r1 &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	test_path_is_file .git/refs/heads/e1/e2/r1 &&
 	test_path_is_file .git/logs/refs/heads/e1/e2/r1 &&
 	git update-ref -d HEAD &&
@@ -358,68 +358,68 @@ test_expect_success 'set up for querying the reflog' '
 ed="Thu, 26 May 2005 18:32:00 -0500"
 gd="Thu, 26 May 2005 18:33:00 -0500"
 ld="Thu, 26 May 2005 18:43:00 -0500"
-test_expect_success 'Query "master@{May 25 2005}" (before history)' '
+test_expect_success 'Query "main@{May 25 2005}" (before history)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{May 25 2005}" >o 2>e &&
+	git rev-parse --verify "main@{May 25 2005}" >o 2>e &&
 	echo "$C" >expect &&
 	test_cmp expect o &&
-	echo "warning: log for '\''master'\'' only goes back to $ed" >expect &&
+	echo "warning: log for '\''main'\'' only goes back to $ed" >expect &&
 	test_i18ncmp expect e
 '
-test_expect_success 'Query master@{2005-05-25} (before history)' '
+test_expect_success 'Query main@{2005-05-25} (before history)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify master@{2005-05-25} >o 2>e &&
+	git rev-parse --verify main@{2005-05-25} >o 2>e &&
 	echo "$C" >expect &&
 	test_cmp expect o &&
-	echo "warning: log for '\''master'\'' only goes back to $ed" >expect &&
+	echo "warning: log for '\''main'\'' only goes back to $ed" >expect &&
 	test_i18ncmp expect e
 '
-test_expect_success 'Query "master@{May 26 2005 23:31:59}" (1 second before history)' '
+test_expect_success 'Query "main@{May 26 2005 23:31:59}" (1 second before history)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{May 26 2005 23:31:59}" >o 2>e &&
+	git rev-parse --verify "main@{May 26 2005 23:31:59}" >o 2>e &&
 	echo "$C" >expect &&
 	test_cmp expect o &&
-	echo "warning: log for '\''master'\'' only goes back to $ed" >expect &&
+	echo "warning: log for '\''main'\'' only goes back to $ed" >expect &&
 	test_i18ncmp expect e
 '
-test_expect_success 'Query "master@{May 26 2005 23:32:00}" (exactly history start)' '
+test_expect_success 'Query "main@{May 26 2005 23:32:00}" (exactly history start)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{May 26 2005 23:32:00}" >o 2>e &&
+	git rev-parse --verify "main@{May 26 2005 23:32:00}" >o 2>e &&
 	echo "$C" >expect &&
 	test_cmp expect o &&
 	test_must_be_empty e
 '
-test_expect_success 'Query "master@{May 26 2005 23:32:30}" (first non-creation change)' '
+test_expect_success 'Query "main@{May 26 2005 23:32:30}" (first non-creation change)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{May 26 2005 23:32:30}" >o 2>e &&
+	git rev-parse --verify "main@{May 26 2005 23:32:30}" >o 2>e &&
 	echo "$A" >expect &&
 	test_cmp expect o &&
 	test_must_be_empty e
 '
-test_expect_success 'Query "master@{2005-05-26 23:33:01}" (middle of history with gap)' '
+test_expect_success 'Query "main@{2005-05-26 23:33:01}" (middle of history with gap)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
+	git rev-parse --verify "main@{2005-05-26 23:33:01}" >o 2>e &&
 	echo "$B" >expect &&
 	test_cmp expect o &&
 	test_i18ngrep -F "warning: log for ref $m has gap after $gd" e
 '
-test_expect_success 'Query "master@{2005-05-26 23:38:00}" (middle of history)' '
+test_expect_success 'Query "main@{2005-05-26 23:38:00}" (middle of history)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{2005-05-26 23:38:00}" >o 2>e &&
+	git rev-parse --verify "main@{2005-05-26 23:38:00}" >o 2>e &&
 	echo "$Z" >expect &&
 	test_cmp expect o &&
 	test_must_be_empty e
 '
-test_expect_success 'Query "master@{2005-05-26 23:43:00}" (exact end of history)' '
+test_expect_success 'Query "main@{2005-05-26 23:43:00}" (exact end of history)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{2005-05-26 23:43:00}" >o 2>e &&
+	git rev-parse --verify "main@{2005-05-26 23:43:00}" >o 2>e &&
 	echo "$E" >expect &&
 	test_cmp expect o &&
 	test_must_be_empty e
 '
-test_expect_success 'Query "master@{2005-05-28}" (past end of history)' '
+test_expect_success 'Query "main@{2005-05-28}" (past end of history)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
+	git rev-parse --verify "main@{2005-05-28}" >o 2>e &&
 	echo "$D" >expect &&
 	test_cmp expect o &&
 	test_i18ngrep -F "warning: log for ref $m unexpectedly ended on $ld" e
@@ -461,14 +461,14 @@ test_expect_success 'git commit logged updates' '
 '
 unset h_TEST h_OTHER h_FIXED h_MERGED
 
-test_expect_success 'git cat-file blob master:F (expect OTHER)' '
-	test OTHER = $(git cat-file blob master:F)
+test_expect_success 'git cat-file blob main:F (expect OTHER)' '
+	test OTHER = $(git cat-file blob main:F)
 '
-test_expect_success 'git cat-file blob master@{2005-05-26 23:30}:F (expect TEST)' '
-	test TEST = $(git cat-file blob "master@{2005-05-26 23:30}:F")
+test_expect_success 'git cat-file blob main@{2005-05-26 23:30}:F (expect TEST)' '
+	test TEST = $(git cat-file blob "main@{2005-05-26 23:30}:F")
 '
-test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' '
-	test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")
+test_expect_success 'git cat-file blob main@{2005-05-26 23:42}:F (expect OTHER)' '
+	test OTHER = $(git cat-file blob "main@{2005-05-26 23:42}:F")
 '
 
 # Test adding and deleting pseudorefs
@@ -580,9 +580,9 @@ test_expect_success 'stdin fails on unknown command' '
 '
 
 test_expect_success 'stdin fails on unbalanced quotes' '
-	echo "create $a \"master" >stdin &&
+	echo "create $a \"main" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: badly quoted argument: \\\"master" err
+	grep "fatal: badly quoted argument: \\\"main" err
 '
 
 test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin fails on invalid escape' '
@@ -592,9 +592,9 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin fails on invalid escape' '
 '
 
 test_expect_success 'stdin fails on junk after quoted argument' '
-	echo "create \"$a\"master" >stdin &&
+	echo "create \"$a\"main" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: unexpected character after quoted argument: \\\"$a\\\"master" err
+	grep "fatal: unexpected character after quoted argument: \\\"$a\\\"main" err
 '
 
 test_expect_success 'stdin fails create with no ref' '
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 98e4a8613b..c19fa344d1 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -134,15 +134,15 @@ valid_ref !MINGW "$ref" '--refspec-pattern --allow-onelevel --normalize'
 test_expect_success "check-ref-format --branch @{-1}" '
 	T=$(git write-tree) &&
 	sha1=$(echo A | git commit-tree $T) &&
-	git update-ref refs/heads/master $sha1 &&
-	git update-ref refs/remotes/origin/master $sha1 &&
-	git checkout master &&
-	git checkout origin/master &&
-	git checkout master &&
+	git update-ref refs/heads/main $sha1 &&
+	git update-ref refs/remotes/origin/main $sha1 &&
+	git checkout main &&
+	git checkout origin/main &&
+	git checkout main &&
 	refname=$(git check-ref-format --branch @{-1}) &&
 	test "$refname" = "$sha1" &&
 	refname2=$(git check-ref-format --branch @{-2}) &&
-	test "$refname2" = master'
+	test "$refname2" = main'
 
 test_expect_success 'check-ref-format --branch -naster' '
 	test_must_fail git check-ref-format --branch -naster >actual &&
@@ -154,11 +154,11 @@ test_expect_success 'check-ref-format --branch from subdir' '
 
 	T=$(git write-tree) &&
 	sha1=$(echo A | git commit-tree $T) &&
-	git update-ref refs/heads/master $sha1 &&
-	git update-ref refs/remotes/origin/master $sha1 &&
-	git checkout master &&
-	git checkout origin/master &&
-	git checkout master &&
+	git update-ref refs/heads/main $sha1 &&
+	git update-ref refs/remotes/origin/main $sha1 &&
+	git checkout main &&
+	git checkout origin/main &&
+	git checkout main &&
 	refname=$(
 		cd subdir &&
 		git check-ref-format --branch @{-1}
@@ -171,9 +171,9 @@ test_expect_success 'check-ref-format --branch @{-1} from non-repo' '
 	test_must_be_empty actual
 '
 
-test_expect_success 'check-ref-format --branch master from non-repo' '
-	echo master >expect &&
-	nongit git check-ref-format --branch master >actual &&
+test_expect_success 'check-ref-format --branch main from non-repo' '
+	echo main >expect &&
+	nongit git check-ref-format --branch main >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 5d955c3bff..681b7022c3 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -9,7 +9,7 @@ test_expect_success setup '
 	git checkout -b side &&
 	test_commit B &&
 	git tag -f -a -m "annotated B" B &&
-	git checkout master &&
+	git checkout main &&
 	test_commit C &&
 	git branch B A^0
 '
@@ -92,23 +92,23 @@ test_expect_success 'show-ref -d' '
 	git show-ref --verify -d refs/tags/A refs/tags/C >actual &&
 	test_cmp expect actual &&
 
-	echo $(git rev-parse refs/heads/master) refs/heads/master >expect &&
-	git show-ref -d master >actual &&
+	echo $(git rev-parse refs/heads/main) refs/heads/main >expect &&
+	git show-ref -d main >actual &&
 	test_cmp expect actual &&
 
-	git show-ref -d heads/master >actual &&
+	git show-ref -d heads/main >actual &&
 	test_cmp expect actual &&
 
-	git show-ref -d refs/heads/master >actual &&
+	git show-ref -d refs/heads/main >actual &&
 	test_cmp expect actual &&
 
-	git show-ref -d --verify refs/heads/master >actual &&
+	git show-ref -d --verify refs/heads/main >actual &&
 	test_cmp expect actual &&
 
-	test_must_fail git show-ref -d --verify master >actual &&
+	test_must_fail git show-ref -d --verify main >actual &&
 	test_must_be_empty actual &&
 
-	test_must_fail git show-ref -d --verify heads/master >actual &&
+	test_must_fail git show-ref -d --verify heads/main >actual &&
 	test_must_be_empty actual &&
 
 	test_must_fail git show-ref --verify -d A C >actual &&
@@ -120,7 +120,7 @@ test_expect_success 'show-ref -d' '
 '
 
 test_expect_success 'show-ref --heads, --tags, --head, pattern' '
-	for branch in B master side
+	for branch in B main side
 	do
 		echo $(git rev-parse refs/heads/$branch) refs/heads/$branch
 	done >expect.heads &&
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 74af927fba..5661df799b 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -21,9 +21,9 @@ test_expect_success 'peel_ref(new-tag)' '
 	test_cmp expected actual
 '
 
-test_expect_success 'create_symref(FOO, refs/heads/master)' '
-	$RUN create-symref FOO refs/heads/master nothing &&
-	echo refs/heads/master >expected &&
+test_expect_success 'create_symref(FOO, refs/heads/main)' '
+	$RUN create-symref FOO refs/heads/main nothing &&
+	echo refs/heads/main >expected &&
 	git symbolic-ref FOO >actual &&
 	test_cmp expected actual
 '
@@ -31,7 +31,7 @@ test_expect_success 'create_symref(FOO, refs/heads/master)' '
 test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
 	git rev-parse FOO -- &&
 	git rev-parse refs/tags/new-tag -- &&
-	m=$(git rev-parse master) &&
+	m=$(git rev-parse main) &&
 	REF_NO_DEREF=1 &&
 	$RUN delete-refs $REF_NO_DEREF nothing FOO refs/tags/new-tag &&
 	test_must_fail git rev-parse --symbolic-full-name FOO &&
@@ -39,19 +39,19 @@ test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
 	test_must_fail git rev-parse refs/tags/new-tag --
 '
 
-test_expect_success 'rename_refs(master, new-master)' '
-	git rev-parse master >expected &&
-	$RUN rename-ref refs/heads/master refs/heads/new-master &&
-	git rev-parse new-master >actual &&
+test_expect_success 'rename_refs(main, new-main)' '
+	git rev-parse main >expected &&
+	$RUN rename-ref refs/heads/main refs/heads/new-main &&
+	git rev-parse new-main >actual &&
 	test_cmp expected actual &&
-	test_commit recreate-master
+	test_commit recreate-main
 '
 
 test_expect_success 'for_each_ref(refs/heads/)' '
 	$RUN for-each-ref refs/heads/ | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
-	master 0x0
-	new-master 0x0
+	main 0x0
+	new-main 0x0
 	EOF
 	test_cmp expected actual
 '
@@ -62,23 +62,23 @@ test_expect_success 'for_each_ref() is sorted' '
 	test_cmp expected actual
 '
 
-test_expect_success 'resolve_ref(new-master)' '
-	SHA1=`git rev-parse new-master` &&
-	echo "$SHA1 refs/heads/new-master 0x0" >expected &&
-	$RUN resolve-ref refs/heads/new-master 0 >actual &&
+test_expect_success 'resolve_ref(new-main)' '
+	SHA1=`git rev-parse new-main` &&
+	echo "$SHA1 refs/heads/new-main 0x0" >expected &&
+	$RUN resolve-ref refs/heads/new-main 0 >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success 'verify_ref(new-master)' '
-	$RUN verify-ref refs/heads/new-master
+test_expect_success 'verify_ref(new-main)' '
+	$RUN verify-ref refs/heads/new-main
 '
 
 test_expect_success 'for_each_reflog()' '
 	$RUN for-each-reflog | sort -k2 | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
-	refs/heads/master 0x0
-	refs/heads/new-master 0x0
+	refs/heads/main 0x0
+	refs/heads/new-main 0x0
 	EOF
 	test_cmp expected actual
 '
@@ -86,12 +86,12 @@ test_expect_success 'for_each_reflog()' '
 test_expect_success 'for_each_reflog_ent()' '
 	$RUN for-each-reflog-ent HEAD >actual &&
 	head -n1 actual | grep one &&
-	tail -n2 actual | head -n1 | grep recreate-master
+	tail -n2 actual | head -n1 | grep recreate-main
 '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
-	head -n1 actual | grep recreate-master &&
+	head -n1 actual | grep recreate-main &&
 	tail -n2 actual | head -n1 | grep one
 '
 
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 36b7ef5046..e3e3b9c84c 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup' '
 	(
 		cd sub &&
 		test_commit first &&
-		git checkout -b new-master
+		git checkout -b new-main
 	)
 '
 
@@ -27,7 +27,7 @@ test_expect_success 'peel_ref(new-tag)' '
 '
 
 test_expect_success 'create_symref() not allowed' '
-	test_must_fail $RUN create-symref FOO refs/heads/master nothing
+	test_must_fail $RUN create-symref FOO refs/heads/main nothing
 '
 
 test_expect_success 'delete_refs() not allowed' '
@@ -35,14 +35,14 @@ test_expect_success 'delete_refs() not allowed' '
 '
 
 test_expect_success 'rename_refs() not allowed' '
-	test_must_fail $RUN rename-ref refs/heads/master refs/heads/new-master
+	test_must_fail $RUN rename-ref refs/heads/main refs/heads/new-main
 '
 
 test_expect_success 'for_each_ref(refs/heads/)' '
 	$RUN for-each-ref refs/heads/ | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
-	master 0x0
-	new-master 0x0
+	main 0x0
+	new-main 0x0
 	EOF
 	test_cmp expected actual
 '
@@ -53,23 +53,23 @@ test_expect_success 'for_each_ref() is sorted' '
 	test_cmp expected actual
 '
 
-test_expect_success 'resolve_ref(master)' '
-	SHA1=`git -C sub rev-parse master` &&
-	echo "$SHA1 refs/heads/master 0x0" >expected &&
-	$RUN resolve-ref refs/heads/master 0 >actual &&
+test_expect_success 'resolve_ref(main)' '
+	SHA1=`git -C sub rev-parse main` &&
+	echo "$SHA1 refs/heads/main 0x0" >expected &&
+	$RUN resolve-ref refs/heads/main 0 >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success 'verify_ref(new-master)' '
-	$RUN verify-ref refs/heads/new-master
+test_expect_success 'verify_ref(new-main)' '
+	$RUN verify-ref refs/heads/new-main
 '
 
 test_expect_success 'for_each_reflog()' '
 	$RUN for-each-reflog | sort | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
-	refs/heads/master 0x0
-	refs/heads/new-master 0x0
+	refs/heads/main 0x0
+	refs/heads/new-main 0x0
 	EOF
 	test_cmp expected actual
 '
@@ -77,12 +77,12 @@ test_expect_success 'for_each_reflog()' '
 test_expect_success 'for_each_reflog_ent()' '
 	$RUN for-each-reflog-ent HEAD >actual &&
 	head -n1 actual | grep first &&
-	tail -n2 actual | head -n1 | grep master.to.new
+	tail -n2 actual | head -n1 | grep main.to.new
 '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
-	head -n1 actual | grep master.to.new &&
+	head -n1 actual | grep main.to.new &&
 	tail -n2 actual | head -n1 | grep first
 '
 
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 9a84858118..71059cb254 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -9,7 +9,7 @@ RMAIN="test-tool ref-store worktree:main"
 
 test_expect_success 'setup' '
 	test_commit first &&
-	git worktree add -b wt-master wt &&
+	git worktree add -b wt-main wt &&
 	(
 		cd wt &&
 		test_commit second
@@ -17,34 +17,34 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'resolve_ref(<shared-ref>)' '
-	SHA1=`git rev-parse master` &&
-	echo "$SHA1 refs/heads/master 0x0" >expected &&
-	$RWT resolve-ref refs/heads/master 0 >actual &&
+	SHA1=`git rev-parse main` &&
+	echo "$SHA1 refs/heads/main 0x0" >expected &&
+	$RWT resolve-ref refs/heads/main 0 >actual &&
 	test_cmp expected actual &&
-	$RMAIN resolve-ref refs/heads/master 0 >actual &&
+	$RMAIN resolve-ref refs/heads/main 0 >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'resolve_ref(<per-worktree-ref>)' '
 	SHA1=`git -C wt rev-parse HEAD` &&
-	echo "$SHA1 refs/heads/wt-master 0x1" >expected &&
+	echo "$SHA1 refs/heads/wt-main 0x1" >expected &&
 	$RWT resolve-ref HEAD 0 >actual &&
 	test_cmp expected actual &&
 
 	SHA1=`git rev-parse HEAD` &&
-	echo "$SHA1 refs/heads/master 0x1" >expected &&
+	echo "$SHA1 refs/heads/main 0x1" >expected &&
 	$RMAIN resolve-ref HEAD 0 >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success 'create_symref(FOO, refs/heads/master)' '
-	$RWT create-symref FOO refs/heads/master nothing &&
-	echo refs/heads/master >expected &&
+test_expect_success 'create_symref(FOO, refs/heads/main)' '
+	$RWT create-symref FOO refs/heads/main nothing &&
+	echo refs/heads/main >expected &&
 	git -C wt symbolic-ref FOO >actual &&
 	test_cmp expected actual &&
 
-	$RMAIN create-symref FOO refs/heads/wt-master nothing &&
-	echo refs/heads/wt-master >expected &&
+	$RMAIN create-symref FOO refs/heads/wt-main nothing &&
+	echo refs/heads/wt-main >expected &&
 	git symbolic-ref FOO >actual &&
 	test_cmp expected actual
 '
@@ -63,8 +63,8 @@ test_expect_success 'for_each_reflog()' '
 	HEAD 0x1
 	PSEUDO-WT 0x0
 	refs/bisect/wt-random 0x0
-	refs/heads/master 0x0
-	refs/heads/wt-master 0x0
+	refs/heads/main 0x0
+	refs/heads/wt-main 0x0
 	EOF
 	test_cmp expected actual &&
 
@@ -73,8 +73,8 @@ test_expect_success 'for_each_reflog()' '
 	HEAD 0x1
 	PSEUDO-MAIN 0x0
 	refs/bisect/random 0x0
-	refs/heads/master 0x0
-	refs/heads/wt-master 0x0
+	refs/heads/main 0x0
+	refs/heads/wt-main 0x0
 	EOF
 	test_cmp expected actual
 '
diff --git a/t/t1408-packed-refs.sh b/t/t1408-packed-refs.sh
index 1e44a17eea..f40e7af8ce 100755
--- a/t/t1408-packed-refs.sh
+++ b/t/t1408-packed-refs.sh
@@ -9,32 +9,32 @@ test_expect_success setup '
 	git commit --allow-empty -m one &&
 	one=$(git rev-parse HEAD) &&
 	git for-each-ref >actual &&
-	echo "$one commit	refs/heads/master" >expect &&
+	echo "$one commit	refs/heads/main" >expect &&
 	test_cmp expect actual &&
 
 	git pack-refs --all &&
 	git for-each-ref >actual &&
-	echo "$one commit	refs/heads/master" >expect &&
+	echo "$one commit	refs/heads/main" >expect &&
 	test_cmp expect actual &&
 
 	git checkout --orphan another &&
 	test_tick &&
 	git commit --allow-empty -m two &&
 	two=$(git rev-parse HEAD) &&
-	git checkout -B master &&
+	git checkout -B main &&
 	git branch -D another &&
 
 	git for-each-ref >actual &&
-	echo "$two commit	refs/heads/master" >expect &&
+	echo "$two commit	refs/heads/main" >expect &&
 	test_cmp expect actual &&
 
 	git reflog expire --expire=now --all &&
 	git prune &&
-	git tag -m v1.0 v1.0 master
+	git tag -m v1.0 v1.0 main
 '
 
 test_expect_success 'no error from stale entry in packed-refs' '
-	git describe master >actual 2>&1 &&
+	git describe main >actual 2>&1 &&
 	echo "v1.0" >expect &&
 	test_cmp expect actual
 '
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 730a43d9dd..8553141434 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -99,7 +99,7 @@ test_expect_success setup '
 
 	check_fsck &&
 
-	git reflog refs/heads/master >output &&
+	git reflog refs/heads/main >output &&
 	test_line_count = 4 output
 '
 
@@ -116,7 +116,7 @@ test_expect_success rewind '
 
 	check_have A B C D E F G H I J K L &&
 
-	git reflog refs/heads/master >output &&
+	git reflog refs/heads/main >output &&
 	test_line_count = 5 output
 '
 
@@ -135,7 +135,7 @@ test_expect_success 'reflog expire --dry-run should not touch reflog' '
 		--stale-fix \
 		--all &&
 
-	git reflog refs/heads/master >output &&
+	git reflog refs/heads/main >output &&
 	test_line_count = 5 output &&
 
 	check_fsck "missing blob $F"
@@ -149,7 +149,7 @@ test_expect_success 'reflog expire' '
 		--stale-fix \
 		--all &&
 
-	git reflog refs/heads/master >output &&
+	git reflog refs/heads/main >output &&
 	test_line_count = 2 output &&
 
 	check_fsck "dangling commit $K"
@@ -186,29 +186,29 @@ test_expect_success 'delete' '
 	git commit -m tiger C &&
 
 	HEAD_entry_count=$(git reflog | wc -l) &&
-	master_entry_count=$(git reflog show master | wc -l) &&
+	main_entry_count=$(git reflog show main | wc -l) &&
 
 	test $HEAD_entry_count = 5 &&
-	test $master_entry_count = 5 &&
+	test $main_entry_count = 5 &&
 
 
-	git reflog delete master@{1} &&
-	git reflog show master > output &&
-	test_line_count = $(($master_entry_count - 1)) output &&
+	git reflog delete main@{1} &&
+	git reflog show main > output &&
+	test_line_count = $(($main_entry_count - 1)) output &&
 	test $HEAD_entry_count = $(git reflog | wc -l) &&
 	! grep ox < output &&
 
-	master_entry_count=$(wc -l < output) &&
+	main_entry_count=$(wc -l < output) &&
 
 	git reflog delete HEAD@{1} &&
 	test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
-	test $master_entry_count = $(git reflog show master | wc -l) &&
+	test $main_entry_count = $(git reflog show main | wc -l) &&
 
 	HEAD_entry_count=$(git reflog | wc -l) &&
 
-	git reflog delete master@{07.04.2005.15:15:00.-0700} &&
-	git reflog show master > output &&
-	test_line_count = $(($master_entry_count - 1)) output &&
+	git reflog delete main@{07.04.2005.15:15:00.-0700} &&
+	git reflog show main > output &&
+	test_line_count = $(($main_entry_count - 1)) output &&
 	! grep dragon < output
 
 '
@@ -216,7 +216,7 @@ test_expect_success 'delete' '
 test_expect_success 'rewind2' '
 
 	test_tick && git reset --hard HEAD~2 &&
-	git reflog refs/heads/master >output &&
+	git reflog refs/heads/main >output &&
 	test_line_count = 4 output
 '
 
@@ -226,7 +226,7 @@ test_expect_success '--expire=never' '
 		--expire=never \
 		--expire-unreachable=never \
 		--all &&
-	git reflog refs/heads/master >output &&
+	git reflog refs/heads/main >output &&
 	test_line_count = 4 output
 '
 
@@ -237,7 +237,7 @@ test_expect_success 'gc.reflogexpire=never' '
 	git reflog expire --verbose --all >output &&
 	test_line_count = 9 output &&
 
-	git reflog refs/heads/master >output &&
+	git reflog refs/heads/main >output &&
 	test_line_count = 4 output
 '
 
@@ -246,7 +246,7 @@ test_expect_success 'gc.reflogexpire=false' '
 	test_config gc.reflogexpireunreachable false &&
 
 	git reflog expire --verbose --all &&
-	git reflog refs/heads/master >output &&
+	git reflog refs/heads/main >output &&
 	test_line_count = 4 output
 
 '
@@ -255,33 +255,33 @@ test_expect_success 'git reflog expire unknown reference' '
 	test_config gc.reflogexpire never &&
 	test_config gc.reflogexpireunreachable never &&
 
-	test_must_fail git reflog expire master@{123} 2>stderr &&
+	test_must_fail git reflog expire main@{123} 2>stderr &&
 	test_i18ngrep "points nowhere" stderr &&
 	test_must_fail git reflog expire does-not-exist 2>stderr &&
 	test_i18ngrep "points nowhere" stderr
 '
 
 test_expect_success 'checkout should not delete log for packed ref' '
-	test $(git reflog master | wc -l) = 4 &&
+	test $(git reflog main | wc -l) = 4 &&
 	git branch foo &&
 	git pack-refs --all &&
 	git checkout foo &&
-	test $(git reflog master | wc -l) = 4
+	test $(git reflog main | wc -l) = 4
 '
 
 test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
 	test_when_finished "git branch -d one || git branch -d one/two" &&
 
-	git branch one/two master &&
-	echo "one/two@{0} branch: Created from master" >expect &&
+	git branch one/two main &&
+	echo "one/two@{0} branch: Created from main" >expect &&
 	git log -g --format="%gd %gs" one/two >actual &&
 	test_cmp expect actual &&
 	git branch -d one/two &&
 
 	# now logs/refs/heads/one is a stale directory, but
 	# we should move it out of the way to create "one" reflog
-	git branch one master &&
-	echo "one@{0} branch: Created from master" >expect &&
+	git branch one main &&
+	echo "one@{0} branch: Created from main" >expect &&
 	git log -g --format="%gd %gs" one >actual &&
 	test_cmp expect actual
 '
@@ -289,15 +289,15 @@ test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
 test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
 	test_when_finished "git branch -d one || git branch -d one/two" &&
 
-	git branch one/two master &&
-	echo "one/two@{0} branch: Created from master" >expect &&
+	git branch one/two main &&
+	echo "one/two@{0} branch: Created from main" >expect &&
 	git log -g --format="%gd %gs" one/two >actual &&
 	test_cmp expect actual &&
 	git branch -d one/two &&
 
 	# same as before, but we only create a reflog for "one" if
 	# it already exists, which it does not
-	git -c core.logallrefupdates=false branch one master &&
+	git -c core.logallrefupdates=false branch one main &&
 	git log -g --format="%gd %gs" one >actual &&
 	test_must_be_empty actual
 '
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 985daf1def..333b35aebc 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -167,7 +167,7 @@ test_expect_success 'git log -g -p shows diffs vs. parents' '
 '
 
 test_expect_success 'reflog exists works' '
-	git reflog exists refs/heads/master &&
+	git reflog exists refs/heads/main &&
 	! git reflog exists refs/heads/nonexistent
 '
 
diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
index c730600d8a..b1f7f35fe9 100755
--- a/t/t1413-reflog-detach.sh
+++ b/t/t1413-reflog-detach.sh
@@ -4,7 +4,7 @@ test_description='Test reflog interaction with detached HEAD'
 . ./test-lib.sh
 
 reset_state () {
-	git checkout master &&
+	git checkout main &&
 	cp saved_reflog .git/logs/HEAD
 }
 
@@ -19,14 +19,14 @@ test_expect_success setup '
 
 test_expect_success baseline '
 	reset_state &&
-	git rev-parse master master^ >expect &&
+	git rev-parse main main^ >expect &&
 	git log -g --format=%H >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'switch to branch' '
 	reset_state &&
-	git rev-parse side master master^ >expect &&
+	git rev-parse side main main^ >expect &&
 	git checkout side &&
 	git log -g --format=%H >actual &&
 	test_cmp expect actual
@@ -34,34 +34,34 @@ test_expect_success 'switch to branch' '
 
 test_expect_success 'detach to other' '
 	reset_state &&
-	git rev-parse master side master master^ >expect &&
+	git rev-parse main side main main^ >expect &&
 	git checkout side &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	git log -g --format=%H >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'detach to self' '
 	reset_state &&
-	git rev-parse master master master^ >expect &&
-	git checkout master^0 &&
+	git rev-parse main main main^ >expect &&
+	git checkout main^0 &&
 	git log -g --format=%H >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'attach to self' '
 	reset_state &&
-	git rev-parse master master master master^ >expect &&
-	git checkout master^0 &&
-	git checkout master &&
+	git rev-parse main main main main^ >expect &&
+	git checkout main^0 &&
+	git checkout main &&
 	git log -g --format=%H >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'attach to other' '
 	reset_state &&
-	git rev-parse side master master master^ >expect &&
-	git checkout master^0 &&
+	git rev-parse side main main main^ >expect &&
+	git checkout main^0 &&
 	git checkout side &&
 	git log -g --format=%H >actual &&
 	test_cmp expect actual
diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index 1181a9fb28..89458b7158 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -8,7 +8,7 @@ test_expect_success 'set up some reflog entries' '
 	test_commit two &&
 	git checkout -b side HEAD^ &&
 	test_commit three &&
-	git merge --no-commit master &&
+	git merge --no-commit main &&
 	echo evil-merge-content >>one.t &&
 	test_tick &&
 	git commit --no-edit -a
@@ -20,9 +20,9 @@ do_walk () {
 
 test_expect_success 'set up expected reflog' '
 	cat >expect.all <<-EOF
-	HEAD@{0} commit (merge): Merge branch ${SQ}master${SQ} into side
+	HEAD@{0} commit (merge): Merge branch ${SQ}main${SQ} into side
 	HEAD@{1} commit: three
-	HEAD@{2} checkout: moving from master to side
+	HEAD@{2} checkout: moving from main to side
 	HEAD@{3} commit: two
 	HEAD@{4} commit (initial): one
 	EOF
@@ -73,15 +73,15 @@ test_expect_success 'walking multiple reflogs shows all' '
 	#      sort ignores the bits after the timestamp.
 	#
 	#   2. POSIX leaves undefined whether this is a stable sort or not. So
-	#      we use "-k 1" to ensure that we see HEAD before master before
+	#      we use "-k 1" to ensure that we see HEAD before main before
 	#      side when breaking ties.
 	{
 		do_walk --date=unix HEAD &&
 		do_walk --date=unix side &&
-		do_walk --date=unix master
+		do_walk --date=unix main
 	} >expect.raw &&
 	sort -t "{" -k 2nr -k 1 <expect.raw >expect &&
-	do_walk --date=unix HEAD master side >actual &&
+	do_walk --date=unix HEAD main side >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index f6e741c6c0..4cabc07c86 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -53,11 +53,11 @@ test_expect_success 'hook gets all queued updates in prepared state' '
 	EOF
 	cat >expect <<-EOF &&
 		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/master
+		$ZERO_OID $POST_OID refs/heads/main
 	EOF
 	git update-ref HEAD POST <<-EOF &&
 		update HEAD $ZERO_OID $POST_OID
-		update refs/heads/master $ZERO_OID $POST_OID
+		update refs/heads/main $ZERO_OID $POST_OID
 	EOF
 	test_cmp expect actual
 '
@@ -76,7 +76,7 @@ test_expect_success 'hook gets all queued updates in committed state' '
 	EOF
 	cat >expect <<-EOF &&
 		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/master
+		$ZERO_OID $POST_OID refs/heads/main
 	EOF
 	git update-ref HEAD POST &&
 	test_cmp expect actual
@@ -96,12 +96,12 @@ test_expect_success 'hook gets all queued updates in aborted state' '
 	EOF
 	cat >expect <<-EOF &&
 		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/master
+		$ZERO_OID $POST_OID refs/heads/main
 	EOF
 	git update-ref --stdin <<-EOF &&
 		start
 		update HEAD POST $ZERO_OID
-		update refs/heads/master POST $ZERO_OID
+		update refs/heads/main POST $ZERO_OID
 		abort
 	EOF
 	test_cmp expect actual
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index c7878a60ed..fcc0194d7e 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -17,7 +17,7 @@ test_expect_success 'fast-import: fail on invalid branch name ".badbranchname"'
 		corrupt
 		COMMIT
 
-		from refs/heads/master
+		from refs/heads/main
 
 	INPUT_END
 	test_must_fail git fast-import <input
@@ -32,14 +32,14 @@ test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"'
 		corrupt
 		COMMIT
 
-		from refs/heads/master
+		from refs/heads/main
 
 	INPUT_END
 	test_must_fail git fast-import <input
 '
 
 test_expect_success 'git branch shows badly named ref as warning' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch >output 2>error &&
 	test_i18ngrep -e "ignoring ref with broken name refs/heads/broken\.\.\.ref" error &&
@@ -47,7 +47,7 @@ test_expect_success 'git branch shows badly named ref as warning' '
 '
 
 test_expect_success 'branch -d can delete badly named ref' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch -d broken...ref &&
 	git branch >output 2>error &&
@@ -56,7 +56,7 @@ test_expect_success 'branch -d can delete badly named ref' '
 '
 
 test_expect_success 'branch -D can delete badly named ref' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch -D broken...ref &&
 	git branch >output 2>error &&
@@ -98,17 +98,17 @@ test_expect_success 'branch -m cannot rename to a bad ref name' '
 	test_might_fail git branch -D goodref &&
 	git branch goodref &&
 	test_must_fail git branch -m goodref broken...ref &&
-	test_cmp_rev master goodref &&
+	test_cmp_rev main goodref &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '
 
 test_expect_failure 'branch -m can rename from a bad ref name' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch -m broken...ref renamed &&
-	test_cmp_rev master renamed &&
+	test_cmp_rev main renamed &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
@@ -135,7 +135,7 @@ test_expect_failure C_LOCALE_OUTPUT 'push --mirror can delete badly named ref' '
 		cd dest &&
 		test_commit two &&
 		git checkout --detach &&
-		cp .git/refs/heads/master .git/refs/heads/broken...ref
+		cp .git/refs/heads/main .git/refs/heads/broken...ref
 	) &&
 	git -C src push --mirror "file://$top/dest" &&
 	git -C dest branch >output 2>error &&
@@ -146,7 +146,7 @@ test_expect_failure C_LOCALE_OUTPUT 'push --mirror can delete badly named ref' '
 test_expect_success 'rev-parse skips symref pointing to broken name' '
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch shadow one &&
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
 	test_when_finished "rm -f .git/refs/tags/shadow" &&
 	git rev-parse --verify one >expect &&
@@ -156,11 +156,11 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 '
 
 test_expect_success 'for-each-ref emits warnings for broken names' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
-	printf "ref: refs/heads/master\n" >.git/refs/heads/broken...symref &&
+	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
 	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
 	git for-each-ref >output 2>error &&
 	! grep -e "broken\.\.\.ref" output &&
@@ -172,7 +172,7 @@ test_expect_success 'for-each-ref emits warnings for broken names' '
 '
 
 test_expect_success 'update-ref -d can delete broken name' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git update-ref -d refs/heads/broken...ref >output 2>error &&
 	test_must_be_empty output &&
@@ -183,7 +183,7 @@ test_expect_success 'update-ref -d can delete broken name' '
 '
 
 test_expect_success 'branch -d can delete broken name' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch -d broken...ref >output 2>error &&
 	test_i18ngrep "Deleted branch broken...ref (was broken)" output &&
@@ -194,7 +194,7 @@ test_expect_success 'branch -d can delete broken name' '
 '
 
 test_expect_success 'update-ref --no-deref -d can delete symref to broken name' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
@@ -205,7 +205,7 @@ test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
 '
 
 test_expect_success 'branch -d can delete symref to broken name' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
@@ -234,7 +234,7 @@ test_expect_success 'branch -d can delete dangling symref to broken name' '
 '
 
 test_expect_success 'update-ref -d can delete broken name through symref' '
-	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
@@ -245,7 +245,7 @@ test_expect_success 'update-ref -d can delete broken name through symref' '
 '
 
 test_expect_success 'update-ref --no-deref -d can delete symref with broken name' '
-	printf "ref: refs/heads/master\n" >.git/refs/heads/broken...symref &&
+	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
 	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
@@ -254,11 +254,11 @@ test_expect_success 'update-ref --no-deref -d can delete symref with broken name
 '
 
 test_expect_success 'branch -d can delete symref with broken name' '
-	printf "ref: refs/heads/master\n" >.git/refs/heads/broken...symref &&
+	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
 	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
 	git branch -d broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
-	test_i18ngrep "Deleted branch broken...symref (was refs/heads/master)" output &&
+	test_i18ngrep "Deleted branch broken...symref (was refs/heads/main)" output &&
 	test_must_be_empty error
 '
 
@@ -296,37 +296,37 @@ test_expect_success 'update-ref -d cannot delete absolute path' '
 '
 
 test_expect_success 'update-ref --stdin fails create with bad ref name' '
-	echo "create ~a refs/heads/master" >stdin &&
+	echo "create ~a refs/heads/main" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
 	grep "fatal: invalid ref format: ~a" err
 '
 
 test_expect_success 'update-ref --stdin fails update with bad ref name' '
-	echo "update ~a refs/heads/master" >stdin &&
+	echo "update ~a refs/heads/main" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
 	grep "fatal: invalid ref format: ~a" err
 '
 
 test_expect_success 'update-ref --stdin fails delete with bad ref name' '
-	echo "delete ~a refs/heads/master" >stdin &&
+	echo "delete ~a refs/heads/main" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
 	grep "fatal: invalid ref format: ~a" err
 '
 
 test_expect_success 'update-ref --stdin -z fails create with bad ref name' '
-	printf "%s\0" "create ~a " refs/heads/master >stdin &&
+	printf "%s\0" "create ~a " refs/heads/main >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
 	grep "fatal: invalid ref format: ~a " err
 '
 
 test_expect_success 'update-ref --stdin -z fails update with bad ref name' '
-	printf "%s\0" "update ~a" refs/heads/master "" >stdin &&
+	printf "%s\0" "update ~a" refs/heads/main "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
 	grep "fatal: invalid ref format: ~a" err
 '
 
 test_expect_success 'update-ref --stdin -z fails delete with bad ref name' '
-	printf "%s\0" "delete ~a" refs/heads/master >stdin &&
+	printf "%s\0" "delete ~a" refs/heads/main >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
 	grep "fatal: invalid ref format: ~a" err
 '
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index b17f5c21fb..a30fc5f74a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -3,7 +3,7 @@
 test_description='git fsck random collection of tests
 
 * (HEAD) B
-* (master) A
+* (main) A
 '
 
 . ./test-lib.sh
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 408b97d5af..a85692ffff 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -174,8 +174,8 @@ test_expect_success 'showing the superproject correctly' '
 	test_commit -C super/dir/sub branch1_commit &&
 	git -C super add dir/sub &&
 	test_commit -C super branch1_commit &&
-	git -C super checkout -b branch2 master &&
-	git -C super/dir/sub checkout -b branch2 master &&
+	git -C super checkout -b branch2 main &&
+	git -C super/dir/sub checkout -b branch2 main &&
 	test_commit -C super/dir/sub branch2_commit &&
 	git -C super add dir/sub &&
 	test_commit -C super branch2_commit &&
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index dc9fe3cbf1..de63186587 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -51,8 +51,8 @@ test_expect_success 'works with one good rev' '
 	test "$rev_hash3" = "$HASH3" &&
 	rev_hash4=$(git rev-parse --verify $HASH4) &&
 	test "$rev_hash4" = "$HASH4" &&
-	rev_master=$(git rev-parse --verify master) &&
-	test "$rev_master" = "$HASH4" &&
+	rev_main=$(git rev-parse --verify main) &&
+	test "$rev_main" = "$HASH4" &&
 	rev_head=$(git rev-parse --verify HEAD) &&
 	test "$rev_head" = "$HASH4"
 '
@@ -116,27 +116,27 @@ test_expect_success 'no stdout output on error' '
 '
 
 test_expect_success 'use --default' '
-	git rev-parse --verify --default master &&
-	git rev-parse --verify --default master HEAD &&
-	git rev-parse --default master --verify &&
-	git rev-parse --default master --verify HEAD &&
-	git rev-parse --verify HEAD --default master &&
-	test_must_fail git rev-parse --verify foo --default master &&
+	git rev-parse --verify --default main &&
+	git rev-parse --verify --default main HEAD &&
+	git rev-parse --default main --verify &&
+	git rev-parse --default main --verify HEAD &&
+	git rev-parse --verify HEAD --default main &&
+	test_must_fail git rev-parse --verify foo --default main &&
 	test_must_fail git rev-parse --default HEAD --verify bar &&
 	test_must_fail git rev-parse --verify --default HEAD baz &&
 	test_must_fail git rev-parse --default foo --verify &&
 	test_must_fail git rev-parse --verify --default bar
 '
 
-test_expect_success 'master@{n} for various n' '
+test_expect_success 'main@{n} for various n' '
 	N=$(git reflog | wc -l) &&
 	Nm1=$(($N-1)) &&
 	Np1=$(($N+1)) &&
-	git rev-parse --verify master@{0} &&
-	git rev-parse --verify master@{1} &&
-	git rev-parse --verify master@{$Nm1} &&
-	test_must_fail git rev-parse --verify master@{$N} &&
-	test_must_fail git rev-parse --verify master@{$Np1}
+	git rev-parse --verify main@{0} &&
+	git rev-parse --verify main@{1} &&
+	git rev-parse --verify main@{$Nm1} &&
+	test_must_fail git rev-parse --verify main@{$N} &&
+	test_must_fail git rev-parse --verify main@{$Np1}
 '
 
 test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
index 4969edb314..a64cd4ce14 100755
--- a/t/t1505-rev-parse-last.sh
+++ b/t/t1505-rev-parse-last.sh
@@ -20,12 +20,12 @@ test_expect_success 'setup' '
 	make_commit 3 &&
 	git checkout side &&
 	make_commit 4 &&
-	git merge master &&
-	git checkout master
+	git merge main &&
+	git checkout main
 
 '
 
-# 1 -- 2 -- 3 master
+# 1 -- 2 -- 3 main
 #  \         \
 #   \         \
 #    --- 4 --- 5 side
@@ -49,7 +49,7 @@ test_expect_success '@{-1}@{1} works' '
 '
 
 test_expect_success '@{-2} works' '
-	test_cmp_rev master @{-2}
+	test_cmp_rev main @{-2}
 '
 
 test_expect_success '@{-3} fails' '
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index e2ae15a2cf..8b183f1de1 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -137,10 +137,10 @@ test_expect_success 'incorrect file in :path and :N:path' '
 '
 
 test_expect_success 'invalid @{n} reference' '
-	test_must_fail git rev-parse master@{99999} >output 2>error &&
+	test_must_fail git rev-parse main@{99999} >output 2>error &&
 	test_must_be_empty output &&
 	test_i18ngrep "log for [^ ]* only has [0-9][0-9]* entries" error  &&
-	test_must_fail git rev-parse --verify master@{99999} >output 2>error &&
+	test_must_fail git rev-parse --verify main@{99999} >output 2>error &&
 	test_must_be_empty output &&
 	test_i18ngrep "log for [^ ]* only has [0-9][0-9]* entries" error
 '
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index dfc0d96d8a..d49998ceb6 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -10,20 +10,20 @@ test_expect_success 'setup' '
 	test_commit 1 &&
 	git checkout -b side &&
 	test_commit 2 &&
-	git checkout master &&
+	git checkout main &&
 	git clone . clone &&
 	test_commit 3 &&
 	(cd clone &&
 	 test_commit 4 &&
 	 git branch --track my-side origin/side &&
-	 git branch --track local-master master &&
+	 git branch --track local-main main &&
 	 git branch --track fun@ny origin/side &&
 	 git branch --track @funny origin/side &&
 	 git branch --track funny@ origin/side &&
-	 git remote add -t master master-only .. &&
-	 git fetch master-only &&
+	 git remote add -t main main-only .. &&
+	 git fetch main-only &&
 	 git branch bad-upstream &&
-	 git config branch.bad-upstream.remote master-only &&
+	 git config branch.bad-upstream.remote main-only &&
 	 git config branch.bad-upstream.merge refs/heads/side
 	)
 '
@@ -39,7 +39,7 @@ error_message () {
 }
 
 test_expect_success '@{upstream} resolves to correct full name' '
-	echo refs/remotes/origin/master >expect &&
+	echo refs/remotes/origin/main >expect &&
 	git -C clone rev-parse --symbolic-full-name @{upstream} >actual &&
 	test_cmp expect actual &&
 	git -C clone rev-parse --symbolic-full-name @{UPSTREAM} >actual &&
@@ -49,7 +49,7 @@ test_expect_success '@{upstream} resolves to correct full name' '
 '
 
 test_expect_success '@{u} resolves to correct full name' '
-	echo refs/remotes/origin/master >expect &&
+	echo refs/remotes/origin/main >expect &&
 	git -C clone rev-parse --symbolic-full-name @{u} >actual &&
 	test_cmp expect actual &&
 	git -C clone rev-parse --symbolic-full-name @{U} >actual &&
@@ -132,7 +132,7 @@ test_expect_success 'checkout -b new my-side@{u} forks from the same' '
 test_expect_success 'merge my-side@{u} records the correct name' '
 (
 	cd clone &&
-	git checkout master &&
+	git checkout main &&
 	test_might_fail git branch -D new &&
 	git branch -t new my-side@{u} &&
 	git merge -s ours new@{u} &&
@@ -143,24 +143,24 @@ test_expect_success 'merge my-side@{u} records the correct name' '
 '
 
 test_expect_success 'branch -d other@{u}' '
-	git checkout -t -b other master &&
+	git checkout -t -b other main &&
 	git branch -d @{u} &&
-	git for-each-ref refs/heads/master >actual &&
+	git for-each-ref refs/heads/main >actual &&
 	test_must_be_empty actual
 '
 
 test_expect_success 'checkout other@{u}' '
-	git branch -f master HEAD &&
-	git checkout -t -b another master &&
+	git branch -f main HEAD &&
+	git checkout -t -b another main &&
 	git checkout @{u} &&
 	git symbolic-ref HEAD >actual &&
-	echo refs/heads/master >expect &&
+	echo refs/heads/main >expect &&
 	test_cmp expect actual
 '
 
 test_expect_success 'branch@{u} works when tracking a local branch' '
-	echo refs/heads/master >expect &&
-	git -C clone rev-parse --symbolic-full-name local-master@{u} >actual &&
+	echo refs/heads/main >expect &&
+	git -C clone rev-parse --symbolic-full-name local-main@{u} >actual &&
 	test_cmp expect actual
 '
 
@@ -174,7 +174,7 @@ test_expect_success 'branch@{u} error message when no upstream' '
 
 test_expect_success '@{u} error message when no upstream' '
 	cat >expect <<-EOF &&
-	fatal: no upstream configured for branch ${SQ}master${SQ}
+	fatal: no upstream configured for branch ${SQ}main${SQ}
 	EOF
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
 	test_i18ncmp expect actual
@@ -208,14 +208,14 @@ test_expect_success 'branch@{u} error message if upstream branch not fetched' '
 test_expect_success 'pull works when tracking a local branch' '
 (
 	cd clone &&
-	git checkout local-master &&
+	git checkout local-main &&
 	git pull
 )
 '
 
 # makes sense if the previous one succeeded
 test_expect_success '@{u} works when tracking a local branch' '
-	echo refs/heads/master >expect &&
+	echo refs/heads/main >expect &&
 	git -C clone rev-parse --symbolic-full-name @{u} >actual &&
 	test_cmp expect actual
 '
@@ -224,7 +224,7 @@ test_expect_success 'log -g other@{u}' '
 	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
 	commit $commit
-	Reflog: master@{0} (C O Mitter <committer@example.com>)
+	Reflog: main@{0} (C O Mitter <committer@example.com>)
 	Reflog message: branch: Created from HEAD
 	Author: A U Thor <author@example.com>
 	Date:   Thu Apr 7 15:15:13 2005 -0700
@@ -239,7 +239,7 @@ test_expect_success 'log -g other@{u}@{now}' '
 	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
 	commit $commit
-	Reflog: master@{Thu Apr 7 15:17:13 2005 -0700} (C O Mitter <committer@example.com>)
+	Reflog: main@{Thu Apr 7 15:17:13 2005 -0700} (C O Mitter <committer@example.com>)
 	Reflog message: branch: Created from HEAD
 	Author: A U Thor <author@example.com>
 	Date:   Thu Apr 7 15:15:13 2005 -0700
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 4a9964e9dc..bda6e7900c 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -30,8 +30,8 @@ fail() {
 }
 
 test_expect_success 'setup' '
-	test_commit master-one &&
-	test_commit master-two &&
+	test_commit main-one &&
+	test_commit main-two &&
 	git checkout -b upstream-branch &&
 	test_commit upstream-one &&
 	test_commit upstream-two &&
@@ -47,7 +47,7 @@ test_expect_success 'setup' '
 	git checkout -b new-branch &&
 	test_commit new-one &&
 	test_commit new-two &&
-	git branch -u master old-branch &&
+	git branch -u main old-branch &&
 	git branch -u upstream-branch new-branch
 '
 
@@ -62,8 +62,8 @@ check "@{-1}@{1}" commit old-one
 check "@{u}" ref refs/heads/upstream-branch
 check "HEAD@{u}" ref refs/heads/upstream-branch
 check "@{u}@{1}" commit upstream-one
-check "@{-1}@{u}" ref refs/heads/master
-check "@{-1}@{u}@{1}" commit master-one
+check "@{-1}@{u}" ref refs/heads/main
+check "@{-1}@{u}@{1}" commit main-one
 check "@" commit new-two
 check "@@{u}" ref refs/heads/upstream-branch
 check "@@/at-test" ref refs/heads/@@/at-test
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index e0a49a651f..cc324bea52 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup' '
 	git commit -m Initial &&
 	git tag -a -m commit commit-tag &&
 	git branch ref &&
-	git checkout master &&
+	git checkout main &&
 	echo modified >>a-blob &&
 	git add -u &&
 	git commit -m Modified &&
@@ -73,52 +73,52 @@ test_expect_success 'ref^{tag}' '
 '
 
 test_expect_success 'ref^{/.}' '
-	git rev-parse master >expected &&
-	git rev-parse master^{/.} >actual &&
+	git rev-parse main >expected &&
+	git rev-parse main^{/.} >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'ref^{/non-existent}' '
-	test_must_fail git rev-parse master^{/non-existent}
+	test_must_fail git rev-parse main^{/non-existent}
 '
 
 test_expect_success 'ref^{/Initial}' '
 	git rev-parse ref >expected &&
-	git rev-parse master^{/Initial} >actual &&
+	git rev-parse main^{/Initial} >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'ref^{/!Exp}' '
-	test_must_fail git rev-parse master^{/!Exp}
+	test_must_fail git rev-parse main^{/!Exp}
 '
 
 test_expect_success 'ref^{/!}' '
-	test_must_fail git rev-parse master^{/!}
+	test_must_fail git rev-parse main^{/!}
 '
 
 test_expect_success 'ref^{/!!Exp}' '
 	git rev-parse expref >expected &&
-	git rev-parse master^{/!!Exp} >actual &&
+	git rev-parse main^{/!!Exp} >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'ref^{/!-}' '
-	test_must_fail git rev-parse master^{/!-}
+	test_must_fail git rev-parse main^{/!-}
 '
 
 test_expect_success 'ref^{/!-.}' '
-	test_must_fail git rev-parse master^{/!-.}
+	test_must_fail git rev-parse main^{/!-.}
 '
 
 test_expect_success 'ref^{/!-non-existent}' '
-	git rev-parse master >expected &&
-	git rev-parse master^{/!-non-existent} >actual &&
+	git rev-parse main >expected &&
+	git rev-parse main^{/!-non-existent} >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'ref^{/!-Changed}' '
 	git rev-parse expref >expected &&
-	git rev-parse master^{/!-Changed} >actual &&
+	git rev-parse main^{/!-Changed} >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 18fa6cf40d..6b4481d36b 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -212,7 +212,7 @@ test_expect_success 'more history' '
 	side=$(git rev-parse HEAD) &&
 
 	# commit 000000000066
-	git checkout master &&
+	git checkout main &&
 
 	# If you use recursive, merge will fail and you will need to
 	# clean up a0blgqsjc as well.  If you use resolve, merge will
diff --git a/t/t1513-rev-parse-prefix.sh b/t/t1513-rev-parse-prefix.sh
index 87ec3ae714..f77e59121c 100755
--- a/t/t1513-rev-parse-prefix.sh
+++ b/t/t1513-rev-parse-prefix.sh
@@ -76,9 +76,9 @@ test_expect_success 'disambiguate path with valid prefix' '
 '
 
 test_expect_success 'file and refs with prefix' '
-	git rev-parse --prefix sub1/ master file1 >actual &&
+	git rev-parse --prefix sub1/ main file1 >actual &&
 	cat <<-EOF >expected &&
-	$(git rev-parse master)
+	$(git rev-parse main)
 	sub1/file1
 	EOF
 	test_cmp expected actual
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index 788cc91e45..e85b222e99 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -16,24 +16,24 @@ test_expect_success 'setup' '
 	git remote add other other.git &&
 	test_commit base &&
 	git push origin HEAD &&
-	git branch --set-upstream-to=origin/master master &&
-	git branch --track topic origin/master &&
+	git branch --set-upstream-to=origin/main main &&
+	git branch --track topic origin/main &&
 	git push origin topic &&
 	git push other topic
 '
 
 test_expect_success '@{push} with default=nothing' '
 	test_config push.default nothing &&
-	test_must_fail git rev-parse master@{push} &&
-	test_must_fail git rev-parse master@{PUSH} &&
-	test_must_fail git rev-parse master@{PuSH}
+	test_must_fail git rev-parse main@{push} &&
+	test_must_fail git rev-parse main@{PUSH} &&
+	test_must_fail git rev-parse main@{PuSH}
 '
 
 test_expect_success '@{push} with default=simple' '
 	test_config push.default simple &&
-	resolve master@{push} refs/remotes/origin/master &&
-	resolve master@{PUSH} refs/remotes/origin/master &&
-	resolve master@{pUSh} refs/remotes/origin/master
+	resolve main@{push} refs/remotes/origin/main &&
+	resolve main@{PUSH} refs/remotes/origin/main &&
+	resolve main@{pUSh} refs/remotes/origin/main
 '
 
 test_expect_success 'triangular @{push} fails with default=simple' '
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 12a5568844..f3309045fe 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -496,7 +496,7 @@ test_expect_success 'do not refresh null base index' '
 		test_commit initial &&
 		git checkout -b side-branch &&
 		test_commit extra &&
-		git checkout master &&
+		git checkout main &&
 		git update-index --split-index &&
 		test_commit more &&
 		# must not write a new shareindex, or we wont catch the problem
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a863ccee7e..126004e342 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -256,6 +256,13 @@ case "$TRASH_DIRECTORY" in
  *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
 esac
 
+case "$TEST_NUMBER" in
+[01]*)
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+	;;
+esac
+
 # If --stress was passed, run this test repeatedly in several parallel loops.
 if test "$GIT_TEST_STRESS_STARTED" = "done"
 then
-- 
gitgitgadget

