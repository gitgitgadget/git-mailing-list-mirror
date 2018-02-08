Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50AA81F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeBHUh6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:37:58 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34081 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeBHUhz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:37:55 -0500
Received: by mail-qk0-f194.google.com with SMTP id m130so7348207qke.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cFx0TZ4l7hwFr3s+EAGutdhNfq5BpWyhErpf5LnfQB0=;
        b=ezA1M6g8lamNSLPJqSBKdJ1GHK9K9ydPWmx+FA39UNg30VGi19O1wvf9Sw3+I2huYk
         hrYSANwKOaKVwpDVGEWZKh5OjFDy5UYYMBmlSA7tfXmPJQK5neDNNhnRcuLYsAVq0faS
         ULhE4l4mXuB/yKE0PXt7l2t7wJYuoPoiKfZEGmvAeePa7zXJlW3I3/SPAmevcgUyTaOg
         Xdfn47y8lf0mU5gqOMNk9bo8Pu1f/H376DA9C0epj9sftkhQtkNcZ2D1iDIPZdNdj5fU
         lSgDx5mK8NE1vOwSGmppy3T0yzhH0uUTZaVGAtPOU5Kul8ITeIKyyMTg2EhJO7btc0m6
         eLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cFx0TZ4l7hwFr3s+EAGutdhNfq5BpWyhErpf5LnfQB0=;
        b=qHKTEuDaJgra6ONd1B3S/BMw7/2SIgpCbR2JH0DinaNRMCSRk/co9TLPKWcSEZF3c0
         mvE3ugK42TCAcqH1NKlZXdkG+EKOQ9SCPrUvl2yEYZOXukHM+ieqbpMFUwPSZ0Bvy0Qk
         weSMJKLzAQeI2dJB4t/It3jaxbabU8jJ7AYG+K4xca5wjd8CPibX09kJRj3hNwS7o6Fz
         KVQCjEPQRGeOb3Fvt9Nzay4M0jh+hBsGV3tLU5WUqBZIp1mS9Nk8AAEtISyem05nTkuO
         yTx6IOJda4410Z2KCpVHN7uLL5/AYhOjANgM4OfPKZu2g+L/pvN5HL3QXBUNLticuTIq
         o2Cw==
X-Gm-Message-State: APf1xPBX4jiVslShyG3Z484w3sASxtBZ1DPMHcdsQzZU3Fr3DRqb4AyC
        cuwDRWBsypiu2NSIj8/8pYIKqafDalM=
X-Google-Smtp-Source: AH8x224hIELeBWF9IJUSPHxn7/O5YFQr4Q825CNgQcNELOrf8GDEQXHB5NQnekyNelzcHNuKiu6Gvg==
X-Received: by 10.55.185.69 with SMTP id j66mr429963qkf.254.1518122274855;
        Thu, 08 Feb 2018 12:37:54 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:37:54 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 03/14] commit-graph: create git-commit-graph builtin
Date:   Thu,  8 Feb 2018 15:37:27 -0500
Message-Id: <1518122258-157281-4-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git the 'commit-graph' builtin that will be used for writing and
reading packed graph files. The current implementation is mostly
empty, except for a '--pack-dir' option.

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
index 0000000000..e1c3078ca1
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
index ee9d5eb11e..fc40b816dc 100644
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
index 0000000000..a01c5d9981
--- /dev/null
+++ b/builtin/commit-graph.c
@@ -0,0 +1,37 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+
+static char const * const builtin_commit_graph_usage[] = {
+	N_("git commit-graph [--pack-dir <packdir>]"),
+	NULL
+};
+
+static struct opts_commit_graph {
+	const char *pack_dir;
+} opts;
+
+
+int cmd_commit_graph(int argc, const char **argv, const char *prefix)
+{
+	static struct option builtin_commit_graph_options[] = {
+		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
+			N_("dir"),
+			N_("The pack directory to store the graph") },
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
diff --git a/git.c b/git.c
index 9e96dd4090..d4832c1e0d 100644
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
2.15.1.45.g9b7079f

