Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A836EC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8129861181
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbhJOQ03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhJOQ02 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:26:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB99AC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:24:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g14so8825307pfm.1
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W831v1YM/QV8kaVpumuDlHXjSedjJ3lW+jBzQQpCtSg=;
        b=tM6xL/wO/JjaCQk47f6q/DdT8erk09JHpbctwGlmsJPgDDDE84hDXhZDvBgOby7D1t
         hBIJKWy8q5kLN/HFqhI8YB4n6BapMzPk3hT8+YQ8baqNfOx1F8Lochx30GkVHdDKon/e
         /jQUE9A0SBDQ7eKhfZ9xtxhOhtV5oArRIeHo3Bsonw0DBoGmPsnFdB73+m99QmB+MHEQ
         LmTPytp+xbRof6ymPpCAmJiT/zGl3rU5DRSU7kimBuamrrH47U7kMs3K7Dn9eo6g7OPx
         P4osQboQh12xrYL+86/DC0h0UGBMYUmwz+bsGhy6G67zHfM07T8VG5L0Gs1NipaelEFF
         0jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W831v1YM/QV8kaVpumuDlHXjSedjJ3lW+jBzQQpCtSg=;
        b=NTPcrPmI9bDOqVGuLUW7BtE0Q5EAc1zkW7Y3DeNnw6eam8LA/0msvmqbmGN1/NshxK
         30tWBnPR51sKay2fvv+wz9z9xGCPdmHO+p8aPj0Wzxv4IeYVmNaZYvsu6zm3kyX0z4OQ
         rx7oZBtFmwAfizmSwavnTF9MO8a5aRXPff4sqQ5vmPF/MuZKRV5XleAbnYoHuluBrqyR
         BghMIbsRRvxWMuleUtPub8vY8BIZFghYrCizaWycMh2MGB+qZ+lX+wRB/okq3Cg29Zz2
         hT9qT6P1ZDGJuC2cnA7KIZFamc3Vl/QxajmE6RNZb5DYOx5b6Z/tl+wsdESHnDXr1Cls
         qiaw==
X-Gm-Message-State: AOAM5311LRF9EE86YujYQMhlQvc+4JiAYvUuVA0BzHvto66+rUy1errB
        WnsE1QNOpT7t3lVFDSxJvZKuEw==
X-Google-Smtp-Source: ABdhPJxSgm6hqP9hR9oNq4dnM8rOi7mK06IspwgqpWjKKY5Khj9wgMtQ1Tmt5hKJKSPQy2xBVIP4qg==
X-Received: by 2002:a62:d11e:0:b0:446:d705:7175 with SMTP id z30-20020a62d11e000000b00446d7057175mr12857096pfg.74.1634315061033;
        Fri, 15 Oct 2021 09:24:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id o14sm5430990pfh.145.2021.10.15.09.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:24:20 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:24:15 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 01/13] hook: add 'run' subcommand
Message-ID: <YWmrL/POUE8P8Od1@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-01.13-ba64faf0580-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-01.13-ba64faf0580-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 03:30:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> In order to enable hooks to be run as an external process, by a
> standalone Git command, or by tools which wrap Git, provide an external
> means to run all configured hook commands for a given hook event.
> 
> Most of our hooks require more complex functionality than this, but
> let's start with the bare minimum required to support our simplest
> hooks.
> 
> In terms of implementation the usage_with_options() and "goto usage"
> pattern here mirrors that of
> builtin/{commit-graph,multi-pack-index}.c.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> new file mode 100644
> index 00000000000..660d6a992a0
> --- /dev/null
> +++ b/Documentation/git-hook.txt
> @@ -0,0 +1,38 @@
> +git-hook(1)
> +===========
> +
> +NAME
> +----
> +git-hook - run git hooks
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git hook' run <hook-name> [-- <hook-args>]
> +
> +DESCRIPTION
> +-----------
> +
> +This command is an interface to git hooks (see linkgit:githooks[5]).
> +Currently it only provides a convenience wrapper for running hooks for
> +use by git itself. In the future it might gain other functionality.

s/git/Git/g nit, no? I thought we were somewhat picky about capitalizing Git
when we don't mean `git`?

> +
> +SUBCOMMANDS
> +-----------
> +
> +run::
> +	Run the `<hook-name>` hook. See linkgit:githooks[5] for
> +	the hook names we support.
> ++
> +Any positional arguments to the hook should be passed after an
> +optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
> +arguments (if any) differ by hook name, see linkgit:githooks[5] for
> +what those are.
> +
> +SEE ALSO
> +--------
> +linkgit:githooks[5]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite

> diff --git a/builtin/hook.c b/builtin/hook.c
> new file mode 100644
> index 00000000000..012a2973b38
> --- /dev/null
> +++ b/builtin/hook.c
> @@ -0,0 +1,90 @@
> +#include "cache.h"
> +#include "builtin.h"
> +#include "config.h"
> +#include "hook.h"
> +#include "parse-options.h"
> +#include "strbuf.h"
> +#include "strvec.h"
> +
> +#define BUILTIN_HOOK_RUN_USAGE \
> +	N_("git hook run <hook-name> [-- <hook-args>]")
> +
> +static const char * const builtin_hook_usage[] = {
> +	BUILTIN_HOOK_RUN_USAGE,
> +	NULL
> +};
> +
> +static const char * const builtin_hook_run_usage[] = {
> +	BUILTIN_HOOK_RUN_USAGE,
> +	NULL
> +};

While some reviewers might think this looks untidy, it does save us some
repetition later on adding other subcommands to 'git hook'. Thanks.

> +
> +static int run(int argc, const char **argv, const char *prefix)
> +{
> +	int i;
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +	const char *hook_name;
> +	const char *hook_path;
> +	struct option run_options[] = {
> +		OPT_END(),
> +	};
> +	int ret;
> +
> +	argc = parse_options(argc, argv, prefix, run_options,
> +			     builtin_hook_run_usage,
> +			     PARSE_OPT_KEEP_DASHDASH);

We KEEP_DASHDASH so we can ensure someone did not send us some args they meant
for 'git hook' instead of for the hook script itself. Ok.

> +
> +	if (!argc)
> +		goto usage;
> +
> +	/*
> +	 * Having a -- for "run" when providing <hook-args> is
> +	 * mandatory.
> +	 */
> +	if (argc > 1 && strcmp(argv[1], "--") &&
> +	    strcmp(argv[1], "--end-of-options"))

--end-of-options isn't documented anywhere, right? Fine, I don't mind, but it's
interesting to support it "secretly".

> +		goto usage;
> +
> +	/* Add our arguments, start after -- */
> +	for (i = 2 ; i < argc; i++)
> +		strvec_push(&opt.args, argv[i]);
> +
> +	/* Need to take into account core.hooksPath */
> +	git_config(git_default_config, NULL);

..and git_default_config() sets it up for use in find_hook(). Great.

> +
> +	/*
> +	 * We are not using a plain run_hooks() because we'd like to
> +	 * detect missing hooks. Let's find it ourselves and call
> +	 * run_hooks() instead.
> +	 */

Hmm. In practice, I wonder if this means that callers like 'git-send-email' still
need to check whether there is a 'sendemail-validate' hook before they can call
'git hook run sendemail-validate'? I guess I'll have a look at the work there
and see.

> +	hook_name = argv[0];
> +	hook_path = find_hook(hook_name);
> +	if (!hook_path) {
> +		error("cannot find a hook named %s", hook_name);
> +		return 1;
> +	}
> +
> +	ret = run_hooks(hook_name, hook_path, &opt);
> +	run_hooks_opt_clear(&opt);
> +	return ret;
> +usage:
> +	usage_with_options(builtin_hook_run_usage, run_options);
> +}
> +
> +int cmd_hook(int argc, const char **argv, const char *prefix)
> +{
> +	struct option builtin_hook_options[] = {
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, NULL, builtin_hook_options,
> +			     builtin_hook_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> +	if (!argc)
> +		goto usage;
> +
> +	if (!strcmp(argv[0], "run"))
> +		return run(argc, argv, prefix);
> +
> +usage:
> +	usage_with_options(builtin_hook_usage, builtin_hook_options);
> +}

The rest of it is very straightforward boilerplate for a builtin. Thanks.


> diff --git a/command-list.txt b/command-list.txt
> index a289f09ed6f..9ccd8e5aebe 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -103,6 +103,7 @@ git-grep                                mainporcelain           info
>  git-gui                                 mainporcelain
>  git-hash-object                         plumbingmanipulators
>  git-help                                ancillaryinterrogators          complete
> +git-hook                                mainporcelain
>  git-http-backend                        synchingrepositories
>  git-http-fetch                          synchelpers
>  git-http-push                           synchelpers
> diff --git a/git.c b/git.c
> index 60c2784be45..e5891e02021 100644
> --- a/git.c
> +++ b/git.c
> @@ -538,6 +538,7 @@ static struct cmd_struct commands[] = {
>  	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
>  	{ "hash-object", cmd_hash_object },
>  	{ "help", cmd_help },
> +	{ "hook", cmd_hook, RUN_SETUP },

Ok. For now this is still requiring a gitdir. That makes sense to me, because
we are still getting our hooks from $GITDIR/hooks/. Fine.

>  	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
>  	{ "init", cmd_init_db },
>  	{ "init-db", cmd_init_db },
> diff --git a/hook.c b/hook.c
> index 55e1145a4b7..240270db64e 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "hook.h"
>  #include "run-command.h"
> +#include "config.h"
>  
>  const char *find_hook(const char *name)
>  {
> @@ -40,3 +41,103 @@ int hook_exists(const char *name)
>  {
>  	return !!find_hook(name);
>  }
> +
> +void run_hooks_opt_clear(struct run_hooks_opt *o)
> +{
> +	strvec_clear(&o->env);
> +	strvec_clear(&o->args);
> +}
> +
> +static int pick_next_hook(struct child_process *cp,
> +			  struct strbuf *out,
> +			  void *pp_cb,
> +			  void **pp_task_cb)
> +{
> +	struct hook_cb_data *hook_cb = pp_cb;
> +	struct hook *run_me = hook_cb->run_me;
> +
> +	if (!run_me)
> +		return 0;

Signal the run_processes_parallel() machinery if we don't have any hooks left
to run. Right now the linked list is always going to be of size 1, but that's
ok :)

> +
> +	cp->no_stdin = 1;
> +	cp->env = hook_cb->options->env.v;
> +	cp->stdout_to_stderr = 1;
> +	cp->trace2_hook_name = hook_cb->hook_name;

These args match identically the ones set up in run_hook_ve. Ok.

> +
> +	/* add command */
> +	strvec_push(&cp->args, run_me->hook_path);
> +
> +	/*
> +	 * add passed-in argv, without expanding - let the user get back
> +	 * exactly what they put in
> +	 */
> +	strvec_pushv(&cp->args, hook_cb->options->args.v);
> +
> +	/* Provide context for errors if necessary */
> +	*pp_task_cb = run_me;
> +
> +	/*
> +	 * This pick_next_hook() will be called again, we're only
> +	 * running one hook, so indicate that no more work will be
> +	 * done.
> +	 */
> +	hook_cb->run_me = NULL;
> +
> +	return 1;
> +}
> +
> +static int notify_start_failure(struct strbuf *out,
> +				void *pp_cb,
> +				void *pp_task_cp)
> +{
> +	struct hook_cb_data *hook_cb = pp_cb;
> +	struct hook *attempted = pp_task_cp;
> +
> +	hook_cb->rc |= 1;

The OR means this will continue to work if the list of hooks is greater than 1.
Ok.

> +
> +	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
> +		    attempted->hook_path);
> +
> +	return 1;

By returning 1, we ask the run_processes_parallel() machinery to give up on
the rest of the hooks. I think that is okay, because the Git operation will not
complete successfully anyway, and because "failed to start process" has more
serious implications for Git's ability to continue starting tasks, compared to
a hook validation failure. Ok.

> +}
> +
> +static int notify_hook_finished(int result,
> +				struct strbuf *out,
> +				void *pp_cb,
> +				void *pp_task_cb)
> +{
> +	struct hook_cb_data *hook_cb = pp_cb;
> +
> +	hook_cb->rc |= result;
> +
> +	return 0;

Conversely, here we could decide to terminate the task list early if we heard
an unhappy hook's return code. However, it's probably more useful for a user
to hear *all* the reasons that their operation failed, rather than just one,
so they don't need to rerun their commit operation 5 times for 5 different hook
failures... :) Fine.

> +}
> +
> +int run_hooks(const char *hook_name, const char *hook_path,
> +	      struct run_hooks_opt *options)
> +{
> +	struct hook my_hook = {
> +		.hook_path = hook_path,
> +	};
> +	struct hook_cb_data cb_data = {
> +		.rc = 0,
> +		.hook_name = hook_name,
> +		.options = options,
> +	};
> +	int jobs = 1;

Even though this is a constant, I find the throwaway variable easier to read
than using a magic 1 in the run_processes_parallel call. I imagine the compiler
gets rid of it, anyways. Thanks.

> +
> +	if (!options)
> +		BUG("a struct run_hooks_opt must be provided to run_hooks");
> +
> +	cb_data.run_me = &my_hook;
> +
> +	run_processes_parallel_tr2(jobs,
> +				   pick_next_hook,
> +				   notify_start_failure,
> +				   notify_hook_finished,
> +				   &cb_data,
> +				   "hook",
> +				   hook_name);
> +
> +	return cb_data.rc;
> +}
> diff --git a/hook.h b/hook.h
> index 6aa36fc7ff9..111c5cf9296 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -1,5 +1,33 @@
>  #ifndef HOOK_H
>  #define HOOK_H
> +#include "strvec.h"
> +
> +struct hook {
> +	/* The path to the hook */
> +	const char *hook_path;
> +};
> +
> +struct run_hooks_opt
> +{
> +	/* Environment vars to be set for each hook */
> +	struct strvec env;
> +
> +	/* Args to be passed to each hook */
> +	struct strvec args;
> +};
> +
> +#define RUN_HOOKS_OPT_INIT { \
> +	.env = STRVEC_INIT, \
> +	.args = STRVEC_INIT, \
> +}
> +
> +struct hook_cb_data {
> +	/* rc reflects the cumulative failure state */
> +	int rc;
> +	const char *hook_name;
> +	struct hook *run_me;
> +	struct run_hooks_opt *options;
> +};
>  
>  /*
>   * Returns the path to the hook file, or NULL if the hook is missing
> @@ -13,4 +41,15 @@ const char *find_hook(const char *name);
>   */
>  int hook_exists(const char *hookname);
>  
> +/**
> + * Clear data from an initialized "struct run_hooks-opt".
Nit, s/run_hooks-opt/run_hooks_opt/
> + */
> +void run_hooks_opt_clear(struct run_hooks_opt *o);
> +
> +/**
> + * Takes an already resolved hook found via find_hook() and runs
> + * it. Does not call run_hooks_opt_clear() for you.
> + */
> +int run_hooks(const char *hookname, const char *hook_path,
> +	      struct run_hooks_opt *options);
>  #endif
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> new file mode 100755
> index 00000000000..3aea1b105f0
> --- /dev/null
> +++ b/t/t1800-hook.sh
> @@ -0,0 +1,129 @@
> +#!/bin/sh
> +
> +test_description='git-hook command'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
> +. ./test-lib.sh
> +
> +test_expect_success 'git hook usage' '
> +	test_expect_code 129 git hook &&
> +	test_expect_code 129 git hook run &&
> +	test_expect_code 129 git hook run -h &&
> +	test_expect_code 129 git hook run --unknown 2>err &&
> +	grep "unknown option" err
> +'
> +
> +test_expect_success 'git hook run: nonexistent hook' '
> +	cat >stderr.expect <<-\EOF &&
> +	error: cannot find a hook named test-hook
> +	EOF
> +	test_expect_code 1 git hook run test-hook 2>stderr.actual &&
> +	test_cmp stderr.expect stderr.actual

See my earlier worry about this meaning callers still have to check the hookdir.

> +'
> +
> +test_expect_success 'git hook run: basic' '
> +	write_script .git/hooks/test-hook <<-EOF &&
> +	echo Test hook
> +	EOF
> +
> +	cat >expect <<-\EOF &&
> +	Test hook
> +	EOF
> +	git hook run test-hook 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git hook run: stdout and stderr both write to our stderr' '
> +	write_script .git/hooks/test-hook <<-EOF &&
> +	echo >&1 Will end up on stderr
> +	echo >&2 Will end up on stderr
> +	EOF
> +
> +	cat >stderr.expect <<-\EOF &&
> +	Will end up on stderr
> +	Will end up on stderr
> +	EOF
> +	git hook run test-hook >stdout.actual 2>stderr.actual &&
> +	test_cmp stderr.expect stderr.actual &&
> +	test_must_be_empty stdout.actual
> +'
> +
> +test_expect_success 'git hook run: exit codes are passed along' '
> +	write_script .git/hooks/test-hook <<-EOF &&
> +	exit 1
> +	EOF
> +
> +	test_expect_code 1 git hook run test-hook &&
> +
> +	write_script .git/hooks/test-hook <<-EOF &&
> +	exit 2
> +	EOF
> +
> +	test_expect_code 2 git hook run test-hook &&
> +
> +	write_script .git/hooks/test-hook <<-EOF &&
> +	exit 128
> +	EOF
> +
> +	test_expect_code 128 git hook run test-hook &&
> +
> +	write_script .git/hooks/test-hook <<-EOF &&
> +	exit 129
> +	EOF
> +
> +	test_expect_code 129 git hook run test-hook
> +'
> +
> +test_expect_success 'git hook run arg u ments without -- is not allowed' '
> +	test_expect_code 129 git hook run test-hook arg u ments
> +'
> +
> +test_expect_success 'git hook run -- pass arguments' '
> +	write_script .git/hooks/test-hook <<-\EOF &&
> +	echo $1
> +	echo $2
> +	EOF
> +
> +	cat >expect <<-EOF &&
> +	arg
> +	u ments
> +	EOF
> +
> +	git hook run test-hook -- arg "u ments" 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git hook run -- out-of-repo runs excluded' '
> +	write_script .git/hooks/test-hook <<-EOF &&
> +	echo Test hook
> +	EOF
> +
> +	nongit test_must_fail git hook run test-hook
> +'
> +
> +test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
> +	mkdir my-hooks &&
> +	write_script my-hooks/test-hook <<-\EOF &&
> +	echo Hook ran $1 >>actual
> +	EOF
> +
> +	cat >expect <<-\EOF &&
> +	Test hook
> +	Hook ran one
> +	Hook ran two
> +	Hook ran three
> +	Hook ran four
> +	EOF
> +
> +	# Test various ways of specifying the path. See also
> +	# t1350-config-hooks-path.sh
> +	>actual &&
> +	git hook run test-hook -- ignored 2>>actual &&
> +	git -c core.hooksPath=my-hooks hook run test-hook -- one 2>>actual &&
> +	git -c core.hooksPath=my-hooks/ hook run test-hook -- two 2>>actual &&
> +	git -c core.hooksPath="$PWD/my-hooks" hook run test-hook -- three 2>>actual &&
> +	git -c core.hooksPath="$PWD/my-hooks/" hook run test-hook -- four 2>>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> -- 
> 2.33.0.1567.g7b23ce7ed9e

Thanks. Other than my concern about erroring when there is no hook executable,
it looks fine - but that one is serious enough that I'll withhold the
Reviewed-by line.
