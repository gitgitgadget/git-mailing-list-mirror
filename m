Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2643B1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeA3VkU (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:20 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39551 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752830AbeA3VkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:17 -0500
Received: by mail-qk0-f196.google.com with SMTP id n129so1375115qke.6
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RbwG7HRkr93oTLH8xCg+o49soNQ/afIrec2j9KPfhQ4=;
        b=vcvVBaW+oobU3dKlcfYYpH3ApM7tUw1lQ7njNOb5vHM5JQ8cZWbh9ks5FvvT9Hzuei
         8QzMEcJf7iusKtPqxzh7GYXT1a3axr0R8JguN5r3Qi6cvStVFpA7hIGV+1HssWk8PxIQ
         Q2ztqvleoq2ecn72zEdHmTn2KdoxRJ1fuyWYXpUVmH9XYiNyER7nnbJLn8mmvg92v3zM
         2z+LxQCT+X6hiqvfCfNl3tclfjBhTAwgmcMX8i0uk+iqRmlfT20H+uEUuzraaSnlpqnq
         9dK+HHXdSXenJYW76Fnw63cjPwjdiw1rS7Iymenul5+s2+H3DIQtfzA15Fw1TKlozk2N
         3upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RbwG7HRkr93oTLH8xCg+o49soNQ/afIrec2j9KPfhQ4=;
        b=AXkmmThtcDV8ESeMR7NwQxl/npynnaQSKRKLai2EMd5eQxxmkr1QoAUEv0prhDRN2J
         zv6nFCqkrmejwpmlxkA29FNkCut+r+3N3kwsjH86+rk4Da3GRdOTcTKnfp+o61sNLo4x
         moo3oNbsQny2ciinEfLHbW9C+uYAsokJdes0AcNe1R4yILz1J5q475/Jz6NZU14vyVxQ
         9TqYDBi0WbA6HmZ3YVduX1aKI8IUjXnIrLuomjH84q17y8crpLKQE7b+Blp87erE3qaI
         HW0c31XtDAoX8wlrehZxsDXoc6tPH/n/CHLVw3uT17TJ8/kLC+knQhIi5StFiEEgvd/I
         T6iw==
X-Gm-Message-State: AKwxytdLK0HJkGFRjYdRbjqPJ11VUbvMk3AI4pbsVnE7bwgTjuutzUbi
        7Ii4I8e3KdLYfWDLtIpfHhiP8Ld+
X-Google-Smtp-Source: AH8x2277w5NVfLfpfgESBCemUzpnQeLk8iKncNcdTMlbcaXQJb0ZDL5KY1WmkfR5hsX3FvDyix1vMg==
X-Received: by 10.55.110.193 with SMTP id j184mr44728886qkc.70.1517348416865;
        Tue, 30 Jan 2018 13:40:16 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:16 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 06/14] commit-graph: implement git-commit-graph --read
Date:   Tue, 30 Jan 2018 16:39:35 -0500
Message-Id: <1517348383-112294-7-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to read commit graph files and summarize their contents.

Use the --read option to verify the contents of a commit graph file in the
tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |   7 ++
 builtin/commit-graph.c             |  55 +++++++++++++++
 commit-graph.c                     | 138 ++++++++++++++++++++++++++++++++++++-
 commit-graph.h                     |  25 +++++++
 t/t5318-commit-graph.sh            |  28 ++++++--
 5 files changed, 247 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 3f3790d9a8..09aeaf6c82 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit-graph' --write <options> [--pack-dir <pack_dir>]
+'git commit-graph' --read <options> [--pack-dir <pack_dir>]
 
 EXAMPLES
 --------
@@ -20,6 +21,12 @@ EXAMPLES
 $ git commit-graph --write
 ------------------------------------------------
 
+* Read basic information from a graph file.
++
+------------------------------------------------
+$ git commit-graph --read --graph-hash=<hash>
+------------------------------------------------
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 7affd512f1..218740b1f8 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,15 +10,58 @@
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
+	N_("git commit-graph --read [--graph-hash=<hash>]"),
 	N_("git commit-graph --write [--pack-dir <packdir>]"),
 	NULL
 };
 
 static struct opts_commit_graph {
 	const char *pack_dir;
+	int read;
+	const char *graph_hash;
 	int write;
 } opts;
 
+static int graph_read(void)
+{
+	struct object_id graph_hash;
+	struct commit_graph *graph = 0;
+	const char *graph_file;
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
 	struct object_id *graph_hash = construct_commit_graph(opts.pack_dir);
@@ -36,8 +79,14 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
 			N_("dir"),
 			N_("The pack directory to store the graph") },
+		OPT_BOOL('r', "read", &opts.read,
+			N_("read graph file")),
 		OPT_BOOL('w', "write", &opts.write,
 			N_("write commit graph file")),
+		{ OPTION_STRING, 'H', "graph-hash", &opts.graph_hash,
+			N_("hash"),
+			N_("A hash for a specific graph file in the pack-dir."),
+			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_END(),
 	};
 
@@ -49,6 +98,10 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			     builtin_commit_graph_options,
 			     builtin_commit_graph_usage, 0);
 
+	if (opts.write + opts.read > 1)
+		usage_with_options(builtin_commit_graph_usage,
+				   builtin_commit_graph_options);
+
 	if (!opts.pack_dir) {
 		struct strbuf path = STRBUF_INIT;
 		strbuf_addstr(&path, get_object_directory());
@@ -56,6 +109,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 		opts.pack_dir = strbuf_detach(&path, NULL);
 	}
 
+	if (opts.read)
+		return graph_read();
 	if (opts.write)
 		return graph_write();
 
diff --git a/commit-graph.c b/commit-graph.c
index db2b7390c7..622a650259 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -48,6 +48,142 @@ char* get_commit_graph_filename_hash(const char *pack_dir,
 	return strbuf_detach(&head_path, &len);
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
+int close_commit_graph(struct commit_graph *g)
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
+
+	free(*g);
+	*g = NULL;
+}
+
+struct commit_graph *load_commit_graph_one(const char *graph_file, const char *pack_dir)
+{
+	void *graph_map;
+	const unsigned char *data;
+	struct commit_graph_header *hdr;
+	size_t graph_size;
+	struct stat st;
+	uint32_t i;
+	struct commit_graph *graph;
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
+	graph = alloc_commit_graph(strlen(pack_dir) + 1);
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
+				free_commit_graph(&graph);
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
 static void write_graph_chunk_fanout(struct sha1file *f,
 				     struct commit **commits,
 				     int nr_commits)
@@ -361,7 +497,7 @@ struct object_id *construct_commit_graph(const char *pack_dir)
 	sha1close(f, final_hash, CSUM_CLOSE | CSUM_FSYNC);
 
 	f_hash = (struct object_id *)malloc(sizeof(struct object_id));
-	memcpy(f_hash->hash, final_hash, GIT_MAX_RAWSZ);
+	hashcpy(f_hash->hash, final_hash);
 	fname = get_commit_graph_filename_hash(pack_dir, f_hash);
 
 	if (rename(graph_name, fname))
diff --git a/commit-graph.h b/commit-graph.h
index 7b3469a7df..e046ae575c 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -15,6 +15,31 @@ struct commit_graph_header {
 	unsigned char num_chunks;
 };
 
+extern struct commit_graph {
+	int graph_fd;
+
+	const unsigned char *data;
+	size_t data_len;
+
+	const struct commit_graph_header *hdr;
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
+} *commit_graph;
+
+extern int close_commit_graph(struct commit_graph *g);
+
+extern struct commit_graph *load_commit_graph_one(const char *graph_file, const char *pack_dir);
+
 extern struct object_id *construct_commit_graph(const char *pack_dir);
 
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 6bcd1cc264..da565624e3 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -25,11 +25,23 @@ test_expect_success 'create commits and repack' \
      done &&
      git repack'
 
+_graph_read_expect() {
+    cat >expect <<- EOF
+header: 43475048 01 01 14 04
+num_commits: $1
+chunks: oid_fanout oid_lookup commit_metadata large_edges
+pack_dir: $2
+EOF
+}
+
 test_expect_success 'write graph' \
     'graph1=$(git commit-graph --write) &&
-     test_path_is_file ${packdir}/graph-${graph1}.graph'
+     test_path_is_file ${packdir}/graph-${graph1}.graph &&
+     git commit-graph --read --graph-hash=${graph1} >output &&
+     _graph_read_expect "5" "${packdir}" &&
+     cmp expect output'
 
-t_expect_success 'Add more commits' \
+test_expect_success 'Add more commits' \
     'git reset --hard commits/3 &&
      for i in $(test_seq 6 10)
      do
@@ -79,7 +91,10 @@ t_expect_success 'Add more commits' \
 
 test_expect_success 'write graph with merges' \
     'graph2=$(git commit-graph --write) &&
-     test_path_is_file ${packdir}/graph-${graph2}.graph'
+     test_path_is_file ${packdir}/graph-${graph2}.graph &&
+     git commit-graph --read --graph-hash=${graph2} >output &&
+     _graph_read_expect "18" "${packdir}" &&
+     cmp expect output'
 
 test_expect_success 'setup bare repo' \
     'cd .. &&
@@ -87,10 +102,13 @@ test_expect_success 'setup bare repo' \
      cd bare &&
      git config core.graph true &&
      git config pack.threads 1 &&
-     baredir="objects/pack"'
+     baredir="./objects/pack"'
 
 test_expect_success 'write graph in bare repo' \
     'graphbare=$(git commit-graph --write) &&
-     test_path_is_file ${baredir}/graph-${graphbare}.graph'
+     test_path_is_file ${baredir}/graph-${graphbare}.graph &&
+     git commit-graph --read --graph-hash=${graphbare} >output &&
+     _graph_read_expect "18" "${baredir}" &&
+     cmp expect output'
 
 test_done
-- 
2.16.0.15.g9c3cf44.dirty

