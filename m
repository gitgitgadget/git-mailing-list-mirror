Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7F71F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbeAYOC7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:02:59 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42374 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeAYOCu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:50 -0500
Received: by mail-qt0-f194.google.com with SMTP id c2so19340350qtn.9
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=civU0bhgEmSIRd9vuJzXbqOT+TRDyP2Z7WzHs/Gnf9E=;
        b=GbKhWvmsmx0HLVZGQbvt1LbsNNWg2zIFIoYiK6LIV9v5mTSY4GCAOyqkHXSr45SuaZ
         F79lSbJmT6blOlgfDtqXqyusbSctt34inytb7s8/PoehTxEZNXY83cK7+Df2iifii+0a
         YYgW2GpqGw2K1ZpTw+yxmPkBcGYqLICqRBG3ZPBpD93p95Cn3xETgwb3MceyYVUwNaGc
         h6hQ71kS1HCTWwVOInpqUe3GYv2a+VL6T0DVJlXh16Bf/muTcJeq6fJYbEVpXRINW8I9
         4b2gP5HYBHJRqgSuVqPJHgp5FAuOQDsCK2l4v7LtRdnT88dbE+2+wm5z/2r8IVqsDv1C
         hNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=civU0bhgEmSIRd9vuJzXbqOT+TRDyP2Z7WzHs/Gnf9E=;
        b=eRNQA1mZgTYcwLKxGgXD0InN0iRn1u6nsUzZTUpBOOj37AvtVSgY3G05/92QFkf2dv
         JYywtiX4Gibef0SjETG+vkwyk6y0u3E1sAxt0Ig+mX1d9bHVkfVBn27xF7R5NYAXHpax
         Vi1V1+iZ/jvrQsEbWCNWt7QS7RH8lpkPojO6kPop2Qce3vUj21rKFRFT2aYAx2jBTTxK
         mfg7wIGz8uh+BHrIsTAdLSkVoVHSvgMlyKHLb7k6OfGKjzAdoJ9r6/DyBhpljw/04HBe
         ++EeBwb8y2xteVElIZ48oiNQcXZwkITBdCbS+RgyofsydvHBop9yWIZoaLQ/4z7v7Ub3
         C1uQ==
X-Gm-Message-State: AKwxytddw/oFFHCAupAA9JAcCGbvZ8qRvBJNRsRtrGioVqe0ofX7yBu0
        odo7kIlSFlWKDI33MjS3qjtp9AZY
X-Google-Smtp-Source: AH8x227DWcIXArcHfiRfMLoetkfvTftJMtM1y1hZyvpaFnCr7uGOpaS40oOMx8+pcllSAhqbekHBtg==
X-Received: by 10.237.37.18 with SMTP id v18mr16552585qtc.124.1516888969212;
        Thu, 25 Jan 2018 06:02:49 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:48 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 07/14] packed-graph: implement git-graph --read
Date:   Thu, 25 Jan 2018 09:02:24 -0500
Message-Id: <20180125140231.65604-8-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-graph to read packed graph files and summarize their contents.

Use the --read option to verify the contents of a graph file in the
graph tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-graph.txt |   7 +++
 builtin/graph.c             |  54 ++++++++++++++++
 packed-graph.c              | 147 +++++++++++++++++++++++++++++++++++++++++++-
 packed-graph.h              |  25 ++++++++
 t/t5319-graph.sh            |  50 +++++++++------
 5 files changed, 260 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-graph.txt b/Documentation/git-graph.txt
index be6bc38814..0939c3f1be 100644
--- a/Documentation/git-graph.txt
+++ b/Documentation/git-graph.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git graph' --write <options> [--pack-dir <pack_dir>]
+'git graph' --read <options> [--pack-dir <pack_dir>]
 
 EXAMPLES
 --------
@@ -20,6 +21,12 @@ EXAMPLES
 $ git midx --write
 ------------------------------------------------
 
+* Read basic information from a graph file.
++
+------------------------------------------------
+$ git midx --read --graph-id=<oid>
+------------------------------------------------
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/graph.c b/builtin/graph.c
index 09f5552338..bc66722924 100644
--- a/builtin/graph.c
+++ b/builtin/graph.c
@@ -10,15 +10,58 @@
 
 static char const * const builtin_graph_usage[] ={
 	N_("git graph [--pack-dir <packdir>]"),
+	N_("git graph --read [--graph-id=<oid>]"),
 	N_("git graph --write [--pack-dir <packdir>]"),
 	NULL
 };
 
 static struct opts_graph {
 	const char *pack_dir;
+	int read;
+	const char *graph_id;
 	int write;
 } opts;
 
+static int graph_read(void)
+{
+	struct object_id graph_oid;
+	struct packed_graph *graph = 0;
+	const char *graph_file;
+
+	if (opts.graph_id && strlen(opts.graph_id) == GIT_MAX_HEXSZ)
+		get_oid_hex(opts.graph_id, &graph_oid);
+	else
+		die("no graph id specified");
+
+	graph_file = get_graph_filename_oid(opts.pack_dir, &graph_oid);
+	graph = load_packed_graph_one(graph_file, opts.pack_dir);
+
+	if (!graph)
+		die("graph file %s does not exist.\n", graph_file);
+
+	printf("header: %08x %02x %02x %02x %02x\n",
+		ntohl(graph->hdr->graph_signature),
+		graph->hdr->graph_version,
+		graph->hdr->hash_version,
+		graph->hdr->hash_len,
+		graph->hdr->num_chunks);
+	printf("num_commits: %u\n", graph->num_commits);
+	printf("chunks:");
+
+	if (graph->chunk_oid_fanout)
+		printf(" oid_fanout");
+	if (graph->chunk_oid_lookup)
+		printf(" oid_lookup");
+	if (graph->chunk_commit_data)
+		printf(" commit_metadata");
+	if (graph->chunk_large_edges)
+		printf(" large_edges");
+	printf("\n");
+
+	printf("pack_dir: %s\n", graph->pack_dir);
+	return 0;
+}
+
 static int graph_write(void)
 {
 	struct object_id *graph_id = construct_graph(opts.pack_dir);
@@ -36,8 +79,14 @@ int cmd_graph(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
 			N_("dir"),
 			N_("The pack directory to store the graph") },
+		OPT_BOOL('r', "read", &opts.read,
+			N_("read graph file")),
 		OPT_BOOL('w', "write", &opts.write,
 			N_("write graph file")),
+		{ OPTION_STRING, 'M', "graph-id", &opts.graph_id,
+			N_("oid"),
+			N_("An OID for a specific graph file in the pack-dir."),
+			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_END(),
 	};
 
@@ -52,6 +101,9 @@ int cmd_graph(int argc, const char **argv, const char *prefix)
 			     builtin_graph_options,
 			     builtin_graph_usage, 0);
 
+	if (opts.write + opts.read > 1)
+		usage_with_options(builtin_graph_usage, builtin_graph_options);
+
 	if (!opts.pack_dir) {
 		struct strbuf path = STRBUF_INIT;
 		strbuf_addstr(&path, get_object_directory());
@@ -59,6 +111,8 @@ int cmd_graph(int argc, const char **argv, const char *prefix)
 		opts.pack_dir = strbuf_detach(&path, NULL);
 	}
 
+	if (opts.read)
+		return graph_read();
 	if (opts.write)
 		return graph_write();
 
diff --git a/packed-graph.c b/packed-graph.c
index 9be9811667..eaa656becb 100644
--- a/packed-graph.c
+++ b/packed-graph.c
@@ -30,6 +30,11 @@
 
 #define GRAPH_LAST_EDGE 0x80000000
 
+#define GRAPH_FANOUT_SIZE (4*256)
+#define GRAPH_CHUNKLOOKUP_SIZE (5 * 12)
+#define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
+			GRAPH_OID_LEN + sizeof(struct packed_graph_header))
+
 char* get_graph_filename_oid(const char *pack_dir,
 				  struct object_id *oid)
 {
@@ -43,6 +48,142 @@ char* get_graph_filename_oid(const char *pack_dir,
 	return strbuf_detach(&head_path, &len);
 }
 
+static struct packed_graph *alloc_packed_graph(int extra)
+{
+	struct packed_graph *g = xmalloc(st_add(sizeof(*g), extra));
+	memset(g, 0, sizeof(*g));
+	g->graph_fd = -1;
+
+	return g;
+}
+
+int close_graph(struct packed_graph *g)
+{
+	if (g->graph_fd < 0)
+		return 0;
+
+	munmap((void *)g->data, g->data_len);
+	g->data = 0;
+
+	close(g->graph_fd);
+	g->graph_fd = -1;
+
+	return 1;
+}
+
+static void free_packed_graph(struct packed_graph **g)
+{
+	if (!g || !*g)
+		return;
+
+	close_graph(*g);
+
+	free(*g);
+	*g = NULL;
+}
+
+struct packed_graph *load_packed_graph_one(const char *graph_file, const char *pack_dir)
+{
+	void *graph_map;
+	const unsigned char *data;
+	struct packed_graph_header *hdr;
+	size_t graph_size;
+	struct stat st;
+	uint32_t i;
+	struct packed_graph *graph;
+	int fd = git_open(graph_file);
+	uint64_t last_chunk_offset;
+	uint32_t last_chunk_id;
+
+	if (fd < 0)
+		return 0;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return 0;
+	}
+	graph_size = xsize_t(st.st_size);
+
+	if (graph_size < GRAPH_MIN_SIZE) {
+		close(fd);
+		die("graph file %s is too small", graph_file);
+	}
+	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	data = (const unsigned char *)graph_map;
+
+	hdr = graph_map;
+	if (ntohl(hdr->graph_signature) != GRAPH_SIGNATURE) {
+		uint32_t signature = ntohl(hdr->graph_signature);
+		munmap(graph_map, graph_size);
+		close(fd);
+		die("graph signature %X does not match signature %X",
+			signature, GRAPH_SIGNATURE);
+	}
+	if (hdr->graph_version != GRAPH_VERSION) {
+		unsigned char version = hdr->graph_version;
+		munmap(graph_map, graph_size);
+		close(fd);
+		die("graph version %X does not match version %X",
+			version, GRAPH_VERSION);
+	}
+
+	graph = alloc_packed_graph(strlen(pack_dir) + 1);
+
+	graph->hdr = hdr;
+	graph->graph_fd = fd;
+	graph->data = graph_map;
+	graph->data_len = graph_size;
+
+	last_chunk_id = 0;
+	last_chunk_offset = (uint64_t)sizeof(*hdr);
+	for (i = 0; i < hdr->num_chunks; i++) {
+		uint32_t chunk_id = ntohl(*(uint32_t*)(data + sizeof(*hdr) + 12 * i));
+		uint64_t chunk_offset1 = ntohl(*(uint32_t*)(data + sizeof(*hdr) + 12 * i + 4));
+		uint32_t chunk_offset2 = ntohl(*(uint32_t*)(data + sizeof(*hdr) + 12 * i + 8));
+		uint64_t chunk_offset = (chunk_offset1 << 32) | chunk_offset2;
+
+		if (chunk_offset > graph_size - GIT_MAX_RAWSZ)
+			die("improper chunk offset %08x%08x", (uint32_t)(chunk_offset >> 32),
+			    (uint32_t)chunk_offset);
+
+		switch (chunk_id) {
+			case GRAPH_CHUNKID_OIDFANOUT:
+				graph->chunk_oid_fanout = data + chunk_offset;
+				break;
+
+			case GRAPH_CHUNKID_OIDLOOKUP:
+				graph->chunk_oid_lookup = data + chunk_offset;
+				break;
+
+			case GRAPH_CHUNKID_DATA:
+				graph->chunk_commit_data = data + chunk_offset;
+				break;
+
+			case GRAPH_CHUNKID_LARGEEDGES:
+				graph->chunk_large_edges = data + chunk_offset;
+				break;
+
+			case 0:
+				break;
+
+			default:
+				free_packed_graph(&graph);
+				die("unrecognized graph chunk id: %08x", chunk_id);
+		}
+
+		if (last_chunk_id == GRAPH_CHUNKID_OIDLOOKUP)
+		{
+			graph->num_commits = (chunk_offset - last_chunk_offset)
+					     / hdr->hash_len;
+		}
+
+		last_chunk_id = chunk_id;
+		last_chunk_offset = chunk_offset;
+	}
+
+	strcpy(graph->pack_dir, pack_dir);
+	return graph;
+}
+
 static void write_graph_chunk_fanout(
 	struct sha1file *f,
 	struct commit **commits, int nr_commits)
@@ -338,8 +479,8 @@ struct object_id *construct_graph(const char *pack_dir)
 	chunk_ids[3] = GRAPH_CHUNKID_LARGEEDGES;
 	chunk_ids[4] = 0;
 
-	chunk_offsets[0] = sizeof(hdr) + 12 * 5; // Skip header and chunk list
-	chunk_offsets[1] = chunk_offsets[0] + 256 * 4; // fanout table size
+	chunk_offsets[0] = sizeof(hdr) + GRAPH_CHUNKLOOKUP_SIZE;
+	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
 	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.num; // lookup size
 	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.num; // data size
 	chunk_offsets[4] = chunk_offsets[3] + 4 * num_long_edges;
@@ -361,7 +502,7 @@ struct object_id *construct_graph(const char *pack_dir)
 	sha1close(f, final_hash, CSUM_CLOSE | CSUM_FSYNC);
 
 	f_oid = (struct object_id *)malloc(sizeof(struct object_id));
-	memcpy(f_oid->hash, final_hash, GIT_MAX_RAWSZ);
+	hashcpy(f_oid->hash, final_hash);
 	fname = get_graph_filename_oid(pack_dir, f_oid);
 
 	if (rename(graph_name, fname))
diff --git a/packed-graph.h b/packed-graph.h
index d4e10fb612..1a7eaa2a46 100644
--- a/packed-graph.h
+++ b/packed-graph.h
@@ -15,6 +15,31 @@ struct packed_graph_header {
 	unsigned char num_chunks;
 };
 
+extern struct packed_graph {
+	int graph_fd;
+
+	const unsigned char *data;
+	size_t data_len;
+
+	const struct packed_graph_header *hdr;
+
+	struct object_id oid;
+
+	uint32_t num_commits;
+
+	const unsigned char *chunk_oid_fanout;
+	const unsigned char *chunk_oid_lookup;
+	const unsigned char *chunk_commit_data;
+	const unsigned char *chunk_large_edges;
+
+	/* something like ".git/objects/pack" */
+	char pack_dir[FLEX_ARRAY]; /* more */
+} *packed_graph;
+
+extern int close_graph(struct packed_graph *g);
+
+extern struct packed_graph *load_packed_graph_one(const char *graph_file, const char *pack_dir);
+
 extern struct object_id *construct_graph(const char *pack_dir);
 
 #endif
diff --git a/t/t5319-graph.sh b/t/t5319-graph.sh
index 52e979dfd3..4975f65dee 100755
--- a/t/t5319-graph.sh
+++ b/t/t5319-graph.sh
@@ -3,8 +3,7 @@
 test_description='packed graph'
 . ./test-lib.sh
 
-test_expect_success \
-    'setup full repo' \
+test_expect_success 'setup full repo' \
     'rm -rf .git &&
      mkdir full &&
      cd full &&
@@ -13,12 +12,10 @@ test_expect_success \
      git config pack.threads 1 &&
      packdir=".git/objects/pack"'
 
-test_expect_success \
-    'write graph with no packs' \
+test_expect_success 'write graph with no packs' \
     'git graph --write --pack-dir .'
 
-test_expect_success \
-    'create commits and repack' \
+test_expect_success 'create commits and repack' \
     'for i in $(test_seq 5)
      do
         echo $i >$i.txt &&
@@ -28,13 +25,23 @@ test_expect_success \
      done &&
      git repack'
 
-test_expect_success \
-    'write graph' \
+_graph_read_expect() {
+    cat >expect <<- EOF
+header: 43475048 01 01 14 04
+num_commits: $1
+chunks: oid_fanout oid_lookup commit_metadata large_edges
+pack_dir: $2
+EOF
+}
+
+test_expect_success 'write graph' \
     'graph1=$(git graph --write) &&
-     test_path_is_file ${packdir}/graph-${graph1}.graph'
+     test_path_is_file ${packdir}/graph-${graph1}.graph &&
+     git graph --read --graph-id=${graph1} >output &&
+     _graph_read_expect "5" "${packdir}" &&
+     cmp expect output'
 
-test_expect_success \
-    'Add more commits' \
+test_expect_success 'Add more commits' \
     'git reset --hard commits/3 &&
      for i in $(test_seq 6 10)
      do
@@ -61,23 +68,26 @@ test_expect_success \
      git merge commits/5 commits/13 &&
      git repack'
 
-test_expect_success \
-    'write graph with merges' \
+test_expect_success 'write graph with merges' \
     'graph2=$(git graph --write) &&
-     test_path_is_file ${packdir}/graph-${graph2}.graph'
+     test_path_is_file ${packdir}/graph-${graph2}.graph &&
+     git graph --read --graph-id=${graph2} >output &&
+     _graph_read_expect "18" "${packdir}" &&
+     cmp expect output'
 
-test_expect_success \
-    'setup bare repo' \
+test_expect_success 'setup bare repo' \
     'cd .. &&
      git clone --bare full bare &&
      cd bare &&
      git config core.graph true &&
      git config pack.threads 1 &&
-     baredir="objects/pack"'
+     baredir="./objects/pack"'
 
-test_expect_success \
-    'write graph in bare repo' \
+test_expect_success 'write graph in bare repo' \
     'graphbare=$(git graph --write) &&
-     test_path_is_file ${baredir}/graph-${graphbare}.graph'
+     test_path_is_file ${baredir}/graph-${graphbare}.graph &&
+     git graph --read --graph-id=${graphbare} >output &&
+     _graph_read_expect "18" "${baredir}" &&
+     cmp expect output'
 
 test_done
-- 
2.16.0

