Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5966B20987
	for <e@80x24.org>; Thu, 29 Sep 2016 21:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934812AbcI2VuM (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:50:12 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34043 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932185AbcI2VuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:50:11 -0400
Received: by mail-pf0-f173.google.com with SMTP id u78so7514521pfa.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tM5qDc44wmgcDu/tTXPxbXSX1dpqEJoXRI2t+IYMp/k=;
        b=UxHsturMfpVusftMfRyivZKoH4hZkeD40glF53yNg+XN2i/jwxACEOWunvXDVgZzvX
         4mKv0zFhPxoK0ODySWb0Aupuv+toR7+qFHe0ZGFwx+Jt/Wjz3TA2a+ZyP4bm069mkjhL
         dvbZwX2HoogqldXImzDtH6Q2P1axjHmFARPoXpxoHJ5b+b/DkIsBCxxdSD3TTTB6Ttw9
         js3E/QmjXlRaRp324HWMrmYEKc4NjIyEc4o5Ke5lx83AbRe1b6A4SqMmDodjKEGIbOnT
         PJsXg15zG48pZ0gV6D9zb70XGuZWzogs4dVhpbaV/XyY0VIl4jTlFbecduoshdIEVY32
         SB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tM5qDc44wmgcDu/tTXPxbXSX1dpqEJoXRI2t+IYMp/k=;
        b=TJzYRBTV4xLeY6Y2uxwy09wFfYxYfQM0Xa33TgP7k9oPkana/ySaLHw30Xc3Aogk8M
         bLdIF7DZpamNNHygiBCQ/+7RlVyf7OI3KgWP1iXEkwA592Abr9MJiNdY+u+PKVsbGs3f
         giAq0w98D+9zhC3SuH7JA8Neu/vEI63oc02VJvsu+GHbnV8qogWnQjGoJgTwl+Ph2Z39
         Oo2bbTMLm04vnS+DRp882t0nfxj4HcEIBa70GPQu4f6zAYW2aZl9hbxUCvp5yBSHy5ij
         sQmIU7/53bfec/1QZq1QYRZC6Wsi6BnkuVrxmR/lNBaGTGIp+oUZW7NHqKTEaGNnJtqs
         wwXw==
X-Gm-Message-State: AA6/9RlJ0ekKeraNnoF9hVDueHhIlbk13E71PPy2Az7bMpJNaag/wnTv1B6rQ0ainj5B2ajd
X-Received: by 10.98.149.82 with SMTP id p79mr6132149pfd.150.1475185810444;
        Thu, 29 Sep 2016 14:50:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4c71:119f:edd5:cf6c])
        by smtp.gmail.com with ESMTPSA id si1sm22590933pab.0.2016.09.29.14.50.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 14:50:09 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v6 1/4] git: make super-prefix option
Date:   Thu, 29 Sep 2016 14:48:40 -0700
Message-Id: <1475185723-36871-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1475185723-36871-1-git-send-email-bmwill@google.com>
References: <1475099443-145608-1-git-send-email-bmwill@google.com>
 <1475185723-36871-1-git-send-email-bmwill@google.com>
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
 environment.c         | 10 ++++++++++
 git.c                 | 26 ++++++++++++++++++++++++++
 4 files changed, 44 insertions(+)

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
index ca72464..13f3d70 100644
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
 
+const char *get_super_prefix(void)
+{
+	if (!super_prefix)
+		super_prefix = getenv(GIT_SUPER_PREFIX_ENVIRONMENT);
+	return super_prefix;
+}
+
 static int git_work_tree_initialized;
 
 /*
diff --git a/git.c b/git.c
index 1c61151..f756b62 100644
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
 
@@ -558,6 +580,10 @@ static void execv_dashed_external(const char **argv)
 	const char *tmp;
 	int status;
 
+	if (get_super_prefix()) {
+		die("%s doesn't support --super-prefix", argv[0]);
+	}
+
 	if (use_pager == -1)
 		use_pager = check_pager_config(argv[0]);
 	commit_pager_choice();
-- 
2.10.0

