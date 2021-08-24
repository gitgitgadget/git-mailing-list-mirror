Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88205C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 20:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659D561371
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 20:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhHXULh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 16:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhHXULh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 16:11:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80134C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 13:10:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mf2so28228655ejb.9
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jKz1UqAr/zX1J+YcNUkgAEAD7cFnYEtjDGnoVncxexA=;
        b=lAPXvgU9pXfhBpOXe19Ims8VDYJ7eIIfx6nA3nVhjk2OmoWwFkgIH25+aBYlZWhSmi
         eec2Ubc5X+WSUiA/DYaM/ipKAYBhdKXMzkwakrjipXSSZaxgxM2j+twB+f9yFtGjNd8Q
         vM/SShLUqvGPMmM3ETmeJ/PU6V14rZqDO8TGkuEY9BLA8qo0vanCp8svNeHTYHfcP7cd
         3vrJJ2dmrMqG2ahUy9xBA/cYOl68n+oqdD8dz1yThHdBP87mw0rj/hoFBxmbZyHa8m/P
         /0KlCc84YT3cNyDOpKdq44s8YqQcqULcmX6UZ2lvLoNMuBA6kwO3AOdVfRPZ6jGZwW1b
         bIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jKz1UqAr/zX1J+YcNUkgAEAD7cFnYEtjDGnoVncxexA=;
        b=gJN8Pvi5s0S/3m7iOIk1ie282KshobZzuifVYxPb+IsoolED/HT9pNHsHmU2NTIy/Y
         M8gtHKsnxlcZe3ShwybTyxcNKDwuw2WpG1qgsPhlr6W34og9VD2qxO2lU/2+0fBO7P83
         gS7OJNgTLIm9B10tmDnhrbh4j76OQsLVdidSaQCRVk61EaYhA05XxPbnen0iw1+JBFWI
         qZbcOmbya99QqrJxxeG+VuX3raiPFw4decthi4cJIa1gGstDOeMWYceDFqSRYj/mdO/1
         Zb3jObvE8LODw8ffLPHjhrf8dVsN/NCHDr91kXj18t6TSLpQkUAGgJM2xVMi8CP3o/sj
         q2Pg==
X-Gm-Message-State: AOAM5336IDgMoaPJelwz9aHbpkiafo0aArRg5UJaC46efx/wGNRlovyp
        3vOxSOyQYZQcSSFAwk5k5dg=
X-Google-Smtp-Source: ABdhPJz1iSlqu0F8HyWEkYEidYGcOh1jR8vdP6olgldIYTMcpXmTLKc4pOs7VeB9GY+UV9r/8LiYHg==
X-Received: by 2002:a17:906:3a58:: with SMTP id a24mr42277144ejf.109.1629835850985;
        Tue, 24 Aug 2021 13:10:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qt23sm3537483ejb.26.2021.08.24.13.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 13:10:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] hook: include hooks from the config
Date:   Tue, 24 Aug 2021 21:30:25 +0200
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-6-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210819033450.3382652-6-emilyshaffer@google.com>
Message-ID: <87lf4qeh86.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 18 2021, Emily Shaffer wrote:

> Teach the hook.[hc] library to parse configs to populare the list of
> hooks to run for a given event.

s/populare/populate/

> Multiple commands can be specified for a given hook by providing
> multiple "hook.<friendly-name>.command = <path-to-hook>" and
> "hook.<friendly-name>.event = <hook-event>" lines. Hooks will be run in
> config order of the "hook.<name>.event" lines.

The "will be run in order" probably needs some amending to account for
--jobs, no?

> For example:
>
>   $ git config --list | grep ^hook
>   hook.bar.command=~/bar.sh
>   hook.bar.event=pre-commit

Perhaps the example should use:

    git config --get-regexp '^hook\.'

>   $ git hook run
>   # Runs ~/bar.sh
>   # Runs .git/hooks/pre-commit

And this "# Runs" is not actual output by git, but just an explanation
for what happens, better to reword it somehow so it doesn't give that
impression.

But the example also seems to be broken, surely it should be "git hook
run bar", not "git hook run"? Reading ahead, but presumably no-arg
doesn't run all known hooks...

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/config/hook.txt |  18 ++++
>  Documentation/git-hook.txt    |  57 ++++++++++++-
>  builtin/hook.c                |   3 +-
>  hook.c                        | 153 ++++++++++++++++++++++++++++++----
>  hook.h                        |   7 +-
>  t/t1800-hook.sh               | 141 ++++++++++++++++++++++++++++++-
>  6 files changed, 357 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
> index 96d3d6572c..c394756328 100644
> --- a/Documentation/config/hook.txt
> +++ b/Documentation/config/hook.txt
> @@ -1,3 +1,21 @@
> +hook.<name>.command::
> +	A command to execute whenever `hook.<name>` is invoked. `<name>` should
> +	be a unique "friendly" name which you can use to identify this hook
> +	command. (You can specify when to invoke this command with
> +	`hook.<name>.event`.) The value can be an executable on your device or a
> +	oneliner for your shell. If more than one value is specified for the
> +	same `<name>`, the last value parsed will be the only command executed.
> +	See linkgit:git-hook[1].

Hrm, so here we say "If more than one value is specified for ... the
last value parsed will be the only command executed", but in the commit
message it's:

    Multiple commands can be specified for a given hook by providing
    multiple "hook.<friendly-name>.command = <path-to-hook>" and
    "hook.<friendly-name>.event = <hook-event>" lines.

As we've discussed earlier I've got a preference for the former, but
just reading this commit message & doc the for the first time I still
don't know what you went for, looks like one or the other needs
updating. I'm intentionally not reading ahead as I review this.

Saying that it's a "unique name", but also discussing what happens if
it's not unique in the sense that we have multiple "hook.<name>.*" is a
bit confusing. I think I know what you're going for, perhaps something
like this would be better to describe it:

    For a "hook.<name>.{command,event}" hook entry you'll need to pick a
    "<name>" that's not shared with any other hook, if you do normal
    single-value config semantics apply and git will use the last
    provided value.

Or something...

> +hook.<name>.event::
> +	The hook events which should invoke `hook.<name>`. `<name>` should be a
> +	unique "friendly" name which you can use to identify this hook. The
p> +	value should be the name of a hook event, like "pre-commit" or "update".
> +	(See linkgit:githooks[5] for a complete list of hooks Git knows about.)
> +	On the specified event, the associated `hook.<name>.command` will be
> +	executed. More than one event can be specified if you wish for
> +	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1].
> +
>  hook.jobs::
>  	Specifies how many hooks can be run simultaneously during parallelized
>  	hook execution. If unspecified, defaults to the number of processors on
> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> index d1db084e4f..9c6cbdc2eb 100644
> --- a/Documentation/git-hook.txt
> +++ b/Documentation/git-hook.txt
> @@ -27,12 +27,65 @@ Git is unlikely to use for a native hook later on. For example, Git is much less
>  likely to create a `mytool-validate-commit` hook than it is to create a
>  `validate-commit` hook.
>  
> +This command parses the default configuration files for pairs of configs like
> +so:
> +
> +  [hook "linter"]
> +    event = pre-commit
> +    command = ~/bin/linter --c
> +
> +In this example, `[hook "linter"]` represents one script - `~/bin/linter --c` -
> +which can be shared by many repos, and even by many hook events, if appropriate.

OK, so now it seems like "hook.<name>.command" is 1=1 for "hook.<name>"
and "command", and "hook.<name>.event" is 1=many, maybe that's correct,
but reading on...

> +Commands are run in the order Git encounters their associated
> +`hook.<name>.event` configs during the configuration parse (see
> +linkgit:git-config[1]). Although multiple `hook.linter.event` configs can be
> +added, only one `hook.linter.command` event is valid - Git uses "last-one-wins"
> +to determine which command to run.

...ah, and confirmed here...

> +So if you wanted your linter to run when you commit as well as when you push,
> +you would configure it like so:
> +
> +  [hook "linter"]
> +    event = pre-commit
> +    event = pre-push
> +    command = ~/bin/linter --c
> +
> +With this config, `~/bin/linter --c` would be run by Git before a commit is
> +generated (during `pre-commit`) as well as before a push is performed (during
> +`pre-push`).

Aside: I know we're discussing a presumably imaginary linter, but it's a
bit jarring to see "--" for a one-letter short-option, perhaps "-c" or
"--check" for the example...

> +And if you wanted to run your linter as well as a secret-leak detector during
> +only the "pre-commit" hook event, you would configure it instead like so:
> +
> +  [hook "linter"]
> +    event = pre-commit
> +    command = ~/bin/linter --c
> +  [hook "no-leaks"]
> +    event = pre-commit
> +    command = ~/bin/leak-detector

I think these examples would flow a bit more naturally if we started by
discussing how to setup one configured hook, then two unrelated hooks
(perhaps a "commit-msg" and "pre-commit" hook), and then finally the
cases where a given "hook.<name>.command" has multiple
"hook.<name>.event" entries. My assumption in suggesting that is that
that's, respectively, the most common to less common use cases.

> +With this config, before a commit is generated (during `pre-commit`), Git would
> +first start `~/bin/linter --c` and second start `~/bin/leak-detector`. It would
> +evaluate the output of each when deciding whether to proceed with the commit.
> +
> +For a full list of hook events which you can set your `hook.<name>.event` to,
> +and how hooks are invoked during those events, see linkgit:githooks[5].

Let's discuss what happens with unknown values for `hook.<name>.event`
here, i.e. just "are ignored".

[I'll discuss my opinions on the new and revised config schema in
another mail, just commenting on the patch here in terms of its stated
goals].

> +In general, when instructions suggest adding a script to
> +`.git/hooks/<hook-event>`, you can specify it in the config instead by running
> +`git config --add hook.<some-name>.command <path-to-script> && git config --add
> +hook.<some-name>.event <hook-event>` - this way you can share the script between
> +multiple repos. That is, `cp ~/my-script.sh ~/project/.git/hooks/pre-commit`
> +would become `git config --add hook.my-script.command ~/my-script.sh && git
> +config --add hook.my-script.event pre-commit`.

I think this would benefit a lot from being split up into code example
prose, so:

    You can [...]

    ----
    git config -add hook.<some-name>.command <path-to-script> &&
    git config -add hook.<some-name>.event <hook-event>
    ----

It's more lines, but I think a lot more readable.

I think the part of this that says "You can share the script between
multiple repos" could really use some elaboration.

I.e. if the user is following an example where they'd otherwise edit
.git/hooks/ and then just run "git config", they'll add it to
.git/config.

So then it won't be shared between multiple repos, what I think this
paragraph is trying to go for is that instead of say:

    ln -s ~/my-script.sh .git/hooks/pre-commit

You can instead do, with configurable hooks:

    git config hook.my-pre-commit.command ~/my-script.sh
    git config --add hook.my-pre-commit.event pre-commit

Notice how I omitted the --add for the first one. It's also confusing if
we're documenting "*.command" as "last one wins" to use --add with it,
in an example that's discussing how to add it to some local repo, no?

Or is this example really trying to discuss what would happen if you:

    cat >~/my-script.sh
    ...
    ^C
    chmod +x ~/my-script.sh
    git config --global hook.my-pre-commit.command ~/my-script.sh
    git config hook.my-pre-commit.event pre-commit

That's not clear to me, in any case, I think we'd do well to lead with
the former, and then discuss the latter. I.e. "here's what you'd symlink
before, now it's in config like this", and then discuss how you'd set
"global" or perhaps included config, which isn't possible with the
.git/hooks/<script> mechanism.

>  SUBCOMMANDS
>  -----------
>  
>  run::
> -	Run the `<hook-name>` hook. See linkgit:githooks[5] for
> -	the hook names we support.
> +	Runs hooks configured for `<hook-name>`, in the order they are
> +	discovered during the config parse.

This and any other things that discuss how hooks are run in detail
should really talk about the thing running .git/hooks/<name> *and* any
configured hooks, and on the subject of --jobs and ordering we should
also talk about what the order of config v.s. .git/hooks/<name> is.

> +	/* to enable oneliners, let config-specified hooks run in shell.
> +	 * config-specified hooks have a name. */

nit: usual style is multi-line comments like:

    /*
     * some text[...]
     * some more...
     */

Not:

    /* text here right away[...]
     * some more ... */


> +	cp->use_shell = !!run_me->name;
> +
>  	/* add command */
> -	if (hook_cb->options->absolute_path)
> -		strvec_push(&cp->args, absolute_path(run_me->hook_path));
> -	else
> -		strvec_push(&cp->args, run_me->hook_path);
> +	if (run_me->name) {
> +		/* ...from config */
> +		struct strbuf cmd_key = STRBUF_INIT;
> +		char *command = NULL;
> +
> +		strbuf_addf(&cmd_key, "hook.%s.command", run_me->name);

Missing strbuf_release() for this later?

> +		if (git_config_get_string(cmd_key.buf, &command)) {
> +			/* TODO test me! */

...seems easy enough to just have a test for..., i.e. an *.event entry
with no *.command.

> +			die(_("'hook.%s.command' must be configured "
> +			      "or 'hook.%s.event' must be removed; aborting.\n"),
> +			    run_me->name, run_me->name);
> +		}
> +
> +		strvec_push(&cp->args, command);
> +	} else {
> +		/* ...from hookdir. */
> +		const char *hook_path = NULL;
> +		/*
> +		 *

Nit: Too few \n before the text in a comment earlier, too many here :)

> +		 * At this point we are already running, so don't validate
> +		 * whether the hook name is known or not.

...because it was done earlier somewhere, or...?

> +		 */
> +		hook_path = find_hook_gently(hook_cb->hook_name);
> +		if (!hook_path)
> +			BUG("hookdir hook in hook list but no hookdir hook present in filesystem");
> +
> +		if (hook_cb->options->absolute_path)
> +			hook_path = absolute_path(hook_path);
> +
> +		strvec_push(&cp->args, hook_path);
> +	}
> +
>  
>  	/*
>  	 * add passed-in argv, without expanding - let the user get back
> @@ -228,8 +346,11 @@ static int notify_start_failure(struct strbuf *out,
>  
>  	hook_cb->rc |= 1;
>  
> -	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
> -		    attempted->hook_path);
> +	if (attempted->name)
> +		strbuf_addf(out, _("Couldn't start hook '%s'\n"),
> +		    attempted->name);
> +	else
> +		strbuf_addstr(out, _("Couldn't start hook from hooks directory\n"));
>  
>  	return 1;
>  }
> diff --git a/hook.h b/hook.h
> index 6b7b2d14d2..621bd2cde1 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -27,8 +27,11 @@ int hook_exists(const char *hookname);
>  
>  struct hook {
>  	struct list_head list;
> -	/* The path to the hook */
> -	const char *hook_path;
> +	/*
> +	 * The friendly name of the hook. NULL indicates the hook is from the
> +	 * hookdir.
> +	 */
> +	const char *name;
>  
>  	/*
>  	 * Use this to keep state for your feed_pipe_fn if you are using
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 217db848b3..ef2432f53a 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -1,13 +1,29 @@
>  #!/bin/bash
>  
> -test_description='git-hook command'
> +test_description='git-hook command and config-managed multihooks'
>  
>  . ./test-lib.sh
>  
> +setup_hooks () {
> +	test_config hook.ghi.event pre-commit --add
> +	test_config hook.ghi.command "/path/ghi" --add
> +	test_config_global hook.def.event pre-commit --add
> +	test_config_global hook.def.command "/path/def" --add

Isn't --add redundant here? Seems no test is stressing multi-value
hook.{ghi,def}.* from a quick glance...

> +}
> +
> +setup_hookdir () {
> +	mkdir .git/hooks
> +	write_script .git/hooks/pre-commit <<-EOF
> +	echo \"Legacy Hook\"
> +	EOF
> +	test_when_finished rm -rf .git/hooks
> +}
> +
>  test_expect_success 'git hook usage' '
>  	test_expect_code 129 git hook &&
>  	test_expect_code 129 git hook run &&
>  	test_expect_code 129 git hook run -h &&
> +	test_expect_code 129 git hook list -h &&

Doesn't this belong in a previous commit that added "git hook list", not
here?

>  	test_expect_code 129 git hook run --unknown 2>err &&
>  	grep "unknown option" err
>  '
> @@ -153,4 +169,127 @@ test_expect_success 'stdin to hooks' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git hook list orders by config order' '
> +	setup_hooks &&
> +
> +	cat >expected <<-EOF &&
> +	def
> +	ghi
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'git hook list reorders on duplicate event declarations' '
> +	setup_hooks &&
> +
> +	# 'def' is usually configured globally; move it to the end by
> +	# configuring it locally.
> +	test_config hook.def.event "pre-commit" --add &&

Ah, well the --add belongs here, but not needed in setup_hooks, right?

> +
> +	cat >expected <<-EOF &&
> +	ghi
> +	def
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'git hook list shows hooks from the hookdir' '
> +	setup_hookdir &&
> +
> +	cat >expected <<-EOF &&
> +	hook from hookdir
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'inline hook definitions execute oneliners' '
> +	test_config hook.oneliner.event "pre-commit" &&
> +	test_config hook.oneliner.command "echo \"Hello World\"" &&
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
> +	test_config hook.sample-hook.event pre-commit &&
> +	test_config hook.sample-hook.command "\"$(pwd)/sample-hook.sh\"" &&
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
> +test_expect_success 'stdin to multiple hooks' '
> +	test_config hook.stdin-a.event "test-hook" --add &&
> +	test_config hook.stdin-a.command "xargs -P1 -I% echo a%" --add &&
> +	test_config hook.stdin-b.event "test-hook" --add &&
> +	test_config hook.stdin-b.command "xargs -P1 -I% echo b%" --add &&
> +
> +	cat >input <<-EOF &&
> +	1
> +	2
> +	3
> +	EOF
> +
> +	cat >expected <<-EOF &&
> +	a1
> +	a2
> +	a3
> +	b1
> +	b2
> +	b3
> +	EOF

For any here-docs without variables, use <<-\EOF, note the backslash.
