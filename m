Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F2C04A94
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 17:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGURan (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGURad (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 13:30:33 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F62DE47
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:30:20 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-579dfae6855so25215547b3.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689960619; x=1690565419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=niuUIsm04JLR6fBqFxncqBz4P9c936DSNdqiM2l8xSU=;
        b=Lr55AaUju2pAXoVG6xA+C3Mla1EV9Ghm1XerZCmonLKubZRrZCuBU7hOduAORiTDjm
         VV5wdGTo+V52w79okIbg61tJEEICPGhNVI6fN0AA6BUjCiffGw67IQc9183vvETH/+pz
         w2WK0j53kzuqaR7Ceh3f1Yww6Ou0gDcQfMXTL+A/kYNd5E5i3v9vbhkGreKcwNK1474I
         uCeFNnsKiiKJpjS98FLKFsfee64GEaRw0z7peVUD4gb1NXI+76XsyjF72jAcw7nOABvF
         vKMVwl4Dau5bshKVEy6h13lbJXvSuRrAvIIxQFfF/HbNyjoNcALQz9mrG7uPm9VMCOJ0
         rvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960619; x=1690565419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niuUIsm04JLR6fBqFxncqBz4P9c936DSNdqiM2l8xSU=;
        b=TMgYZbFuiU+K76hNplEADZlZp2uKM0t3wlFCbw1tXcgSbvN1Y2tCXgsh3GZm6MK8RU
         Swgs+ce2vFnjCAYMPBnmdL3dxR1Ix4T8m4IGfkOtAJs75IS7whUM67evCgzDaxyo7sIP
         DSGKR2bFSLyMjBeiL5PgDRpFQzjdt9nz95EOUNOodScED4+KdhDUKWvvHPDB5mg46IM8
         l4NGOKGQy3R9SpSdYx2lwGZ8ndxtUqrBU9863Qoho/a6Pk927o5NHhqc/dc1oQMjrnBo
         aWtZJGrX7Gj8aJv1uiFWlvCniUiaL7642BWbSqBs8GPyDsIFqOTBXu+kwnnDwas83XQI
         0w5g==
X-Gm-Message-State: ABy/qLYtgEqTofNJ69687D8gm0W7ZMC7U9fcFrMQhwtkoS0fSfOCVOG4
        3M/3VbrHtyL0Kawv7H+ewB8w09/atD8JgH9uDcaGbA==
X-Google-Smtp-Source: APBJJlFS5vC7ycfIi7wmzonyXoucPhGl2gPmt3rcxB5rGy1FIOX3odRL6fHJIlqHtRsOG/OSODW7Kw==
X-Received: by 2002:a81:6d08:0:b0:56f:f40f:9414 with SMTP id i8-20020a816d08000000b0056ff40f9414mr690129ywc.38.1689960619240;
        Fri, 21 Jul 2023 10:30:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m11-20020a81710b000000b0055a373a7e5asm1023500ywc.131.2023.07.21.10.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:30:19 -0700 (PDT)
Date:   Fri, 21 Jul 2023 13:30:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] t5318: avoid top-level directory changes
Message-ID: <451ec003be8714bc38cc8cdc159add3e8899ce57.1689960606.git.me@ttaylorr.com>
References: <cover.1689960606.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689960606.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid changing the current working directory from outside of a sub-shell
during the tests in t5318.

Each test has mostly straightforward changes, either:

  - Removing the top-level `cd "$TRASH_DIRECTORY/full"`, which is
    unnecessary after ensuring that other tests don't change their
    working directory outside of a sub-shell.

  - Changing any Git invocations which want to be in a sub-directory by
    either (a) adding a "-C $DIR" argument, or (b) moving the whole test
    into a sub-shell.

While we're here, remove any explicit "git config core.commitGraph true"
invocations which were designed to enable use of the commit-graph. These
are unnecessary following 31b1de6a09b (commit-graph: turn on
commit-graph by default, 2019-08-13).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5318-commit-graph.sh | 378 ++++++++++++++++++----------------------
 1 file changed, 172 insertions(+), 206 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index bf8a92317b3..4df76173a8d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -24,12 +24,10 @@ test_expect_success 'usage shown with an error on unknown sub-command' '
 	test_cmp expect actual
 '
 
+objdir=".git/objects"
+
 test_expect_success 'setup full repo' '
-	mkdir full &&
-	cd "$TRASH_DIRECTORY/full" &&
-	git init &&
-	git config core.commitGraph true &&
-	objdir=".git/objects"
+	git init full
 '
 
 test_expect_success POSIXPERM 'tweak umask for modebit tests' '
@@ -37,31 +35,28 @@ test_expect_success POSIXPERM 'tweak umask for modebit tests' '
 '
 
 test_expect_success 'verify graph with no graph file' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph verify
+	git -C full commit-graph verify
 '
 
 test_expect_success 'write graph with no packs' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write --object-dir $objdir &&
-	test_path_is_missing $objdir/info/commit-graph
+	git -C full commit-graph write --object-dir $objdir &&
+	test_path_is_missing full/$objdir/info/commit-graph
 '
 
 test_expect_success 'exit with correct error on bad input to --stdin-packs' '
-	cd "$TRASH_DIRECTORY/full" &&
 	echo doesnotexist >in &&
-	test_expect_code 1 git commit-graph write --stdin-packs <in 2>stderr &&
+	test_expect_code 1 git -C full commit-graph write --stdin-packs \
+		<in 2>stderr &&
 	test_i18ngrep "error adding pack" stderr
 '
 
 test_expect_success 'create commits and repack' '
-	cd "$TRASH_DIRECTORY/full" &&
 	for i in $(test_seq 3)
 	do
-		test_commit $i &&
-		git branch commits/$i || return 1
+		test_commit -C full $i &&
+		git -C full branch commits/$i || return 1
 	done &&
-	git repack
+	git -C full repack
 '
 
 . "$TEST_DIRECTORY"/lib-commit-graph.sh
@@ -69,117 +64,106 @@ test_expect_success 'create commits and repack' '
 graph_git_behavior 'no graph' full commits/3 commits/1
 
 test_expect_success 'exit with correct error on bad input to --stdin-commits' '
-	cd "$TRASH_DIRECTORY/full" &&
 	# invalid, non-hex OID
-	echo HEAD >in &&
-	test_expect_code 1 git commit-graph write --stdin-commits <in 2>stderr &&
+	echo HEAD | test_expect_code 1 git -C full commit-graph write \
+		--stdin-commits 2>stderr &&
 	test_i18ngrep "unexpected non-hex object ID: HEAD" stderr &&
 	# non-existent OID
-	echo $ZERO_OID >in &&
-	test_expect_code 1 git commit-graph write --stdin-commits <in 2>stderr &&
+	echo $ZERO_OID | test_expect_code 1 git -C full commit-graph write \
+		--stdin-commits 2>stderr &&
 	test_i18ngrep "invalid object" stderr &&
 	# valid commit and tree OID
-	git rev-parse HEAD HEAD^{tree} >in &&
-	git commit-graph write --stdin-commits <in &&
-	graph_read_expect 3 generation_data
+	git -C full rev-parse HEAD HEAD^{tree} >in &&
+	git -C full commit-graph write --stdin-commits <in &&
+	graph_read_expect -C full 3 generation_data
 '
 
 test_expect_success 'write graph' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write &&
-	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "3" generation_data
+	git -C full commit-graph write &&
+	test_path_is_file full/$objdir/info/commit-graph &&
+	graph_read_expect -C full 3 generation_data
 '
 
 test_expect_success POSIXPERM 'write graph has correct permissions' '
-	test_path_is_file $objdir/info/commit-graph &&
+	test_path_is_file full/$objdir/info/commit-graph &&
 	echo "-r--r--r--" >expect &&
-	test_modebits $objdir/info/commit-graph >actual &&
+	test_modebits full/$objdir/info/commit-graph >actual &&
 	test_cmp expect actual
 '
 
 graph_git_behavior 'graph exists' full commits/3 commits/1
 
 test_expect_success 'Add more commits' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git reset --hard commits/1 &&
+	git -C full reset --hard commits/1 &&
 	for i in $(test_seq 4 5)
 	do
-		test_commit $i &&
-		git branch commits/$i || return 1
+		test_commit -C full $i &&
+		git -C full branch commits/$i || return 1
 	done &&
-	git reset --hard commits/2 &&
+	git -C full reset --hard commits/2 &&
 	for i in $(test_seq 6 7)
 	do
-		test_commit $i &&
-		git branch commits/$i || return 1
+		test_commit -C full $i &&
+		git -C full branch commits/$i || return 1
 	done &&
-	git reset --hard commits/2 &&
-	git merge commits/4 &&
-	git branch merge/1 &&
-	git reset --hard commits/4 &&
-	git merge commits/6 &&
-	git branch merge/2 &&
-	git reset --hard commits/3 &&
-	git merge commits/5 commits/7 &&
-	git branch merge/3 &&
-	git repack
+	git -C full reset --hard commits/2 &&
+	git -C full merge commits/4 &&
+	git -C full branch merge/1 &&
+	git -C full reset --hard commits/4 &&
+	git -C full merge commits/6 &&
+	git -C full branch merge/2 &&
+	git -C full reset --hard commits/3 &&
+	git -C full merge commits/5 commits/7 &&
+	git -C full branch merge/3 &&
+	git -C full repack
 '
 
 test_expect_success 'commit-graph write progress off for redirected stderr' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write 2>err &&
+	git -C full commit-graph write 2>err &&
 	test_must_be_empty err
 '
 
 test_expect_success 'commit-graph write force progress on for stderr' '
-	cd "$TRASH_DIRECTORY/full" &&
-	GIT_PROGRESS_DELAY=0 git commit-graph write --progress 2>err &&
+	GIT_PROGRESS_DELAY=0 git -C full commit-graph write --progress 2>err &&
 	test_file_not_empty err
 '
 
 test_expect_success 'commit-graph write with the --no-progress option' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write --no-progress 2>err &&
+	git -C full commit-graph write --no-progress 2>err &&
 	test_must_be_empty err
 '
 
 test_expect_success 'commit-graph write --stdin-commits progress off for redirected stderr' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git rev-parse commits/5 >in &&
-	git commit-graph write --stdin-commits <in 2>err &&
+	git -C full rev-parse commits/5 >in &&
+	git -C full commit-graph write --stdin-commits <in 2>err &&
 	test_must_be_empty err
 '
 
 test_expect_success 'commit-graph write --stdin-commits force progress on for stderr' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git rev-parse commits/5 >in &&
-	GIT_PROGRESS_DELAY=0 git commit-graph write --stdin-commits --progress <in 2>err &&
+	git -C full rev-parse commits/5 >in &&
+	GIT_PROGRESS_DELAY=0 git -C full commit-graph write --stdin-commits \
+		--progress <in 2>err &&
 	test_i18ngrep "Collecting commits from input" err
 '
 
 test_expect_success 'commit-graph write --stdin-commits with the --no-progress option' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git rev-parse commits/5 >in &&
-	git commit-graph write --stdin-commits --no-progress <in 2>err &&
+	git -C full rev-parse commits/5 >in &&
+	git -C full commit-graph write --stdin-commits --no-progress <in 2>err &&
 	test_must_be_empty err
 '
 
 test_expect_success 'commit-graph verify progress off for redirected stderr' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph verify 2>err &&
+	git -C full commit-graph verify 2>err &&
 	test_must_be_empty err
 '
 
 test_expect_success 'commit-graph verify force progress on for stderr' '
-	cd "$TRASH_DIRECTORY/full" &&
-	GIT_PROGRESS_DELAY=0 git commit-graph verify --progress 2>err &&
+	GIT_PROGRESS_DELAY=0 git -C full commit-graph verify --progress 2>err &&
 	test_file_not_empty err
 '
 
 test_expect_success 'commit-graph verify with the --no-progress option' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph verify --no-progress 2>err &&
+	git -C full commit-graph verify --no-progress 2>err &&
 	test_must_be_empty err
 '
 
@@ -194,10 +178,9 @@ test_expect_success 'commit-graph verify with the --no-progress option' '
 # 1
 
 test_expect_success 'write graph with merges' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write &&
-	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "10" "generation_data extra_edges"
+	git -C full commit-graph write &&
+	test_path_is_file full/$objdir/info/commit-graph &&
+	graph_read_expect -C full 10 "generation_data extra_edges"
 '
 
 graph_git_behavior 'merge 1 vs 2' full merge/1 merge/2
@@ -205,12 +188,11 @@ graph_git_behavior 'merge 1 vs 3' full merge/1 merge/3
 graph_git_behavior 'merge 2 vs 3' full merge/2 merge/3
 
 test_expect_success 'Add one more commit' '
-	cd "$TRASH_DIRECTORY/full" &&
-	test_commit 8 &&
-	git branch commits/8 &&
-	ls $objdir/pack | grep idx >existing-idx &&
-	git repack &&
-	ls $objdir/pack| grep idx | grep -v -f existing-idx >new-idx
+	test_commit -C full 8 &&
+	git -C full branch commits/8 &&
+	ls full/$objdir/pack | grep idx >existing-idx &&
+	git -C full repack &&
+	ls full/$objdir/pack| grep idx | grep -v -f existing-idx >new-idx
 '
 
 # Current graph structure:
@@ -229,114 +211,101 @@ graph_git_behavior 'mixed mode, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'mixed mode, commit 8 vs merge 2' full commits/8 merge/2
 
 test_expect_success 'write graph with new commit' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write &&
-	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "11" "generation_data extra_edges"
+	git -C full commit-graph write &&
+	test_path_is_file full/$objdir/info/commit-graph &&
+	graph_read_expect -C full 11 "generation_data extra_edges"
 '
 
 graph_git_behavior 'full graph, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'full graph, commit 8 vs merge 2' full commits/8 merge/2
 
 test_expect_success 'write graph with nothing new' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write &&
-	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "11" "generation_data extra_edges"
+	git -C full commit-graph write &&
+	test_path_is_file full/$objdir/info/commit-graph &&
+	graph_read_expect -C full 11 "generation_data extra_edges"
 '
 
 graph_git_behavior 'cleared graph, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'cleared graph, commit 8 vs merge 2' full commits/8 merge/2
 
 test_expect_success 'build graph from latest pack with closure' '
-	cd "$TRASH_DIRECTORY/full" &&
-	cat new-idx | git commit-graph write --stdin-packs &&
-	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "9" "generation_data extra_edges"
+	git -C full commit-graph write --stdin-packs <new-idx &&
+	test_path_is_file full/$objdir/info/commit-graph &&
+	graph_read_expect -C full 9 "generation_data extra_edges"
 '
 
 graph_git_behavior 'graph from pack, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'graph from pack, commit 8 vs merge 2' full commits/8 merge/2
 
 test_expect_success 'build graph from commits with closure' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git tag -a -m "merge" tag/merge merge/2 &&
-	git rev-parse tag/merge >commits-in &&
-	git rev-parse merge/1 >>commits-in &&
-	cat commits-in | git commit-graph write --stdin-commits &&
-	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "6" "generation_data"
+	git -C full tag -a -m "merge" tag/merge merge/2 &&
+	git -C full rev-parse tag/merge >commits-in &&
+	git -C full rev-parse merge/1 >>commits-in &&
+	git -C full commit-graph write --stdin-commits <commits-in &&
+	test_path_is_file full/$objdir/info/commit-graph &&
+	graph_read_expect -C full 6 "generation_data"
 '
 
 graph_git_behavior 'graph from commits, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'graph from commits, commit 8 vs merge 2' full commits/8 merge/2
 
 test_expect_success 'build graph from commits with append' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git rev-parse merge/3 | git commit-graph write --stdin-commits --append &&
-	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "10" "generation_data extra_edges"
+	git -C full rev-parse merge/3 >in &&
+	git -C full commit-graph write --stdin-commits --append <in &&
+	test_path_is_file full/$objdir/info/commit-graph &&
+	graph_read_expect -C full 10 "generation_data extra_edges"
 '
 
 graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
 
 test_expect_success 'build graph using --reachable' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write --reachable &&
-	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "11" "generation_data extra_edges"
+	git -C full commit-graph write --reachable &&
+	test_path_is_file full/$objdir/info/commit-graph &&
+	graph_read_expect -C full 11 "generation_data extra_edges"
 '
 
 graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
 
 test_expect_success 'setup bare repo' '
-	cd "$TRASH_DIRECTORY" &&
-	git clone --bare --no-local full bare &&
-	cd bare &&
-	git config core.commitGraph true &&
-	baredir="./objects"
+	git clone --bare --no-local full bare
 '
 
 graph_git_behavior 'bare repo, commit 8 vs merge 1' bare commits/8 merge/1
 graph_git_behavior 'bare repo, commit 8 vs merge 2' bare commits/8 merge/2
 
 test_expect_success 'write graph in bare repo' '
-	cd "$TRASH_DIRECTORY/bare" &&
-	git commit-graph write &&
-	test_path_is_file $baredir/info/commit-graph &&
-	graph_read_expect "11" "generation_data extra_edges"
+	git -C bare commit-graph write &&
+	test_path_is_file bare/objects/info/commit-graph &&
+	graph_read_expect -C bare 11 "generation_data extra_edges"
 '
 
 graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
 graph_git_behavior 'bare repo with graph, commit 8 vs merge 2' bare commits/8 merge/2
 
 test_expect_success 'perform fast-forward merge in full repo' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git checkout -b merge-5-to-8 commits/5 &&
-	git merge commits/8 &&
-	git show-ref -s merge-5-to-8 >output &&
-	git show-ref -s commits/8 >expect &&
+	git -C full checkout -b merge-5-to-8 commits/5 &&
+	git -C full merge commits/8 &&
+	git -C full show-ref -s merge-5-to-8 >output &&
+	git -C full show-ref -s commits/8 >expect &&
 	test_cmp expect output
 '
 
 test_expect_success 'check that gc computes commit-graph' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit --allow-empty -m "blank" &&
-	git commit-graph write --reachable &&
-	cp $objdir/info/commit-graph commit-graph-before-gc &&
-	git reset --hard HEAD~1 &&
-	git config gc.writeCommitGraph true &&
-	git gc &&
-	cp $objdir/info/commit-graph commit-graph-after-gc &&
+	test_commit -C full --no-tag blank &&
+	git -C full commit-graph write --reachable &&
+	cp full/$objdir/info/commit-graph commit-graph-before-gc &&
+	git -C full reset --hard HEAD~1 &&
+	test_config -C full gc.writeCommitGraph true &&
+	git -C full gc &&
+	cp full/$objdir/info/commit-graph commit-graph-after-gc &&
 	! test_cmp_bin commit-graph-before-gc commit-graph-after-gc &&
-	git commit-graph write --reachable &&
-	test_cmp_bin commit-graph-after-gc $objdir/info/commit-graph
+	git -C full commit-graph write --reachable &&
+	test_cmp_bin commit-graph-after-gc full/$objdir/info/commit-graph
 '
 
 test_expect_success 'replace-objects invalidates commit-graph' '
-	cd "$TRASH_DIRECTORY" &&
 	test_when_finished rm -rf replace &&
 	git clone full replace &&
 	(
@@ -359,7 +328,6 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 '
 
 test_expect_success 'commit grafts invalidate commit-graph' '
-	cd "$TRASH_DIRECTORY" &&
 	test_when_finished rm -rf graft &&
 	git clone --template= full graft &&
 	(
@@ -384,7 +352,6 @@ test_expect_success 'commit grafts invalidate commit-graph' '
 '
 
 test_expect_success 'replace-objects invalidates commit-graph' '
-	cd "$TRASH_DIRECTORY" &&
 	test_when_finished rm -rf shallow &&
 	git clone --depth 2 "file://$TRASH_DIRECTORY/full" shallow &&
 	(
@@ -427,24 +394,25 @@ test_expect_success 'warn on improper hash version' '
 '
 
 test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'lower layers have overflow chunk' '
-	cd "$TRASH_DIRECTORY/full" &&
 	UNIX_EPOCH_ZERO="@0 +0000" &&
 	FUTURE_DATE="@4147483646 +0000" &&
-	rm -f .git/objects/info/commit-graph &&
-	test_commit --date "$FUTURE_DATE" future-1 &&
-	test_commit --date "$UNIX_EPOCH_ZERO" old-1 &&
-	git commit-graph write --reachable &&
-	test_commit --date "$FUTURE_DATE" future-2 &&
-	test_commit --date "$UNIX_EPOCH_ZERO" old-2 &&
-	git commit-graph write --reachable --split=no-merge &&
-	test_commit extra &&
-	git commit-graph write --reachable --split=no-merge &&
-	git commit-graph write --reachable &&
-	graph_read_expect 16 "generation_data generation_data_overflow extra_edges" &&
-	mv .git/objects/info/commit-graph commit-graph-upgraded &&
-	git commit-graph write --reachable &&
-	graph_read_expect 16 "generation_data generation_data_overflow extra_edges" &&
-	test_cmp .git/objects/info/commit-graph commit-graph-upgraded
+	rm -f full/.git/objects/info/commit-graph &&
+	test_commit -C full --date "$FUTURE_DATE" future-1 &&
+	test_commit -C full --date "$UNIX_EPOCH_ZERO" old-1 &&
+	git -C full commit-graph write --reachable &&
+	test_commit -C full --date "$FUTURE_DATE" future-2 &&
+	test_commit -C full --date "$UNIX_EPOCH_ZERO" old-2 &&
+	git -C full commit-graph write --reachable --split=no-merge &&
+	test_commit -C full extra &&
+	git -C full commit-graph write --reachable --split=no-merge &&
+	git -C full commit-graph write --reachable &&
+	graph_read_expect -C full 16 \
+		"generation_data generation_data_overflow extra_edges" &&
+	mv full/.git/objects/info/commit-graph commit-graph-upgraded &&
+	git -C full commit-graph write --reachable &&
+	graph_read_expect -C full 16 \
+		"generation_data generation_data_overflow extra_edges" &&
+	test_cmp full/.git/objects/info/commit-graph commit-graph-upgraded
 '
 
 # the verify tests below expect the commit-graph to contain
@@ -454,10 +422,11 @@ test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'lower layers have overflow ch
 # and the tests will likely break.
 
 test_expect_success 'git commit-graph verify' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git rev-parse commits/8 | git -c commitGraph.generationVersion=1 commit-graph write --stdin-commits &&
-	git commit-graph verify >output &&
-	graph_read_expect 9 extra_edges 1
+	git -C full rev-parse commits/8 >in &&
+	git -C full -c commitGraph.generationVersion=1 commit-graph write \
+		--stdin-commits <in &&
+	git -C full commit-graph verify >output &&
+	graph_read_expect -C full 9 extra_edges 1
 '
 
 NUM_COMMITS=9
@@ -495,25 +464,24 @@ GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
 GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
 
 corrupt_graph_setup() {
-	cd "$TRASH_DIRECTORY/full" &&
-	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
-	cp $objdir/info/commit-graph commit-graph-backup &&
-	chmod u+w $objdir/info/commit-graph
+	test_when_finished mv commit-graph-backup full/$objdir/info/commit-graph &&
+	cp full/$objdir/info/commit-graph commit-graph-backup &&
+	chmod u+w full/$objdir/info/commit-graph
 }
 
 corrupt_graph_verify() {
 	grepstr=$1
-	test_must_fail git commit-graph verify 2>test_err &&
+	test_must_fail git -C full commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
 	test_i18ngrep "$grepstr" err &&
 	if test "$2" != "no-copy"
 	then
-		cp $objdir/info/commit-graph commit-graph-pre-write-test
+		cp full/$objdir/info/commit-graph commit-graph-pre-write-test
 	fi &&
-	git status --short &&
-	GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE=true git commit-graph write &&
-	chmod u+w $objdir/info/commit-graph &&
-	git commit-graph verify
+	git -C full status --short &&
+	GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE=true git -C full commit-graph write &&
+	chmod u+w full/$objdir/info/commit-graph &&
+	git -C full commit-graph verify
 }
 
 # usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
@@ -527,24 +495,24 @@ corrupt_graph_and_verify() {
 	data="${2:-\0}"
 	grepstr=$3
 	corrupt_graph_setup &&
-	orig_size=$(wc -c < $objdir/info/commit-graph) &&
+	orig_size=$(wc -c <full/$objdir/info/commit-graph) &&
 	zero_pos=${4:-${orig_size}} &&
-	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
-	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null &&
-	test-tool genzeros $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
+	printf "$data" | dd of="full/$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
+	dd of="full/$objdir/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null &&
+	test-tool genzeros $(($orig_size - $zero_pos)) >>"full/$objdir/info/commit-graph" &&
 	corrupt_graph_verify "$grepstr"
 
 }
 
 test_expect_success POSIXPERM,SANITY 'detect permission problem' '
 	corrupt_graph_setup &&
-	chmod 000 $objdir/info/commit-graph &&
+	chmod 000 full/$objdir/info/commit-graph &&
 	corrupt_graph_verify "Could not open" "no-copy"
 '
 
 test_expect_success 'detect too small' '
 	corrupt_graph_setup &&
-	echo "a small graph" >$objdir/info/commit-graph &&
+	echo "a small graph" >full/$objdir/info/commit-graph &&
 	corrupt_graph_verify "too small"
 '
 
@@ -655,33 +623,30 @@ test_expect_success 'detect incorrect chunk count' '
 '
 
 test_expect_success 'git fsck (checks commit-graph when config set to true)' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git fsck &&
+	git -C full fsck &&
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
 		"incorrect checksum" &&
-	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
-	test_must_fail git -c core.commitGraph=true fsck
+	cp commit-graph-pre-write-test full/$objdir/info/commit-graph &&
+	test_must_fail git -C full -c core.commitGraph=true fsck
 '
 
 test_expect_success 'git fsck (ignores commit-graph when config set to false)' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git fsck &&
+	git -C full fsck &&
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
 		"incorrect checksum" &&
-	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
-	git -c core.commitGraph=false fsck
+	cp commit-graph-pre-write-test full/$objdir/info/commit-graph &&
+	git -C full -c core.commitGraph=false fsck
 '
 
 test_expect_success 'git fsck (checks commit-graph when config unset)' '
-	cd "$TRASH_DIRECTORY/full" &&
-	test_when_finished "git config core.commitGraph true" &&
+	test_when_finished "git -C full config core.commitGraph true" &&
 
-	git fsck &&
+	git -C full fsck &&
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
 		"incorrect checksum" &&
-	test_unconfig core.commitGraph &&
-	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
-	test_must_fail git fsck
+	test_unconfig -C full core.commitGraph &&
+	cp commit-graph-pre-write-test full/$objdir/info/commit-graph &&
+	test_must_fail git -C full fsck
 '
 
 test_expect_success 'git fsck shows commit-graph output with --progress' '
@@ -792,32 +757,33 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 #
 
 test_expect_success 'set up and verify repo with generation data overflow chunk' '
-	objdir=".git/objects" &&
 	UNIX_EPOCH_ZERO="@0 +0000" &&
 	FUTURE_DATE="@2147483646 +0000" &&
-	cd "$TRASH_DIRECTORY" &&
-	mkdir repo &&
-	cd repo &&
-	git init &&
-	test_commit --date "$UNIX_EPOCH_ZERO" 1 &&
-	test_commit 2 &&
-	test_commit --date "$UNIX_EPOCH_ZERO" 3 &&
-	git commit-graph write --reachable &&
-	graph_read_expect 3 generation_data &&
-	test_commit --date "$FUTURE_DATE" 4 &&
-	test_commit 5 &&
-	test_commit --date "$UNIX_EPOCH_ZERO" 6 &&
-	git branch left &&
-	git reset --hard 3 &&
-	test_commit 7 &&
-	test_commit --date "$FUTURE_DATE" 8 &&
-	test_commit 9 &&
-	git branch right &&
-	git reset --hard 3 &&
-	test_merge M left right &&
-	git commit-graph write --reachable &&
-	graph_read_expect 10 "generation_data generation_data_overflow" &&
-	git commit-graph verify
+
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit --date "$UNIX_EPOCH_ZERO" 1 &&
+		test_commit 2 &&
+		test_commit --date "$UNIX_EPOCH_ZERO" 3 &&
+		git commit-graph write --reachable &&
+		graph_read_expect 3 generation_data &&
+		test_commit --date "$FUTURE_DATE" 4 &&
+		test_commit 5 &&
+		test_commit --date "$UNIX_EPOCH_ZERO" 6 &&
+		git branch left &&
+		git reset --hard 3 &&
+		test_commit 7 &&
+		test_commit --date "$FUTURE_DATE" 8 &&
+		test_commit 9 &&
+		git branch right &&
+		git reset --hard 3 &&
+		test_merge M left right &&
+		git commit-graph write --reachable &&
+		graph_read_expect 10 "generation_data generation_data_overflow" &&
+		git commit-graph verify
+	)
 '
 
 graph_git_behavior 'generation data overflow chunk repo' repo left right
-- 
2.41.0.381.gd8424d64777

