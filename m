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
	by dcvr.yhbt.net (Postfix) with ESMTP id D58401F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeB0Cds (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:48 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46274 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeB0CdW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:22 -0500
Received: by mail-qt0-f195.google.com with SMTP id m13so16666235qtg.13
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KWKk9ZbbeKto5hTWtZFA/HIk0rLV+VGghSUsQqMkpmI=;
        b=qAlpRFphF+g0m8dXmE0Oo4/q6n/iP32+iPbuWgReTRHoH5e1v1HNAlAUNxVBgOLCXp
         Ky7bWqTJMjzUF5igRUPYfzsgMOhMdMCpTm3SSYboF1jjAP+U3m0E4AnCX4TRiXLXiRoR
         ET8R0jioe9Y1UX3hbJoNAzcXSRI3i1Ah5dA6GfIYfrWPQ07/3bKqepK8ioUH3xfd5CeU
         D74LhRvyit3IUvBge+Y9Q1O5WRzA3mlJvvQH0xLFUpoocx0GhEri7mYIJeeNr7qGZE0C
         XDZ1ounv4aHPdMrvJvbK/bvwc52uVULQK0RWfrf7XejrCc/jqf28MVU0o3KcGAHraB3o
         jRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KWKk9ZbbeKto5hTWtZFA/HIk0rLV+VGghSUsQqMkpmI=;
        b=cqOUCjQ7KvDker1dqtVIM3d1NeP8erOTg1oyk4D9+aXPDr6N2tzjVxpSv05uG+fOw5
         WDrjHa6CBTXzvAUMCaSC7mrenuwk2LSW7KK5Vka7BtmZ0cF7Pedb7Ctz2HC3WUjoKKSk
         da5gVqvMGgJYiPYM+krp19PAWwekw5l89N/4Ki1yTQJi0FeYkq1gvILL7WIJexVpkqiR
         VzQm8V1aUtcfVXXlzRMqbP6f2nbXEv3DLQTCcYdd0cOiIDmcxNmJCg2sSKTcd7I7DdOw
         Pxl5hRa9p0pcQTmEF7yHJU3Ppx7wTjseAyp5TsKMIlnnDRRF7SiQ3QOyVjc8oX951i8z
         /+Tw==
X-Gm-Message-State: APf1xPBnIctpAej+tmOWfR7qD96rkxB8ZJZ0Oeb6/r84SU8bDAlLGLoH
        nr+2NaW+UEAaDgOEPm8Z9TWZhnpUFgs=
X-Google-Smtp-Source: AG47ELvEccgs0vkZR2VSUDVMVmswNA62kZqD5MBte9s61SyaB/4SdG9I9pwm+WcxxOrrv00L+G1Vnw==
X-Received: by 10.200.44.154 with SMTP id 26mr21289464qtw.214.1519698801660;
        Mon, 26 Feb 2018 18:33:21 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:21 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 07/13] commit-graph: implement git commit-graph read
Date:   Mon, 26 Feb 2018 21:33:01 -0500
Message-Id: <1519698787-190494-8-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to read commit graph files and summarize their contents.

Use the read subcommand to verify the contents of a commit graph file in the
tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  12 ++++
 builtin/commit-graph.c             |  56 +++++++++++++++
 commit-graph.c                     | 140 ++++++++++++++++++++++++++++++++++++-
 commit-graph.h                     |  23 ++++++
 t/t5318-commit-graph.sh            |  32 +++++++--
 5 files changed, 257 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index e688843..51cb038 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -9,6 +9,7 @@ git-commit-graph - Write and verify Git commit graph files
 SYNOPSIS
 --------
 [verse]
+'git commit-graph read' <options> [--object-dir <dir>]
 'git commit-graph write' <options> [--object-dir <dir>]
 
 
@@ -33,6 +34,11 @@ COMMANDS
 Write a commit graph file based on the commits found in packfiles.
 Includes all commits from the existing commit graph file.
 
+'read'::
+
+Read a graph file given by the commit-graph file and output basic
+details about the graph file. Used for debugging purposes.
+
 
 EXAMPLES
 --------
@@ -43,6 +49,12 @@ EXAMPLES
 $ git commit-graph write
 ------------------------------------------------
 
+* Read basic information from the commit-graph file.
++
+------------------------------------------------
+$ git commit-graph read
+------------------------------------------------
+
 
 GIT
 ---
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index a9d61f6..0e164be 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -7,10 +7,16 @@
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
+	N_("git commit-graph read [--object-dir <objdir>]"),
 	N_("git commit-graph write [--object-dir <objdir>]"),
 	NULL
 };
 
+static const char * const builtin_commit_graph_read_usage[] = {
+	N_("git commit-graph read [--object-dir <objdir>]"),
+	NULL
+};
+
 static const char * const builtin_commit_graph_write_usage[] = {
 	N_("git commit-graph write [--object-dir <objdir>]"),
 	NULL
@@ -20,6 +26,54 @@ static struct opts_commit_graph {
 	const char *obj_dir;
 } opts;
 
+static int graph_read(int argc, const char **argv)
+{
+	struct commit_graph *graph = 0;
+	char *graph_name;
+
+	static struct option builtin_commit_graph_read_options[] = {
+		OPT_STRING(0, "object-dir", &opts.obj_dir,
+			N_("dir"),
+			N_("The object directory to store the graph")),
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
+	graph_name = get_commit_graph_filename(opts.obj_dir);
+	graph = load_commit_graph_one(graph_name);
+
+	if (!graph)
+		die("graph file %s does not exist", graph_name);
+	FREE_AND_NULL(graph_name);
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
 	static struct option builtin_commit_graph_write_options[] = {
@@ -60,6 +114,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (argc > 0) {
+		if (!strcmp(argv[0], "read"))
+			return graph_read(argc, argv);
 		if (!strcmp(argv[0], "write"))
 			return graph_write(argc, argv);
 	}
diff --git a/commit-graph.c b/commit-graph.c
index 2251397..7b0cfb4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -39,11 +39,149 @@
 			GRAPH_OID_LEN + 8)
 
 
-static char *get_commit_graph_filename(const char *obj_dir)
+char *get_commit_graph_filename(const char *obj_dir)
 {
 	return xstrfmt("%s/info/commit-graph", obj_dir);
 }
 
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
+		return NULL;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return NULL;
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
+		error("graph signature %X does not match signature %X",
+		      graph_signature, GRAPH_SIGNATURE);
+		goto cleanup_fail;
+	}
+
+	graph_version = *(unsigned char*)(data + 4);
+	if (graph_version != GRAPH_VERSION) {
+		error("graph version %X does not match version %X",
+		      graph_version, GRAPH_VERSION);
+		goto cleanup_fail;
+	}
+
+	hash_version = *(unsigned char*)(data + 5);
+	if (hash_version != GRAPH_OID_VERSION) {
+		error("hash version %X does not match version %X",
+		      hash_version, GRAPH_OID_VERSION);
+		goto cleanup_fail;
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
+		int chunk_repeated = 0;
+
+		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
+
+		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
+			error("improper chunk offset %08x%08x", (uint32_t)(chunk_offset >> 32),
+			      (uint32_t)chunk_offset);
+			goto cleanup_fail;
+		}
+
+		switch (chunk_id) {
+		case GRAPH_CHUNKID_OIDFANOUT:
+			if (graph->chunk_oid_fanout)
+				chunk_repeated = 1;
+			else
+				graph->chunk_oid_fanout = (uint32_t*)(data + chunk_offset);
+			break;
+
+		case GRAPH_CHUNKID_OIDLOOKUP:
+			if (graph->chunk_oid_lookup)
+				chunk_repeated = 1;
+			else
+				graph->chunk_oid_lookup = data + chunk_offset;
+			break;
+
+		case GRAPH_CHUNKID_DATA:
+			if (graph->chunk_commit_data)
+				chunk_repeated = 1;
+			else
+				graph->chunk_commit_data = data + chunk_offset;
+			break;
+
+		case GRAPH_CHUNKID_LARGEEDGES:
+			if (graph->chunk_large_edges)
+				chunk_repeated = 1;
+			else
+				graph->chunk_large_edges = data + chunk_offset;
+			break;
+		}
+
+		if (chunk_repeated) {
+			error("chunk id %08x appears multiple times", chunk_id);
+			goto cleanup_fail;
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
+
+cleanup_fail:
+	munmap(graph_map, graph_size);
+	close(fd);
+	exit(1);
+}
+
 static void write_graph_chunk_fanout(struct hashfile *f,
 				     struct commit **commits,
 				     int nr_commits)
diff --git a/commit-graph.h b/commit-graph.h
index 4cb3f12..8b4b0f9 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -1,6 +1,29 @@
 #ifndef COMMIT_GRAPH_H
 #define COMMIT_GRAPH_H
 
+#include "git-compat-util.h"
+
+char *get_commit_graph_filename(const char *obj_dir);
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
+struct commit_graph *load_commit_graph_one(const char *graph_file);
+
 void write_commit_graph(const char *obj_dir);
 
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 7524d2a..0085e23 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -26,10 +26,28 @@ test_expect_success 'create commits and repack' '
 	git repack
 '
 
+graph_read_expect() {
+	OPTIONAL=""
+	NUM_CHUNKS=3
+	if test ! -z $2
+	then
+		OPTIONAL=" $2"
+		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
+	fi
+	cat >expect <<- EOF
+	header: 43475048 1 1 $NUM_CHUNKS 0
+	num_commits: $1
+	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
+	EOF
+	git commit-graph read >output &&
+	test_cmp expect output
+}
+
 test_expect_success 'write graph' '
 	cd "$TRASH_DIRECTORY/full" &&
 	graph1=$(git commit-graph write) &&
-	test_path_is_file $objdir/info/commit-graph
+	test_path_is_file $objdir/info/commit-graph &&
+	graph_read_expect "3"
 '
 
 test_expect_success 'Add more commits' '
@@ -72,7 +90,8 @@ test_expect_success 'Add more commits' '
 test_expect_success 'write graph with merges' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
-	test_path_is_file $objdir/info/commit-graph
+	test_path_is_file $objdir/info/commit-graph &&
+	graph_read_expect "10" "large_edges"
 '
 
 test_expect_success 'Add one more commit' '
@@ -99,13 +118,15 @@ test_expect_success 'Add one more commit' '
 test_expect_success 'write graph with new commit' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
-	test_path_is_file $objdir/info/commit-graph
+	test_path_is_file $objdir/info/commit-graph &&
+	graph_read_expect "11" "large_edges"
 '
 
 test_expect_success 'write graph with nothing new' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
-	test_path_is_file $objdir/info/commit-graph
+	test_path_is_file $objdir/info/commit-graph &&
+	graph_read_expect "11" "large_edges"
 '
 
 test_expect_success 'setup bare repo' '
@@ -118,7 +139,8 @@ test_expect_success 'setup bare repo' '
 test_expect_success 'write graph in bare repo' '
 	cd "$TRASH_DIRECTORY/bare" &&
 	git commit-graph write &&
-	test_path_is_file $baredir/info/commit-graph
+	test_path_is_file $baredir/info/commit-graph &&
+	graph_read_expect "11" "large_edges"
 '
 
 test_done
-- 
2.7.4

