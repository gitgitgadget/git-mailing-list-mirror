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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF54C4361B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24457207AA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501886AbgLCQSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501877AbgLCQST (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:18:19 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C8C08E863
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:17:11 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so4506824wmb.2
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zhqt0AwMzROvyhcvFbwQxVrzJhz+jcUqN5PlkHniKp8=;
        b=oxH27VgAqRLFpNvp3zM69x/+MJHDhKirLpsMV1f4OMEj13/FOv5WMmBrtH4FW85e30
         oBGWl31Y+61aNNyZcvXdet58DO37MSql5G08pCSigPWhtq3MH36T0jI2iueRmA6JBVIq
         XFB+epEqBjD/3YrcYB87M1LCWycvmDUZ7qLsYFLYKg9bUC8rq/3/7c7PXVyQB9/kQ9pM
         rMJyXwO/074M3WQu4tk5jbB8VDDlHv1L/1ZwnrD8Z2SgEFIi0Slg7lQvwKVjmn3ZabHd
         I+g5IpHFegdiRI8COdhuHDn9wRKkshPcoQWkgxB5Ukcv3JsWd5ZtKuAc1wQpFNOlk57/
         jg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zhqt0AwMzROvyhcvFbwQxVrzJhz+jcUqN5PlkHniKp8=;
        b=ESRfcpqwgobHykiQ76gNJfdNJnOdfI8E18coiQmGKmw3Yec+FgBn2ocLo737wX8Ahp
         RYZsbQTVcM1BAGHEqdlr8h5B2mJZyV9UIKXDFnEjr21HUibiSzvW9HTQdakC27e4xvY5
         i/hpBvh+2h/A0CCG+nUzsqMoLsx+Xo+MmQcjkixrrhxnrcZDaBvka7AxmLHeIyHdbDZo
         O5+GcY1eexS+GHW7GJHoa3u/oJ4wsjywnXzXCzIaAjVdRqMxtpaReWFNHSTM/KG6Vh8J
         d8KW8xQL9q3rmUouX5eXhGYvasU9fF4IiIeAtshqMD8AyL7s4VGif4ObQ6wddM3tqYga
         c0Jg==
X-Gm-Message-State: AOAM533N7Q3wDwB59jSV8JdLczL90GA2+n8kby0SdLOfqjVmRggCJ06m
        OOczyj4odY3sScMrXvkqlIUfgk+UwPU=
X-Google-Smtp-Source: ABdhPJxgo4JkUvgixavlz5YczkRpuNzG44l9jSrrEfbdZg01RFlLuOuNXPj1Rjt47GNESLKnGRPX3g==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr4181434wml.33.1607012229652;
        Thu, 03 Dec 2020 08:17:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm2320958wrr.2.2020.12.03.08.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:17:09 -0800 (PST)
Message-Id: <6801e231f7414444a272f2ea87dcc6f60f29e25a.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:52 +0000
Subject: [PATCH 13/15] chunk-format: create chunk reading API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Now that the chunk-format API has a consistent mechanism for writing
file formats based on chunks, let's extend it to also parse chunk-based
files during read.

Similar to the write scenario, the caller supplies some context
information, such as a memory location, the offset of the table of
contents, and some information of what to do with each chunk. The table
of contents parsing will skip any unspecified chunks and will leave the
specifics of each chunk to a function pointer.

This implementation handles some of the important error cases, such as
chunk offsets that escape the size of the file. However, we drop the
case of duplicate chunks and leave that to the given functions. It may
be helpful to allow multiple instances of the same chunk ID for some
formats. The new location of these error checks change the error strings
and also the tests that verify for corruption in the table of contents.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 chunk-format.c              |  56 ++++++++++
 chunk-format.h              |  20 ++++
 commit-graph.c              | 200 ++++++++++++++++++++----------------
 midx.c                      | 114 ++++++++++++--------
 t/t5318-commit-graph.sh     |   2 +-
 t/t5319-multi-pack-index.sh |   6 +-
 6 files changed, 261 insertions(+), 137 deletions(-)

diff --git a/chunk-format.c b/chunk-format.c
index a6643a4fc8..d888ef6ec7 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "chunk-format.h"
 #include "csum-file.h"
+#include "cache.h"
 #define CHUNK_LOOKUP_WIDTH 12
 
 void write_table_of_contents(struct hashfile *f,
@@ -47,3 +48,58 @@ int write_chunks(struct hashfile *f,
 
 	return 0;
 }
+
+int read_table_of_contents(const unsigned char *mfile,
+			   size_t mfile_size,
+			   uint64_t toc_offset,
+			   int toc_length,
+			   struct read_chunk_info *chunks,
+			   int nr,
+			   void *data)
+{
+	uint32_t chunk_id;
+	const unsigned char *table_of_contents = mfile + toc_offset;
+
+	while (toc_length--) {
+		int i;
+		uint64_t chunk_offset, next_chunk_offset;
+
+		chunk_id = get_be32(table_of_contents);
+		chunk_offset = get_be64(table_of_contents + 4);
+
+		if (!chunk_id) {
+			error(_("terminating chunk id appears earlier than expected"));
+			return 1;
+		}
+
+		table_of_contents += CHUNK_LOOKUP_WIDTH;
+		next_chunk_offset = get_be64(table_of_contents + 4);
+
+		if (next_chunk_offset < chunk_offset ||
+		    next_chunk_offset > mfile_size - the_hash_algo->rawsz) {
+			error(_("improper chunk offset(s) %"PRIx64" and %"PRIx64""),
+			      chunk_offset, next_chunk_offset);
+			return 1;
+		}
+		for (i = 0; i < nr; i++) {
+			if (chunks[i].id == chunk_id) {
+				int result = chunks[i].read_fn(
+						mfile + chunk_offset,
+						next_chunk_offset - chunk_offset,
+						data);
+
+				if (result)
+					return result;
+				break;
+			}
+		}
+	}
+
+	chunk_id = get_be32(table_of_contents);
+	if (chunk_id) {
+		error(_("final chunk has non-zero id %"PRIx32""), chunk_id);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/chunk-format.h b/chunk-format.h
index a2c7ddb23b..7049800f73 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -46,4 +46,24 @@ int write_chunks(struct hashfile *f,
 		 int nr,
 		 void *data);
 
+/*
+ * When reading a table of contents, we find the chunk with matching 'id'
+ * then call its read_fn to populate the necessary 'data' based on the
+ * chunk start and size.
+ */
+typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
+			     size_t chunk_size, void *data);
+struct read_chunk_info {
+	uint32_t id;
+	chunk_read_fn read_fn;
+};
+
+int read_table_of_contents(const unsigned char *mfile,
+			   size_t mfile_size,
+			   uint64_t toc_offset,
+			   int toc_length,
+			   struct read_chunk_info *chunks,
+			   int nr,
+			   void *data);
+
 #endif
diff --git a/commit-graph.c b/commit-graph.c
index 10dcef9d6b..0a3ba147df 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -289,15 +289,114 @@ static int verify_commit_graph_lite(struct commit_graph *g)
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
+static struct read_chunk_info read_chunks[] = {
+	[0] = {
+		GRAPH_CHUNKID_OIDFANOUT,
+		graph_read_oid_fanout
+	},
+	[1] = {
+		GRAPH_CHUNKID_OIDLOOKUP,
+		graph_read_oid_lookup
+	},
+	[2] = {
+		GRAPH_CHUNKID_DATA,
+		graph_read_data
+	},
+	[3] = {
+		GRAPH_CHUNKID_EXTRAEDGES,
+		graph_read_extra_edges
+	},
+	[4] = {
+		GRAPH_CHUNKID_BASE,
+		graph_read_base_graphs
+	},
+	[5] = {
+		GRAPH_CHUNKID_BLOOMINDEXES,
+		graph_read_bloom_indices
+	},
+	[6] = {
+		GRAPH_CHUNKID_BLOOMDATA,
+		graph_read_bloom_data
+	}
+};
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
+	int chunks_nr = MAX_NUM_CHUNKS;
 
 	if (!graph_map)
 		return NULL;
@@ -346,95 +445,14 @@ struct commit_graph *parse_commit_graph(struct repository *r,
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
+	/* limit the chunk-format list if we are ignoring Bloom filters */
+	if (!r->settings.commit_graph_read_changed_paths)
+		chunks_nr = 5;
 
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
-
-				graph->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
-				graph->bloom_filter_settings->hash_version = hash_version;
-				graph->bloom_filter_settings->num_hashes = get_be32(data + chunk_offset + 4);
-				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
-				graph->bloom_filter_settings->max_changed_paths = DEFAULT_BLOOM_MAX_CHANGES;
-			}
-			break;
-		}
-
-		if (chunk_repeated) {
-			error(_("commit-graph chunk id %08x appears multiple times"), chunk_id);
-			goto free_and_return;
-		}
-	}
+	if (read_table_of_contents(
+		graph->data, graph_size, GRAPH_HEADER_SIZE, graph->num_chunks,
+		read_chunks, chunks_nr, graph))
+		goto free_and_return;
 
 	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
 		init_bloom_filters();
diff --git a/midx.c b/midx.c
index 67ac232a81..786b3b51c3 100644
--- a/midx.c
+++ b/midx.c
@@ -54,6 +54,74 @@ static char *get_midx_filename(const char *object_dir)
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
 }
 
+static int midx_read_pack_names(const unsigned char *chunk_start,
+				size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = (struct multi_pack_index *)data;
+	m->chunk_pack_names = chunk_start;
+	return 0;
+}
+
+static int midx_read_oid_fanout(const unsigned char *chunk_start,
+				size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = (struct multi_pack_index *)data;
+	m->chunk_oid_fanout = (uint32_t *)chunk_start;
+
+	if (chunk_size != 4 * 256) {
+		error(_("multi-pack-index OID fanout is of the wrong size"));
+		return 1;
+	}
+	return 0;
+}
+
+static int midx_read_oid_lookup(const unsigned char *chunk_start,
+				size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = (struct multi_pack_index *)data;
+	m->chunk_oid_lookup = chunk_start;
+	return 0;
+}
+
+static int midx_read_offsets(const unsigned char *chunk_start,
+			     size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = (struct multi_pack_index *)data;
+	m->chunk_object_offsets = chunk_start;
+	return 0;
+}
+
+static int midx_read_large_offsets(const unsigned char *chunk_start,
+				   size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = (struct multi_pack_index *)data;
+	m->chunk_large_offsets = chunk_start;
+	return 0;
+}
+
+static struct read_chunk_info read_chunks[] = {
+	[0] = {
+		MIDX_CHUNKID_PACKNAMES,
+		midx_read_pack_names
+	},
+	[1] = {
+		MIDX_CHUNKID_OIDFANOUT,
+		midx_read_oid_fanout
+	},
+	[2] = {
+		MIDX_CHUNKID_OIDLOOKUP,
+		midx_read_oid_lookup
+	},
+	[3] = {
+		MIDX_CHUNKID_OBJECTOFFSETS,
+		midx_read_offsets
+	},
+	[4] = {
+		MIDX_CHUNKID_LARGEOFFSETS,
+		midx_read_large_offsets
+	}
+};
+
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local)
 {
 	struct multi_pack_index *m = NULL;
@@ -114,48 +182,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 	m->num_packs = get_be32(m->data + MIDX_BYTE_NUM_PACKS);
 
-	for (i = 0; i < m->num_chunks; i++) {
-		uint32_t chunk_id = get_be32(m->data + MIDX_HEADER_SIZE +
-					     MIDX_CHUNKLOOKUP_WIDTH * i);
-		uint64_t chunk_offset = get_be64(m->data + MIDX_HEADER_SIZE + 4 +
-						 MIDX_CHUNKLOOKUP_WIDTH * i);
-
-		if (chunk_offset >= m->data_len)
-			die(_("invalid chunk offset (too large)"));
-
-		switch (chunk_id) {
-			case MIDX_CHUNKID_PACKNAMES:
-				m->chunk_pack_names = m->data + chunk_offset;
-				break;
-
-			case MIDX_CHUNKID_OIDFANOUT:
-				m->chunk_oid_fanout = (uint32_t *)(m->data + chunk_offset);
-				break;
-
-			case MIDX_CHUNKID_OIDLOOKUP:
-				m->chunk_oid_lookup = m->data + chunk_offset;
-				break;
-
-			case MIDX_CHUNKID_OBJECTOFFSETS:
-				m->chunk_object_offsets = m->data + chunk_offset;
-				break;
-
-			case MIDX_CHUNKID_LARGEOFFSETS:
-				m->chunk_large_offsets = m->data + chunk_offset;
-				break;
-
-			case 0:
-				die(_("terminating multi-pack-index chunk id appears earlier than expected"));
-				break;
-
-			default:
-				/*
-				 * Do nothing on unrecognized chunks, allowing future
-				 * extensions to add optional chunks.
-				 */
-				break;
-		}
-	}
+	if (read_table_of_contents(m->data, midx_size, MIDX_HEADER_SIZE,
+				   m->num_chunks, read_chunks,
+				   MIDX_MAX_CHUNKS, m))
+		goto cleanup_fail;
 
 	if (!m->chunk_pack_names)
 		die(_("multi-pack-index missing required pack-name chunk"));
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2ed0c1544d..65879af6c0 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -563,7 +563,7 @@ test_expect_success 'detect bad hash version' '
 
 test_expect_success 'detect low chunk count' '
 	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\01" \
-		"missing the .* chunk"
+		"final chunk has non-zero id"
 '
 
 test_expect_success 'detect missing OID fanout chunk' '
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index ace469c95c..a02d612f4d 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -314,12 +314,12 @@ test_expect_success 'verify bad OID version' '
 
 test_expect_success 'verify truncated chunk count' '
 	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_COUNT "\01" $objdir \
-		"missing required"
+		"final chunk has non-zero id"
 '
 
 test_expect_success 'verify extended chunk count' '
 	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_COUNT "\07" $objdir \
-		"terminating multi-pack-index chunk id appears earlier than expected"
+		"terminating chunk id appears earlier than expected"
 '
 
 test_expect_success 'verify missing required chunk' '
@@ -329,7 +329,7 @@ test_expect_success 'verify missing required chunk' '
 
 test_expect_success 'verify invalid chunk offset' '
 	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_OFFSET "\01" $objdir \
-		"invalid chunk offset (too large)"
+		"improper chunk offset(s)"
 '
 
 test_expect_success 'verify packnames out of order' '
-- 
gitgitgadget

