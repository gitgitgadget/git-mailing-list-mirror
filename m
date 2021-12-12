Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2CCC433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhLLUOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:14:49 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46733 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhLLUOk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:40 -0500
Received: by mail-wr1-f54.google.com with SMTP id u1so23761119wru.13
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pf8ckl348z4gTFmlNbcEwF/Y+zJkABhHPfKxshGnw+4=;
        b=LVY370R0OhB4UyCqTaSSeRpQulQ3skS6QvrZNofvHNO66RDVSOEl0s49HZ4ll88KZu
         hVwVhGUTXCotLdF3oN5uvrBxVJ60BCR9vdnH0/H1kBGD6QWQZ0Sow7x8GTIy2iOmk2Oe
         pXYkSV98dfh4uCNsFbzrpO+VoRNzhuGeb22WKMuBCJPRxiq02RVxgXyGAlj1WHw/gx4K
         Zryu4X/iTmaBpjm58HaBEudX20d2bKl8waniF7UWk3rT2PLVwNzPRSc2PJt19xiBWbKQ
         Z62K4PZ5OW8uZoSfrfab49RPC/Otk77TdVy47+acqn3RPlibuC2miua7hKsxzcBekPHJ
         FWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pf8ckl348z4gTFmlNbcEwF/Y+zJkABhHPfKxshGnw+4=;
        b=uvhKGaZBqePvYJMoHnkrKSYli+Jt/1D4DFucjdHhwwx0JIZ/9bItLIzuskIEBL7Ush
         JFmM4CGf39gYCiXQf6UezumBd/qXUsY/ty4zeGaT9alXJFrZuPx9FckSKGSmsw2W/E6+
         ffIaxZMUVQ2rBwBsWVqtPMdmBsMYqmEcj6CR65YCMh3jzNXEV5A0DwyH3Tfzgl5i5X+g
         /5T7pNs/ECQyYigY+WPhxzx6Tn/XvGyDBIAfWua64FuEw0/y9O9WY6W4UPWlwlQAIf//
         uNYppRBVc8EYCNdKAV7qjNrndcLul4bOFqb6VJ7sygzK001LY6seFef/kPQV4ubuRKHM
         MniQ==
X-Gm-Message-State: AOAM5311evsDUR1A9tlAA8gCef5p5jd/lb6HT0M8rfaa94ZkyP90ZPMX
        +ejiZuSh+MrqJHlgdp0zQ7cH11UHql3YwA==
X-Google-Smtp-Source: ABdhPJyHtRihAKM+RqTgZB7vTPzjAUVgU++XiYlPqjrLFlZDKjXTLiqNnwmNoQgmH4Kr3emrbi2xMQ==
X-Received: by 2002:a5d:50c6:: with SMTP id f6mr26713129wrt.131.1639340018524;
        Sun, 12 Dec 2021 12:13:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/13] init & clone: add init.templateDir=[bool]
Date:   Sun, 12 Dec 2021 21:13:16 +0100
Message-Id: <patch-06.13-2f478f7ba4a-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to specify init.templateDir=false in the configuration
to always initialize or clone repositories as though "--no-template"
was provided. This makes it easy to entirely opt-out of getting
default template content such as the sample hooks.

Not all of what's being added here to the config API is needed for
this change, but let's be consistent with the existing boilerplate
there and add the full set of relevant functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-init.txt |  7 ++++++-
 builtin/clone.c            |  4 ++--
 builtin/init-db.c          | 10 +++++++---
 config.c                   | 34 ++++++++++++++++++++++++++++++++++
 config.h                   | 17 +++++++++++++++++
 t/t0001-init.sh            |  8 +++-----
 6 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index d0ce9b185a5..ef933ee9145 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -148,6 +148,9 @@ Using a template template directory can be disabled by any of of:
  - The `--no-template` option being given. This option is incompatible
    with `--template`.
 
+ - The `init.templateDirectory' option being set to 'false' (or
+   another stand-in for 'false', see linkgit:git-config[1]).
+
  - The `GIT_NO_TEMPLATE_DIR` variable being set to `true` in the
    environment (or any other `true` value. See the discussion of
    boolean canonicalization in linkgit:git-config[1]).
@@ -159,7 +162,9 @@ will be one of the following (in order):
 
  - the contents of the `$GIT_TEMPLATE_DIR` environment variable;
 
- - the `init.templateDir` configuration variable; or
+ - the `init.templateDir` configuration variable, if set to 'true' (or
+   another stand-in for 'true', see linkgit:git-config[1]) the default
+   template directory; or
 
  - the default template directory: `/usr/share/git-core/templates`.
 
diff --git a/builtin/clone.c b/builtin/clone.c
index a57ba4da31d..671d8356f1c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -53,7 +53,7 @@ static int option_shallow_submodules;
 static int option_reject_shallow = -1;    /* unspecified */
 static int config_reject_shallow = -1;    /* unspecified */
 static int deepen;
-static int option_no_template;
+static int option_no_template = -1; /* unspecified */
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
 static char *remote_name = NULL;
@@ -911,7 +911,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
-	if (option_no_template && option_template)
+	if (option_no_template != -1 && option_template)
 		die(_("--no-template and --template are incompatible."));
 
 	repo_name = argv[0];
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 4c4ff6fe412..fcf538193c8 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -196,6 +196,7 @@ void initialize_repository_version(int hash_algo, int reinit)
 static void create_template_files(int no_template, const char *template_path)
 {
 	const char *init_template_dir = NULL;
+	int is_bool, ret;
 
 	/*
 	 * First copy the templates -- we might have the default
@@ -206,7 +207,10 @@ static void create_template_files(int no_template, const char *template_path)
 	 * values (since we've just potentially changed what's available on
 	 * disk).
 	 */
-	git_config_get_pathname("init.templatedir", &init_template_dir);
+	ret = git_config_get_bool_or_pathname("init.templatedir", &is_bool,
+					      &init_template_dir);
+	if (no_template == -1)
+		no_template = is_bool ? !ret : 0;
 	copy_templates(no_template, template_path, init_template_dir);
 	free((char *)init_template_dir);
 	git_config_clear();
@@ -547,7 +551,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *git_dir;
 	const char *real_git_dir = NULL;
 	const char *work_tree;
-	int no_template = 0;
+	int no_template = -1;
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
 	const char *object_format = NULL;
@@ -583,7 +587,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	if (real_git_dir && !is_absolute_path(real_git_dir))
 		real_git_dir = real_pathdup(real_git_dir, 1);
 
-	if (no_template && template_dir)
+	if (no_template != -1 && template_dir)
 		die(_("--no-template and --template are incompatible"));
 	if (template_dir && *template_dir && !is_absolute_path(template_dir)) {
 		template_dir = absolute_pathdup(template_dir);
diff --git a/config.c b/config.c
index c5873f3a706..f64ce2a1e1e 100644
--- a/config.c
+++ b/config.c
@@ -1260,6 +1260,18 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_bool_or_pathname(const char **dest, const char *name,
+				const char *value, int *is_bool)
+{
+	int v = git_parse_maybe_bool_text(value);
+	if (0 <= v) {
+		*is_bool = 1;
+		return v;
+	}
+	*is_bool = 0;
+	return git_config_pathname(dest, name, value);
+}
+
 int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *value)
 {
 	if (!value)
@@ -2251,6 +2263,16 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 		return 1;
 }
 
+int git_configset_get_bool_or_pathname(struct config_set *cs, const char *key,
+				       int *is_bool, const char **dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value))
+		return git_config_bool_or_pathname(dest, key, value, is_bool);
+	else
+		return 1;
+}
+
 /* Functions use to read configuration from a repository */
 static void repo_read_config(struct repository *repo)
 {
@@ -2384,6 +2406,13 @@ int repo_config_get_pathname(struct repository *repo,
 	return ret;
 }
 
+int repo_config_get_bool_or_pathname(struct repository *repo,
+				     const char *key, int *is_bool, const char **dest)
+{
+	git_config_check_init(repo);
+	return git_configset_get_bool_or_pathname(repo->config, key, is_bool, dest);
+}
+
 /* Functions used historically to read configuration from 'the_repository' */
 void git_config(config_fn_t fn, void *data)
 {
@@ -2445,6 +2474,11 @@ int git_config_get_pathname(const char *key, const char **dest)
 	return repo_config_get_pathname(the_repository, key, dest);
 }
 
+int git_config_get_bool_or_pathname(const char *key, int *is_bool, const char **dest)
+{
+	return repo_config_get_bool_or_pathname(the_repository, key, is_bool, dest);
+}
+
 int git_config_get_expiry(const char *key, const char **output)
 {
 	int ret = git_config_get_string(key, (char **)output);
diff --git a/config.h b/config.h
index f119de01309..d482d55d9ae 100644
--- a/config.h
+++ b/config.h
@@ -241,6 +241,15 @@ int git_config_string(const char **, const char *, const char *);
  */
 int git_config_pathname(const char **, const char *, const char *);
 
+/**
+ * Same as `git_config_pathname`, except that we'll first try to parse
+ * the value as a boolean. Check the `is_bool` to see if it was a
+ * boolen. Otherwise it'll have the same semantics as
+ * `git_config_pathname`.
+ */
+int git_config_bool_or_pathname(const char **dest, const char *name,
+				const char *value, int *is_bool);
+
 int git_config_expiry_date(timestamp_t *, const char *, const char *);
 int git_config_color(char *, const char *, const char *);
 int git_config_set_in_file_gently(const char *, const char *, const char *);
@@ -493,6 +502,8 @@ int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
 int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
 int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
 int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest);
+int git_configset_get_bool_or_pathname(struct config_set *cs, const char *key,
+				       int *is_bool, const char **dest);
 
 /* Functions for reading a repository's config */
 struct repository;
@@ -517,6 +528,9 @@ int repo_config_get_maybe_bool(struct repository *repo,
 			       const char *key, int *dest);
 int repo_config_get_pathname(struct repository *repo,
 			     const char *key, const char **dest);
+int repo_config_get_bool_or_pathname(struct repository *repo,
+				     const char *key, int *is_bool,
+				     const char **dest);
 
 /**
  * Querying For Specific Variables
@@ -607,6 +621,9 @@ int git_config_get_maybe_bool(const char *key, int *dest);
  */
 int git_config_get_pathname(const char *key, const char **dest);
 
+int git_config_get_bool_or_pathname(const char *key, int *is_bool,
+				    const char **dest);
+
 int git_config_get_index_threads(int *dest);
 int git_config_get_split_index(void);
 int git_config_get_max_percent_split_change(void);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 388c28062c2..39cf132e9a0 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -289,11 +289,9 @@ test_expect_success 'init with init.templateDir=[bool]' '
 	(
 		no_templatedir_env &&
 
-		cat >expect <<-\EOF &&
-		warning: templates not found in false
-		EOF
-		git -c init.templateDir=false init repo 2>actual &&
-		test_cmp expect actual
+		git -c init.templateDir=false init repo 2>err &&
+		test_must_be_empty err &&
+		test_path_is_missing repo/.git/description
 	)
 '
 
-- 
2.34.1.1020.gb1392dd1877

