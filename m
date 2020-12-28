Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7935C4332B
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6350C22583
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgL1LRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgL1LQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:16:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523D4C061799
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:16 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d13so10983331wrc.13
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cEe95guw9s9mzUDrRNnTP/221TBTHwdatVA+Owv7Nr0=;
        b=qn7fAp3Tt7H3AW/2+PbNFLsSxpZbW63yNzfYmofm51EGfLj6uCKYdbFUK0O/qpww9T
         DKotAlDmcpGjTs69hSYAK8KQSxHjOeEe8GLKiV+uJi9diU8sRRrFYgepByqGAl5f/J0q
         AEi6xYG8vtMrVDWWX32lEi8C34z7PREavIjJfhYVMNuqG/LgS+CHXtdWd0TI5yurZOgL
         AuRUUeMc7UV2o4/PSvEwO7r11LWPaW8vvnA1j4r+slo80ux4ZD8rEzRaOFCXgFYfHrqG
         LU1/h95a6DHwM3rL49RNiV7BGE8HlKqQ/+wLur/fJObVdMkl7ThtKHE2+kena56DGOyo
         oN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cEe95guw9s9mzUDrRNnTP/221TBTHwdatVA+Owv7Nr0=;
        b=HU/ryf3vR0/JXEBol8MqtvDBFq45+/IIHk9DXmeUuPfaBG/zI99jxHRrFXYKb7PPRi
         lFbhFeiP2knGbja8pFi/0nY9SlShOhjYD9jbzkW9ycdLoF9GpDF5WydWmmhrhRPxRdU6
         E/jL2jQc2tUYbD2SVifwA0sjJG7TzHCSU/3r5Z3SiXzjKArhbbIdoZUk4UhTTPS9xWo9
         Gs1k+lNM8nJS21v0u8ebQkeQaoLYEUwWOTGuvMBtOwF2Lm1Wp4yJi1/RkhiFGBjOzwgh
         A4N62loUD5Jo3lBDjZO13o3WNhIIEGebxpmmVW6qOxZht7tqfAOib5j5hTiBzQTPxRS9
         1QHw==
X-Gm-Message-State: AOAM530b+AjM0ZugiFMiicivU9E7n6uUlspJ5Gxhf7hiDx6+RDwkzD9P
        nmKJqrqE7vy2Eld4mFrZPpGcUAtqwbQ=
X-Google-Smtp-Source: ABdhPJzw6aeFzfxk3Vuw21185Zp1A1nErXfPbx4bu82lykxis07PkD7DY/IkkMh7+pv+8paIpMkwXw==
X-Received: by 2002:adf:9567:: with SMTP id 94mr50953440wrs.394.1609154174815;
        Mon, 28 Dec 2020 03:16:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18sm61175811wrd.45.2020.12.28.03.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 03:16:14 -0800 (PST)
Message-Id: <591935075f1dce264b24c91715c81ce1ff15fd47.1609154168.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Dec 2020 11:16:01 +0000
Subject: [PATCH v5 04/11] t6600-test-reach: generalize *_three_modes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
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

