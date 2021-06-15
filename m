Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5971C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD2E61443
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhFOKEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhFOKEb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 06:04:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC90C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:02:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z12so1503014edc.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=o5D9F9FJJoy/EkMqOEOeDdhRza4byZqafpLiBw2bunc=;
        b=CgugiQFQ2FoXBjtNKImJ6CBOC8Be9zCNKGClLv4SAWiqKon5W/CLl5bZTtJijkQNi0
         YHEyXSo8FmjJR2f4eZygyrOCnWn/c2qIpqJn6ymuA51b7FGBm5puv9Goz7bGxwezIKnZ
         Dlb8dbhg5YnBl65UtmYILkYenf46NQMmmSMrYIMvYGxympb7kYr+ieULMK3p0JxTZXWN
         k+spysnysnumKTnysSlw/MkM9TTtzlT/fb5Tnm5GrYvc/YVhtCvXnWIP3RAzg3BiBIh9
         aqjaewCYLNyvHzZP7nvIud4yTXfUd+mpXBrkwxP7if/Y5xiMHxIKh9xgtnh2AzBvrMds
         wubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=o5D9F9FJJoy/EkMqOEOeDdhRza4byZqafpLiBw2bunc=;
        b=Ai1bZ/okStpNZCTm9HA67tnHg7ILk8eCxvVkQ24dZ3qQvhoPbGOqAMzg1dlbsUE0Bd
         a/z/vH6FaZOEgCSNbeANfFI5wM7UEDJbFv1+RPgd8mf6pVE1dk0xWOSzvTkiqIdla3GT
         bMKDKwg/ykQtY7YzwlrKzZ+pfcF68pTRDP5FeoI4ZTSrvtCFIwQoHeERBqjp+aLs4wQm
         gQoTHVD+Hpw9geAhV9LqeJqIBjzqEiPoo5yz92M5Ns3wc5ENnphmkGADi033ABtF2Cl2
         Ng2YgSlOY2AzudJVATO147FMY86ewrY9tmHLiGRdstqXmjF/Lxq+HW75q5Va/i3zZKEc
         /VZA==
X-Gm-Message-State: AOAM531reTRcyOVG3itXM+acpUuZlFKxVzmLEaChSn7BnftNJdSEFgt1
        h6TlQp2d6OfR9dvuIn+nXcNK16P88MMY0Q==
X-Google-Smtp-Source: ABdhPJytLgxnShT60FWK++NVWxANQJRzw+t9wzJOOYXFj4iK0RM3kNzQmX43ZLPItzIEplL+LVD92g==
X-Received: by 2002:a50:9b42:: with SMTP id a2mr21984331edj.215.1623751344722;
        Tue, 15 Jun 2021 03:02:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e22sm11793620edv.57.2021.06.15.03.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 03:02:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 01/30] hook: add 'run' subcommand
Date:   Tue, 15 Jun 2021 11:36:26 +0200
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <patch-01.30-447d349c738-20210614T101920Z-avarab@gmail.com>
 <YMfLO9CT+iIDR3OA@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YMfLO9CT+iIDR3OA@google.com>
Message-ID: <87lf7bzbrk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 14 2021, Emily Shaffer wrote:

> On Mon, Jun 14, 2021 at 12:32:50PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> In order to enable hooks to be run as an external process, by a
>> standalone Git command, or by tools which wrap Git, provide an external
>> means to run all configured hook commands for a given hook event.
>
> From what it says on the box, I'm slightly worried about this patch
> doing too much at once, but let's see... (I think this is also a common
> thing you and I disagree on - how much work to do per commit - so feel
> free to ignore me ;) )
>
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Thanks for including attribution - I appreciate it.

They are almost entirely subsets of your patches, so I retained the
authorship, but added my own SOB. The only ones with my authorship are
something where I added fixes in-between or on top.

>> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
>> new file mode 100644
>> index 00000000000..902b9cffaef
>> --- /dev/null
>> +++ b/Documentation/git-hook.txt
>> @@ -0,0 +1,36 @@
>> +git-hook(1)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +NAME
>> +----
>> +git-hook - run git hooks
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git hook' run <hook-name> [-- <hook-args>]
>
> Interesting. This is definitely more user friendly than `-a foo -a bar -a
> aagh` ;)
>
> Can we think of a scenario when a user might want to alias to part of
> 'git hook run' with an argument provided, but still wish to use the hook
> more generally? I thought maybe something like `git hook run -a
> "--user=3DBob"` for a user who has a handful of hooks that can take some
> additional argument, but then I realized that most hooks need to meet a
> contract with which args they accept, so this isn't a reasonable use
> case.

I can only think of ones where the [-- <hook-args>] would be sufficient.

> I also wondered whether accepting hook args this way implied that we
> can't also provide environment vars for the hooks later on, but I think
> it's fine to have those two interfaces be asymmetrical, e.g. `git hook
> run -e "USERID=3DBob" -- blah.txt`.
>
> So I like this way of accepting them :)

I carved out the "-e" support from "run" as part of a general removal of
things not needed for the bug-for-bug compatibility with existing hook
interfaces, i.e. nothing needed it in this phase.

But I also can't see why a "hook run" would need to have an "-e",
anything that invokes the command has other more native ways of setting
the environment first, so the command just needs to avoid actively
clearing its own environment, no?

> [snip]
>> +run::
>> +
>> +	Run the `<hook-name>` hook. Any positional arguments to the
>> +	hook should be passed after an optional "--" (or
>> +	"--end-of-options"). See "OPTIONS" below for the arguments
>> +	this accepts.
>
> Is it clear enough that users will need to provide arguments to certain
> hooks? (Should this have some reference to githooks.txt?)

Probably, I also figured at this point it could be left as almost a
*--helper command.

> The "OPTIONS" reference is stale - there is no OPTIONS header in the
> manpage now.

Well spotted, will fix, or maybe you will :)

>> --- /dev/null
>> +++ b/builtin/hook.c
>> @@ -0,0 +1,65 @@
>> +#include "cache.h"
>> +#include "builtin.h"
>> +#include "config.h"
>> +#include "hook.h"
>> +#include "parse-options.h"
>> +#include "strbuf.h"
>> +#include "strvec.h"
>> +
>> +static const char * const builtin_hook_usage[] =3D {
>> +	N_("git hook run <hook-name> [-- <hook-args>]"),
>> +	NULL
>> +};
>> +
>> +static int run(int argc, const char **argv, const char *prefix)
>> +{
>> +	int i;
>> +	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
>> +	int rc =3D 0;
>> +	const char *hook_name;
>> +	const char *hook_path;
>> +
>> +	struct option run_options[] =3D {
>> +		OPT_END(),
>> +	};
>> +
>> +	argc =3D parse_options(argc, argv, prefix, run_options,
>> +			     builtin_hook_usage, PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DAS=
HDASH);
>> +
>> +	if (argc > 2) {
>> +		if (strcmp(argv[2], "--") &&
>> +		    strcmp(argv[2], "--end-of-options"))
>> +			/* Having a -- for "run" is mandatory */
>> +			usage_with_options(builtin_hook_usage, run_options);
>> +		/* Add our arguments, start after -- */
>> +		for (i =3D 3 ; i < argc; i++)
>> +			strvec_push(&opt.args, argv[i]);
>> +	}
>> +
>> +	/* Need to take into account core.hooksPath */
>> +	git_config(git_default_config, NULL);
>> +
>> +	hook_name =3D argv[1];
>> +	hook_path =3D find_hook(hook_name);
>> +	if (!hook_path) {
>> +		error("cannot find a hook named %s", hook_name);
>> +		return 1;
>> +	}
>> +	rc =3D run_found_hooks(hook_name, hook_path, &opt);
>
> Hum, what's the reasoning for not letting the hook.h call look up the
> hook path for itself? I scanned through the v1 cover and older version
> of this patch and didn't see any reasoning. To me, having the builtin
> look up paths feels like incorrect layering.

I see you end up addressing this yourself below, i.e. some users want to
silently ignore missing hooks, others want to error (as in this case).

>> +int cmd_hook(int argc, const char **argv, const char *prefix)
>> +{
>> +	struct option builtin_hook_options[] =3D {
>> +		OPT_END(),
>> +	};
>> +
>> +	if (!strcmp(argv[1], "run"))
>> +		return run(argc, argv, prefix);
>
> Hum. This means that 'run' will still be included in argv for run(),
> which I see that it works around silently. I personally find that to be
> confusing - maybe at least a comment pointing it out, if you don't like
> the idea of adjusting argv before passing it to run()?

It's not something I actively changed IIRC, i.e. it just came out of the
general refactoring of minimizing the command. I tihnk it would also
make sense (probably more sense) to adjust argv/argc as you suggest.

>> diff --git a/git.c b/git.c
>> index 18bed9a9964..540909c391f 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -538,6 +538,7 @@ static struct cmd_struct commands[] =3D {
>>  	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
>>  	{ "hash-object", cmd_hash_object },
>>  	{ "help", cmd_help },
>> +	{ "hook", cmd_hook, RUN_SETUP },
>
> Hm. RUN_SETUP requires a gitdir, which I suppose makes sense as this is
> a pre-config-hooks world.
>
> Does this mean "git send-email" will abort if I try to run it with no
> gitdir (which I often do)? I looked ahead to patch 10 and it doesn't
> look like there's a significant change to the error handling, so I guess
> that if it works for me today, it will work for me with this change too.
>
> Later config-based hooks will mean that such hooks could exist without a
> gitdir, but we can cross that bridge when we get there :)

Right, since it's a way more limited command used for only running hooks
by git itself it's a RUN_SETUP. I had some preliminary WIP work (based
on yours, obviously) to make it a RUN_SETUP_GENTLY, but within this
series it doesn't become needed.

>> --- /dev/null
>> +++ b/hook.c
>> @@ -0,0 +1,114 @@
>> +#include "cache.h"
>> +#include "hook.h"
>> +#include "run-command.h"
>> +
>> +void run_hooks_opt_clear(struct run_hooks_opt *o)
>> +{
>> +	strvec_clear(&o->env);
>> +	strvec_clear(&o->args);
>
> Maybe more graceful to nullcheck within the _clear() function before
> dereferencing 'o'? That way callers don't need to worry about NULL
> checking on their end.

I don't feel strongly about it, but I tihnk doing it this way is
consistent with other APIs in git. I.e. you do:

    struct something blah =3D BLAH_INIT;
    [...]
    blah_release(&blah);

And we simply assume that "blah" isn't NULL, and that any field
mandatory via the "INIT" initialization can be assumed not to be NULL.

>> +static int pick_next_hook(struct child_process *cp,
>> +			  struct strbuf *out,
>> +			  void *pp_cb,
>> +			  void **pp_task_cb)
>> +{
>> +	struct hook_cb_data *hook_cb =3D pp_cb;
>> +	struct hook *run_me =3D hook_cb->run_me;
>> +
>> +	if (!run_me)
>> +		BUG("did we not return 1 in notify_hook_finished?");
>
> I'm not sure I like this message, even as a BUG(), although the things
> I'd rather say ("run_me was NULL unexpectedly!") are obvious as soon as
> you grep the codebase. So I think I dislike it for no reason :)

I think I just added that as an assertion during development, could be
turned into somethin gelse.

> [...]
>
>> +static int notify_start_failure(struct strbuf *out,
>> +				void *pp_cb,
>> +				void *pp_task_cp)
>> +{
>> +	struct hook_cb_data *hook_cb =3D pp_cb;
>> +	struct hook *attempted =3D pp_task_cp;
>> +
>> +	/* |=3D rc in cb */
>> +	hook_cb->rc |=3D 1;
>
> Yuck, I think I wrote this comment... yikes. Maybe something like
> "hook_cb->rc reflects cumulative failure state" instead?

*nod*, more on this below...

>> +static int notify_hook_finished(int result,
>> +				struct strbuf *out,
>> +				void *pp_cb,
>> +				void *pp_task_cb)
>> +{
>> +	struct hook_cb_data *hook_cb =3D pp_cb;
>> +
>> +	/* |=3D rc in cb */
>> +	hook_cb->rc |=3D result;
>
> (And same as above.)

..and this...

>> +int run_found_hooks(const char *hook_name, const char *hook_path,
>> +		    struct run_hooks_opt *options)
>> +{
>> +	struct hook my_hook =3D {
>> +		.hook_path =3D hook_path,
>
> As mentioned earlier, I think it is neater - and better for config-based
> hooks in the future - if my_hook.hook_path is set by find_hooks()
> directly instead of by being passed in, here. (I expect you did it this
> way because one of the later hooks lives in an odd place - but I seem to
> remember that one being strange in other ways, too, and I ended up
> letting it manage its own affairs in my attempt. So I'll look forward to
> seeing whether you handled that differently.)

Yeah, the designated initializers made a few things much nicer.


>
> [...]
>
>> +int run_hooks(const char *hook_name, struct run_hooks_opt *options)
>> +{
>> +	const char *hook_path;
>> +	int ret;
>> +	if (!options)
>> +		BUG("a struct run_hooks_opt must be provided to run_hooks");
>> +
>> +	hook_path =3D find_hook(hook_name);
>> +
>> +	/* Care about nonexistence? Use run_found_hooks() */
>> +	if (!hook_path)
>> +		return 0;
>
> Ah, I see - you've done it this way so that builtin/hook.c can complain
> "You tried to run pre-commit hook but you don't even have one!".

Sounds better.

> Hm. I think I dislike this comment for the same reason I dislike the one
> much earlier in this patch - it's different from how I would have
> written it. But I do think it still conveys the exact same information (I
> would have said "If you need to act on a missing hook, use
> run_found_hooks() instead") so chalk it up to difference in tone
> preferences and ignore me :)
>
>> diff --git a/hook.h b/hook.h
> [...]
>> +	/* Number of threads to parallelize across */
>> +	int jobs;
>
> I wonder whether it's worth changing the comments here...

So more generally (continuing the "and this" above), I really tried to
not change the comments, structure, names, order etc. of your initial
series unless it was necessary for the stated aims of minimizing and
simplifying this.

That was all in order to make it easier for you to eventually rebase on
top of this, or to pick it up. I.e. it leaves most things as subsets of
corresponding patches of yours.

But if you think this approach is good / would want to pick it up and
run with it that would make me happy, and I think at that point you
should continue tweaking/adjusting anything like this that you want,
since the non-tweaking of it was something I did for your benefit, but
if you don't mind...

> [...]
>> +/*
>> + * Callback provided to feed_pipe_fn and consume_sideband_fn.
>> + */
>
> ...and here, since they don't mean anything in the context of this
> specific commit? But they will mean something later on in the series.

*ditto*

>> +/*
>> + * Calls find_hook(hookname) and runs the hooks (if any) with
>> + * run_found_hooks().
>> + */
>> +int run_hooks(const char *hook_name, struct run_hooks_opt *options);
>> +
>> +/*
>> + * Takes an already resolved hook and runs it. Internally the simpler
>> + * run_hooks() will call this.
>> + */
>> +int run_found_hooks(const char *hookname, const char *hook_path,
>> +		    struct run_hooks_opt *options);
>
> The comments in the header here resolve any concerns I had about the
> comments in the run_hooks() implementation. I like these a lot.
>
>> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
>> new file mode 100755
>> index 00000000000..f6ff6c4a493
>> --- /dev/null
>> +++ b/t/t1800-hook.sh
>> @@ -0,0 +1,131 @@
>> +#!/bin/bash
>> +
>> +test_description=3D'git-hook command'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'git hook run -- nonexistent hook' '
>
> Nit: Since you take '--' in 'git hook run' now, can you use something els=
e as
> a delimiter in the test names? I keep reading these as "here we will
> call `git hook run -- nonexistent hook`" :/

Yeah, makes sense, maybe ": " more generally in this test?

>> +	cat >stderr.expect <<-\EOF &&
>> +	error: cannot find a hook named does-not-exist
>> +	EOF
>> +	test_expect_code 1 git hook run does-not-exist 2>stderr.actual &&
>> +	test_cmp stderr.expect stderr.actual
>
> I'm not wild about matching directly against the error message; that
> means that the test will be a pain to update any time we update the
> error message language. I'd prefer an approach where we check that the
> error is for the reason we expect (by ensuring .git/hooks/does-not-exist
> is not there in the fs) and then check that 'git hook run' fails, but do
> not particularly care about the error message.

I generally prefer it, but as noted above, "if you want to pick it up..." :)

FWIW yes I agree it's a bit of a pain, but having run into a lot of
things of the form:

    cmd 2>err &&
    grep "some message I expect" err

hiding issues like the message being duplicated, or an unexpected
additional error/warning being there, I think it's best just to test_cmp
the full output (inserting relevant OIDs if needed) when possible.

>> +test_expect_success 'git hook run -- stdout and stderr handling' '
>
> I have a slight preference towards "the name of the test tells me
> exactly what is supposed to happen" - which means I'd prefer to see this
> named "stdout and stderr both write to hook's stderr". Too chatty,
> maybe, though.
>
>> +test_expect_success 'git hook run -- out-of-repo runs excluded' '
>> +	write_script .git/hooks/test-hook <<-EOF &&
>> +	echo Test hook
>> +	EOF
>> +
>> +	nongit test_must_fail git hook run test-hook
>
> I wonder if it's necessary to enforce this. I'm just thinking, in a
> config-based hook world later on, it will make sense to allow nongit
> runs - specifically, I'd use the heck out of a send-email hook to fixup
> my In-Reply-To lines, and I always run git-send-email from a nongit dir,
> because I keep all my mailed patches stored away out of repo.
>
> What's the general feeling towards "this is how it works, but we don't
> have a good reason to require it"?

I for one think tests should assert existing behavior, we now have
RUN_SETUP so it would be a bug for thaht not to error, so a test is
asserting it. It doesn't mean that we shouldn't willy-nilly change this
later on if and when it's expected that we have a RUN_SETUP_GENTLY.

>> +test_expect_success 'git -c core.hooksPath=3D<PATH> hook run' '
>> +	mkdir my-hooks &&
>> +	write_script my-hooks/test-hook <<-EOF &&
>> +	echo Hook ran >>actual
>> +	EOF
>> +
>> +	cat >expect <<-\EOF &&
>> +	Test hook
>> +	Hook ran
>> +	Hook ran
>> +	Hook ran
>> +	Hook ran
>> +	EOF
>
> I'm not sure I like this - collecting multiple runs into one "actual"
> and only comparing it once at the end. Are there other places in the
> codebase that do this?

Yeah, that's some ad-hoc nastyness, would be better if it attributed
specific runs or otherwise asserted the "we expected to run" otherwise.

>> +
>> +	# Test various ways of specifying the path. See also
>> +	# t1350-config-hooks-path.sh
>> +	>actual &&
>> +	git hook run test-hook 2>>actual &&
>> +	git -c core.hooksPath=3Dmy-hooks hook run test-hook 2>>actual &&
>> +	git -c core.hooksPath=3Dmy-hooks/ hook run test-hook 2>>actual &&
>> +	git -c core.hooksPath=3D"$PWD/my-hooks" hook run test-hook 2>>actual &&
>> +	git -c core.hooksPath=3D"$PWD/my-hooks/" hook run test-hook 2>>actual =
&&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'set up a pre-commit hook in core.hooksPath' '
>> +	>actual &&
>> +	mkdir -p .git/custom-hooks .git/hooks &&
>> +	write_script .git/custom-hooks/pre-commit <<-\EOF &&
>> +	echo CUSTOM >>actual
>> +	EOF
>> +	write_script .git/hooks/pre-commit <<-\EOF
>> +	echo NORMAL >>actual
>> +	EOF
>> +'
>
> Is this setup test a leftover from a later commit?

Hrm, maybe... :)

> Overall, I think I like the direction your reroll is going - I've needed
> some time to process it. Hopefully I'll be able to get through all or
> most of the series this week, but there's a lot going on here, too. I'll
> do what I can. Thanks for the help.

Yeah, will reply to any qusetions etc; and as noted above my initial
goal here was "hey, what about this approach", so if you wanted to pick
this up & run with it...

This particular version of the series is at github.com/avar/git.git's
es-avar/config-based-hooks-3 b.t.w.
