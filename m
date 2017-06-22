Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E275B1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753564AbdFVSoK (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:10 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35724 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdFVSoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:09 -0400
Received: by mail-pg0-f46.google.com with SMTP id 132so11348815pgb.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5viClup0j+33slrGNUc5PrUokfLcYtwmm/yxZUT7h+E=;
        b=Fgj9D9EQ50OIGPtGx08HiyzlV1VKPW2jrFwvzn8QhmY+wNdMTxi9ozGi6gL73jgpkP
         yjRjubFN6Z1J/IgUzU3a2KYoUP2i08DgtfBB6ybHiRhloPMGArHHp7OS1z26qxMqMeOL
         25NNUf+1nOVRRQ/4kai+wfS24rnaBZa77q4K6WZcVY5Ut1rs0LcH5HOb3SG0q+VJ7+IB
         8dRpvN3z1ttEPwar/yXiOxMjSugV9m92WFCp66C8BNU8Tz0JSLdOJlz15L87cn5y0mzV
         b9AtRV0iw3WZc2Yvl4XyaeCgFm7btF/qgAQ6fA9G5eFQiUxUdok9/6bT/Gq2lDxvbkJe
         GxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5viClup0j+33slrGNUc5PrUokfLcYtwmm/yxZUT7h+E=;
        b=dkHW50UH9SBjP4EKAN/zpOXIX4rU1tComCI1OPsPmHhAjUn2LvYqePFrmK1RCVYuDA
         wwMnsYfCwduUmf71FEbWpWx4TIHRv2syWwkIpyLQn5KsXCVPWpldDrADXrxtPOU0tlDp
         DzWr4Q5uUtM7W5LBZwd2Hlb0u1qklA4sN6z6jt8h12NJRvORMlw0eor5G/T8XQnd6FJB
         LEe7ZscW0hssMIC8PwarA0n1Wzr8epx+78v/rsLMXsIn9IZK17ICHvl2mnO0fMW33D7S
         5hhre2qswcPN0FMOu7yuSXdtOqKGWzHST6h/GRKCN1PhqZ+wgkgBBVlj5bk0rDTRFwN1
         +YMA==
X-Gm-Message-State: AKS2vOxI/zGxpVntCkPdKbnmhFYiatuwkvoS/hHdK91DDvX4ZHxXjPtC
        09sTVcyJ5PeQgZrj9cnOXA==
X-Received: by 10.84.129.97 with SMTP id 88mr4589401plb.111.1498157047776;
        Thu, 22 Jun 2017 11:44:07 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:06 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 04/20] repository: introduce the repository object
Date:   Thu, 22 Jun 2017 11:43:32 -0700
Message-Id: <20170622184348.56497-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
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
 repository.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 repository.h |  64 ++++++++++++++++++++++++
 3 files changed, 224 insertions(+)
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
index 000000000..cf440405a
--- /dev/null
+++ b/repository.c
@@ -0,0 +1,159 @@
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
+static void repo_setup_env(struct repository *repo)
+{
+	struct strbuf sb = STRBUF_INIT;
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
+	const char *resolved_gitdir;
+
+	abspath = real_pathdup(gitdir, 0);
+	if (!abspath) {
+		ret = -1;
+		goto out;
+	}
+
+	/* 'gitdir' must reference the gitdir directly */
+	resolved_gitdir = resolve_gitdir_gently(abspath, &error);
+	if (!resolved_gitdir) {
+		ret = -1;
+		goto out;
+	}
+
+	repo_set_gitdir(repo, resolved_gitdir);
+
+out:
+	free(abspath);
+	return ret;
+}
+
+void repo_set_worktree(struct repository *repo, const char *path)
+{
+	repo->worktree = real_pathdup(path, 1);
+}
+
+static int read_and_verify_repository_format(struct repository_format *format,
+					     const char *commondir)
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
+	if (read_and_verify_repository_format(&format, repo->commondir))
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
+}
diff --git a/repository.h b/repository.h
new file mode 100644
index 000000000..0a1db9633
--- /dev/null
+++ b/repository.h
@@ -0,0 +1,64 @@
+#ifndef REPOSITORY_H
+#define REPOSITORY_H
+
+struct repository {
+	/* Environment */
+	/*
+	 * Path to the git directory.
+	 * Cannot be NULL after initialization.
+	 */
+	char *gitdir;
+
+	/*
+	 * Path to the common git directory.
+	 * Cannot be NULL after initialization.
+	 */
+	char *commondir;
+
+	/*
+	 * Path to the repository's object store.
+	 * Cannot be NULL after initialization.
+	 */
+	char *objectdir;
+
+	/*
+	 * Path to the repository's graft file.
+	 * Cannot be NULL after initialization.
+	 */
+	char *graft_file;
+
+	/*
+	 * Path to the current worktree's index file.
+	 * Cannot be NULL after initialization.
+	 */
+	char *index_file;
+
+	/*
+	 * Path to the working directory.
+	 * A NULL value indicates that there is no working directory.
+	 */
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
2.13.1.704.gde00cce3c-goog

