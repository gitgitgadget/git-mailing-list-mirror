Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A0A1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbeA3VkR (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:17 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42250 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeA3VkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:14 -0500
Received: by mail-qk0-f194.google.com with SMTP id k201so12132312qke.9
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f2weVzwR63pjqXNxTTx8Wbd0Nadbkr+0rluwCIOAQhQ=;
        b=AjwCG+bSKz/WzobPZ5SPBexgufle5XXFCnstrfnjp7uk4LtQtJxqLEnlnhYkdYcw1f
         rdfUhozgS8JWqxDWSQS7bkkMimRG57G0P3ZCAk16qwfDGQLeg5IuN7C4R5M67EHhol0L
         Yzfbak7GRokA28nKsTwswobtF4+zf+jSmFDjtU7Fy8HclkjDFSCBqmdoUxTBSkt7W4A8
         hIadra9iOIoNH8u9OiqRzXJUBqxp8CY4M/C2lav8ebZnG2OPzv0vz6ICzpgU2r8izEf4
         UYROPmtVRSgajZ3EXqMOUOupctmgHQrQtE9SQ1foA70rJpvHLKGDZgwA07Ji6vmFlydk
         u9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f2weVzwR63pjqXNxTTx8Wbd0Nadbkr+0rluwCIOAQhQ=;
        b=oI1bNDGede+op/rrgcDMn+NBdYSZEJeYcHykg3VfR3NNooL1J4LhOoCZaF7kbPWbaS
         nWBwiDeAXHO6twLO0Ajb2qnYghig74Au27zJ7z90uNfXi941sjO9803fWMniMoQFgPcF
         iyrH+k19wWkxa/NVLKBcVPKJHAxD92YgczaBehN3J6fm6FdFEPejc3vPsD50qCFKAXcZ
         EXCOWIQM1J9HoZhVKi00xa/RTLVTaW31jLFeihtpe28IbGP+u+G9P3NSgOx6RK3MqxkS
         T1+F9Enk9j/ZG6+lqmjeY5iN5bo0E0BpaSmL9LXIH0KQR6nzL4tUAuliF59FD9MxIWYo
         RTxQ==
X-Gm-Message-State: AKwxytdsuDGllBqPTryun0tTCq5z/B1cLn96OjplSZgmRbHa8oo1jj1V
        UntL+bUKfFSbAISZjaqs1w8sOpmx
X-Google-Smtp-Source: AH8x2246kUAIX5llAsBj7c6WTePx51bzMbbUv71QG5mjq9/qBFwhBXgDkrkbuykBFcNB7F0F07Maaw==
X-Received: by 10.233.220.130 with SMTP id q124mr46297405qkf.170.1517348413765;
        Tue, 30 Jan 2018 13:40:13 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:13 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 03/14] commit-graph: create git-commit-graph builtin
Date:   Tue, 30 Jan 2018 16:39:32 -0500
Message-Id: <1517348383-112294-4-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
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
 Documentation/git-commit-graph.txt |  7 +++++++
 Makefile                           |  1 +
 builtin.h                          |  1 +
 builtin/commit-graph.c             | 33 +++++++++++++++++++++++++++++++++
 command-list.txt                   |  1 +
 git.c                              |  1 +
 7 files changed, 45 insertions(+)
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
index 0000000000..c8ea548dfb
--- /dev/null
+++ b/Documentation/git-commit-graph.txt
@@ -0,0 +1,7 @@
+git-commit-graph(1)
+============
+
+NAME
+----
+git-commit-graph - Write and verify Git commit graphs (.graph files)
+
diff --git a/Makefile b/Makefile
index 1a9b23b679..aee5d3f7b9 100644
--- a/Makefile
+++ b/Makefile
@@ -965,6 +965,7 @@ BUILTIN_OBJS += builtin/for-each-ref.o
 BUILTIN_OBJS += builtin/fsck.o
 BUILTIN_OBJS += builtin/gc.o
 BUILTIN_OBJS += builtin/get-tar-commit-id.o
+BUILTIN_OBJS += builtin/commit-graph.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
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
index 0000000000..2104550d25
--- /dev/null
+++ b/builtin/commit-graph.c
@@ -0,0 +1,33 @@
+#include "builtin.h"
+#include "cache.h"
+#include "config.h"
+#include "dir.h"
+#include "git-compat-util.h"
+#include "lockfile.h"
+#include "packfile.h"
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
+	return 0;
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
diff --git a/git.c b/git.c
index c870b9719c..c7b5adae7b 100644
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
2.16.0.15.g9c3cf44.dirty

