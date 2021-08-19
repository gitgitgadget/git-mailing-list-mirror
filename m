Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C80EC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 23:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B456108F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 23:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhHSXlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 19:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhHSXlA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 19:41:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BC4C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 16:40:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso12570635pjb.2
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 16:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Vm6ulgeFS8Td8QRT5eh9ESOiTEOTTFqPKbUltZsb9B4=;
        b=TZ7EOceCD1jm4FZzxV/EHLiEWa/y5t2YfmYdYmanS9sZ6O3L0Qywyc0lMVsYgbjinD
         ptfoBlk3a2YixBfUAie581hdXsl2UJbRwRx7Pz4YoSmJHl1Ixu3G8LkkfET6HvQgZ7bt
         ybS6Dsbu/8bUVznycyu0xreMPNWSmUS0UK8vIsCffjX6wA7+rsZWeu8nOfitGrklAY2H
         b+CSreXCfEIzP+dyPym834I9089FLLMvdqAJ6zsxUNByy8z8kooGq332PxaziBulx9sY
         A7Nce0i89T0HIb7mZ6WmY1I7ZXBIKGJfWvMHyyXCxD6A7Z17PrjM/R0+rfMPyouzB+jp
         Azlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vm6ulgeFS8Td8QRT5eh9ESOiTEOTTFqPKbUltZsb9B4=;
        b=hY9v/D3ayI5P9AMahZRwmjoNDHJVToJmeIqDN8FQxUYefYS63Lm5B3OeYryV3fjLKa
         rs+CSQH947h7sX2YnG9s4/T8Wi3Q/OMsNcETwFKMuZVTbzw7sw4r7jKYv6pheLDXuxiY
         oNlEKHtE6qt+fTLbC3T+n6dcPx7gRHz2xlxUedSGRg0W1x4RQ+/fkl9/VsiA2eDl4DhD
         RjpDkTS7bWOj9VUvhFc8CL/kIkpX546fBE04Suh+LkwPXmPjVD14cC9ger8sekGyU5bT
         M5Px7aL2ZD9Pzs7IVWFK3mCs1XUExgzCKBNeUD98nxreMVUXq2adHJfvGEq5guYgsTSK
         8iVQ==
X-Gm-Message-State: AOAM531ZnDq5vG3ertqzxyf8Sk7lCLqwp0ClVlXQh9IrN6FoOEtQWlda
        LDZXxeiyMx3HjLGl50JHo11SMA==
X-Google-Smtp-Source: ABdhPJynijYv1MF1X0+xOJmSUKL8EhCXBUaM24nBEszMx7vQoJgbdAxwe/AogRwsHNHBz9mfTbox8Q==
X-Received: by 2002:a17:90b:4b0b:: with SMTP id lx11mr1436748pjb.70.1629416422933;
        Thu, 19 Aug 2021 16:40:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
        by smtp.gmail.com with ESMTPSA id c24sm5694175pgj.11.2021.08.19.16.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 16:40:22 -0700 (PDT)
Date:   Thu, 19 Aug 2021 16:40:14 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 00/36] Run hooks via "git run hook" & hook library
Message-ID: <YR7r3h1AG4Zyn7x7@google.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 09:38:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> This is a v4 re-roll of the "Base for "config-based-hooks" topic.
>  * Almost all the callers were just "one-shot" callers, I introduced a
>    new run_hooks_oneshot() function for those, which gets rid of the
>    verbosity around memory management, see e.g. the "builtin/gc.c" in
>    the range-diff below. That run_hooks_oneshot() can also take a NULL
>    set of options.

I discussed this elswhere, but just to make doubly sure that comment
doesn't get lost, here's a link to my mail:
https://lore.kernel.org/git/YR2jLdYQA5CVzX5h%40google.com

> Range-diff against v3:
>  1:  27c94247f87 =  1:  81fe1ed90d5 Makefile: mark "check" target as .PHONY
>  2:  6e164edb0b0 !  2:  0f749530777 Makefile: stop hardcoding {command,config}-list.h
>  3:  ddae86802e2 !  3:  644b31fe281 Makefile: remove an out-of-date comment
>  4:  58c37e4f06e =  4:  89c4d44b0c3 hook.[ch]: move find_hook() to this new library
>  5:  0cf7e078ef4 =  5:  3514e0c0251 hook.c: add a hook_exists() wrapper and use it in bugreport.c
>  -:  ----------- >  6:  d5ef40f77dc hook.c users: use "hook_exists()" insted of "find_hook()"
>  6:  f343fc7ae66 !  7:  4cfd72722c1 hook-list.h: add a generated list of hooks, like config-list.h

Since these 6 were broken out and then brought back into this series,
I'll review them individually downthread.

>  7:  cf4b06bfdf8 !  8:  7cb4a4cb69e hook: add 'run' subcommand
>     @@ builtin/hook.c (new)
>      +#include "strbuf.h"
>      +#include "strvec.h"
>      +
>     ++#define BUILTIN_HOOK_RUN_USAGE \
>     ++	N_("git hook run <hook-name> [-- <hook-args>]")
>     ++

Nice, now we avoid string duplication here...

>      +static const char * const builtin_hook_usage[] = {
>     -+	N_("git hook <command> [...]"),

...and there is no point including this vague thing that has a more
specific description right after. Ok.

>     -+	N_("git hook run <hook-name> [-- <hook-args>]"),
>     ++	BUILTIN_HOOK_RUN_USAGE,
>      +	NULL
>      +};
[...]
>     @@ builtin/hook.c (new)
>      +{
>      +	int i;
>      +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>     -+	int rc = 0;
>      +	const char *hook_name;
>      +	const char *hook_path;
>     -+
>      +	struct option run_options[] = {
>      +		OPT_END(),
>      +	};
>     ++	int ret;
>      +
>      +	argc = parse_options(argc, argv, prefix, run_options,
>      +			     builtin_hook_run_usage,
>     -+			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
>     -+
>     -+	if (argc > 1) {
>     -+		if (strcmp(argv[1], "--") &&
>     -+		    strcmp(argv[1], "--end-of-options"))
>     -+			/* Having a -- for "run" is mandatory */
>     -+			usage_with_options(builtin_hook_usage, run_options);
>     -+		/* Add our arguments, start after -- */
>     -+		for (i = 2 ; i < argc; i++)
>     -+			strvec_push(&opt.args, argv[i]);
>     -+	}
>     ++			     PARSE_OPT_KEEP_DASHDASH);

Nice - this code is being broken up and moved later.

>      +
>     -+	/* Need to take into account core.hooksPath */
>     -+	git_config(git_default_config, NULL);
>     ++	if (!argc)
>     ++		goto usage;
>      +
>      +	/*
>     -+	 * We are not using run_hooks() because we'd like to detect
>     -+	 * missing hooks. Let's find it ourselves and call
>     -+	 * run_found_hooks() instead.

This comment disappears entirely. I am not too terribly upset about it,
since this behavior changes in my series anyway, but it seems like it
might have been an accident?

>     ++	 * Having a -- for "run" when providing <hook-args> is
>     ++	 * mandatory.
>      +	 */
>     ++	if (argc > 1 && strcmp(argv[1], "--") &&
>     ++	    strcmp(argv[1], "--end-of-options"))
>     ++		goto usage;
>     ++
>     ++	/* Add our arguments, start after -- */
>     ++	for (i = 2 ; i < argc; i++)
>     ++		strvec_push(&opt.args, argv[i]);
>     ++
>     ++	/* Need to take into account core.hooksPath */
>     ++	git_config(git_default_config, NULL);
>     ++
>      +	hook_name = argv[0];
>      +	hook_path = find_hook(hook_name);
>      +	if (!hook_path) {
>      +		error("cannot find a hook named %s", hook_name);
>      +		return 1;
>      +	}
>     -+	rc = run_found_hooks(hook_name, hook_path, &opt);
>      +
>     ++	ret = run_hooks(hook_name, hook_path, &opt);
>      +	run_hooks_opt_clear(&opt);
>     -+
>     -+	return rc;
>     ++	return ret;
>     ++usage:
>     ++	usage_with_options(builtin_hook_run_usage, run_options);
>      +}
>      +
>      +int cmd_hook(int argc, const char **argv, const char *prefix)
>     @@ builtin/hook.c (new)
>      +	struct option builtin_hook_options[] = {
>      +		OPT_END(),
>      +	};
>     ++
>      +	argc = parse_options(argc, argv, NULL, builtin_hook_options,
>      +			     builtin_hook_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>      +	if (!argc)
>     -+		usage_with_options(builtin_hook_usage, builtin_hook_options);
>     ++		goto usage;
>      +
>      +	if (!strcmp(argv[0], "run"))
>      +		return run(argc, argv, prefix);
>     -+	else
>     -+		usage_with_options(builtin_hook_usage, builtin_hook_options);
>     ++
>     ++usage:
>     ++	usage_with_options(builtin_hook_usage, builtin_hook_options);
>      +}

The goto pattern seems readable enough elsewhere, though.

>       ## command-list.txt ##
>     @@ hook.c: int hook_exists(const char *name)
>      +	struct hook_cb_data *hook_cb = pp_cb;
>      +	struct hook *run_me = hook_cb->run_me;
>      +
>     ++	if (!run_me)
>     ++		return 0;
>     ++
Now we protect ourselves from the repeated calls to pick_next_hook().
Good.
>      +	cp->no_stdin = 1;
>      +	cp->env = hook_cb->options->env.v;
>      +	cp->stdout_to_stderr = 1;
>     @@ hook.c: int hook_exists(const char *name)
>      +	/* Provide context for errors if necessary */
>      +	*pp_task_cb = run_me;
>      +
>     ++	/*
>     ++	 * This pick_next_hook() will be called again, we're only
>     ++	 * running one hook, so indicate that no more work will be
>     ++	 * done.
>     ++	 */
>     ++	hook_cb->run_me = NULL;
>     ++
And clearly explaining the caller's behavior here. Sure.
>      +	return 1;
>      +}
>      +
>     @@ hook.c: int hook_exists(const char *name)
>      +
>      +	hook_cb->rc |= result;
>      +
>     -+	return 1;
>     ++	return 0;
And finally, report "everything is fine" on task finished. Thanks.
>      +}
>      +
>     -+int run_found_hooks(const char *hook_name, const char *hook_path,
>     -+		    struct run_hooks_opt *options)
>     ++int run_hooks(const char *hook_name, const char *hook_path,
>     ++	      struct run_hooks_opt *options)

Ok. With the rename, we only have "verbose way to call it" and "speedy
way to call it". No more "run_found_hooks()". Thanks, I think I like
this better - I found "run_found_hooks()" to be a little ambiguous.

>     @@ hook.c: int hook_exists(const char *name)
>      +				   hook_name);
>      +
>      +	return cb_data.rc;
>     -+}
>     -+
>     -+int run_hooks(const char *hook_name, struct run_hooks_opt *options)
>     -+{
>     -+	const char *hook_path;
>     -+	int ret;
>     -+	if (!options)
>     -+		BUG("a struct run_hooks_opt must be provided to run_hooks");
>     -+
>     -+	hook_path = find_hook(hook_name);
>     -+
>     -+	/*
>     -+	 * If you need to act on a missing hook, use run_found_hooks()
>     -+	 * instead
>     -+	 */
>     -+	if (!hook_path)
>     -+		return 0;
>     -+
>     -+	ret = run_found_hooks(hook_name, hook_path, options);
>     -+	return ret;

Ok - so we wait for another patch to introduce run_hooks_oneshot. Fine.

>      +}
>      
>       ## hook.h ##
>     @@ hook.h: const char *find_hook(const char *name);
>      +
>      +	/* Args to be passed to each hook */
>      +	struct strvec args;
>     -+
>     -+	/*
>     -+	 * Number of threads to parallelize across, currently a stub,
>     -+	 * we use the parallel API for future-proofing, but we always
>     -+	 * have one hook of a given name, so this is always an
>     -+	 * implicit 1 for now.
>     -+	 */
>     -+	int jobs;

Thanks. I think this makes more sense than the weird "futureproofing"
state it was in before.

>       ## t/t1800-hook.sh (new) ##
>     @@ t/t1800-hook.sh (new)
>      +
>      +test_expect_success 'git hook usage' '
>      +	test_expect_code 129 git hook &&
>     -+	test_expect_code 129 git hook -h &&
>     -+	test_expect_code 129 git hook run -h
>     ++	test_expect_code 129 git hook run &&
>     ++	test_expect_code 129 git hook run -h &&
>     ++	test_expect_code 129 git hook run --unknown 2>err &&
>     ++	grep "unknown option" err
>      +'

Nice. I was able to use this test myself when I added 'git hook list',
too.

The changes to this patch look good to me.

>  8:  7209f73f281 !  9:  2b8500aa675 gc: use hook library for pre-auto-gc hook
>     @@ Metadata
>       ## Commit message ##
>          gc: use hook library for pre-auto-gc hook
>      
>     -    Using the hook.h library instead of the run-command.h library to run
>     -    pre-auto-gc means that those hooks can be set up in config files, as
>     -    well as in the hookdir. pre-auto-gc is called only from builtin/gc.c.
>     +    Move the pre-auto-gc hook away from run-command.h to and over to the
>     +    new hook.h library.
>     +
>     +    To do this introduce a simple run_hooks_oneshot() wrapper, we'll be
>     +    using it extensively for these simple cases of wanting to run a single
>     +    hook under a given name, and having it free the memory we allocate for
>     +    us.

Cool, so we have an excuse for introducing the oneshot wrapper right
away. Thanks.

>     -@@ builtin/gc.c: static void add_repack_incremental_option(void)
>     - 
>     - static int need_to_gc(void)
>     - {
>     -+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
>     -+
>     - 	/*
>     - 	 * Setting gc.auto to 0 or negative can disable the
>     - 	 * automatic gc.
>      @@ builtin/gc.c: static int need_to_gc(void)
>       	else
>       		return 0;
>       
>      -	if (run_hook_le(NULL, "pre-auto-gc", NULL))
>     -+	if (run_hooks("pre-auto-gc", &hook_opt)) {
>     -+		run_hooks_opt_clear(&hook_opt);
>     ++	if (run_hooks_oneshot("pre-auto-gc", NULL))
>       		return 0;
>     -+	}
>     -+	run_hooks_opt_clear(&hook_opt);
>       	return 1;
>       }

Nice - the callsite looks much tidier now.

>     +
>     + ## hook.c ##
>     +@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
>       
>     + 	return cb_data.rc;
>     + }
>     ++
>     ++int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
>     ++{
>     ++	const char *hook_path;
>     ++	int ret;
>     ++	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
>     ++
>     ++	if (!options)
>     ++		options = &hook_opt_scratch;

Ah, it still takes an options (optionally, ha ha) because run_hooks()
would require the caller to provide the hook list/hook path. Ok. Seems
fine, and I like that the '_oneshot' naming change makes it less
surprising that run_hooks_opt_clear() will get called for you.

>     ++
>     ++	hook_path = find_hook(hook_name);
>     ++	if (!hook_path) {
>     ++		ret = 0;
>     ++		goto cleanup;
>     ++	}
>     ++
>     ++	ret = run_hooks(hook_name, hook_path, options);
>     ++cleanup:
>     ++	run_hooks_opt_clear(options);
>     ++	return ret;
>     ++}
>     +
>     + ## hook.h ##
>     +@@ hook.h: void run_hooks_opt_clear(struct run_hooks_opt *o);
>     + /**
>     +  * Takes an already resolved hook found via find_hook() and runs
>     +  * it. Does not call run_hooks_opt_clear() for you.
>     ++ *
>     ++ * See run_hooks_oneshot() for the simpler one-shot API.
>     +  */
>     + int run_hooks(const char *hookname, const char *hook_path,
>     + 	      struct run_hooks_opt *options);
>     ++
>     ++/**
>     ++ * Calls find_hook() on your "hook_name" and runs the hooks (if any)
>     ++ * with run_hooks().
>     ++ *
>     ++ * If "options" is provided calls run_hooks_opt_clear() on it for
>     ++ * you. If "options" is NULL a scratch one will be provided for you
>     ++ * before calling run_hooks().

"A scratch one will be provided for you" doesn't sound quite right -
it's not exposed to the caller at all, but the comment sounds like
you're handing the caller this scratch struct. Maybe it's better to say
"the default options from RUN_HOOKS_OPT_INIT will be used"?

As a bonus, if you directly reference the initter macro, then it will
automatically become clear to folks reading the documentation what the
expected parallelism is on their hook, as the parallelism (_SERIES or
_PARALLEL) is included on the name of the macro in my change later.

>     ++ */
>     ++int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options);
>     ++
>     + #endif

>  9:  e9a1e7cf61e ! 10:  3ee55d2c10f rebase: teach pre-rebase to use hook.h
>     @@ Metadata
>      Author: Emily Shaffer <emilyshaffer@google.com>
>      
>       ## Commit message ##
>     -    rebase: teach pre-rebase to use hook.h
>     +    rebase: convert pre-rebase to use hook.h
>      
>          Move the pre-rebase hook away from run-command.h to and over to the
>          new hook.h library.
>     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
>       	if (!ok_to_skip_pre_rebase &&
>      -	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
>      -			argc ? argv[0] : NULL, NULL))
>     -+	    run_hooks("pre-rebase", &hook_opt)) {
>     -+		run_hooks_opt_clear(&hook_opt);
>     ++	    run_hooks_oneshot("pre-rebase", &hook_opt))

Ok, it just uses the oneshot call instead. Looks good.
> 10:  1d087269303 ! 11:  050f20d14f0 am: convert applypatch hooks to use config
> 11:  32eec5dc2f0 ! 12:  ac875d284da hooks: convert 'post-checkout' hook to hook library
> 12:  e9fa3f67593 ! 13:  69763bc2255 merge: use config-based hooks for post-merge hook

The above all just use the oneshot instead, and have some minor tweaks
to commit messages to lose references to the config. Looks good.

> 13:  12347d901bb ! 14:  2ca1ca1b8e4 git hook run: add an --ignore-missing flag
>     @@ Documentation/git-hook.txt: optional `--` (or `--end-of-options`, see linkgit:gi
>       linkgit:githooks[5]
>      
>       ## builtin/hook.c ##
>     +@@
>     + #include "strvec.h"
>     + 
>     + #define BUILTIN_HOOK_RUN_USAGE \
>     +-	N_("git hook run <hook-name> [-- <hook-args>]")
>     ++	N_("git hook run [--ignore-missing] <hook-name> [-- <hook-args>]")

Ok. We update the usage in the macro here instead. Nice.

>      @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
>     - 	/*
>     - 	 * We are not using run_hooks() because we'd like to detect
>     - 	 * missing hooks. Let's find it ourselves and call
>     --	 * run_found_hooks() instead.
>     -+	 * run_found_hooks() instead...
>     - 	 */
>     + 	git_config(git_default_config, NULL);
>     + 
>       	hook_name = argv[0];
>     ++	if (ignore_missing)
>     ++		return run_hooks_oneshot(hook_name, &opt);
>       	hook_path = find_hook(hook_name);
>       	if (!hook_path) {
>     -+		/* ... act like run_hooks() under --ignore-missing */
>     -+		if (ignore_missing)
>     -+			return 0;
>       		error("cannot find a hook named %s", hook_name);
>     - 		return 1;
>     - 	}

Hm. I actually think this was clearer before. I *think* that is because
you and I have different opinions on the clarity of multiple returns :)

But I think it is a little confusing to say "ok, we will call an
entirely different entry point in case of this one thing which we will
have to check anyways".

> 14:  71d209b4077 ! 15:  5b66b04bec7 send-email: use 'git hook run' for 'sendemail-validate'
>     @@ git-send-email.perl: sub validate_patch {
>       	if ($repo) {
>      +		my $hook_name = 'sendemail-validate';
>       		my $hooks_path = $repo->command_oneline('rev-parse', '--git-path', 'hooks');
>     --		my $validate_hook = catfile($hooks_path,
>     + 		require File::Spec;
>     +-		my $validate_hook = File::Spec->catfile($hooks_path,
>      -					    'sendemail-validate');
>     -+		my $validate_hook = catfile($hooks_path, $hook_name);
>     ++		my $validate_hook = File::Spec->catfile($hooks_path, $hook_name);

Ok, we are adapting to some other change around File::Spec that happened
to git-send-email.perl elsewhere. The change to this patch looks good to
me.

>       		my $hook_error;
>       		if (-x $validate_hook) {
>     - 			my $target = abs_path($fn);
>     + 			require Cwd;
>      @@ git-send-email.perl: sub validate_patch {
>       			chdir($repo->wc_path() or $repo->repo_path())
>       				or die("chdir: $!");
> 15:  246a82b55b2 = 16:  14a37a43db2 git-p4: use 'git hook' to run hooks
> 16:  e3f8482d803 ! 17:  ad5d0e0e7de commit: use hook.h to execute hooks
>     @@ Metadata
>      Author: Emily Shaffer <emilyshaffer@google.com>
>      
>       ## Commit message ##
>     -    commit: use hook.h to execute hooks
>     +    commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>      
>     -    Teach run_commit_hook() to call hook.h instead of run-command.h. This
>     -    covers 'pre-commit', 'commit-msg', and
>     -    'prepare-commit-msg'.
>     -
>     -    Additionally, ask the hook library - not run-command - whether any
>     -    hooks will be run, as it's possible hooks may exist in the config but
>     -    not the hookdir.
>     -
>     -    Because all but 'post-commit' hooks are expected to make some state
>     -    change, force all but 'post-commit' hook to run in series. 'post-commit'
>     -    "is meant primarily for notification, and cannot affect the outcome of
>     -    `git commit`," so it is fine to run in parallel.

I am a little bummed that the patch reordering effectively removes the
justification for parallel/serial execution for each hook from 'git
blame'. Oh well.

>     +    Move these hooks hook away from run-command.h to and over to the new
>     +    hook.h library.
>      
>          Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>          Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>      
>       ## commit.c ##

Otherwise the main change here is dealing with other improvements
earlier in the series, like 'hook_exists()' and 'run_hooks_oneshot()'.
Looks fine.

> 17:  6ed61071c5e ! 18:  3d3a33e2674 read-cache: convert post-index-change hook to use config
>     @@ Metadata
>      Author: Emily Shaffer <emilyshaffer@google.com>
>      
>       ## Commit message ##
>     -    read-cache: convert post-index-change hook to use config
>     +    read-cache: convert post-index-change to use hook.h
>      
>     -    By using hook.h instead of run-command.h to run, post-index-change hooks
>     -    can now be specified in the config in addition to the hookdir.
>     -    post-index-change is not run anywhere besides in read-cache.c.
>     +    Move the post-index-change hook away from run-command.h to and over to
>     +    the new hook.h library.

I do not think it is necessary to drop the mention about
'post-index-change' being run anywhere else, but that's just a nit, not
worth fixing :)

>      
>          This removes the last direct user of run_hook_ve(), so we can make the
>          function static now. It'll be removed entirely soon.
>     @@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struc
>      +		     istate->updated_workdir ? "1" : "0",
>      +		     istate->updated_skipworktree ? "1" : "0",
>      +		     NULL);
>     -+	run_hooks("post-index-change", &hook_opt);
>     -+	run_hooks_opt_clear(&hook_opt);
>     ++	run_hooks_oneshot("post-index-change", &hook_opt);
>      +

Mechanical change to using run_hooks_oneshot(). OK.

>       	istate->updated_workdir = 0;
>       	istate->updated_skipworktree = 0;
> 18:  e4ef3f4548a ! 19:  893f8666301 receive-pack: convert push-to-checkout hook to hook.h
>     @@ Metadata
>       ## Commit message ##
>          receive-pack: convert push-to-checkout hook to hook.h
>      
>     -    By using hook.h instead of run-command.h to invoke push-to-checkout,
>     -    hooks can now be specified in the config as well as in the hookdir.
>     -    push-to-checkout is not called anywhere but in builtin/receive-pack.c.
>     +    Move the push-to-checkout hook away from run-command.h to and over to
>     +    the new hook.h library.

You made a comment in the commit before about the final instance of
run_hook_ve; do you want to make a similar one here about run_hook_le?

The range-diff here is mechanical so looks fine to me.

> 19:  e3dda367ec9 = 20:  070433deba5 run-command: remove old run_hook_{le,ve}() hook API
> 20:  477d75bf579 = 21:  1028e0c1667 run-command: allow stdin for run_processes_parallel
> 21:  b7c0ee9719a ! 22:  639e59e9ed0 hook: support passing stdin to hooks
>     @@ Documentation/git-hook.txt: what those are.
>      
>       ## builtin/hook.c ##
>      @@
>     + #include "strvec.h"
>       
>     - static const char * const builtin_hook_usage[] = {
>     - 	N_("git hook <command> [...]"),
>     --	N_("git hook run <hook-name> [-- <hook-args>]"),
>     -+	N_("git hook run [<args>] <hook-name> [-- <hook-args>]"),
>     - 	NULL
>     - };
>     - 
>     - static const char * const builtin_hook_run_usage[] = {
>     - 	N_("git hook run <hook-name> [-- <hook-args>]"),
>     -+	N_("git hook run [--to-stdin=<path>] <hook-name> [-- <hook-args>]"),
>     - 	NULL
>     - };
>     + #define BUILTIN_HOOK_RUN_USAGE \
>     +-	N_("git hook run [--ignore-missing] <hook-name> [-- <hook-args>]")
>     ++	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
>       
Just coping with the macro instead of the duplicated strings. Ok.

The range-diff looks fine to me.

> 22:  4035069a98c ! 23:  7d1925cca48 am: convert 'post-rewrite' hook to hook.h
>     @@ builtin/am.c: static int run_applypatch_msg_hook(struct am_state *state)
>       {
>      -	struct child_process cp = CHILD_PROCESS_INIT;
>      -	const char *hook = find_hook("post-rewrite");
>     -+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>     - 	int ret;
>     - 
>     +-	int ret;
>     +-
>      -	if (!hook)
>      -		return 0;
>      -
>     @@ builtin/am.c: static int run_applypatch_msg_hook(struct am_state *state)
>      -	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
>      -	cp.stdout_to_stderr = 1;
>      -	cp.trace2_hook_name = "post-rewrite";
>     -+	strvec_push(&opt.args, "rebase");
>     -+	opt.path_to_stdin = am_path(state, "rewritten");
>     ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>       
>      -	ret = run_command(&cp);
>     -+	ret = run_hooks("post-rewrite", &opt);
>     ++	strvec_push(&opt.args, "rebase");
>     ++	opt.path_to_stdin = am_path(state, "rewritten");
>       
>      -	close(cp.in);
>     -+	run_hooks_opt_clear(&opt);
>     - 	return ret;
>     +-	return ret;
>     ++	return run_hooks_oneshot("post-rewrite", &opt);
>       }
>       
>     + /**

Man, the range-diff did a terrible job of summarizing this :)

The patch itself looks great, though, with the switch to using
run_hooks_oneshot. Thanks.

> 24:  da46c859c1c ! 25:  05d1085f7eb hook: provide stdin by string_list or callback
>     @@ hook.c: static int pick_next_hook(struct child_process *cp,
>       	} else {
>       		cp->no_stdin = 1;
>       	}
>     -@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
>     - 	run_processes_parallel_tr2(options->jobs,
>     +@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
>     + 	run_processes_parallel_tr2(jobs,
>       				   pick_next_hook,
>       				   notify_start_failure,
>      -				   NULL,
>     @@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
>       				   notify_hook_finished,
>       				   &cb_data,
>       				   "hook",
>     -@@ hook.c: int run_hooks(const char *hook_name, struct run_hooks_opt *options)
>     +@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
>     + 
>     + 	if (options->absolute_path)
>     + 		strbuf_release(&abs_path);
>     ++	free(my_hook.feed_pipe_cb_data);

Nice catch. Thanks.

> 25:  7343be28ef4 ! 26:  4b7175af2e5 hook: convert 'post-rewrite' hook in sequencer.c to hook.h
> 26:  85bf13a0835 ! 27:  3f24e056410 transport: convert pre-push hook to use config
>     @@ Metadata
>      Author: Emily Shaffer <emilyshaffer@google.com>
>      
>       ## Commit message ##
>     -    transport: convert pre-push hook to use config
>     +    transport: convert pre-push hook to hook.h
>      
>     -    By using the hook.h:run_hooks API, pre-push hooks can be specified in
>     -    the config as well as in the hookdir.
>     +    Move the pre-push hook away from run-command.h to and over to the new
>     +    hook.h library.
>      
>          Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>          Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>     @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_
>      -	int ret = 0, x;
>      +	int ret = 0;
>      +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>     -+	struct strbuf tmp = STRBUF_INIT;
>       	struct ref *r;
>      -	struct child_process proc = CHILD_PROCESS_INIT;
>      -	struct strbuf buf;
>     @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_
>      -		finish_command(&proc);
>      -		return -1;
>      -	}
>     --
>     --	sigchain_push(SIGPIPE, SIG_IGN);
>     -+	struct string_list to_stdin = STRING_LIST_INIT_DUP;
>     ++	struct string_list to_stdin = STRING_LIST_INIT_NODUP;
>       
>     +-	sigchain_push(SIGPIPE, SIG_IGN);
>     +-
>      -	strbuf_init(&buf, 256);
>      +	strvec_push(&opt.args, transport->remote->name);
>      +	strvec_push(&opt.args, transport->url);
>       
>       	for (r = remote_refs; r; r = r->next) {
>     ++		struct strbuf buf = STRBUF_INIT;

Ah. It is not being freed because its lifetime is being managed by
to_stdin instead. Ok, cool!

>     ++
>       		if (!r->peer_ref) continue;
>     -@@ transport.c: static int run_pre_push_hook(struct transport *transport,
>     + 		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
>     + 		if (r->status == REF_STATUS_REJECT_STALE) continue;
>       		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
>       		if (r->status == REF_STATUS_UPTODATE) continue;
>       
>      -		strbuf_reset(&buf);
>      -		strbuf_addf( &buf, "%s %s %s %s\n",
>     -+		strbuf_reset(&tmp);
>     -+		strbuf_addf(&tmp, "%s %s %s %s",
>     ++		strbuf_addf(&buf, "%s %s %s %s",
>       			 r->peer_ref->name, oid_to_hex(&r->new_oid),
>       			 r->name, oid_to_hex(&r->old_oid));
>      -
>     @@ transport.c: static int run_pre_push_hook(struct transport *transport,
>      -				ret = -1;
>      -			break;
>      -		}
>     -+		string_list_append(&to_stdin, tmp.buf);
>     ++		string_list_append(&to_stdin, strbuf_detach(&buf, NULL));
>       	}
>       
>      -	strbuf_release(&buf);
>     @@ transport.c: static int run_pre_push_hook(struct transport *transport,
>      -	x = finish_command(&proc);
>      -	if (!ret)
>      -		ret = x;
>     -+	ret = run_hooks("pre-push", &opt);
>     -+	run_hooks_opt_clear(&opt);
>     -+	strbuf_release(&tmp);
>     ++	ret = run_hooks_oneshot("pre-push", &opt);
>     ++	to_stdin.strdup_strings = 1;

And this is a typical change to the oneshot function. Cool.

>      +	string_list_clear(&to_stdin, 0);
>       
>       	return ret;
>  -:  ----------- > 28:  ecf75f33233 hook tests: test for exact "pre-push" hook input
>  -:  ----------- > 29:  2c961be94b4 hook tests: use a modern style for "pre-push" tests

I'll take a look at these separately.

> 27:  331014bad17 ! 30:  1ce456f9d9d reference-transaction: use hook.h to run hooks
>     @@ refs.c: int ref_update_reject_duplicates(struct string_list *refnames,
>       				const char *state)
>       {
>      -	struct child_process proc = CHILD_PROCESS_INIT;
>     - 	struct strbuf buf = STRBUF_INIT;
>     +-	struct strbuf buf = STRBUF_INIT;
>      -	const char *hook;
>      +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>     -+	struct string_list to_stdin = STRING_LIST_INIT_DUP;
>     ++	struct string_list to_stdin = STRING_LIST_INIT_NODUP;
>       	int ret = 0, i;
>     -+	char o[GIT_MAX_HEXSZ + 1], n[GIT_MAX_HEXSZ + 1];
>       
>      -	hook = find_hook("reference-transaction");
>      -	if (!hook)
>     -+	if (!hook_exists("reference-transaction"))
>     - 		return ret;
>     - 
>     +-		return ret;
>     +-
>      -	strvec_pushl(&proc.args, hook, state, NULL);
>      -	proc.in = -1;
>      -	proc.stdout_to_stderr = 1;
>     @@ refs.c: int ref_update_reject_duplicates(struct string_list *refnames,
>      -
>      -	ret = start_command(&proc);
>      -	if (ret)
>     --		return ret;
>     --
>     ++	if (!hook_exists("reference-transaction"))
>     + 		return ret;
>     + 
>      -	sigchain_push(SIGPIPE, SIG_IGN);
>      +	strvec_push(&opt.args, state);
>       
>       	for (i = 0; i < transaction->nr; i++) {
>       		struct ref_update *update = transaction->updates[i];
>     -+		oid_to_hex_r(o, &update->old_oid);
>     -+		oid_to_hex_r(n, &update->new_oid);
>     ++		struct strbuf buf = STRBUF_INIT;

Ah, this is doing the same thing as with 'pre-push'. Cool.

>       
>     - 		strbuf_reset(&buf);
>     +-		strbuf_reset(&buf);
>      -		strbuf_addf(&buf, "%s %s %s\n",
>     --			    oid_to_hex(&update->old_oid),
>     --			    oid_to_hex(&update->new_oid),
>     --			    update->refname);
>     ++		strbuf_addf(&buf, "%s %s %s",
>     + 			    oid_to_hex(&update->old_oid),
>     + 			    oid_to_hex(&update->new_oid),
>     + 			    update->refname);
>      -
>      -		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
>      -			if (errno != EPIPE)
>      -				ret = -1;
>      -			break;
>      -		}
>     -+		strbuf_addf(&buf, "%s %s %s", o, n, update->refname);
>     -+		string_list_append(&to_stdin, buf.buf);
>     ++		string_list_append(&to_stdin, strbuf_detach(&buf, NULL));
>       	}
>       
>      -	close(proc.in);
>      -	sigchain_pop(SIGPIPE);
>     +-	strbuf_release(&buf);
>      +	opt.feed_pipe = pipe_from_string_list;
>      +	opt.feed_pipe_ctx = &to_stdin;
>      +
>     -+	ret = run_hooks("reference-transaction", &opt);
>     -+	run_hooks_opt_clear(&opt);
>     - 	strbuf_release(&buf);
>     ++	ret = run_hooks_oneshot("reference-transaction", &opt);
>     ++	to_stdin.strdup_strings = 1;

And turning on strdup_strings here means we will free them when we call
string_list_clear. Ok.

>      +	string_list_clear(&to_stdin, 0);
>       
>      -	ret |= finish_command(&proc);
> 32:  db70b59b3bd ! 35:  ceef2f3e804 receive-pack: convert receive hooks to hook.h
>     @@ builtin/receive-pack.c: static void hook_output_to_sideband(struct strbuf *outpu
>      +{
>      +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>      +	struct receive_hook_feed_context ctx;
>     -+	int rc;
>      +	struct command *iter = commands;
>      +
>      +	/* if there are no valid commands, don't invoke the hook at all. */
>     @@ builtin/receive-pack.c: static void hook_output_to_sideband(struct strbuf *outpu
>      +	if (!iter)
>      +		return 0;
>      +
>     -+	/* pre-receive hooks should run in series as the hook updates refs */
>     -+	if (!strcmp(hook_name, "pre-receive"))
>     -+		opt.jobs = 1;
>     -+

Hm, interesting. I'll note this as a case to watch for when I add the
.jobs option back in.


Thanks. I'll take a look at the newly added/copied over patches next.

 - Emily
