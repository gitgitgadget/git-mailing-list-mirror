Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0319D1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbeBSSxl (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:53:41 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41137 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753489AbeBSSxj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:39 -0500
Received: by mail-qk0-f195.google.com with SMTP id h129so13450124qke.8
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U6kynFVqO/mMfkIgwemikKKNWlY/KUMogFZpU2bGl2I=;
        b=COQWr4OLLgeqYZ9hCT6FOdqTLDfgyGcneBZcIVPCTW9VER43Hajp0rCVLbXlQKUsQ9
         bmILYTWjNb8c3FoTNlNyi97/8SieUyAihOFCe1udqBl7uw4FbwdhOe77bJGRP4fp1q3G
         gBBRvCWaBTUn0wxXWAcNWw2oy/NPTwSCFzYOQAkgj9zMeOlv/2sr9eAT8nSQ6PKoUkRW
         SAWQNaw8ZR8IcaddxvqgVXxqSb3pvjEhSeB3ZwXPDxKeZHeilIf4kTFtH1KPX6ar7BcY
         1yUgkc5v/G37DO2CWnV/ihAEZrZEZnGtYMrxH2lQENNjJGwY7QsKQFLiqm12l2eMYg/N
         Rpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U6kynFVqO/mMfkIgwemikKKNWlY/KUMogFZpU2bGl2I=;
        b=gTzjTwkjnCqXh+OYAfR+CTDwtsze0yBCjNUwBtS8T2s97Vhk67taM6o2We+kuC9HK3
         8IGHY5lebQdTUcHwoPIjiFhz12dQ809FQh6QocmVBBZkWGbXLms5+M2b++PjrNqhPFIB
         9Z9snv28cKQo5ey2ypJnXXliw7PDLeUaADKCT3IVO4phCMwP+m9wF0+PK0w2jxc3jmm+
         2vrAljlsiNnirtD/8Q6CVk/aWcJRqkzM2W6cyHnzAyMYtB7aL9PAOfQERZwrjwqAAdVL
         DC9FUfGJtA3ijW0bOvR3ihf/eDDzw5KKTS8uChari+AQYE3ILL67FextYsu+r9xgQmVW
         ggUg==
X-Gm-Message-State: APf1xPCBM0Zlk7UjkZuJkdj9grNroEUAyqKTB+u2LpzXDl7KPe/JKQ1W
        3VEzHVXGUmHYryAXEHgprqshwRqd2ds=
X-Google-Smtp-Source: AH8x225JTfRKIHgO3HLWh9Xv8sXYYvYbMOtq/RupT3TsFyc1XqexT53LVg8z/2r1oAQOfMi/niatbw==
X-Received: by 10.55.118.6 with SMTP id r6mr13833519qkc.211.1519066418793;
        Mon, 19 Feb 2018 10:53:38 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:38 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 06/13] commit-graph: implement git commit-graph read
Date:   Mon, 19 Feb 2018 13:53:19 -0500
Message-Id: <1519066406-81663-7-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to read commit graph files and summarize their contents.

Use the read subcommand to verify the contents of a commit graph file in the
tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  15 +++++
 builtin/commit-graph.c             |  63 ++++++++++++++++++++
 commit-graph.c                     | 116 +++++++++++++++++++++++++++++++++++++
 commit-graph.h                     |  21 +++++++
 t/t5318-commit-graph.sh            |  38 ++++++++++--
 5 files changed, 249 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index c3f222f..6d26e56 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -9,6 +9,7 @@ git-commit-graph - Write and verify Git commit graphs (.graph files)
 SYNOPSIS
 --------
 [verse]
+'git commit-graph read' <options> [--object-dir <dir>]
 'git commit-graph write' <options> [--object-dir <dir>]
 
 
@@ -34,6 +35,14 @@ Write a commit graph file based on the commits found in packfiles.
 Includes all commits from the existing commit graph file. Outputs the
 resulting filename.
 
+'read'::
+
+Read a graph file given by the graph-head file and output basic
+details about the graph file.
++
+With `--file=<name>` option, consider the graph stored in the file at
+the path  <object-dir>/info/<name>.
+
 
 EXAMPLES
 --------
@@ -44,6 +53,12 @@ EXAMPLES
 $ git commit-graph write
 ------------------------------------------------
 
+* Read basic information from a graph file.
++
+------------------------------------------------
+$ git commit-graph read --file=<name>
+------------------------------------------------
+
 
 GIT
 ---
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index a51d87b..28cd097 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -7,10 +7,16 @@
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
+	N_("git commit-graph read [--object-dir <objdir>] [--file=<hash>]"),
 	N_("git commit-graph write [--object-dir <objdir>]"),
 	NULL
 };
 
+static const char * const builtin_commit_graph_read_usage[] = {
+	N_("git commit-graph read [--object-dir <objdir>] [--file=<hash>]"),
+	NULL
+};
+
 static const char * const builtin_commit_graph_write_usage[] = {
 	N_("git commit-graph write [--object-dir <objdir>]"),
 	NULL
@@ -18,8 +24,63 @@ static const char * const builtin_commit_graph_write_usage[] = {
 
 static struct opts_commit_graph {
 	const char *obj_dir;
+	const char *graph_file;
 } opts;
 
+static int graph_read(int argc, const char **argv)
+{
+	struct commit_graph *graph = 0;
+	struct strbuf full_path = STRBUF_INIT;
+
+	static struct option builtin_commit_graph_read_options[] = {
+		{ OPTION_STRING, 'o', "object-dir", &opts.obj_dir,
+			N_("dir"),
+			N_("The object directory to store the graph") },
+		{ OPTION_STRING, 'H', "file", &opts.graph_file,
+			N_("file"),
+			N_("The filename for a specific commit graph file in the object directory."),
+			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_commit_graph_read_options,
+			     builtin_commit_graph_read_usage, 0);
+
+	if (!opts.obj_dir)
+		opts.obj_dir = get_object_directory();
+
+	if (!opts.graph_file)
+		die("no graph hash specified");
+
+	strbuf_addf(&full_path, "%s/info/%s", opts.obj_dir, opts.graph_file);
+	graph = load_commit_graph_one(full_path.buf);
+
+	if (!graph)
+		die("graph file %s does not exist", full_path.buf);
+
+	printf("header: %08x %d %d %d %d\n",
+		ntohl(*(uint32_t*)graph->data),
+		*(unsigned char*)(graph->data + 4),
+		*(unsigned char*)(graph->data + 5),
+		*(unsigned char*)(graph->data + 6),
+		*(unsigned char*)(graph->data + 7));
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
+	return 0;
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	char *graph_name;
@@ -68,6 +129,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (argc > 0) {
+		if (!strcmp(argv[0], "read"))
+			return graph_read(argc, argv);
 		if (!strcmp(argv[0], "write"))
 			return graph_write(argc, argv);
 	}
diff --git a/commit-graph.c b/commit-graph.c
index f9e39b0..2a8594f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -38,6 +38,122 @@
 #define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
 			GRAPH_OID_LEN + 8)
 
+static struct commit_graph *alloc_commit_graph(void)
+{
+	struct commit_graph *g = xmalloc(sizeof(*g));
+	memset(g, 0, sizeof(*g));
+	g->graph_fd = -1;
+
+	return g;
+}
+
+struct commit_graph *load_commit_graph_one(const char *graph_file)
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
+	graph = alloc_commit_graph();
+
+	graph->hash_len = GRAPH_OID_LEN;
+	graph->num_chunks = *(unsigned char*)(data + 6);
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
+				graph->chunk_oid_fanout = (uint32_t*)(data + chunk_offset);
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
+	return graph;
+}
+
 static void write_graph_chunk_fanout(struct sha1file *f,
 				     struct commit **commits,
 				     int nr_commits)
diff --git a/commit-graph.h b/commit-graph.h
index dc8c73a..9093b97 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -1,6 +1,27 @@
 #ifndef COMMIT_GRAPH_H
 #define COMMIT_GRAPH_H
 
+#include "git-compat-util.h"
+
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
+	const uint32_t *chunk_oid_fanout;
+	const unsigned char *chunk_oid_lookup;
+	const unsigned char *chunk_commit_data;
+	const unsigned char *chunk_large_edges;
+};
+
+extern struct commit_graph *load_commit_graph_one(const char *graph_file);
+
 extern char *write_commit_graph(const char *obj_dir);
 
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 6a5e93c..893fa24 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -24,9 +24,27 @@ test_expect_success 'create commits and repack' '
 	git repack
 '
 
+graph_read_expect() {
+	OPTIONAL=""
+	NUM_CHUNKS=3
+	if [ ! -z $2 ]
+	then
+		OPTIONAL=" $2"
+		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
+	fi
+	cat >expect <<- EOF
+	header: 43475048 1 1 $NUM_CHUNKS 0
+	num_commits: $1
+	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
+	EOF
+}
+
 test_expect_success 'write graph' '
 	graph1=$(git commit-graph write) &&
-	test_path_is_file $objdir/info/$graph1
+	test_path_is_file $objdir/info/$graph1 &&
+	git commit-graph read --file=$graph1 >output &&
+	graph_read_expect "3" &&
+	test_cmp expect output
 '
 
 test_expect_success 'Add more commits' '
@@ -67,7 +85,10 @@ test_expect_success 'Add more commits' '
 
 test_expect_success 'write graph with merges' '
 	graph2=$(git commit-graph write)&&
-	test_path_is_file $objdir/info/$graph2
+	test_path_is_file $objdir/info/$graph2 &&
+	git commit-graph read --file=$graph2 >output &&
+	graph_read_expect "10" "large_edges" &&
+	test_cmp expect output
 '
 
 test_expect_success 'Add one more commit' '
@@ -92,7 +113,10 @@ test_expect_success 'Add one more commit' '
 
 test_expect_success 'write graph with new commit' '
 	graph3=$(git commit-graph write) &&
-	test_path_is_file $objdir/info/$graph3
+	test_path_is_file $objdir/info/$graph3 &&
+	git commit-graph read --file=$graph3 >output &&
+	graph_read_expect "11" "large_edges" &&
+	test_cmp expect output
 '
 
 test_expect_success 'write graph with nothing new' '
@@ -100,6 +124,9 @@ test_expect_success 'write graph with nothing new' '
 	test_path_is_file $objdir/info/$graph4 &&
 	printf $graph3 >expect &&
 	printf $graph4 >output &&
+	test_cmp expect output &&
+	git commit-graph read --file=$graph4 >output &&
+	graph_read_expect "11" "large_edges" &&
 	test_cmp expect output
 '
 
@@ -112,7 +139,10 @@ test_expect_success 'setup bare repo' '
 
 test_expect_success 'write graph in bare repo' '
 	graphbare=$(git commit-graph write) &&
-	test_path_is_file $baredir/info/$graphbare
+	test_path_is_file $baredir/info/$graphbare &&
+	git commit-graph read --file=$graphbare >output &&
+	graph_read_expect "11" "large_edges" &&
+	test_cmp expect output
 '
 
 test_done
-- 
2.7.4

