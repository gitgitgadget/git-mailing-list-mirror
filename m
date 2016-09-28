Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5811F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 21:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbcI1VvW (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 17:51:22 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34917 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754411AbcI1VvU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 17:51:20 -0400
Received: by mail-pa0-f47.google.com with SMTP id oz2so20476441pac.2
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 14:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dFTZiWaw4lD1LNDpVurNTS+q1gd/lFz8H+Q1sAFrBRk=;
        b=au6cY5/zhZKfWp1pha8y4feppAif9JmvWUd6uspfh6Dp1Hfvf4vybgHiL6h843gJSe
         EhzFDgzkbaZFGvs9D2e17lAGZj1Ve4nru1/L03WSL1Dp6EYwIc3dG856NR4cixZmE3nF
         q1GmYwe88W9NocPVC6vZ/u5XIjYTGTtKrThd+qyCkEJ9JP7jA8pHAQgoR4ORAtG3AEb+
         plcjZO14hiSI1VIrTASHte/MWpe2ZE3fLsoDY/SnPEPjjO9AIR4dLr8wRz3n2wwwXFUn
         GHF2rx31w3Ww0uy/emn54ebm2wluIBuaPDC7hPetMKuD7iSTruIyRqM+7Qt/8rJW95s9
         4DeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dFTZiWaw4lD1LNDpVurNTS+q1gd/lFz8H+Q1sAFrBRk=;
        b=VDeGbzWHla0JBOQIv//JAe54oF1jd0Y+MTuDlKhdgD+sMCNGaZ46kJ5SZmiCsekRjh
         GMBtOMC2RtYbi1+wEbli6QIQifgSDvoUFe5QQJmkDqhdL1LOyqW1OAba1Uu/vrB2T/ak
         5dXq/GWf0b26Mp2Fk4yGMBmLFmlGEWYcquS8pk3Skbq7gcUCQQeac+OOnjkGxR9wVlhd
         1WhW0P1RQjMbs8Vr8Oy4TUwUKqt9q9MD0dezoGRy/oFWTT4Or06GlH7yM8H9W6tZxHex
         ZkWOH6PQ7999khRnT70UPv+dOzOl783g/BVOvfyEmb/+bw0DXjpBY9+yx3aACbqcR9Id
         sAHQ==
X-Gm-Message-State: AA6/9Rnn6VYF/unQnhrlXa5c8yUpIvlPaPVc2FVSKwJHGAiKIgTYCYrcrwtkEgX25FRlj7N7
X-Received: by 10.66.84.34 with SMTP id v2mr10679666pay.54.1475099479271;
        Wed, 28 Sep 2016 14:51:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8def:9119:a35:c58b])
        by smtp.gmail.com with ESMTPSA id t6sm14735802paa.45.2016.09.28.14.51.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Sep 2016 14:51:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v5 1/4] git: make super-prefix option
Date:   Wed, 28 Sep 2016 14:50:40 -0700
Message-Id: <1475099443-145608-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1475099443-145608-1-git-send-email-bmwill@google.com>
References: <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1475099443-145608-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a super-prefix environment variable 'GIT_INTERNAL_SUPER_PREFIX'
which can be used to specify a path from above a repository down to its
root.  The immediate use of this option is by commands which have a
--recurse-submodule option in order to give context to submodules about
how they were invoked.  This option is currently only allowed for
builtins which support a super-prefix.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git.txt |  6 ++++++
 cache.h               |  2 ++
 environment.c         | 10 ++++++++++
 git.c                 | 22 ++++++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7913fc2..e3309b9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -13,6 +13,7 @@ SYNOPSIS
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
+    [--super-prefix=<path>]
     <command> [<args>]
 
 DESCRIPTION
@@ -601,6 +602,11 @@ foo.bar= ...`) sets `foo.bar` to the empty string.
 	details.  Equivalent to setting the `GIT_NAMESPACE` environment
 	variable.
 
+--super-prefix=<path>::
+	Set a prefix which gives a path from above a repository down to its
+	root.  One use is to give submodules context about the superproject that
+	invoked it.  Currently for internal use only.
+
 --bare::
 	Treat the repository as a bare repository.  If GIT_DIR
 	environment is not set, it is set to the current working
diff --git a/cache.h b/cache.h
index 3556326..01730e1 100644
--- a/cache.h
+++ b/cache.h
@@ -408,6 +408,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
+#define GIT_SUPER_PREFIX_ENVIRONMENT "GIT_INTERNAL_SUPER_PREFIX"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
@@ -468,6 +469,7 @@ extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 extern int get_common_dir(struct strbuf *sb, const char *gitdir);
 extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
+extern const char *get_super_prefix();
 extern const char *get_git_work_tree(void);
 
 /*
diff --git a/environment.c b/environment.c
index ca72464..1a2a779 100644
--- a/environment.c
+++ b/environment.c
@@ -100,6 +100,8 @@ static char *work_tree;
 static const char *namespace;
 static size_t namespace_len;
 
+static const char *super_prefix;
+
 static const char *git_dir, *git_common_dir;
 static char *git_object_dir, *git_index_file, *git_graft_file;
 int git_db_env, git_index_env, git_graft_env, git_common_dir_env;
@@ -120,6 +122,7 @@ const char * const local_repo_env[] = {
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
+	GIT_SUPER_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
 	GIT_COMMON_DIR_ENVIRONMENT,
 	NULL
@@ -222,6 +225,13 @@ const char *strip_namespace(const char *namespaced_ref)
 	return namespaced_ref + namespace_len;
 }
 
+const char *get_super_prefix()
+{
+	if (!super_prefix)
+		super_prefix = getenv(GIT_SUPER_PREFIX_ENVIRONMENT);
+	return super_prefix;
+}
+
 static int git_work_tree_initialized;
 
 /*
diff --git a/git.c b/git.c
index 1c61151..3e5cd63 100644
--- a/git.c
+++ b/git.c
@@ -164,6 +164,20 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd, 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--super-prefix")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No prefix given for --super-prefix.\n" );
+				usage(git_usage_string);
+			}
+			setenv(GIT_SUPER_PREFIX_ENVIRONMENT, (*argv)[1], 1);
+			if (envchanged)
+				*envchanged = 1;
+			(*argv)++;
+			(*argc)--;
+		} else if (skip_prefix(cmd, "--super-prefix=", &cmd)) {
+			setenv(GIT_SUPER_PREFIX_ENVIRONMENT, cmd, 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
 			char *cwd = xgetcwd();
 			is_bare_repository_cfg = 1;
@@ -310,6 +324,7 @@ static int handle_alias(int *argcp, const char ***argv)
  * RUN_SETUP for reading from the configuration file.
  */
 #define NEED_WORK_TREE		(1<<3)
+#define SUPPORT_SUPER_PREFIX	(1<<4)
 
 struct cmd_struct {
 	const char *cmd;
@@ -344,6 +359,13 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	}
 	commit_pager_choice();
 
+	if (!help && get_super_prefix()) {
+		if (!(p->option & SUPPORT_SUPER_PREFIX))
+			die("%s doesn't support --super-prefix", p->cmd);
+		if (prefix)
+			die("can't have both a prefix and super-prefix");
+	}
+
 	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
-- 
2.8.0.rc3.226.g39d4020

