Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAE0C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 06:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345112AbiA2G7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 01:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbiA2G7K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 01:59:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB270C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 22:59:09 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a8so23631879ejc.8
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 22:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=whzCAPFHZzZIZB8Jq3pPLF0mJdHGgZlLJUrVJQUgxSg=;
        b=Pdrx4HwqORh5zPRRa3+tJW9L0GCn3v2zwjI4t0PzC39Tnxx3p0b1XUfnX6XksbDrB6
         eWFNPw1sD4SgBBDMmRBvvbDZ4m5nzlcX+BJmJeg+NdPL6Gj71bJA06idwHQ/qw/gRehy
         Kc5wkq+c0bN7tRrD1g1gQW+dJIDj0Vxgw8fyQjWaFknc2fLz/I09BFfpse4p3KQlqPKs
         cQG8+GEzw9X35i/hKrgBANqMlnf8ugH+Pn6lA4sAj2KEHT/IaKp63DRgZZfwje7aCR3J
         ry8XHp2RiSy/qE4fdzmr8oPkkZ0nLwUHVgGcYi03HDi8fkeWMhSfKXP3tVmWBDnONbZo
         td2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=whzCAPFHZzZIZB8Jq3pPLF0mJdHGgZlLJUrVJQUgxSg=;
        b=VLFORDdt9/PJqmIljVZSuG4JTTM34XoeWVn6rEKLayCJiAussM8ja5DeJ1vRaVVyJy
         YsN4yp4y9pnwvG/hU2Fi8iuEhDIAwzlX4MIpZP0uJq16qt/NLL7r528JSHlt+wRb9RQD
         CnUdDgtTbPT4958l0S9FT98InWM8Q1R9ytedyEAmfKmeYqV9OKPWX67R8XC2lRrPZq+a
         U3hnZ+P8Kb063xDT16r/kYgW0pKqWLXOn4/BPoXB1aQ5Mu6yR1UZNOc8WcQLNBQJImur
         YYOabuMxVesSifz54j5jq01j2xU0cmHrM3bURgaIm107iYf0Um7jqYjPW3Hqm8Xb4JPN
         eTBA==
X-Gm-Message-State: AOAM531mOKD+t2gnpmw5CQ0YxU0OaFYaJk0BNYwdX64om2kTQjRuzS8N
        xRlMhdX7NHm67fDgMiIFNyMrHhRvx4dNhlxA
X-Google-Smtp-Source: ABdhPJyo14mQzKDU2xsfTLtafEzVIg6HRwwSYlqNHY91Ydij8QrwEaM7YPBPPeX47TOWStjVXaZPyA==
X-Received: by 2002:a17:907:9253:: with SMTP id kb19mr9549177ejb.707.1643439547913;
        Fri, 28 Jan 2022 22:59:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o11sm13948121edq.5.2022.01.28.22.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 22:59:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nDhhS-003lTC-Qj;
        Sat, 29 Jan 2022 07:59:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 07/11] bisect: move even the option parsing to
 `bisect--helper`
Date:   Sat, 29 Jan 2022 07:47:52 +0100
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
 <515e86e20758ed7f5b4a8ce8f38bfbbac27ec42a.1643328752.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <515e86e20758ed7f5b4a8ce8f38bfbbac27ec42a.1643328752.git.gitgitgadget@gmail.com>
Message-ID: <220129.86pmobauyt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 28 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
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
> dramatically simpler implementation. Therefore, we now keep the
> `parse_options()` call primarily to support `-h` and little else.

Yes, in this case we're hardly getting any use out of parse_options() as
it is.

And here the problem is that we're going from parsing a "git <cmd>
--bisect-FOO" to "git <cmd> FOO", and parse_options() obviously is more
set up to like the former form.

For your playing around with flags (the "not set up for that" for
PARSE_OPT_NODASH is that it doesn't like "long options"?) I wonder if
you considered/tried just setting the argc you pass to it such that it
only looks at the "FOO" item.

Or just parse_options_step(), which is the supported function equivalent
of "I set up my state, now parse this one item".

Anyway...

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/bisect--helper.c | 172 ++++++++++++++++-----------------------
>  git-bisect.sh            |  49 +----------
>  2 files changed, 72 insertions(+), 149 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 219fa99cd0b..4450305c81c 100644
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

...I think you're throwing the baby out with the bathwater here. The
parse_options() version is much nicer to maintain, and will to
auto-alignment of the help output.

As builtin/commit-graph.c, builtin/stash.c, builtin/bundle.c we can and
do have these manual if/else if chains in combination with
parse_options(). There's no need to change this part (except for the
s/bisect-helper/bisect/ etc. change.

>  
> @@ -1168,115 +1184,69 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
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
> +	/* Handle -h and invalid options */
> +	parse_options(argc - 1, argv + 1, prefix, options,
> +		      git_bisect_usage,
> +		      PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN |
> +		      PARSE_OPT_ONE_SHOT | PARSE_OPT_STOP_AT_NON_OPTION);

Why isn't PARSE_OPT_STOP_AT_NON_OPTION sufficient here? That's pretty
much our "this is subcommand" pattern flag. See:

    git grep -W PARSE_OPT_STOP_AT_NON_OPTION -- builtin

Which lists the examples above.

I think this should strive to just copy an existing pattern as-is. See
e.g. 92f480909f7 (multi-pack-index: refactor "goto usage" pattern,
2021-08-23) for one change to make them a bit more consistent (as they
all solve the same problem)....

> [...]
> +		else {
> +			char *msg = xstrfmt(_("unknown command: '%s'"), command);
> +			usage_msg_opt(msg, git_bisect_usage, options);

...e.g. this part in cmd_commit_graph is nicer.
