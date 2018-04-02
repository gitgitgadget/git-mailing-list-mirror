Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DB41F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbeDBUfE (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:35:04 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43563 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932452AbeDBUfA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:35:00 -0400
Received: by mail-qt0-f196.google.com with SMTP id s48so16896653qtb.10
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9IFnpXamcq/RF1fl1AIb1MQ/GhEiZbJNF7+qS5hsyJQ=;
        b=vIagd+kACNFUBDeSHtKTGoFGU/dOb1JCx47uBxjpv8RMa9YDYqFPuRUuHBdebOsalg
         xo3qFg0tzLIv7oN/mPjYtCKkbnI6M1IsY75MOeT9hVe1Z2e9a5Dk6TNvgDx8++xl25eA
         egeQM9znDQz+rVwwknLQHNR/ftrzV0ZBmF/NrJ+yP8BLt/WM820hi+umTqlB8bezax0j
         LXZw53vkNlC4N/HgaICC0J4AVIY2dJ9SbeWcIO4LdqqbqCH0i3uVYOgi1UHQM91D4HNW
         j873VArPL8D43D42YQgEsyhYxkaCzWwMuFQKhEzcMIwjnW6Y3Ex+Mo5d/pcm33M9J0N9
         9Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9IFnpXamcq/RF1fl1AIb1MQ/GhEiZbJNF7+qS5hsyJQ=;
        b=tdKaW8JF6Vhb/PVhkS19sm7S33tVvrfvsJ7omdvsRZ9wA6pqcwc2l+3vlgATS58O6o
         ZIXl7Jf5Czu+CQvd1FP9ZZ5VBv/i+PT7gKOT60Lwhk5TWE/xKWHjRTrTN7w5oCvMPpjb
         3VqpRLi8A3xBBy0vfJwELtgIKDabxZwLuXzSASYZbHC85BzjQ6k5mFyNzbkqEPx7T4rA
         4RuRyyj645m7879e2x0Rdk+I2YqmaNfaPfoAXeEh93x66c0A+5HN1z8n8hjx4OV+xsZr
         XCLYpX3Ruy3shRp0UEfbUFd1DWwFolTDlgRFV3Wvjo57TCm3l0vuzMKGaeMGCwZ6Ec3b
         MQ3g==
X-Gm-Message-State: ALQs6tB+IRLuahA0j58UlDVVvLp1IxR4oGPa15/pO1Z/OT2ax7nwVjae
        dkoxh6s6X9V7aAzKu3HqB5/YiScmvxI=
X-Google-Smtp-Source: AIpwx48KpEFlzHz6Ed36zx47I05PY4Sa10+KR8T8tKJieYAomp7lrU8yl3dTnTRexdu0zBQvqWyPZQ==
X-Received: by 10.237.61.213 with SMTP id j21mr15945080qtf.251.1522701299117;
        Mon, 02 Apr 2018 13:34:59 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id n30sm998611qtb.93.2018.04.02.13.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:34:58 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 05/14] commit-graph: create git-commit-graph builtin
Date:   Mon,  2 Apr 2018 16:34:18 -0400
Message-Id: <20180402203427.170177-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180402203427.170177-1-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
 <20180402203427.170177-1-dstolee@microsoft.com>
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
 Documentation/git-commit-graph.txt     | 10 +++++++
 Makefile                               |  1 +
 builtin.h                              |  1 +
 builtin/commit-graph.c                 | 36 ++++++++++++++++++++++++++
 command-list.txt                       |  1 +
 contrib/completion/git-completion.bash |  2 ++
 git.c                                  |  1 +
 8 files changed, 53 insertions(+)
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
index 0000000000..f3b34622a8
--- /dev/null
+++ b/Documentation/git-commit-graph.txt
@@ -0,0 +1,10 @@
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
diff --git a/Makefile b/Makefile
index a1d8775adb..a59b62bed1 100644
--- a/Makefile
+++ b/Makefile
@@ -952,6 +952,7 @@ BUILTIN_OBJS += builtin/clone.o
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
index 0000000000..b466ecd781
--- /dev/null
+++ b/builtin/commit-graph.c
@@ -0,0 +1,36 @@
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
index b09c8a2362..6726daaf69 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -878,6 +878,7 @@ __git_list_porcelain_commands ()
 		check-ref-format) : plumbing;;
 		checkout-index)   : plumbing;;
 		column)           : internal helper;;
+		commit-graph)     : plumbing;;
 		commit-tree)      : plumbing;;
 		count-objects)    : infrequent;;
 		credential)       : credentials;;
@@ -2350,6 +2351,7 @@ _git_config ()
 		core.bigFileThreshold
 		core.checkStat
 		core.commentChar
+		core.commitGraph
 		core.compression
 		core.createObject
 		core.deltaBaseCacheLimit
diff --git a/git.c b/git.c
index ceaa58ef40..2808c51de9 100644
--- a/git.c
+++ b/git.c
@@ -388,6 +388,7 @@ static struct cmd_struct commands[] = {
 	{ "clone", cmd_clone },
 	{ "column", cmd_column, RUN_SETUP_GENTLY },
 	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
+	{ "commit-graph", cmd_commit_graph, RUN_SETUP },
 	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
 	{ "count-objects", cmd_count_objects, RUN_SETUP },
-- 
2.17.0.14.gba1221a8ce

