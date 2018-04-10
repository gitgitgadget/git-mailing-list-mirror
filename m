Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D711F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeDJM4u (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:56:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34253 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbeDJM4s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:56:48 -0400
Received: by mail-pf0-f196.google.com with SMTP id q9so8242678pff.1
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCipDz0ghHI9TXnMc+0co2pX4TRVczIXPLAVQ1uR9n4=;
        b=qpVLdLvXbqDNGF3FRdi7zOl1OTZuFI9vxcT2OSJnh6MbF4knkrHh32crHOcjmtyjgR
         e+jSpxfb6KTg09nhIqUtaqul6YVR2mpdKKVkJhW1S+QgpiZ3wzNOK3qpkpi96iX14K2v
         /t3nWmkx88P+k+DaX3bS5ZQkLD/OfBENQcl37ykgBwUMvgywmBw4nG450H+HeNmKQSsU
         hpaTTWcs1s/AjxLdPlZmsBZSP/MmUUII7W1ewibr5Evy9hDBQrjpfOoK6SMMixaS6KTM
         sR0XZ5hhmdkdogHyLs+pMx/o1fIKOY4JFPtBri7bRS4bweLsxpOVfkToa0byZVXPJoRO
         QZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCipDz0ghHI9TXnMc+0co2pX4TRVczIXPLAVQ1uR9n4=;
        b=PFKVm9J/PYPMxrpPR4WMAoU6uEPZjesg0TFpUYuGBiP0LUsqGiPhSMvSVS1EKUfVvg
         Ifzv1msL/AJj2mgcXI/VNN9EKyek5pZLQqCxQuVh4Zj3nEDFv/DoeK+i4XiuFAA47Yzz
         WCeDfoqI9izz43t4RowTD4yA1MTDpqUHvll8PuN7SlaY5lT4jLM58lLFF3ltd8b+IkB2
         gYXXhyCuJTjxM9HhJxJZcsfZau1q2OhYOFFlmi6ggYEUmL6D34RY4r4vMQy55dKV4E5M
         hmX8ZFAqAYcpCsu1gOVnAHKkKl2w3A+FiBrAXSzwGzF0AmktJ7dpj4AmcJMW86O+9/iF
         dDfg==
X-Gm-Message-State: ALQs6tBOuvbVp/wXEtt54rFLnRfrnNw8yB99iB2O37dmLQkcxAnLxV1h
        G1//dsLr0eNhnjsV1ZMRHIeoRzPSNBs=
X-Google-Smtp-Source: AIpwx4/vsRhFsjWwBWFycTtS7qUWELjCFBLtRjYfpZ+5ouafvlQVoMSFWxf+itMaVa7o0qp9vzI93Q==
X-Received: by 10.101.70.72 with SMTP id k8mr216693pgr.402.1523365007561;
        Tue, 10 Apr 2018 05:56:47 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id l10sm4421666pgp.35.2018.04.10.05.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 05:56:46 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v8 05/14] commit-graph: create git-commit-graph builtin
Date:   Tue, 10 Apr 2018 08:55:59 -0400
Message-Id: <20180410125608.39443-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410125608.39443-1-dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com>
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
2.17.0

