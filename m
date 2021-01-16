Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8C5C4332E
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE03A22D50
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbhAPSMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 13:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbhAPSMH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 13:12:07 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0406DC0613C1
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d13so12453668wrc.13
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cEe95guw9s9mzUDrRNnTP/221TBTHwdatVA+Owv7Nr0=;
        b=Rg2JtbAwPSaOukfj62OMw2SoQPSeXQZHePcvc7gFS+0XTKfO0sZiyKgWZ95uqL6hAX
         vFVjeGfcubnm/iPk94pWusqMavScLhls/XNvLgNVc0Pj5ek3X1Y45V3URtA+eF6/5Uoz
         1iYw4RjCgALe7BijbjeMpvUcuWszJaON7uZ7y1GmhY3PbifoDcswF1muqiIkGVx5fsIn
         0CYxN75ZdxhFx7JzK4Ep9OdsneQO0+9LfmZfD2lnAKdlpHSA+FlMWaDQVf5XPJ/uIfML
         /UHj4JdRQ0ocO9rAgKBtaXNJPbHoDZaBPUxKL2mXc92s2hO6xLTs7IfnoVd9Us55hH+3
         OHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cEe95guw9s9mzUDrRNnTP/221TBTHwdatVA+Owv7Nr0=;
        b=f7pcGWAKwfrmWpIBvqtKNktUciYnCw2hqP3WipVmsbumbH0t4/0IFyKsNzU5j+dvtj
         +E9a/IXBg3tRJ5vII3bRzyDlmZk1E1bnrknqgbP2wBpab5LnQPVw9luKfHZTEQeOprge
         7Z5nhiMKFYaeByb0w+D+eDaVw1AC18OZP1pSVlO1BL3ozA1qmie+Z/sIC6FM0+VKKqC9
         EHxgTegdhTjuKkZLT8ouhiEOitfHogrw49LKak5R6+pU4ljXGXlCH96dy+aMyFTjRjVn
         rZvNTKyyZF1+IMstHNV8jnVD7tKZUSvc3ZO5iVDyA4Jl0aaNJvEshiuLSvZ/sb1Vu3SI
         EKxw==
X-Gm-Message-State: AOAM532tOpOCYd9CT1jZ7QH3uGc0A5tkGf3S6NN2s1aQbwjPh7YPoLWl
        XgimOIXrP9s23nm3w6lB24S/hB/gLGc=
X-Google-Smtp-Source: ABdhPJxhrCEeGoKUfsMcno0KCZJYB0o3rOMhYLNh87CCe/fX1z8n/f89JY1oUy5WY6LsCS8B76Cgcw==
X-Received: by 2002:a5d:4dc6:: with SMTP id f6mr19089576wru.336.1610820685431;
        Sat, 16 Jan 2021 10:11:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r20sm22283099wrg.66.2021.01.16.10.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 10:11:24 -0800 (PST)
Message-Id: <4fbdee7ac9070345ad20d226a260b55767e375d1.1610820679.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
        <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Jan 2021 18:11:11 +0000
Subject: [PATCH v6 04/11] t6600-test-reach: generalize *_three_modes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
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

