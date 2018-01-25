Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53BCD1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeAYODS (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:03:18 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44002 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeAYOC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:56 -0500
Received: by mail-qt0-f196.google.com with SMTP id s3so19353890qtb.10
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kaYmq+wz59DQUMUpsT6NEczBwUcdJD0EEwPIc+lkeGA=;
        b=krJ/SJ24dcu6yGQ0AtB1RvSLvkGSRqY1aiJHiuEByXozFom4btVW1oUHp3fROu0rk5
         Zf5ZlSol6TkdUqRsW85wRorUoZKxBy6RLwkd6rcIWZtzNoNqPvHc5r/krIGZvRFX7Dy5
         TUitV6sirsbiHr2jXu2o6VEHH1yjnN3E1+V0ahhRORDuY4g0RO2AF1CRi3GE9ricuo5x
         kZAEU7VDpBDrU4gtHR4Ze5x9mH5a3wPyO+6T+zqV5GoTVWRjoc2y+tGrMtHfoDD8sD3p
         MYHdSQuEK2a5NOKCADXhpneGqshZMkWO7Vq7fltbpwj9wvLDADGW7cLoOHsSXZLUh6UY
         cOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kaYmq+wz59DQUMUpsT6NEczBwUcdJD0EEwPIc+lkeGA=;
        b=XWewly0McQavgoVKQ8W13NNgum8ELNgUdlBD2QiBqT9ADIxus4WPwhsBENgJD5dE49
         0kBHKuFtSy0Sgj1AuZDQNMb8vnhEpWI7NVKY7auIw5hTfQtBAkpsMwfHyRStTeOkI0R+
         5o9OaH8YTaFhhjnUpkZvqZy/+DbAIqPLdrzUEqZhf7q5XsZV6twvllBbTuYFRD1xTXDQ
         /GP6tirDr2shiXI0L5jhPLWuzQTOHasd9g6dRYjQ9StzfTDyrfASum4DLKfdCrzr92Pq
         GR6YAXb0fckYjVYJhqN3HgsAtigAxzi/+59rAMChc5AiXxyFi6Zwpo79uivVTzFZ+2mJ
         dfdQ==
X-Gm-Message-State: AKwxytdCeTpQAuxuZZnbTfuZKZsxIJ3NAfkHTZPhLK1plFUIO8AkUnOC
        JYLVUnCAm2jg3OAcqVt8UD6xVVSI
X-Google-Smtp-Source: AH8x227grgAF9zO2KPx/pPMWd6ERKdoPZ9OC9PBQM8HjmWb+jRYPEMwIdt5gNdlXoLd/llEZ9gL+uw==
X-Received: by 10.55.23.204 with SMTP id 73mr1368834qkx.138.1516888975591;
        Thu, 25 Jan 2018 06:02:55 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:54 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 12/14] packed-graph: read only from specific pack-indexes
Date:   Thu, 25 Jan 2018 09:02:29 -0500
Message-Id: <20180125140231.65604-13-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-graph to inspect the objects only in a certain list of
pack-indexes within the given pack directory. This allows updating
the graph iteratively, since we add all commits stored in a previous
packed graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-graph.txt | 12 ++++++++++++
 builtin/graph.c             | 26 +++++++++++++++++++++++---
 packed-graph.c              | 27 +++++++++++++++++++++++----
 packed-graph.h              |  2 +-
 packfile.c                  |  4 ++--
 packfile.h                  |  2 ++
 t/t5319-graph.sh            | 10 ++++++----
 7 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-graph.txt b/Documentation/git-graph.txt
index f4f1048d28..b68a61ddea 100644
--- a/Documentation/git-graph.txt
+++ b/Documentation/git-graph.txt
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
 
@@ -65,6 +70,13 @@ $ git graph --write
 $ git graph --write --update-head --delete-expired
 ------------------------------------------------
 
+* Write a graph file, extending the current graph file using commits
+* in <packfile>, update graph-head, and delete the old graph-<oid>.graph file.
++
+------------------------------------------------
+$ echo <packfile> | git graph --write --update-head --delete-expired --stdin-packs
+------------------------------------------------
+
 * Read basic information from a graph file.
 +
 ------------------------------------------------
diff --git a/builtin/graph.c b/builtin/graph.c
index adf779b601..3cace3a18c 100644
--- a/builtin/graph.c
+++ b/builtin/graph.c
@@ -12,7 +12,7 @@ static char const * const builtin_graph_usage[] ={
 	N_("git graph [--pack-dir <packdir>]"),
 	N_("git graph --clear [--pack-dir <packdir>]"),
 	N_("git graph --read [--graph-id=<oid>]"),
-	N_("git graph --write [--pack-dir <packdir>] [--update-head] [--delete-expired]"),
+	N_("git graph --write [--pack-dir <packdir>] [--update-head] [--delete-expired] [--stdin-packs]"),
 	NULL
 };
 
@@ -24,6 +24,7 @@ static struct opts_graph {
 	int write;
 	int update_head;
 	int delete_expired;
+	int stdin_packs;
 	int has_existing;
 	struct object_id old_graph_oid;
 } opts;
@@ -113,7 +114,24 @@ static void update_head_file(const char *pack_dir, const struct object_id *graph
 
 static int graph_write(void)
 {
-	struct object_id *graph_id = construct_graph(opts.pack_dir);
+	struct object_id *graph_id;
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
+	graph_id = construct_graph(opts.pack_dir, pack_indexes, num_packs);
 
 	if (opts.update_head)
 		update_head_file(opts.pack_dir, graph_id);
@@ -150,7 +168,9 @@ int cmd_graph(int argc, const char **argv, const char *prefix)
 			N_("update graph-head to written graph file")),
 		OPT_BOOL('d', "delete-expired", &opts.delete_expired,
 			N_("delete expired head graph file")),
-		{ OPTION_STRING, 'M', "graph-id", &opts.graph_id,
+		OPT_BOOL('s', "stdin-packs", &opts.stdin_packs,
+			N_("only scan packfiles listed by stdin")),
+		{ OPTION_STRING, 'G', "graph-id", &opts.graph_id,
 			N_("oid"),
 			N_("An OID for a specific graph file in the pack-dir."),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
diff --git a/packed-graph.c b/packed-graph.c
index 343b231973..0dc68a077e 100644
--- a/packed-graph.c
+++ b/packed-graph.c
@@ -401,7 +401,7 @@ static int fill_packed_commit(struct commit *item, struct packed_graph *g, uint3
  *  2. date
  *  3. parents.
  *
- * Returns 1 iff the commit was found in the packed graph.
+ * Returns 1 if and only if the commit was found in the packed graph.
  *
  * See parse_commit_buffer() for the fallback after this call.
  */
@@ -427,7 +427,7 @@ int parse_packed_commit(struct commit *item)
 			return fill_packed_commit(item, packed_graph, pos);
 	}
 
-	return parse_commit_internal(item, 0, 0);
+	return 0;
 }
 
 static void write_graph_chunk_fanout(
@@ -638,7 +638,7 @@ static int if_packed_commit_add_to_list(const struct object_id *oid,
 	return 0;
 }
 
-struct object_id *construct_graph(const char *pack_dir)
+struct object_id *construct_graph(const char *pack_dir, char **pack_indexes, int nr_packs)
 {
 	// Find a list of oids, adding the pointer to a list.
 	struct packed_oid_list oids;
@@ -678,7 +678,26 @@ struct object_id *construct_graph(const char *pack_dir)
 		oids.num = packed_graph->num_commits;
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
diff --git a/packed-graph.h b/packed-graph.h
index 6010ce3e53..97ce1e2652 100644
--- a/packed-graph.h
+++ b/packed-graph.h
@@ -58,7 +58,7 @@ extern struct object_id *get_nth_commit_oid(struct packed_graph *g,
 					    uint32_t n,
 					    struct object_id *oid);
 
-extern struct object_id *construct_graph(const char *pack_dir);
+extern struct object_id *construct_graph(const char *pack_dir, char **pack_indexes, int nr_packs);
 extern int close_graph(struct packed_graph *g);
 
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
diff --git a/t/t5319-graph.sh b/t/t5319-graph.sh
index 4552795179..969150cd21 100755
--- a/t/t5319-graph.sh
+++ b/t/t5319-graph.sh
@@ -34,8 +34,8 @@ _graph_git_two_modes() {
 
 _graph_git_behavior() {
     test_expect_success 'check normal git operations' \
-        '_graph_git_two_modes "log --oneline master" &&
-         _graph_git_two_modes "log --topo-order master" &&
+        '_graph_git_two_modes "log --oneline $1" &&
+         _graph_git_two_modes "log --topo-order $1" &&
          _graph_git_two_modes "log --graph $1 $2" &&
          _graph_git_two_modes "branch -vv" &&
          _graph_git_two_modes "merge-base -a $1 $2"'
@@ -136,7 +136,9 @@ test_expect_success 'Add more commits' \
         git commit -m "commit $i" &&
         git branch commits/$i
      done &&
-     git repack'
+     ls ${packdir} | grep idx >existing-idx &&
+     git repack &&
+     ls ${packdir} | grep idx | grep -v --file=existing-idx >new-idx'
 
 # Current graph structure:
 #
@@ -173,7 +175,7 @@ _graph_git_behavior commits/20 merge/1
 _graph_git_behavior commits/20 merge/2
 
 test_expect_success 'write graph with merges' \
-    'graph3=$(git graph --write --update-head --delete-expired) &&
+    'graph3=$(cat new-idx | git graph --write --update-head --delete-expired --stdin-packs) &&
      test_path_is_file ${packdir}/graph-${graph3}.graph &&
      test_path_is_missing ${packdir}/graph-${graph2}.graph &&
      test_path_is_file ${packdir}/graph-${graph1}.graph &&
-- 
2.16.0

