Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA8A1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeBHUiA (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:38:00 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44417 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeBHUh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:37:59 -0500
Received: by mail-qt0-f194.google.com with SMTP id f18so7729764qth.11
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5b+hhP0JrAQIceBfsUaAWMUPoSAFxz1zEgR1yDk0Voc=;
        b=ONUDxbio3HyhA89rP8CNtNihgP7/geQXpQEPsiiNR6Sp4k5JhIoLGVq/JALUoXb5o4
         1hHDd7L9qnL6itc4lSq6aUO0OYcNk6cuD4f0c7iSIRxV2vnjgb+FRFcNhpZdrSvUZh8C
         tQr8560tx9FnSXk/BE/VdyXyxydiyjPRcYCg2k3KPErGxYv0q8YoQ29uytcvrqzEE1MJ
         pSHbuwgcrNVzZMEIADRnKrFEjLoIuK46OLbL/QcQEf4FAowEa3PB9H5XSw96/ZrOvkAR
         0d0TEGzUwLUWMZaKOQzcWeNoDYRuirOLa9zFFBBEGqmDzoHPIRe0PT+bdJHI6HZ55vRf
         H+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5b+hhP0JrAQIceBfsUaAWMUPoSAFxz1zEgR1yDk0Voc=;
        b=petJcIsuo8Djwf67CVwGsGYn584dGgwRWMmXcik7bnVZ7d4P7YzZo0ASiju/I+cE/R
         V5MQRs99YA6CE8zOvhXShL+WnIfN5MbPq+plvcY5sXbEGtS6P5u20urwfMxILlxmKsCg
         0mkNGLqBTRf03e1FCj8tyXL+vjV61Ak97hE01qK983GD4pXzAQRgXz5HH+nif+SXe+bc
         wlB9MN77ExyPhHqjKsH8QkmBIjiL7Z0hnBp2g5qOB1iHuIl7uZCd4Zw0MP/kd58Ci0we
         MNCuCBKtunKEz7dCfvlCQRMo84UGAzEcz3PnM1PQ+mGmMPfK8o9riN/06QOj2dOfxwEH
         GgyQ==
X-Gm-Message-State: APf1xPARQHT8WKHu1qy0ZtRsHityy0FB6/f4wPi5uGgVsRdGYn2Wr7Gj
        bsNs9+aApiEKtg4zt53tuYZegee/xfo=
X-Google-Smtp-Source: AH8x224lRP217cqg1HjfWRxZ1/Q6fz+YC8aJZ0bIqQDl2Bzcg6xCCQKzmIA3E06oyz9CKlOBqhsg4w==
X-Received: by 10.237.43.165 with SMTP id e34mr788511qtd.11.1518122278229;
        Thu, 08 Feb 2018 12:37:58 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:37:57 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 06/14] commit-graph: implement 'git-commit-graph read'
Date:   Thu,  8 Feb 2018 15:37:30 -0500
Message-Id: <1518122258-157281-7-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to read commit graph files and summarize their contents.

Use the read subcommand to verify the contents of a commit graph file in the
tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  16 ++++
 builtin/commit-graph.c             |  71 ++++++++++++++++++
 commit-graph.c                     | 147 +++++++++++++++++++++++++++++++++++++
 commit-graph.h                     |  23 ++++++
 t/t5318-commit-graph.sh            |  34 +++++++--
 5 files changed, 286 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 55dfe5c3d8..67e107f06a 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -9,6 +9,7 @@ git-commit-graph - Write and verify Git commit graphs (.graph files)
 SYNOPSIS
 --------
 [verse]
+'git commit-graph read' <options> [--pack-dir <pack_dir>]
 'git commit-graph write' <options> [--pack-dir <pack_dir>]
 
 
@@ -34,6 +35,15 @@ Includes all commits from the existing commit graph file. Outputs the
 checksum hash of the written file.
 
 
+'read'::
+
+Read a graph file given by the graph-head file and output basic
+details about the graph file.
++
+With `--graph-hash=<hash>` option, consider the graph file
+graph-<hash>.graph in the pack directory.
+
+
 EXAMPLES
 --------
 
@@ -43,6 +53,12 @@ EXAMPLES
 $ git commit-graph write
 ------------------------------------------------
 
+* Read basic information from a graph file.
++
+------------------------------------------------
+$ git commit-graph read --graph-hash=<hash>
+------------------------------------------------
+
 
 GIT
 ---
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 5dac033bfe..3ffa7ec433 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -5,10 +5,16 @@
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
+	N_("git commit-graph read [--graph-hash=<hash>]"),
 	N_("git commit-graph write [--pack-dir <packdir>]"),
 	NULL
 };
 
+static const char * const builtin_commit_graph_read_usage[] = {
+	N_("git commit-graph read [--pack-dir <packdir>]"),
+	NULL
+};
+
 static const char * const builtin_commit_graph_write_usage[] = {
 	N_("git commit-graph write [--pack-dir <packdir>]"),
 	NULL
@@ -16,8 +22,71 @@ static const char * const builtin_commit_graph_write_usage[] = {
 
 static struct opts_commit_graph {
 	const char *pack_dir;
+	const char *graph_hash;
 } opts;
 
+static int graph_read(int argc, const char **argv)
+{
+	struct object_id graph_hash;
+	struct commit_graph *graph = 0;
+	const char *graph_file;
+
+	static struct option builtin_commit_graph_read_options[] = {
+		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
+			N_("dir"),
+			N_("The pack directory to store the graph") },
+		{ OPTION_STRING, 'H', "graph-hash", &opts.graph_hash,
+			N_("hash"),
+			N_("A hash for a specific graph file in the pack-dir."),
+			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_commit_graph_read_options,
+			     builtin_commit_graph_read_usage, 0);
+
+	if (!opts.pack_dir) {
+		struct strbuf path = STRBUF_INIT;
+		strbuf_addstr(&path, get_object_directory());
+		strbuf_addstr(&path, "/pack");
+		opts.pack_dir = strbuf_detach(&path, NULL);
+	}
+
+	if (opts.graph_hash && strlen(opts.graph_hash) == GIT_MAX_HEXSZ)
+		get_oid_hex(opts.graph_hash, &graph_hash);
+	else
+		die("no graph hash specified");
+
+	graph_file = get_commit_graph_filename_hash(opts.pack_dir, &graph_hash);
+	graph = load_commit_graph_one(graph_file, opts.pack_dir);
+
+	if (!graph)
+		die("graph file %s does not exist", graph_file);
+
+	printf("header: %08x %02x %02x %02x %02x\n",
+		ntohl(*(uint32_t*)graph->data),
+		*(unsigned char*)(graph->data + 4),
+		*(unsigned char*)(graph->data + 5),
+		graph->hash_len,
+		graph->num_chunks);
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
 static int graph_write(int argc, const char **argv)
 {
 	struct object_id *graph_hash;
@@ -70,6 +139,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (argc > 0) {
+		if (!strcmp(argv[0], "read"))
+			return graph_read(argc, argv);
 		if (!strcmp(argv[0], "write"))
 			return graph_write(argc, argv);
 	}
diff --git a/commit-graph.c b/commit-graph.c
index cb47b68871..9a337cea4d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -51,6 +51,153 @@ char* get_commit_graph_filename_hash(const char *pack_dir,
 	return strbuf_detach(&path, &len);
 }
 
+static struct commit_graph *alloc_commit_graph(int extra)
+{
+	struct commit_graph *g = xmalloc(st_add(sizeof(*g), extra));
+	memset(g, 0, sizeof(*g));
+	g->graph_fd = -1;
+
+	return g;
+}
+
+static int close_commit_graph(struct commit_graph *g)
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
+static void free_commit_graph(struct commit_graph **g)
+{
+	if (!g || !*g)
+		return;
+
+	close_commit_graph(*g);
+	FREE_AND_NULL(*g);
+}
+
+struct commit_graph *load_commit_graph_one(const char *graph_file, const char *pack_dir)
+{
+	void *graph_map;
+	const unsigned char *data, *chunk_lookup;
+	size_t graph_size;
+	struct stat st;
+	uint32_t i;
+	struct commit_graph *graph;
+	int fd = git_open(graph_file);
+	uint64_t last_chunk_offset;
+	uint32_t last_chunk_id;
+	uint32_t graph_signature;
+	unsigned char graph_version, hash_version;
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
+	graph_signature = ntohl(*(uint32_t*)data);
+	if (graph_signature != GRAPH_SIGNATURE) {
+		munmap(graph_map, graph_size);
+		close(fd);
+		die("graph signature %X does not match signature %X",
+			graph_signature, GRAPH_SIGNATURE);
+	}
+
+	graph_version = *(unsigned char*)(data + 4);
+	if (graph_version != GRAPH_VERSION) {
+		munmap(graph_map, graph_size);
+		close(fd);
+		die("graph version %X does not match version %X",
+			graph_version, GRAPH_VERSION);
+	}
+
+	hash_version = *(unsigned char*)(data + 5);
+	if (hash_version != GRAPH_OID_VERSION) {
+		munmap(graph_map, graph_size);
+		close(fd);
+		die("hash version %X does not match version %X",
+			hash_version, GRAPH_OID_VERSION);
+	}
+
+	graph = alloc_commit_graph(strlen(pack_dir) + 1);
+
+	graph->hash_len = *(unsigned char*)(data + 6);
+	graph->num_chunks = *(unsigned char*)(data + 7);
+	graph->graph_fd = fd;
+	graph->data = graph_map;
+	graph->data_len = graph_size;
+
+	last_chunk_id = 0;
+	last_chunk_offset = 8;
+	chunk_lookup = data + 8;
+	for (i = 0; i < graph->num_chunks; i++) {
+		uint32_t chunk_id = get_be32(chunk_lookup + 0);
+		uint64_t chunk_offset1 = get_be32(chunk_lookup + 4);
+		uint32_t chunk_offset2 = get_be32(chunk_lookup + 8);
+		uint64_t chunk_offset = (chunk_offset1 << 32) | chunk_offset2;
+
+		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
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
+				free_commit_graph(&graph);
+				die("unrecognized graph chunk id: %08x", chunk_id);
+		}
+
+		if (last_chunk_id == GRAPH_CHUNKID_OIDLOOKUP)
+		{
+			graph->num_commits = (chunk_offset - last_chunk_offset)
+					     / graph->hash_len;
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
 static void write_graph_chunk_fanout(struct sha1file *f,
 				     struct commit **commits,
 				     int nr_commits)
diff --git a/commit-graph.h b/commit-graph.h
index 4756f6ba5b..c1608976b3 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -7,6 +7,29 @@
 extern char* get_commit_graph_filename_hash(const char *pack_dir,
 					    struct object_id *hash);
 
+struct commit_graph {
+	int graph_fd;
+
+	const unsigned char *data;
+	size_t data_len;
+
+	unsigned char hash_len;
+	unsigned char num_chunks;
+	uint32_t num_commits;
+	struct object_id oid;
+
+	const unsigned char *chunk_oid_fanout;
+	const unsigned char *chunk_oid_lookup;
+	const unsigned char *chunk_commit_data;
+	const unsigned char *chunk_large_edges;
+
+	/* something like ".git/objects/pack" */
+	char pack_dir[FLEX_ARRAY]; /* more */
+};
+
+extern struct commit_graph *load_commit_graph_one(const char *graph_file,
+						  const char *pack_dir);
+
 extern struct object_id *write_commit_graph(const char *pack_dir);
 
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index b762587595..ad1d0e621d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -21,9 +21,21 @@ test_expect_success 'create commits and repack' '
 	done &&
 	git repack'
 
+graph_read_expect() {
+	cat >expect <<- EOF
+	header: 43475048 01 01 14 04
+	num_commits: $1
+	chunks: oid_fanout oid_lookup commit_metadata large_edges
+	pack_dir: $2
+	EOF
+}
+
 test_expect_success 'write graph' '
 	graph1=$(git commit-graph write) &&
-	test_path_is_file $packdir/graph-$graph1.graph'
+	test_path_is_file $packdir/graph-$graph1.graph &&
+	git commit-graph read --graph-hash=$graph1 >output &&
+	graph_read_expect "3" "$packdir" &&
+	test_cmp expect output'
 
 test_expect_success 'Add more commits' '
 	git reset --hard commits/1 &&
@@ -62,7 +74,10 @@ test_expect_success 'Add more commits' '
 
 test_expect_success 'write graph with merges' '
 	graph2=$(git commit-graph write)&&
-	test_path_is_file $packdir/graph-$graph2.graph'
+	test_path_is_file $packdir/graph-$graph2.graph &&
+	git commit-graph read --graph-hash=$graph2 >output &&
+	graph_read_expect "10" "$packdir" &&
+	test_cmp expect output'
 
 test_expect_success 'Add one more commit' '
 	test_commit 8 &&
@@ -85,14 +100,20 @@ test_expect_success 'Add one more commit' '
 
 test_expect_success 'write graph with new commit' '
 	graph3=$(git commit-graph write) &&
-	test_path_is_file $packdir/graph-$graph3.graph'
-
+	test_path_is_file $packdir/graph-$graph3.graph &&
+	test_path_is_file $packdir/graph-$graph3.graph &&
+	git commit-graph read --graph-hash=$graph3 >output &&
+	graph_read_expect "11" "$packdir" &&
+	test_cmp expect output'
 
 test_expect_success 'write graph with nothing new' '
 	graph4=$(git commit-graph write) &&
 	test_path_is_file $packdir/graph-$graph4.graph &&
 	printf $graph3 >expect &&
 	printf $graph4 >output &&
+	test_cmp expect output &&
+	git commit-graph read --graph-hash=$graph4 >output &&
+	graph_read_expect "11" "$packdir" &&
 	test_cmp expect output'
 
 test_expect_success 'setup bare repo' '
@@ -103,7 +124,10 @@ test_expect_success 'setup bare repo' '
 
 test_expect_success 'write graph in bare repo' '
 	graphbare=$(git commit-graph write) &&
-	test_path_is_file $baredir/graph-$graphbare.graph'
+	test_path_is_file $baredir/graph-$graphbare.graph &&
+	git commit-graph read --graph-hash=$graphbare >output &&
+	graph_read_expect "11" "$baredir" &&
+	test_cmp expect output'
 
 test_done
 
-- 
2.15.1.45.g9b7079f

