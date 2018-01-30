Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38BE21F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeA3Vkf (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:35 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42272 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeA3VkY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:24 -0500
Received: by mail-qk0-f196.google.com with SMTP id k201so12132809qke.9
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=96orTY5nARu8ofyf+zEqyxgxUtZM7f/wBEh2HHu0/uE=;
        b=cWNqn8W+c60Sw/cAN7H9s1xDtc5juUG2lx9v6VEj/r2+CEr3ZU3isuwscALZ4IIye4
         DF9TiI50gzfauVO2LKPeBcNpHM/fzxUuKXcG5+q+t3VLj7D7WUwybRZgTXc0qG+cg7Fy
         0Cc6/p0QJW3CyGPuTnIGj1JVgqG+rPnex2owt7hiUgq75c8Sc/lLK2zH74lZmYcPuuBW
         LQmEMbIYnnOHtRPoEG/Os57fZUuyju9osm2gbmKQYI3pfMuKK4HzBtC6R6+crs6DaLcm
         J4DvFexuM58/0X0VWaWUMOdBxY8Es+JWBcLZ5IG+VYl/MEYEigsZtaElYGDe3b9gljZ0
         FCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=96orTY5nARu8ofyf+zEqyxgxUtZM7f/wBEh2HHu0/uE=;
        b=fj/vqSUyzdT5RDNbPjY/bKeLhdQzqKoKWgpCVZQXyTL8GTTEk9ZFj7Ahs8VoWMSIS6
         +EINNbkUjz2/IgU4C9SY8CwhDn9RTnv6u0apJNqxMq8nmPTe5XbD/8dv6Rwl01n2FLa2
         0wHJ2Q/yYifXJhjnXuioIOk3Ol4lXZNEpBvBp1BC7s8Ke2gr05A9t8wA2fGIkpsG0KE8
         Xsqc9IuDi8db9FctM0XRt34a9l6OxdKqcmsw4IoaHypyPsRr6NlJTdunZY+jxPiywxkt
         RpDcyg9VTiSI3Qrt/+lA8w52ohYviH2gK5V+jMHpIJuD6S0vAjfIERxBrol/CmbtgU8z
         1Bkw==
X-Gm-Message-State: AKwxytdeowihLfLQyjnUPhaM4GbympfldE6EbObX5TKrpCS9OGukduuX
        LNCdAzCPmtI01NBdEN3AmuuO+fdk
X-Google-Smtp-Source: AH8x226zKnTv3Pa3TY2geYdlW63CklbRvDBsLP/BrVPbZZp/K3nL10lc2bqGmuAXbmhe0Bppd05wiw==
X-Received: by 10.55.23.99 with SMTP id i96mr45162351qkh.104.1517348423072;
        Tue, 30 Jan 2018 13:40:23 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:22 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 12/14] commit-graph: read only from specific pack-indexes
Date:   Tue, 30 Jan 2018 16:39:41 -0500
Message-Id: <1517348383-112294-13-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to inspect the objects only in a certain list
of pack-indexes within the given pack directory. This allows updating
the commit graph iteratively, since we add all commits stored in a
previous commit graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 13 +++++++++++++
 builtin/commit-graph.c             | 25 ++++++++++++++++++++++---
 commit-graph.c                     | 25 +++++++++++++++++++++++--
 commit-graph.h                     |  4 +++-
 packfile.c                         |  4 ++--
 packfile.h                         |  2 ++
 t/t5318-commit-graph.sh            |  6 ++++--
 7 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 7b376e9212..d0571cd896 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -43,6 +43,11 @@ OPTIONS
 	When used with --write and --update-head, delete the graph file
 	previously referenced by graph-head.
 
+--stdin-packs::
+	When used with --write, generate the new graph by walking objects
+	only in the specified packfiles and any commits in the
+	existing graph-head.
+
 EXAMPLES
 --------
 
@@ -65,6 +70,14 @@ $ git commit-graph --write
 $ git commit-graph --write --update-head --delete-expired
 ------------------------------------------------
 
+* Write a graph file, extending the current graph file using commits
+* in <pack-index>, update graph-head, and delete the old graph-<hash>.graph
+* file.
++
+------------------------------------------------
+$ echo <pack-index> | git commit-graph --write --update-head --delete-expired --stdin-packs
+------------------------------------------------
+
 * Read basic information from a graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 766f09e6fc..80a409e784 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -12,7 +12,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
 	N_("git commit-graph --clear [--pack-dir <packdir>]"),
 	N_("git commit-graph --read [--graph-hash=<hash>]"),
-	N_("git commit-graph --write [--pack-dir <packdir>] [--update-head] [--delete-expired]"),
+	N_("git commit-graph --write [--pack-dir <packdir>] [--update-head] [--delete-expired] [--stdin-packs]"),
 	NULL
 };
 
@@ -24,6 +24,7 @@ static struct opts_commit_graph {
 	int write;
 	int update_head;
 	int delete_expired;
+	int stdin_packs;
 	int has_existing;
 	struct object_id old_graph_hash;
 } opts;
@@ -114,7 +115,24 @@ static void update_head_file(const char *pack_dir, const struct object_id *graph
 
 static int graph_write(void)
 {
-	struct object_id *graph_hash = construct_commit_graph(opts.pack_dir);
+	struct object_id *graph_hash;
+	char **pack_indexes = NULL;
+	int num_packs = 0;
+	int size_packs = 0;
+
+	if (opts.stdin_packs) {
+		struct strbuf buf = STRBUF_INIT;
+		size_packs = 128;
+		ALLOC_ARRAY(pack_indexes, size_packs);
+
+		while (strbuf_getline(&buf, stdin) != EOF) {
+			ALLOC_GROW(pack_indexes, num_packs + 1, size_packs);
+			pack_indexes[num_packs++] = buf.buf;
+			strbuf_detach(&buf, NULL);
+		}
+	}
+
+	graph_hash = construct_commit_graph(opts.pack_dir, pack_indexes, num_packs);
 
 	if (opts.update_head)
 		update_head_file(opts.pack_dir, graph_hash);
@@ -122,7 +140,6 @@ static int graph_write(void)
 	if (graph_hash)
 		printf("%s\n", oid_to_hex(graph_hash));
 
-
 	if (opts.delete_expired && opts.update_head && opts.has_existing &&
 	    oidcmp(graph_hash, &opts.old_graph_hash)) {
 		char *old_path = get_commit_graph_filename_hash(opts.pack_dir,
@@ -153,6 +170,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			N_("update graph-head to written graph file")),
 		OPT_BOOL('d', "delete-expired", &opts.delete_expired,
 			N_("delete expired head graph file")),
+		OPT_BOOL('s', "stdin-packs", &opts.stdin_packs,
+			N_("only scan packfiles listed by stdin")),
 		{ OPTION_STRING, 'H', "graph-hash", &opts.graph_hash,
 			N_("hash"),
 			N_("A hash for a specific graph file in the pack-dir."),
diff --git a/commit-graph.c b/commit-graph.c
index fc816533c6..e5a1d9ee8b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -638,7 +638,9 @@ static int if_packed_commit_add_to_list(const struct object_id *oid,
 	return 0;
 }
 
-struct object_id *construct_commit_graph(const char *pack_dir)
+struct object_id *construct_commit_graph(const char *pack_dir,
+					 char **pack_indexes,
+					 int nr_packs)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -674,7 +676,26 @@ struct object_id *construct_commit_graph(const char *pack_dir)
 		oids.num = commit_graph->num_commits;
 	}
 
-	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
+	if (pack_indexes) {
+		int pack_dir_len = strlen(pack_dir) + 1;
+		struct strbuf packname = STRBUF_INIT;
+		strbuf_add(&packname, pack_dir, pack_dir_len - 1);
+		strbuf_addch(&packname, '/');
+		for (i = 0; i < nr_packs; i++) {
+			struct packed_git *p;
+			strbuf_setlen(&packname, pack_dir_len);
+			strbuf_addstr(&packname, pack_indexes[i]);
+			p = add_packed_git(packname.buf, packname.len, 1);
+			if (!p)
+				die("error adding pack %s", packname.buf);
+			if (open_pack_index(p))
+				die("error opening index for %s", packname.buf);
+			for_each_object_in_pack(p, if_packed_commit_add_to_list, &oids);
+			close_pack(p);
+		}
+	} else {
+		for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
+	}
 	QSORT(oids.list, oids.num, commit_compare);
 
 	count_distinct = 1;
diff --git a/commit-graph.h b/commit-graph.h
index 05ddbbe165..3ae1eadce0 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -60,6 +60,8 @@ extern struct object_id *get_nth_commit_oid(struct commit_graph *g,
 					    uint32_t n,
 					    struct object_id *oid);
 
-extern struct object_id *construct_commit_graph(const char *pack_dir);
+extern struct object_id *construct_commit_graph(const char *pack_dir,
+						char **pack_indexes,
+						int nr_packs);
 
 #endif
diff --git a/packfile.c b/packfile.c
index 4a5fe7ab18..48133bd669 100644
--- a/packfile.c
+++ b/packfile.c
@@ -299,7 +299,7 @@ void close_pack_index(struct packed_git *p)
 	}
 }
 
-static void close_pack(struct packed_git *p)
+void close_pack(struct packed_git *p)
 {
 	close_pack_windows(p);
 	close_pack_fd(p);
@@ -1860,7 +1860,7 @@ int has_pack_index(const unsigned char *sha1)
 	return 1;
 }
 
-static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
+int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
 {
 	uint32_t i;
 	int r = 0;
diff --git a/packfile.h b/packfile.h
index 0cdeb54dcd..cde868feb6 100644
--- a/packfile.h
+++ b/packfile.h
@@ -61,6 +61,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
+extern void close_pack(struct packed_git *);
 extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
@@ -133,6 +134,7 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data);
+extern int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data);
 extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
 
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 93b0d4f51b..b9a73f398c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -137,7 +137,9 @@ test_expect_success 'Add more commits' \
         git commit -m "commit $i" &&
         git branch commits/$i
      done &&
-     git repack'
+     ls ${packdir} | grep idx >existing-idx &&
+     git repack &&
+     ls ${packdir} | grep idx | grep -v --file=existing-idx >new-idx'
 
 # Current graph structure:
 #
@@ -174,7 +176,7 @@ _graph_git_behavior commits/20 merge/1
 _graph_git_behavior commits/20 merge/2
 
 test_expect_success 'write graph with merges' \
-    'graph3=$(git commit-graph --write --update-head --delete-expired) &&
+    'graph3=$(cat new-idx | git commit-graph --write --update-head --delete-expired --stdin-packs) &&
      test_path_is_file ${packdir}/graph-${graph3}.graph &&
      test_path_is_missing ${packdir}/graph-${graph2}.graph &&
      test_path_is_file ${packdir}/graph-${graph1}.graph &&
-- 
2.16.0.15.g9c3cf44.dirty

