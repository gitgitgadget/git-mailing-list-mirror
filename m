Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C45921FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbdEaVoo (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:44:44 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34243 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdEaVom (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:44:42 -0400
Received: by mail-pf0-f175.google.com with SMTP id 9so18578134pfj.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W8PvEcQsa6KgK7j0Dklv6kxN6AYA5BrKHb1woLMWP7s=;
        b=j/CvDT/iXovfilzQNlna3SOq1+mrMI/pOqzGukMiqNW1uw7RsD6bl+farOwotisMw/
         hz+C9uA7dRgl8uInjNiKZJ78NxGOCfSAsofHRgBIKg77QFVyEMLxeCYDXEZMoT5WMNgE
         c9HyfuOL0B/hnPnG5qCkZHyz4Aa2bnSpoQV1xHG4hcE9DN9Z7PQ8ZXkh94RxkOvT7Cks
         EL9dK5MYYAFZ7TJp7QKMH/501596xy3XVSwL7hFuFjlAbw9bqwTZ6ryQ4AsTWz0Ysagc
         OuCVyoFFDtCkK4pNcCPb8+WF52VjxRJhKjycfq5+Db56XKRfpG36pu0mPp3G96S0Qnkh
         5Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W8PvEcQsa6KgK7j0Dklv6kxN6AYA5BrKHb1woLMWP7s=;
        b=EysUsdbLAY49fg7VO4aBYfvrFJ5dIZFARM3Iy4gLJa6fXSL0k9D6NOcz9+V/0uury7
         quRakYpk3nGaKSl2hirNiPnSkt8K8wJcE/gpARTS/+GfxH7MnHkd0gnc7qUgZdsZ3c0m
         p3ZLK2tYUzdk+fA9vc7a5OtLFnQFZXjVvQk58JT/1xCp/bRuL0uKMB7/tNzli+7O7x7d
         Tv1FGX6e09OcvGic7h1jsX2pkJh0rD67vkbxivfKE/UoysluTzJMpbi8qYk/GV9z6FLg
         l6xkExd9lFYXXXUjvs3S2YVcIgKjYUU640hnBS3kFOA4A/URQ2oAAAID6WA1H47U2Nbs
         inJg==
X-Gm-Message-State: AODbwcBFRSMYRgHjz/0shox1ZkRsN33Hyanvt9UmLG+BLK9fCv2jfT+T
        T1CXZ28ssr/kA5Vf
X-Received: by 10.84.132.98 with SMTP id 89mr91707855ple.29.1496267081286;
        Wed, 31 May 2017 14:44:41 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:40 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 06/31] repo: introduce the repository object
Date:   Wed, 31 May 2017 14:43:52 -0700
Message-Id: <20170531214417.38857-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the repository object 'struct repo' which can be used hold all
state pertaining to a git repository.

The aim of object-ifying the repository is to (1) make the code base
more readable and easier to reason about and (2) allow for working on
multiple repositories, specifically submodules, within the same process.

TODO: Add more motivating points for adding a repository object?

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Makefile      |   1 +
 cache.h       |   1 +
 environment.c |   2 +-
 repo.c        | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 repo.h        |  25 ++++++++++++
 5 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 repo.c
 create mode 100644 repo.h

diff --git a/Makefile b/Makefile
index 2ed6db728..3d3d556ef 100644
--- a/Makefile
+++ b/Makefile
@@ -821,6 +821,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
+LIB_OBJS += repo.o
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
diff --git a/repo.c b/repo.c
new file mode 100644
index 000000000..f7c3617a9
--- /dev/null
+++ b/repo.c
@@ -0,0 +1,124 @@
+#include "cache.h"
+#include "repo.h"
+
+/*
+ * This may be the wrong place for this.
+ * It may be better to go in env.c or setup for the time being?
+ */
+struct repo the_repository;
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
+static void repo_setup_env(struct repo *repo)
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
+static void repo_clear_env(struct repo *repo)
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
+void repo_set_gitdir(struct repo *repo, const char *path)
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
+int repo_init(struct repo *repo, const char *gitdir)
+{
+	int error = 0;
+	char *abspath = real_pathdup(gitdir, 1);
+	char *suspect = xstrfmt("%s/.git", abspath);
+	struct strbuf sb = STRBUF_INIT;
+	const char *resolved_gitdir;
+
+	memset(repo, 0, sizeof(struct repo));
+
+	repo->ignore_env = 1;
+
+	/* First assume 'gitdir' references the gitdir directly */
+	resolved_gitdir = resolve_gitdir_gently(abspath, &error);
+	/* otherwise; try 'gitdir'.git */
+	if (!resolved_gitdir) {
+		resolved_gitdir = resolve_gitdir_gently(suspect, &error);
+		if (!resolved_gitdir) {
+			die("'%s' is not a repository\n", abspath);
+			return error;
+		}
+	}
+
+	repo_set_gitdir(repo, resolved_gitdir);
+
+	/* NEEDSWORK: Verify repository format version */
+
+	free(abspath);
+	free(suspect);
+	strbuf_release(&sb);
+
+	return error;
+}
+
+void repo_clear(struct repo *repo)
+{
+	repo_clear_env(repo);
+}
diff --git a/repo.h b/repo.h
new file mode 100644
index 000000000..453049e67
--- /dev/null
+++ b/repo.h
@@ -0,0 +1,25 @@
+#ifndef REPO_H
+#define REPO_H
+
+struct repo {
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
+extern struct repo the_repository;
+
+extern void repo_set_gitdir(struct repo *repo, const char *path);
+extern int repo_init(struct repo *repo, const char *path);
+extern void repo_clear(struct repo *repo);
+
+#endif /* REPO_H */
-- 
2.13.0.506.g27d5fe0cd-goog

