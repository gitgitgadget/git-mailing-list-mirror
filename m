Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E181F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753129AbeDJM5H (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:57:07 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34282 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753104AbeDJM5F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:57:05 -0400
Received: by mail-pf0-f193.google.com with SMTP id q9so8243302pff.1
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vzGpW4DgW7feRdqnZDUuEQYRl0QpZ7Wopdjnb7tjyKA=;
        b=j5477dY0IMaXjpP2NxkIGGsZW0ohYSXzMR19L97/Dp7GW38bqVIiy3G+a4HblkJp5b
         7D9LD1rrYUJgQQaL+3CL1Bq5aDYX9fROf8EgN6X/RQJLmZJdTpFHUiRUP+xcm/OylHOV
         rchC8N97NE/uoRQGgA4IYFksJZM8smcVaF05fpYR86ACiXb+d7sToDy3ckfbmIiUcaET
         gN55sG6eSUsN1XMxo3dP/UXNB62FUEk2k92MA9VLw/3YhNTv4pWFmFe6IR2P9EXZw5h6
         gDGcLjSCZpkrTFErjSV+icLHZhZrpv6abWitAwbOlU8A5bchRCkrdcalzJXk1Biff+lT
         crag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vzGpW4DgW7feRdqnZDUuEQYRl0QpZ7Wopdjnb7tjyKA=;
        b=FgnE9BgXEmFswnTF5SnWMkpxPCwkWg3n3CM0XBhdCKVYVz68qpOarI72VH+dn2JY10
         CRfDjt+e1F7L5aj9bT/61BFxx49euYUupRyGbwI+MGV5Y+HwQDWGA4zw+VMrHV70ntlH
         fY8F+vZ7CmdhMwh5RhI025glfE5j5pLSGbebckIvG8U3dc8uZx7CNTXmMr6EvAT+oY8x
         63UU1i6k0cQChvA8R6kBCY8Kn97mRIeHj29CLNfrSJWEHgywkP9cVSC2PQU93H5zS4SM
         iQ5oHvcX/u9n9Pl+hAv0gO8RFV6uocvijMe00VeCKbSoM5mNiTACFCZFCwa1s17daktj
         5n+g==
X-Gm-Message-State: ALQs6tBVZZuPTDVQ1rtAw+f4jLlV8bv8hIGUOts15aiBPmZh3Y/j6Vw2
        zO4xiAit/rpXtv3eebqgeXl8IccH64g=
X-Google-Smtp-Source: AIpwx4/KD5PSGZMiXg1yf+XtibpGL2aA4WsfhsAFDLy6nBaOdBnXD0MDlsxuA5hF4lgt5fU+WELUeQ==
X-Received: by 10.101.102.211 with SMTP id c19mr239020pgw.78.1523365024330;
        Tue, 10 Apr 2018 05:57:04 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id l10sm4421666pgp.35.2018.04.10.05.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 05:57:03 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v8 08/14] commit-graph: implement git commit-graph read
Date:   Tue, 10 Apr 2018 08:56:02 -0400
Message-Id: <20180410125608.39443-9-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410125608.39443-1-dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Teach git-commit-graph to read commit graph files and summarize their contents.

Use the read subcommand to verify the contents of a commit graph file in the
tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  12 +++
 builtin/commit-graph.c             |  56 ++++++++++++
 commit-graph.c                     | 137 ++++++++++++++++++++++++++++-
 commit-graph.h                     |  23 +++++
 t/t5318-commit-graph.sh            |  32 +++++--
 5 files changed, 254 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 47996e8f89..8aad8303f5 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -9,6 +9,7 @@ git-commit-graph - Write and verify Git commit graph files
 SYNOPSIS
 --------
 [verse]
+'git commit-graph read' [--object-dir <dir>]
 'git commit-graph write' <options> [--object-dir <dir>]
 
 
@@ -35,6 +36,11 @@ COMMANDS
 Write a commit graph file based on the commits found in packfiles.
 Includes all commits from the existing commit graph file.
 
+'read'::
+
+Read a graph file given by the commit-graph file and output basic
+details about the graph file. Used for debugging purposes.
+
 
 EXAMPLES
 --------
@@ -45,6 +51,12 @@ EXAMPLES
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
index 26b6360289..efd39331d7 100644
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
+	struct commit_graph *graph = NULL;
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
index f3f7c4f189..b1bd3a892d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -39,11 +39,146 @@
 			GRAPH_OID_LEN + 8)
 
 
-static char *get_commit_graph_filename(const char *obj_dir)
+char *get_commit_graph_filename(const char *obj_dir)
 {
 	return xstrfmt("%s/info/commit-graph", obj_dir);
 }
 
+static struct commit_graph *alloc_commit_graph(void)
+{
+	struct commit_graph *g = xcalloc(1, sizeof(*g));
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
+	graph_signature = get_be32(data);
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
+		uint64_t chunk_offset = get_be64(chunk_lookup + 4);
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
index 16fea993ab..2528478f06 100644
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
index d7b635bd68..2f44f91193 100755
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
2.17.0

