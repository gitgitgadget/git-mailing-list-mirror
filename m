Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B88F1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeAYODB (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:03:01 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42382 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeAYOCv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:51 -0500
Received: by mail-qt0-f194.google.com with SMTP id c2so19340531qtn.9
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/7IBv24pQ68DbU2z8j6LGOalS6Ey0x+G2IlTN8b/lf0=;
        b=emDKef6g8O0+FvLz+O4PdQLbckXsaHeoMC5GMV2j0ZC3avhWV/5ckpyVIKYV2CBJms
         WUxf8WnNVcvzby8vM2/PGsfZvT0dqobDQ6vedVvujgH/rNvVcDL+Iokqcoej9NMPPH0C
         pC2O4qlhJKYNjqx326eHgYRqT7TDYUznMlgFEdPY155WiTAEPBMy24oLk5aSKWEYf+CP
         aRN52ceWTxWbpD8JMQZt3jhymrsiLwrOBvx14+FaUE9UrPuoj2k5wpYJu06QBg1ENk5Y
         PYgdG43pQgReMYNRga0nAlOSeNxuNZae4bB5Hq6ECuQmQsJVw5BfWV9LKfDnk4KXtjgo
         KQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/7IBv24pQ68DbU2z8j6LGOalS6Ey0x+G2IlTN8b/lf0=;
        b=WQY/+fJgkOLRrGXKexHeAgv7KRdhvlTglrslFrr2Iqg9ILKmyorI6g3ZUnFupohD9g
         00Ma8nZLctvKHcwXu9Qdtz1UjFJEa7PTmE10RSZODwzP6rSvOUk6qeSEX6+JCKBfUof1
         MB0sQiHKAjwkqIItmuTaSUKbQFuRh/yCHqEUsB3virJMio8EvD1+6R/vGsj9v/3takdz
         MM+NZy7wMj+RwXW3uPxbuMaK9rw9KV6dNKbvdzehBgs2xiUprJKOxy/FPkA+JrLe+E7Y
         Cybazp3bhGOmXM94TxpdIIf1hI9jDmWnBSD9n6qnuaT7ZCCzsGW4UxUKJhQXaoxnmNya
         /szw==
X-Gm-Message-State: AKwxytc8EYJltb85zHerEO1B7fV56V9hz7PJ/UdPb1jQhOkcKUdtkgub
        1TWl0tnSRFRjB6MKO1PROTfYaNA6
X-Google-Smtp-Source: AH8x2252HFYT2tsHEfIHAqEEipZ2xvWt5gq8e3lRkZkmOHqSNA4GgiJ5fE4561KV79OxIb90GNKf8g==
X-Received: by 10.55.150.6 with SMTP id y6mr13752037qkd.155.1516888970334;
        Thu, 25 Jan 2018 06:02:50 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:49 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 08/14] graph: implement git-graph --update-head
Date:   Thu, 25 Jan 2018 09:02:25 -0500
Message-Id: <20180125140231.65604-9-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to have multiple packed graph files in a pack directory,
but only one is important at a time. Use a 'graph_head' file to point
to the important file. Teach git-graph to write 'graph_head' upon
writing a new packed graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-graph.txt | 38 ++++++++++++++++++++++++++++++++++++--
 builtin/graph.c             | 38 +++++++++++++++++++++++++++++++++++---
 packed-graph.c              | 25 +++++++++++++++++++++++++
 packed-graph.h              |  1 +
 t/t5319-graph.sh            | 12 ++++++++++--
 5 files changed, 107 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-graph.txt b/Documentation/git-graph.txt
index 0939c3f1be..ac20aa67a9 100644
--- a/Documentation/git-graph.txt
+++ b/Documentation/git-graph.txt
@@ -12,19 +12,53 @@ SYNOPSIS
 'git graph' --write <options> [--pack-dir <pack_dir>]
 'git graph' --read <options> [--pack-dir <pack_dir>]
 
+OPTIONS
+-------
+--pack-dir::
+	Use given directory for the location of packfiles, graph-head,
+	and graph files.
+
+--read::
+	Read a graph file given by the graph-head file and output basic
+	details about the graph file. (Cannot be combined with --write.)
+
+--graph-id::
+	When used with --read, consider the graph file graph-<oid>.graph.
+
+--write::
+	Write a new graph file to the pack directory. (Cannot be combined
+	with --read.)
+
+--update-head::
+	When used with --write, update the graph-head file to point to
+	the written graph file.
+
 EXAMPLES
 --------
 
+* Output the OID of the graph file pointed to by <dir>/graph-head.
++
+------------------------------------------------
+$ git graph --pack-dir=<dir>
+------------------------------------------------
+
 * Write a graph file for the packed commits in your local .git folder.
 +
 ------------------------------------------------
-$ git midx --write
+$ git graph --write
+------------------------------------------------
+
+* Write a graph file for the packed commits in your local .git folder,
+* and update graph-head.
++
+------------------------------------------------
+$ git graph --write --update-head
 ------------------------------------------------
 
 * Read basic information from a graph file.
 +
 ------------------------------------------------
-$ git midx --read --graph-id=<oid>
+$ git graph --read --graph-id=<oid>
 ------------------------------------------------
 
 CONFIGURATION
diff --git a/builtin/graph.c b/builtin/graph.c
index bc66722924..0760d99f43 100644
--- a/builtin/graph.c
+++ b/builtin/graph.c
@@ -11,7 +11,7 @@
 static char const * const builtin_graph_usage[] ={
 	N_("git graph [--pack-dir <packdir>]"),
 	N_("git graph --read [--graph-id=<oid>]"),
-	N_("git graph --write [--pack-dir <packdir>]"),
+	N_("git graph --write [--pack-dir <packdir>] [--update-head]"),
 	NULL
 };
 
@@ -20,6 +20,9 @@ static struct opts_graph {
 	int read;
 	const char *graph_id;
 	int write;
+	int update_head;
+	int has_existing;
+	struct object_id old_graph_oid;
 } opts;
 
 static int graph_read(void)
@@ -30,8 +33,8 @@ static int graph_read(void)
 
 	if (opts.graph_id && strlen(opts.graph_id) == GIT_MAX_HEXSZ)
 		get_oid_hex(opts.graph_id, &graph_oid);
-	else
-		die("no graph id specified");
+	else if (!get_graph_head_oid(opts.pack_dir, &graph_oid))
+		die("no graph-head exists.");
 
 	graph_file = get_graph_filename_oid(opts.pack_dir, &graph_oid);
 	graph = load_packed_graph_one(graph_file, opts.pack_dir);
@@ -62,10 +65,33 @@ static int graph_read(void)
 	return 0;
 }
 
+static void update_head_file(const char *pack_dir, const struct object_id *graph_id)
+{
+	struct strbuf head_path = STRBUF_INIT;
+	int fd;
+	struct lock_file lk = LOCK_INIT;
+
+	strbuf_addstr(&head_path, pack_dir);
+	strbuf_addstr(&head_path, "/");
+	strbuf_addstr(&head_path, "graph-head");
+
+	fd = hold_lock_file_for_update(&lk, head_path.buf, LOCK_DIE_ON_ERROR);
+	strbuf_release(&head_path);
+
+	if (fd < 0)
+		die_errno("unable to open graph-head");
+
+	write_in_full(fd, oid_to_hex(graph_id), GIT_MAX_HEXSZ);
+	commit_lock_file(&lk);
+}
+
 static int graph_write(void)
 {
 	struct object_id *graph_id = construct_graph(opts.pack_dir);
 
+	if (opts.update_head)
+		update_head_file(opts.pack_dir, graph_id);
+
 	if (graph_id)
 		printf("%s\n", oid_to_hex(graph_id));
 
@@ -83,6 +109,8 @@ int cmd_graph(int argc, const char **argv, const char *prefix)
 			N_("read graph file")),
 		OPT_BOOL('w', "write", &opts.write,
 			N_("write graph file")),
+		OPT_BOOL('u', "update-head", &opts.update_head,
+			N_("update graph-head to written graph file")),
 		{ OPTION_STRING, 'M', "graph-id", &opts.graph_id,
 			N_("oid"),
 			N_("An OID for a specific graph file in the pack-dir."),
@@ -111,11 +139,15 @@ int cmd_graph(int argc, const char **argv, const char *prefix)
 		opts.pack_dir = strbuf_detach(&path, NULL);
 	}
 
+	opts.has_existing = !!get_graph_head_oid(opts.pack_dir, &opts.old_graph_oid);
+
 	if (opts.read)
 		return graph_read();
 	if (opts.write)
 		return graph_write();
 
+	if (opts.has_existing)
+		printf("%s\n", oid_to_hex(&opts.old_graph_oid));
 	return 0;
 }
 
diff --git a/packed-graph.c b/packed-graph.c
index eaa656becb..5723f163ae 100644
--- a/packed-graph.c
+++ b/packed-graph.c
@@ -35,6 +35,31 @@
 #define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
 			GRAPH_OID_LEN + sizeof(struct packed_graph_header))
 
+struct object_id *get_graph_head_oid(const char *pack_dir, struct object_id *oid)
+{
+	struct strbuf head_filename = STRBUF_INIT;
+	char oid_hex[GIT_MAX_HEXSZ + 1];
+	FILE *f;
+
+	strbuf_addstr(&head_filename, pack_dir);
+	strbuf_addstr(&head_filename, "/graph-head");
+
+	f = fopen(head_filename.buf, "r");
+	strbuf_release(&head_filename);
+
+	if (!f)
+		return 0;
+
+	if (!fgets(oid_hex, sizeof(oid_hex), f))
+		die("failed to read graph-head");
+
+	fclose(f);
+
+	if (get_oid_hex(oid_hex, oid))
+		return 0;
+	return oid;
+}
+
 char* get_graph_filename_oid(const char *pack_dir,
 				  struct object_id *oid)
 {
diff --git a/packed-graph.h b/packed-graph.h
index 1a7eaa2a46..ad561863c8 100644
--- a/packed-graph.h
+++ b/packed-graph.h
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "commit.h"
 
+extern struct object_id *get_graph_head_oid(const char *pack_dir, struct object_id *oid);
 extern char* get_graph_filename_oid(const char *pack_dir,
 				    struct object_id *oid);
 
diff --git a/t/t5319-graph.sh b/t/t5319-graph.sh
index 4975f65dee..3919a3ad73 100755
--- a/t/t5319-graph.sh
+++ b/t/t5319-graph.sh
@@ -13,7 +13,8 @@ test_expect_success 'setup full repo' \
      packdir=".git/objects/pack"'
 
 test_expect_success 'write graph with no packs' \
-    'git graph --write --pack-dir .'
+    'git graph --write --pack-dir . &&
+     test_path_is_missing graph-head'
 
 test_expect_success 'create commits and repack' \
     'for i in $(test_seq 5)
@@ -37,6 +38,7 @@ EOF
 test_expect_success 'write graph' \
     'graph1=$(git graph --write) &&
      test_path_is_file ${packdir}/graph-${graph1}.graph &&
+     test_path_is_missing ${packdir}/graph-head &&
      git graph --read --graph-id=${graph1} >output &&
      _graph_read_expect "5" "${packdir}" &&
      cmp expect output'
@@ -69,8 +71,11 @@ test_expect_success 'Add more commits' \
      git repack'
 
 test_expect_success 'write graph with merges' \
-    'graph2=$(git graph --write) &&
+    'graph2=$(git graph --write --update-head) &&
      test_path_is_file ${packdir}/graph-${graph2}.graph &&
+     test_path_is_file ${packdir}/graph-head &&
+     echo ${graph2} >expect &&
+     cmp -n 40 expect ${packdir}/graph-head &&
      git graph --read --graph-id=${graph2} >output &&
      _graph_read_expect "18" "${packdir}" &&
      cmp expect output'
@@ -86,6 +91,9 @@ test_expect_success 'setup bare repo' \
 test_expect_success 'write graph in bare repo' \
     'graphbare=$(git graph --write) &&
      test_path_is_file ${baredir}/graph-${graphbare}.graph &&
+     test_path_is_file ${baredir}/graph-head &&
+     echo ${graphbare} >expect &&
+     cmp -n 40 expect ${baredir}/graph-head &&
      git graph --read --graph-id=${graphbare} >output &&
      _graph_read_expect "18" "${baredir}" &&
      cmp expect output'
-- 
2.16.0

