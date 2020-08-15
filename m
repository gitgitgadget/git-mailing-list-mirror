Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA89AC433E3
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E56205CB
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNPoVGMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgHOVvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgHOVvY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0940FC0A3BF2
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so10414090wme.4
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tecyx3UhIpZWqH03UciY9yF/in1nxi1c0KS0xS7R+SY=;
        b=UNPoVGMHvJVDnNPGsSjNrd9grBGo7/dg+7VYOa2pNwjqRNy+WNim9Xt9Fc/yzsr6bE
         uFzHX7bddaQ2HjP8qtn5TEYAictL7F+79UI7Qows5YnJkQc2dGp5VZmgalRhRnlJPBAZ
         FOKOhiDWYgEuqXOvV2U18HMM53dHFsnjVaWjQiaPvsBzpk82BX8GuRJZIy5bW+ZQ02x5
         x64N6O2L14a0IfLRX4UQQcpFE4eZjJbXuMHvrokanZCXsB74Xaz6HaNCGJsHIFP6gHYa
         LBvwn/Pt884WEgg59OFsol96BL3tzvYiVvDcKEgmY44AKYSIyqwALtLoAIkNpnJyqraF
         Z3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tecyx3UhIpZWqH03UciY9yF/in1nxi1c0KS0xS7R+SY=;
        b=oZ9YaFiQE1YNWJ175Y/oZLFxNcb+knP6zL259aMgp+adafy0Dr6RLqa7WLbg3wOn+1
         EzpkWuZNr7uG24iptLo36SI3kk7ZGdtXdR/etrPVhMtEeJiIi7gmxAYTiCbkozm2gMi2
         Ch0eolXFQ/9g3HtUKgKW3tXSEUkThaP4D98AiDHsPHDI6ghnj5v1AKoZTisyP+MdBJua
         ymqky2Gxz8Ubog3J1VJgKFJAm2A8hrnbHbowMGVrIG97As4+wthn6TvftKOhdDFLsi2P
         mJLlUDM7k740YIGzQJBK4kJvY7wulVKG+nM7PEOvgrZiUYbtVXyRuA3LoySKr0s+ECEE
         Up0Q==
X-Gm-Message-State: AOAM5301Wxtk+hU3ZrUb63u3LMRcSpj/nk6mkfEIQPg/ypIqA1L4+L1z
        20yt6+pDuyyHEk6Y7wnh7WcKs49awhE=
X-Google-Smtp-Source: ABdhPJx/Zng1QW3r93mNmV+4rYbQcZ6AL2y7jKxSDWiM5EfAnzfg94c+2WlgB6tfRtmJzbRNfOQe7w==
X-Received: by 2002:a1c:1f8b:: with SMTP id f133mr7352212wmf.65.1597509590222;
        Sat, 15 Aug 2020 09:39:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm21388123wme.11.2020.08.15.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:39:49 -0700 (PDT)
Message-Id: <b347dbb01b9254ab8d79fbbd0f7c2b637efde62e.1597509583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 16:39:38 +0000
Subject: [PATCH v3 06/11] commit-graph: add a slab to store topological levels
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

As we are writing topological levels to commit data chunk to ensure
backwards compatibility with "Old" Git and the member `generation` of
struct commit_graph_data will store corrected commit date in a later
commit, let's introduce a commit-slab to store topological levels while
writing commit-graph.

When Git creates a split commit-graph, it takes advantage of the
generation values that have been computed already and present in
existing commit-graph files.

So, let's add a pointer to struct commit_graph to the topological level
commit-slab and populate it with topological levels while writing a
split commit-graph.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 47 ++++++++++++++++++++++++++++++++---------------
 commit-graph.h |  1 +
 commit.h       |  1 +
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7f9f858577..a2f15b2825 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -64,6 +64,8 @@ void git_test_write_commit_graph_or_die(void)
 /* Remember to update object flag allocation in object.h */
 #define REACHABLE       (1u<<15)
 
+define_commit_slab(topo_level_slab, uint32_t);
+
 /* Keep track of the order in which commits are added to our list. */
 define_commit_slab(commit_pos, int);
 static struct commit_pos commit_pos = COMMIT_SLAB_INIT(1, commit_pos);
@@ -759,6 +761,9 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
 	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+
+	if (g->topo_levels)
+		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
 static inline void set_commit_tree(struct commit *c, struct tree *t)
@@ -953,6 +958,7 @@ struct write_commit_graph_context {
 		 changed_paths:1,
 		 order_by_pack:1;
 
+	struct topo_level_slab *topo_levels;
 	const struct split_commit_graph_opts *split_opts;
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
@@ -1094,7 +1100,7 @@ static int write_graph_chunk_data(struct hashfile *f,
 		else
 			packedDate[0] = 0;
 
-		packedDate[0] |= htonl(commit_graph_data_at(*list)->generation << 2);
+		packedDate[0] |= htonl(*topo_level_slab_at(ctx->topo_levels, *list) << 2);
 
 		packedDate[1] = htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
@@ -1335,11 +1341,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
-		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
+		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
 
 		display_progress(ctx->progress, i + 1);
-		if (generation != GENERATION_NUMBER_V1_INFINITY &&
-		    generation != GENERATION_NUMBER_ZERO)
+		if (level != GENERATION_NUMBER_V1_INFINITY &&
+		    level != GENERATION_NUMBER_ZERO)
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1347,29 +1353,27 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			struct commit *current = list->item;
 			struct commit_list *parent;
 			int all_parents_computed = 1;
-			uint32_t max_generation = 0;
+			uint32_t max_level = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
-				generation = commit_graph_data_at(parent->item)->generation;
+				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
 
-				if (generation == GENERATION_NUMBER_V1_INFINITY ||
-				    generation == GENERATION_NUMBER_ZERO) {
+				if (level == GENERATION_NUMBER_V1_INFINITY ||
+				    level == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-				} else if (generation > max_generation) {
-					max_generation = generation;
+				} else if (level > max_level) {
+					max_level = level;
 				}
 			}
 
 			if (all_parents_computed) {
-				struct commit_graph_data *data = commit_graph_data_at(current);
-
-				data->generation = max_generation + 1;
 				pop_commit(&list);
 
-				if (data->generation > GENERATION_NUMBER_MAX)
-					data->generation = GENERATION_NUMBER_MAX;
+				if (max_level > GENERATION_NUMBER_MAX - 1)
+					max_level = GENERATION_NUMBER_MAX - 1;
+				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
 			}
 		}
 	}
@@ -2101,6 +2105,7 @@ int write_commit_graph(struct object_directory *odb,
 	uint32_t i, count_distinct = 0;
 	int res = 0;
 	int replace = 0;
+	struct topo_level_slab topo_levels;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
@@ -2179,6 +2184,18 @@ int write_commit_graph(struct object_directory *odb,
 		}
 	}
 
+	init_topo_level_slab(&topo_levels);
+	ctx->topo_levels = &topo_levels;
+
+	if (ctx->r->objects->commit_graph) {
+		struct commit_graph *g = ctx->r->objects->commit_graph;
+
+		while (g) {
+			g->topo_levels = &topo_levels;
+			g = g->base_graph;
+		}
+	}
+
 	if (pack_indexes) {
 		ctx->order_by_pack = 1;
 		if ((res = fill_oids_from_packs(ctx, pack_indexes)))
diff --git a/commit-graph.h b/commit-graph.h
index 430bc830bb..1152a9642e 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -72,6 +72,7 @@ struct commit_graph {
 	const unsigned char *chunk_bloom_indexes;
 	const unsigned char *chunk_bloom_data;
 
+	struct topo_level_slab *topo_levels;
 	struct bloom_filter_settings *bloom_filter_settings;
 };
 
diff --git a/commit.h b/commit.h
index bc0732a4fe..bb846e0025 100644
--- a/commit.h
+++ b/commit.h
@@ -15,6 +15,7 @@
 #define GENERATION_NUMBER_V1_INFINITY 0xFFFFFFFF
 #define GENERATION_NUMBER_MAX 0x3FFFFFFF
 #define GENERATION_NUMBER_ZERO 0
+#define GENERATION_NUMBER_V2_OFFSET_MAX 0xFFFFFFFF
 
 struct commit_list {
 	struct commit *item;
-- 
gitgitgadget

