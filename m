Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7E620D27
	for <e@80x24.org>; Tue, 20 Jun 2017 19:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbdFTTVO (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:21:14 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34189 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFTTUf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:35 -0400
Received: by mail-pg0-f53.google.com with SMTP id e187so14379368pgc.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m/rgsTK8nlrr/+cwfZjUNwyfuFrUFrEHF0uiI7DIJVM=;
        b=Rl6ZTh4ArSIUiXGDIsxnTJiW7secRCuSJYWzIyQgdYTljc5S9EIOvdl/sTx4v6BoO4
         IygjKvxis0nuOq6LP6/cYatVcSLNx32+HKBhL1JUKXarGXttFNF1zwZSv1eJqP3uww0e
         WdsYm3OztrzH4KmVS6H7QWPbJlOHYMGmOfyIy234hcloq5k4KsGclHPm17N9+0VJ6CbJ
         dyUh6tRVfhSF7wVFpl8bPxsOBDpfEVggKYDWf7zlAJ7JW2YK5C3ds2sDaqtBYUeA0kds
         5HujXJothly6DJLiaCpfKyEHwS+QbuZLkmODGkYCLhVvg6xtlrQQuGXu2bfrppXICNar
         o5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m/rgsTK8nlrr/+cwfZjUNwyfuFrUFrEHF0uiI7DIJVM=;
        b=IDxNizQcYA9YQvxlCJjeLMOrOmWeY0RdqZYB0n57n2CA4q9ahrmK5t9pnAwO7SEhry
         iK/AFeidCzUe2Zcz8EfBKFuGHUgnCPN6ELrI4BQDekXLLxxSwSCa3lOx6HD6TG6fmWFD
         jvRKw4k2K9P0lZt+v3vqRaWPVt+d97ItIQUTxs91j1aSiVkPXm21iU3ch4pIbjca8dnI
         rhJucPJd45JJ1pWfyqrYQ0N+5OAboHJb0C4JloEtjT1YdLYS4FY+KYtzmaeVZIb1VMni
         Rk2e+aurAwXFekByTB5hkzdyt653Jsi3S6ybTjEbe6cotfTJvFqBvq3bYO1X61iW6xmk
         KdAA==
X-Gm-Message-State: AKS2vOyw1CG0Q4K/rOQcK5Qg6SfUv2k6DVRdrmmcIPn5rjuPifLefnL+
        4OXRkSeNWyplG6bWEJ1+vQ==
X-Received: by 10.84.192.3 with SMTP id b3mr37738289pld.76.1497986434104;
        Tue, 20 Jun 2017 12:20:34 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:33 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 14/20] config: read config from a repository object
Date:   Tue, 20 Jun 2017 12:19:45 -0700
Message-Id: <20170620191951.84791-15-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the config machinery to read config information from a repository
object.  This involves storing a 'struct config_set' inside the
repository object and adding a number of functions (repo_config*) to be
able to query a repository's config.

The current config API enables lazy-loading of the config.  This means
that when 'git_config_get_int()' is called, if the_config_set hasn't
been populated yet, then it will be populated and properly initialized by
reading the necessary config files (system wide .gitconfig, user's home
.gitconfig, and the repository's config).  To maintain this paradigm,
the new API to read from a repository object's config will also perform
this lazy-initialization.

Since both APIs (git_config_get* and repo_config_get*) have the same
semantics we can migrate the default config to be stored within
'the_repository' and just have the 'git_config_get*' family of functions
redirect to the 'repo_config_get*' functions.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 config.c     | 216 +++++++++++++++++++++++++++++++++++++++--------------------
 config.h     |  24 +++++++
 repository.c |   7 ++
 repository.h |  10 +++
 4 files changed, 183 insertions(+), 74 deletions(-)

diff --git a/config.c b/config.c
index 6f0f8b30f..be1c640a4 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "repository.h"
 #include "lockfile.h"
 #include "exec_cmd.h"
 #include "strbuf.h"
@@ -72,13 +73,6 @@ static int core_compression_seen;
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
-/*
- * Default config_set that contains key-value pairs from the usual set of config
- * config files (i.e repo specific .git/config, user wide ~/.gitconfig, XDG
- * config file and the global /etc/gitconfig)
- */
-static struct config_set the_config_set;
-
 static int config_file_fgetc(struct config_source *conf)
 {
 	return getc_unlocked(conf->u.file);
@@ -1605,31 +1599,6 @@ int config_with_options(config_fn_t fn, void *data,
 	return do_git_config_sequence(opts, fn, data);
 }
 
-static void git_config_raw(config_fn_t fn, void *data)
-{
-	struct config_options opts = {0};
-
-	opts.respect_includes = 1;
-	if (have_git_dir()) {
-		opts.commondir = get_git_common_dir();
-		opts.git_dir = get_git_dir();
-	}
-
-	if (config_with_options(fn, data, NULL, &opts) < 0)
-		/*
-		 * config_with_options() normally returns only
-		 * zero, as most errors are fatal, and
-		 * non-fatal potential errors are guarded by "if"
-		 * statements that are entered only when no error is
-		 * possible.
-		 *
-		 * If we ever encounter a non-fatal error, it means
-		 * something went really wrong and we should stop
-		 * immediately.
-		 */
-		die(_("unknown error occurred while reading the configuration files"));
-}
-
 static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 {
 	int i, value_index;
@@ -1683,14 +1652,6 @@ void read_early_config(config_fn_t cb, void *data)
 	strbuf_release(&gitdir);
 }
 
-static void git_config_check_init(void);
-
-void git_config(config_fn_t fn, void *data)
-{
-	git_config_check_init();
-	configset_iter(&the_config_set, fn, data);
-}
-
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
 {
 	struct config_set_element k;
@@ -1900,87 +1861,194 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 		return 1;
 }
 
-static void git_config_check_init(void)
+/* Functions use to read configuration from a repository */
+static void repo_read_config(struct repository *repo)
 {
-	if (the_config_set.hash_initialized)
+	struct config_options opts;
+
+	opts.respect_includes = 1;
+	opts.commondir = repo->commondir;
+	opts.git_dir = repo->gitdir;
+
+	if (!repo->config)
+		repo->config = xcalloc(1, sizeof(struct config_set));
+	else
+		git_configset_clear(repo->config);
+
+	git_configset_init(repo->config);
+
+	if (config_with_options(config_set_callback, repo->config, NULL, &opts) < 0)
+		/*
+		 * config_with_options() normally returns only
+		 * zero, as most errors are fatal, and
+		 * non-fatal potential errors are guarded by "if"
+		 * statements that are entered only when no error is
+		 * possible.
+		 *
+		 * If we ever encounter a non-fatal error, it means
+		 * something went really wrong and we should stop
+		 * immediately.
+		 */
+		die(_("unknown error occurred while reading the configuration files"));
+}
+
+static void git_config_check_init(struct repository *repo)
+{
+	if (repo->config && repo->config->hash_initialized)
 		return;
-	git_configset_init(&the_config_set);
-	git_config_raw(config_set_callback, &the_config_set);
+	repo_read_config(repo);
 }
 
-void git_config_clear(void)
+static void repo_config_clear(struct repository *repo)
 {
-	if (!the_config_set.hash_initialized)
+	if (!repo->config || !repo->config->hash_initialized)
 		return;
-	git_configset_clear(&the_config_set);
+	git_configset_clear(repo->config);
 }
 
-int git_config_get_value(const char *key, const char **value)
+void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
-	git_config_check_init();
-	return git_configset_get_value(&the_config_set, key, value);
+	git_config_check_init(repo);
+	configset_iter(repo->config, fn, data);
 }
 
-const struct string_list *git_config_get_value_multi(const char *key)
+int repo_config_get_value(struct repository *repo,
+			  const char *key, const char **value)
 {
-	git_config_check_init();
-	return git_configset_get_value_multi(&the_config_set, key);
+	git_config_check_init(repo);
+	return git_configset_get_value(repo->config, key, value);
 }
 
-int git_config_get_string_const(const char *key, const char **dest)
+const struct string_list *repo_config_get_value_multi(struct repository *repo,
+						      const char *key)
+{
+	git_config_check_init(repo);
+	return git_configset_get_value_multi(repo->config, key);
+}
+
+int repo_config_get_string_const(struct repository *repo,
+				 const char *key, const char **dest)
+{
+	int ret;
+	git_config_check_init(repo);
+	ret = git_configset_get_string_const(repo->config, key, dest);
+	if (ret < 0)
+		git_die_config(key, NULL);
+	return ret;
+}
+
+int repo_config_get_string(struct repository *repo,
+			   const char *key, char **dest)
+{
+	git_config_check_init(repo);
+	return repo_config_get_string_const(repo, key, (const char **)dest);
+}
+
+int repo_config_get_int(struct repository *repo,
+			const char *key, int *dest)
+{
+	git_config_check_init(repo);
+	return git_configset_get_int(repo->config, key, dest);
+}
+
+int repo_config_get_ulong(struct repository *repo,
+			  const char *key, unsigned long *dest)
+{
+	git_config_check_init(repo);
+	return git_configset_get_ulong(repo->config, key, dest);
+}
+
+int repo_config_get_bool(struct repository *repo,
+			 const char *key, int *dest)
+{
+	git_config_check_init(repo);
+	return git_configset_get_bool(repo->config, key, dest);
+}
+
+int repo_config_get_bool_or_int(struct repository *repo,
+				const char *key, int *is_bool, int *dest)
+{
+	git_config_check_init(repo);
+	return git_configset_get_bool_or_int(repo->config, key, is_bool, dest);
+}
+
+int repo_config_get_maybe_bool(struct repository *repo,
+			       const char *key, int *dest)
+{
+	git_config_check_init(repo);
+	return git_configset_get_maybe_bool(repo->config, key, dest);
+}
+
+int repo_config_get_pathname(struct repository *repo,
+			     const char *key, const char **dest)
 {
 	int ret;
-	git_config_check_init();
-	ret = git_configset_get_string_const(&the_config_set, key, dest);
+	git_config_check_init(repo);
+	ret = git_configset_get_pathname(repo->config, key, dest);
 	if (ret < 0)
 		git_die_config(key, NULL);
 	return ret;
 }
 
+/* Functions used historically to read configuration from 'the_repository' */
+void git_config(config_fn_t fn, void *data)
+{
+	repo_config(the_repository, fn, data);
+}
+
+void git_config_clear(void)
+{
+	repo_config_clear(the_repository);
+}
+
+int git_config_get_value(const char *key, const char **value)
+{
+	return repo_config_get_value(the_repository, key, value);
+}
+
+const struct string_list *git_config_get_value_multi(const char *key)
+{
+	return repo_config_get_value_multi(the_repository, key);
+}
+
+int git_config_get_string_const(const char *key, const char **dest)
+{
+	return repo_config_get_string_const(the_repository, key, dest);
+}
+
 int git_config_get_string(const char *key, char **dest)
 {
-	git_config_check_init();
-	return git_config_get_string_const(key, (const char **)dest);
+	return repo_config_get_string(the_repository, key, dest);
 }
 
 int git_config_get_int(const char *key, int *dest)
 {
-	git_config_check_init();
-	return git_configset_get_int(&the_config_set, key, dest);
+	return repo_config_get_int(the_repository, key, dest);
 }
 
 int git_config_get_ulong(const char *key, unsigned long *dest)
 {
-	git_config_check_init();
-	return git_configset_get_ulong(&the_config_set, key, dest);
+	return repo_config_get_ulong(the_repository, key, dest);
 }
 
 int git_config_get_bool(const char *key, int *dest)
 {
-	git_config_check_init();
-	return git_configset_get_bool(&the_config_set, key, dest);
+	return repo_config_get_bool(the_repository, key, dest);
 }
 
 int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)
 {
-	git_config_check_init();
-	return git_configset_get_bool_or_int(&the_config_set, key, is_bool, dest);
+	return repo_config_get_bool_or_int(the_repository, key, is_bool, dest);
 }
 
 int git_config_get_maybe_bool(const char *key, int *dest)
 {
-	git_config_check_init();
-	return git_configset_get_maybe_bool(&the_config_set, key, dest);
+	return repo_config_get_maybe_bool(the_repository, key, dest);
 }
 
 int git_config_get_pathname(const char *key, const char **dest)
 {
-	int ret;
-	git_config_check_init();
-	ret = git_configset_get_pathname(&the_config_set, key, dest);
-	if (ret < 0)
-		git_die_config(key, NULL);
-	return ret;
+	return repo_config_get_pathname(the_repository, key, dest);
 }
 
 int git_config_get_expiry(const char *key, const char **output)
diff --git a/config.h b/config.h
index 9e038cce2..0352da117 100644
--- a/config.h
+++ b/config.h
@@ -163,6 +163,30 @@ extern int git_configset_get_bool_or_int(struct config_set *cs, const char *key,
 extern int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
 extern int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest);
 
+/* Functions for reading a repository's config */
+struct repository;
+extern void repo_config(struct repository *repo, config_fn_t fn, void *data);
+extern int repo_config_get_value(struct repository *repo,
+				 const char *key, const char **value);
+extern const struct string_list *repo_config_get_value_multi(struct repository *repo,
+							     const char *key);
+extern int repo_config_get_string_const(struct repository *repo,
+					const char *key, const char **dest);
+extern int repo_config_get_string(struct repository *repo,
+				  const char *key, char **dest);
+extern int repo_config_get_int(struct repository *repo,
+			       const char *key, int *dest);
+extern int repo_config_get_ulong(struct repository *repo,
+				 const char *key, unsigned long *dest);
+extern int repo_config_get_bool(struct repository *repo,
+				const char *key, int *dest);
+extern int repo_config_get_bool_or_int(struct repository *repo,
+				       const char *key, int *is_bool, int *dest);
+extern int repo_config_get_maybe_bool(struct repository *repo,
+				      const char *key, int *dest);
+extern int repo_config_get_pathname(struct repository *repo,
+				    const char *key, const char **dest);
+
 extern int git_config_get_value(const char *key, const char **value);
 extern const struct string_list *git_config_get_value_multi(const char *key);
 extern void git_config_clear(void);
diff --git a/repository.c b/repository.c
index 7c8a7728c..3dcfec3b8 100644
--- a/repository.c
+++ b/repository.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "repository.h"
+#include "config.h"
 
 /* The main repository */
 static struct repository the_repo;
@@ -168,5 +169,11 @@ void repo_clear(struct repository *repo)
 	free(repo->worktree);
 	repo->worktree = NULL;
 
+	if (repo->config) {
+		git_configset_clear(repo->config);
+		free(repo->config);
+		repo->config = NULL;
+	}
+
 	memset(repo, 0, sizeof(*repo));
 }
diff --git a/repository.h b/repository.h
index ab1744d51..379b64170 100644
--- a/repository.h
+++ b/repository.h
@@ -1,6 +1,8 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
 
+struct config_set;
+
 struct repository {
 	/* Environment */
 	/* Path to the git directory */
@@ -21,6 +23,14 @@ struct repository {
 	/* Path to the working directory */
 	char *worktree;
 
+	/* Subsystems */
+	/*
+	 * Repository's config which contains key-value pairs from the usual
+	 * set of config files (i.e. repo specific .git/config, user wide
+	 * ~/.gitconfig, XDG config file and the global /etc/gitconfig)
+	 */
+	struct config_set *config;
+
 	/* Configurations */
 	/*
 	 * Bit used during initialization to indicate if repository state (like
-- 
2.13.1.611.g7e3b11ae1-goog

