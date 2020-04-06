Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3024C2BB55
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA6B21841
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixCdnDU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgDFRAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42309 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbgDFRAH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id cw6so346067edb.9
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RzDq0RVy9u/llzNNfsL9IhgF26sWW+4SNXyurg5TCzc=;
        b=ixCdnDU/PksEXMyv3ow9sIsu4O62AvAzHFr7K/FjvVHd+X72vGpqu6GzQrl5IeIcba
         lVPDtxrAqYRogFKNQLLVQgLI/Lx5kaYOJ0/KMcwE83DMenMXrZCRFq3VF87WPkC45pMF
         LzpGlDw8MW1+f9tvbfu8jumw2iGH5u52lGaDnnZlli7N3BwrFeb7jNSwZyOObVklbno8
         TJsvNWrZH9/BCCJgp3/y9athMluUhOt6Q5121n6S9X6YNEafiA7BTua8P2/4lIiUbMOB
         cPCJ2rH2fjPJNi5HsnDhnuJnkMOCW/lGmpEDVSYukXWWTEEW7l9c4XLNnBka2LmB1LHU
         vdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RzDq0RVy9u/llzNNfsL9IhgF26sWW+4SNXyurg5TCzc=;
        b=TUn9VvtnvZK7WZGi//1nnjPTHXqrWrq5U+RDroC7YEL4iBV1djpX1EfUGi/h1oAoLU
         ls0RUWnpAz9y3+sADUmHCTOeiptFR7DxIJFuEzQrPyVDnz8y81iI7M7aOYg9Y6XzdtDU
         Lh4PPR1QzW5amaUkfEY8CYHzLeYvFQ4/2339HQHa4zc2ZTz+6FbqXw1+DckfqIxcUu3c
         +eKTe9ZARQIJAnQ20ZLijSjICQzv0XNsv2BPFIr+PU8m4d0pwKXpeTdYIccY3hmDeFE7
         HTyAleHr4zIc8u8aPjxYkSfM5a3eYFGNsoljw0axIM0IxLmH3AzlVa24tBMqIeZHiA4H
         +lAw==
X-Gm-Message-State: AGi0Pua9Or6hp+joXYif2Zo4sqRUlBdEiBXVK/GYlEDaQ7smt925im/E
        zxgMdqgKB8lDVB99fk65i7OPsKi1
X-Google-Smtp-Source: APiQypLyIUg2FeOkF8J5NDUhqP2pzIWPlqrS1p2AwxH9dtTlIXWvIEdYPn18NYJzRdLbxggMaqm8Zw==
X-Received: by 2002:a50:9dc4:: with SMTP id l4mr20448726edk.234.1586192403670;
        Mon, 06 Apr 2020 10:00:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k19sm837342eds.32.2020.04.06.10.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:00:03 -0700 (PDT)
Message-Id: <ff6b96aad1e2317d3ed36c2c8b419905dea84a83.1586192395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:49 +0000
Subject: [PATCH v4 09/15] commit-graph: write Bloom filters to commit graph
 file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Update the technical documentation for commit-graph-format with
the formats for the Bloom filter index (BIDX) and Bloom filter
data (BDAT) chunks. Write the computed Bloom filters information
to the commit graph file using this format.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 .../technical/commit-graph-format.txt         |  30 +++++
 commit-graph.c                                | 113 +++++++++++++++++-
 commit-graph.h                                |   5 +
 3 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index a4f17441aed..de56f9f1efd 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -17,6 +17,9 @@ metadata, including:
 - The parents of the commit, stored using positional references within
   the graph file.
 
+- The Bloom filter of the commit carrying the paths that were changed between
+  the commit and its first parent, if requested.
+
 These positional references are stored as unsigned 32-bit integers
 corresponding to the array position within the list of commit OIDs. Due
 to some special constants we use to track parents, we can store at most
@@ -93,6 +96,33 @@ CHUNK DATA:
       positions for the parents until reaching a value with the most-significant
       bit on. The other bits correspond to the position of the last parent.
 
+  Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
+    * The ith entry, BIDX[i], stores the number of 8-byte word blocks in all
+      Bloom filters from commit 0 to commit i (inclusive) in lexicographic
+      order. The Bloom filter for the i-th commit spans from BIDX[i-1] to
+      BIDX[i] (plus header length), where BIDX[-1] is 0.
+    * The BIDX chunk is ignored if the BDAT chunk is not present.
+
+  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
+    * It starts with header consisting of three unsigned 32-bit integers:
+      - Version of the hash algorithm being used. We currently only support
+	value 1 which corresponds to the 32-bit version of the murmur3 hash
+	implemented exactly as described in
+	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
+	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
+	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
+	in Probabilistic Verification"
+      - The number of times a path is hashed and hence the number of bit positions
+	      that cumulatively determine whether a file is present in the commit.
+      - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
+	      contains 'n' entries, then the filter size is the minimum number of 64-bit
+	      words that contain n*b bits.
+    * The rest of the chunk is the concatenation of all the computed Bloom
+      filters for the commits in lexicographic order.
+    * Note: Commits with no changes or more than 512 changes have Bloom filters
+      of length zero.
+    * The BDAT chunk is present if and only if BIDX is present.
+
   Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
       This list of H-byte hashes describe a set of B commit-graph files that
       form a commit-graph chain. The graph position for the ith commit in this
diff --git a/commit-graph.c b/commit-graph.c
index 732c81fa1b2..a8b6b5cca5d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -24,8 +24,10 @@
 #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
+#define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
+#define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
-#define MAX_NUM_CHUNKS 5
+#define MAX_NUM_CHUNKS 7
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -319,6 +321,32 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 				chunk_repeated = 1;
 			else
 				graph->chunk_base_graphs = data + chunk_offset;
+			break;
+
+		case GRAPH_CHUNKID_BLOOMINDEXES:
+			if (graph->chunk_bloom_indexes)
+				chunk_repeated = 1;
+			else
+				graph->chunk_bloom_indexes = data + chunk_offset;
+			break;
+
+		case GRAPH_CHUNKID_BLOOMDATA:
+			if (graph->chunk_bloom_data)
+				chunk_repeated = 1;
+			else {
+				uint32_t hash_version;
+				graph->chunk_bloom_data = data + chunk_offset;
+				hash_version = get_be32(data + chunk_offset);
+
+				if (hash_version != 1)
+					break;
+
+				graph->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
+				graph->bloom_filter_settings->hash_version = hash_version;
+				graph->bloom_filter_settings->num_hashes = get_be32(data + chunk_offset + 4);
+				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
+			}
+			break;
 		}
 
 		if (chunk_repeated) {
@@ -337,6 +365,15 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		last_chunk_offset = chunk_offset;
 	}
 
+	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
+		init_bloom_filters();
+	} else {
+		/* We need both the bloom chunks to exist together. Else ignore the data */
+		graph->chunk_bloom_indexes = NULL;
+		graph->chunk_bloom_data = NULL;
+		graph->bloom_filter_settings = NULL;
+	}
+
 	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
 
 	if (verify_commit_graph_lite(graph)) {
@@ -1034,6 +1071,59 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 	}
 }
 
+static void write_graph_chunk_bloom_indexes(struct hashfile *f,
+					    struct write_commit_graph_context *ctx)
+{
+	struct commit **list = ctx->commits.list;
+	struct commit **last = ctx->commits.list + ctx->commits.nr;
+	uint32_t cur_pos = 0;
+	struct progress *progress = NULL;
+	int i = 0;
+
+	if (ctx->report_progress)
+		progress = start_delayed_progress(
+			_("Writing changed paths Bloom filters index"),
+			ctx->commits.nr);
+
+	while (list < last) {
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
+		cur_pos += filter->len;
+		display_progress(progress, ++i);
+		hashwrite_be32(f, cur_pos);
+		list++;
+	}
+
+	stop_progress(&progress);
+}
+
+static void write_graph_chunk_bloom_data(struct hashfile *f,
+					 struct write_commit_graph_context *ctx,
+					 const struct bloom_filter_settings *settings)
+{
+	struct commit **list = ctx->commits.list;
+	struct commit **last = ctx->commits.list + ctx->commits.nr;
+	struct progress *progress = NULL;
+	int i = 0;
+
+	if (ctx->report_progress)
+		progress = start_delayed_progress(
+			_("Writing changed paths Bloom filters data"),
+			ctx->commits.nr);
+
+	hashwrite_be32(f, settings->hash_version);
+	hashwrite_be32(f, settings->num_hashes);
+	hashwrite_be32(f, settings->bits_per_entry);
+
+	while (list < last) {
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
+		display_progress(progress, ++i);
+		hashwrite(f, filter->data, filter->len * sizeof(unsigned char));
+		list++;
+	}
+
+	stop_progress(&progress);
+}
+
 static int oid_compare(const void *_a, const void *_b)
 {
 	const struct object_id *a = (const struct object_id *)_a;
@@ -1438,6 +1528,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = 3;
 	struct object_id file_hash;
+	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 	if (ctx->split) {
 		struct strbuf tmp_file = STRBUF_INIT;
@@ -1482,6 +1573,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
 		num_chunks++;
 	}
+	if (ctx->changed_paths) {
+		chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMINDEXES;
+		num_chunks++;
+		chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMDATA;
+		num_chunks++;
+	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_BASE;
 		num_chunks++;
@@ -1500,6 +1597,15 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 						4 * ctx->num_extra_edges;
 		num_chunks++;
 	}
+	if (ctx->changed_paths) {
+		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
+						sizeof(uint32_t) * ctx->commits.nr;
+		num_chunks++;
+
+		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
+						sizeof(uint32_t) * 3 + ctx->total_bloom_filter_data_size;
+		num_chunks++;
+	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
 						hashsz * (ctx->num_commit_graphs_after - 1);
@@ -1537,6 +1643,10 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	write_graph_chunk_data(f, hashsz, ctx);
 	if (ctx->num_extra_edges)
 		write_graph_chunk_extra_edges(f, ctx);
+	if (ctx->changed_paths) {
+		write_graph_chunk_bloom_indexes(f, ctx);
+		write_graph_chunk_bloom_data(f, ctx, &bloom_settings);
+	}
 	if (ctx->num_commit_graphs_after > 1 &&
 	    write_graph_chunk_base(f, ctx)) {
 		return -1;
@@ -2184,6 +2294,7 @@ void free_commit_graph(struct commit_graph *g)
 		close(g->graph_fd);
 	}
 	free(g->filename);
+	free(g->bloom_filter_settings);
 	free(g);
 }
 
diff --git a/commit-graph.h b/commit-graph.h
index 86be81219da..8e7a8e0e5b2 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -11,6 +11,7 @@
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
 
 struct commit;
+struct bloom_filter_settings;
 
 char *get_commit_graph_filename(struct object_directory *odb);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
@@ -59,6 +60,10 @@ struct commit_graph {
 	const unsigned char *chunk_commit_data;
 	const unsigned char *chunk_extra_edges;
 	const unsigned char *chunk_base_graphs;
+	const unsigned char *chunk_bloom_indexes;
+	const unsigned char *chunk_bloom_data;
+
+	struct bloom_filter_settings *bloom_filter_settings;
 };
 
 struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
-- 
gitgitgadget

