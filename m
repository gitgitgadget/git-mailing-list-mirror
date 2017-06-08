Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4427D1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdFHXlc (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:32 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33570 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdFHXl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:27 -0400
Received: by mail-pf0-f179.google.com with SMTP id 83so22169052pfr.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dj7tq5bIus2V0aZGyt3zRST0QlYdddABYMNZdkpu2Mc=;
        b=eKaOa+lxHhme2NShZ2neYgSiKzaAtZODg5hE1h2GoBcXSUyVPPzShUXoQN63Ndc/Jm
         wlZ2vCdrHHoxZKxuPX1LKrQj0bFXlSMyS6s7K76CPJzJQEmziCLvLG+owHW/182Mq4H6
         w1TgwvFoEOsk8gq8D+OfqdbzUOc+glP5aVMFw2g8Lgd0DTUW0yf1E+s3JsO5KkCI4TDh
         rFBjPDmIW4bo8IbdfJvTyXwbML1XmXokzfblmfkrIWeYugFHgQ9DXyFfjJBE3AXPCknQ
         TDd3GcM6sGqQeDyj+CDbl8PcIQlDc+0YfdY5m2103ifGZpFg2/9eanZ3aYU4ydGEOR6j
         gjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dj7tq5bIus2V0aZGyt3zRST0QlYdddABYMNZdkpu2Mc=;
        b=hvCVsakUlmFJvEJRTmQPOw6FXmV4sMHTicZ9LoSj/lQnIq9R1ZZ7ybXF4d3QySL6KN
         ftrwmlBBrsBDobcSlcJWHTLeFynQpv8nBWzHN+bZVjlHMChf7nZVpLw39Wndnv79f7sW
         4V//+KLzxB0sMIpdvJRWo1TPOLPg91ZHDUS8/6gdYDWdd+fmkp9jBPoL7+Q94fcx0FAm
         mdCjQI48iRYdEFvCpn57N/ySGpkbsNtYktUOh2ygZMq6KEXUrfSw2FH6EHdXGdD+RmAe
         Tz/ZCHw0T/1cbXX0fOaUmV25YFrdMoA6AzEzc2Bu+cRribxfXK18VSPCrbOkZIG7RkHZ
         bhKQ==
X-Gm-Message-State: AODbwcDCxCStqMSWdomeBr8xCWYHi6y+UgNPR+MBDBj3weR09ZAT9NPx
        y/0u1N9cFtxYk1xvOVEzCw==
X-Received: by 10.98.200.206 with SMTP id i75mr13307546pfk.163.1496965284758;
        Thu, 08 Jun 2017 16:41:24 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:23 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 07/32] repository: introduce the repository object
Date:   Thu,  8 Jun 2017 16:40:35 -0700
Message-Id: <20170608234100.188529-8-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the repository object 'struct repository' which can be used to
hold all state pertaining to a git repository.

Some of the benefits of object-ifying a repository are:

  1. Make the code base more readable and easier to reason about.

  2. Allow for working on multiple repositories, specifically
     submodules, within the same process.  Currently the process for
     working on a submodule involves setting up an argv_array of options
     for a particular command and then launching a child process to
     execute the command in the context of the submodule.  This is
     clunky and can require lots of little hacks in order to ensure
     correctness.  Ideally it would be nice to simply pass a repository
     and an options struct to a command.

  3. Eliminating reliance on global state will make it easier to
     enable the use of threading to improve performance.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Makefile      |   1 +
 cache.h       |   1 +
 environment.c |   2 +-
 repository.c  | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 repository.h  |  25 +++++++++
 5 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 repository.c
 create mode 100644 repository.h

diff --git a/Makefile b/Makefile
index 2ed6db728..ac82d93f6 100644
--- a/Makefile
+++ b/Makefile
@@ -821,6 +821,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
+LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
diff --git a/cache.h b/cache.h
index d41aab82f..c0b4c8d83 100644
--- a/cache.h
+++ b/cache.h
@@ -483,6 +483,7 @@ extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
 extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 extern int get_common_dir(struct strbuf *sb, const char *gitdir);
+extern char *expand_namespace(const char *raw_namespace);
 extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_super_prefix(void);
diff --git a/environment.c b/environment.c
index e035f6372..77900b31a 100644
--- a/environment.c
+++ b/environment.c
@@ -127,7 +127,7 @@ const char * const local_repo_env[] = {
 	NULL
 };
 
-static char *expand_namespace(const char *raw_namespace)
+char *expand_namespace(const char *raw_namespace)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf **components, **c;
diff --git a/repository.c b/repository.c
new file mode 100644
index 000000000..e952238d1
--- /dev/null
+++ b/repository.c
@@ -0,0 +1,171 @@
+#include "cache.h"
+#include "repository.h"
+
+/* The main repository */
+static struct repository the_repo;
+struct repository *the_repository = &the_repo;
+
+static char *git_path_from_env(const char *envvar, const char *git_dir,
+			       const char *path, int fromenv)
+{
+	if (fromenv) {
+		const char *value = getenv(envvar);
+		if (value)
+			return xstrdup(value);
+	}
+
+	return xstrfmt("%s/%s", git_dir, path);
+}
+
+static int find_common_dir(struct strbuf *sb, const char *gitdir, int fromenv)
+{
+	if (fromenv) {
+		const char *value = getenv(GIT_COMMON_DIR_ENVIRONMENT);
+		if (value) {
+			strbuf_addstr(sb, value);
+			return 1;
+		}
+	}
+
+	return get_common_dir_noenv(sb, gitdir);
+}
+
+/* called after setting gitdir */
+static void repo_setup_env(struct repository *repo)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!repo->gitdir)
+		BUG("gitdir wasn't set before setting up the environment");
+
+	repo->different_commondir = find_common_dir(&sb, repo->gitdir,
+						    !repo->ignore_env);
+	repo->commondir = strbuf_detach(&sb, NULL);
+	repo->objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
+					    "objects", !repo->ignore_env);
+	repo->index_file = git_path_from_env(INDEX_ENVIRONMENT, repo->gitdir,
+					     "index", !repo->ignore_env);
+	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
+					     "info/grafts", !repo->ignore_env);
+	repo->namespace = expand_namespace(repo->ignore_env ? NULL :
+					   getenv(GIT_NAMESPACE_ENVIRONMENT));
+}
+
+void repo_set_gitdir(struct repository *repo, const char *path)
+{
+	const char *gitfile = read_gitfile(path);
+
+	/*
+	 * NEEDSWORK: Eventually we want to be able to free gitdir and the rest
+	 * of the environment before reinitializing it again, but we have some
+	 * crazy code paths where we try to set gitdir with the current gitdir
+	 * and we don't want to free gitdir before copying the passed in value.
+	 */
+	repo->gitdir = xstrdup(gitfile ? gitfile : path);
+
+	repo_setup_env(repo);
+}
+
+/*
+ * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
+ * Return 0 upon success and a non-zero value upon failure.
+ */
+static int repo_init_gitdir(struct repository *repo, const char *gitdir)
+{
+	int ret = 0;
+	int error = 0;
+	char *abspath = NULL;
+	char *suspect = NULL;
+	const char *resolved_gitdir;
+
+	abspath = real_pathdup(gitdir, 0);
+	if (!abspath) {
+		ret = -1;
+		goto out;
+	}
+
+	/* First assume 'gitdir' references the gitdir directly */
+	resolved_gitdir = resolve_gitdir_gently(abspath, &error);
+	/* otherwise; try 'gitdir'.git */
+	if (!resolved_gitdir) {
+		suspect = xstrfmt("%s/.git", abspath);
+		resolved_gitdir = resolve_gitdir_gently(suspect, &error);
+		if (!resolved_gitdir) {
+			ret = -1;
+			goto out;
+		}
+	}
+
+	repo_set_gitdir(repo, resolved_gitdir);
+
+out:
+	free(abspath);
+	free(suspect);
+	return ret;
+}
+
+static int verify_repo_format(struct repository_format *format,
+			      const char *commondir)
+{
+	int ret = 0;
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addf(&sb, "%s/config", commondir);
+	read_repository_format(format, sb.buf);
+	strbuf_reset(&sb);
+
+	if (verify_repository_format(format, &sb) < 0) {
+		warning("%s", sb.buf);
+		ret = -1;
+	}
+
+	strbuf_release(&sb);
+	return ret;
+}
+
+/*
+ * Initialize 'repo' based on the provided 'gitdir'.
+ * Return 0 upon success and a non-zero value upon failure.
+ */
+int repo_init(struct repository *repo, const char *gitdir)
+{
+	struct repository_format format;
+	memset(repo, 0, sizeof(*repo));
+
+	repo->ignore_env = 1;
+
+	if (repo_init_gitdir(repo, gitdir))
+		goto error;
+
+	if (verify_repo_format(&format, repo->commondir))
+		goto error;
+
+	return 0;
+
+error:
+	repo_clear(repo);
+	return -1;
+}
+
+static void repo_clear_env(struct repository *repo)
+{
+	free(repo->gitdir);
+	repo->gitdir = NULL;
+	free(repo->commondir);
+	repo->commondir = NULL;
+	free(repo->objectdir);
+	repo->objectdir = NULL;
+	free(repo->index_file);
+	repo->index_file = NULL;
+	free(repo->graft_file);
+	repo->graft_file = NULL;
+	free(repo->namespace);
+	repo->namespace = NULL;
+}
+
+void repo_clear(struct repository *repo)
+{
+	repo_clear_env(repo);
+
+	memset(repo, 0, sizeof(*repo));
+}
diff --git a/repository.h b/repository.h
new file mode 100644
index 000000000..174ab0f2d
--- /dev/null
+++ b/repository.h
@@ -0,0 +1,25 @@
+#ifndef REPOSITORY_H
+#define REPOSITORY_H
+
+struct repository {
+	/* Environment */
+	char *gitdir;
+	char *commondir;
+	char *objectdir;
+	char *index_file;
+	char *graft_file;
+	char *namespace;
+
+	/* Configurations */
+	unsigned ignore_env:1;
+	/* Indicates if a repository has a different 'commondir' from 'gitdir' */
+	unsigned different_commondir:1;
+};
+
+extern struct repository *the_repository;
+
+extern void repo_set_gitdir(struct repository *repo, const char *path);
+extern int repo_init(struct repository *repo, const char *path);
+extern void repo_clear(struct repository *repo);
+
+#endif /* REPOSITORY_H */
-- 
2.13.1.508.gb3defc5cc-goog

