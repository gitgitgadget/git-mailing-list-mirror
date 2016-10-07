Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB7620986
	for <e@80x24.org>; Fri,  7 Oct 2016 18:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754476AbcJGSTW (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 14:19:22 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34275 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753136AbcJGSTU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:19:20 -0400
Received: by mail-pa0-f44.google.com with SMTP id rz1so25807080pab.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 11:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QFNN/yaRj9iHwSF5uwUvxu5EkHj9JlKuOWU42py0Z+Q=;
        b=Om3UBFlV/N08jVPpUDDVFmnaTa0XwRF1ogCrzh6b4rUGLagupV+V2lhgIfh9sXC7B9
         Dqlm/yXg1qOKEfHGjew7h5jaxU4DEUaA6vFsM5f9+Z83/zNFXLbOua9Dr85ykbuRAOZj
         2iQ6YyUlxIDRu6D9KMlmOQe1PJ/rCzLagu87ADDOMp9ZGUWlosHw67cianHCIeq94HFB
         gBZ0O7It+DMhxNyZzl0jp+HebzPim1eTqc951Vq0wqImRpvImW+xnrAG3HEqm290TqRj
         Ck9YiKOZVgdPYzIQXN65MDdevtZ/WKFNcHO1mPX1uC9ds2B80UkHN+mkXdvL7a67CIpi
         A6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QFNN/yaRj9iHwSF5uwUvxu5EkHj9JlKuOWU42py0Z+Q=;
        b=CmxZS0remBOlww1OOauu5lqRFoFS7NkpjaPYJPlCWImro/KtmhLnrkq9ImV+YMtdWX
         TShxgQz0x3CWOo42NbOyo/1npICTd8a69yc5vxluTJQrrq9sIiqi/SpIObqDi/arxfxW
         gE0Aed9z0gXLhSgQdURWznp02dDhpMKp4DA0Nvh7GFcIWvp6e+h+HP4r67Qb/zjnrKgh
         VTOsf42z3rTFgdUgo0JvSNOsOhuPTNcrCFZUV41zF6yPxmeftKrbU9eHiSl2Xc9PpJ7/
         eOs+R4OmAoCV56SKytc6g8VgurE9yOWrOL1UDfno3Y3xqSvh4LEsMCwPzfw9xY7VIcyv
         YSqw==
X-Gm-Message-State: AA6/9RmNzqbkjCpmaDYHbYFJ1nfurgEc0ANsRv9rQhKRig1zSdoE2yoyswvg5bqYKSvx7LUt
X-Received: by 10.66.5.7 with SMTP id o7mr16671468pao.19.1475864359728;
        Fri, 07 Oct 2016 11:19:19 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.36.144])
        by smtp.gmail.com with ESMTPSA id s74sm15641281pfk.61.2016.10.07.11.19.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 07 Oct 2016 11:19:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v7 1/4] git: make super-prefix option
Date:   Fri,  7 Oct 2016 11:18:48 -0700
Message-Id: <20161007181851.15063-2-bmwill@google.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161007181851.15063-1-bmwill@google.com>
References: <1475185723-36871-1-git-send-email-bmwill@google.com>
 <20161007181851.15063-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a super-prefix environment variable 'GIT_INTERNAL_SUPER_PREFIX'
which can be used to specify a path from above a repository down to its
root.  When such a super-prefix is specified, the paths reported by Git
are prefixed with it to make them relative to that directory "above".
The paths given by the user on the command line
(e.g. "git subcmd --output-file=path/to/a/file" and pathspecs) are taken
relative to the directory "above" to match.

The immediate use of this option is by commands which have a
--recurse-submodule option in order to give context to submodules about
how they were invoked.  This option is currently only allowed for
builtins which support a super-prefix.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git.txt |  6 ++++++
 cache.h               |  2 ++
 environment.c         | 13 +++++++++++++
 git.c                 | 25 +++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7913fc2..2188ae6 100644
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
+	Currently for internal use only.  Set a prefix which gives a path from
+	above a repository down to its root.  One use is to give submodules
+	context about the superproject that invoked it.
+
 --bare::
 	Treat the repository as a bare repository.  If GIT_DIR
 	environment is not set, it is set to the current working
diff --git a/cache.h b/cache.h
index 3556326..8cf495d 100644
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
+extern const char *get_super_prefix(void);
 extern const char *get_git_work_tree(void);
 
 /*
diff --git a/environment.c b/environment.c
index ca72464..d12d7db 100644
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
@@ -222,6 +225,16 @@ const char *strip_namespace(const char *namespaced_ref)
 	return namespaced_ref + namespace_len;
 }
 
+const char *get_super_prefix(void)
+{
+	static int initialized;
+	if (!initialized) {
+		super_prefix = getenv(GIT_SUPER_PREFIX_ENVIRONMENT);
+		initialized = 1;
+	}
+	return super_prefix;
+}
+
 static int git_work_tree_initialized;
 
 /*
diff --git a/git.c b/git.c
index 1c61151..469a83f 100644
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
+			die("can't use --super-prefix from a subdirectory");
+	}
+
 	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
@@ -558,6 +580,9 @@ static void execv_dashed_external(const char **argv)
 	const char *tmp;
 	int status;
 
+	if (get_super_prefix())
+		die("%s doesn't support --super-prefix", argv[0]);
+
 	if (use_pager == -1)
 		use_pager = check_pager_config(argv[0]);
 	commit_pager_choice();
-- 
2.10.0

