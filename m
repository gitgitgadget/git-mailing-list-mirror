Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D83EA1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeAYOC6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:02:58 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37266 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeAYOCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:52 -0500
Received: by mail-qt0-f196.google.com with SMTP id d54so19400157qtd.4
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MA4B1MxFOD8t563xQ8MXiwV3cHS78v9MbdenvQlJygs=;
        b=ey+g7G3MwbKG4owve/C0xDxR6KkTQ2WzgCuzGu6sZi54IaMUU/wVCdrCt8hNx9iWaJ
         Vx4jJy8YDe5ZNsnwGOATwrJPz5scPdIO8PPjSCN2zHOWOtnZ8SVyPQa4GKDq5i/hCtMs
         4UjT7m2EsiTt6YlkQvIGjMVgs2L7pIzRBruEHqr+MugzwJoih78oWKLe8oiBVHsqlOtZ
         9/V4P7FEtrCssppwMVLq0jG0q7OwTW8eYWp9rnvzr4kNxgsyn95fwe7HMgjo6ci5IWjI
         7A9k4eQbzgMJunwLh+Qn2V5iyRhV02N9pLQw2e8qbSk3jYVv/hqFrMTaOBBTeL40yGsJ
         cZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MA4B1MxFOD8t563xQ8MXiwV3cHS78v9MbdenvQlJygs=;
        b=gq0J04fIWeUnJfgL/nFdCiAq+yydDhdQ51EJq+e03lRdN1aJZjqaSs+8nodpzo9RCz
         HFwNSX/v42uZUMzjrblE2rYHeHuohwDeGpiNzT1D6RysFEojJLOESdj2yBJZlsJOVdZW
         6krvU2hBCcqIItHIjf2dXKEqZpVox0FZR1zb9qodDUWv12QBmb4GV4Z+aKrxcac6NVqe
         6COtNP5AZpFf5RUFaC9JjM+cwK601Us2gdSHm+C8Nl8iH1olcZMaVAqhgTv8AU//iFen
         +9rFIbiGvpNyfg4YaK/Q/5aiDXxth91LWz6SOcv1P7bEwPOM7Caw29f2b0UYrZYFH4rz
         DcXw==
X-Gm-Message-State: AKwxyte10dfxjdYY1X8e2v+Mwj+7ZVlFiFShP3AkMmnaHu1BORQ5KNh6
        IS69dAaS6CSVFgRQPCmjdWwG2gLz
X-Google-Smtp-Source: AH8x227QGO40ab+ZIeEI0o8b3ArmYb4Vefr8RFBgpHRcDVkFUiNtcqA9nqyQ2pi80dNQHTRRwx3PwA==
X-Received: by 10.200.25.91 with SMTP id g27mr17078094qtk.71.1516888971560;
        Thu, 25 Jan 2018 06:02:51 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:50 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 09/14] packed-graph: implement git-graph --clear
Date:   Thu, 25 Jan 2018 09:02:26 -0500
Message-Id: <20180125140231.65604-10-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to delete the current 'graph_head' file and the packed graph
it references. This is a good safety valve if somehow the file is
corrupted and needs to be recalculated. Since the packed graph is a
summary of contents already in the ODB, it can be regenerated.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-graph.txt | 16 ++++++++++++++--
 builtin/graph.c             | 31 ++++++++++++++++++++++++++++++-
 t/t5319-graph.sh            |  7 ++++++-
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-graph.txt b/Documentation/git-graph.txt
index ac20aa67a9..f690699570 100644
--- a/Documentation/git-graph.txt
+++ b/Documentation/git-graph.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git graph' --write <options> [--pack-dir <pack_dir>]
 'git graph' --read <options> [--pack-dir <pack_dir>]
+'git graph' --clear [--pack-dir <pack_dir>]
 
 OPTIONS
 -------
@@ -18,16 +19,21 @@ OPTIONS
 	Use given directory for the location of packfiles, graph-head,
 	and graph files.
 
+--clear::
+	Delete the graph-head file and the graph file it references.
+	(Cannot be combined with --read or --write.)
+
 --read::
 	Read a graph file given by the graph-head file and output basic
-	details about the graph file. (Cannot be combined with --write.)
+	details about the graph file. (Cannot be combined with --clear
+	or --write.)
 
 --graph-id::
 	When used with --read, consider the graph file graph-<oid>.graph.
 
 --write::
 	Write a new graph file to the pack directory. (Cannot be combined
-	with --read.)
+	with --clear or --read.)
 
 --update-head::
 	When used with --write, update the graph-head file to point to
@@ -61,6 +67,12 @@ $ git graph --write --update-head
 $ git graph --read --graph-id=<oid>
 ------------------------------------------------
 
+* Delete <dir>/graph-head and the file it references.
++
+------------------------------------------------
+$ git graph --clear --pack-dir=<dir>
+------------------------------------------------
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/graph.c b/builtin/graph.c
index 0760d99f43..ac15febc46 100644
--- a/builtin/graph.c
+++ b/builtin/graph.c
@@ -10,6 +10,7 @@
 
 static char const * const builtin_graph_usage[] ={
 	N_("git graph [--pack-dir <packdir>]"),
+	N_("git graph --clear [--pack-dir <packdir>]"),
 	N_("git graph --read [--graph-id=<oid>]"),
 	N_("git graph --write [--pack-dir <packdir>] [--update-head]"),
 	NULL
@@ -17,6 +18,7 @@ static char const * const builtin_graph_usage[] ={
 
 static struct opts_graph {
 	const char *pack_dir;
+	int clear;
 	int read;
 	const char *graph_id;
 	int write;
@@ -25,6 +27,29 @@ static struct opts_graph {
 	struct object_id old_graph_oid;
 } opts;
 
+static int graph_clear(void)
+{
+	struct strbuf head_path = STRBUF_INIT;
+	char *old_path;
+
+	if (!opts.has_existing)
+		return 0;
+
+	strbuf_addstr(&head_path, opts.pack_dir);
+	strbuf_addstr(&head_path, "/");
+	strbuf_addstr(&head_path, "graph-head");
+	if (remove_path(head_path.buf))
+		die("failed to remove path %s", head_path.buf);
+	strbuf_release(&head_path);
+
+	old_path = get_graph_filename_oid(opts.pack_dir, &opts.old_graph_oid);
+	if (remove_path(old_path))
+		die("failed to remove path %s", old_path);
+	free(old_path);
+
+	return 0;
+}
+
 static int graph_read(void)
 {
 	struct object_id graph_oid;
@@ -105,6 +130,8 @@ int cmd_graph(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
 			N_("dir"),
 			N_("The pack directory to store the graph") },
+		OPT_BOOL('c', "clear", &opts.clear,
+			N_("clear graph file and graph-head")),
 		OPT_BOOL('r', "read", &opts.read,
 			N_("read graph file")),
 		OPT_BOOL('w', "write", &opts.write,
@@ -129,7 +156,7 @@ int cmd_graph(int argc, const char **argv, const char *prefix)
 			     builtin_graph_options,
 			     builtin_graph_usage, 0);
 
-	if (opts.write + opts.read > 1)
+	if (opts.write + opts.read + opts.clear > 1)
 		usage_with_options(builtin_graph_usage, builtin_graph_options);
 
 	if (!opts.pack_dir) {
@@ -141,6 +168,8 @@ int cmd_graph(int argc, const char **argv, const char *prefix)
 
 	opts.has_existing = !!get_graph_head_oid(opts.pack_dir, &opts.old_graph_oid);
 
+	if (opts.clear)
+		return graph_clear();
 	if (opts.read)
 		return graph_read();
 	if (opts.write)
diff --git a/t/t5319-graph.sh b/t/t5319-graph.sh
index 3919a3ad73..311fb9dd67 100755
--- a/t/t5319-graph.sh
+++ b/t/t5319-graph.sh
@@ -80,6 +80,11 @@ test_expect_success 'write graph with merges' \
      _graph_read_expect "18" "${packdir}" &&
      cmp expect output'
 
+test_expect_success 'clear graph' \
+    'git graph --clear &&
+     test_path_is_missing ${packdir}/graph-${graph2}.graph &&
+     test_path_is_missing ${packdir}/graph-head'
+
 test_expect_success 'setup bare repo' \
     'cd .. &&
      git clone --bare full bare &&
@@ -89,7 +94,7 @@ test_expect_success 'setup bare repo' \
      baredir="./objects/pack"'
 
 test_expect_success 'write graph in bare repo' \
-    'graphbare=$(git graph --write) &&
+    'graphbare=$(git graph --write --update-head) &&
      test_path_is_file ${baredir}/graph-${graphbare}.graph &&
      test_path_is_file ${baredir}/graph-head &&
      echo ${graphbare} >expect &&
-- 
2.16.0

