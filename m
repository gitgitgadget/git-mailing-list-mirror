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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E7AC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CE3207D0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhA0PfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbhA0PE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:04:28 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A482FC061220
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:13 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j18so1799738wmi.3
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q5wWfy5oAGCO35mqYvKAtPhcZckzIut3LhnPNj7ZkDQ=;
        b=sfJma4y/tIH88XqZJyxqbKxuofXKtn5ldLfm2V6NrlP/pMx2y9iNw41VRJWSl7so6j
         6+UZ0mfzetbN6EH39T/B9xyZ9luweTYS/Y209e72tGbXgM8JjIv/VMwaU8jcIJniefPr
         7TfGdhP6c3MRaZPlLNYQQDV1+l77a32iHtOXRq1DkuZq1rJv3F7YQpaALu7gyqQuRF+o
         LEEijkk17g8ubXfqryjHxoFoxt7/qpFPKlC7kZfgaA8SSt5uOMr6m8t3Kv6HDTTC6wjk
         UL1bCjwgdz2q/NUkqaTglToodOSao98MDv+Nj+Upv14PrKXVjTDO9OKrwSzyUYUj076A
         re3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q5wWfy5oAGCO35mqYvKAtPhcZckzIut3LhnPNj7ZkDQ=;
        b=ugjkWVa9/FWb8bo7fdKQpJ1tEPvMs/m9Wv1VvoTnaxFwzyiaje/xDF6KrCiIBB7ARc
         Xg+zihDBvP9BIbvPO3TEtTtAVIsI9lYLiEfwlJYa95BmDep7zp0FZMKbNi1aTRAfWyZ8
         MHXT7pTLcjCTK/rF5K66yGMUnlapAun66X/KszuvE8jC+rjPhP3WFiD+b152mLOTNPNF
         qI8Gr667RtHZXn+GKXh+wqS3VTptRdeSoMBN5d6h+NZtxnohH+FyqFi4N2+6r2uKnsZG
         WVOLKXzyT9+eh4Ygb8vdU7ZePOEd5Exgbt5w5PRUJt+sqBcBEq6C3K7y2B6lrXjdyD3T
         pnnA==
X-Gm-Message-State: AOAM5316wNs87l0h8xneCRfPi2++kj1kjsQ4k6CnoOMbFqRZycPNZTrg
        u9muwtMw65r4+r5/pcScY24hFOxNmx4=
X-Google-Smtp-Source: ABdhPJz+16SZBofhvFgIx3HyaLl12q3AgyBm1PYDP72wO4gnvDf4atXRmyIGkOfSiP5eR1J95hF7dQ==
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr4536280wmj.161.1611759732107;
        Wed, 27 Jan 2021 07:02:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm3276008wrt.85.2021.01.27.07.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:11 -0800 (PST)
Message-Id: <8744d2785965773a2b561e9e1e91170530d052b1.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:52 +0000
Subject: [PATCH v2 13/17] commit-graph: use chunk-format read API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
 commit-graph.c          | 154 ++++++++++++++--------------------------
 t/t5318-commit-graph.sh |   2 +-
 2 files changed, 53 insertions(+), 103 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index ba33777dcb8..8aa4881d85d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -299,15 +299,43 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	return 0;
 }
 
+static int graph_read_oid_lookup(const unsigned char *chunk_start,
+				 size_t chunk_size, void *data)
+{
+	struct commit_graph *g = data;
+	g->chunk_oid_lookup = chunk_start;
+	g->num_commits = chunk_size / g->hash_len;
+	return 0;
+}
+
+static int graph_read_bloom_data(const unsigned char *chunk_start,
+				  size_t chunk_size, void *data)
+{
+	struct commit_graph *g = data;
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
@@ -356,108 +384,28 @@ struct commit_graph *parse_commit_graph(struct repository *r,
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
+	cf = init_chunkfile(NULL);
 
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
-
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
+	pair_chunk(cf, GRAPH_CHUNKID_OIDFANOUT,
+		   (const unsigned char **)&graph->chunk_oid_fanout);
+	read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
+	pair_chunk(cf, GRAPH_CHUNKID_DATA, &graph->chunk_commit_data);
+	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
+	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
+	pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
+		   &graph->chunk_generation_data);
+	pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
+		   &graph->chunk_generation_data_overflow);
 
-		if (chunk_repeated) {
-			error(_("commit-graph chunk id %08x appears multiple times"), chunk_id);
-			goto free_and_return;
-		}
+	if (r->settings.commit_graph_read_changed_paths) {
+		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
+			   &graph->chunk_bloom_indexes);
+		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
+			   graph_read_bloom_data, graph);
 	}
 
 	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
@@ -474,9 +422,11 @@ struct commit_graph *parse_commit_graph(struct repository *r,
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

