Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC996C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 09:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A735D20708
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 09:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZRUlFJPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgA2JIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:08:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38140 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgA2JIK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 04:08:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so19235848wrh.5
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 01:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HZSvyVHec+ukIoncMSl39Ilk5F5n6z2bBEPOa1mMg2A=;
        b=ZRUlFJPdZdHdSu72cf6nDrIVp406htCx31aQR5et43NoFxWJ+a1ZoQdayXnjymCtZj
         E8MKSwNEdQbqAVGeC3CJ4UojW2aGfHa6qYgV5dpI6s4NO3cZVD5/TUMhjbAISPrIejoW
         JuzgXUUypUoZtVefZ4NeO/CVqFt6TfN2pCfrfpXgUMIBi9yLWourwxFyg+tDAkCmHy9T
         K2cuXPayj/AuCmfnimsr9CF8LE8AotvUCA2dyoMI+PMCjytIV7aNCtME7DoZEPfDPiVS
         5o06whEjn7SV2Feu/ami1pkTGSN7qVs+G3NPUa78v2SWR0mwnCcuUjl3L1eb1x9/pALn
         56lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZSvyVHec+ukIoncMSl39Ilk5F5n6z2bBEPOa1mMg2A=;
        b=npwCHGHW6R3FRi06WwfEXGi+6Bqjm9Jz8j2jT0ne9jgG+2k5fRmrPPhV5AzATVIlLO
         o4I0zh9+GINv2Ho0oshwhtrndq5On3AaQFSko/zdoVGbIOFHTKyfI5j5OgQdFBQalkcN
         fYyyC/d42qGKvXC4JbLwbi2ZEdPsQg2HPjPAdUTqr3wDGuhKOB9x2sKq9+IE+V5cCpZE
         Gwse7czo/ziSZNbHR4nEo19guEgvdBI0HAkX6Rcy5WTN3m4Dgu/oZv5EISPytEsYVdCK
         LDPCsUZrV12u05hPoIBkzd2Vzp4R36x9b8Vbtra5H70/dIPaYFPNlMFhUM0NLLnbzYbK
         bF3g==
X-Gm-Message-State: APjAAAXEA10OfHgfZvFYWSbg/eCdnbRLJ1NYqfyxNtiDHtlnkejKiavl
        3MxeqZSNupnVmZOR0T8=
X-Google-Smtp-Source: APXvYqzAz9hC17ENijr+Bw/IKmCdVuIS65DKYLSjk9IzxHsoYZFgX44da/RS4iLPSzECLIqctY9D5g==
X-Received: by 2002:a5d:54c1:: with SMTP id x1mr32955826wrv.240.1580288886478;
        Wed, 29 Jan 2020 01:08:06 -0800 (PST)
Received: from [141.30.68.221] (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id e16sm1999355wrs.73.2020.01.29.01.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 01:08:05 -0800 (PST)
Subject: Re: [PATCH v6 6/6] config: add '--show-scope' to print the scope of a
 config value
To:     Matthew Rogers <mattr94@gmail.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
 <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
 <fc141e86896edb4241e84cc300e191889a3fa4ea.1580268865.git.gitgitgadget@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Message-ID: <8ede2f21-46a8-b95f-6425-c0ee54abdad6@googlemail.com>
Date:   Wed, 29 Jan 2020 10:08:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fc141e86896edb4241e84cc300e191889a3fa4ea.1580268865.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Matthew,

On 29.01.20 04:34, Matthew Rogers via GitGitGadget wrote:
> From: Matthew Rogers <mattr94@gmail.com>
> 
> When a user queries config values with --show-origin, often it's
> difficult to determine what the actual "scope" (local, global, etc.) of
> a given value is based on just the origin file.
> 
> Teach 'git config' the '--show-scope' option to print the scope of all
> displayed config values.  Note that we should never see anything of
> "submodule" scope as that is only ever used by submodule-config.c when
> parsing the '.gitmodules' file.
> 
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   Documentation/git-config.txt | 15 ++++++---
>   builtin/config.c             | 36 +++++++++++++++++++---
>   config.c                     | 26 +++++++++++++++-
>   config.h                     | 21 +++++++------
>   submodule-config.c           |  4 ++-
>   t/helper/test-config.c       | 19 +-----------
>   t/t1300-config.sh            | 59 ++++++++++++++++++++++++++++++++++++
>   7 files changed, 141 insertions(+), 39 deletions(-)

for clarity, I think this patch should be split up further.

For example:

  - moving an enum and adding a new entry should be avoided
  - does the changes to '/config.c' fix something?
  - exposing config_scope_name should have been done before PATCH 4/6 already

Best,
Bert

> 
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 899e92a1c9..7573160f21 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -9,18 +9,18 @@ git-config - Get and set repository or global options
>   SYNOPSIS
>   --------
>   [verse]
> -'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] name [value [value_regex]]
> +'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
>   'git config' [<file-option>] [--type=<type>] --add name value
>   'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
> -'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get name [value_regex]
> -'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get-all name [value_regex]
> -'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
> +'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value_regex]
> +'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value_regex]
> +'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
>   'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
>   'git config' [<file-option>] --unset name [value_regex]
>   'git config' [<file-option>] --unset-all name [value_regex]
>   'git config' [<file-option>] --rename-section old_name new_name
>   'git config' [<file-option>] --remove-section name
> -'git config' [<file-option>] [--show-origin] [-z|--null] [--name-only] -l | --list
> +'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
>   'git config' [<file-option>] --get-color name [default]
>   'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
>   'git config' [<file-option>] -e | --edit
> @@ -222,6 +222,11 @@ Valid `<type>`'s include:
>   	the actual origin (config file path, ref, or blob id if
>   	applicable).
>   
> +--show-scope::
> +	Similar to `--show-origin` in that it augments the output of
> +	all queried config options with the scope of that value
> +	(local, global, system, command).
> +
>   --get-colorbool name [stdout-is-tty]::
>   
>   	Find the color setting for `name` (e.g. `color.diff`) and output
> diff --git a/builtin/config.c b/builtin/config.c
> index 52a904cfb1..ee4aef6a35 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -33,6 +33,7 @@ static int end_nul;
>   static int respect_includes_opt = -1;
>   static struct config_options config_options;
>   static int show_origin;
> +static int show_scope;
>   
>   #define ACTION_GET (1<<0)
>   #define ACTION_GET_ALL (1<<1)
> @@ -155,6 +156,7 @@ static struct option builtin_config_options[] = {
>   	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
>   	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
>   	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
> +	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree, local, global, system, command)")),
>   	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
>   	OPT_END(),
>   };
> @@ -189,11 +191,23 @@ static void show_config_origin(struct strbuf *buf)
>   	strbuf_addch(buf, term);
>   }
>   
> +static void show_config_scope(struct strbuf *buf)
> +{
> +	const char term = end_nul ? '\0' : '\t';
> +	const char *scope = config_scope_name(current_config_scope());
> +
> +	strbuf_addstr(buf, N_(scope));
> +	strbuf_addch(buf, term);
> +}
> +
>   static int show_all_config(const char *key_, const char *value_, void *cb)
>   {
> -	if (show_origin) {
> +	if (show_origin || show_scope) {
>   		struct strbuf buf = STRBUF_INIT;
> -		show_config_origin(&buf);
> +		if (show_scope)
> +			show_config_scope(&buf);
> +		if (show_origin)
> +			show_config_origin(&buf);
>   		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
>   		fwrite(buf.buf, 1, buf.len, stdout);
>   		strbuf_release(&buf);
> @@ -213,6 +227,8 @@ struct strbuf_list {
>   
>   static int format_config(struct strbuf *buf, const char *key_, const char *value_)
>   {
> +	if (show_scope)
> +		show_config_scope(buf);
>   	if (show_origin)
>   		show_config_origin(buf);
>   	if (show_keys)
> @@ -622,6 +638,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>   			!strcmp(given_config_source.file, "-")) {
>   		given_config_source.file = NULL;
>   		given_config_source.use_stdin = 1;
> +		given_config_source.scope = CONFIG_SCOPE_COMMAND;
>   	}
>   
>   	if (use_global_config) {
> @@ -637,6 +654,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>   			 */
>   			die(_("$HOME not set"));
>   
> +		given_config_source.scope = CONFIG_SCOPE_GLOBAL;
> +
>   		if (access_or_warn(user_config, R_OK, 0) &&
>   		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
>   			given_config_source.file = xdg_config;
> @@ -646,11 +665,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>   			free(xdg_config);
>   		}
>   	}
> -	else if (use_system_config)
> +	else if (use_system_config) {
>   		given_config_source.file = git_etc_gitconfig();
> -	else if (use_local_config)
> +		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
> +	} else if (use_local_config) {
>   		given_config_source.file = git_pathdup("config");
> -	else if (use_worktree_config) {
> +		given_config_source.scope = CONFIG_SCOPE_LOCAL;
> +	} else if (use_worktree_config) {
>   		struct worktree **worktrees = get_worktrees(0);
>   		if (repository_format_worktree_config)
>   			given_config_source.file = git_pathdup("config.worktree");
> @@ -662,13 +683,18 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>   			      "section in \"git help worktree\" for details"));
>   		else
>   			given_config_source.file = git_pathdup("config");
> +		given_config_source.scope = CONFIG_SCOPE_LOCAL;
>   		free_worktrees(worktrees);
>   	} else if (given_config_source.file) {
>   		if (!is_absolute_path(given_config_source.file) && prefix)
>   			given_config_source.file =
>   				prefix_filename(prefix, given_config_source.file);
> +		given_config_source.scope = CONFIG_SCOPE_COMMAND;
> +	} else if (given_config_source.blob) {
> +		given_config_source.scope = CONFIG_SCOPE_COMMAND;
>   	}
>   
> +
>   	if (respect_includes_opt == -1)
>   		config_options.respect_includes = !given_config_source.file;
>   	else
> diff --git a/config.c b/config.c
> index f319a3d6a0..18a6bdd9ff 100644
> --- a/config.c
> +++ b/config.c
> @@ -1702,6 +1702,7 @@ static int do_git_config_sequence(const struct config_options *opts,
>   	char *xdg_config = xdg_config_home("config");
>   	char *user_config = expand_user_path("~/.gitconfig", 0);
>   	char *repo_config;
> +	enum config_scope prev_parsing_scope = current_parsing_scope;
>   
>   	if (opts->commondir)
>   		repo_config = mkpathdup("%s/config", opts->commondir);
> @@ -1741,7 +1742,7 @@ static int do_git_config_sequence(const struct config_options *opts,
>   	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
>   		die(_("unable to parse command-line config"));
>   
> -	current_parsing_scope = CONFIG_SCOPE_UNKNOWN;
> +	current_parsing_scope = prev_parsing_scope;
>   	free(xdg_config);
>   	free(user_config);
>   	free(repo_config);
> @@ -1762,6 +1763,9 @@ int config_with_options(config_fn_t fn, void *data,
>   		data = &inc;
>   	}
>   
> +	if (config_source)
> +		current_parsing_scope = config_source->scope;
> +
>   	/*
>   	 * If we have a specific filename, use it. Otherwise, follow the
>   	 * regular lookup sequence.
> @@ -3294,6 +3298,26 @@ const char *current_config_origin_type(void)
>   	}
>   }
>   
> +const char *config_scope_name(enum config_scope scope)
> +{
> +	switch (scope) {
> +	case CONFIG_SCOPE_SYSTEM:
> +		return "system";
> +	case CONFIG_SCOPE_GLOBAL:
> +		return "global";
> +	case CONFIG_SCOPE_LOCAL:
> +		return "local";
> +	case CONFIG_SCOPE_WORKTREE:
> +		return "worktree";
> +	case CONFIG_SCOPE_COMMAND:
> +		return "command";
> +	case CONFIG_SCOPE_SUBMODULE:
> +		return "submodule";
> +	default:
> +		return "unknown";
> +	}
> +}
> +
>   const char *current_config_name(void)
>   {
>   	const char *name;
> diff --git a/config.h b/config.h
> index f383a71404..fe0addb0dc 100644
> --- a/config.h
> +++ b/config.h
> @@ -35,10 +35,22 @@ struct object_id;
>   
>   #define CONFIG_REGEX_NONE ((void *)1)
>   
> +enum config_scope {
> +	CONFIG_SCOPE_UNKNOWN = 0,
> +	CONFIG_SCOPE_SYSTEM,
> +	CONFIG_SCOPE_GLOBAL,
> +	CONFIG_SCOPE_LOCAL,
> +	CONFIG_SCOPE_WORKTREE,
> +	CONFIG_SCOPE_COMMAND,
> +	CONFIG_SCOPE_SUBMODULE,
> +};
> +const char *config_scope_name(enum config_scope scope);
> +
>   struct git_config_source {
>   	unsigned int use_stdin:1;
>   	const char *file;
>   	const char *blob;
> +	enum config_scope scope;
>   };
>   
>   enum config_origin_type {
> @@ -294,15 +306,6 @@ int config_error_nonbool(const char *);
>   
>   int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
>   
> -enum config_scope {
> -	CONFIG_SCOPE_UNKNOWN = 0,
> -	CONFIG_SCOPE_SYSTEM,
> -	CONFIG_SCOPE_GLOBAL,
> -	CONFIG_SCOPE_LOCAL,
> -	CONFIG_SCOPE_WORKTREE,
> -	CONFIG_SCOPE_COMMAND,
> -};
> -
>   enum config_scope current_config_scope(void);
>   const char *current_config_origin_type(void);
>   const char *current_config_name(void);
> diff --git a/submodule-config.c b/submodule-config.c
> index 85064810b2..b8e97d8ae8 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -635,7 +635,9 @@ static void submodule_cache_check_init(struct repository *repo)
>   static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
>   {
>   	if (repo->worktree) {
> -		struct git_config_source config_source = { 0 };
> +		struct git_config_source config_source = {
> +			0, .scope = CONFIG_SCOPE_SUBMODULE
> +		};
>   		const struct config_options opts = { 0 };
>   		struct object_id oid;
>   		char *file;
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 56c1f6dfb6..1e3bc7c8f4 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -37,23 +37,6 @@
>    *
>    */
>   
> -static const char *scope_name(enum config_scope scope)
> -{
> -	switch (scope) {
> -	case CONFIG_SCOPE_SYSTEM:
> -		return "system";
> -	case CONFIG_SCOPE_GLOBAL:
> -		return "global";
> -	case CONFIG_SCOPE_LOCAL:
> -		return "local";
> -	case CONFIG_SCOPE_WORKTREE:
> -		return "worktree";
> -	case CONFIG_SCOPE_COMMAND:
> -		return "command";
> -	default:
> -		return "unknown";
> -	}
> -}
>   static int iterate_cb(const char *var, const char *value, void *data)
>   {
>   	static int nr;
> @@ -65,7 +48,7 @@ static int iterate_cb(const char *var, const char *value, void *data)
>   	printf("value=%s\n", value ? value : "(null)");
>   	printf("origin=%s\n", current_config_origin_type());
>   	printf("name=%s\n", current_config_name());
> -	printf("scope=%s\n", scope_name(current_config_scope()));
> +	printf("scope=%s\n", config_scope_name(current_config_scope()));
>   
>   	return 0;
>   }
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index e5fb9114f6..5464c46c18 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1771,6 +1771,65 @@ test_expect_success '--show-origin blob ref' '
>   	test_cmp expect output
>   '
>   
> +test_expect_success '--show-scope with --list' '
> +	cat >expect <<-EOF &&
> +	global	user.global=true
> +	global	user.override=global
> +	global	include.path=$INCLUDE_DIR/absolute.include
> +	global	user.absolute=include
> +	local	user.local=true
> +	local	user.override=local
> +	local	include.path=../include/relative.include
> +	local	user.relative=include
> +	command	user.cmdline=true
> +	EOF
> +	git -c user.cmdline=true config --list --show-scope >output &&
> +	test_cmp expect output
> +'
> +
> +test_expect_success !MINGW '--show-scope with --blob' '
> +	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
> +	cat >expect <<-EOF &&
> +	command	user.custom=true
> +	EOF
> +	git config --blob=$blob --show-scope --list >output &&
> +	test_cmp expect output
> +'
> +
> +test_expect_success '--show-scope with --local' '
> +	cat >expect <<-\EOF &&
> +	local	user.local=true
> +	local	user.override=local
> +	local	include.path=../include/relative.include
> +	EOF
> +	git config --local --list --show-scope >output &&
> +	test_cmp expect output
> +'
> +
> +test_expect_success '--show-scope getting a single value' '
> +	cat >expect <<-\EOF &&
> +	local	true
> +	EOF
> +	git config --show-scope --get user.local >output &&
> +	test_cmp expect output
> +'
> +
> +test_expect_success '--show-scope with --show-origin' '
> +	cat >expect <<-EOF &&
> +	global	file:$HOME/.gitconfig	user.global=true
> +	global	file:$HOME/.gitconfig	user.override=global
> +	global	file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
> +	global	file:$INCLUDE_DIR/absolute.include	user.absolute=include
> +	local	file:.git/config	user.local=true
> +	local	file:.git/config	user.override=local
> +	local	file:.git/config	include.path=../include/relative.include
> +	local	file:.git/../include/relative.include	user.relative=include
> +	command	command line:	user.cmdline=true
> +	EOF
> +	git -c user.cmdline=true config --list --show-origin --show-scope >output &&
> +	test_cmp expect output
> +'
> +
>   test_expect_success '--local requires a repo' '
>   	# we expect 128 to ensure that we do not simply
>   	# fail to find anything and return code "1"
> 
