Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A82C433E1
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524FC206DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRCV1NEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgHICyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgHICxz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:53:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1981C061A27
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:53:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id 88so5052343wrh.3
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6AVQeslCBa1mSfJ9qfMqVwa16RSD2qGpgXX3ZnaVk/A=;
        b=fRCV1NENfWIJmgC8wlE1O37CUgehbaCsK59bAZfdo4xStO3QYk11Sr29hSBF3yBE/c
         l6xZeN8gOw8EW0mJGiMsvndS18T7G7axRtmn30rJnO5pCCNd8YSmjqGIZ/sgsjtBlPGJ
         k64cErZCs9c3jscbmXbQ6syv5R0pJvQrKQvYoOzwmh9CBX1sEsbGRV/3YOmRHLr+vMwU
         N8Qya82Res9PW+BdzuvTa+j+c95tTUxwBZqAeLsgrz+K35Y5Ab8/oV0ob1xXOBJCIA2y
         F7yJHkki2H1y+1XejRlEbKsK39nsoyMnjqIMiECYKo/eWxhYeLSybwU3CCbX/CuB5psZ
         8A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6AVQeslCBa1mSfJ9qfMqVwa16RSD2qGpgXX3ZnaVk/A=;
        b=TjfHky3Q/uXwVue5Af2naZgDqVGUiHl98Xlh85uUaFAd+pSJlQcQ3qRlogflDJwRBY
         gs9z58c7bY8Ebh75ODcOFZ9giynzpbfyV0yuDdySPijd1swiuKpJ2vM5F9DFkfoNshDR
         9kzi2e1dHTpUzF4PS+1fI76Oi7+5VmSr8KyoaSWhwoTtgTz+PEoknW4yT8orx3zM0tVG
         RUBgHt5S4ES2es1ifTHJDfDkzhmLeL3BK7SnPYK2SuOrazSQrkg8bkyOOrNtCjz372lk
         sNPs7EHCI5K3YCD/E4nTV1tL1Q+wirbtDRGmspqnYH0m+Qgw3Wwv/7tNDrwsERtVs9Vq
         YCIQ==
X-Gm-Message-State: AOAM5300WFKMUUt3p5GuP//pjPhBpUxxsaQn3+3nIxvb+g097Z7eaRFR
        U/DV/XI7Pps158LclX5jGNwKZTzf
X-Google-Smtp-Source: ABdhPJzHhiloenrCvjOOImXRszIv47blnIfVR9/JbHXewitUmV5a9n7MwhKDB66i0aH4bPGwTxAtew==
X-Received: by 2002:adf:ec10:: with SMTP id x16mr17858319wrn.74.1596941633328;
        Sat, 08 Aug 2020 19:53:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i82sm16473697wmi.10.2020.08.08.19.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 19:53:52 -0700 (PDT)
Message-Id: <32da955e318c143db9605a1b2b312598b3fc5231.1596941624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Aug 2020 02:53:37 +0000
Subject: [PATCH v2 03/10] commit-graph: consolidate fill_commit_graph_info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

Both fill_commit_graph_info() and fill_commit_in_graph() parse
information present in commit data chunk. Let's simplify the
implementation by calling fill_commit_graph_info() within
fill_commit_in_graph().

The test 'generate tar with future mtime' creates a commit with commit
time of (2 ^ 36 + 1) seconds since EPOCH. The commit time overflows into
generation number (within CDAT chunk) and has undefined behavior.

The test used to pass as fill_commit_in_graph() guarantees the values of
graph position and generation number, and did not load timestamp.
However, with corrected commit date we will need load the timestamp as
well to populate the generation number.

Let's fix the test by setting a timestamp of (2 ^ 34 - 1) seconds.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c      | 29 +++++++++++------------------
 t/t5000-tar-tree.sh |  4 ++--
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index ace7400a1a..af8d9cc45e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -725,15 +725,24 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	const unsigned char *commit_data;
 	struct commit_graph_data *graph_data;
 	uint32_t lex_index;
+	uint64_t date_high, date_low;
 
 	while (pos < g->num_commits_in_base)
 		g = g->base_graph;
 
+	if (pos >= g->num_commits + g->num_commits_in_base)
+		die(_("invalid commit position. commit-graph is likely corrupt"));
+
 	lex_index = pos - g->num_commits_in_base;
 	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
 
 	graph_data = commit_graph_data_at(item);
 	graph_data->graph_pos = pos;
+
+	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
+	date_low = get_be32(commit_data + g->hash_len + 12);
+	item->date = (timestamp_t)((date_high << 32) | date_low);
+
 	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
@@ -748,38 +757,22 @@ static int fill_commit_in_graph(struct repository *r,
 {
 	uint32_t edge_value;
 	uint32_t *parent_data_ptr;
-	uint64_t date_low, date_high;
 	struct commit_list **pptr;
-	struct commit_graph_data *graph_data;
 	const unsigned char *commit_data;
 	uint32_t lex_index;
 
 	while (pos < g->num_commits_in_base)
 		g = g->base_graph;
 
-	if (pos >= g->num_commits + g->num_commits_in_base)
-		die(_("invalid commit position. commit-graph is likely corrupt"));
+	fill_commit_graph_info(item, g, pos);
 
-	/*
-	 * Store the "full" position, but then use the
-	 * "local" position for the rest of the calculation.
-	 */
-	graph_data = commit_graph_data_at(item);
-	graph_data->graph_pos = pos;
 	lex_index = pos - g->num_commits_in_base;
-
-	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
+	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
 
 	item->object.parsed = 1;
 
 	set_commit_tree(item, NULL);
 
-	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
-	date_low = get_be32(commit_data + g->hash_len + 12);
-	item->date = (timestamp_t)((date_high << 32) | date_low);
-
-	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
-
 	pptr = &item->parents;
 
 	edge_value = get_be32(commit_data + g->hash_len);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 37655a237c..1986354fc3 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -406,7 +406,7 @@ test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
 	rm -f .git/index &&
 	echo content >file &&
 	git add file &&
-	GIT_COMMITTER_DATE="@68719476737 +0000" \
+	GIT_COMMITTER_DATE="@17179869183 +0000" \
 		git commit -m "tempori parendum"
 '
 
@@ -415,7 +415,7 @@ test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
 '
 
 test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read our future mtime' '
-	echo 4147 >expect &&
+	echo 2514 >expect &&
 	tar_info future.tar | cut -d" " -f2 >actual &&
 	test_cmp expect actual
 '
-- 
gitgitgadget

