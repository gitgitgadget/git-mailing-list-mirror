Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C89F91F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeBHUiR (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:38:17 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39882 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbeBHUiC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:38:02 -0500
Received: by mail-qt0-f196.google.com with SMTP id f4so7906174qtj.6
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i8exlq0yzMLjtct4liF4w3fZZP2wNWSYYvIDyZwS1jE=;
        b=OFw/sQNlhV668t2ZKoJOgOCDECLqzronh+SwJlWVirkx6GgcbDEIkUEoUv4Zat44FX
         1j4Ix/yxAVFgUd7SzWASMS1H0a0J4JFuwHFO319Ig8TgcVQgLI/CApfzkf7QI9H+d95N
         CgmBP5uh2V9i2h5ueUdhoB9pWOOb4Thd4dylw9nhk4C/ueaEj/Mn9H4XlGmn//YK1Fi5
         7w4W/FPuNXugJlRt7AtD3VgXkRuaQH2vpO44axFsWXdc7zxz0qfhyElzAixRxKtrASK6
         DjCpLwsm+cFifTkoeGRl63izdxmkomJyQ7aqhyQBuOr4gPWnyOdA6nk5BWlTgp10BwY1
         9yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i8exlq0yzMLjtct4liF4w3fZZP2wNWSYYvIDyZwS1jE=;
        b=Ix7uFQhfP4Q/Oy1xEaWhzjdkvADZQzc8jKdcn6EGvNEBMYzb7LDGTakj9cZg92hSVS
         8a1wF+VBi0TFyHwbUDov2PrU2QdLBRiBWRPFSsVi/W2PaerJdvXElTwnDTAsQly0Vzsh
         X8hieE7cigiSfd/jJa19LsKKcNdm16ntg4D4ox6FKjc6FuRsZHpGIfdmhCVRkDX412bQ
         p6y+2r+JKIDpyHUcLao7faTIxCo/565YIScLoeHIXK5qsEIXrYR/faymikoE35Bal7Gc
         zp0gpr+X3JzsrnoBsYz/Ht2/CJiYwSJqwziFtS3Xh96+gFQC2yYw5WFK2YnApjpzFugQ
         OkFQ==
X-Gm-Message-State: APf1xPB5hbFnm+JaN2XeuoiELOrO+QZR+qNJAMpR7lVKu1Ovt9JUVUgk
        6YgwZjJV9ty3ZJ8ngF1nzghdGPlkDno=
X-Google-Smtp-Source: AH8x2272d1jLMXbOweHBYVLdDO6ZWElaTLR5KVCBWep8KmCYLOZOcse6c9DiqMXmyNdrdOn5SpmSpQ==
X-Received: by 10.200.48.136 with SMTP id v8mr754406qta.296.1518122281309;
        Thu, 08 Feb 2018 12:38:01 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:38:00 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 09/14] commit-graph: implement --delete-expired
Date:   Thu,  8 Feb 2018 15:37:33 -0500
Message-Id: <1518122258-157281-10-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to delete the graph files in the pack directory
that were not referenced by 'graph_head' during this process. This cleans
up space for the user while not causing race conditions with other running
Git processes that may be referencing the previous graph file.

To delete old graph files, a user (or managing process) would call

	git commit-graph write --update-head --delete-expired

but there is some responsibility that the caller must consider. Specifically,
ensure that processes that started before a previous 'commit-graph write'
command have completed. Otherwise, they may have an open handle on a graph file
that will be deleted by the new call.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 11 ++++--
 builtin/commit-graph.c             | 73 ++++++++++++++++++++++++++++++++++++--
 t/t5318-commit-graph.sh            |  7 ++--
 3 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 8c2cbbc923..7ae8f7484d 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -37,6 +37,11 @@ checksum hash of the written file.
 +
 With `--update-head` option, update the graph-head file to point
 to the written graph file.
++
+With the `--delete-expired` option, delete the graph files in the pack
+directory that are not referred to by the graph-head file. To avoid race
+conditions, do not delete the file previously referred to by the
+graph-head file if it is updated by the `--update-head` option.
 
 'read'::
 
@@ -60,11 +65,11 @@ EXAMPLES
 $ git commit-graph write
 ------------------------------------------------
 
-* Write a graph file for the packed commits in your local .git folder
-* and update graph-head.
+* Write a graph file for the packed commits in your local .git folder,
+* update graph-head, and delete state graph files.
 +
 ------------------------------------------------
-$ git commit-graph write --update-head
+$ git commit-graph write --update-head --delete-expired
 ------------------------------------------------
 
 * Read basic information from a graph file.
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 529cb80de6..15f647fd81 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,7 +9,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
 	N_("git commit-graph clear [--pack-dir <packdir>]"),
 	N_("git commit-graph read [--graph-hash=<hash>]"),
-	N_("git commit-graph write [--pack-dir <packdir>] [--update-head]"),
+	N_("git commit-graph write [--pack-dir <packdir>] [--update-head] [--delete-expired]"),
 	NULL
 };
 
@@ -24,7 +24,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--pack-dir <packdir>] [--update-head]"),
+	N_("git commit-graph write [--pack-dir <packdir>] [--update-head] [--delete-expired]"),
 	NULL
 };
 
@@ -32,6 +32,7 @@ static struct opts_commit_graph {
 	const char *pack_dir;
 	const char *graph_hash;
 	int update_head;
+	int delete_expired;
 } opts;
 
 static int graph_clear(int argc, const char **argv)
@@ -153,9 +154,68 @@ static void update_head_file(const char *pack_dir, const struct object_id *graph
 	commit_lock_file(&lk);
 }
 
+/*
+ * To avoid race conditions and deleting graph files that are being
+ * used by other processes, look inside a pack directory for all files
+ * of the form "graph-<hash>.graph" that do not match the old or new
+ * graph hashes and delete them.
+ */
+static void do_delete_expired(const char *pack_dir,
+			      struct object_id *old_graph_hash,
+			      struct object_id *new_graph_hash)
+{
+	DIR *dir;
+	struct dirent *de;
+	int dirnamelen;
+	struct strbuf path = STRBUF_INIT;
+	char *old_graph_path, *new_graph_path;
+
+	if (old_graph_hash)
+		old_graph_path = get_commit_graph_filename_hash(pack_dir, old_graph_hash);
+	else
+		old_graph_path = NULL;
+	new_graph_path = get_commit_graph_filename_hash(pack_dir, new_graph_hash);
+
+	dir = opendir(pack_dir);
+	if (!dir) {
+		if (errno != ENOENT)
+			error_errno("unable to open object pack directory: %s",
+				    pack_dir);
+		return;
+	}
+
+	strbuf_addstr(&path, pack_dir);
+	strbuf_addch(&path, '/');
+
+	dirnamelen = path.len;
+	while ((de = readdir(dir)) != NULL) {
+		size_t base_len;
+
+		if (is_dot_or_dotdot(de->d_name))
+			continue;
+
+		strbuf_setlen(&path, dirnamelen);
+		strbuf_addstr(&path, de->d_name);
+
+		base_len = path.len;
+		if (strip_suffix_mem(path.buf, &base_len, ".graph") &&
+		    strcmp(new_graph_path, path.buf) &&
+		    (!old_graph_path || strcmp(old_graph_path, path.buf)) &&
+		    remove_path(path.buf))
+			die("failed to remove path %s", path.buf);
+	}
+
+	strbuf_release(&path);
+	if (old_graph_path)
+		FREE_AND_NULL(old_graph_path);
+	FREE_AND_NULL(new_graph_path);
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	struct object_id *graph_hash;
+	struct object_id old_graph_hash;
+	int has_existing;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
@@ -163,6 +223,8 @@ static int graph_write(int argc, const char **argv)
 			N_("The pack directory to store the graph") },
 		OPT_BOOL('u', "update-head", &opts.update_head,
 			N_("update graph-head to written graph file")),
+		OPT_BOOL('d', "delete-expired", &opts.delete_expired,
+			N_("delete expired head graph file")),
 		OPT_END(),
 	};
 
@@ -177,11 +239,18 @@ static int graph_write(int argc, const char **argv)
 		opts.pack_dir = strbuf_detach(&path, NULL);
 	}
 
+	has_existing = !!get_graph_head_hash(opts.pack_dir, &old_graph_hash);
+
 	graph_hash = write_commit_graph(opts.pack_dir);
 
 	if (opts.update_head)
 		update_head_file(opts.pack_dir, graph_hash);
 
+	if (opts.delete_expired && graph_hash)
+		do_delete_expired(opts.pack_dir,
+				  has_existing ? &old_graph_hash : NULL,
+				  graph_hash);
+
 	if (graph_hash) {
 		printf("%s\n", oid_to_hex(graph_hash));
 		FREE_AND_NULL(graph_hash);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index de81253790..10dfb6c5cf 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -104,8 +104,10 @@ test_expect_success 'Add one more commit' '
 # 1
 
 test_expect_success 'write graph with new commit' '
-	graph3=$(git commit-graph write --update-head) &&
+	graph3=$(git commit-graph write --update-head --delete-expired) &&
 	test_path_is_file $packdir/graph-$graph3.graph &&
+	test_path_is_file $packdir/graph-$graph2.graph &&
+	test_path_is_missing $packdir/graph-$graph1.graph &&
         test_path_is_file $packdir/graph-head &&
         printf $graph3 >expect &&
         test_cmp expect $packdir/graph-head &&
@@ -114,8 +116,9 @@ test_expect_success 'write graph with new commit' '
 	test_cmp expect output'
 
 test_expect_success 'write graph with nothing new' '
-	graph4=$(git commit-graph write --update-head) &&
+	graph4=$(git commit-graph write --update-head --delete-expired) &&
 	test_path_is_file $packdir/graph-$graph4.graph &&
+	test_path_is_missing $packdir/graph-$graph2.graph &&
 	printf $graph3 >expect &&
 	printf $graph4 >output &&
 	test_cmp expect output &&
-- 
2.15.1.45.g9b7079f

