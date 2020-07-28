Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0129C433E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD90E20829
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdhBllA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgG1JOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgG1JN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 05:13:58 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FF0C0619D4
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:13:58 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a1so14203201edt.10
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RUaE+WxBy+3RZnyLvqcNd38rWb9xYJ+kF6E5n7+K2YQ=;
        b=PdhBllA5RL6Cr+l5Q7cG6oFL1RT0Q46pHxsziaViauEn8/LLz3E/7Z7QJ7XVbFM3UF
         HWZnQiAdNUUcXVgXfUhVWKpehN7hvlHNSHxHbSAXtGQeEHJAmSSZ6E39swi4Wpc1PeAK
         ym3SU6YS3XKK2RupcqDuYYBvkp/C6T78HT084tH5n/A9QTwc9Cwjm3WBgP4bka/D8mQT
         S+Ioc9MvkDuc13JBw2tdHrTmHUJXz+LXtsfu64Gu4MLF6Z6xgX61Y+VcDKlQS/wZA61n
         ILuZ8BRGTh9z0MsEYlcKjpDTEJXK5Q4thAYBAc+JXTrX/9rAizlg5KJnb8r/Idf2FYz8
         DyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RUaE+WxBy+3RZnyLvqcNd38rWb9xYJ+kF6E5n7+K2YQ=;
        b=pKm2eR2Rnb73WsI761AXyXQZV1wkdbfsJMAoiZie+8XCXMnZPLAoIOneV4Zso1/eRM
         1VWeehWCdMka1vP25cv0rkYKmXNj/HznYZhWsW/TNatrAc92DN6+rTyVy87FOempX9tW
         eqZwz2OUMgYh5VO/7U1xt7p631Yd/XL2/CjOIedXY14Q6Ht/OyCA2nPGSAl0NGpmb19h
         s21Vw8mLhyRUj+fiqpdTglbFNsLwPhwNrOcXKU9oi//g6oeeqCyEoZkZfoIgSWW/ikNU
         xBWa3zZsVObXo9buv9ttvmTht+ZJ6hKSZqVt4mVTrULKcoq2OE92v8y4ZW3KtMWV+yjf
         BiKA==
X-Gm-Message-State: AOAM531C2BRV/9wfeaIJ+oazpVnSBigGxSVoauwHonMZXx+NNNU/XaSl
        BCW1piP4cxwDeoc1fmSZN1x/1hnk
X-Google-Smtp-Source: ABdhPJwfeQU/lQ+KK8V+RoaR5vnSuAXTZ3Xvh6icduWVx5QcYE7uQL2HDhKX+BpbF70+NHUSj+L7xw==
X-Received: by 2002:a50:e689:: with SMTP id z9mr25603243edm.131.1595927637011;
        Tue, 28 Jul 2020 02:13:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h24sm8776360ejk.117.2020.07.28.02.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 02:13:56 -0700 (PDT)
Message-Id: <701f5912369c0fcc07cf604c3129cb5017a125ce.1595927632.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.1595927632.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 09:13:48 +0000
Subject: [PATCH 3/6] commit-graph: consolidate fill_commit_graph_info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
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
generation number and has undefined behavior. The test used to pass as
fill_commit_in_graph() did not read commit time from commit graph,
reading commit date from odb instead.

Let's fix that by setting commit time of (2 ^ 34 - 1) seconds.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c      | 31 ++++++++++++-------------------
 t/t5000-tar-tree.sh |  4 ++--
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 5d3c9bd23c..204eb454b2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -735,15 +735,24 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
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
 
@@ -758,38 +767,22 @@ static int fill_commit_in_graph(struct repository *r,
 {
 	uint32_t edge_value;
 	uint32_t *parent_data_ptr;
-	uint64_t date_low, date_high;
 	struct commit_list **pptr;
-	struct commit_graph_data *graph_data;
 	const unsigned char *commit_data;
 	uint32_t lex_index;
 
+	fill_commit_graph_info(item, g, pos);
+
 	while (pos < g->num_commits_in_base)
 		g = g->base_graph;
 
-	if (pos >= g->num_commits + g->num_commits_in_base)
-		die(_("invalid commit position. commit-graph is likely corrupt"));
-
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

