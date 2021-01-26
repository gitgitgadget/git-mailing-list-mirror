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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CDAC433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9492220B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404951AbhAZQGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404563AbhAZQCr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:47 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C8AC0698C7
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:42 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c128so3246029wme.2
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g54d1hmA9HIwJVQpYPG3GOux5lOAMXVYgzBb/0D3228=;
        b=Pa/E98WgKQV5ShCJmWoM6qwvsUOSZwwz4T1yIhINJgssIWsYBbkmPnCDyEXfpsPWbY
         IUwwhngHrqHWmA8R/c3RonlKuhudLkTjMrJ2e7jPjFqjHeL4sYKBLdlccFABhehjScSt
         tGYaBKM+jh1KjZY7FAsKugiPJwEAknWQvb0LUjl3jFgwlQPATzMIPVMkZbPNEeGJ9xx8
         pmlDrk6em8xXfo0miY0Hht4QBoLI68wmlNMkwtt3+sZfX15GVaAVf1DP2QWSxTnwpYOO
         APnpQjJZsnUgyGs8W5eM05ij1S71TzAy2eaOi+3o4eZ0/i2yI6UwNaYZ4+lLebxBnNw6
         F4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g54d1hmA9HIwJVQpYPG3GOux5lOAMXVYgzBb/0D3228=;
        b=DGY/p6v5Tl7gJVL0gUq2tg882+64ZJ2wrWgi2paA8/j8fYPVWTtLICqv7htp5KaFcg
         YJ6ZwIF6q7d0nXmuelGD3KOqgVOU0Do1X1dRrm5Z2O3Bg5xutBG6gVRZKJayXZcTnx2Y
         fYKtrogHQJUKUBL+Zrs1DzAFlcymfIOc529x+KzK7FkZpTO7qehwx5mAhm9672tNk/dt
         fuWVEJ72fe81zEdI002wciepi//6vAFigt0BAxwHbytilEae76RpiE8T70ahnlU186b6
         jf58+2AtXT7LvqibPwHYsmzfTWu80f7CiXn2e9g8vQgLvaITEB/70FjoDKYXQS7wkCw9
         pW0A==
X-Gm-Message-State: AOAM530KmJK4BnKhJWJvSV+lFzKIf1v8JHJOwdzMPy6uptMEMjoo43c7
        0dVU+hgoAitpjj0MCA9tJ8ftDwXFJ5k=
X-Google-Smtp-Source: ABdhPJzJfaO5xt3d8+luOstoZ3th1/bL4jVT1GNoOoHq1U+AP4jKAnc7qGY4gSE5iHZBcdC0oXBddA==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr343500wmd.157.1611676900537;
        Tue, 26 Jan 2021 08:01:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v4sm28924990wrw.42.2021.01.26.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:39 -0800 (PST)
Message-Id: <7339990f07db81897a30cb12e2d33ac1ef855d20.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:22 +0000
Subject: [PATCH 13/17] commit-graph: use chunk-format read API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Instead of parsing the table of contents directly, use the chunk-format
API methods read_table_of_contents() and pair_chunk(). While the current
implementation loses the duplicate-chunk detection, that will be added
in a future change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 209 ++++++++++++++++++++--------------------
 t/t5318-commit-graph.sh |   2 +-
 2 files changed, 108 insertions(+), 103 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b2c0f233eab..44c06d0fb67 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -299,15 +299,99 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	return 0;
 }
 
+static int graph_read_oid_fanout(const unsigned char *chunk_start,
+				 size_t chunk_size, void *data)
+{
+	struct commit_graph *g = (struct commit_graph *)data;
+	g->chunk_oid_fanout = (uint32_t*)chunk_start;
+	return 0;
+}
+
+static int graph_read_oid_lookup(const unsigned char *chunk_start,
+				 size_t chunk_size, void *data)
+{
+	struct commit_graph *g = (struct commit_graph *)data;
+	g->chunk_oid_lookup = chunk_start;
+	g->num_commits = chunk_size / g->hash_len;
+	return 0;
+}
+
+static int graph_read_data(const unsigned char *chunk_start,
+				 size_t chunk_size, void *data)
+{
+	struct commit_graph *g = (struct commit_graph *)data;
+	g->chunk_commit_data = chunk_start;
+	return 0;
+}
+
+static int graph_read_extra_edges(const unsigned char *chunk_start,
+				  size_t chunk_size, void *data)
+{
+	struct commit_graph *g = (struct commit_graph *)data;
+	g->chunk_extra_edges = chunk_start;
+	return 0;
+}
+
+static int graph_read_base_graphs(const unsigned char *chunk_start,
+				  size_t chunk_size, void *data)
+{
+	struct commit_graph *g = (struct commit_graph *)data;
+	g->chunk_base_graphs = chunk_start;
+	return 0;
+}
+
+static int graph_read_generation_data(const unsigned char *chunk_start,
+				      size_t chunk_size, void *data)
+{
+	struct commit_graph *g = (struct commit_graph *)data;
+	g->chunk_generation_data = chunk_start;
+	return 0;
+}
+
+static int graph_read_generation_overflow(const unsigned char *chunk_start,
+					  size_t chunk_size, void *data)
+{
+	struct commit_graph *g = (struct commit_graph *)data;
+	g->chunk_generation_data_overflow = chunk_start;
+	return 0;
+}
+
+static int graph_read_bloom_indices(const unsigned char *chunk_start,
+				    size_t chunk_size, void *data)
+{
+	struct commit_graph *g = (struct commit_graph *)data;
+	g->chunk_bloom_indexes = chunk_start;
+	return 0;
+}
+
+static int graph_read_bloom_data(const unsigned char *chunk_start,
+				  size_t chunk_size, void *data)
+{
+	struct commit_graph *g = (struct commit_graph *)data;
+	uint32_t hash_version;
+	g->chunk_bloom_data = chunk_start;
+	hash_version = get_be32(chunk_start);
+
+	if (hash_version != 1)
+		return 0;
+
+	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
+	g->bloom_filter_settings->hash_version = hash_version;
+	g->bloom_filter_settings->num_hashes = get_be32(chunk_start + 4);
+	g->bloom_filter_settings->bits_per_entry = get_be32(chunk_start + 8);
+	g->bloom_filter_settings->max_changed_paths = DEFAULT_BLOOM_MAX_CHANGES;
+
+	return 0;
+}
+
 struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size)
 {
-	const unsigned char *data, *chunk_lookup;
-	uint32_t i;
+	const unsigned char *data;
 	struct commit_graph *graph;
-	uint64_t next_chunk_offset;
 	uint32_t graph_signature;
 	unsigned char graph_version, hash_version;
+	struct chunkfile *cf = NULL;
 
 	if (!graph_map)
 		return NULL;
@@ -356,108 +440,27 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 		return NULL;
 	}
 
-	chunk_lookup = data + 8;
-	next_chunk_offset = get_be64(chunk_lookup + 4);
-	for (i = 0; i < graph->num_chunks; i++) {
-		uint32_t chunk_id;
-		uint64_t chunk_offset = next_chunk_offset;
-		int chunk_repeated = 0;
-
-		chunk_id = get_be32(chunk_lookup + 0);
-
-		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
-		next_chunk_offset = get_be64(chunk_lookup + 4);
-
-		if (chunk_offset > graph_size - the_hash_algo->rawsz) {
-			error(_("commit-graph improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
-			      (uint32_t)chunk_offset);
-			goto free_and_return;
-		}
-
-		switch (chunk_id) {
-		case GRAPH_CHUNKID_OIDFANOUT:
-			if (graph->chunk_oid_fanout)
-				chunk_repeated = 1;
-			else
-				graph->chunk_oid_fanout = (uint32_t*)(data + chunk_offset);
-			break;
-
-		case GRAPH_CHUNKID_OIDLOOKUP:
-			if (graph->chunk_oid_lookup)
-				chunk_repeated = 1;
-			else {
-				graph->chunk_oid_lookup = data + chunk_offset;
-				graph->num_commits = (next_chunk_offset - chunk_offset)
-						     / graph->hash_len;
-			}
-			break;
-
-		case GRAPH_CHUNKID_DATA:
-			if (graph->chunk_commit_data)
-				chunk_repeated = 1;
-			else
-				graph->chunk_commit_data = data + chunk_offset;
-			break;
-
-		case GRAPH_CHUNKID_GENERATION_DATA:
-			if (graph->chunk_generation_data)
-				chunk_repeated = 1;
-			else
-				graph->chunk_generation_data = data + chunk_offset;
-			break;
+	cf = init_chunkfile(NULL);
 
-		case GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW:
-			if (graph->chunk_generation_data_overflow)
-				chunk_repeated = 1;
-			else
-				graph->chunk_generation_data_overflow = data + chunk_offset;
-			break;
-
-		case GRAPH_CHUNKID_EXTRAEDGES:
-			if (graph->chunk_extra_edges)
-				chunk_repeated = 1;
-			else
-				graph->chunk_extra_edges = data + chunk_offset;
-			break;
-
-		case GRAPH_CHUNKID_BASE:
-			if (graph->chunk_base_graphs)
-				chunk_repeated = 1;
-			else
-				graph->chunk_base_graphs = data + chunk_offset;
-			break;
-
-		case GRAPH_CHUNKID_BLOOMINDEXES:
-			if (graph->chunk_bloom_indexes)
-				chunk_repeated = 1;
-			else if (r->settings.commit_graph_read_changed_paths)
-				graph->chunk_bloom_indexes = data + chunk_offset;
-			break;
-
-		case GRAPH_CHUNKID_BLOOMDATA:
-			if (graph->chunk_bloom_data)
-				chunk_repeated = 1;
-			else if (r->settings.commit_graph_read_changed_paths) {
-				uint32_t hash_version;
-				graph->chunk_bloom_data = data + chunk_offset;
-				hash_version = get_be32(data + chunk_offset);
-
-				if (hash_version != 1)
-					break;
+	if (read_table_of_contents(cf, graph->data, graph_size,
+				   GRAPH_HEADER_SIZE, graph->num_chunks))
+		goto free_and_return;
 
-				graph->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
-				graph->bloom_filter_settings->hash_version = hash_version;
-				graph->bloom_filter_settings->num_hashes = get_be32(data + chunk_offset + 4);
-				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
-				graph->bloom_filter_settings->max_changed_paths = DEFAULT_BLOOM_MAX_CHANGES;
-			}
-			break;
-		}
+	pair_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph);
+	pair_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
+	pair_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_data, graph);
+	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, graph_read_extra_edges, graph);
+	pair_chunk(cf, GRAPH_CHUNKID_BASE, graph_read_base_graphs, graph);
+	pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
+		   graph_read_generation_data, graph);
+	pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
+		   graph_read_generation_overflow, graph);
 
-		if (chunk_repeated) {
-			error(_("commit-graph chunk id %08x appears multiple times"), chunk_id);
-			goto free_and_return;
-		}
+	if (r->settings.commit_graph_read_changed_paths) {
+		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
+			   graph_read_bloom_indices, graph);
+		pair_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
+			   graph_read_bloom_data, graph);
 	}
 
 	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
@@ -474,9 +477,11 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 	if (verify_commit_graph_lite(graph))
 		goto free_and_return;
 
+	free_chunkfile(cf);
 	return graph;
 
 free_and_return:
+	free_chunkfile(cf);
 	free(graph->bloom_filter_settings);
 	free(graph);
 	return NULL;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index fa27df579a5..c7da741284e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -564,7 +564,7 @@ test_expect_success 'detect bad hash version' '
 
 test_expect_success 'detect low chunk count' '
 	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\01" \
-		"missing the .* chunk"
+		"final chunk has non-zero id"
 '
 
 test_expect_success 'detect missing OID fanout chunk' '
-- 
gitgitgadget

