Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1BDF20D1E
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbdFTTUg (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:36 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34615 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbdFTTU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:28 -0400
Received: by mail-pf0-f169.google.com with SMTP id s66so73668218pfs.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U3/c5lCNowrNfcX+mC9PKAdt1qI46OEnBznZgFfB6UY=;
        b=L85PAmWef/G3Ir5F9ThLWhZF8e7eCF/+tTrLCitRQzKLwvCA8uLh/W9SlBePUUzJnF
         Aww35QYnPB+PEjtHL3BSUpuceI1rA2YrfO8EXJ6AtvJvmgEKNL/2hZiQVp7NZD1wifUl
         gT/zFP5zuJRBKF1QCBTMtEomPXOR7e6z0vWOBRFvxtEAm8A/hUns4xIwQeKL9ZAUpW5g
         qGV/eg0frGALLH9fTeeS86VY7esat+he9DPlhONd4UGAw64BW7ZQmNOPf5wHTgj3ubI3
         KQgyZ0WqaH03rFjsRq1cnAH5hFXrWxixkHC1qkL0bdicg2O+VNS/lLOrLv4/4k4RdK5u
         gvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U3/c5lCNowrNfcX+mC9PKAdt1qI46OEnBznZgFfB6UY=;
        b=ganygfErGOhJ2Fiph3pxjsDzSisRJpk3bbr3/kAq+17kNTC0le4x/QEzpqnYLaQpRF
         iZBtuks1rRfKjVU/enPKJNKUN1yIDsZ5oLwueGuXsMSoc9SNxmAXT1pgMdzDK05QKrJ0
         Hy5/vgM0W3ByxvjMBT3sbnLgDA9g8iNiZCzNAjXHg5DhMpqzEIenOo0A3a8jigOi37XX
         AEcdXRETDh6SYY08oxlgJiUCymtKi8rmcRx1cBAIwOjqzYzUwI3A4WflWW9wiiTQa4wb
         8NrgHEfWAbjzGMUAhOsBAILMmPjwCXSIEy/BaHtk3KalLMGm6X28qxUIGJNz6E1UzAef
         xyuQ==
X-Gm-Message-State: AKS2vOxrSYupRYT70X1LI0WPr4rWx5Sr0HcSGa1mdhPvwS4LHnYbxQLP
        w1vBKvLtfRWvu93qJ2/zcQ==
X-Received: by 10.98.78.70 with SMTP id c67mr32071216pfb.155.1497986417019;
        Tue, 20 Jun 2017 12:20:17 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 04/20] repository: introduce the repository object
Date:   Tue, 20 Jun 2017 12:19:35 -0700
Message-Id: <20170620191951.84791-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
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
 Makefile     |   1 +
 repository.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 repository.h |  46 ++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 repository.c
 create mode 100644 repository.h

diff --git a/Makefile b/Makefile
index f48480163..32e4efc71 100644
--- a/Makefile
+++ b/Makefile
@@ -839,6 +839,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
+LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
diff --git a/repository.c b/repository.c
new file mode 100644
index 000000000..7c8a7728c
--- /dev/null
+++ b/repository.c
@@ -0,0 +1,172 @@
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
+	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
+					     "info/grafts", !repo->ignore_env);
+	repo->index_file = git_path_from_env(INDEX_ENVIRONMENT, repo->gitdir,
+					     "index", !repo->ignore_env);
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
+void repo_set_worktree(struct repository *repo, const char *path)
+{
+	repo->worktree = real_pathdup(path, 1);
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
+int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
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
+	if (worktree)
+		repo_set_worktree(repo, worktree);
+
+	return 0;
+
+error:
+	repo_clear(repo);
+	return -1;
+}
+
+void repo_clear(struct repository *repo)
+{
+	free(repo->gitdir);
+	repo->gitdir = NULL;
+	free(repo->commondir);
+	repo->commondir = NULL;
+	free(repo->objectdir);
+	repo->objectdir = NULL;
+	free(repo->graft_file);
+	repo->graft_file = NULL;
+	free(repo->index_file);
+	repo->index_file = NULL;
+	free(repo->worktree);
+	repo->worktree = NULL;
+
+	memset(repo, 0, sizeof(*repo));
+}
diff --git a/repository.h b/repository.h
new file mode 100644
index 000000000..ab1744d51
--- /dev/null
+++ b/repository.h
@@ -0,0 +1,46 @@
+#ifndef REPOSITORY_H
+#define REPOSITORY_H
+
+struct repository {
+	/* Environment */
+	/* Path to the git directory */
+	char *gitdir;
+
+	/* Path to the common git directory */
+	char *commondir;
+
+	/* Path to the repository's object store */
+	char *objectdir;
+
+	/* Path to the repository's graft file */
+	char *graft_file;
+
+	/* Path to the current worktree's index file */
+	char *index_file;
+
+	/* Path to the working directory */
+	char *worktree;
+
+	/* Configurations */
+	/*
+	 * Bit used during initialization to indicate if repository state (like
+	 * the location of the 'objectdir') should be read from the
+	 * environment.  By default this bit will be set at the begining of
+	 * 'repo_init()' so that all repositories will ignore the environment.
+	 * The exception to this is 'the_repository', which doesn't go through
+	 * the normal 'repo_init()' process.
+	 */
+	unsigned ignore_env:1;
+
+	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
+	unsigned different_commondir:1;
+};
+
+extern struct repository *the_repository;
+
+extern void repo_set_gitdir(struct repository *repo, const char *path);
+extern void repo_set_worktree(struct repository *repo, const char *path);
+extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
+extern void repo_clear(struct repository *repo);
+
+#endif /* REPOSITORY_H */
-- 
2.13.1.611.g7e3b11ae1-goog

