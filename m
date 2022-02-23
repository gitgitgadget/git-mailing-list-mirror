Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EF2C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 10:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbiBWKQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 05:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbiBWKQv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 05:16:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3228B6F9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 02:16:22 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p14so51192963ejf.11
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 02:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LOT/YKcKMmoPSarfJVkPkLWik6vrXi9tEM36Jh+Vd4w=;
        b=cX0NZsno44XzoErHROGbdK9nINnoR9iJJoA6bMRvTTJdp10gZNevDMhB8rP1oiDbyD
         AweLtv6nqZO+xkVKetKkH+uBkWXlLyUJ8zy8m98LVf5cBIGVizfy8pV3hLYIpk8kh6sW
         WUQkAcDLcNfW7QYLDFOAdHdir7e3fMejxJynPQtCC8TVmLp3NJPyfa/fwN/HY98pvp4F
         5nt0dFX0vMai3Sjm+JioDq3nJLlydyZUI+YaWxdeZFD0z4qv7hmqsrEZzXTICnu26Wzk
         OTGOdF2wRMmOrHAStnTTwAIkDQw5b+D8x5r5I0OHzsPUniCAe+cuWrS4ArlwD7sUF+4w
         pJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LOT/YKcKMmoPSarfJVkPkLWik6vrXi9tEM36Jh+Vd4w=;
        b=xZxEAZTi9TQz8ZN9KfYJwDSBCV48+FUqrZW2uSw9NHbqDKeNWk28ku6ELGdLuc1Iy0
         jbFwKfMksGPdMxNq/97KTkPL9/+MnaPZiTB9KK8MzYJehC5YbuLHSgCkIopoxo5CXIDY
         q4g/ky2+kjZte0cp9OMCeVvztFP5qD5ItkBmACUUYXn7zFv2nurCzNGPeA6g/yBJsuF8
         +77mMj3EkTkB76OY18QJmPr4tT8tu2eBdCZ9b2LKDOeKgGvO71cJTWJ0ZXL4/EBG4Ub+
         j8ElYIdi9L1ieBOOvUdlZ+odsSsPxEY41YNL/HTtkQcgUsEgu+p/T/hbUXNmBEW84Y+K
         C0Wg==
X-Gm-Message-State: AOAM530DrPS/MByERE9+2QCMfbVkD5T/xEtiwMLKVSO8gvQDGUxezGOw
        YnhL/e/bzPW8K/JzHJEZd2Q+pRBoB+M=
X-Google-Smtp-Source: ABdhPJxwnkqri+e5j2v8DnIWRqd3IjHihaN3Xo+6JNjfYT+iRImuA9q8IBYMLrFvLeuRPQGDh9h08g==
X-Received: by 2002:a17:906:1188:b0:6ce:f315:21df with SMTP id n8-20020a170906118800b006cef31521dfmr22697384eja.591.1645611380863;
        Wed, 23 Feb 2022 02:16:20 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ka26sm2771153ejc.170.2022.02.23.02.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 02:16:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMoh1-006FfR-Aj;
        Wed, 23 Feb 2022 11:16:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 11/14] bisect: move even the option parsing to
 `bisect--helper`
Date:   Wed, 23 Feb 2022 10:47:36 +0100
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
 <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
 <dc04b06206bbb833ce3a7fa893d724d00fe58a74.1645547423.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <dc04b06206bbb833ce3a7fa893d724d00fe58a74.1645547423.git.gitgitgadget@gmail.com>
Message-ID: <220223.86v8x56g7g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On our journey to a fully built-in `git bisect`, this is the
> second-to-last step.
>
> Side note: The `if (!strcmp(...)) ... else if (!strcmp(...)) ... else if
> (!strcmp(...)) ...` chain seen in this patch was not actually the first
> idea how to convert the command modes to sub-commands. Since the
> `bisect--helper` command already used the `parse-opions` API with neatly
> set-up command modes, naturally the idea was to use `PARSE_OPT_NODASH`
> to support proper sub-commands instead. However, the `parse-options` API
> is not set up for that, and even after making that option work with long
> options, it turned out that `STOP_AT_NON_OPTION` and `KEEP_UNKNOWN`
> would have to be used but these options were not designed to work
> together. So it would appear as if a lot of work would have to be done
> just to be able to use `parse_options()` just to parse the sub-command,
> instead of a simple `if...else if` chain, the latter being a
> dramatically simpler implementation.

As I noted in
https://lore.kernel.org/git/220129.86pmobauyt.gmgdl@evledraar.gmail.com/:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/bisect--helper.c | 133 ++++++++++++++++-----------------------
>  git-bisect.sh            |  49 +--------------
>  2 files changed, 56 insertions(+), 126 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 5228964937d..ef0b06d594b 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -20,18 +20,34 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
>  static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
>  static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
>  
> -static const char * const git_bisect_helper_usage[] = {
> -	N_("git bisect--helper --bisect-reset [<commit>]"),
> -	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
> -	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
> -					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
> -	N_("git bisect--helper --bisect-next"),
> -	N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
> -	N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"),
> -	N_("git bisect--helper --bisect-replay <filename>"),
> -	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
> -	N_("git bisect--helper --bisect-visualize"),
> -	N_("git bisect--helper --bisect-run <cmd>..."),
> +static const char * const git_bisect_usage[] = {
> +	N_("git bisect help\n"
> +	   "\tprint this long help message."),
> +	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]\n"
> +	   "\t\t [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]\n"
> +	   "\treset bisect state and start bisection."),
> +	N_("git bisect (bad|new) [<rev>]\n"
> +	   "\tmark <rev> a known-bad revision/\n"
> +	   "\t\ta revision after change in a given property."),
> +	N_("git bisect (good|old) [<rev>...]\n"
> +	   "\tmark <rev>... known-good revisions/\n"
> +	   "\t\trevisions before change in a given property."),
> +	N_("git bisect terms [--term-good | --term-bad]\n"
> +	   "\tshow the terms used for old and new commits (default: bad, good)"),
> +	N_("git bisect skip [(<rev>|<range>)...]\n"
> +	   "\tmark <rev>... untestable revisions."),
> +	N_("git bisect next\n"
> +	   "\tfind next bisection to test and check it out."),
> +	N_("git bisect reset [<commit>]\n"
> +	   "\tfinish bisection search and go back to commit."),
> +	N_("git bisect (visualize|view)\n"
> +	   "\tshow bisect status in gitk."),
> +	N_("git bisect replay <logfile>\n"
> +	   "\treplay bisection log."),
> +	N_("git bisect log\n"
> +	   "\tshow bisect log."),
> +	N_("git bisect run <cmd>...\n"
> +	   "\tuse <cmd>... to automatically bisect."),
>  	NULL
>  };

Even that doesn't explain why this needs to be changed as
well. I.e. this could just be:
	
	diff --git a/builtin/bisect.c b/builtin/bisect.c
	index e8a346fa516..d27b80ddaf3 100644
	--- a/builtin/bisect.c
	+++ b/builtin/bisect.c
	@@ -20,33 +20,18 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
	 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
	 
	 static const char * const builtin_bisect_usage[] = {
	-	N_("git bisect help\n"
	-	   "\tprint this long help message."),
	+	N_("git bisect reset [<commit>]"),
	+	N_("git bisect terms [--term-good | --term-old | --term-bad | --term-new]"),
	 	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]\n"
	-	   "\t\t [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]\n"
	-	   "\treset bisect state and start bisection."),
	-	N_("git bisect (bad|new) [<rev>]\n"
	-	   "\tmark <rev> a known-bad revision/\n"
	-	   "\t\ta revision after change in a given property."),
	-	N_("git bisect (good|old) [<rev>...]\n"
	-	   "\tmark <rev>... known-good revisions/\n"
	-	   "\t\trevisions before change in a given property."),
	-	N_("git bisect terms [--term-good | --term-bad]\n"
	-	   "\tshow the terms used for old and new commits (default: bad, good)"),
	-	N_("git bisect skip [(<rev>|<range>)...]\n"
	-	   "\tmark <rev>... untestable revisions."),
	-	N_("git bisect next\n"
	-	   "\tfind next bisection to test and check it out."),
	-	N_("git bisect reset [<commit>]\n"
	-	   "\tfinish bisection search and go back to commit."),
	-	N_("git bisect (visualize|view)\n"
	-	   "\tshow bisect status in gitk."),
	-	N_("git bisect replay <logfile>\n"
	-	   "\treplay bisection log."),
	-	N_("git bisect log\n"
	-	   "\tshow bisect log."),
	-	N_("git bisect run <cmd>...\n"
	-	   "\tuse <cmd>... to automatically bisect."),
	+	   "                 [--no-checkout] [--first-parent] [<bad> [<good>...]]\n"
	+	   "                 [--] [<paths>...]"),
	+	N_("git bisect next"),
	+	N_("git bisect state (bad|new) [<rev>]"),
	+	N_("git bisect state (good|old) [<rev>...]"),
	+	N_("git bisect replay <filename>"),
	+	N_("git bisect skip [(<rev>|<range>)...]"),
	+	N_("git bisect visualize"),
	+	N_("git bisect run <cmd>..."),
	 	NULL
	 };

Which turns the help output into:
    
    $ ./git bisect -h
    usage: git bisect reset [<commit>]
       or: git bisect terms [--term-good | --term-old | --term-bad | --term-new]
       or: git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
                            [--no-checkout] [--first-parent] [<bad> [<good>...]]
                            [--] [<paths>...]
       or: git bisect next
       or: git bisect state (bad|new) [<rev>]
       or: git bisect state (good|old) [<rev>...]
       or: git bisect replay <filename>
       or: git bisect skip [(<rev>|<range>)...]
       or: git bisect visualize
       or: git bisect run <cmd>...

Instead of:
    
    $ ./git bisect -h
    usage: git bisect help
            print this long help message.
       or: git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
                     [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
            reset bisect state and start bisection.
       or: git bisect (bad|new) [<rev>]
            mark <rev> a known-bad revision/
                    a revision after change in a given property.
       or: git bisect (good|old) [<rev>...]
            mark <rev>... known-good revisions/
                    revisions before change in a given property.
       or: git bisect terms [--term-good | --term-bad]
            show the terms used for old and new commits (default: bad, good)
       or: git bisect skip [(<rev>|<range>)...]
            mark <rev>... untestable revisions.
       or: git bisect next
            find next bisection to test and check it out.
       or: git bisect reset [<commit>]
            finish bisection search and go back to commit.
       or: git bisect (visualize|view)
            show bisect status in gitk.
       or: git bisect replay <logfile>
            replay bisection log.
       or: git bisect log
            show bisect log.
       or: git bisect run <cmd>...
            use <cmd>... to automatically bisect.

I.e. parse_options() != the usage_with_options() formatting function in
parse-options.c. You can use one without using the other. The commit
message only claims (wrongly I think, but let's leave that aside for the
moment) that we can't use parse_options(), but doesn't say why we *also*
need to move to doing our own formatting of the usage output, those are
two different things.

As I noted in the previous round I think you were trying to retain the
OPT_CMDMODE help messages. We could use the "" parse_options() usage
feature to emit output similar to "git bisect--helper -h", but I think
just having it by the same as current built-ins is fine.

I.e. for "stash" etc. we're not emitting human readable help
explanations along with every subcommand, and could just do the same for
"git bisect".

But on to parse_options() usage:

> @@ -1168,108 +1184,69 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
>  
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
> -	enum {
> -		BISECT_START = 1,
> -		BISECT_STATE,
> -		BISECT_TERMS,
> -		BISECT_SKIP,
> -		BISECT_NEXT,
> -		BISECT_RESET,
> -		BISECT_VISUALIZE,
> -		BISECT_REPLAY,
> -		BISECT_LOG,
> -		BISECT_RUN,
> -	} cmdmode = 0;
>  	int res = 0;
>  	struct option options[] = {
> -		OPT_CMDMODE(0, "bisect-start", &cmdmode,
> -			 N_("start the bisect session"), BISECT_START),
> -		OPT_CMDMODE(0, "bisect-state", &cmdmode,
> -			 N_("mark the state of ref (or refs)"), BISECT_STATE),
> -		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
> -			 N_("print out the bisect terms"), BISECT_TERMS),
> -		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
> -			 N_("skip some commits for checkout"), BISECT_SKIP),
> -		OPT_CMDMODE(0, "bisect-next", &cmdmode,
> -			 N_("find the next bisection commit"), BISECT_NEXT),
> -		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
> -			 N_("reset the bisection state"), BISECT_RESET),
> -		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
> -			 N_("visualize the bisection"), BISECT_VISUALIZE),
> -		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
> -			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
> -		OPT_CMDMODE(0, "bisect-log", &cmdmode,
> -			 N_("list the bisection steps so far"), BISECT_LOG),
> -		OPT_CMDMODE(0, "bisect-run", &cmdmode,
> -			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
>  		OPT_END()
>  	};
>  	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
> +	const char *command = argc > 1 ? argv[1] : "help";
>  
> -	argc = parse_options(argc, argv, prefix, options,
> -			     git_bisect_helper_usage,
> -			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);

Because of thinking that we need to get rid of parse_options() here
we...

> +	if (!strcmp("-h", command) || !strcmp("help", command))
> +		usage_with_options(git_bisect_usage, options);

...end up duplicating some of its behavior here...

>  
> -	switch (cmdmode ? cmdmode : BISECT_STATE) {
> -	case BISECT_START:
> +	argc -= 2;
> +	argv += 2;
> +
> +	if (!strcmp("start", command)) {
>  		set_terms(&terms, "bad", "good");
>  		res = bisect_start(&terms, argv, argc);
> -		break;
> -	case BISECT_TERMS:
> +	} else if (!strcmp("terms", command)) {
>  		if (argc > 1)
> -			die(_("--bisect-terms requires 0 or 1 argument"));
> +			die(_("'terms' requires 0 or 1 argument"));
>  		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
> -		break;
> -	case BISECT_SKIP:
> +	} else if (!strcmp("skip", command)) {
>  		set_terms(&terms, "bad", "good");
>  		get_terms(&terms);
>  		res = bisect_skip(&terms, argv, argc);
> -		break;
> -	case BISECT_NEXT:
> +	} else if (!strcmp("next", command)) {
>  		if (argc)
> -			die(_("--bisect-next requires 0 arguments"));
> +			die(_("'next' requires 0 arguments"));
>  		get_terms(&terms);
>  		res = bisect_next(&terms, prefix);
> -		break;
> -	case BISECT_RESET:
> +	} else if (!strcmp("reset", command)) {
>  		if (argc > 1)
> -			die(_("--bisect-reset requires either no argument or a commit"));
> +			die(_("'reset' requires either no argument or a commit"));
>  		res = bisect_reset(argc ? argv[0] : NULL);
> -		break;
> -	case BISECT_VISUALIZE:
> +	} else if (one_of(command, "visualize", "view", NULL)) {
>  		get_terms(&terms);
>  		res = bisect_visualize(&terms, argv, argc);
> -		break;
> -	case BISECT_REPLAY:
> +	} else if (!strcmp("replay", command)) {
>  		if (argc != 1)
>  			die(_("no logfile given"));
>  		set_terms(&terms, "bad", "good");
>  		res = bisect_replay(&terms, argv[0]);
> -		break;
> -	case BISECT_LOG:
> +	} else if (!strcmp("log", command)) {
>  		if (argc)
> -			die(_("--bisect-log requires 0 arguments"));
> +			die(_("'log' requires 0 arguments"));
>  		res = bisect_log();
> -		break;
> -	case BISECT_RUN:
> +	} else if (!strcmp("run", command)) {
>  		if (!argc)
>  			die(_("bisect run failed: no command provided."));
>  		get_terms(&terms);
>  		res = bisect_run(&terms, argv, argc);
> -		break;
> -	case BISECT_STATE:
> +	} else {
>  		set_terms(&terms, "bad", "good");
>  		get_terms(&terms);
> -		if (!cmdmode &&
> -		    (!argc || check_and_set_terms(&terms, argv[0]))) {
> -			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
> -			usage_msg_opt(msg, git_bisect_helper_usage, options);
> +		if (check_and_set_terms(&terms, command)) {
> +			char *msg = xstrfmt(_("unknown command: '%s'"), command);
> +			usage_msg_opt(msg, git_bisect_usage, options);

[Change this usage_msg_opt() to a usage_msg_optf() and drop the
xstrfmt()]

>  		}
> +		/* shift the `command` back in */
> +		argc++;
> +		argv--;
>  		res = bisect_state(&terms, argv, argc);
> -		break;
> -	default:
> -		BUG("unknown subcommand %d", cmdmode);
>  	}

..and introducing bugs here, e.g. "git bisect --blah" is now a valid way
to start a bisect", we no longer understand "git bisect <subcommand>
-h", but did before etc.

Is the reason for further extending the custom command parser here
because of e.g. the "die(..requires N arguments"? For all of those this
could follow the pattern that builtin/commit-graph.c etc. use.

I.e. just define a usage for say "log", and empty options, then pass
argc/argv to that subcommand, and have it call parse_options().

Then not only will the user get an error, they'll get the subset of "git
bisect -h" output appropriate for whatever "git bisect subcommand <bad
usage>" they invoked.
