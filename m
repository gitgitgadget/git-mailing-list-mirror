Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7B301F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeBSSxo (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:53:44 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44836 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753489AbeBSSxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:42 -0500
Received: by mail-qt0-f193.google.com with SMTP id g60so5279870qtd.11
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p/QXdAESBFuW7OCRJm83YPI0xWE9ocsTcTwAM57Wuvo=;
        b=CG9melWDerHkCdh1bM0eCF2tLJE1UCj36bXXlgr/OEJ6NVzBzaCcNQ1YK4dueWgb5Q
         AHUCInA5hLLB/a5pRQBvLh+T1ikPpDYRpC5QUFiD9qy1u9aE85ztJy3TL1Hc6Cs5gUro
         j6VkhezHS9B8X+wN8SB8OGg+Erseym3a39clPqwIHdzfk+bY9Z+ZKl7sFeJr7QEJNRTv
         DjpNUb0pDS/JLABezP/JUmI7cxXHTmXTL3fLSz0cSSQ52tEr3728O5rnBGiDq1FJSDfO
         EZ/SKR1+hMKJ/MjO6erqebZ/+MNSob9yudssqmjou3+RzPqdwoghE4kvzYsnHT/kZmEH
         I3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p/QXdAESBFuW7OCRJm83YPI0xWE9ocsTcTwAM57Wuvo=;
        b=Zd/XSUjpmhQXMr1f22Pb3i6sy1cirJ7MF0QKz97BrYpmv3sJ9Hcy6LRUi08u5b+m1P
         OsdjrL55ImPFK5eExcbNnV2P8TYBXomEdgC+uBuHLgszXLGX0mlCFpPPJZXq44K7Ls53
         0Y9A88DF4d20iPycJyblSX1iFCIO6SVvLIlJ64Pk2KpXAL6aUqtRIind15YUQnyO5e3k
         XU4Sr0LrCe05A1NOJQA0v5WIYPJ/v8dcs4uIYZSS/rni/ExO8x62V0eNNposCn5Cbq6a
         koQRgGtHNW+om3nIeoDKr6mWoGZAXWc8k/0ELmdNFhCRj70I7KLFRSEWhTMxWXt093dc
         ohNg==
X-Gm-Message-State: APf1xPAWLBpkGZVt/2e7Ool9iixZ1BP7Mrr8WoHQ0T1i9iaQOCsSbB1e
        vRoGgvROKeLrnoqj+ker1AhrXQjLmUQ=
X-Google-Smtp-Source: AH8x2271Xn7GUt7PS3ginV4oQDT2oFnYCCr3arBukgMLePCvpFmTrHN736IPJJYwL8SRIEt4JAzP1w==
X-Received: by 10.200.49.130 with SMTP id h2mr26860653qte.281.1519066421067;
        Mon, 19 Feb 2018 10:53:41 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:40 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 08/13] commit-graph: implement --delete-expired
Date:   Mon, 19 Feb 2018 13:53:21 -0500
Message-Id: <1519066406-81663-9-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to delete the .graph files that are siblings of a
newly-written graph file, except for the file referenced by 'graph-latest'
at the beginning of the process and the newly-written file. If we fail to
delete a graph file, only report a warning because another git process may
be using that file. In a multi-process environment, we expect the previoius
graph file to be used by a concurrent process, so we do not delete it to
avoid race conditions.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 11 +++++--
 builtin/commit-graph.c             | 61 ++++++++++++++++++++++++++++++++++++--
 commit-graph.c                     | 23 ++++++++++++++
 commit-graph.h                     |  1 +
 t/t5318-commit-graph.sh            |  7 +++--
 5 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index dc948c5..b9b4031 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -37,6 +37,11 @@ resulting filename.
 +
 With `--set-latest` option, update the graph-latest file to point
 to the written graph file.
++
+With the `--delete-expired` option, delete the graph files in the pack
+directory that are not referred to by the graph-latest file. To avoid race
+conditions, do not delete the file previously referred to by the
+graph-latest file if it is updated by the `--set-latest` option.
 
 'read'::
 
@@ -56,11 +61,11 @@ EXAMPLES
 $ git commit-graph write
 ------------------------------------------------
 
-* Write a graph file for the packed commits in your local .git folder
-* and update graph-latest.
+* Write a graph file for the packed commits in your local .git folder,
+* update graph-latest, and delete stale graph files.
 +
 ------------------------------------------------
-$ git commit-graph write --set-latest
+$ git commit-graph write --set-latest --delete-expired
 ------------------------------------------------
 
 * Read basic information from a graph file.
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index bf86172..fd99169 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,7 +8,7 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>] [--file=<hash>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--set-latest]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--set-latest] [--delete-expired]"),
 	NULL
 };
 
@@ -18,7 +18,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--set-latest]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--set-latest] [--delete-expired]"),
 	NULL
 };
 
@@ -26,6 +26,7 @@ static struct opts_commit_graph {
 	const char *obj_dir;
 	const char *graph_file;
 	int set_latest;
+	int delete_expired;
 } opts;
 
 static int graph_read(int argc, const char **argv)
@@ -98,9 +99,56 @@ static void set_latest_file(const char *obj_dir, const char *graph_file)
 	commit_lock_file(&lk);
 }
 
+/*
+ * To avoid race conditions and deleting graph files that are being
+ * used by other processes, look inside a pack directory for all files
+ * of the form "graph-<hash>.graph" that do not match the old or new
+ * graph hashes and delete them.
+ */
+static void do_delete_expired(const char *obj_dir,
+			      const char *old_graph_name,
+			      const char *new_graph_name)
+{
+	DIR *dir;
+	struct dirent *de;
+	int dirnamelen;
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_addf(&path, "%s/info", obj_dir);
+	dir = opendir(path.buf);
+	if (!dir) {
+		if (errno != ENOENT)
+			error_errno("unable to open object pack directory: %s",
+				    obj_dir);
+		return;
+	}
+
+	strbuf_addch(&path, '/');
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
+		    strcmp(new_graph_name, de->d_name) &&
+		    (!old_graph_name || strcmp(old_graph_name, de->d_name)) &&
+		    remove_path(path.buf))
+			die("failed to remove path %s", path.buf);
+	}
+
+	strbuf_release(&path);
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	char *graph_name;
+	char *old_graph_name;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		{ OPTION_STRING, 'o', "object-dir", &opts.obj_dir,
@@ -108,6 +156,8 @@ static int graph_write(int argc, const char **argv)
 			N_("The object directory to store the graph") },
 		OPT_BOOL('u', "set-latest", &opts.set_latest,
 			N_("update graph-head to written graph file")),
+		OPT_BOOL('d', "delete-expired", &opts.delete_expired,
+			N_("delete expired head graph file")),
 		OPT_END(),
 	};
 
@@ -118,12 +168,19 @@ static int graph_write(int argc, const char **argv)
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
 
+	old_graph_name = get_graph_latest_contents(opts.obj_dir);
+
 	graph_name = write_commit_graph(opts.obj_dir);
 
 	if (graph_name) {
 		if (opts.set_latest)
 			set_latest_file(opts.obj_dir, graph_name);
 
+		if (opts.delete_expired)
+			do_delete_expired(opts.obj_dir,
+					  old_graph_name,
+					  graph_name);
+
 		printf("%s\n", graph_name);
 		FREE_AND_NULL(graph_name);
 	}
diff --git a/commit-graph.c b/commit-graph.c
index 5ee0805..c8fb38f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -45,6 +45,29 @@ char *get_graph_latest_filename(const char *obj_dir)
 	return strbuf_detach(&fname, 0);
 }
 
+char *get_graph_latest_contents(const char *obj_dir)
+{
+	struct strbuf graph_file = STRBUF_INIT;
+	char *fname;
+	FILE *f;
+	char buf[64];
+
+	fname = get_graph_latest_filename(obj_dir);
+	f = fopen(fname, "r");
+	FREE_AND_NULL(fname);
+
+	if (!f)
+		return 0;
+
+	while (!feof(f)) {
+		if (fgets(buf, sizeof(buf), f))
+			strbuf_addstr(&graph_file, buf);
+	}
+
+	fclose(f);
+	return strbuf_detach(&graph_file, NULL);
+}
+
 static struct commit_graph *alloc_commit_graph(void)
 {
 	struct commit_graph *g = xmalloc(sizeof(*g));
diff --git a/commit-graph.h b/commit-graph.h
index ae24b3a..56215ad 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 
 extern char *get_graph_latest_filename(const char *obj_dir);
+extern char *get_graph_latest_contents(const char *obj_dir);
 
 struct commit_graph {
 	int graph_fd;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index cad9d90..1d5ec7d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -117,8 +117,10 @@ test_expect_success 'Add one more commit' '
 # 1
 
 test_expect_success 'write graph with new commit' '
-	graph3=$(git commit-graph write --set-latest) &&
+	graph3=$(git commit-graph write --set-latest --delete-expired) &&
 	test_path_is_file $objdir/info/$graph3 &&
+	test_path_is_file $objdir/info/$graph2 &&
+	test_path_is_missing $objdir/info/$graph1 &&
 	test_path_is_file $objdir/info/graph-latest &&
 	printf $graph3 >expect &&
 	test_cmp expect $objdir/info/graph-latest &&
@@ -128,8 +130,9 @@ test_expect_success 'write graph with new commit' '
 '
 
 test_expect_success 'write graph with nothing new' '
-	graph4=$(git commit-graph write --set-latest) &&
+	graph4=$(git commit-graph write --set-latest --delete-expired) &&
 	test_path_is_file $objdir/info/$graph4 &&
+	test_path_is_missing $objdir/info/$graph2 &&
 	printf $graph3 >expect &&
 	printf $graph4 >output &&
 	test_cmp expect output &&
-- 
2.7.4

