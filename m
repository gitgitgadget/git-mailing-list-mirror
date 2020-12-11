Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216A7C4167B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 10:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D214A23ED0
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 10:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbgLKKQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 05:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgLKKQL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 05:16:11 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6760C061794
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 02:15:30 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id x16so11577053ejj.7
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 02:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ohZGqAKKlUxhaXNmwdqpQzpqCT6UoPPxj/q6PCVyzWc=;
        b=ezHH/q5KagCXqzpqSY5YcQwzHm3e5x5UXEzxdjXJ7mMQISeFRa/L3t3R85ssYIxOIZ
         3YnyJwJfvy+uIGGpWVwZtAI6lH8Ksi6luPwiwNXMQ14m/JnR6DNPVeJ7dlqxjGF09jbg
         oSboJhw3KBX0vJaYDOZvz0m2Rurf9eJcO3WCoVSTvFzfu6cTMVzmbGLjVTnLvFiEB+t3
         jEskbyzmyOStZkNlnjnCpe5uEaraOOFRLrlpLGZnMtF4swH7ELBHWueGPiuG2msqdf0B
         aq+v2fwRz0sHNhrVJqVNQSxivIB8hLD2wGaByxmGRlhn7cToOwSarSkDqWZeRR0sm8fE
         ycwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ohZGqAKKlUxhaXNmwdqpQzpqCT6UoPPxj/q6PCVyzWc=;
        b=goE08m6+f+McjTahgAQp9CT23eh5XIwWIjP7QTL+Q2XcMWZJZSAwbaLMZeHRFl9BCP
         BGuVNdhTQ26Nt6zGxdsx3SQAIbKCM/tGcjV0j+nQuT3JbH1xohh4GV5fpDg/V6F47gXW
         Axe22D5+6pGNLRc/6cMLDaPz0h99Z7V4F0wjS6V5myl+LidcJza8tbnk2eCjB576kl4L
         Y4VUZOZ8uHwimrLybi2ERPOsMj1IaveXQHwAK5MZuW/evK+hWnXdJ5eGjODuWjsdoq1O
         91S2Hr5lYJGjD55cdKfjweYyCNe9Le+bksD6Yes1214BAoMaxExPNh1OoF8UXIOHw0oW
         gbxQ==
X-Gm-Message-State: AOAM532xRu/P+qIAx8eI42GUlOThNOYSpuEvUL+2zdPwkIaODRJ46A94
        jZD/htqOxtEnPbLNTjFxSXcI/uycziU=
X-Google-Smtp-Source: ABdhPJxDFridzXNSSerlIZcflDgUMa1Z0lWzE+Sb0tQJ2gd885a1FjfnItJ0wm4GvgYGpxTN//6axg==
X-Received: by 2002:a17:906:4ec7:: with SMTP id i7mr10507469ejv.252.1607681728907;
        Fri, 11 Dec 2020 02:15:28 -0800 (PST)
Received: from [192.168.1.240] (87.22.198.146.dyn.plus.net. [146.198.22.87])
        by smtp.gmail.com with ESMTPSA id f17sm7285314edv.5.2020.12.11.02.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 02:15:28 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 08/17] hook: add 'run' subcommand
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20201205014607.1464119-1-emilyshaffer@google.com>
 <20201205014607.1464119-9-emilyshaffer@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <23cb3575-7706-45a6-7a50-0fc9ef850b9f@gmail.com>
Date:   Fri, 11 Dec 2020 10:15:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201205014607.1464119-9-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

On 05/12/2020 01:45, Emily Shaffer wrote:
> In order to enable hooks to be run as an external process, by a
> standalone Git command, or by tools which wrap Git, provide an external
> means to run all configured hook commands for a given hook event.
> 
> For now, the hook commands will run in config order, in series. As
> alternate ordering or parallelism is supported in the future, we should
> add knobs to use those to the command line as well.
> 
> As with the legacy hook implementation, all stdout generated by hook
> commands is redirected to stderr. Piping from stdin is not yet
> supported.
> 
> Legacy hooks (those present in $GITDIR/hooks) are run at the end of the
> execution list. For now, there is no way to disable them.
> 
> Users may wish to provide hook commands like 'git config
> hook.pre-commit.command "~/linter.sh --pre-commit"'. To enable this, the
> contents of the 'hook.*.command' and 'hookcmd.*.command' strings are
> first split by space or quotes into an argv_array, then expanded with
> 'expand_user_path()'.

I'm a bit confused by this last paragraph, the docs below say we pass 
the string to the shell and that's what the implementation seems to do. 
If we're running a lot of hooks then maybe it would be worth using 
split_cmdline() and expand_user_path() rather than invoking the shell 
for each hook we run.

I'm afraid I've only had time to skip the patch, there are a couple of 
minor comments below.

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> 
> Notes:
>      Since v4, updated the docs, and did less local application of single
>      quotes. In order for hookdir hooks to run successfully with a space in
>      the path, though, they must not be run with 'sh -c'. So we can treat the
>      hookdir hooks specially, and warn users via doc about special
>      considerations for configured hooks with spaces in their path.
> 
>   Documentation/git-hook.txt    |  31 +++++++++-
>   builtin/hook.c                |  48 ++++++++++++++-
>   hook.c                        | 112 ++++++++++++++++++++++++++++++++++
>   hook.h                        |  32 ++++++++++
>   t/t1360-config-based-hooks.sh |  65 +++++++++++++++++++-
>   5 files changed, 281 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> index f19875ed68..18a817d832 100644
> --- a/Documentation/git-hook.txt
> +++ b/Documentation/git-hook.txt
> @@ -9,11 +9,12 @@ SYNOPSIS
>   --------
>   [verse]
>   'git hook' list <hook-name>
> +'git hook' run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] <hook-name>
>   
>   DESCRIPTION
>   -----------
> -You can list configured hooks with this command. Later, you will be able to run,
> -add, and modify hooks with this command.
> +You can list and run configured hooks with this command. Later, you will be able
> +to add and modify hooks with this command.
>   
>   This command parses the default configuration files for sections `hook` and
>   `hookcmd`. `hook` is used to describe the commands which will be run during a
> @@ -64,6 +65,32 @@ in the order they should be run, and print the config scope where the relevant
>   `hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
>   This output is human-readable and the format is subject to change over time.
>   
> +run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] `<hook-name>`::
> +
> +Runs hooks configured for `<hook-name>`, in the same order displayed by `git
> +hook list`. Hooks configured this way are run prepended with `sh -c`, so paths
> +containing special characters or spaces should be wrapped in single quotes:
> +`command = '/my/path with spaces/script.sh' some args`.
> +
> +OPTIONS
> +-------
> +--run-hookdir::
> +	Overrides the hook.runHookDir config. Must be 'yes', 'warn',
> +	'interactive', or 'no'. Specifies how to handle hooks located in the Git
> +	hook directory (core.hooksPath).
> +
> +-a::
> +--arg::
> +	Only valid for `run`.
> ++
> +Specify arguments to pass to every hook that is run.
> +
> +-e::
> +--env::
> +	Only valid for `run`.
> ++
> +Specify environment variables to set for every hook that is run.
> +
>   CONFIGURATION
>   -------------
>   include::config/hook.txt[]
> diff --git a/builtin/hook.c b/builtin/hook.c
> index 16324d4195..26f7050387 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -5,9 +5,11 @@
>   #include "hook.h"
>   #include "parse-options.h"
>   #include "strbuf.h"
> +#include "strvec.h"
>   
>   static const char * const builtin_hook_usage[] = {
>   	N_("git hook list <hookname>"),
> +	N_("git hook run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] <hookname>"),
>   	NULL
>   };
>   
> @@ -84,6 +86,46 @@ static int list(int argc, const char **argv, const char *prefix)
>   	return 0;
>   }
>   
> +static int run(int argc, const char **argv, const char *prefix)
> +{
> +	struct strbuf hookname = STRBUF_INIT;
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +	int rc = 0;
> +
> +	struct option run_options[] = {
> +		OPT_STRVEC('e', "env", &opt.env, N_("var"),
> +			   N_("environment variables for hook to use")),
> +		OPT_STRVEC('a', "arg", &opt.args, N_("args"),
> +			   N_("argument to pass to hook")),
> +		OPT_END(),
> +	};
> +
> +	/*
> +	 * While it makes sense to list hooks out-of-repo, it doesn't make sense
> +	 * to execute them. Hooks usually want to look at repository artifacts.
> +	 */
> +	if (!have_git_dir())
> +		usage_msg_opt(_("You must be in a Git repo to execute hooks."),
> +			      builtin_hook_usage, run_options);
> +
> +	argc = parse_options(argc, argv, prefix, run_options,
> +			     builtin_hook_usage, 0);
> +
> +	if (argc < 1)
> +		usage_msg_opt(_("You must specify a hook event to run."),
> +			      builtin_hook_usage, run_options);
> +
> +	strbuf_addstr(&hookname, argv[0]);
> +	opt.run_hookdir = should_run_hookdir;
> +
> +	rc = run_hooks(hookname.buf, &opt);
> +
> +	strbuf_release(&hookname);
> +	run_hooks_opt_clear(&opt);
> +
> +	return rc;
> +}
> +
>   int cmd_hook(int argc, const char **argv, const char *prefix)
>   {
>   	const char *run_hookdir = NULL;
> @@ -95,10 +137,10 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
>   	};
>   
>   	argc = parse_options(argc, argv, prefix, builtin_hook_options,
> -			     builtin_hook_usage, 0);
> +			     builtin_hook_usage, PARSE_OPT_KEEP_UNKNOWN);
>   
>   	/* after the parse, we should have "<command> <hookname> <args...>" */
> -	if (argc < 1)
> +	if (argc < 2)
>   		usage_with_options(builtin_hook_usage, builtin_hook_options);
>   
>   
> @@ -120,6 +162,8 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
>   
>   	if (!strcmp(argv[0], "list"))
>   		return list(argc, argv, prefix);
> +	if (!strcmp(argv[0], "run"))
> +		return run(argc, argv, prefix);
>   
>   	usage_with_options(builtin_hook_usage, builtin_hook_options);
>   }
> diff --git a/hook.c b/hook.c
> index f4084e33c8..c4595a2324 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -3,6 +3,7 @@
>   #include "hook.h"
>   #include "config.h"
>   #include "run-command.h"
> +#include "prompt.h"
>   
>   void free_hook(struct hook *ptr)
>   {
> @@ -135,6 +136,56 @@ enum hookdir_opt configured_hookdir_opt(void)
>   	return hookdir_unknown;
>   }
>   
> +static int should_include_hookdir(const char *path, enum hookdir_opt cfg)
> +{
> +	struct strbuf prompt = STRBUF_INIT;
> +	/*
> +	 * If the path doesn't exist, don't bother adding the empty hook and
> +	 * don't bother checking the config or prompting the user.
> +	 */
> +	if (!path)
> +		return 0;
> +
> +	switch (cfg)
> +	{
> +		case hookdir_no:

Style nit: we normally use uppercase for constants and enums.

> +			return 0;
> +		case hookdir_unknown:
> +			fprintf(stderr,
> +				_("Unrecognized value for 'hook.runHookDir'. "
> +				  "Is there a typo? "));

What happens at the moment if core.hooksPath does not exist?

Best Wishes

Phillip

> +			/* FALLTHROUGH */
> +		case hookdir_warn:
> +			fprintf(stderr, _("Running legacy hook at '%s'\n"),
> +				path);
> +			return 1;
> +		case hookdir_interactive:
> +			do {
> +				/*
> +				 * TRANSLATORS: Make sure to include [Y] and [n]
> +				 * in your translation. Only English input is
> +				 * accepted. Default option is "yes".
> +				 */
> +				fprintf(stderr, _("Run '%s'? [Yn] "), path);
> +				git_read_line_interactively(&prompt);
> +				strbuf_tolower(&prompt);
> +				if (starts_with(prompt.buf, "n")) {
> +					strbuf_release(&prompt);
> +					return 0;
> +				} else if (starts_with(prompt.buf, "y")) {
> +					strbuf_release(&prompt);
> +					return 1;
> +				}
> +				/* otherwise, we didn't understand the input */
> +			} while (prompt.len); /* an empty reply means "Yes" */
> +			strbuf_release(&prompt);
> +			return 1;
> +		case hookdir_yes:
> +		default:
> +			return 1;
> +	}
> +}
> +
>   struct list_head* hook_list(const struct strbuf* hookname)
>   {
>   	struct strbuf hook_key = STRBUF_INIT;
> @@ -166,3 +217,64 @@ struct list_head* hook_list(const struct strbuf* hookname)
>   	strbuf_release(&hook_key);
>   	return hook_head;
>   }
> +
> +void run_hooks_opt_init(struct run_hooks_opt *o)
> +{
> +	strvec_init(&o->env);
> +	strvec_init(&o->args);
> +	o->run_hookdir = configured_hookdir_opt();
> +}
> +
> +void run_hooks_opt_clear(struct run_hooks_opt *o)
> +{
> +	strvec_clear(&o->env);
> +	strvec_clear(&o->args);
> +}
> +
> +int run_hooks(const char *hookname, struct run_hooks_opt *options)
> +{
> +	struct strbuf hookname_str = STRBUF_INIT;
> +	struct list_head *to_run, *pos = NULL, *tmp = NULL;
> +	int rc = 0;
> +
> +	if (!options)
> +		BUG("a struct run_hooks_opt must be provided to run_hooks");
> +
> +	strbuf_addstr(&hookname_str, hookname);
> +
> +	to_run = hook_list(&hookname_str);
> +
> +	list_for_each_safe(pos, tmp, to_run) {
> +		struct child_process hook_proc = CHILD_PROCESS_INIT;
> +		struct hook *hook = list_entry(pos, struct hook, list);
> +
> +		hook_proc.env = options->env.v;
> +		hook_proc.no_stdin = 1;
> +		hook_proc.stdout_to_stderr = 1;
> +		hook_proc.trace2_hook_name = hook->command.buf;
> +		hook_proc.use_shell = 1;
> +
> +		if (hook->from_hookdir) {
> +		    if (!should_include_hookdir(hook->command.buf, options->run_hookdir))
> +			continue;
> +		    /*
> +		     * Commands from the config could be oneliners, but we know
> +		     * for certain that hookdir commands are not.
> +		     */
> +		    hook_proc.use_shell = 0;
> +		}
> +
> +		/* add command */
> +		strvec_push(&hook_proc.args, hook->command.buf);
> +
> +		/*
> +		 * add passed-in argv, without expanding - let the user get back
> +		 * exactly what they put in
> +		 */
> +		strvec_pushv(&hook_proc.args, options->args.v);
> +
> +		rc |= run_command(&hook_proc);
> +	}
> +
> +	return rc;
> +}
> diff --git a/hook.h b/hook.h
> index ca45d388d3..d1c3d71e82 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -1,6 +1,7 @@
>   #include "config.h"
>   #include "list.h"
>   #include "strbuf.h"
> +#include "strvec.h"
>   
>   struct hook
>   {
> @@ -36,6 +37,37 @@ enum hookdir_opt
>    */
>   enum hookdir_opt configured_hookdir_opt(void);
>   
> +struct run_hooks_opt
> +{
> +	/* Environment vars to be set for each hook */
> +	struct strvec env;
> +
> +	/* Args to be passed to each hook */
> +	struct strvec args;
> +
> +	/*
> +	 * How should the hookdir be handled?
> +	 * Leave the RUN_HOOKS_OPT_INIT default in most cases; this only needs
> +	 * to be overridden if the user can override it at the command line.
> +	 */
> +	enum hookdir_opt run_hookdir;
> +};
> +
> +#define RUN_HOOKS_OPT_INIT  {   		\
> +	.env = STRVEC_INIT, 				\
> +	.args = STRVEC_INIT, 			\
> +	.run_hookdir = configured_hookdir_opt()	\
> +}
> +
> +void run_hooks_opt_init(struct run_hooks_opt *o);
> +void run_hooks_opt_clear(struct run_hooks_opt *o);
> +
> +/*
> + * Runs all hooks associated to the 'hookname' event in order. Each hook will be
> + * passed 'env' and 'args'.
> + */
> +int run_hooks(const char *hookname, struct run_hooks_opt *options);
> +
>   /* Free memory associated with a 'struct hook' */
>   void free_hook(struct hook *ptr);
>   /* Empties the list at 'head', calling 'free_hook()' on each entry */
> diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
> index ebd3bc623f..5b3003d59b 100755
> --- a/t/t1360-config-based-hooks.sh
> +++ b/t/t1360-config-based-hooks.sh
> @@ -115,7 +115,10 @@ test_expect_success 'hook.runHookDir = no is respected by list' '
>   
>   	git hook list pre-commit >actual &&
>   	# the hookdir annotation is translated
> -	test_i18ncmp expected actual
> +	test_i18ncmp expected actual &&
> +
> +	git hook run pre-commit 2>actual &&
> +	test_must_be_empty actual
>   '
>   
>   test_expect_success 'hook.runHookDir = warn is respected by list' '
> @@ -129,6 +132,14 @@ test_expect_success 'hook.runHookDir = warn is respected by list' '
>   
>   	git hook list pre-commit >actual &&
>   	# the hookdir annotation is translated
> +	test_i18ncmp expected actual &&
> +
> +	cat >expected <<-EOF &&
> +	Running legacy hook at '\''$(pwd)/.git/hooks/pre-commit'\''
> +	"Legacy Hook"
> +	EOF
> +
> +	git hook run pre-commit 2>actual &&
>   	test_i18ncmp expected actual
>   '
>   
> @@ -156,7 +167,7 @@ test_expect_success 'git hook list removes skipped inlined hook' '
>   	test_cmp expected actual
>   '
>   
> -test_expect_success 'hook.runHookDir = interactive is respected by list' '
> +test_expect_success 'hook.runHookDir = interactive is respected by list and run' '
>   	setup_hookdir &&
>   
>   	test_config hook.runHookDir "interactive" &&
> @@ -167,7 +178,55 @@ test_expect_success 'hook.runHookDir = interactive is respected by list' '
>   
>   	git hook list pre-commit >actual &&
>   	# the hookdir annotation is translated
> -	test_i18ncmp expected actual
> +	test_i18ncmp expected actual &&
> +
> +	test_write_lines n | git hook run pre-commit 2>actual &&
> +	! grep "Legacy Hook" actual &&
> +
> +	test_write_lines y | git hook run pre-commit 2>actual &&
> +	grep "Legacy Hook" actual
> +'
> +
> +test_expect_success 'inline hook definitions execute oneliners' '
> +	test_config hook.pre-commit.command "echo \"Hello World\"" &&
> +
> +	echo "Hello World" >expected &&
> +
> +	# hooks are run with stdout_to_stderr = 1
> +	git hook run pre-commit 2>actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'inline hook definitions resolve paths' '
> +	write_script sample-hook.sh <<-EOF &&
> +	echo \"Sample Hook\"
> +	EOF
> +
> +	test_when_finished "rm sample-hook.sh" &&
> +
> +	test_config hook.pre-commit.command "\"$(pwd)/sample-hook.sh\"" &&
> +
> +	echo \"Sample Hook\" >expected &&
> +
> +	# hooks are run with stdout_to_stderr = 1
> +	git hook run pre-commit 2>actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'hookdir hook included in git hook run' '
> +	setup_hookdir &&
> +
> +	echo \"Legacy Hook\" >expected &&
> +
> +	# hooks are run with stdout_to_stderr = 1
> +	git hook run pre-commit 2>actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'out-of-repo runs excluded' '
> +	setup_hooks &&
> +
> +	nongit test_must_fail git hook run pre-commit
>   '
>   
>   test_done
> 
