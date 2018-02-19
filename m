Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B364B1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeBSSxj (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:53:39 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41130 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbeBSSxg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:36 -0500
Received: by mail-qk0-f196.google.com with SMTP id h129so13449881qke.8
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JWZY6Xg7q2635K9hFK4JzUgOHU3AYUdsqxkjEVuHNLg=;
        b=DdU9NRujTccn7eWq1fjiwVncYgn+JUN+6Jt5WeEgfpARX3TFHoK7jB+rAczHrvInVC
         fNEwlZA5PnhxtTK4yBUH+jtbQ9WgEcydofTZHyIj9ZkB6LI4xH2HBYyb6nO05gsVUb8A
         rTYSgUehl6VSU4xwxUa7oonuiZZwtibaTW/LyZswB5Sok6l9bAJ1CWRuxgkEjrQuieyA
         9hshVd2fJDndkZjipNcpIj+C+mQHfK8EFCbqQ5o2/eC9MqcU8pIPZYeenUJGF6CW9HBU
         TGH1f8D2nJ7d6QGUcn2jUsbVLgy2VYClSSaUcEaB9xFMd3LI16Nj93eQtUiwUrO0tAHK
         fqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JWZY6Xg7q2635K9hFK4JzUgOHU3AYUdsqxkjEVuHNLg=;
        b=aIXQzA20mKAm9sdBXmYL1nsU8Q1h7rxhBTMm4+TUlG7kzdSe6x8+TP4IXdtVNjlARm
         xXfVdKmd+riH3NviYEREfGsdG1PQjo6/s0ar6YfirR2gOQNpz7c4MPZEAlOJkajkk2FS
         LBdH1Nt2L6igG8AqmaMzVTNIkIYcfv/BVl3ZXT1oP/vqhRORypTwM/VEtGEEO8Ig52yw
         /RC/yOvGo3PJoJKvj1+45mkVo5W/pyGJTryjQpPismfurCvM4v+vvFmtlYlIgjEZ2SIe
         qMtQVYDfWkkqKfolEU/aA+vBsfCxhSQbCBlKaLAORRHRdYShcIDGqW9axy7J3kGQVWe+
         SQNA==
X-Gm-Message-State: APf1xPBtFfzT078iUJFbqpgq4CyHPoMaKMLQ42T1i339QBiOZ5z3ClmI
        v1Ql7hSvCDiTL9+hq2X6R6EeGjkWs5I=
X-Google-Smtp-Source: AH8x226k5WyHQlXqQb3jQS/vIz6i5v1TxGfMiqcIlaiAYalJ6ccGtpC/xf7LeF1oSlnDMB0K+dkR1Q==
X-Received: by 10.55.71.201 with SMTP id u192mr20959901qka.357.1519066414959;
        Mon, 19 Feb 2018 10:53:34 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:34 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 03/13] commit-graph: create git-commit-graph builtin
Date:   Mon, 19 Feb 2018 13:53:16 -0500
Message-Id: <1519066406-81663-4-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git the 'commit-graph' builtin that will be used for writing and
reading packed graph files. The current implementation is mostly
empty, except for an '--object-dir' option.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                         |  1 +
 Documentation/git-commit-graph.txt | 11 +++++++++++
 Makefile                           |  1 +
 builtin.h                          |  1 +
 builtin/commit-graph.c             | 37 +++++++++++++++++++++++++++++++++++++
 command-list.txt                   |  1 +
 git.c                              |  1 +
 7 files changed, 53 insertions(+)
 create mode 100644 Documentation/git-commit-graph.txt
 create mode 100644 builtin/commit-graph.c

diff --git a/.gitignore b/.gitignore
index 833ef3b..e82f901 100644
--- a/.gitignore
+++ b/.gitignore
@@ -34,6 +34,7 @@
 /git-clone
 /git-column
 /git-commit
+/git-commit-graph
 /git-commit-tree
 /git-config
 /git-count-objects
diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
new file mode 100644
index 0000000..e1c3078
--- /dev/null
+++ b/Documentation/git-commit-graph.txt
@@ -0,0 +1,11 @@
+git-commit-graph(1)
+===================
+
+NAME
+----
+git-commit-graph - Write and verify Git commit graphs (.graph files)
+
+GIT
+---
+Part of the linkgit:git[1] suite
+
diff --git a/Makefile b/Makefile
index ee9d5eb..fc40b81 100644
--- a/Makefile
+++ b/Makefile
@@ -932,6 +932,7 @@ BUILTIN_OBJS += builtin/clone.o
 BUILTIN_OBJS += builtin/column.o
 BUILTIN_OBJS += builtin/commit-tree.o
 BUILTIN_OBJS += builtin/commit.o
+BUILTIN_OBJS += builtin/commit-graph.o
 BUILTIN_OBJS += builtin/config.o
 BUILTIN_OBJS += builtin/count-objects.o
 BUILTIN_OBJS += builtin/credential.o
diff --git a/builtin.h b/builtin.h
index 42378f3..079855b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -149,6 +149,7 @@ extern int cmd_clone(int argc, const char **argv, const char *prefix);
 extern int cmd_clean(int argc, const char **argv, const char *prefix);
 extern int cmd_column(int argc, const char **argv, const char *prefix);
 extern int cmd_commit(int argc, const char **argv, const char *prefix);
+extern int cmd_commit_graph(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
new file mode 100644
index 0000000..98110bb
--- /dev/null
+++ b/builtin/commit-graph.c
@@ -0,0 +1,37 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+
+static char const * const builtin_commit_graph_usage[] = {
+	N_("git commit-graph [--object-dir <objdir>]"),
+	NULL
+};
+
+static struct opts_commit_graph {
+	const char *obj_dir;
+} opts;
+
+
+int cmd_commit_graph(int argc, const char **argv, const char *prefix)
+{
+	static struct option builtin_commit_graph_options[] = {
+		{ OPTION_STRING, 'p', "object-dir", &opts.obj_dir,
+			N_("dir"),
+			N_("The object directory to store the graph") },
+		OPT_END(),
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_commit_graph_usage,
+				   builtin_commit_graph_options);
+
+	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix,
+			     builtin_commit_graph_options,
+			     builtin_commit_graph_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	usage_with_options(builtin_commit_graph_usage,
+			   builtin_commit_graph_options);
+}
+
diff --git a/command-list.txt b/command-list.txt
index a1fad28..835c589 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -34,6 +34,7 @@ git-clean                               mainporcelain
 git-clone                               mainporcelain           init
 git-column                              purehelpers
 git-commit                              mainporcelain           history
+git-commit-graph                        plumbingmanipulators
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
diff --git a/git.c b/git.c
index 9e96dd4..d4832c1 100644
--- a/git.c
+++ b/git.c
@@ -388,6 +388,7 @@ static struct cmd_struct commands[] = {
 	{ "clone", cmd_clone },
 	{ "column", cmd_column, RUN_SETUP_GENTLY },
 	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
+	{ "commit-graph", cmd_commit_graph, RUN_SETUP },
 	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 	{ "config", cmd_config, RUN_SETUP_GENTLY },
 	{ "count-objects", cmd_count_objects, RUN_SETUP },
-- 
2.7.4

