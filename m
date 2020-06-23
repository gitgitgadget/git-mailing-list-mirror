Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F250DC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15AE206D4
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag5CLgkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbgFWRrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733167AbgFWRrS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:47:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA1C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so9059803wru.6
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=As+XaR3i/7WhEvBBuzPQae7jR5XZACb2XpAm/niysU0=;
        b=Ag5CLgkCnOOWQh7fFdXGNp8vZvSJ47fCWdausMOo/csgv9+s822IDCL/9w4YEQI2VY
         Tmlsl8ebHnY4HyMdeAWSH3e5yMeo/zGxiL4Vl0v8dCeCUq5YEkt1gasBkH6oFY5Cm9Nd
         70wqUhkUnCjYTgya1iUT/nOkDydZyNuAT/ZPssH6THKMN5xUznZrtEGYbfC5vkYlfWPq
         TgX9id+No9n5pn2DaiaQ4oR6UlAZOOWtxreMnsLO8BVf/UTIFaqskYa2JOn9dbeuED/G
         5Z71IUac/rDMOl4uTuqwoIpQe5YaPWyCjGtJQ2yf3DGszaSEtdZP97XYovte/1AkucEi
         xEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=As+XaR3i/7WhEvBBuzPQae7jR5XZACb2XpAm/niysU0=;
        b=tVH/xwt0tkHbRJERuZ8mY0cWu9tPJdVeLB69WxrMMTV4bgpnGLLr0KCBeX7X3eO+EE
         EPYrwdv2WUNxwteLmyV3KsSsY3Imjks+R8kapjvjxXBM1CpgM8O2x8FAMEPi978FPlX6
         K/id/0xur7OX8dyRzO1EBNlKU4OOtnktCC0UNsupsTHTmBcFJyqlD94k9yY/83Z/B7RV
         8saqI2KYGorbejpdkM0RhNj1RLnv/DxPS341Ai9sEF1FcUQDtNOcOw1aLgn2E83Ken9n
         aVaXlDtyI4D8KC0iid5FgUBimPl0aN4AOK7rI9YjfxJrleYF5Z5pdnyOyvJ3QEUoJHzO
         vmcQ==
X-Gm-Message-State: AOAM530pq1kJBF4eq0/cRdmsjyGrWZk6ZBc41CSTVMGEpxaRQLCvjEBx
        hFeU0uZtMyJfh93bxspQPEr6z3b1
X-Google-Smtp-Source: ABdhPJzwFpAq9bvj6W0gjr1VGu0ZEIImqH085tAJN+6tZxIjRpcTIB39Zb1LFNl6Z5ghnjkoDi8CXA==
X-Received: by 2002:adf:e906:: with SMTP id f6mr18490096wrm.425.1592934436219;
        Tue, 23 Jun 2020 10:47:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15sm17467036wrm.64.2020.06.23.10.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:47:15 -0700 (PDT)
Message-Id: <244668fec4428872f441d515e570e923808f0db1.1592934430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
        <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:47:04 +0000
Subject: [PATCH v2 05/11] commit-graph: unify the signatures of all
 write_graph_chunk_*() functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

Update the write_graph_chunk_*() helper functions to have the same
signature:

  - Return an int error code from all these functions.
    write_graph_chunk_base() already has an int error code, now the
    others will have one, too, but since they don't indicate any
    error, they will always return 0.

  - Drop the hash size parameter of write_graph_chunk_oids() and
    write_graph_chunk_data(); its value can be read directly from
    'the_hash_algo' inside these functions as well.

This opens up the possibility for further cleanups and foolproofing in
the following two patches.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 908f094271..f33bfe49b3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -891,8 +891,8 @@ struct write_commit_graph_context {
 	const struct bloom_filter_settings *bloom_settings;
 };
 
-static void write_graph_chunk_fanout(struct hashfile *f,
-				     struct write_commit_graph_context *ctx)
+static int write_graph_chunk_fanout(struct hashfile *f,
+				    struct write_commit_graph_context *ctx)
 {
 	int i, count = 0;
 	struct commit **list = ctx->commits.list;
@@ -913,17 +913,21 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 
 		hashwrite_be32(f, count);
 	}
+
+	return 0;
 }
 
-static void write_graph_chunk_oids(struct hashfile *f, int hash_len,
-				   struct write_commit_graph_context *ctx)
+static int write_graph_chunk_oids(struct hashfile *f,
+				  struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	int count;
 	for (count = 0; count < ctx->commits.nr; count++, list++) {
 		display_progress(ctx->progress, ++ctx->progress_cnt);
-		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
+		hashwrite(f, (*list)->object.oid.hash, (int)the_hash_algo->rawsz);
 	}
+
+	return 0;
 }
 
 static const unsigned char *commit_to_sha1(size_t index, void *table)
@@ -932,8 +936,8 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
 	return commits[index]->object.oid.hash;
 }
 
-static void write_graph_chunk_data(struct hashfile *f, int hash_len,
-				   struct write_commit_graph_context *ctx)
+static int write_graph_chunk_data(struct hashfile *f,
+				  struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -950,7 +954,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 			die(_("unable to parse commit %s"),
 				oid_to_hex(&(*list)->object.oid));
 		tree = get_commit_tree_oid(*list);
-		hashwrite(f, tree->hash, hash_len);
+		hashwrite(f, tree->hash, the_hash_algo->rawsz);
 
 		parent = (*list)->parents;
 
@@ -1030,10 +1034,12 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 		list++;
 	}
+
+	return 0;
 }
 
-static void write_graph_chunk_extra_edges(struct hashfile *f,
-					  struct write_commit_graph_context *ctx)
+static int write_graph_chunk_extra_edges(struct hashfile *f,
+					 struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -1082,10 +1088,12 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 
 		list++;
 	}
+
+	return 0;
 }
 
-static void write_graph_chunk_bloom_indexes(struct hashfile *f,
-					    struct write_commit_graph_context *ctx)
+static int write_graph_chunk_bloom_indexes(struct hashfile *f,
+					   struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -1107,6 +1115,7 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
 	}
 
 	stop_progress(&progress);
+	return 0;
 }
 
 static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
@@ -1124,8 +1133,8 @@ static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
 	jw_release(&jw);
 }
 
-static void write_graph_chunk_bloom_data(struct hashfile *f,
-					 struct write_commit_graph_context *ctx)
+static int write_graph_chunk_bloom_data(struct hashfile *f,
+					struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -1151,6 +1160,7 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 	}
 
 	stop_progress(&progress);
+	return 0;
 }
 
 static int oid_compare(const void *_a, const void *_b)
@@ -1662,8 +1672,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			num_chunks * ctx->commits.nr);
 	}
 	write_graph_chunk_fanout(f, ctx);
-	write_graph_chunk_oids(f, hashsz, ctx);
-	write_graph_chunk_data(f, hashsz, ctx);
+	write_graph_chunk_oids(f, ctx);
+	write_graph_chunk_data(f, ctx);
 	if (ctx->num_extra_edges)
 		write_graph_chunk_extra_edges(f, ctx);
 	if (ctx->changed_paths) {
-- 
gitgitgadget

