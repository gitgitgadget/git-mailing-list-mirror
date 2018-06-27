Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961541F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965459AbeF0NZx (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:53 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41166 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965430AbeF0NZf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:35 -0400
Received: by mail-qt0-f196.google.com with SMTP id y20-v6so1571897qto.8
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tnqsEfU47DpWGW3XRC4ovvJjS9QkyJ4JYmPXmYWwWWI=;
        b=dBvp6dmf1hRmAVaaUp+4X7Rx2zW75ExdtGr38zeFxgElcWVPxiWlH1j2QrspuahawA
         R4F6xVGXTwXsfpypSHYBbqB2t2ALWqSQ4+31/WSKrqX9GwF/IM43k7yp+lUF6OUpHWIg
         R7Dtj/aPzarCQkIDKsrRkK2sNTqqWQ4qeaz6Q8QuE/Dxg3xsRMbU5d7COY16T5Sh02sm
         lxq/F3QvnDsWhrDLwRnxOIyGNuk1AqwqYUoMDeTwfsMZPxLGyl+vW8ndUr/vcQiNIcoX
         jVQVG4MCfubf3G9VzNyifXt8YOAcCVAyW+Gbef0tlZVwN9zwDd/XUe+C7F+EHqSavm1p
         07Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tnqsEfU47DpWGW3XRC4ovvJjS9QkyJ4JYmPXmYWwWWI=;
        b=Vo2kF0YdDoQzeHNGPzBHMxkJ8Xre84ckEjXdcl0o3okiSeNBi8NMRQB429HKv2m8If
         IP3pXFy2rY9V85SGrTg3Qo/GQfgh3eQD1dXUuFkxzdSRUlLJc52bTJIpRewwvHYVjneL
         iFDikMo6fNPkcUDFsfWXOTsf8xdaNusrjzUkqgUh6/+yUH4/vRnf5bhFaQo3Q8HcLwf1
         eODRAoW27IozrCdP8fLgdgr5/FcGE7HWLCjQk1rIUSzehng5RGxJged+xWjuen9xy1ky
         4Zpehe/zfTNLgrpOPu9pMJMlg9IDxuQaYX+TAgGElaEonFvpuWIsVCCjIi0zVcFl3lxr
         EGvw==
X-Gm-Message-State: APt69E1GIMkErvrLG4eHgeSpDyEA98ra0lnKH56JBfzc/znrE6D6XxqQ
        iuAm3eTOgf5WmwJPr1AdNl/0LAAYRVQ=
X-Google-Smtp-Source: AAOMgpc6Xw/ZShuY7iAJ08LXWEGshLMOAi2hxmugWW8A0e3zF9nnn9gRDPb3rDVtLRrioa97P1n+pg==
X-Received: by 2002:ac8:2696:: with SMTP id 22-v6mr5201823qto.304.1530105934523;
        Wed, 27 Jun 2018 06:25:34 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:33 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 20/22] commit-graph: add '--reachable' option
Date:   Wed, 27 Jun 2018 09:24:45 -0400
Message-Id: <20180627132447.142473-21-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing commit-graph files, it can be convenient to ask for all
reachable commits (starting at the ref set) in the resulting file. This
is particularly helpful when writing to stdin is complicated, such as a
future integration with 'git gc'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  8 ++++++--
 builtin/commit-graph.c             | 16 ++++++++++++----
 commit-graph.c                     | 18 ++++++++++++++++++
 commit-graph.h                     |  1 +
 t/t5318-commit-graph.sh            | 10 ++++++++++
 5 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index a222cfab08..dececb79d7 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -38,12 +38,16 @@ Write a commit graph file based on the commits found in packfiles.
 +
 With the `--stdin-packs` option, generate the new commit graph by
 walking objects only in the specified pack-indexes. (Cannot be combined
-with --stdin-commits.)
+with `--stdin-commits` or `--reachable`.)
 +
 With the `--stdin-commits` option, generate the new commit graph by
 walking commits starting at the commits specified in stdin as a list
 of OIDs in hex, one OID per line. (Cannot be combined with
---stdin-packs.)
+`--stdin-packs` or `--reachable`.)
++
+With the `--reachable` option, generate the new commit graph by walking
+commits starting at all refs. (Cannot be combined with `--stdin-commits`
+or `--stdin-packs`.)
 +
 With the `--append` option, include all commits that are present in the
 existing commit-graph file.
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index ea28bc311a..c7d0db5ab4 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,7 +10,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	N_("git commit-graph verify [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -25,12 +25,13 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
 static struct opts_commit_graph {
 	const char *obj_dir;
+	int reachable;
 	int stdin_packs;
 	int stdin_commits;
 	int append;
@@ -127,6 +128,8 @@ static int graph_write(int argc, const char **argv)
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			N_("dir"),
 			N_("The object directory to store the graph")),
+		OPT_BOOL(0, "reachable", &opts.reachable,
+			N_("start walk at all refs")),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			N_("scan pack-indexes listed by stdin for commits")),
 		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
@@ -140,11 +143,16 @@ static int graph_write(int argc, const char **argv)
 			     builtin_commit_graph_write_options,
 			     builtin_commit_graph_write_usage, 0);
 
-	if (opts.stdin_packs && opts.stdin_commits)
-		die(_("cannot use both --stdin-commits and --stdin-packs"));
+	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
+		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
 
+	if (opts.reachable) {
+		write_commit_graph_reachable(opts.obj_dir, opts.append);
+		return 0;
+	}
+
 	string_list_init(&lines, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
 		struct strbuf buf = STRBUF_INIT;
diff --git a/commit-graph.c b/commit-graph.c
index a06e7e9549..adf54e3fe7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -7,6 +7,7 @@
 #include "packfile.h"
 #include "commit.h"
 #include "object.h"
+#include "refs.h"
 #include "revision.h"
 #include "sha1-lookup.h"
 #include "commit-graph.h"
@@ -656,6 +657,23 @@ static void compute_generation_numbers(struct packed_commit_list* commits)
 	}
 }
 
+static int add_ref_to_list(const char *refname,
+			   const struct object_id *oid,
+			   int flags, void *cb_data)
+{
+	struct string_list *list = (struct string_list*)cb_data;
+	string_list_append(list, oid_to_hex(oid));
+	return 0;
+}
+
+void write_commit_graph_reachable(const char *obj_dir, int append)
+{
+	struct string_list list;
+	string_list_init(&list, 1);
+	for_each_ref(add_ref_to_list, &list);
+	write_commit_graph(obj_dir, NULL, &list, append);
+}
+
 void write_commit_graph(const char *obj_dir,
 			struct string_list *pack_indexes,
 			struct string_list *commit_hex,
diff --git a/commit-graph.h b/commit-graph.h
index a79b854470..506cb45fb1 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -48,6 +48,7 @@ struct commit_graph {
 
 struct commit_graph *load_commit_graph_one(const char *graph_file);
 
+void write_commit_graph_reachable(const char *obj_dir, int append);
 void write_commit_graph(const char *obj_dir,
 			struct string_list *pack_indexes,
 			struct string_list *commit_hex,
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index a9e8c774d5..2208c266b5 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -205,6 +205,16 @@ test_expect_success 'build graph from commits with append' '
 graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
 
+test_expect_success 'build graph using --reachable' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write --reachable &&
+	test_path_is_file $objdir/info/commit-graph &&
+	graph_read_expect "11" "large_edges"
+'
+
+graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
+graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone --bare --no-local full bare &&
-- 
2.18.0.24.g1b579a2ee9

