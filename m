Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF7C71F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeB0Cd2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:28 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43976 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbeB0CdS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:18 -0500
Received: by mail-qt0-f194.google.com with SMTP id d26so21405627qtk.10
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LliPx5lS7lKrJsr/ndPHOt72le/ovlwArz+FDrQieFw=;
        b=lQVQGJmdMJhpc5XR1/0zeL0Lm3Fm6yLJ0VPIRtQGLS7PeIJuNXUbrQy8AX0ipMIdv2
         kDZT89FoxXh9keLnpJ7gxGNE35fHIX41copwAxKvH1tAtS07Tr271l/EPWWRU8H9D18i
         L3efx6sMDznWjDPWgj2BTC89ccMlSsm3qYG9OMbXVYPkb+oSuCYL8kR/v34nXgmfMlyU
         quBGHWB8DE7cpu9J63fr6yzp8gQ5aPgiVi0Y+P9THnuT54xJm2rhPXjCrzYjzsiwGRyG
         R6JEhC762PO7BPT9Ye5j+/Iich4xcfCoJbNs6I+FtEC5baxMjF/3Ud3VugILU/ofbNUW
         Zkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LliPx5lS7lKrJsr/ndPHOt72le/ovlwArz+FDrQieFw=;
        b=NjH3ETMTOMTl4ztzjeQoPyVYADy/St4CO1ZxAAZgMPWZfaylHshVZ7aXIbIfrod6UJ
         5CydEHoh0WXik44tLSk9K7zoBLPwNyyXmI8wprIswKKNuW1nQ9HsXtF33uEHRO8dPDtg
         vI0X+PK6yLgx/MsuJyrbBuUgQr38ngJuwYWLDEZO24gfh7n9pwN33IyQ27STC/ip4tTo
         IE7OShsUpz+yrxm8/SGU6brCAzusUceTZplk02e8x5a8X3hWo/Zu11YNf/keII4ZNdjs
         QWbu8TtiIQZ7va+mvs/36prs+ejASewy+f2KpqTmF35vRCaE1ewrDaV3l5sdzK48mrZ5
         +fkA==
X-Gm-Message-State: APf1xPDBMgdAGxAcAPJ6XjvG7EdF4tPp6tNWaWCO/PcFITk7dKIkGW1e
        lRMDu/nNErZ6roJ5FUzdPfQBm4bDqaA=
X-Google-Smtp-Source: AG47ELviDAiRkHyOx/luz//YhlicuxL6GCTG651GzW03ykxOO7ZBJo+b7Kc5D3Z7tR/2HBM8Yz48dA==
X-Received: by 10.237.41.194 with SMTP id o60mr21508784qtd.128.1519698797208;
        Mon, 26 Feb 2018 18:33:17 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:16 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 03/13] commit-graph: create git-commit-graph builtin
Date:   Mon, 26 Feb 2018 21:32:57 -0500
Message-Id: <1519698787-190494-4-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the help in getting all the details right in setting up a
builtin.

-- >8 --

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
index 0000000..5913340
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
index c56fdc1..2e4956f 100644
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
index 0000000..8ff7336
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
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 88813e9..b060b6f 100644
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
index c870b97..c7b5ada 100644
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

