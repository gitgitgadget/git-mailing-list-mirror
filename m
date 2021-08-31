Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4EFC43214
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B2B61074
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbhHaTGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbhHaTGN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 15:06:13 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B48C061760
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 12:05:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s11so142722pgr.11
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QUVkYjAH+nrSfc0+kxysFz/uYu33xdoZO3mwVBbL8b4=;
        b=gyhLzxA7wXaiTz9SB5GW635oZY3xnbFVFoAijte8vB4KHRSSmLaLgYcjVJaV15Pl2S
         vJ6y1aEVNuVkJORNOXo4RNfYDFxiGSH4npYUhasVDtdaJxSS8rFvuY9fjVVjP+hYVAVN
         Upl/QTyqwzZR9tf6gsSxz3m5Zr2lC65PQZjPWy+eAiNhPIUYhh50Y79FoL3yb56vDnO8
         f/sPpDta+EkpJAfFHjNjvmRWOAerSMnscRqToT8eN40C4wDISj3chvMQVOshTyOcGTG5
         hJi0tiIKo9ssY3K3Ihci8x/w+HpuT/kXY3thmtugG4Z1yVTrqRaWSJryDb+kIaqPuUxI
         muBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QUVkYjAH+nrSfc0+kxysFz/uYu33xdoZO3mwVBbL8b4=;
        b=KQJezaWg0uTGb3IlYdw0DEq1SO3bIYeNXQ+Z1mElqtLkRXoBp9/v2WDOytOUxNz9vX
         m963uMTGdQZDC8wjwyd4mJsQ3tGN0jrq2txtyrj2pBcjsUkuV7o+hoJngPi/ALdaIUL3
         v8S2mv4Xi0Q8X8qSAURrEb3kKqG6aQcRK/1Qe21jVrtB3ju8UTCbkguIJxfc+Jnj0x+b
         v7Nq8ESCw1o2y/KQfcvhBTJXp2g9ssqPL4aTO1EPzh0xe+RukIliGBZTafgNzQy8jRiZ
         VWLg/tUsK3Ck5O1+fP/614jWx6oPYJWcGloy5elu+Ng7SqUqcaWXUiqtgx/BRpNbNjHt
         Q3DA==
X-Gm-Message-State: AOAM531z4Oa0cn4XB5U4b/X9k4zi9IzjJE3EiGQevgNN1OP4Jptlg7QU
        9v0aFypdymoneqpUy6Y7rc+7UV/Yvo4lQg==
X-Google-Smtp-Source: ABdhPJzn4B1YvrbupaeZlmq8hcBAJavSKLEAstU14hXgbBc2XV2E9k016ExQvq23siB6zx5xHl0L3w==
X-Received: by 2002:a63:1358:: with SMTP id 24mr28314800pgt.327.1630436717437;
        Tue, 31 Aug 2021 12:05:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:9007:bdba:3f52:14ff])
        by smtp.gmail.com with ESMTPSA id g140sm11216326pfb.100.2021.08.31.12.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 12:05:16 -0700 (PDT)
Date:   Tue, 31 Aug 2021 12:05:10 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] hook: include hooks from the config
Message-ID: <YS59ZvJIzCeMxefs@google.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-6-emilyshaffer@google.com>
 <87lf4qeh86.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lf4qeh86.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 09:30:25PM +0200, Ævar Arnfjörð Bjarmason wrote:

Disclaimer: I was writing a pretty involved reply to this and my tmux
session crashed, so hopefully I can recall it well enough. Sorry if
anything is confusing :)

> 
> On Wed, Aug 18 2021, Emily Shaffer wrote:
> 
> > Teach the hook.[hc] library to parse configs to populare the list of
> > hooks to run for a given event.
> 
> s/populare/populate/
ack

> 
> > Multiple commands can be specified for a given hook by providing
> > multiple "hook.<friendly-name>.command = <path-to-hook>" and
> > "hook.<friendly-name>.event = <hook-event>" lines. Hooks will be run in
> > config order of the "hook.<name>.event" lines.
> 
> The "will be run in order" probably needs some amending to account for
> --jobs, no?

I changed it to "started in order", and tacked on "(but may be run in
parallel)".

> 
> > For example:
> >
> >   $ git config --list | grep ^hook
> >   hook.bar.command=~/bar.sh
> >   hook.bar.event=pre-commit
> 
> Perhaps the example should use:
> 
>     git config --get-regexp '^hook\.'

Sure, I better not inflict my crappy habits on readers ;)

> 
> >   $ git hook run
> >   # Runs ~/bar.sh
> >   # Runs .git/hooks/pre-commit
> 
> And this "# Runs" is not actual output by git, but just an explanation
> for what happens, better to reword it somehow so it doesn't give that
> impression.
> 
> But the example also seems to be broken, surely it should be "git hook
> run bar", not "git hook run"? Reading ahead, but presumably no-arg
> doesn't run all known hooks...

Ah, even the suggestion was wrong - it should be `git hook run
pre-commit`. Zzzz. :)

> 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  Documentation/config/hook.txt |  18 ++++
> >  Documentation/git-hook.txt    |  57 ++++++++++++-
> >  builtin/hook.c                |   3 +-
> >  hook.c                        | 153 ++++++++++++++++++++++++++++++----
> >  hook.h                        |   7 +-
> >  t/t1800-hook.sh               | 141 ++++++++++++++++++++++++++++++-
> >  6 files changed, 357 insertions(+), 22 deletions(-)
> >
> > diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
> > index 96d3d6572c..c394756328 100644
> > --- a/Documentation/config/hook.txt
> > +++ b/Documentation/config/hook.txt
> > @@ -1,3 +1,21 @@
> > +hook.<name>.command::
> > +	A command to execute whenever `hook.<name>` is invoked. `<name>` should
> > +	be a unique "friendly" name which you can use to identify this hook
> > +	command. (You can specify when to invoke this command with
> > +	`hook.<name>.event`.) The value can be an executable on your device or a
> > +	oneliner for your shell. If more than one value is specified for the
> > +	same `<name>`, the last value parsed will be the only command executed.
> > +	See linkgit:git-hook[1].
> 
> Hrm, so here we say "If more than one value is specified for ... the
> last value parsed will be the only command executed", but in the commit
> message it's:
> 
>     Multiple commands can be specified for a given hook by providing
>     multiple "hook.<friendly-name>.command = <path-to-hook>" and
>     "hook.<friendly-name>.event = <hook-event>" lines.
> 
> As we've discussed earlier I've got a preference for the former, but
> just reading this commit message & doc the for the first time I still
> don't know what you went for, looks like one or the other needs
> updating. I'm intentionally not reading ahead as I review this.
> 
> Saying that it's a "unique name", but also discussing what happens if
> it's not unique in the sense that we have multiple "hook.<name>.*" is a
> bit confusing. I think I know what you're going for, perhaps something
> like this would be better to describe it:
> 
>     For a "hook.<name>.{command,event}" hook entry you'll need to pick a
>     "<name>" that's not shared with any other hook, if you do normal
>     single-value config semantics apply and git will use the last
>     provided value.
> 
> Or something...

Yeah, I ended up reworking this a lot. I think the manpage needs some
structuring work, to be honest - I wrote a lot about how to use 'git
hook run' to add hooks to your wrapper around Git, for example, and
stuck it in a section.

While I'm waiting for your next reroll, I'm planning to send the doc to
a tech writer we've got on loan internally and see if they've got any
tips for us here. Hopefully they can help us out :)

I'm going to snip the rest of the doc comments, because while I know I
took action on them last week, I'm not sure I recall what I changed;
and I'm hoping to get a third party to take a look. I did read them all, I
promise :)

> > +	/* to enable oneliners, let config-specified hooks run in shell.
> > +	 * config-specified hooks have a name. */
> 
> nit: usual style is multi-line comments like:
> 
>     /*
>      * some text[...]
>      * some more...
>      */
> 
> Not:
> 
>     /* text here right away[...]
>      * some more ... */

ACK. By the way, anybody have tips for making Vim gracefully transition
from

 /* happily typing a single line comment

to

 /*
  * happily typing a single line comment that
  * became super long

Wonder if anything is working quite well for anybody, because I mess
this up all the time ;)

I guess I could just check for this kind of thing at pre-commit time.
Maybe with a hook. ;) ;)

> 
> > +	cp->use_shell = !!run_me->name;
> > +
> >  	/* add command */
> > -	if (hook_cb->options->absolute_path)
> > -		strvec_push(&cp->args, absolute_path(run_me->hook_path));
> > -	else
> > -		strvec_push(&cp->args, run_me->hook_path);
> > +	if (run_me->name) {
> > +		/* ...from config */
> > +		struct strbuf cmd_key = STRBUF_INIT;
> > +		char *command = NULL;
> > +
> > +		strbuf_addf(&cmd_key, "hook.%s.command", run_me->name);
> 
> Missing strbuf_release() for this later?

Yep, thanks.

> 
> > +		if (git_config_get_string(cmd_key.buf, &command)) {
> > +			/* TODO test me! */
> 
> ...seems easy enough to just have a test for..., i.e. an *.event entry
> with no *.command.

Yeah, this TODO was probably for myself, so I wouldn't push the reroll
without writing the test. That worked really well....

> 
> > +			die(_("'hook.%s.command' must be configured "
> > +			      "or 'hook.%s.event' must be removed; aborting.\n"),
> > +			    run_me->name, run_me->name);
> > +		}
> > +
> > +		strvec_push(&cp->args, command);
> > +	} else {
> > +		/* ...from hookdir. */
> > +		const char *hook_path = NULL;
> > +		/*
> > +		 *
> 
> Nit: Too few \n before the text in a comment earlier, too many here :)
*facepalm*

> 
> > +		 * At this point we are already running, so don't validate
> > +		 * whether the hook name is known or not.
> 
> ...because it was done earlier somewhere, or...?

Yeah, that validation occurs in list_hooks() instead. I'll make the
comment more clear.

> 
> > +		 */
> > +		hook_path = find_hook_gently(hook_cb->hook_name);
> > +		if (!hook_path)
> > +			BUG("hookdir hook in hook list but no hookdir hook present in filesystem");
> > +
> > +		if (hook_cb->options->absolute_path)
> > +			hook_path = absolute_path(hook_path);
> > +
> > +		strvec_push(&cp->args, hook_path);
> > +	}
> > +
> >  
> >  	/*
> >  	 * add passed-in argv, without expanding - let the user get back
> > @@ -228,8 +346,11 @@ static int notify_start_failure(struct strbuf *out,
> >  
> >  	hook_cb->rc |= 1;
> >  
> > -	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
> > -		    attempted->hook_path);
> > +	if (attempted->name)
> > +		strbuf_addf(out, _("Couldn't start hook '%s'\n"),
> > +		    attempted->name);
> > +	else
> > +		strbuf_addstr(out, _("Couldn't start hook from hooks directory\n"));
> >  
> >  	return 1;
> >  }
> > diff --git a/hook.h b/hook.h
> > index 6b7b2d14d2..621bd2cde1 100644
> > --- a/hook.h
> > +++ b/hook.h
> > @@ -27,8 +27,11 @@ int hook_exists(const char *hookname);
> >  
> >  struct hook {
> >  	struct list_head list;
> > -	/* The path to the hook */
> > -	const char *hook_path;
> > +	/*
> > +	 * The friendly name of the hook. NULL indicates the hook is from the
> > +	 * hookdir.
> > +	 */
> > +	const char *name;
> >  
> >  	/*
> >  	 * Use this to keep state for your feed_pipe_fn if you are using
> > diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> > index 217db848b3..ef2432f53a 100755
> > --- a/t/t1800-hook.sh
> > +++ b/t/t1800-hook.sh
> > @@ -1,13 +1,29 @@
> >  #!/bin/bash
> >  
> > -test_description='git-hook command'
> > +test_description='git-hook command and config-managed multihooks'
> >  
> >  . ./test-lib.sh
> >  
> > +setup_hooks () {
> > +	test_config hook.ghi.event pre-commit --add
> > +	test_config hook.ghi.command "/path/ghi" --add
> > +	test_config_global hook.def.event pre-commit --add
> > +	test_config_global hook.def.command "/path/def" --add
> 
> Isn't --add redundant here? Seems no test is stressing multi-value
> hook.{ghi,def}.* from a quick glance...

Sounds like a failing in the test suite ;)

Will remove --add from the command configs, and will stick in test for a
hook to run in multiple places.

I went back and forth over whether to add the extra .event config in the
setup vs. in a specific test, and I decided that by adding it in the
setup, we get some implicit "this is fine" assurance, as well as the one
explicit test (which I added just now) that the hook shows up in both
places.

> 
> > +}
> > +
> > +setup_hookdir () {
> > +	mkdir .git/hooks
> > +	write_script .git/hooks/pre-commit <<-EOF
> > +	echo \"Legacy Hook\"
> > +	EOF
> > +	test_when_finished rm -rf .git/hooks
> > +}
> > +
> >  test_expect_success 'git hook usage' '
> >  	test_expect_code 129 git hook &&
> >  	test_expect_code 129 git hook run &&
> >  	test_expect_code 129 git hook run -h &&
> > +	test_expect_code 129 git hook list -h &&
> 
> Doesn't this belong in a previous commit that added "git hook list", not
> here?

Yes, nice. Thanks.

> 
> >  	test_expect_code 129 git hook run --unknown 2>err &&
> >  	grep "unknown option" err
> >  '
> > @@ -153,4 +169,127 @@ test_expect_success 'stdin to hooks' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'git hook list orders by config order' '
> > +	setup_hooks &&
> > +
> > +	cat >expected <<-EOF &&
> > +	def
> > +	ghi
> > +	EOF
> > +
> > +	git hook list pre-commit >actual &&
> > +	test_cmp expected actual
> > +'
> > +
> > +test_expect_success 'git hook list reorders on duplicate event declarations' '
> > +	setup_hooks &&
> > +
> > +	# 'def' is usually configured globally; move it to the end by
> > +	# configuring it locally.
> > +	test_config hook.def.event "pre-commit" --add &&
> 
> Ah, well the --add belongs here, but not needed in setup_hooks, right?

Addressed above.

> > +
> > +	cat >input <<-EOF &&
> > +	1
> > +	2
> > +	3
> > +	EOF
> > +
> > +	cat >expected <<-EOF &&
> > +	a1
> > +	a2
> > +	a3
> > +	b1
> > +	b2
> > +	b3
> > +	EOF
> 
> For any here-docs without variables, use <<-\EOF, note the backslash.
ACK


Thanks.
 - Emily
