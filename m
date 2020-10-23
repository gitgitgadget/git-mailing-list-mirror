Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CEFC55179
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3298520FC3
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmaPvhc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750258AbgJWOAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750250AbgJWOAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:00:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132BCC0613D2
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n18so1965997wrs.5
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9YAUbemPjdqgb13YBIt9R7T10dy3CBjCCxSBTtLskDA=;
        b=JmaPvhc15hAGTG0JL0azV3iYdB5tM8U4uU4pmM3OEPaUqMaJO39a1BUF5VuB35SlYY
         +RI0C1zriiW18rqf8hYzl/kw6GZYaM/52UfiU55cV9dtTZZpuczUmj55ADknlfJOe3LS
         0ln+57HIwa07nU4kx3vYQfA9R32iXaylJ/t5/wWuW1fsXw5kLEl07DIxHlXeBGttBzD2
         hlmVZTAAffNBvKz05vDmU5F8WeQE8RnLs7u0xlNoALJoiHUi0V4pFrQpwcxcS81cOsXu
         mUDkKflK7mB1HcsxH42kASu9temArrv1Ge1A8rfZb0QBp16kZfSCLCdclnEUCkZzv85T
         43fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9YAUbemPjdqgb13YBIt9R7T10dy3CBjCCxSBTtLskDA=;
        b=cZ5oz2v7/bWXskSWOBXD8Fbgqrcx52GflXex89L3MFprXeS72vD9k0ixsIKmasIuzQ
         JKJjQog2pPVPbIJtxjqs1mFkokvUo7expXUfV+JoYrNTtou0jBhK7o2uNuYGhF/oTSsm
         Fl3x+7Bn/UfcOEpulk21JmI6p9HBVwLgcwKyebuHdvu3sBm96l7Y5DNoj+nnAkVGgstc
         F6FalU14G9a9/F/9iYnQuKDriQyk74YfZ285PbQX4lNRz0qzLwDqVPq5cqN/H0b8o+y8
         Tk3Xxr2PSBc4Q6ZBP97aoTOQ8V+RFnmn3YEBnXReJgm2VyTEBLGNtmicmCFLKnXsLma6
         oSLQ==
X-Gm-Message-State: AOAM531hCWuf+6r7obuNmYNeEyad8T5q9uBG/EYwlpLgyuw4Wvurgadp
        a1ylsajTE8T+makAIPjCkZ5K/pUaaBg=
X-Google-Smtp-Source: ABdhPJyEqJEue89d13g5Oq3uqFdqM+GvByqoJK2TYJ3F718hVns+/gfQ4HXuZNu/QK5D7zHSGWGn8w==
X-Received: by 2002:a05:6000:108:: with SMTP id o8mr2732763wrx.256.1603461615236;
        Fri, 23 Oct 2020 07:00:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm3599729wme.22.2020.10.23.07.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 07:00:14 -0700 (PDT)
Message-Id: <d15e39bb7355064bf0305f82e1892dc42298059e.1603461606.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 14:00:05 +0000
Subject: [PATCH v2 8/9] tests: prepare aligned mentions of the default branch
 name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In some tests, the default branch name is part of aligned output. As we
want to change the default branch name to `main`, which is two
characters shorter than the old default branch name, we will have to
adjust those tests.

Since we use the original default branch name until the entire test
suite has been adjusted accordingly, the touched test cases need to be
guarded by a prereq (that is so far disabled so that they are skipped
for now).

The test cases that depend on those test cases that are newly guarded by
that prereq naturally have to be guarded, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3200-branch.sh              | 12 +++---
 t/t3201-branch-contains.sh     |  8 ++--
 t/t3203-branch-output.sh       |  4 +-
 t/t3205-branch-color.sh        |  8 ++--
 t/t5505-remote.sh              | 30 +++++++--------
 t/t5510-fetch.sh               |  8 ++--
 t/t5526-fetch-submodules.sh    | 70 +++++++++++++++++-----------------
 t/t6302-for-each-ref-filter.sh | 24 ++++++------
 8 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 55b24b76ce..a0b832d59e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -321,11 +321,11 @@ test_expect_success 'git branch --list -v with --abbrev' '
 
 '
 
-test_expect_success 'git branch --column' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expect <<\EOF &&
-  a/b/c    bam      foo      l      * master   n        o/p      r
-  abc      bar      j/k      m/m      mb       o/o      q        topic
+  a/b/c   bam     foo     l     * main    n       o/p     r
+  abc     bar     j/k     m/m     mb      o/o     q       topic
 EOF
 	test_cmp expect actual
 '
@@ -358,15 +358,15 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'git branch with column.*' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch with column.*' '
 	git config column.ui column &&
 	git config column.branch "dense" &&
 	COLUMNS=80 git branch >actual &&
 	git config --unset column.branch &&
 	git config --unset column.ui &&
 	cat >expect <<\EOF &&
-  a/b/c   bam   foo   l   * master   n     o/p   r
-  abc     bar   j/k   m/m   mb       o/o   q     topic
+  a/b/c   bam   foo   l   * main   n     o/p   r
+  abc     bar   j/k   m/m   mb     o/o   q     topic
 EOF
 	test_cmp expect actual
 '
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index efea5c4971..3733cd0091 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -242,7 +242,7 @@ test_expect_success 'branch --merged combined with --no-merged' '
 # Here "topic" tracks "master" with one extra commit, and "zzz" points to the
 # same tip as master The name "zzz" must come alphabetically after "topic"
 # as we process them in that order.
-test_expect_success 'branch --merged with --verbose' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'branch --merged with --verbose' '
 	git branch --track topic master &&
 	git branch zzz topic &&
 	git checkout topic &&
@@ -256,9 +256,9 @@ test_expect_success 'branch --merged with --verbose' '
 	test_cmp expect actual &&
 	git branch --verbose --merged topic >actual &&
 	cat >expect <<-EOF &&
-	  master $(git rev-parse --short master) second on master
-	* topic  $(git rev-parse --short topic ) [ahead 1] foo
-	  zzz    $(git rev-parse --short zzz   ) second on master
+	  main  $(git rev-parse --short main) second on main
+	* topic $(git rev-parse --short topic ) [ahead 1] foo
+	  zzz   $(git rev-parse --short zzz   ) second on main
 	EOF
 	test_i18ncmp expect actual
 '
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 71818b90f0..d65586541d 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -329,7 +329,7 @@ test_expect_success '--color overrides auto-color' '
 	test_cmp expect.color actual
 '
 
-test_expect_success 'verbose output lists worktree path' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'verbose output lists worktree path' '
 	one=$(git rev-parse --short HEAD) &&
 	two=$(git rev-parse --short master) &&
 	cat >expect <<-EOF &&
@@ -337,7 +337,7 @@ test_expect_success 'verbose output lists worktree path' '
 	  ambiguous                    $one one
 	  branch-one                   $two two
 	+ branch-two                   $one ($(pwd)/worktree_dir) one
-	  master                       $two two
+	  main                         $two two
 	  ref-to-branch                $two two
 	  ref-to-remote                $two two
 	EOF
diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index 4f1e16bb44..289625c464 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -28,12 +28,12 @@ test_expect_success 'regular output shows colors' '
 	test_cmp expect actual
 '
 
-test_expect_success 'verbose output shows colors' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'verbose output shows colors' '
 	oid=$(git rev-parse --short HEAD) &&
 	cat >expect <<-EOF &&
-	* <CYAN>master               <RESET> $oid foo
-	  <BLUE>other                <RESET> $oid foo
-	  <YELLOW>remotes/origin/master<RESET> $oid foo
+	* <CYAN>main               <RESET> $oid foo
+	  <BLUE>other              <RESET> $oid foo
+	  <YELLOW>remotes/origin/main<RESET> $oid foo
 	EOF
 	git branch --color -v -a >actual.raw &&
 	test_decode_color <actual.raw >actual &&
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8d62edd98b..de0e3df14a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -200,28 +200,28 @@ cat >test/expect <<EOF
   Push  URL: $(pwd)/one
   HEAD branch: master
   Remote branches:
-    master new (next fetch will store in remotes/origin)
-    side   tracked
+    main new (next fetch will store in remotes/origin)
+    side tracked
   Local branches configured for 'git pull':
-    ahead    merges with remote master
-    master   merges with remote master
+    ahead    merges with remote main
+    main     merges with remote main
     octopus  merges with remote topic-a
                 and with remote topic-b
                 and with remote topic-c
     rebase  rebases onto remote master
   Local refs configured for 'git push':
-    master pushes to master   (local out of date)
-    master pushes to upstream (create)
+    main pushes to main     (local out of date)
+    main pushes to upstream (create)
 * remote two
   Fetch URL: ../two
   Push  URL: ../three
   HEAD branch: master
   Local refs configured for 'git push':
-    ahead  forces to master  (fast-forwardable)
-    master pushes to another (up to date)
+    ahead forces to main    (fast-forwardable)
+    main  pushes to another (up to date)
 EOF
 
-test_expect_success 'show' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'show' '
 	(
 		cd test &&
 		git config --add remote.origin.fetch refs/heads/master:refs/heads/upstream &&
@@ -264,15 +264,15 @@ cat >test/expect <<EOF
     master
     side
   Local branches configured for 'git pull':
-    ahead  merges with remote master
-    master merges with remote master
+    ahead merges with remote main
+    main  merges with remote main
   Local refs configured for 'git push' (status not queried):
     (matching)           pushes to (matching)
-    refs/heads/master    pushes to refs/heads/upstream
+    refs/heads/main      pushes to refs/heads/upstream
     refs/tags/lastbackup forces to refs/tags/lastbackup
 EOF
 
-test_expect_success 'show -n' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'show -n' '
 	mv one one.unreachable &&
 	(
 		cd test &&
@@ -315,7 +315,7 @@ test_expect_success 'set-head --auto' '
 	)
 '
 
-test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'set-head --auto has no problem w/multiple HEADs' '
 	(
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
@@ -1335,7 +1335,7 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 	)
 '
 
-test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
 	(
 		cd two &&
 		git tag -a -m "Some tag" my-tag master &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index dbc724e4c0..5d673358f9 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -942,7 +942,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	)
 '
 
-test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch aligned output' '
 	git clone . full-output &&
 	test_commit looooooooooooong-tag &&
 	(
@@ -951,13 +951,13 @@ test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
 		grep -e "->" actual | cut -c 22- >../actual
 	) &&
 	cat >expect <<-\EOF &&
-	master               -> origin/master
+	main                 -> origin/main
 	looooooooooooong-tag -> looooooooooooong-tag
 	EOF
 	test_cmp expect actual
 '
 
-test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch compact output' '
 	git clone . compact &&
 	test_commit extraaa &&
 	(
@@ -966,7 +966,7 @@ test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
 		grep -e "->" actual | cut -c 22- >../actual
 	) &&
 	cat >expect <<-\EOF &&
-	master     -> origin/*
+	main       -> origin/*
 	extraaa    -> *
 	EOF
 	test_cmp expect actual
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 63205dfdf9..dd8e423d25 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -18,7 +18,7 @@ add_upstream_commit() {
 		head2=$(git rev-parse --short HEAD) &&
 		echo "Fetching submodule submodule" > ../expect.err &&
 		echo "From $pwd/submodule" >> ../expect.err &&
-		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
+		echo "   $head1..$head2  main       -> origin/main" >> ../expect.err
 	) &&
 	(
 		cd deepsubmodule &&
@@ -30,7 +30,7 @@ add_upstream_commit() {
 		head2=$(git rev-parse --short HEAD) &&
 		echo "Fetching submodule submodule/subdir/deepsubmodule" >> ../expect.err
 		echo "From $pwd/deepsubmodule" >> ../expect.err &&
-		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
+		echo "   $head1..$head2  main       -> origin/main" >> ../expect.err
 	)
 }
 
@@ -61,7 +61,7 @@ test_expect_success setup '
 	)
 '
 
-test_expect_success "fetch --recurse-submodules recurses into submodules" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "fetch --recurse-submodules recurses into submodules" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -71,7 +71,7 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success "submodule.recurse option triggers recursive fetch" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "submodule.recurse option triggers recursive fetch" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -81,7 +81,7 @@ test_expect_success "submodule.recurse option triggers recursive fetch" '
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "fetch --recurse-submodules -j2 has the same output behaviour" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -111,7 +111,7 @@ test_expect_success "fetch --no-recurse-submodules only fetches superproject" '
 	test_must_be_empty actual.err
 '
 
-test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses into submodules" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "using fetchRecurseSubmodules=true in .gitmodules recurses into submodules" '
 	(
 		cd downstream &&
 		git config -f .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
@@ -141,7 +141,7 @@ test_expect_success "using fetchRecurseSubmodules=false in .git/config overrides
 	test_must_be_empty actual.err
 '
 
-test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setting from .git/config" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "--recurse-submodules overrides fetchRecurseSubmodules setting from .git/config" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
@@ -170,7 +170,7 @@ test_expect_success "--quiet propagates to parallel submodules" '
 	test_must_be_empty actual.err
 '
 
-test_expect_success "--dry-run propagates to submodules" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "--dry-run propagates to submodules" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -180,7 +180,7 @@ test_expect_success "--dry-run propagates to submodules" '
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success "Without --dry-run propagates to submodules" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "Without --dry-run propagates to submodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
@@ -189,7 +189,7 @@ test_expect_success "Without --dry-run propagates to submodules" '
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success "recurseSubmodules=true propagates into submodules" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "recurseSubmodules=true propagates into submodules" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -200,7 +200,7 @@ test_expect_success "recurseSubmodules=true propagates into submodules" '
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success "--recurse-submodules overrides config in submodule" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "--recurse-submodules overrides config in submodule" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -225,7 +225,7 @@ test_expect_success "--no-recurse-submodules overrides config setting" '
 	test_must_be_empty actual.err
 '
 
-test_expect_success "Recursion doesn't happen when no new commits are fetched in the superproject" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion doesn't happen when no new commits are fetched in the superproject" '
 	(
 		cd downstream &&
 		(
@@ -239,13 +239,13 @@ test_expect_success "Recursion doesn't happen when no new commits are fetched in
 	test_must_be_empty actual.err
 '
 
-test_expect_success "Recursion stops when no new submodule commits are fetched" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion stops when no new submodule commits are fetched" '
 	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.sub &&
-	echo "   $head1..$head2  master     -> origin/master" >>expect.err.sub &&
+	echo "   $head1..$head2  main       -> origin/main" >>expect.err.sub &&
 	head -3 expect.err >> expect.err.sub &&
 	(
 		cd downstream &&
@@ -255,7 +255,7 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
 	test_must_be_empty actual.out
 '
 
-test_expect_success "Recursion doesn't happen when new superproject commits don't change any submodules" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion doesn't happen when new superproject commits don't change any submodules" '
 	add_upstream_commit &&
 	head1=$(git rev-parse --short HEAD) &&
 	echo a > file &&
@@ -263,7 +263,7 @@ test_expect_success "Recursion doesn't happen when new superproject commits don'
 	git commit -m "new file" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.file &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err.file &&
+	echo "   $head1..$head2  main       -> origin/main" >> expect.err.file &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -272,7 +272,7 @@ test_expect_success "Recursion doesn't happen when new superproject commits don'
 	test_i18ncmp expect.err.file actual.err
 '
 
-test_expect_success "Recursion picks up config in submodule" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion picks up config in submodule" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules &&
@@ -287,7 +287,7 @@ test_expect_success "Recursion picks up config in submodule" '
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.sub &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err.sub &&
+	echo "   $head1..$head2  main       -> origin/main" >> expect.err.sub &&
 	cat expect.err >> expect.err.sub &&
 	(
 		cd downstream &&
@@ -301,7 +301,7 @@ test_expect_success "Recursion picks up config in submodule" '
 	test_must_be_empty actual.out
 '
 
-test_expect_success "Recursion picks up all submodules when necessary" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion picks up all submodules when necessary" '
 	add_upstream_commit &&
 	(
 		cd submodule &&
@@ -316,14 +316,14 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 		head2=$(git rev-parse --short HEAD) &&
 		echo "Fetching submodule submodule" > ../expect.err.sub &&
 		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err.sub
+		echo "   $head1..$head2  main       -> origin/main" >> ../expect.err.sub
 	) &&
 	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err.2 &&
+	echo "   $head1..$head2  main       -> origin/main" >> expect.err.2 &&
 	cat expect.err.sub >> expect.err.2 &&
 	tail -3 expect.err >> expect.err.2 &&
 	(
@@ -334,7 +334,7 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 	test_must_be_empty actual.out
 '
 
-test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
 	add_upstream_commit &&
 	(
 		cd submodule &&
@@ -349,7 +349,7 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 		head2=$(git rev-parse --short HEAD) &&
 		echo Fetching submodule submodule > ../expect.err.sub &&
 		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err.sub
+		echo "   $head1..$head2  main       -> origin/main" >> ../expect.err.sub
 	) &&
 	(
 		cd downstream &&
@@ -361,14 +361,14 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 	test_must_be_empty actual.err
 '
 
-test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
 	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	tail -3 expect.err > expect.err.deepsub &&
 	echo "From $pwd/." > expect.err &&
-	echo "   $head1..$head2  master     -> origin/master" >>expect.err &&
+	echo "   $head1..$head2  main       -> origin/main" >>expect.err &&
 	cat expect.err.sub >> expect.err &&
 	cat expect.err.deepsub >> expect.err &&
 	(
@@ -389,7 +389,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
 	add_upstream_commit &&
 	head1=$(git rev-parse --short HEAD) &&
 	echo a >> file &&
@@ -397,7 +397,7 @@ test_expect_success "'--recurse-submodules=on-demand' stops when no new submodul
 	git commit -m "new file" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.file &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err.file &&
+	echo "   $head1..$head2  main       -> origin/main" >> expect.err.file &&
 	(
 		cd downstream &&
 		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
@@ -406,7 +406,7 @@ test_expect_success "'--recurse-submodules=on-demand' stops when no new submodul
 	test_i18ncmp expect.err.file actual.err
 '
 
-test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "'fetch.recurseSubmodules=on-demand' overrides global config" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules
@@ -418,7 +418,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  master     -> origin/master" >>expect.err.2 &&
+	echo "   $head1..$head2  main       -> origin/main" >>expect.err.2 &&
 	head -3 expect.err >> expect.err.2 &&
 	(
 		cd downstream &&
@@ -434,7 +434,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 	test_i18ncmp expect.err.2 actual.err
 '
 
-test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' overrides fetch.recurseSubmodules" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "'submodule.<sub>.fetchRecurseSubmodules=on-demand' overrides fetch.recurseSubmodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules
@@ -446,7 +446,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  master     -> origin/master" >>expect.err.2 &&
+	echo "   $head1..$head2  main       -> origin/main" >>expect.err.2 &&
 	head -3 expect.err >> expect.err.2 &&
 	(
 		cd downstream &&
@@ -462,7 +462,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	test_i18ncmp expect.err.2 actual.err
 '
 
-test_expect_success "don't fetch submodule when newly recorded commits are already present" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "don't fetch submodule when newly recorded commits are already present" '
 	(
 		cd submodule &&
 		git checkout -q HEAD^^
@@ -472,7 +472,7 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 	git commit -m "submodule rewound" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err &&
+	echo "   $head1..$head2  main       -> origin/main" >> expect.err &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -485,7 +485,7 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 	)
 '
 
-test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .gitmodules entry" '
+test_expect_success PREPARE_FOR_MAIN_BRANCH "'fetch.recurseSubmodules=on-demand' works also without .gitmodules entry" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules
@@ -497,7 +497,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 	git commit -m "new submodule without .gitmodules" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." >expect.err.2 &&
-	echo "   $head1..$head2  master     -> origin/master" >>expect.err.2 &&
+	echo "   $head1..$head2  main       -> origin/main" >>expect.err.2 &&
 	head -3 expect.err >>expect.err.2 &&
 	(
 		cd downstream &&
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 781e470aea..0a21669f56 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -113,9 +113,9 @@ test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
 
-test_expect_success 'left alignment is default' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'left alignment is default' '
 	cat >expect <<-\EOF &&
-	refname is refs/heads/master  |refs/heads/master
+	refname is refs/heads/main    |refs/heads/main
 	refname is refs/heads/side    |refs/heads/side
 	refname is refs/odd/spot      |refs/odd/spot
 	refname is refs/tags/annotated-tag|refs/tags/annotated-tag
@@ -131,9 +131,9 @@ test_expect_success 'left alignment is default' '
 	test_cmp expect actual
 '
 
-test_expect_success 'middle alignment' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'middle alignment' '
 	cat >expect <<-\EOF &&
-	| refname is refs/heads/master |refs/heads/master
+	|  refname is refs/heads/main  |refs/heads/main
 	|  refname is refs/heads/side  |refs/heads/side
 	|   refname is refs/odd/spot   |refs/odd/spot
 	|refname is refs/tags/annotated-tag|refs/tags/annotated-tag
@@ -149,9 +149,9 @@ test_expect_success 'middle alignment' '
 	test_cmp expect actual
 '
 
-test_expect_success 'right alignment' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'right alignment' '
 	cat >expect <<-\EOF &&
-	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/main|refs/heads/main
 	|    refname is refs/heads/side|refs/heads/side
 	|      refname is refs/odd/spot|refs/odd/spot
 	|refname is refs/tags/annotated-tag|refs/tags/annotated-tag
@@ -168,7 +168,7 @@ test_expect_success 'right alignment' '
 '
 
 cat >expect <<-\EOF
-|       refname is refs/heads/master       |refs/heads/master
+|        refname is refs/heads/main        |refs/heads/main
 |        refname is refs/heads/side        |refs/heads/side
 |         refname is refs/odd/spot         |refs/odd/spot
 |    refname is refs/tags/annotated-tag    |refs/tags/annotated-tag
@@ -184,7 +184,7 @@ EOF
 test_align_permutations() {
 	while read -r option
 	do
-		test_expect_success "align:$option" '
+		test_expect_success PREPARE_FOR_MAIN_BRANCH "align:$option" '
 			git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
 			test_cmp expect actual
 		'
@@ -213,9 +213,9 @@ EOF
 
 # Individual atoms inside %(align:...) and %(end) must not be quoted.
 
-test_expect_success 'alignment with format quote' "
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'alignment with format quote' "
 	cat >expect <<-\EOF &&
-	|'      '\''master| A U Thor'\''      '|
+	|'       '\''main| A U Thor'\''       '|
 	|'       '\''side| A U Thor'\''       '|
 	|'     '\''odd/spot| A U Thor'\''     '|
 	|'      '\''annotated-tag| '\''       '|
@@ -231,9 +231,9 @@ test_expect_success 'alignment with format quote' "
 	test_cmp expect actual
 "
 
-test_expect_success 'nested alignment with quote formatting' "
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'nested alignment with quote formatting' "
 	cat >expect <<-\EOF &&
-	|'         master               '|
+	|'           main               '|
 	|'           side               '|
 	|'       odd/spot               '|
 	|'  annotated-tag               '|
-- 
gitgitgadget

