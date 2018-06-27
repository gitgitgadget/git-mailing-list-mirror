Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A1AE1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965415AbeF0NZT (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:19 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43783 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965111AbeF0NZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id c8-v6so1565903qtp.10
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VJz9pdw9WgHYsEDhufHDnxIWmsN8wRq5zgEmoBuh6Z4=;
        b=VeWhgFSgGUHhgRiLEFFgWWunrSVRcyU75RC6i5zf98B6IKQoPkPIOCVlI7PTjzPc7r
         TV1aZgJQfQbEvghvObm/DyHjZpWYWPlwbu+3oCOLM0DTnqKjEk8FFlks90rgM1wXFuab
         a5+MO7bj413jr2Au3LVEFwnKGZGC96O8Fu/qyjz1v++xEu+LcL7f2s+sdG/sW0Cfrv9G
         9zsDoD3YOJpECjWyAt1YabNJ+gyDXANkQUZybAVEzIHp0IGxrLTnuQAFxP/OqSarKLyN
         uY93lJLWKK9M/K/2tdQOoDtYOIpOOG3F75cfPwA0p3qtd4YhiUA443i1Or/1s7f8zVPQ
         hqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VJz9pdw9WgHYsEDhufHDnxIWmsN8wRq5zgEmoBuh6Z4=;
        b=VeNV5m1p4hj/1nL3+ZXW1Gg95tHjWoEXHwAbQCvkOwC2wuViAeJr2+I2df7PVFiivJ
         AiG6dm+jiW+09Gt7UH4khGhNz4USPCjltjDrfcdHA5fZQLRPSaat6xvPEag/jagQE/u8
         GSmcibD3n2VirDwLToNfFteBFpman0/PEdDainlCWYxihpHiuOESOcACvUyu2VeN2KgX
         i7tgwWUykzGpf8mFZXTVFPBw0UfG6lrglPHSFzErc7FRYUFgJ7upLlAttEmz4nLLgb0y
         M1rBN5wx8+lBFfKECGRcMeXcO5sH538KnPpRb1KSmce0zbT9wv5aN5dSiDvM16kerYaE
         zl6g==
X-Gm-Message-State: APt69E37m74Swn8DuzjSxwJRPYs9BoFYoWb2lv9hsJ9cPTaxDwkZNr7a
        wBEvKNFfHq/Zui2okhBPPC2qAgCWmH0=
X-Google-Smtp-Source: AAOMgpfymg0pK8h/ZuWT1RYOG7pznekOPrD1gMqfCSFet7UkTtCk+waPRPkFWuEzMr4KUlrHNR8f9w==
X-Received: by 2002:a0c:d0eb:: with SMTP id b40-v6mr5290589qvh.236.1530105910153;
        Wed, 27 Jun 2018 06:25:10 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:09 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 07/22] commit-graph: add 'verify' subcommand
Date:   Wed, 27 Jun 2018 09:24:32 -0400
Message-Id: <20180627132447.142473-8-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the commit-graph file becomes corrupt, we need a way to verify
that its contents match the object database. In the manner of
'git fsck' we will implement a 'git commit-graph verify' subcommand
to report all issues with the file.

Add the 'verify' subcommand to the 'commit-graph' builtin and its
documentation. The subcommand is currently a no-op except for
loading the commit-graph into memory, which may trigger run-time
errors that would be caught by normal use. Add a simple test that
ensures the command returns a zero error code.

If no commit-graph file exists, this is an acceptable state. Do
not report any errors.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  6 +++++
 builtin/commit-graph.c             | 39 ++++++++++++++++++++++++++++++
 commit-graph.c                     | 23 ++++++++++++++++++
 commit-graph.h                     |  3 +++
 t/t5318-commit-graph.sh            | 10 ++++++++
 5 files changed, 81 insertions(+)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 4c97b555cc..a222cfab08 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit-graph read' [--object-dir <dir>]
+'git commit-graph verify' [--object-dir <dir>]
 'git commit-graph write' <options> [--object-dir <dir>]
 
 
@@ -52,6 +53,11 @@ existing commit-graph file.
 Read a graph file given by the commit-graph file and output basic
 details about the graph file. Used for debugging purposes.
 
+'verify'::
+
+Read the commit-graph file and verify its contents against the object
+database. Used to check for corrupted data.
+
 
 EXAMPLES
 --------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f0875b8bf3..9d108f43a9 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -3,15 +3,22 @@
 #include "dir.h"
 #include "lockfile.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "commit-graph.h"
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
+	N_("git commit-graph verify [--object-dir <objdir>]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
+static const char * const builtin_commit_graph_verify_usage[] = {
+	N_("git commit-graph verify [--object-dir <objdir>]"),
+	NULL
+};
+
 static const char * const builtin_commit_graph_read_usage[] = {
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	NULL
@@ -29,6 +36,36 @@ static struct opts_commit_graph {
 	int append;
 } opts;
 
+
+static int graph_verify(int argc, const char **argv)
+{
+	struct commit_graph *graph = NULL;
+	char *graph_name;
+
+	static struct option builtin_commit_graph_verify_options[] = {
+		OPT_STRING(0, "object-dir", &opts.obj_dir,
+			   N_("dir"),
+			   N_("The object directory to store the graph")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_commit_graph_verify_options,
+			     builtin_commit_graph_verify_usage, 0);
+
+	if (!opts.obj_dir)
+		opts.obj_dir = get_object_directory();
+
+	graph_name = get_commit_graph_filename(opts.obj_dir);
+	graph = load_commit_graph_one(graph_name);
+	FREE_AND_NULL(graph_name);
+
+	if (!graph)
+		return 0;
+
+	return verify_commit_graph(the_repository, graph);
+}
+
 static int graph_read(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
@@ -165,6 +202,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 	if (argc > 0) {
 		if (!strcmp(argv[0], "read"))
 			return graph_read(argc, argv);
+		if (!strcmp(argv[0], "verify"))
+			return graph_verify(argc, argv);
 		if (!strcmp(argv[0], "write"))
 			return graph_write(argc, argv);
 	}
diff --git a/commit-graph.c b/commit-graph.c
index 9e228d3bb5..22ef696e18 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -827,3 +827,26 @@ void write_commit_graph(const char *obj_dir,
 	oids.alloc = 0;
 	oids.nr = 0;
 }
+
+static int verify_commit_graph_error;
+
+static void graph_report(const char *fmt, ...)
+{
+	va_list ap;
+	verify_commit_graph_error = 1;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, "\n");
+	va_end(ap);
+}
+
+int verify_commit_graph(struct repository *r, struct commit_graph *g)
+{
+	if (!g) {
+		graph_report("no commit-graph file loaded");
+		return 1;
+	}
+
+	return verify_commit_graph_error;
+}
diff --git a/commit-graph.h b/commit-graph.h
index 96cccb10f3..4359812fb4 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -2,6 +2,7 @@
 #define COMMIT_GRAPH_H
 
 #include "git-compat-util.h"
+#include "repository.h"
 
 char *get_commit_graph_filename(const char *obj_dir);
 
@@ -53,4 +54,6 @@ void write_commit_graph(const char *obj_dir,
 			int nr_commits,
 			int append);
 
+int verify_commit_graph(struct repository *r, struct commit_graph *g);
+
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 59d0be2877..0830ef9fdd 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -11,6 +11,11 @@ test_expect_success 'setup full repo' '
 	objdir=".git/objects"
 '
 
+test_expect_success 'verify graph with no graph file' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph verify
+'
+
 test_expect_success 'write graph with no packs' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write --object-dir . &&
@@ -230,4 +235,9 @@ test_expect_success 'perform fast-forward merge in full repo' '
 	test_cmp expect output
 '
 
+test_expect_success 'git commit-graph verify' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph verify >output
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

