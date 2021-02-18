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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EC3C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A4064EAD
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhBRQx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhBROKo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:10:44 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E07FC06121D
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n10so4085354wmq.0
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vzmS8yzoSmi05koRWtYpOHFxzzJ97VIl5onOob4HIG8=;
        b=oTt7/7fqFkLr6R3w9lNgVmOxDFXEm3LovTIHeKIsmZ3Jgmtb2/QoH1XlYIdnB9Zoil
         8FwqepURG9jCpFP44XpSzmYiYoXcEu4YbmgmzrfZvC4nTwR//jimvy0qK/4Mk3r0HZ19
         ykbHIBfKuKu/g77kqcTUN45Mc+qireQx+p7s4VSzUS+fMsGv0ESnKh5lsoiRngHQ9ALW
         /t3dgon4bJDKlhACDShg8rTgKMPnbMIJCbnFl7EKd3n4MR8rNe1ezbnesd/5KUbRy3o2
         67PsIFAOojOW0qeDD+HutLiOv6mbUup5ZttvR1hJAtgqO4KITxbyey+LbIjcAvlSMbIa
         ssEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vzmS8yzoSmi05koRWtYpOHFxzzJ97VIl5onOob4HIG8=;
        b=lC6QkAcZJw92B3cIv2wGziy9Isx29W0KzWbidaO8RzbDxMzw5vyfWydFulmEGwY7uT
         hpKc4lQvfiR7jK0O/Y+9llvqtyHUonAH96Ol6ABoWhUVndnHn5+1oCkyJgyisqlzhNcD
         +BR2uOBLtMB/4s8EqsC/K7WVWf1wbQF5ah7os/qc/pFnOPGS6RQXrcwTnQ0kbV7tkkyU
         q8FH46mh9X6pr7rFP57sCT94jIMTRkZ18wCwx30fW8D8u+qz4Lum0f1HrOWEAtFA4Bbm
         ek2NOYw+Qny0SJs5uC04YhscngF1kqVvcO//knS6jsUsc9wrOLSFZB5Ouvhl6pdNZWWs
         gIyg==
X-Gm-Message-State: AOAM531146Op2ypj6qu2jUA8+UoDow//9wC195LQGdlGqvuebhvwENId
        v1PHb3LTAlVBDKrAuv23Ndkgbz7Ennc=
X-Google-Smtp-Source: ABdhPJwxZsMNHXHJ6COoWtzC9qomKiH5Iyhgjrr6LpCzHFRP/PHDKmooC0Ats14MRb+UeK7HQwYY+w==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr3766857wmb.33.1613657275307;
        Thu, 18 Feb 2021 06:07:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm7582451wmh.38.2021.02.18.06.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:54 -0800 (PST)
Message-Id: <87f441fc5e154c95494f3f1219fb0e0c7d9b3244.1613657259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:35 +0000
Subject: [PATCH v4 13/17] commit-graph: use chunk-format read API
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
 commit-graph.c          | 159 ++++++++++++++--------------------------
 t/t5318-commit-graph.sh |   2 +-
 2 files changed, 55 insertions(+), 106 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a889130cc849..76514a879e88 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -59,8 +59,7 @@ void git_test_write_commit_graph_or_die(void)
 
 #define GRAPH_HEADER_SIZE 8
 #define GRAPH_FANOUT_SIZE (4 * 256)
-#define GRAPH_CHUNKLOOKUP_WIDTH 12
-#define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
+#define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * CHUNK_TOC_ENTRY_SIZE \
 			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
 
 #define CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW (1ULL << 31)
@@ -298,15 +297,43 @@ static int verify_commit_graph_lite(struct commit_graph *g)
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
@@ -347,7 +374,7 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 	graph->data_len = graph_size;
 
 	if (graph_size < GRAPH_HEADER_SIZE +
-			 (graph->num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH +
+			 (graph->num_chunks + 1) * CHUNK_TOC_ENTRY_SIZE +
 			 GRAPH_FANOUT_SIZE + the_hash_algo->rawsz) {
 		error(_("commit-graph file is too small to hold %u chunks"),
 		      graph->num_chunks);
@@ -355,108 +382,28 @@ struct commit_graph *parse_commit_graph(struct repository *r,
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
@@ -473,9 +420,11 @@ struct commit_graph *parse_commit_graph(struct repository *r,
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

