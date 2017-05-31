Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961641FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbdEaVqI (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:46:08 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35184 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdEaVot (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:44:49 -0400
Received: by mail-pf0-f173.google.com with SMTP id n23so18560795pfb.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Begk0szVfsIK0MNleiufllaCD+/oPEPI5QF8Mpo7rp0=;
        b=GJJGOSBIRt5ofO90CdcOxPIXtRpSfxQljPaRBr5j7AtBpDh1d2p4tIbpA7a+z3W6Aw
         rhMomTF8tgLVIlvZ59eJUvQCebpKfCkAfGgyR4RSna0zfY684gQCoZ9wSiRLFyOu0Fek
         2YB+lbRP4vK5U8VwdEizUF/Xj3x2dxvJiILh63nyvswfzH2lExMpHVYKC5QGTUXfek1+
         p2nPdM/hCjJem4/xkBwizjpgXtRQ0KP4/iSxokZgNvcfLbvFu3NlHtoz0qlphQjOxjMZ
         uSHg8a3eCFJKqdi8RC8iqebhglINisnxvNfz46+ITMyK4UqHixURs8kJB4NfRxpHhTaG
         dGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Begk0szVfsIK0MNleiufllaCD+/oPEPI5QF8Mpo7rp0=;
        b=cYGx9o7m810kd4KwSzptBklUb1IFMUKZcxC4QrbdtmCwluSvg58uT2GRlT4LFll0Se
         NAFTnEcBKLWwmq0PbaGk6CEaUQwu1Ipx93aP96RVJ+4/KN9ZRhK4CrkSWrBQrflVnoUd
         HC8d6e7Kg05siHej6IC9/BweY0GPFIbqyYovb628XXYXsP8hJLXtl39p6MObrC629ZPm
         gY1TQuk9LRdkJtyHZiIH1MQVMvgpV0rPO2wLV/62kloiNWKZHgtGei4qlYDlCRD9svgw
         5i7Fzi/DJjGAmlGrRfEHRbrGOwMn3yr7FnMY2n7DVK2c+qsThdwaSe6HwGmJhJtuaHKz
         2rlw==
X-Gm-Message-State: AODbwcA4SOyUNheOy3m0zOW/n/aoLlqco/YOlOFLyDKtVWDoUZDCHFDv
        jQu7UjWt2ZQVq53PoNU9sg==
X-Received: by 10.84.217.21 with SMTP id o21mr4833485pli.50.1496267088080;
        Wed, 31 May 2017 14:44:48 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:46 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 10/31] config: migrate the_configset to the_repository
Date:   Wed, 31 May 2017 14:43:56 -0700
Message-Id: <20170531214417.38857-11-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate the default config to be stored within 'the_repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 config.c | 185 ++++++++++++++++++++++++++++++++++++++-------------------------
 config.h |   1 +
 repo.c   |  21 ++++++++
 repo.h   |  11 ++++
 4 files changed, 146 insertions(+), 72 deletions(-)

diff --git a/config.c b/config.c
index ff09b27b8..930333e89 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "repo.h"
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
@@ -1606,28 +1600,6 @@ int git_config_with_options(config_fn_t fn, void *data,
 	return do_git_config_sequence(opts, fn, data);
 }
 
-static void git_config_raw(config_fn_t fn, void *data)
-{
-	struct config_options opts = {0};
-
-	opts.respect_includes = 1;
-	if (have_git_dir())
-		opts.git_dir = get_git_common_dir();
-	if (git_config_with_options(fn, data, NULL, &opts) < 0)
-		/*
-		 * git_config_with_options() normally returns only
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
@@ -1676,14 +1648,6 @@ void read_early_config(config_fn_t cb, void *data)
 	strbuf_release(&buf);
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
@@ -1782,7 +1746,7 @@ void git_configset_clear(struct config_set *cs)
 	cs->list.items = NULL;
 }
 
-static int config_set_callback(const char *key, const char *value, void *cb)
+int config_set_callback(const char *key, const char *value, void *cb)
 {
 	struct config_set *cs = cb;
 	configset_add_value(cs, key, value);
@@ -1893,87 +1857,164 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 		return 1;
 }
 
-static void git_config_check_init(void)
+/* Functions use to read configuration from a repository */
+static void git_config_check_init(struct repo *repository)
 {
-	if (the_config_set.hash_initialized)
+	if (repository->config && repository->config->hash_initialized)
 		return;
-	git_configset_init(&the_config_set);
-	git_config_raw(config_set_callback, &the_config_set);
+	repo_read_config(repository);
 }
 
-void git_config_clear(void)
+static void repo_config_clear(struct repo *repository)
 {
-	if (!the_config_set.hash_initialized)
+	if (!repository->config || !repository->config->hash_initialized)
 		return;
-	git_configset_clear(&the_config_set);
+	git_configset_clear(repository->config);
 }
 
-int git_config_get_value(const char *key, const char **value)
+static void repo_config(struct repo *repository, config_fn_t fn, void *data)
 {
-	git_config_check_init();
-	return git_configset_get_value(&the_config_set, key, value);
+	git_config_check_init(repository);
+	configset_iter(repository->config, fn, data);
 }
 
-const struct string_list *git_config_get_value_multi(const char *key)
+static int repo_config_get_value(struct repo *repository,
+				 const char *key, const char **value)
 {
-	git_config_check_init();
-	return git_configset_get_value_multi(&the_config_set, key);
+	git_config_check_init(repository);
+	return git_configset_get_value(repository->config, key, value);
 }
 
-int git_config_get_string_const(const char *key, const char **dest)
+static const struct string_list *repo_config_get_value_multi(struct repo *repository,
+							     const char *key)
+{
+	git_config_check_init(repository);
+	return git_configset_get_value_multi(repository->config, key);
+}
+
+static int repo_config_get_string_const(struct repo *repository,
+					const char *key, const char **dest)
 {
 	int ret;
-	git_config_check_init();
-	ret = git_configset_get_string_const(&the_config_set, key, dest);
+	git_config_check_init(repository);
+	ret = git_configset_get_string_const(repository->config, key, dest);
 	if (ret < 0)
 		git_die_config(key, NULL);
 	return ret;
 }
 
+static int repo_config_get_string(struct repo *repository,
+				  const char *key, char **dest)
+{
+	git_config_check_init(repository);
+	return repo_config_get_string_const(repository, key, (const char **)dest);
+}
+
+static int repo_config_get_int(struct repo *repository,
+			       const char *key, int *dest)
+{
+	git_config_check_init(repository);
+	return git_configset_get_int(repository->config, key, dest);
+}
+
+static int repo_config_get_ulong(struct repo *repository,
+				const char *key, unsigned long *dest)
+{
+	git_config_check_init(repository);
+	return git_configset_get_ulong(repository->config, key, dest);
+}
+
+static int repo_config_get_bool(struct repo *repository,
+				const char *key, int *dest)
+{
+	git_config_check_init(repository);
+	return git_configset_get_bool(repository->config, key, dest);
+}
+
+static int repo_config_get_bool_or_int(struct repo *repository,
+				       const char *key, int *is_bool, int *dest)
+{
+	git_config_check_init(repository);
+	return git_configset_get_bool_or_int(repository->config, key, is_bool, dest);
+}
+
+static int repo_config_get_maybe_bool(struct repo *repository,
+				      const char *key, int *dest)
+{
+	git_config_check_init(repository);
+	return git_configset_get_maybe_bool(repository->config, key, dest);
+}
+
+static int repo_config_get_pathname(struct repo *repository,
+				    const char *key, const char **dest)
+{
+	int ret;
+	git_config_check_init(repository);
+	ret = git_configset_get_pathname(repository->config, key, dest);
+	if (ret < 0)
+		git_die_config(key, NULL);
+	return ret;
+}
+
+/* Functions used historically to read configuration from 'the_repository' */
+void git_config(config_fn_t fn, void *data)
+{
+	repo_config(&the_repository, fn, data);
+}
+
+void git_config_clear(void)
+{
+	repo_config_clear(&the_repository);
+}
+
+int git_config_get_value(const char *key, const char **value)
+{
+	return repo_config_get_value(&the_repository, key, value);
+}
+
+const struct string_list *git_config_get_value_multi(const char *key)
+{
+	return repo_config_get_value_multi(&the_repository, key);
+}
+
+int git_config_get_string_const(const char *key, const char **dest)
+{
+	return repo_config_get_string_const(&the_repository, key, dest);
+}
+
 int git_config_get_string(const char *key, char **dest)
 {
-	git_config_check_init();
-	return git_config_get_string_const(key, (const char **)dest);
+	return repo_config_get_string(&the_repository, key, dest);
 }
 
 int git_config_get_int(const char *key, int *dest)
 {
-	git_config_check_init();
-	return git_configset_get_int(&the_config_set, key, dest);
+	return repo_config_get_int(&the_repository, key, dest);
 }
 
 int git_config_get_ulong(const char *key, unsigned long *dest)
 {
-	git_config_check_init();
-	return git_configset_get_ulong(&the_config_set, key, dest);
+	return repo_config_get_ulong(&the_repository, key, dest);
 }
 
 int git_config_get_bool(const char *key, int *dest)
 {
-	git_config_check_init();
-	return git_configset_get_bool(&the_config_set, key, dest);
+	return repo_config_get_bool(&the_repository, key, dest);
 }
 
 int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)
 {
-	git_config_check_init();
-	return git_configset_get_bool_or_int(&the_config_set, key, is_bool, dest);
+	return repo_config_get_bool_or_int(&the_repository, key, is_bool, dest);
 }
 
 int git_config_get_maybe_bool(const char *key, int *dest)
 {
-	git_config_check_init();
-	return git_configset_get_maybe_bool(&the_config_set, key, dest);
+	return repo_config_get_maybe_bool(&the_repository, key, dest);
 }
 
 int git_config_get_pathname(const char *key, const char **dest)
 {
-	int ret;
-	git_config_check_init();
-	ret = git_configset_get_pathname(&the_config_set, key, dest);
-	if (ret < 0)
-		git_die_config(key, NULL);
-	return ret;
+	return repo_config_get_pathname(&the_repository, key, dest);
 }
 
 int git_config_get_expiry(const char *key, const char **output)
diff --git a/config.h b/config.h
index f7f8b66c5..4cd9e2915 100644
--- a/config.h
+++ b/config.h
@@ -149,6 +149,7 @@ struct config_set {
 };
 
 extern void git_configset_init(struct config_set *cs);
+extern int config_set_callback(const char *key, const char *value, void *cb);
 extern int git_configset_add_file(struct config_set *cs, const char *filename);
 extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
 extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
diff --git a/repo.c b/repo.c
index 789ffdd78..c67cad5a2 100644
--- a/repo.c
+++ b/repo.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "repo.h"
+#include "config.h"
 
 /*
  * This may be the wrong place for this.
@@ -89,6 +90,20 @@ void repo_set_worktree(struct repo *repo, const char *path)
 	repo->worktree = real_pathdup(path, 1);
 }
 
+void repo_read_config(struct repo *repo)
+{
+	struct config_options opts = { 1, repo->commondir };
+
+	if (!repo->config)
+		repo->config = xcalloc(1, sizeof(struct config_set));
+	else
+		git_configset_clear(repo->config);
+
+	git_configset_init(repo->config);
+
+	git_config_with_options(config_set_callback, repo->config, NULL, &opts);
+}
+
 int repo_init(struct repo *repo, const char *gitdir)
 {
 	int error = 0;
@@ -128,4 +143,10 @@ void repo_clear(struct repo *repo)
 	repo_clear_env(repo);
 	free(repo->worktree);
 	repo->worktree = NULL;
+
+	if (repo->config) {
+		git_configset_clear(repo->config);
+		free(repo->config);
+		repo->config = NULL;
+	}
 }
diff --git a/repo.h b/repo.h
index 95d021049..284452832 100644
--- a/repo.h
+++ b/repo.h
@@ -1,6 +1,8 @@
 #ifndef REPO_H
 #define REPO_H
 
+struct config_set;
+
 struct repo {
 	/* Environment */
 	char *gitdir;
@@ -11,6 +13,14 @@ struct repo {
 	char *namespace;
 	char *worktree;
 
+	/* Subsystems */
+	/*
+	 * Repository's config which contains key-value pairs from the usual
+	 * set of config config files (i.e repo specific .git/config, user wide
+	 * ~/.gitconfig, XDG config file and the global /etc/gitconfig)
+	 */
+	struct config_set *config;
+
 	/* Configurations */
 	unsigned ignore_env:1;
 	/* Indicates if a repository has a different 'commondir' from 'gitdir' */
@@ -21,6 +31,7 @@ extern struct repo the_repository;
 
 extern void repo_set_gitdir(struct repo *repo, const char *path);
 extern void repo_set_worktree(struct repo *repo, const char *path);
+extern void repo_read_config(struct repo *repo);
 extern int repo_init(struct repo *repo, const char *path);
 extern void repo_clear(struct repo *repo);
 
-- 
2.13.0.506.g27d5fe0cd-goog

