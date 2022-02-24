Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D778EC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 20:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiBXUj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbiBXUjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 15:39:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E60C179A2E
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s13so1446635wrb.6
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2lfdbTb1AAzLaTbrjMtrUcUXS6b8cJjnDeEf/T3l0rk=;
        b=hWYjZ0dpe3yfKoiAfHyU2w22URYcFvHmorxJ6s8wJpmT1B3xKhq1ixAqJYWEUDwyje
         oiKWXdqWVdztLpz4pUbPz1SCrNYF6J5K2DJXi066D02Gl4C2BPguGGYIs5SAvYtVlZ66
         STfnsDHwJd/kiZILFnKZUwgrnN4VJ0BNUlnjjLKilmalBO1CHmxjqrbkJb/py8IfovuJ
         1c7jwSRsFK96ko6T7C85T1otyBqvBdwfLaXaAv4Bi6WiKbbvu4xmIGAcMlFQBVLleyIG
         Q4uTOB5EyW8Hb8X+3u0om4mRLEgxtfdSOWGP26/5cFjxmaGHzpVyxpCd96AzCaBWOVTk
         FBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2lfdbTb1AAzLaTbrjMtrUcUXS6b8cJjnDeEf/T3l0rk=;
        b=DDO4kUN8Io+pz75NOVc3CqqFtCzfaZRBI8oDXFnNXpERsMCdWNXnEHh8nKvDgTWJT2
         Q7kKKrvOB4Xi4nIGtluKw50iWte7dBDuxW5qqvS9nDqAOc3/k4FJzbbi3c/JQVVU5yxy
         v1OwUwAshvB4rxtmHRjfGCQtFNM6Zkmiof8rxbl/faJlqm5cuqk3G+evVsU0wv7IlD0/
         rE1P/ypHbfyO/zZYlujtMjzP4QP4pHd7Xw6z4yjF7VxQ/fOWYBO3VdsN/5CZpbdvyqOv
         UNX6WUgWUs2VjkHHkRW/VSsnam94Gwtha+KWV1MGGWiRKZbGa1ddHOtCETwJNQTA9RVM
         EncA==
X-Gm-Message-State: AOAM532mUdAI4+Quv4D5pciahZm+L2iL0c6pABrjoGZfttq8d3Fm2rRr
        pcn3lz9FF/LmUsmkxGs3MEhUFDlWvtY=
X-Google-Smtp-Source: ABdhPJwcU6P7JAlKQq0sr6T1menP9OkV+8g3UA8s76sDECJ1qlbRdUkG+UMJQDpaHiqYXD9b2LMx7g==
X-Received: by 2002:adf:f988:0:b0:1ee:c6e9:1fb2 with SMTP id f8-20020adff988000000b001eec6e91fb2mr2218703wrr.696.1645735122976;
        Thu, 24 Feb 2022 12:38:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f21-20020a5d58f5000000b001ea99c3397dsm390582wrd.21.2022.02.24.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:38:42 -0800 (PST)
Message-Id: <28fe8824ba71ff9cda5ec5c034b6a6fb3c857654.1645735117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 20:38:35 +0000
Subject: [PATCH 6/7] commit-graph: parse file format v2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The commit-graph file format v2 alters how it stores the corrected
commit date offsets within the Commit Data chunk instead of a separate
chunk. The idea is to significantly reduce the amount of data loaded
from disk while parsing the commit-graph.

We need to alter the error message when we see a file format version
outside of our range now that multiple are possible. This has a
non-functional side-effect of altering a use of GRAPH_VERSION within
write_commit_graph().

By storing the file format version in 'struct commit_graph', we can
alter the parsing code to depend on that version value. This involves
changing where we look for the corrected commit date offset, but also
which constants we use for jumping into the Generation Data Overflow
chunk. The Commit Data chunk only has 30 bits available for the offset
while the Generation Data chunk has 32 bits. This only makes a
meaningful difference in very malformed repositories.

Also, we need to be careful about how we enable using corrected commit
dates and generation numbers to rely upon the read_generation_data value
instead of a non-zero value in the Commit Date chunk. In
generation_numbers_enabled(), the first_generation variable is
attemptint to look for the first topological level stored to see that it
is nonzero. However, for a v2 commit-graph, this value is actually
likely to be zero because the corrected commit date offset is probably
zero.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c          | 43 +++++++++++++++++++++++++++++------------
 commit-graph.h          |  6 ++++++
 t/t5318-commit-graph.sh |  2 +-
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b86a6a634fe..366fc4d6e41 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -49,7 +49,9 @@ void git_test_write_commit_graph_or_die(void)
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
 #define GRAPH_VERSION_1 0x1
-#define GRAPH_VERSION GRAPH_VERSION_1
+#define GRAPH_VERSION_2 0x2
+#define GRAPH_VERSION_MIN GRAPH_VERSION_1
+#define GRAPH_VERSION_MAX GRAPH_VERSION_2
 
 #define GRAPH_EXTRA_EDGES_NEEDED 0x80000000
 #define GRAPH_EDGE_LAST_MASK 0x7fffffff
@@ -63,6 +65,7 @@ void git_test_write_commit_graph_or_die(void)
 			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
 
 #define CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW (1ULL << 31)
+#define CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW_V3 (1ULL << 29)
 
 /* Remember to update object flag allocation in object.h */
 #define REACHABLE       (1u<<15)
@@ -358,9 +361,10 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
-	if (graph_version != GRAPH_VERSION) {
-		error(_("commit-graph version %X does not match version %X"),
-		      graph_version, GRAPH_VERSION);
+	if (graph_version < GRAPH_VERSION_MIN ||
+	    graph_version > GRAPH_VERSION_MAX) {
+		error(_("commit-graph version %X is not understood"),
+		      graph_version);
 		return NULL;
 	}
 
@@ -375,6 +379,7 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 
 	graph = alloc_commit_graph();
 
+	graph->version = graph_version;
 	graph->hash_len = the_hash_algo->rawsz;
 	graph->num_chunks = *(unsigned char*)(data + 6);
 	graph->data = graph_map;
@@ -402,13 +407,17 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
 	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
 
-	if (get_configured_generation_version(r) >= 2) {
-		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
-			&graph->chunk_generation_data);
+	if (graph_version >= GRAPH_VERSION_2 ||
+	    get_configured_generation_version(r) >= 2) {
+		/* Skip this chunk if GRAPH_VERSION_2 or higher. */
+		if (graph_version == GRAPH_VERSION_1)
+			pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
+				   &graph->chunk_generation_data);
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
 			&graph->chunk_generation_data_overflow);
 
-		if (graph->chunk_generation_data)
+		if (graph_version >= GRAPH_VERSION_2 ||
+		    graph->chunk_generation_data)
 			graph->read_generation_data = 1;
 	}
 
@@ -683,6 +692,9 @@ int generation_numbers_enabled(struct repository *r)
 	if (!g->num_commits)
 		return 0;
 
+	if (g->version >= GRAPH_VERSION_2)
+		return g->read_generation_data;
+
 	first_generation = get_be32(g->chunk_commit_data +
 				    g->hash_len + 8) >> 2;
 
@@ -799,13 +811,20 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
 	if (g->read_generation_data) {
-		offset = (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
+		timestamp_t overflow_bit;
+		if (g->version == GRAPH_VERSION_2) {
+			offset = (timestamp_t)(get_be32(commit_data + g->hash_len + 8) >> 2);
+			overflow_bit = CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW_V3;
+		} else {
+			offset = (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
+			overflow_bit = CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
+		}
 
-		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
+		if (offset & overflow_bit) {
 			if (!g->chunk_generation_data_overflow)
 				die(_("commit-graph requires overflow generation data but has none"));
 
-			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
+			offset_pos = offset ^ overflow_bit;
 			graph_data->generation = item->date + get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
 		} else
 			graph_data->generation = item->date + offset;
@@ -1917,7 +1936,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
-	hashwrite_u8(f, GRAPH_VERSION);
+	hashwrite_u8(f, GRAPH_VERSION_1);
 	hashwrite_u8(f, oid_version());
 	hashwrite_u8(f, get_num_chunks(cf));
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
diff --git a/commit-graph.h b/commit-graph.h
index 04a94e18302..b379b8eae25 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -63,6 +63,12 @@ struct commit_graph {
 	const unsigned char *data;
 	size_t data_len;
 
+	/**
+	 * The 'version' byte mirrors the file format version. This is
+	 * necessary to consider when parsing commits.
+	 */
+	unsigned version;
+
 	unsigned char hash_len;
 	unsigned char num_chunks;
 	uint32_t num_commits;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 5e4b0216fa6..a14a13e5f7b 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -605,7 +605,7 @@ test_expect_success 'detect bad signature' '
 '
 
 test_expect_success 'detect bad version' '
-	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
+	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\03" \
 		"graph version"
 '
 
-- 
gitgitgadget

