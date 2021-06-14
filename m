Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BF1C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 21:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE5D61166
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 21:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhFNVhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:37:18 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:38498 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhFNVhR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 17:37:17 -0400
Received: by mail-pl1-f178.google.com with SMTP id 69so7335075plc.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gbnJ6dyepHECB5/BB+gOwXWWrnw2FahhrPPNYNapdxw=;
        b=sIxvWJnINgSgLwvINeze4GcNk2+Rcn+Mz29SCVQ/9SqPyFXj97cgx6K+DaQ8j4yKY8
         sw7gP5jmalHNPk68g/hP6tz7u0pnNh1PJ9rXksD3gub93+1azUB+vvBSr/NW2yvMxDwk
         9o9eawa71b5IZz0ILZH02BDTY7BEpaWKF2GWS2cUAA1NCvuHnvmKD+Yhh6eNEvQiPAVM
         bCwL2AIc56Ju2aue5+5pCS/PHZL77ZvTypIKqKUWZcprbnnY4+KfuF3buDMRjUQySyhw
         v62RqxcM8kRAvrx3hP1QskihADRos5RmkU1IWn0CP4jxhz0hCqWKX9v7nO9oTFiW8CJK
         UNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gbnJ6dyepHECB5/BB+gOwXWWrnw2FahhrPPNYNapdxw=;
        b=uJdUqZsufrkVpWVm5Wa5CjSuIVCAiDiPJQI2uoAIIzKSa2PRwRS3WCoudqSCTTozuj
         3Is87SSw5ewn3M6ft8hm29/cVfA7A9mkcFX1NwSZuioijlMSjKqqfhrgMvwGMS2e3YtI
         tS5IWuu6o3RvbhnY9E/y9IIHreyZQRqsooxyA051fnlz40HELrBIDeI2wsw0yMDAKJtE
         Xe2iVpAlZccfCs3RlwuVZQEL0+UnltgCiVOvLY7D6bD8D7TaAI7su2qKJdBzLfS+iNRy
         BsoXYplw+thhwYX05s5g73hNp1frzw7xmJHeQDjQDU1haoCYnFdz68BMFpGkpX/NE1kw
         Hb6g==
X-Gm-Message-State: AOAM531rboJwbeLj/h2MQJiff+ZS0HoKTEh2PDdtbmKRgx7d87bRS/Np
        yWpDxGELblqfxjRMsU4e6RCjkKtE98SFQQ==
X-Google-Smtp-Source: ABdhPJwusyT+lv5yyjWt20J37pKJXq5xs0uqEGmYI81Lw5tH2I5wTljOkWiKQcVPgiA3tfrgKn9eJg==
X-Received: by 2002:a17:90a:cd03:: with SMTP id d3mr19339651pju.31.1623706439709;
        Mon, 14 Jun 2021 14:33:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:87fc:fefd:1365:fa14])
        by smtp.gmail.com with ESMTPSA id iq15sm339346pjb.53.2021.06.14.14.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:33:58 -0700 (PDT)
Date:   Mon, 14 Jun 2021 14:33:47 -0700
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
Subject: Re: [PATCH v2 01/30] hook: add 'run' subcommand
Message-ID: <YMfLO9CT+iIDR3OA@google.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <patch-01.30-447d349c738-20210614T101920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-01.30-447d349c738-20210614T101920Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 12:32:50PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> In order to enable hooks to be run as an external process, by a
> standalone Git command, or by tools which wrap Git, provide an external
> means to run all configured hook commands for a given hook event.

From what it says on the box, I'm slightly worried about this patch
doing too much at once, but let's see... (I think this is also a common
thing you and I disagree on - how much work to do per commit - so feel
free to ignore me ;) )

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Thanks for including attribution - I appreciate it.

> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> new file mode 100644
> index 00000000000..902b9cffaef
> --- /dev/null
> +++ b/Documentation/git-hook.txt
> @@ -0,0 +1,36 @@
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

Interesting. This is definitely more user friendly than `-a foo -a bar -a
aagh` ;)

Can we think of a scenario when a user might want to alias to part of
'git hook run' with an argument provided, but still wish to use the hook
more generally? I thought maybe something like `git hook run -a
"--user=Bob"` for a user who has a handful of hooks that can take some
additional argument, but then I realized that most hooks need to meet a
contract with which args they accept, so this isn't a reasonable use
case.

I also wondered whether accepting hook args this way implied that we
can't also provide environment vars for the hooks later on, but I think
it's fine to have those two interfaces be asymmetrical, e.g. `git hook
run -e "USERID=Bob" -- blah.txt`.

So I like this way of accepting them :)

[snip]
> +run::
> +
> +	Run the `<hook-name>` hook. Any positional arguments to the
> +	hook should be passed after an optional "--" (or
> +	"--end-of-options"). See "OPTIONS" below for the arguments
> +	this accepts.

Is it clear enough that users will need to provide arguments to certain
hooks? (Should this have some reference to githooks.txt?)

The "OPTIONS" reference is stale - there is no OPTIONS header in the
manpage now.

> --- /dev/null
> +++ b/builtin/hook.c
> @@ -0,0 +1,65 @@
> +#include "cache.h"
> +#include "builtin.h"
> +#include "config.h"
> +#include "hook.h"
> +#include "parse-options.h"
> +#include "strbuf.h"
> +#include "strvec.h"
> +
> +static const char * const builtin_hook_usage[] = {
> +	N_("git hook run <hook-name> [-- <hook-args>]"),
> +	NULL
> +};
> +
> +static int run(int argc, const char **argv, const char *prefix)
> +{
> +	int i;
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +	int rc = 0;
> +	const char *hook_name;
> +	const char *hook_path;
> +
> +	struct option run_options[] = {
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, run_options,
> +			     builtin_hook_usage, PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
> +
> +	if (argc > 2) {
> +		if (strcmp(argv[2], "--") &&
> +		    strcmp(argv[2], "--end-of-options"))
> +			/* Having a -- for "run" is mandatory */
> +			usage_with_options(builtin_hook_usage, run_options);
> +		/* Add our arguments, start after -- */
> +		for (i = 3 ; i < argc; i++)
> +			strvec_push(&opt.args, argv[i]);
> +	}
> +
> +	/* Need to take into account core.hooksPath */
> +	git_config(git_default_config, NULL);
> +
> +	hook_name = argv[1];
> +	hook_path = find_hook(hook_name);
> +	if (!hook_path) {
> +		error("cannot find a hook named %s", hook_name);
> +		return 1;
> +	}
> +	rc = run_found_hooks(hook_name, hook_path, &opt);

Hum, what's the reasoning for not letting the hook.h call look up the
hook path for itself? I scanned through the v1 cover and older version
of this patch and didn't see any reasoning. To me, having the builtin
look up paths feels like incorrect layering.

> +int cmd_hook(int argc, const char **argv, const char *prefix)
> +{
> +	struct option builtin_hook_options[] = {
> +		OPT_END(),
> +	};
> +
> +	if (!strcmp(argv[1], "run"))
> +		return run(argc, argv, prefix);

Hum. This means that 'run' will still be included in argv for run(),
which I see that it works around silently. I personally find that to be
confusing - maybe at least a comment pointing it out, if you don't like
the idea of adjusting argv before passing it to run()?

> diff --git a/git.c b/git.c
> index 18bed9a9964..540909c391f 100644
> --- a/git.c
> +++ b/git.c
> @@ -538,6 +538,7 @@ static struct cmd_struct commands[] = {
>  	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
>  	{ "hash-object", cmd_hash_object },
>  	{ "help", cmd_help },
> +	{ "hook", cmd_hook, RUN_SETUP },

Hm. RUN_SETUP requires a gitdir, which I suppose makes sense as this is
a pre-config-hooks world.

Does this mean "git send-email" will abort if I try to run it with no
gitdir (which I often do)? I looked ahead to patch 10 and it doesn't
look like there's a significant change to the error handling, so I guess
that if it works for me today, it will work for me with this change too.

Later config-based hooks will mean that such hooks could exist without a
gitdir, but we can cross that bridge when we get there :)

> --- /dev/null
> +++ b/hook.c
> @@ -0,0 +1,114 @@
> +#include "cache.h"
> +#include "hook.h"
> +#include "run-command.h"
> +
> +void run_hooks_opt_clear(struct run_hooks_opt *o)
> +{
> +	strvec_clear(&o->env);
> +	strvec_clear(&o->args);

Maybe more graceful to nullcheck within the _clear() function before
dereferencing 'o'? That way callers don't need to worry about NULL
checking on their end.

> +static int pick_next_hook(struct child_process *cp,
> +			  struct strbuf *out,
> +			  void *pp_cb,
> +			  void **pp_task_cb)
> +{
> +	struct hook_cb_data *hook_cb = pp_cb;
> +	struct hook *run_me = hook_cb->run_me;
> +
> +	if (!run_me)
> +		BUG("did we not return 1 in notify_hook_finished?");

I'm not sure I like this message, even as a BUG(), although the things
I'd rather say ("run_me was NULL unexpectedly!") are obvious as soon as
you grep the codebase. So I think I dislike it for no reason :)

[...]

> +static int notify_start_failure(struct strbuf *out,
> +				void *pp_cb,
> +				void *pp_task_cp)
> +{
> +	struct hook_cb_data *hook_cb = pp_cb;
> +	struct hook *attempted = pp_task_cp;
> +
> +	/* |= rc in cb */
> +	hook_cb->rc |= 1;

Yuck, I think I wrote this comment... yikes. Maybe something like
"hook_cb->rc reflects cumulative failure state" instead?

> +static int notify_hook_finished(int result,
> +				struct strbuf *out,
> +				void *pp_cb,
> +				void *pp_task_cb)
> +{
> +	struct hook_cb_data *hook_cb = pp_cb;
> +
> +	/* |= rc in cb */
> +	hook_cb->rc |= result;

(And same as above.)

> +int run_found_hooks(const char *hook_name, const char *hook_path,
> +		    struct run_hooks_opt *options)
> +{
> +	struct hook my_hook = {
> +		.hook_path = hook_path,

As mentioned earlier, I think it is neater - and better for config-based
hooks in the future - if my_hook.hook_path is set by find_hooks()
directly instead of by being passed in, here. (I expect you did it this
way because one of the later hooks lives in an odd place - but I seem to
remember that one being strange in other ways, too, and I ended up
letting it manage its own affairs in my attempt. So I'll look forward to
seeing whether you handled that differently.)

[...]

> +int run_hooks(const char *hook_name, struct run_hooks_opt *options)
> +{
> +	const char *hook_path;
> +	int ret;
> +	if (!options)
> +		BUG("a struct run_hooks_opt must be provided to run_hooks");
> +
> +	hook_path = find_hook(hook_name);
> +
> +	/* Care about nonexistence? Use run_found_hooks() */
> +	if (!hook_path)
> +		return 0;

Ah, I see - you've done it this way so that builtin/hook.c can complain
"You tried to run pre-commit hook but you don't even have one!".

Hm. I think I dislike this comment for the same reason I dislike the one
much earlier in this patch - it's different from how I would have
written it. But I do think it still conveys the exact same information (I
would have said "If you need to act on a missing hook, use
run_found_hooks() instead") so chalk it up to difference in tone
preferences and ignore me :)

> diff --git a/hook.h b/hook.h
[...]
> +	/* Number of threads to parallelize across */
> +	int jobs;

I wonder whether it's worth changing the comments here...

[...]
> +/*
> + * Callback provided to feed_pipe_fn and consume_sideband_fn.
> + */

...and here, since they don't mean anything in the context of this
specific commit? But they will mean something later on in the series.

> +/*
> + * Calls find_hook(hookname) and runs the hooks (if any) with
> + * run_found_hooks().
> + */
> +int run_hooks(const char *hook_name, struct run_hooks_opt *options);
> +
> +/*
> + * Takes an already resolved hook and runs it. Internally the simpler
> + * run_hooks() will call this.
> + */
> +int run_found_hooks(const char *hookname, const char *hook_path,
> +		    struct run_hooks_opt *options);

The comments in the header here resolve any concerns I had about the
comments in the run_hooks() implementation. I like these a lot.

> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> new file mode 100755
> index 00000000000..f6ff6c4a493
> --- /dev/null
> +++ b/t/t1800-hook.sh
> @@ -0,0 +1,131 @@
> +#!/bin/bash
> +
> +test_description='git-hook command'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'git hook run -- nonexistent hook' '

Nit: Since you take '--' in 'git hook run' now, can you use something else as
a delimiter in the test names? I keep reading these as "here we will
call `git hook run -- nonexistent hook`" :/

> +	cat >stderr.expect <<-\EOF &&
> +	error: cannot find a hook named does-not-exist
> +	EOF
> +	test_expect_code 1 git hook run does-not-exist 2>stderr.actual &&
> +	test_cmp stderr.expect stderr.actual

I'm not wild about matching directly against the error message; that
means that the test will be a pain to update any time we update the
error message language. I'd prefer an approach where we check that the
error is for the reason we expect (by ensuring .git/hooks/does-not-exist
is not there in the fs) and then check that 'git hook run' fails, but do
not particularly care about the error message.

> +test_expect_success 'git hook run -- stdout and stderr handling' '

I have a slight preference towards "the name of the test tells me
exactly what is supposed to happen" - which means I'd prefer to see this
named "stdout and stderr both write to hook's stderr". Too chatty,
maybe, though.

> +test_expect_success 'git hook run -- out-of-repo runs excluded' '
> +	write_script .git/hooks/test-hook <<-EOF &&
> +	echo Test hook
> +	EOF
> +
> +	nongit test_must_fail git hook run test-hook

I wonder if it's necessary to enforce this. I'm just thinking, in a
config-based hook world later on, it will make sense to allow nongit
runs - specifically, I'd use the heck out of a send-email hook to fixup
my In-Reply-To lines, and I always run git-send-email from a nongit dir,
because I keep all my mailed patches stored away out of repo.

What's the general feeling towards "this is how it works, but we don't
have a good reason to require it"?

> +test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
> +	mkdir my-hooks &&
> +	write_script my-hooks/test-hook <<-EOF &&
> +	echo Hook ran >>actual
> +	EOF
> +
> +	cat >expect <<-\EOF &&
> +	Test hook
> +	Hook ran
> +	Hook ran
> +	Hook ran
> +	Hook ran
> +	EOF

I'm not sure I like this - collecting multiple runs into one "actual"
and only comparing it once at the end. Are there other places in the
codebase that do this?

> +
> +	# Test various ways of specifying the path. See also
> +	# t1350-config-hooks-path.sh
> +	>actual &&
> +	git hook run test-hook 2>>actual &&
> +	git -c core.hooksPath=my-hooks hook run test-hook 2>>actual &&
> +	git -c core.hooksPath=my-hooks/ hook run test-hook 2>>actual &&
> +	git -c core.hooksPath="$PWD/my-hooks" hook run test-hook 2>>actual &&
> +	git -c core.hooksPath="$PWD/my-hooks/" hook run test-hook 2>>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'set up a pre-commit hook in core.hooksPath' '
> +	>actual &&
> +	mkdir -p .git/custom-hooks .git/hooks &&
> +	write_script .git/custom-hooks/pre-commit <<-\EOF &&
> +	echo CUSTOM >>actual
> +	EOF
> +	write_script .git/hooks/pre-commit <<-\EOF
> +	echo NORMAL >>actual
> +	EOF
> +'

Is this setup test a leftover from a later commit?


Overall, I think I like the direction your reroll is going - I've needed
some time to process it. Hopefully I'll be able to get through all or
most of the series this week, but there's a lot going on here, too. I'll
do what I can. Thanks for the help.

 - Emily
