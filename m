Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204921F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeCNT2E (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:28:04 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46738 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeCNT2A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 15:28:00 -0400
Received: by mail-qt0-f194.google.com with SMTP id m13so4680670qtg.13
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=06x7tZ0tMyMSsvJTqWVkBawYx25d1I4M4/F3G6vqI7E=;
        b=Pn/7LwSlrCfHCg6Bz5JKuGt+BhrKxwUsOrLuqDEssw8efFTvdYVgpk4HxQTbfRApuf
         CCRbkrk/B/wY5B6QnaTamX6k//F+fXNIcS3qDabwJ/Njjq8XxsraHZflIXIINxUbdV5O
         MMx+xYUpbKtoPEDmkxAC6+7St6n1/KA+AqI3PyirrONd1FmTN3CR+8WcZewmu235/Vuf
         LSW8AzuZiLna8jkmfhB/mt278jK742QNCX9xnZ/3BzQ8gRj89NgDH60LZOCEAU+CSHy3
         ZmoA7HHoUcvzgHOt91y7h/v3y73ff1FWCCYPdPMIRmkK+4z8bmsLtIANBElSkSMfo6cq
         XLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=06x7tZ0tMyMSsvJTqWVkBawYx25d1I4M4/F3G6vqI7E=;
        b=p20nqbzkzYAjANwCBamGE6X/oSaiZVxt6BlhAzvFOdd5DhkKns5sXfmJyQTU2HDZt5
         LwP6qyVCDOPwfs758Z2tTdTAWbKtOMB+Pme7YK4SZ4/LG7oiOQU4V5wqI0nlcAi75Dme
         +1nO+doMjbrRZDiBTnKr1G/SWcovZgIx//UqM54QtTC2IY1/uTpgsffXyo11ZItRpfV4
         6tdvNtRyWKtmF2e9/36OSohO6wUpGlMx8BeajxtyZQsUBHOxulXe3izqGtL1sd9FtpSQ
         RqCOkgPMNfbsEoaOVCUNx5EItgWRAfP2f6at/KkKHPvpuLXL+R9gAUS0HyE5/0xRtcgl
         IYjg==
X-Gm-Message-State: AElRT7GeztTf/6SoPLfwgZkKD8jdD7CuJ1gRP+Pebt0Fr6SvnAYwNPkI
        rmJAGM7pt8Orr2+UacyYJsq5gaFZZY4=
X-Google-Smtp-Source: AG47ELsghyEmUmPHqlFh86kfm/d6yQ91xVPD81Z5BkCNWgzNqqLISpwvB3VptulWaxYhYkL9ds6Aig==
X-Received: by 10.200.36.189 with SMTP id s58mr8852279qts.0.1521055678296;
        Wed, 14 Mar 2018 12:27:58 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id q30sm2847395qte.10.2018.03.14.12.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 12:27:57 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 05/14] commit-graph: create git-commit-graph builtin
Date:   Wed, 14 Mar 2018 15:27:27 -0400
Message-Id: <20180314192736.70602-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Teach git the 'commit-graph' builtin that will be used for writing and
reading packed graph files. The current implementation is mostly
empty, except for an '--object-dir' option.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                             |  1 +
 Documentation/git-commit-graph.txt     | 11 ++++++++++
 Makefile                               |  1 +
 builtin.h                              |  1 +
 builtin/commit-graph.c                 | 37 ++++++++++++++++++++++++++++++++++
 command-list.txt                       |  1 +
 contrib/completion/git-completion.bash |  2 ++
 git.c                                  |  1 +
 8 files changed, 55 insertions(+)
 create mode 100644 Documentation/git-commit-graph.txt
 create mode 100644 builtin/commit-graph.c

diff --git a/.gitignore b/.gitignore
index 833ef3b0b7..e82f90184d 100644
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
index 0000000000..5913340fad
--- /dev/null
+++ b/Documentation/git-commit-graph.txt
@@ -0,0 +1,11 @@
+git-commit-graph(1)
+===================
+
+NAME
+----
+git-commit-graph - Write and verify Git commit graph files
+
+GIT
+---
+Part of the linkgit:git[1] suite
+
diff --git a/Makefile b/Makefile
index de4b8f0c02..a928d4de66 100644
--- a/Makefile
+++ b/Makefile
@@ -946,6 +946,7 @@ BUILTIN_OBJS += builtin/clone.o
 BUILTIN_OBJS += builtin/column.o
 BUILTIN_OBJS += builtin/commit-tree.o
 BUILTIN_OBJS += builtin/commit.o
+BUILTIN_OBJS += builtin/commit-graph.o
 BUILTIN_OBJS += builtin/config.o
 BUILTIN_OBJS += builtin/count-objects.o
 BUILTIN_OBJS += builtin/credential.o
diff --git a/builtin.h b/builtin.h
index 42378f3aa4..079855b6d4 100644
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
index 0000000000..8ff7336527
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
+		OPT_STRING(0, "object-dir", &opts.obj_dir,
+			N_("dir"),
+			N_("The object directory to store the graph")),
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
index a1fad28fd8..835c5890be 100644
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
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 91536d831c..a24af902d8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -841,6 +841,7 @@ __git_list_porcelain_commands ()
 		check-ref-format) : plumbing;;
 		checkout-index)   : plumbing;;
 		column)           : internal helper;;
+		commit-graph)     : plumbing;;
 		commit-tree)      : plumbing;;
 		count-objects)    : infrequent;;
 		credential)       : credentials;;
@@ -2419,6 +2420,7 @@ _git_config ()
 		core.bigFileThreshold
 		core.checkStat
 		core.commentChar
+		core.commitGraph
 		core.compression
 		core.createObject
 		core.deltaBaseCacheLimit
diff --git a/git.c b/git.c
index 96cd734f12..ea777f5d6a 100644
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
2.14.1

