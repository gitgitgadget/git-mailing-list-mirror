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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89384C433E9
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FAC61492
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhBEWQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhBEOeB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:34:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC0FC06178B
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:11:59 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w4so6448121wmi.4
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=69vd5Y2CPpd1hYEmKNSzHwI+erEl0uQVGxpZhdzj/sc=;
        b=G6yFjBQWoWJWPQ+dp8nllKn195T1jwhSBznM9Bd4o21WZxvMhIWlNMQoL6joQg5ojL
         WH98+joT7ctmEX9gmXnzLVw5+8rx3DjwnpovJQI3ZDOisKNLnwYnGkmtD6yMl9L2ah+B
         XcAzRlhbbA3Uo4d6WJpI6clLZjywHsxvJtjSXIEbHlyY/mcgFXhiKZAnOT5AwFXLKH8t
         EuGrO+HZO4a3j8SHSvR96fZ0/6oS6+AUuXVIxsauQzkZsSnDyd84nbOHUHOnWn/pcFMJ
         Z9g2rdFMeRklk319YhUjELQyJsscT6F5SwKyJRaHZVvD6Ab4C78ipkdbxCa74H1uTEwY
         GRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=69vd5Y2CPpd1hYEmKNSzHwI+erEl0uQVGxpZhdzj/sc=;
        b=dRYHdukH7Qq+UELYQ/w5Shiasm/Q5S9UZ30PxNj9WkCtr1vFLFOGdcdbl5YKAZN1+c
         zGDZbXQVYmC5JXFI69IcC+LMvYEPodhE17l6douprvMlTt8rtGhgyR2Xko1VfQ/pw6/Y
         VTbxboKG4QUM1SKQ/RjMuUy8VTZxYTq4TJLHqNFLjqUx0qvN0v2GDxWlraQPHPuEOZHz
         8cvQAer+GTxdgQALu6O5zfl9Pb4r7wAodBUnqIzR4e4s7ecjT/gaS9JzkCm7Dvu9RaX6
         WwwY3I8iKyO52jW+xk8BIZlXxebR6vukYY6i8J/efOMoPcqbpMxda5it8mKpJm5WFmpq
         Q3Vw==
X-Gm-Message-State: AOAM5330WHWNZB2/fIL4sC6/Jyv8WZXbmca3NPZo/2ta548QEHUDD78/
        xHMhpL+u/IkwTYuqmLGpN8Qnr6iPg6c=
X-Google-Smtp-Source: ABdhPJz3e7Ftrjq4DHzAE06XWLhmDPfmMOxd387fUzHqf1T5+I5SmlyvcollKK05zckJu0vBXgOf2w==
X-Received: by 2002:a7b:cf33:: with SMTP id m19mr3865297wmg.53.1612535467891;
        Fri, 05 Feb 2021 06:31:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm8619315wmj.40.2021.02.05.06.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:31:07 -0800 (PST)
Message-Id: <7838ad32e2e0b2e5941f5027d873f2453e08f7cb.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:48 +0000
Subject: [PATCH v3 13/17] commit-graph: use chunk-format read API
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
index 7c607d23b29f..32cf5091d2fb 100644
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
index fa27df579a57..c7da741284e5 100755
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

