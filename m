Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501C4C33CB7
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A38A20CC7
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYNn4lV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgA2Dei (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:34:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39269 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgA2Def (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 22:34:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so18483747wrt.6
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 19:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Ejpw9f3ijtaRWKw12zZaPCY02AQ1qYgiLIhb4ToR9w=;
        b=nYNn4lV9l82hgNDQGTuj4A28X320hFQ6BdQ1aVcPZNiaJpL+lcTfMMGfUXD7FynAqz
         gm2eDR1CKwAAeoT3+BiKL+u0QXIPUUwe44n3OEc24NZOGAYFLqcQwyTYaZvR/MQI0hml
         8qvh5/9gk/RLx/sAUtu06opMPNMoTJbkOeHBJtG08HPwE4K3K4JMiWn28YjFbjxcF2W8
         LG+UahBUZfUW+4bRY2IvXNu9CjT19/rsTm+NK0kOUUBPG7yzEnkDOc30O8fMrLSJmnBl
         QJnI+NdROoGa/zjwlB9RfVKtZu5nhJrh7Dehx1XUIrAQwHmJvalD+wfnYqBMrDHB6p+3
         QoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Ejpw9f3ijtaRWKw12zZaPCY02AQ1qYgiLIhb4ToR9w=;
        b=oSQ9PrOsuKA6eN82brZH2ucZkvAnawqJpT0Af66KH2q72mRAQmZKeSy7+5Sk0kIkyP
         xQJFzzGw2uwAPeIl1Gu95wdDxNwDc+JqXUQUlCULmpsXQhhweO8MJsg9QzjlxSIkC1SW
         A8Dl4N+xBH16JQuG1zKD7EIEZTPPjVnRhpv+Ddi9tm0pX43RrfMX9sYgOjt53kbcB3PG
         hqj0LJdOP8wJ6E/IxRsj2MKznLqj+mzB3B1P6hzXJSw3Jp0SYM32JF79zaOEIZFr9sIY
         qz4NBUe4VGLKr5yCBAMcV6tvWLKiK13JLx59ckLGDsKHVOlIlmy8ZZYrk3QIZHCIYwtV
         /I0g==
X-Gm-Message-State: APjAAAWxSlTtDBbWWVL7AMdEz4rJ039XJl1VxO5bzHkMlVvdZ6pjdPUG
        hHNJ91ihXxpmiiC01bwPOG51gzGS
X-Google-Smtp-Source: APXvYqxge9ljwM71pmehP/EWIbRq3MnxK8beg5fCEsg/CD66CnlkNyRmed43jBKJmGbeSO3dkaHzfw==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr32947846wrs.106.1580268871806;
        Tue, 28 Jan 2020 19:34:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm580435wmh.48.2020.01.28.19.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 19:34:31 -0800 (PST)
Message-Id: <fc141e86896edb4241e84cc300e191889a3fa4ea.1580268865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
References: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
        <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jan 2020 03:34:25 +0000
Subject: [PATCH v6 6/6] config: add '--show-scope' to print the scope of a
 config value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

When a user queries config values with --show-origin, often it's
difficult to determine what the actual "scope" (local, global, etc.) of
a given value is based on just the origin file.

Teach 'git config' the '--show-scope' option to print the scope of all
displayed config values.  Note that we should never see anything of
"submodule" scope as that is only ever used by submodule-config.c when
parsing the '.gitmodules' file.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-config.txt | 15 ++++++---
 builtin/config.c             | 36 +++++++++++++++++++---
 config.c                     | 26 +++++++++++++++-
 config.h                     | 21 +++++++------
 submodule-config.c           |  4 ++-
 t/helper/test-config.c       | 19 +-----------
 t/t1300-config.sh            | 59 ++++++++++++++++++++++++++++++++++++
 7 files changed, 141 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 899e92a1c9..7573160f21 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,18 +9,18 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] name [value [value_regex]]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
 'git config' [<file-option>] [--type=<type>] --add name value
 'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get name [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get-all name [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
 'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
 'git config' [<file-option>] --unset name [value_regex]
 'git config' [<file-option>] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
 'git config' [<file-option>] --remove-section name
-'git config' [<file-option>] [--show-origin] [-z|--null] [--name-only] -l | --list
+'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
 'git config' [<file-option>] --get-color name [default]
 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
 'git config' [<file-option>] -e | --edit
@@ -222,6 +222,11 @@ Valid `<type>`'s include:
 	the actual origin (config file path, ref, or blob id if
 	applicable).
 
+--show-scope::
+	Similar to `--show-origin` in that it augments the output of
+	all queried config options with the scope of that value
+	(local, global, system, command).
+
 --get-colorbool name [stdout-is-tty]::
 
 	Find the color setting for `name` (e.g. `color.diff`) and output
diff --git a/builtin/config.c b/builtin/config.c
index 52a904cfb1..ee4aef6a35 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -33,6 +33,7 @@ static int end_nul;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
 static int show_origin;
+static int show_scope;
 
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -155,6 +156,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
+	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree, local, global, system, command)")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
 	OPT_END(),
 };
@@ -189,11 +191,23 @@ static void show_config_origin(struct strbuf *buf)
 	strbuf_addch(buf, term);
 }
 
+static void show_config_scope(struct strbuf *buf)
+{
+	const char term = end_nul ? '\0' : '\t';
+	const char *scope = config_scope_name(current_config_scope());
+
+	strbuf_addstr(buf, N_(scope));
+	strbuf_addch(buf, term);
+}
+
 static int show_all_config(const char *key_, const char *value_, void *cb)
 {
-	if (show_origin) {
+	if (show_origin || show_scope) {
 		struct strbuf buf = STRBUF_INIT;
-		show_config_origin(&buf);
+		if (show_scope)
+			show_config_scope(&buf);
+		if (show_origin)
+			show_config_origin(&buf);
 		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
 		fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
@@ -213,6 +227,8 @@ struct strbuf_list {
 
 static int format_config(struct strbuf *buf, const char *key_, const char *value_)
 {
+	if (show_scope)
+		show_config_scope(buf);
 	if (show_origin)
 		show_config_origin(buf);
 	if (show_keys)
@@ -622,6 +638,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			!strcmp(given_config_source.file, "-")) {
 		given_config_source.file = NULL;
 		given_config_source.use_stdin = 1;
+		given_config_source.scope = CONFIG_SCOPE_COMMAND;
 	}
 
 	if (use_global_config) {
@@ -637,6 +654,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			 */
 			die(_("$HOME not set"));
 
+		given_config_source.scope = CONFIG_SCOPE_GLOBAL;
+
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
 			given_config_source.file = xdg_config;
@@ -646,11 +665,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			free(xdg_config);
 		}
 	}
-	else if (use_system_config)
+	else if (use_system_config) {
 		given_config_source.file = git_etc_gitconfig();
-	else if (use_local_config)
+		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
+	} else if (use_local_config) {
 		given_config_source.file = git_pathdup("config");
-	else if (use_worktree_config) {
+		given_config_source.scope = CONFIG_SCOPE_LOCAL;
+	} else if (use_worktree_config) {
 		struct worktree **worktrees = get_worktrees(0);
 		if (repository_format_worktree_config)
 			given_config_source.file = git_pathdup("config.worktree");
@@ -662,13 +683,18 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			      "section in \"git help worktree\" for details"));
 		else
 			given_config_source.file = git_pathdup("config");
+		given_config_source.scope = CONFIG_SCOPE_LOCAL;
 		free_worktrees(worktrees);
 	} else if (given_config_source.file) {
 		if (!is_absolute_path(given_config_source.file) && prefix)
 			given_config_source.file =
 				prefix_filename(prefix, given_config_source.file);
+		given_config_source.scope = CONFIG_SCOPE_COMMAND;
+	} else if (given_config_source.blob) {
+		given_config_source.scope = CONFIG_SCOPE_COMMAND;
 	}
 
+
 	if (respect_includes_opt == -1)
 		config_options.respect_includes = !given_config_source.file;
 	else
diff --git a/config.c b/config.c
index f319a3d6a0..18a6bdd9ff 100644
--- a/config.c
+++ b/config.c
@@ -1702,6 +1702,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 	char *xdg_config = xdg_config_home("config");
 	char *user_config = expand_user_path("~/.gitconfig", 0);
 	char *repo_config;
+	enum config_scope prev_parsing_scope = current_parsing_scope;
 
 	if (opts->commondir)
 		repo_config = mkpathdup("%s/config", opts->commondir);
@@ -1741,7 +1742,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
 
-	current_parsing_scope = CONFIG_SCOPE_UNKNOWN;
+	current_parsing_scope = prev_parsing_scope;
 	free(xdg_config);
 	free(user_config);
 	free(repo_config);
@@ -1762,6 +1763,9 @@ int config_with_options(config_fn_t fn, void *data,
 		data = &inc;
 	}
 
+	if (config_source)
+		current_parsing_scope = config_source->scope;
+
 	/*
 	 * If we have a specific filename, use it. Otherwise, follow the
 	 * regular lookup sequence.
@@ -3294,6 +3298,26 @@ const char *current_config_origin_type(void)
 	}
 }
 
+const char *config_scope_name(enum config_scope scope)
+{
+	switch (scope) {
+	case CONFIG_SCOPE_SYSTEM:
+		return "system";
+	case CONFIG_SCOPE_GLOBAL:
+		return "global";
+	case CONFIG_SCOPE_LOCAL:
+		return "local";
+	case CONFIG_SCOPE_WORKTREE:
+		return "worktree";
+	case CONFIG_SCOPE_COMMAND:
+		return "command";
+	case CONFIG_SCOPE_SUBMODULE:
+		return "submodule";
+	default:
+		return "unknown";
+	}
+}
+
 const char *current_config_name(void)
 {
 	const char *name;
diff --git a/config.h b/config.h
index f383a71404..fe0addb0dc 100644
--- a/config.h
+++ b/config.h
@@ -35,10 +35,22 @@ struct object_id;
 
 #define CONFIG_REGEX_NONE ((void *)1)
 
+enum config_scope {
+	CONFIG_SCOPE_UNKNOWN = 0,
+	CONFIG_SCOPE_SYSTEM,
+	CONFIG_SCOPE_GLOBAL,
+	CONFIG_SCOPE_LOCAL,
+	CONFIG_SCOPE_WORKTREE,
+	CONFIG_SCOPE_COMMAND,
+	CONFIG_SCOPE_SUBMODULE,
+};
+const char *config_scope_name(enum config_scope scope);
+
 struct git_config_source {
 	unsigned int use_stdin:1;
 	const char *file;
 	const char *blob;
+	enum config_scope scope;
 };
 
 enum config_origin_type {
@@ -294,15 +306,6 @@ int config_error_nonbool(const char *);
 
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
-enum config_scope {
-	CONFIG_SCOPE_UNKNOWN = 0,
-	CONFIG_SCOPE_SYSTEM,
-	CONFIG_SCOPE_GLOBAL,
-	CONFIG_SCOPE_LOCAL,
-	CONFIG_SCOPE_WORKTREE,
-	CONFIG_SCOPE_COMMAND,
-};
-
 enum config_scope current_config_scope(void);
 const char *current_config_origin_type(void);
 const char *current_config_name(void);
diff --git a/submodule-config.c b/submodule-config.c
index 85064810b2..b8e97d8ae8 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -635,7 +635,9 @@ static void submodule_cache_check_init(struct repository *repo)
 static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
 {
 	if (repo->worktree) {
-		struct git_config_source config_source = { 0 };
+		struct git_config_source config_source = {
+			0, .scope = CONFIG_SCOPE_SUBMODULE
+		};
 		const struct config_options opts = { 0 };
 		struct object_id oid;
 		char *file;
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 56c1f6dfb6..1e3bc7c8f4 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -37,23 +37,6 @@
  *
  */
 
-static const char *scope_name(enum config_scope scope)
-{
-	switch (scope) {
-	case CONFIG_SCOPE_SYSTEM:
-		return "system";
-	case CONFIG_SCOPE_GLOBAL:
-		return "global";
-	case CONFIG_SCOPE_LOCAL:
-		return "local";
-	case CONFIG_SCOPE_WORKTREE:
-		return "worktree";
-	case CONFIG_SCOPE_COMMAND:
-		return "command";
-	default:
-		return "unknown";
-	}
-}
 static int iterate_cb(const char *var, const char *value, void *data)
 {
 	static int nr;
@@ -65,7 +48,7 @@ static int iterate_cb(const char *var, const char *value, void *data)
 	printf("value=%s\n", value ? value : "(null)");
 	printf("origin=%s\n", current_config_origin_type());
 	printf("name=%s\n", current_config_name());
-	printf("scope=%s\n", scope_name(current_config_scope()));
+	printf("scope=%s\n", config_scope_name(current_config_scope()));
 
 	return 0;
 }
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e5fb9114f6..5464c46c18 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1771,6 +1771,65 @@ test_expect_success '--show-origin blob ref' '
 	test_cmp expect output
 '
 
+test_expect_success '--show-scope with --list' '
+	cat >expect <<-EOF &&
+	global	user.global=true
+	global	user.override=global
+	global	include.path=$INCLUDE_DIR/absolute.include
+	global	user.absolute=include
+	local	user.local=true
+	local	user.override=local
+	local	include.path=../include/relative.include
+	local	user.relative=include
+	command	user.cmdline=true
+	EOF
+	git -c user.cmdline=true config --list --show-scope >output &&
+	test_cmp expect output
+'
+
+test_expect_success !MINGW '--show-scope with --blob' '
+	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
+	cat >expect <<-EOF &&
+	command	user.custom=true
+	EOF
+	git config --blob=$blob --show-scope --list >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-scope with --local' '
+	cat >expect <<-\EOF &&
+	local	user.local=true
+	local	user.override=local
+	local	include.path=../include/relative.include
+	EOF
+	git config --local --list --show-scope >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-scope getting a single value' '
+	cat >expect <<-\EOF &&
+	local	true
+	EOF
+	git config --show-scope --get user.local >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-scope with --show-origin' '
+	cat >expect <<-EOF &&
+	global	file:$HOME/.gitconfig	user.global=true
+	global	file:$HOME/.gitconfig	user.override=global
+	global	file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
+	global	file:$INCLUDE_DIR/absolute.include	user.absolute=include
+	local	file:.git/config	user.local=true
+	local	file:.git/config	user.override=local
+	local	file:.git/config	include.path=../include/relative.include
+	local	file:.git/../include/relative.include	user.relative=include
+	command	command line:	user.cmdline=true
+	EOF
+	git -c user.cmdline=true config --list --show-origin --show-scope >output &&
+	test_cmp expect output
+'
+
 test_expect_success '--local requires a repo' '
 	# we expect 128 to ensure that we do not simply
 	# fail to find anything and return code "1"
-- 
gitgitgadget
