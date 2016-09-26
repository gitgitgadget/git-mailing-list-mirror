Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360F3207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 22:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932713AbcIZWrK (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:47:10 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34242 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932189AbcIZWrI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:47:08 -0400
Received: by mail-pf0-f180.google.com with SMTP id l25so22065726pfb.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BeiBa1te0zWpINW9A71IIpxqiicaRwroaQEqWBx3T9E=;
        b=bnG6WJGzW0ZOYG2qwuRHOQIG14KrbuV72PNCmRHEQe9k4Eugb/tG1sfFfQxsNgY6N6
         ZPXKEibkx3wqFfepDA0SmSg7SVovjWs4eSgTrBFSlqTNcCq2sIGjhj1vfpfSXXuQnekd
         Nx9TGQiDDAl2+Xz+ApEHkFYoT4L302y8bU1O3CoI0lbBFPbTBZUW7YQVOS84pNAFr6dE
         pOt8gmdGl8B7KkwIF1Qh18riym442McSTnn/ca9exV8sVeSCNsM1Z8s7NbpIaWnVCokC
         cxzrf9hheSWzjarJcdyS39oLUUtXjlkiWW3hzSk3Mv2zRA5dON8l+GKo8vBM4dLtgzgS
         QmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BeiBa1te0zWpINW9A71IIpxqiicaRwroaQEqWBx3T9E=;
        b=VzrEjj/crhlEF8RHCc+EdhinLH3P2oHqnVN27Y9KJXi6tjtDGxBCImS/bJf/qG9Ph/
         KRadPszuVmR9149BOyKW7vBWq/KUI804X3KxC4+2yyCmPOW7xPLQvhKAer6W3kng2GH9
         BCxg2UKw2t+DMInBULJgpDCW00GAVcmXGR7S3uSaJwNG1gpHYheG1ABuGDcGnVopPl/r
         9VsuhBDAn0WK2g1F4sAxSzI+7kxGlIERMBczkaJB8Q4dtkHHbMtBbmPamsgAJFSvfvFt
         XKgf5nuUjAldsw9fFKVHpOuQsY5qAfndmwkeYPBz6EjJhQBLO3Vyl7EuE/LXbZQFFMP2
         pN9g==
X-Gm-Message-State: AE9vXwMIxhCJmJW6uj2R2xNw5E97OeOnBef8bHwyeaT9MUbZBANXdAr/gqjZNurbwE6Uc4jt
X-Received: by 10.98.86.11 with SMTP id k11mr41434228pfb.182.1474930027265;
        Mon, 26 Sep 2016 15:47:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:9046:8098:b971:afcc])
        by smtp.gmail.com with ESMTPSA id b188sm30513386pfa.82.2016.09.26.15.47.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Sep 2016 15:47:06 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/4 v4] submodules: make submodule-prefix option
Date:   Mon, 26 Sep 2016 15:46:40 -0700
Message-Id: <1474930003-83750-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1474930003-83750-1-git-send-email-bmwill@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <1474930003-83750-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a submodule-prefix environment variable
'GIT_INTERNAL_SUBMODULE_PREFIX' which can be used by commands which have
--recurse-submodule options to give context to submodules about how they
were invoked.  This option is only allowed for builtins which have
submodule support.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git.txt |  5 +++++
 cache.h               |  1 +
 environment.c         |  1 +
 git.c                 | 19 +++++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7913fc2..d29967a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -13,6 +13,7 @@ SYNOPSIS
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
+    [--submodule-prefix=<path>]
     <command> [<args>]
 
 DESCRIPTION
@@ -601,6 +602,10 @@ foo.bar= ...`) sets `foo.bar` to the empty string.
 	details.  Equivalent to setting the `GIT_NAMESPACE` environment
 	variable.
 
+--submodule-prefix=<path>::
+	Set a prefix which gives submodules context about the superproject that
+	invoked it.  Only allowed for commands which support submodules.
+
 --bare::
 	Treat the repository as a bare repository.  If GIT_DIR
 	environment is not set, it is set to the current working
diff --git a/cache.h b/cache.h
index 3556326..ae88a35 100644
--- a/cache.h
+++ b/cache.h
@@ -408,6 +408,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
+#define GIT_SUBMODULE_PREFIX_ENVIRONMENT "GIT_INTERNAL_SUBMODULE_PREFIX"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
diff --git a/environment.c b/environment.c
index ca72464..7380815 100644
--- a/environment.c
+++ b/environment.c
@@ -120,6 +120,7 @@ const char * const local_repo_env[] = {
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
+	GIT_SUBMODULE_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
 	GIT_COMMON_DIR_ENVIRONMENT,
 	NULL
diff --git a/git.c b/git.c
index 1c61151..b2b096a 100644
--- a/git.c
+++ b/git.c
@@ -164,6 +164,20 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd, 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--submodule-prefix")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No prefix given for --submodule-prefix.\n" );
+				usage(git_usage_string);
+			}
+			setenv(GIT_SUBMODULE_PREFIX_ENVIRONMENT, (*argv)[1], 1);
+			if (envchanged)
+				*envchanged = 1;
+			(*argv)++;
+			(*argc)--;
+		} else if (skip_prefix(cmd, "--submodule-prefix=", &cmd)) {
+			setenv(GIT_SUBMODULE_PREFIX_ENVIRONMENT, cmd, 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
 			char *cwd = xgetcwd();
 			is_bare_repository_cfg = 1;
@@ -310,6 +324,7 @@ static int handle_alias(int *argcp, const char ***argv)
  * RUN_SETUP for reading from the configuration file.
  */
 #define NEED_WORK_TREE		(1<<3)
+#define SUPPORT_SUBMODULES	(1<<4)
 
 struct cmd_struct {
 	const char *cmd;
@@ -344,6 +359,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	}
 	commit_pager_choice();
 
+	if (!help && (getenv(GIT_SUBMODULE_PREFIX_ENVIRONMENT) &&
+		      !(p->option & SUPPORT_SUBMODULES)))
+		die("%s doesn't support submodules", p->cmd);
+
 	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
-- 
2.8.0.rc3.226.g39d4020

