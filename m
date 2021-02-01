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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D352C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8E164E30
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBAG7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 01:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhBAG7e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 01:59:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01AFC0613D6
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:58:53 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l12so15340196wry.2
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cEe95guw9s9mzUDrRNnTP/221TBTHwdatVA+Owv7Nr0=;
        b=hBl6uBiW/aKHt0+bz3CnFE3dDdP9AMeWkEgCVczuhd1NLGgOtdJxKYxfTxcF67zECh
         0tryZswbk6HVKqbip6ULx/a9Q4zmywj+ahVxRidlEhahBIj+E8bgdQR4lrwRC1Ge96yO
         q2a0rAXwNPQkze7eWLrzgx5KEIPJpamDl1ib5vzbBkrWYoMDjhxEcqmVzSEnP237RpXG
         WLIzTs3vPFN4+rHhFRH/6zAyWcYC1UJDre11kDPpZrliz9ucROBoIC7xSOgvxaJTRZxD
         hgVr6VLOmV4GBKa0KXeUaS4fG3AKsd8g/vtVGO5F2Pmz/vjVMRCflZWBlnT8BquVSuDj
         XSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cEe95guw9s9mzUDrRNnTP/221TBTHwdatVA+Owv7Nr0=;
        b=V68vyo9N+hWLGZXMRzPaIRuv7xQ1lA1t/ZvxDtawKHsO8pvB5g5XJUVlDVua99TirF
         Bx8ojzZ3D58EMQXRIokajJ3WPwVfN22wy9lSCb+ats4awFYPfwlJSQC/Ajek0WvLzGql
         a5/cP14HGLJ2pJTgVK+t6Vnpljf1YidNiaGMvtA9IuueS+fE4kxayIu3f1j6CByHdZ5L
         FcUBT6ZLxYpOzNMdQVK1m1mSJoY4MlxjjdNdnej2SCAzcY4yUCAWW8kaxtP7H4FjiqR0
         Yj/OH/54utAgpssV1vaj+hJiSQOlDogzWpu853AXs0uOMpW0gNtf6hs0Ri7WjZHjCo5h
         FJgQ==
X-Gm-Message-State: AOAM531HW+3gW5Q/z5j9ltJcqxlvHo4q8bjStx6AyHNMmmsu1eCmy0y8
        xytLGgh/szpTlnF/In+RWSdWjJlZE2w=
X-Google-Smtp-Source: ABdhPJzn/dk5F6vKsgcjMGz2g3gG+SfFo1lKjIq/IjER5B4wgepri8HX93KXidYuxmpEMu1gEG4HsQ==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr17033288wrr.409.1612162732367;
        Sun, 31 Jan 2021 22:58:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm25487707wrt.15.2021.01.31.22.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 22:58:51 -0800 (PST)
Message-Id: <085085a433072076ffa45d149cdf4e0b6b55d918.1612162726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
References: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
        <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 06:58:38 +0000
Subject: [PATCH v7 04/11] t6600-test-reach: generalize *_three_modes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

In a preparatory step to implement generation number v2, we add tests to
ensure Git can read and parse commit-graph files without Generation Data
chunk. These files represent commit-graph files written by Old Git and
are neccesary for backward compatability.

We extend run_three_modes() and test_three_modes() to *_all_modes() with
the fourth mode being "commit-graph without generation data chunk".

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 t/t6600-test-reach.sh | 62 +++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index f807276337d..af10f0dc090 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -58,7 +58,7 @@ test_expect_success 'setup' '
 	git config core.commitGraph true
 '
 
-run_three_modes () {
+run_all_modes () {
 	test_when_finished rm -rf .git/objects/info/commit-graph &&
 	"$@" <input >actual &&
 	test_cmp expect actual &&
@@ -70,8 +70,8 @@ run_three_modes () {
 	test_cmp expect actual
 }
 
-test_three_modes () {
-	run_three_modes test-tool reach "$@"
+test_all_modes () {
+	run_all_modes test-tool reach "$@"
 }
 
 test_expect_success 'ref_newer:miss' '
@@ -80,7 +80,7 @@ test_expect_success 'ref_newer:miss' '
 	B:commit-4-9
 	EOF
 	echo "ref_newer(A,B):0" >expect &&
-	test_three_modes ref_newer
+	test_all_modes ref_newer
 '
 
 test_expect_success 'ref_newer:hit' '
@@ -89,7 +89,7 @@ test_expect_success 'ref_newer:hit' '
 	B:commit-2-3
 	EOF
 	echo "ref_newer(A,B):1" >expect &&
-	test_three_modes ref_newer
+	test_all_modes ref_newer
 '
 
 test_expect_success 'in_merge_bases:hit' '
@@ -98,7 +98,7 @@ test_expect_success 'in_merge_bases:hit' '
 	B:commit-8-8
 	EOF
 	echo "in_merge_bases(A,B):1" >expect &&
-	test_three_modes in_merge_bases
+	test_all_modes in_merge_bases
 '
 
 test_expect_success 'in_merge_bases:miss' '
@@ -107,7 +107,7 @@ test_expect_success 'in_merge_bases:miss' '
 	B:commit-5-9
 	EOF
 	echo "in_merge_bases(A,B):0" >expect &&
-	test_three_modes in_merge_bases
+	test_all_modes in_merge_bases
 '
 
 test_expect_success 'in_merge_bases_many:hit' '
@@ -117,7 +117,7 @@ test_expect_success 'in_merge_bases_many:hit' '
 	X:commit-5-7
 	EOF
 	echo "in_merge_bases_many(A,X):1" >expect &&
-	test_three_modes in_merge_bases_many
+	test_all_modes in_merge_bases_many
 '
 
 test_expect_success 'in_merge_bases_many:miss' '
@@ -127,7 +127,7 @@ test_expect_success 'in_merge_bases_many:miss' '
 	X:commit-8-6
 	EOF
 	echo "in_merge_bases_many(A,X):0" >expect &&
-	test_three_modes in_merge_bases_many
+	test_all_modes in_merge_bases_many
 '
 
 test_expect_success 'in_merge_bases_many:miss-heuristic' '
@@ -137,7 +137,7 @@ test_expect_success 'in_merge_bases_many:miss-heuristic' '
 	X:commit-6-6
 	EOF
 	echo "in_merge_bases_many(A,X):0" >expect &&
-	test_three_modes in_merge_bases_many
+	test_all_modes in_merge_bases_many
 '
 
 test_expect_success 'is_descendant_of:hit' '
@@ -148,7 +148,7 @@ test_expect_success 'is_descendant_of:hit' '
 	X:commit-1-1
 	EOF
 	echo "is_descendant_of(A,X):1" >expect &&
-	test_three_modes is_descendant_of
+	test_all_modes is_descendant_of
 '
 
 test_expect_success 'is_descendant_of:miss' '
@@ -159,7 +159,7 @@ test_expect_success 'is_descendant_of:miss' '
 	X:commit-7-6
 	EOF
 	echo "is_descendant_of(A,X):0" >expect &&
-	test_three_modes is_descendant_of
+	test_all_modes is_descendant_of
 '
 
 test_expect_success 'get_merge_bases_many' '
@@ -174,7 +174,7 @@ test_expect_success 'get_merge_bases_many' '
 		git rev-parse commit-5-6 \
 			      commit-4-7 | sort
 	} >expect &&
-	test_three_modes get_merge_bases_many
+	test_all_modes get_merge_bases_many
 '
 
 test_expect_success 'reduce_heads' '
@@ -196,7 +196,7 @@ test_expect_success 'reduce_heads' '
 			      commit-2-8 \
 			      commit-1-10 | sort
 	} >expect &&
-	test_three_modes reduce_heads
+	test_all_modes reduce_heads
 '
 
 test_expect_success 'can_all_from_reach:hit' '
@@ -219,7 +219,7 @@ test_expect_success 'can_all_from_reach:hit' '
 	Y:commit-8-1
 	EOF
 	echo "can_all_from_reach(X,Y):1" >expect &&
-	test_three_modes can_all_from_reach
+	test_all_modes can_all_from_reach
 '
 
 test_expect_success 'can_all_from_reach:miss' '
@@ -241,7 +241,7 @@ test_expect_success 'can_all_from_reach:miss' '
 	Y:commit-8-5
 	EOF
 	echo "can_all_from_reach(X,Y):0" >expect &&
-	test_three_modes can_all_from_reach
+	test_all_modes can_all_from_reach
 '
 
 test_expect_success 'can_all_from_reach_with_flag: tags case' '
@@ -264,7 +264,7 @@ test_expect_success 'can_all_from_reach_with_flag: tags case' '
 	Y:commit-8-1
 	EOF
 	echo "can_all_from_reach_with_flag(X,_,_,0,0):1" >expect &&
-	test_three_modes can_all_from_reach_with_flag
+	test_all_modes can_all_from_reach_with_flag
 '
 
 test_expect_success 'commit_contains:hit' '
@@ -280,8 +280,8 @@ test_expect_success 'commit_contains:hit' '
 	X:commit-9-3
 	EOF
 	echo "commit_contains(_,A,X,_):1" >expect &&
-	test_three_modes commit_contains &&
-	test_three_modes commit_contains --tag
+	test_all_modes commit_contains &&
+	test_all_modes commit_contains --tag
 '
 
 test_expect_success 'commit_contains:miss' '
@@ -297,8 +297,8 @@ test_expect_success 'commit_contains:miss' '
 	X:commit-9-3
 	EOF
 	echo "commit_contains(_,A,X,_):0" >expect &&
-	test_three_modes commit_contains &&
-	test_three_modes commit_contains --tag
+	test_all_modes commit_contains &&
+	test_all_modes commit_contains --tag
 '
 
 test_expect_success 'rev-list: basic topo-order' '
@@ -310,7 +310,7 @@ test_expect_success 'rev-list: basic topo-order' '
 		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
 		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
 	>expect &&
-	run_three_modes git rev-list --topo-order commit-6-6
+	run_all_modes git rev-list --topo-order commit-6-6
 '
 
 test_expect_success 'rev-list: first-parent topo-order' '
@@ -322,7 +322,7 @@ test_expect_success 'rev-list: first-parent topo-order' '
 		commit-6-2 \
 		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
 	>expect &&
-	run_three_modes git rev-list --first-parent --topo-order commit-6-6
+	run_all_modes git rev-list --first-parent --topo-order commit-6-6
 '
 
 test_expect_success 'rev-list: range topo-order' '
@@ -334,7 +334,7 @@ test_expect_success 'rev-list: range topo-order' '
 		commit-6-2 commit-5-2 commit-4-2 \
 		commit-6-1 commit-5-1 commit-4-1 \
 	>expect &&
-	run_three_modes git rev-list --topo-order commit-3-3..commit-6-6
+	run_all_modes git rev-list --topo-order commit-3-3..commit-6-6
 '
 
 test_expect_success 'rev-list: range topo-order' '
@@ -346,7 +346,7 @@ test_expect_success 'rev-list: range topo-order' '
 		commit-6-2 commit-5-2 commit-4-2 \
 		commit-6-1 commit-5-1 commit-4-1 \
 	>expect &&
-	run_three_modes git rev-list --topo-order commit-3-8..commit-6-6
+	run_all_modes git rev-list --topo-order commit-3-8..commit-6-6
 '
 
 test_expect_success 'rev-list: first-parent range topo-order' '
@@ -358,7 +358,7 @@ test_expect_success 'rev-list: first-parent range topo-order' '
 		commit-6-2 \
 		commit-6-1 commit-5-1 commit-4-1 \
 	>expect &&
-	run_three_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
+	run_all_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
 '
 
 test_expect_success 'rev-list: ancestry-path topo-order' '
@@ -368,7 +368,7 @@ test_expect_success 'rev-list: ancestry-path topo-order' '
 		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
 		commit-6-3 commit-5-3 commit-4-3 \
 	>expect &&
-	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
+	run_all_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
 '
 
 test_expect_success 'rev-list: symmetric difference topo-order' '
@@ -382,7 +382,7 @@ test_expect_success 'rev-list: symmetric difference topo-order' '
 		commit-3-8 commit-2-8 commit-1-8 \
 		commit-3-7 commit-2-7 commit-1-7 \
 	>expect &&
-	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
+	run_all_modes git rev-list --topo-order commit-3-8...commit-6-6
 '
 
 test_expect_success 'get_reachable_subset:all' '
@@ -402,7 +402,7 @@ test_expect_success 'get_reachable_subset:all' '
 			      commit-1-7 \
 			      commit-5-6 | sort
 	) >expect &&
-	test_three_modes get_reachable_subset
+	test_all_modes get_reachable_subset
 '
 
 test_expect_success 'get_reachable_subset:some' '
@@ -420,7 +420,7 @@ test_expect_success 'get_reachable_subset:some' '
 		git rev-parse commit-3-3 \
 			      commit-1-7 | sort
 	) >expect &&
-	test_three_modes get_reachable_subset
+	test_all_modes get_reachable_subset
 '
 
 test_expect_success 'get_reachable_subset:none' '
@@ -434,7 +434,7 @@ test_expect_success 'get_reachable_subset:none' '
 	Y:commit-2-8
 	EOF
 	echo "get_reachable_subset(X,Y)" >expect &&
-	test_three_modes get_reachable_subset
+	test_all_modes get_reachable_subset
 '
 
 test_done
-- 
gitgitgadget

