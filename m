Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B44C433E1
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87FF7206DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCuCFKBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgHICyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHICx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:53:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4B0C061A2B
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:53:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p20so5059181wrf.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pr2Zc/i+T1F6Y+cZHGY7FqZwxY9Ft3aIIPl4yRzi6Xs=;
        b=HCuCFKBRnmsskT62haz6FS669ebg+MrRmKvpJu43FqGZOyvyX4PDtZK35rBgjnYWMN
         6LXxonXLOctMRfr7OZeKMuHbqvCVwYHu9U8jKp44mHfHTqT8xSfohfzi1nFQEapHVUXW
         ymUbb/inQW+EYvv7J8UfvaEd2tRewoVrEWcJ8G+n/TaPSNIpgjN/kcMrtY1YX+zRC7Cv
         47cNvFPC4lI2UsIUyRJDsRVxepjG0BNTD58l4UNipzKzMneIU73ZD/LJaqVcOh1MN/f0
         ljbUsSKnDpDZeXGYyM6tBlBtpiGPPveZrixGeymeztcN83sHkCYBWdhy8ANVEzTFaajn
         Ur+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pr2Zc/i+T1F6Y+cZHGY7FqZwxY9Ft3aIIPl4yRzi6Xs=;
        b=P24vuffd7E7A141jGo6QloaxzMGbTixhX7d4Cbbmljw9K3ZWKQEQRIj+AuWgtRB9ml
         F2QT5+IJrF/h1sIUwyHqse5PoY9xRWjc3tr90QCyThKcFBmcr7VVwNMh3OzTikg15SiC
         Map4iH8fQxLD71BaGm5Cypg06Gv/DUxzEKZDZAo4WYupUlkPAlvU/5QZgtd7oe7wmCwC
         8zLn8415I5PTF03nj3HFfh5wmW63rGDiHJTiSs3S8pXQUfGuUmRGzcnniP4gYOASvRkq
         DmtzIJYnP4GiTO8ZTWs3ApJVJ4FlVQ+Aq4EvY1dWxz/Hzmo2EOQ+izDraslAPgqK1w5J
         qC6g==
X-Gm-Message-State: AOAM531D+cbUYzHPm5eN7cvsFkqMoJyENmygscL7MTczIuLtYC8jt1Ro
        CthsGm417PY/vP03NMf706jKVxXF
X-Google-Smtp-Source: ABdhPJz+I14H6OjVwFQlCfC5hHP8n4rBIHheQcdxKUP2TRg7zrxsgflhg/UvIv7pcQIGYoewXCkX7g==
X-Received: by 2002:a5d:5746:: with SMTP id q6mr18625136wrw.59.1596941636377;
        Sat, 08 Aug 2020 19:53:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm17002984wrx.90.2020.08.08.19.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 19:53:55 -0700 (PDT)
Message-Id: <bfe14732014807ff19f943cdf51068f0d3043c30.1596941625.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Aug 2020 02:53:41 +0000
Subject: [PATCH v2 07/10] commit-graph: implement corrected commit date
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

With most of preparations done, let's implement corrected commit date
offset. We add a new commit-slab to store topogical levels while
writing commit graph and upgrade the generation member in struct
commit_graph_data to a 64-bit timestamp. We store topological levels to
ensure that older versions of Git will still have the performance
benefits from generation number v2.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 89 ++++++++++++++++++++++++++++----------------------
 commit.h       |  1 +
 2 files changed, 51 insertions(+), 39 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 42f3ec5460..d0f977852b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -65,6 +65,8 @@ void git_test_write_commit_graph_or_die(void)
 /* Remember to update object flag allocation in object.h */
 #define REACHABLE       (1u<<15)
 
+define_commit_slab(topo_level_slab, uint32_t);
+
 /* Keep track of the order in which commits are added to our list. */
 define_commit_slab(commit_pos, int);
 static struct commit_pos commit_pos = COMMIT_SLAB_INIT(1, commit_pos);
@@ -168,11 +170,6 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	else if (generation_a > generation_b)
 		return 1;
 
-	/* use date as a heuristic when generations are equal */
-	if (a->date < b->date)
-		return -1;
-	else if (a->date > b->date)
-		return 1;
 	return 0;
 }
 
@@ -767,7 +764,10 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
 	if (g->chunk_generation_data)
-		graph_data->generation = get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
+	{
+		graph_data->generation = item->date +
+			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
+	}
 	else
 		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
@@ -948,6 +948,7 @@ struct write_commit_graph_context {
 	struct progress *progress;
 	int progress_done;
 	uint64_t progress_cnt;
+	struct topo_level_slab *topo_levels;
 
 	char *base_graph_name;
 	int num_commit_graphs_before;
@@ -1106,7 +1107,7 @@ static int write_graph_chunk_data(struct hashfile *f,
 		else
 			packedDate[0] = 0;
 
-		packedDate[0] |= htonl(commit_graph_data_at(*list)->generation << 2);
+		packedDate[0] |= htonl(*topo_level_slab_at(ctx->topo_levels, *list) << 2);
 
 		packedDate[1] = htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
@@ -1123,8 +1124,13 @@ static int write_graph_chunk_generation_data(struct hashfile *f,
 	int i;
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
+		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
-		hashwrite_be32(f, commit_graph_data_at(c)->generation);
+
+		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
+			offset = GENERATION_NUMBER_V2_OFFSET_MAX;
+
+		hashwrite_be32(f, offset);
 	}
 
 	return 0;
@@ -1360,11 +1366,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
-		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
+		uint32_t topo_level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
 
 		display_progress(ctx->progress, i + 1);
-		if (generation != GENERATION_NUMBER_V1_INFINITY &&
-		    generation != GENERATION_NUMBER_ZERO)
+		if (topo_level != GENERATION_NUMBER_V1_INFINITY &&
+		    topo_level != GENERATION_NUMBER_ZERO)
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1372,29 +1378,38 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			struct commit *current = list->item;
 			struct commit_list *parent;
 			int all_parents_computed = 1;
-			uint32_t max_generation = 0;
+			uint32_t max_level = 0;
+			timestamp_t max_corrected_commit_date = current->date - 1;
 
 			for (parent = current->parents; parent; parent = parent->next) {
-				generation = commit_graph_data_at(parent->item)->generation;
+				topo_level = *topo_level_slab_at(ctx->topo_levels, parent->item);
 
-				if (generation == GENERATION_NUMBER_V1_INFINITY ||
-				    generation == GENERATION_NUMBER_ZERO) {
+				if (topo_level == GENERATION_NUMBER_V1_INFINITY ||
+				    topo_level == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-				} else if (generation > max_generation) {
-					max_generation = generation;
+				} else {
+					struct commit_graph_data *data = commit_graph_data_at(parent->item);
+
+					if (topo_level > max_level)
+						max_level = topo_level;
+
+					if (data->generation > max_corrected_commit_date)
+						max_corrected_commit_date = data->generation;
 				}
 			}
 
 			if (all_parents_computed) {
 				struct commit_graph_data *data = commit_graph_data_at(current);
 
-				data->generation = max_generation + 1;
-				pop_commit(&list);
+				if (max_level > GENERATION_NUMBER_MAX - 1)
+					max_level = GENERATION_NUMBER_MAX - 1;
+
+				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
+				data->generation = max_corrected_commit_date + 1;
 
-				if (data->generation > GENERATION_NUMBER_MAX)
-					data->generation = GENERATION_NUMBER_MAX;
+				pop_commit(&list);
 			}
 		}
 	}
@@ -2132,6 +2147,7 @@ int write_commit_graph(struct object_directory *odb,
 	uint32_t i, count_distinct = 0;
 	int res = 0;
 	int replace = 0;
+	struct topo_level_slab topo_levels;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
@@ -2146,6 +2162,9 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->total_bloom_filter_data_size = 0;
 	ctx->write_generation_data = !git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0);
 
+	init_topo_level_slab(&topo_levels);
+	ctx->topo_levels = &topo_levels;
+
 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
 		ctx->changed_paths = 1;
 	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
@@ -2387,8 +2406,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
-		timestamp_t max_generation = 0;
-		timestamp_t generation;
+		timestamp_t max_parent_corrected_commit_date = 0;
+		timestamp_t corrected_commit_date;
 
 		display_progress(progress, i + 1);
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
@@ -2427,9 +2446,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
 
-			generation = commit_graph_generation(graph_parents->item);
-			if (generation > max_generation)
-				max_generation = generation;
+			corrected_commit_date = commit_graph_generation(graph_parents->item);
+			if (corrected_commit_date > max_parent_corrected_commit_date)
+				max_parent_corrected_commit_date = corrected_commit_date;
 
 			graph_parents = graph_parents->next;
 			odb_parents = odb_parents->next;
@@ -2451,20 +2470,12 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		if (generation_zero == GENERATION_ZERO_EXISTS)
 			continue;
 
-		/*
-		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
-		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
-		 * extra logic in the following condition.
-		 */
-		if (max_generation == GENERATION_NUMBER_MAX)
-			max_generation--;
-
-		generation = commit_graph_generation(graph_commit);
-		if (generation != max_generation + 1)
-			graph_report(_("commit-graph generation for commit %s is %u != %u"),
+		corrected_commit_date = commit_graph_generation(graph_commit);
+		if (corrected_commit_date < max_parent_corrected_commit_date + 1)
+			graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
 				     oid_to_hex(&cur_oid),
-				     generation,
-				     max_generation + 1);
+				     corrected_commit_date,
+				     max_parent_corrected_commit_date + 1);
 
 		if (graph_commit->date != odb_commit->date)
 			graph_report(_("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime),
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

