Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391F5C35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0455F2072C
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJOt7Fp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbgAYAjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:39:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46017 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387458AbgAYAjc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:39:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so4155977wrj.12
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 16:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LFp4mK6etq2pl4vtqJtV6izsCj/YQsTWJa7JfMKFvKY=;
        b=jJOt7Fp1R+NLCO03H1rc3piA/77I9ydEbIIEwFVZ1Dw0MRe1S0RXdzH7dXv/7OI3Zi
         Myo/MkucaI/XuhBavsjFng/6s4lJA/n4lix6B0a+Kfwxcr8Qm/8thn0LbIrktdGoHJ8D
         V7Cpl9VodJKI93e8Tg8lid8DZKm2Rz2QcpOcuNRF/1I3S3unktvRQs4iZYkZ/d/oyENs
         HmSrqOFIwG2MDbwJQUg7cFLRMnDprqocnPkmJoyDnU9UVK7aBtpOOLl3xO9VnO16KbXy
         o4+uW2krCc4TFzklLv3xuwSfasC5CtwL5/1pZ9myDbk5yN/vVFzM8MPvB4GpzVufNKWT
         +rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LFp4mK6etq2pl4vtqJtV6izsCj/YQsTWJa7JfMKFvKY=;
        b=BAOc1I5BCa/oYdUYVhqDCR2fHGtivkHPvRxBIvCwiqd8cUchlNZLt1QolqvKgHwnv/
         TZ+TFN6cXr88LXmFAY13OC5lC82oC4XOdaF2mi8R9GNJzPPl9VF1z+v1HXFE8BPKyy1u
         TS8pgTqrybnF5OE+nb9RMWhrEGyXP+2CMoBC0Hi8HmItWGOYzFkjx2Y/2JZjw0WEoJQ7
         kq+sSGbOkcv+m/RNL5t0ktUNeul9kBuxup8ZNHOqqvDwM51UCOG1zzGO5FSLwvVaISz0
         E0Oqj5aYG9C6kibcuz4FkyP4AlvsabYRxsuaQhGipqffgeWXsPZ+DP+jk7pK1ypG2JCM
         X+1A==
X-Gm-Message-State: APjAAAVXXhnYOf/ymPhL7YHULeHjY8qTgM378ca9FCl1dXX4XTAj5emp
        UakPWKBj7pIT9mJtUQFjzjc2/3vR
X-Google-Smtp-Source: APXvYqy+zizG++I+c3VL3YmY58AoKoNBL0F22oO0m4SUTM2sjuR7Y/oWJu41cKYcObPX5kF5V5ZF4Q==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr6698750wrx.147.1579912770954;
        Fri, 24 Jan 2020 16:39:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10sm9740578wrx.19.2020.01.24.16.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 16:39:30 -0800 (PST)
Message-Id: <2e979d9fa5066f61eb89e3c1a1a34ac813d71700.1579912764.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
References: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Jan 2020 00:39:24 +0000
Subject: [PATCH v5 6/6] config: add '--show-scope' to print the scope of a
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
index 899e92a1c9..2e47765aab 100644
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
index 52a904cfb1..66d2b0d2df 100644
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
+	const char *scope = scope_to_string(current_config_scope());
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
index f319a3d6a0..469dff57b4 100644
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
 
+const char *scope_to_string(enum config_scope scope)
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
index f383a71404..7b3aec0092 100644
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
+const char *scope_to_string(enum config_scope scope);
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
index 78bbb9eb98..2e91879b2a 100644
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
-		return "repo";
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
+	printf("scope=%s\n", scope_to_string(current_config_scope()));
 
 	return 0;
 }
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e5fb9114f6..79dbea9bd1 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1771,6 +1771,65 @@ test_expect_success '--show-origin blob ref' '
 	test_cmp expect output
 '
 
+test_expect_success '--show-scope with --list' '
+	cat >expect <<-EOF &&
+		global	user.global=true
+		global	user.override=global
+		global	include.path=$INCLUDE_DIR/absolute.include
+		global	user.absolute=include
+		local	user.local=true
+		local	user.override=local
+		local	include.path=../include/relative.include
+		local	user.relative=include
+		command	user.cmdline=true
+	EOF
+	git -c user.cmdline=true config --list --show-scope >output &&
+	test_cmp expect output
+'
+
+test_expect_success !MINGW '--show-scope with --blob' '
+	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
+	cat >expect <<-EOF &&
+		command	user.custom=true
+	EOF
+	git config --blob=$blob --show-scope --list >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-scope with --local' '
+	cat >expect <<-\EOF &&
+		local	user.local=true
+		local	user.override=local
+		local	include.path=../include/relative.include
+	EOF
+	git config --local --list --show-scope >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-scope getting a single value' '
+	cat >expect <<-\EOF &&
+		local	true
+	EOF
+	git config --show-scope --get user.local >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-scope with --show-origin' '
+	cat >expect <<-EOF &&
+		global	file:$HOME/.gitconfig	user.global=true
+		global	file:$HOME/.gitconfig	user.override=global
+		global	file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
+		global	file:$INCLUDE_DIR/absolute.include	user.absolute=include
+		local	file:.git/config	user.local=true
+		local	file:.git/config	user.override=local
+		local	file:.git/config	include.path=../include/relative.include
+		local	file:.git/../include/relative.include	user.relative=include
+		command	command line:	user.cmdline=true
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
