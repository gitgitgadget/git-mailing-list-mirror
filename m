Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7ABE1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeBHUiS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:38:18 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44421 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeBHUiB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:38:01 -0500
Received: by mail-qt0-f193.google.com with SMTP id f18so7729874qth.11
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fvYTnImeMBZWB0h5Vb1sRoNeErVzu35r0lUbYFFiRNM=;
        b=YSoke9YQclUipgZeYCnW4QgFOx+9iwh6DvyUgZQQS+3vE1ZxODyc+Ojm5kNYtyc+Rb
         Ug7G3L/C4VLjul1GLin8NtUBA6wTpW3jwuuJYnJJCbrUZ68hQpfQAn5kxeVwxWomPpOc
         dG/hvBxakcFPG3LRsUt9HODRRF0tkoO7cXD5GOyuDhVNOagh4MS6HwWtGniQBHJUz8d2
         omNK/c21JIPw/Vrz0Y4+rAIj8jZABSOffytvaxv2Toq8tNexjHq5GPaZIblBhzJuO5L4
         DMPlhU/nH/9R4anP6Tb/UGg7woUkFBnD0baBiN6s/++W+rXii0OqLsGXdqFUhFmvTUk1
         lb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fvYTnImeMBZWB0h5Vb1sRoNeErVzu35r0lUbYFFiRNM=;
        b=GVPHOk8W3DDHynLxcbsobe23k55z08Cc5WrioLNv/AVMKcCaK4FV3fnV7i3PNxro6x
         PFxPL0iU1EyyeJuNTwS4oBCW/xrhlC9P23KSEhnhaLHwDl0Eahgcm0P3d3NZv/MjMJhx
         028x1kvbPiAAM1pZG2jIYC7XK2Bjc/x+5vZUVZYtkaHa4sePaW3dUUigWIvZUeCaiK2E
         P9cMbmjzhefjzfmt1Sp1PMlq4IB+HkWy6GLGKdATaJJ+t9BaEth0AcmV+4mevDb7qErf
         lEQuS+2qysENe6cViIAdNWaEYVfApXBl2phXv7JJKS9Uz5PVzMMQtpwI0x0oiEjQfYTt
         4A6A==
X-Gm-Message-State: APf1xPDyDENkQIWw6uEXHKq4BFh+8tzqAVH0Oa31YyoV4lpv/XoNxrqQ
        JW23s3cvxvtkGf4VxldSqKd0NLs+k4I=
X-Google-Smtp-Source: AH8x225Vfm6jGSlGWVy4v/H6tFsT+TNm451D9tzjP5PxO2fq2nXFz5X3RoD7nYpb0SqNRFdS+7bxEw==
X-Received: by 10.200.3.145 with SMTP id t17mr760613qtg.259.1518122280273;
        Thu, 08 Feb 2018 12:38:00 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:37:59 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 08/14] commit-graph: implement 'git-commit-graph clear'
Date:   Thu,  8 Feb 2018 15:37:32 -0500
Message-Id: <1518122258-157281-9-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to delete the current 'graph_head' file and the commit graph
it references. This is a good safety valve if somehow the file is
corrupted and needs to be recalculated. Since the commit graph is a
summary of contents already in the ODB, it can be regenerated.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 11 +++++++++
 builtin/commit-graph.c             | 50 ++++++++++++++++++++++++++++++++++++++
 commit-graph.c                     | 23 ++++++++++++++++++
 commit-graph.h                     |  2 ++
 t/t5318-commit-graph.sh            |  5 ++++
 5 files changed, 91 insertions(+)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 5e32c43b27..8c2cbbc923 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -9,6 +9,7 @@ git-commit-graph - Write and verify Git commit graphs (.graph files)
 SYNOPSIS
 --------
 [verse]
+'git commit-graph clear' [--pack-dir <pack_dir>]
 'git commit-graph read' <options> [--pack-dir <pack_dir>]
 'git commit-graph write' <options> [--pack-dir <pack_dir>]
 
@@ -45,6 +46,10 @@ details about the graph file.
 With `--graph-hash=<hash>` option, consider the graph file
 graph-<hash>.graph in the pack directory.
 
+'clear'::
+
+Delete the graph-head file and the graph file it references.
+
 
 EXAMPLES
 --------
@@ -68,6 +73,12 @@ $ git commit-graph write --update-head
 $ git commit-graph read --graph-hash=<hash>
 ------------------------------------------------
 
+* Delete <dir>/graph-head and the file it references.
++
+------------------------------------------------
+$ git commit-graph clear --pack-dir=<dir>
+------------------------------------------------
+
 
 GIT
 ---
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 776ca087e8..529cb80de6 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,16 +1,23 @@
 #include "builtin.h"
 #include "config.h"
+#include "dir.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "commit-graph.h"
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
+	N_("git commit-graph clear [--pack-dir <packdir>]"),
 	N_("git commit-graph read [--graph-hash=<hash>]"),
 	N_("git commit-graph write [--pack-dir <packdir>] [--update-head]"),
 	NULL
 };
 
+static const char * const builtin_commit_graph_clear_usage[] = {
+	N_("git commit-graph clear [--pack-dir <packdir>]"),
+	NULL
+};
+
 static const char * const builtin_commit_graph_read_usage[] = {
 	N_("git commit-graph read [--pack-dir <packdir>]"),
 	NULL
@@ -27,6 +34,47 @@ static struct opts_commit_graph {
 	int update_head;
 } opts;
 
+static int graph_clear(int argc, const char **argv)
+{
+	char *old_path;
+	char *head_fname;
+	struct object_id old_graph_hash;
+
+	static struct option builtin_commit_graph_clear_options[] = {
+		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
+			N_("dir"),
+			N_("The pack directory to store the graph") },
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_commit_graph_clear_options,
+			     builtin_commit_graph_clear_usage, 0);
+
+	if (!opts.pack_dir) {
+		struct strbuf path = STRBUF_INIT;
+		strbuf_addstr(&path, get_object_directory());
+		strbuf_addstr(&path, "/pack");
+		opts.pack_dir = strbuf_detach(&path, NULL);
+	}
+
+	if (!get_graph_head_hash(opts.pack_dir, &old_graph_hash))
+		return 0;
+
+	head_fname = get_graph_head_filename(opts.pack_dir);
+	if (remove_path(head_fname))
+		die("failed to remove path %s", head_fname);
+	FREE_AND_NULL(head_fname);
+
+	old_path = get_commit_graph_filename_hash(opts.pack_dir,
+						  &old_graph_hash);
+	if (remove_path(old_path))
+		die("failed to remove path %s", old_path);
+	free(old_path);
+
+	return 0;
+}
+
 static int graph_read(int argc, const char **argv)
 {
 	struct object_id graph_hash;
@@ -162,6 +210,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (argc > 0) {
+		if (!strcmp(argv[0], "clear"))
+			return graph_clear(argc, argv);
 		if (!strcmp(argv[0], "read"))
 			return graph_read(argc, argv);
 		if (!strcmp(argv[0], "write"))
diff --git a/commit-graph.c b/commit-graph.c
index 9789fe37f9..95b813c2c7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -46,6 +46,29 @@ char *get_graph_head_filename(const char *pack_dir)
 	return strbuf_detach(&fname, 0);
 }
 
+struct object_id *get_graph_head_hash(const char *pack_dir, struct object_id *hash)
+{
+	char hex[GIT_MAX_HEXSZ + 1];
+	char *fname;
+	FILE *f;
+
+	fname = get_graph_head_filename(pack_dir);
+	f = fopen(fname, "r");
+	FREE_AND_NULL(fname);
+
+	if (!f)
+		return 0;
+
+	if (!fgets(hex, sizeof(hex), f))
+		die("failed to read graph-head");
+
+	fclose(f);
+
+	if (get_oid_hex(hex, hash))
+		return 0;
+	return hash;
+}
+
 char* get_commit_graph_filename_hash(const char *pack_dir,
 				     struct object_id *hash)
 {
diff --git a/commit-graph.h b/commit-graph.h
index 726b8aa0f4..75427cd5f6 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -5,6 +5,8 @@
 #include "commit.h"
 
 extern char *get_graph_head_filename(const char *pack_dir);
+extern struct object_id *get_graph_head_hash(const char *pack_dir,
+					     struct object_id *hash);
 extern char* get_commit_graph_filename_hash(const char *pack_dir,
 					    struct object_id *hash);
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 21352d5a3c..de81253790 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -126,6 +126,11 @@ test_expect_success 'write graph with nothing new' '
 	graph_read_expect "11" "$packdir" &&
 	test_cmp expect output'
 
+test_expect_success 'clear graph' '
+	git commit-graph clear &&
+	test_path_is_missing $packdir/graph-$graph4.graph &&
+	test_path_is_missing $packdir/graph-head'
+
 test_expect_success 'setup bare repo' '
 	cd .. &&
 	git clone --bare --no-local full bare &&
-- 
2.15.1.45.g9b7079f

