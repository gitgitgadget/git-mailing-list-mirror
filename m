Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6EDC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 20:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7BC60F46
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 20:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhG1UjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 16:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhG1UjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 16:39:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D90C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 13:39:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id a20so4253831plm.0
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 13:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4kUvzho9UoYSXJS5eVsMGpXNncC3JE0UveB9t4Hx+r8=;
        b=r5TkyODEPg2IRiEXjnH/+/0scaDbS8dWDyTCFC5OWcFa5DkfL/hJ3Gn3DNF/mwpdE+
         OPa8gomKWTy2rlRNtkecslAo9XSX8rQdoFS3IjMyaSHki3M4ACWF7Q5zc/4OsRa4XrvM
         Ph2dl9ltLc0rVKzzlAX1mNnWW1+Hhg4OrVNXa/IaZPV0BVB56IW3Nb64vZ4bSTV2bPfL
         MClDt46nMuFIAQI9AbENmzJzVLyrRKjpeYj8+lfrNTFg/9B1XWZQoRTqxgWx5ayBUuS3
         zU4RuM5R29wQgvhurFciEtBXv6+L5bJezS+xqzUhI06jqGu1ZbgrczSkMlDiWImrg4IR
         npIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4kUvzho9UoYSXJS5eVsMGpXNncC3JE0UveB9t4Hx+r8=;
        b=WI54Iss5Mp9VUOiCndX5cngCZ+I3f2kPkicu1lmnDEqMwmrziziKWlBdWZ7pHsJim1
         3iGI/BVvHKshHeZs9xb5CWLU2NFmLlvqaDgcFEWI+OitHT6UnAKMZPQ/j0Yv1IcOrBdn
         AFyl5VB9XMp6itYHJ31niMRpbFKmHN388XsK6K/xUupzmOsV/kBjngktN/HtDst19Myw
         hVBF74KyJ2ngMW3DBHubyzEni5/LIcj6SVPR/h6sPsgV46uZXISJRfEmd2gtDFx0cxjG
         8rWAQSJomH9fy3VxUj71nKS/vq5gP80/p+oIOs0wGw7TqnxxOSqGB9xh8eofgreuXXyK
         feiQ==
X-Gm-Message-State: AOAM5324EtzRZ1NDSjB9JXQBuGba6mPi2dxdHha2iJZzetKktx9eoAYQ
        dunsJxwlgKhmzR3vePF4p2mFVw==
X-Google-Smtp-Source: ABdhPJxtjqSGpjwtUX4lYF7yRAl1vi6BAAEbEp9kDcor/wiDV5EiVbbn6y4UJKoc8QZgwIACA/cORw==
X-Received: by 2002:a17:902:7610:b029:12b:f9f:727 with SMTP id k16-20020a1709027610b029012b0f9f0727mr1308435pll.65.1627504752404;
        Wed, 28 Jul 2021 13:39:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cb2e:f87a:87ef:c918])
        by smtp.gmail.com with ESMTPSA id w2sm6224051pjf.2.2021.07.28.13.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 13:39:11 -0700 (PDT)
Date:   Wed, 28 Jul 2021 13:39:06 -0700
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
Subject: Re: [PATCH 00/27] Base for "config-based-hooks"
Message-ID: <YQHAasrmcbdiCDQF@google.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 12:22:34PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> This v3 of the "Base for 'config-based-hooks'" topic is >95% a
> slimmed-down versio nof Emily Schaffer's work to introduce a mechanism
(Tiniest of nits - I only have a 'c' in my middle name ;) )
> to drive hooks via config.
> 
> This topic doesn't do that, but moves all hook execution (C libary and
> Perl|Python script) to either the new hook.[ch] library code, or the
> "git hook run" utility.
> 
> See previous iterations for more details:
> 
>  v0 (Emily's): http://lore.kernel.org/git/20210527000856.695702-1-emilyshaffer@google.com
>  v1: https://lore.kernel.org/git/cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com/
>  v2: http://lore.kernel.org/git/cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com
> 
> This series gained two new dependencies since v2, my just-submitted
> preparatory topics:
> 
>     https://lore.kernel.org/git/cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com/
>     https://lore.kernel.org/git/cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com/
> 
> And hopefully addreses all the feedback on v2, mainly/entirely from
> Emily at https://lore.kernel.org/git/YMfLO9CT+iIDR3OA@google.com
> 
> I'd normally have waited longer for a v3, but as discussed in the
> small hook.[ch] topic that precedes this one building the new
> hook-list.h had an error on Windows CI due to a missing CMake change,
> that's now fixed.
> 
> Other changes can be seen in the range-diff, all rather trivial fixes
> like comment fixes, trimming off "argc/argv" before we pass things to
> "git hook run", removing a redundant test setup etc.
> 
> I also added a GIT_TEST_FAKE_HOOKS=true for use in the test suite to
> make us support a "test-hook" and a "does-not-exist" hook, we'd
> previously accept those outside the test environment.

I initially wasn't sure this is necessary, and I'm still not entirely
sure - it makes more sense to me to see test-hook and does-not-exist use
essentially
https://lore.kernel.org/git/20210715232603.3415111-8-emilyshaffer@google.com.

Would it make sense for you to absorb that much - "when we're 'git hook
run'ing, don't validate hookname" - into your series to avoid this
test-fake-hooks thing, and also teach the test-helper to use (or not
use) the allow_unknown flag?

[...]

> Range-diff:
>  1:  447d349c73 !  1:  cf4b06bfdf hook: add 'run' subcommand
>     @@ Documentation/git-hook.txt (new)
>     @@ Documentation/githooks.txt: and "0" meaning they were not.
>     -@@ Makefile: LIB_OBJS += hash-lookup.o
>     - LIB_OBJS += hashmap.o
>     - LIB_OBJS += help.o
>     - LIB_OBJS += hex.o
>     -+LIB_OBJS += hook.o
>     - LIB_OBJS += ident.o
>     - LIB_OBJS += json-writer.o
>     - LIB_OBJS += kwset.o

Ah, no longer adding hook.o to the Makefile because it's been added in
one of your splintered-off dependency topics. Ok.

>     @@ builtin/hook.c (new)
>      +#include "strvec.h"
>      +
>      +static const char * const builtin_hook_usage[] = {
>     ++	N_("git hook <command> [...]"),
>     ++	N_("git hook run <hook-name> [-- <hook-args>]"),
>     ++	NULL
>     ++};
>     ++
>     ++static const char * const builtin_hook_run_usage[] = {
>      +	N_("git hook run <hook-name> [-- <hook-args>]"),
>      +	NULL
>      +};
Cool, so now we have a separate 'git hook<enter>' usage and 'git hook
run<enter>' usage.

I was going to complain about the strings being duplicated, but it
appears that other commands that use this pattern - like 'git remote' -
do it the same way as you're doing here. So seems like that's a problem
to ponder later, unrelated to this topic ;)

>     @@ builtin/hook.c (new)
>      +	};
>      +
>      +	argc = parse_options(argc, argv, prefix, run_options,
>     -+			     builtin_hook_usage, PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
>     ++			     builtin_hook_run_usage,
>     ++			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
>      +
>     -+	if (argc > 2) {
>     -+		if (strcmp(argv[2], "--") &&
>     -+		    strcmp(argv[2], "--end-of-options"))
>     ++	if (argc > 1) {
>     ++		if (strcmp(argv[1], "--") &&
>     ++		    strcmp(argv[1], "--end-of-options"))
>      +			/* Having a -- for "run" is mandatory */
>      +			usage_with_options(builtin_hook_usage, run_options);
>      +		/* Add our arguments, start after -- */
>     -+		for (i = 3 ; i < argc; i++)
>     ++		for (i = 2 ; i < argc; i++)

Nice, so the implementation of run_hooks() has one less stray arg to
worry about.

>      +			strvec_push(&opt.args, argv[i]);
>      +	}
>      +
>      +	/* Need to take into account core.hooksPath */
>      +	git_config(git_default_config, NULL);
>      +
>     -+	hook_name = argv[1];
>     ++	/*
>     ++	 * We are not using run_hooks() because we'd like to detect
>     ++	 * missing hooks. Let's find it ourselves and call
>     ++	 * run_found_hooks() instead.
>     ++	 */
>     ++	hook_name = argv[0];

And a more explicit comment. Thanks.

>      +	hook_path = find_hook(hook_name);
>      +	if (!hook_path) {
>      +		error("cannot find a hook named %s", hook_name);
>     @@ builtin/hook.c (new)
>      +	struct option builtin_hook_options[] = {
>      +		OPT_END(),
>      +	};
>     ++	argc = parse_options(argc, argv, NULL, builtin_hook_options,
>     ++			     builtin_hook_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>     ++	if (!argc)
>     ++		usage_with_options(builtin_hook_usage, builtin_hook_options);

Nice - parse_options() removes the 'hook' part of the invocation for us,
so we don't need to carry it around into the subcommands. Thanks.

>      +
>     -+	if (!strcmp(argv[1], "run"))
>     ++	if (!strcmp(argv[0], "run"))
>      +		return run(argc, argv, prefix);
>     -+	usage_with_options(builtin_hook_usage, builtin_hook_options);
>     -+	return 1;
>     ++	else
>     ++		usage_with_options(builtin_hook_usage, builtin_hook_options);
>      +}

Ah, and here we lose the awkward "return something even though
usage_with_options() exits". Ok.

>     + ## hook.c ##
>     + static int known_hook(const char *name)
>     + {
>     + 	const char **p;
>     + 	size_t len = strlen(name);
>     ++	static int test_hooks_ok = -1;
>     ++

Setting aside whether or not I think it's a good idea, this seems
correct - we either allow test hooks for the entire lifetime of the
process (e.g. from the test runner) or enforce hookname validation for
the entire lifetime of the process (e.g. 'git hook run' or normal Git
operation). So it makes sense to cache it in a static. Ok.

>     + 	for (p = hook_name_list; *p; p++) {
>     + 		const char *hook = *p;
>     + 
>     +@@ hook.c: static int known_hook(const char *name)
>     + 			return 1;
>     + 	}
>     + 
>     ++	if (test_hooks_ok == -1)
>     ++		test_hooks_ok = git_env_bool("GIT_TEST_FAKE_HOOKS", 0);
>     ++
>     ++	if (test_hooks_ok &&
>     ++	    (!strcmp(name, "test-hook") ||
>     ++	     !strcmp(name, "does-not-exist")))
>     ++		return 1;
>     ++

As I mentioned above, this still seems too restrictive to me, but I
don't need to rehash it here.

>     @@ hook.c (new)
>      +	struct hook_cb_data *hook_cb = pp_cb;
>      +	struct hook *run_me = hook_cb->run_me;
>      +
>     -+	if (!run_me)
>     -+		BUG("did we not return 1 in notify_hook_finished?");
>     -+

I think the logic here is not quite correct, and I patched it in my
series on top when I enabled multiple hooks.

My understanding of the contract with run_processes_parallel() is this:
 - When you're done assigning tasks, return '0' from pick_next_hook()
 - If you want to stop all task processing because of one task's exit
   state, return '1' from notify_hook_finished()

But you instead are unconditionally returning '1' from
'notify_hook_finished()', and not handling "no more tasks to assign" in
pick_next_hook(). I think it is more correct to return 0 from
'notify_hook_finished()' - "this hook ran correctly, or if it ran
poorly, at least we don't want to prevent anybody else from running, as
that's not our problem". And then in your pick_next_hook(), since you
know you only want to run one hook and you aren't using a list yet, at
the end after you prepare the child_process, you can set hook_cb->run_me
= NULL - "there is no next hook to pick" - and then use "if (!run_me)"
to return 0 to tell run_processes_parallel() that there are no more
tasks to assign.

I  mention it because without noticing your changed flow in this patch,
I wrote a fairly pernicious bug in my rebase on top. By leaving
'notify_hook_finished()' to return 1, but enabling parallelism,
multihooks *appeared* to work - because all the tasks were assigned and
started when running in parallel, even though the first one to finish
said "wait don't start any more tasks please". But when running multiple
hooks with j=1, only the first hook would run, even though the list was
populated correctly - and stepping through pick_next_hook() didn't
indicate why.

I *think* you did it this way to avoid calling pick_next_hook() again with
nothing to iterate over, but since run_processes_parallel() is written
for lists of tasks, I don't think that kludge is the "correct" approach.

>     +@@ hook.h: const char *find_hook(const char *name);
>     -+	/* Number of threads to parallelize across */
>     ++	/*
>     ++	 * Number of threads to parallelize across, currently a stub,
>     ++	 * we use the parallel API for future-proofing, but we always
>     ++	 * have one hook of a given name, so this is always an
>     ++	 * implicit 1 for now.
>     ++	 */
>      +	int jobs;

Makes me wonder whether you really even want to leave it in here. I
guess it makes your call to run_processes_parallel() cleaner. But it'd
also be handy to swap '1' for 'options->jobs' in
https://lore.kernel.org/git/20210715232603.3415111-3-emilyshaffer@google.com
instead, if you'd prefer.

>      +};
>      +
>     @@ hook.h (new)
>      +	.args = STRVEC_INIT, \
>      +}
>      +
>     -+/*
>     -+ * Callback provided to feed_pipe_fn and consume_sideband_fn.
>     -+ */

Why delete the comment? What was it hurting? ;)

>     @@ t/t1800-hook.sh (new)
>     ++test_expect_success 'git hook run: nonexistent hook' '

Ah, thanks for '%s/--/:/'. I know it was a nit, but that was bugging me :)

>      +test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
>      +	mkdir my-hooks &&
>     -+	write_script my-hooks/test-hook <<-EOF &&
>     -+	echo Hook ran >>actual
>     ++	write_script my-hooks/test-hook <<-\EOF &&
>     ++	echo Hook ran $1 >>actual
>      +	EOF
>      +
>      +	cat >expect <<-\EOF &&
>      +	Test hook
>     -+	Hook ran
>     -+	Hook ran
>     -+	Hook ran
>     -+	Hook ran
>     ++	Hook ran one
>     ++	Hook ran two
>     ++	Hook ran three
>     ++	Hook ran four
>      +	EOF
>      +
>      +	# Test various ways of specifying the path. See also
>      +	# t1350-config-hooks-path.sh
>      +	>actual &&
>     -+	git hook run test-hook 2>>actual &&
>     -+	git -c core.hooksPath=my-hooks hook run test-hook 2>>actual &&
>     -+	git -c core.hooksPath=my-hooks/ hook run test-hook 2>>actual &&
>     -+	git -c core.hooksPath="$PWD/my-hooks" hook run test-hook 2>>actual &&
>     -+	git -c core.hooksPath="$PWD/my-hooks/" hook run test-hook 2>>actual &&
>     ++	git hook run test-hook -- ignored 2>>actual &&
>     ++	git -c core.hooksPath=my-hooks hook run test-hook -- one 2>>actual &&
>     ++	git -c core.hooksPath=my-hooks/ hook run test-hook -- two 2>>actual &&
>     ++	git -c core.hooksPath="$PWD/my-hooks" hook run test-hook -- three 2>>actual &&
>     ++	git -c core.hooksPath="$PWD/my-hooks/" hook run test-hook -- four 2>>actual &&

Thanks - this will be much easier to debug when someone (me, probably)
breaks one of these by accident ;)

>      +	test_cmp expect actual
>      +'
>      +
>     -+test_expect_success 'set up a pre-commit hook in core.hooksPath' '
>     -+	>actual &&
>     -+	mkdir -p .git/custom-hooks .git/hooks &&
>     -+	write_script .git/custom-hooks/pre-commit <<-\EOF &&
>     -+	echo CUSTOM >>actual
>     -+	EOF
>     -+	write_script .git/hooks/pre-commit <<-\EOF
>     -+	echo NORMAL >>actual
>     -+	EOF
>     -+'

Hm, is this removed because we feel like the test-hook test above gives
us enough coverage? Ok.

>  9:  8d8b2d2645 !  7:  12347d901b git hook run: add an --ignore-missing flag
>       ## t/t1800-hook.sh ##
>     +-test_expect_success 'git hook run: basic' '
>     ++test_expect_success 'git hook run: nonexistent hook with --ignore-missing' '
>      +	git hook run --ignore-missing does-not-exist 2>stderr.actual &&
>      +	test_must_be_empty stderr.actual
>      +'
>      +
>     - test_expect_success 'git hook run -- basic' '
>     ++test_expect_success 'git hook run -- basic' '

Ah, I see the range-diff caught s/--/:/ earlier but that step was missed
in patch 9, which made this bit of the diff a little confused.

> 11:  aa970a8175 !  9:  246a82b55b git-p4: use 'git hook' to run hooks
>     @@ Commit message
>          Python, we can directly call 'git hook run'. We emulate the existence
>          check with the --ignore-missing flag.
>      
>     +    As this is the last hook execution in git.git to not go through "git
>     +    hook run" or the hook.[ch] library we can now be absolutely sure that
>     +    our assertion in hook.c that only hooks known by the generated (from
>     +    githooks(5)) hook-list.h are permitted.
>     +

\o/

> 17:  c4f60db606 ! 15:  b7c0ee9719 hook: support passing stdin to hooks
>       ## builtin/hook.c ##
>       static const char * const builtin_hook_usage[] = {
>     + 	N_("git hook <command> [...]"),
>      -	N_("git hook run <hook-name> [-- <hook-args>]"),
>     ++	N_("git hook run [<args>] <hook-name> [-- <hook-args>]"),
>     + 	NULL
>     + };
>     + 
>     + static const char * const builtin_hook_run_usage[] = {
>     + 	N_("git hook run <hook-name> [-- <hook-args>]"),
>      +	N_("git hook run [--to-stdin=<path>] <hook-name> [-- <hook-args>]"),

Nice, and here the strings in builtin_hook_usage and
builtin_hook_run_usage start to differ, which makes my earlier concern
entirely moot. Thanks.

--

Aside from the questions about a) this test hook envvar and b) specific
mechanics of terminating run_processes_parallel(), this series looks
good to me.

 - Emily
