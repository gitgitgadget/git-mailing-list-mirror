Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EDAECAAD5
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 10:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiH2KAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 06:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiH2KAS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 06:00:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E88DEC2
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 03:00:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s11so9388243edd.13
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=k47xK8d14C8S2zi7UdExNjq6JPG5hWd1WmcEmNcuz9c=;
        b=JMO9eQNPtbw1TYyQIAW50Szp5gN1x3hm3w1gk9R4ypb309gVo3OHvbUYMWRWV8g+NX
         FMs143/i2QGBnUVeisTxl0H3T0xhB/emc74/r0U25CSczsjc2dGo4yfUEnzXvxhMGWxg
         juSyMJEzuFoGM2knIbgGcqBrfzAOn56j5YAX2/iqpZmJkRZSkGuW9vUgXY4TdMj1FtBe
         hciQGSyZqH2rJ2q90b7jLyZyvU/Ev8/7namINevEjURnf4UUnjRR53fA7fvs0wEpiqjR
         eG3SokeSJuHHnId9IXb9BExo2hbmVTYamMuufCiKFCl7n4C6ktiOuqOnUa4iV6huZjuu
         oBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=k47xK8d14C8S2zi7UdExNjq6JPG5hWd1WmcEmNcuz9c=;
        b=T4gFzUyLTnFe2fwxWrljyVnGf0br4T9YYry2mYRfp89OvpZMI52ay6MDaQqWpFlTwL
         M6r7UvnIaZWRNMrPnuozQCxf3+UVEtEeBkZM441XHKq66Immt4OzIaHGeAR0aGupfiQH
         SkSBqHLs7ryvE0KjotK2YGByPBJTd44Y0YeflE+tgNDaanoQVD8HjJ3y//Q9xR+7w+Bm
         UrBgmlwZ+Jf/1bSqfmzbBeu+5H5zHSwnn2JyYAlg71v588rRP0WCdprCF8R3ank00Mue
         DexuMHX7xN7OcUfDNmxbz/MPkczKMIXR8XfD8QK8mWjZxOyUBmX7H8G8pr5/rCWyWPz2
         zavQ==
X-Gm-Message-State: ACgBeo2v9ee3EHepkLcg6GpnIMGOij5j6bFnykyJDTklDKEUcnc3Noyn
        NVG5ZXaE26bJXdPODE3ZRO+XqO6Rrd8=
X-Google-Smtp-Source: AA6agR62pSg/DDfushb7F6t10tkXzwbgOyawKc/W7Q43nrTJ7J5jBT3kWoe5KTUjIk/T1jPkV4eDuw==
X-Received: by 2002:a05:6402:288b:b0:444:26fd:d4c4 with SMTP id eg11-20020a056402288b00b0044426fdd4c4mr15828687edb.249.1661767213327;
        Mon, 29 Aug 2022 03:00:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090631c800b0073bf84be798sm4335251ejf.142.2022.08.29.03.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 03:00:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oSbYx-001dyq-1Y;
        Mon, 29 Aug 2022 12:00:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 07/16] bisect--helper: migrate to OPT_SUBCOMMAND()
Date:   Mon, 29 Aug 2022 11:38:13 +0200
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
 <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
 <5b7a3d58b4f84f72e1ae2196fa67c76b0a6302ad.1661604264.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <5b7a3d58b4f84f72e1ae2196fa67c76b0a6302ad.1661604264.git.gitgitgadget@gmail.com>
Message-ID: <220829.86wnar2wus.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 27 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>

> -static const char * const git_bisect_helper_usage[] = {
> -	N_("git bisect--helper --bisect-reset [<commit>]"),
> -	"git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]",
> -	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
> -					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
> -	"git bisect--helper --bisect-next",
> -	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
> -	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
> -	N_("git bisect--helper --bisect-replay <filename>"),
> -	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
> -	"git bisect--helper --bisect-visualize",
> -	N_("git bisect--helper --bisect-run <cmd>..."),
> +static const char * const bisect_usage[] = {
> +	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
> +	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]"
> +	   "    [<pathspec>...]"),
> +	N_("git bisect (bad|new) [<rev>]"),
> +	N_("git bisect (good|old) [<rev>...]"),
> +	N_("git bisect terms [--term-good | --term-bad]"),
> +	N_("git bisect skip [(<rev>|<range>)...]"),
> +	N_("git bisect next"),
> +	N_("git bisect reset [<commit>]"),
> +	N_("git bisect (visualize|view)"),
> +	N_("git bisect replay <logfile>"),
> +	N_("git bisect log"),
> +	N_("git bisect run <cmd>..."),
> +	NULL
> +};

Parts of this are erroneously reverting bits of 959d670d1a4 (i18n:
remove from i18n strings that do not hold translatable parts,
2022-01-31).

I.e. the N_() should not be there in cases like "git bisect next", only
commands that have placeholders like "<rev>".

> +static const char * const bisect_start_usage[] = {
> +	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
> +	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]"
> +	   "    [<pathspec>...]"),
> +	NULL
> +};

Rather than copy/pasting these we can define them once & re-use that
definition with a macro. See builtin/commit-graph.c and 8757b35d443
(commit-graph: define common usage with a macro, 2021-08-23).

(Ditto elided below)

> +	argc = parse_options(argc, argv, prefix, options,
> +			     bisect_reset_usage,  PARSE_OPT_STOP_AT_NON_OPTION);

Nit: Stray " " (double space) here in the argument list.

>  		printf(_("Your current terms are %s for the old state\n"
>  			 "and %s for the new state.\n"),
>  		       terms.term_good, terms.term_bad);
>  		return 0;

Using '%s'-quoting here for the interpolated terms would help
translators & normalize this with other bessages. It was (partially)
like this in the pre-image, but since we're changing the whole string
anyway...

> +	if (argc > 0)
> +		usage_msg_opt(_("requires 0 argument"),
> +			      bisect_next_usage, options);

Earlier a message says "requires either no argument[...]", but here we
say "requires 0 argument", which sounds like it expects a literal "0" in
the argument list.

But what we actually mean is "requires no arguments", let's change the
string to that.

> -	}
> +

Here's a "whitespace change while at it..."...

>  finish:
> +	strvec_clear(&orig_argv);
> +

Ditto here, why make this clear/release visually separate from the
cleanup below?:

>  	string_list_clear(&revs, 0);
>  	string_list_clear(&states, 0);
>  	strbuf_release(&start_head);

^^^ i.e. this.

> @@ -1004,8 +1135,10 @@ static int process_replay_line(struct strbuf *line)
>  	if (!strcmp(p, "start")) {
>  		struct strvec argv = STRVEC_INIT;
>  		int res;
> +

Ditto whitespace change here...

> +		strvec_push(&argv, p);
>  		sq_dequote_to_strvec(rev, &argv);
> [...]
>  		struct strvec argv = STRVEC_INIT;
>  		int res;
> +

...and here.., I think these are good, but they add up, perhaps worth
splitting up various whitespace-prettification in this series for
readability into its own commit.

> [...]
> @@ -1272,105 +1445,26 @@ static int bisect_run(int argc, const char **argv)
>  
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
> -	enum {
> -		BISECT_RESET = 1,
> -		BISECT_TERMS,
> -		BISECT_START,
> -		BISECT_NEXT,
> -		BISECT_STATE,
> -		BISECT_LOG,
> -		BISECT_REPLAY,
> -		BISECT_SKIP,
> -		BISECT_VISUALIZE,
> -		BISECT_RUN,
> -	} cmdmode = 0;
> +	parse_opt_subcommand_fn *fn = NULL;
>  	int res = 0;
>  	struct option options[] = {
> -		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
> -			 N_("reset the bisection state"), BISECT_RESET),
> -		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
> -			 N_("print out the bisect terms"), BISECT_TERMS),
> -		OPT_CMDMODE(0, "bisect-start", &cmdmode,
> -			 N_("start the bisect session"), BISECT_START),
> -		OPT_CMDMODE(0, "bisect-next", &cmdmode,
> -			 N_("find the next bisection commit"), BISECT_NEXT),
> -		OPT_CMDMODE(0, "bisect-state", &cmdmode,
> -			 N_("mark the state of ref (or refs)"), BISECT_STATE),
> -		OPT_CMDMODE(0, "bisect-log", &cmdmode,
> -			 N_("list the bisection steps so far"), BISECT_LOG),
> -		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
> -			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
> -		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
> -			 N_("skip some commits for checkout"), BISECT_SKIP),
> -		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
> -			 N_("visualize the bisection"), BISECT_VISUALIZE),
> -		OPT_CMDMODE(0, "bisect-run", &cmdmode,
> -			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
> +		OPT_SUBCOMMAND("reset", &fn, cmd_bisect_reset),
> +		OPT_SUBCOMMAND("terms", &fn, cmd_bisect_terms),
> +		OPT_SUBCOMMAND("start", &fn, cmd_bisect_start),
> +		OPT_SUBCOMMAND("next", &fn, cmd_bisect_next),
> +		OPT_SUBCOMMAND("state", &fn, cmd_bisect_state),
> +		OPT_SUBCOMMAND("log", &fn, cmd_bisect_log),
> +		OPT_SUBCOMMAND("replay", &fn, cmd_bisect_replay),
> +		OPT_SUBCOMMAND("skip", &fn, cmd_bisect_skip),
> +		OPT_SUBCOMMAND("visualize", &fn, cmd_bisect_visualize),
> +		OPT_SUBCOMMAND("run", &fn, cmd_bisect_run),
>  		OPT_END()
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options,
> -			     git_bisect_helper_usage,
> -			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN_OPT);
> -
> -	if (!cmdmode)
> -		usage_with_options(git_bisect_helper_usage, options);
> +			     bisect_usage, 0);
>  
> -	switch (cmdmode) {
> -	case BISECT_RESET:
> -		if (argc > 1)
> -			return error(_("--bisect-reset requires either no argument or a commit"));
> -		res = bisect_reset(argc ? argv[0] : NULL);
> -		break;
> -	case BISECT_TERMS:
> -		if (argc > 1)
> -			return error(_("--bisect-terms requires 0 or 1 argument"));
> -		res = bisect_terms(argc == 1 ? argv[0] : NULL);
> -		break;
> -	case BISECT_START:
> -		set_terms("bad", "good");
> -		res = bisect_start(argc, argv);
> -		break;
> -	case BISECT_NEXT:
> -		if (argc)
> -			return error(_("--bisect-next requires 0 arguments"));
> -		get_terms();
> -		res = bisect_next(prefix);
> -		break;
> -	case BISECT_STATE:
> -		set_terms("bad", "good");
> -		get_terms();
> -		res = bisect_state(argc, argv);
> -		break;
> -	case BISECT_LOG:
> -		if (argc)
> -			return error(_("--bisect-log requires 0 arguments"));
> -		res = bisect_log();
> -		break;
> -	case BISECT_REPLAY:
> -		if (argc != 1)
> -			return error(_("no logfile given"));
> -		set_terms("bad", "good");
> -		res = bisect_replay(argv[0]);
> -		break;
> -	case BISECT_SKIP:
> -		set_terms("bad", "good");
> -		get_terms();
> -		res = bisect_skip(argc, argv);
> -		break;
> -	case BISECT_VISUALIZE:
> -		get_terms();
> -		res = bisect_visualize(argc, argv);
> -		break;
> -	case BISECT_RUN:
> -		if (!argc)
> -			return error(_("bisect run failed: no command provided."));
> -		get_terms();
> -		res = bisect_run(argc, argv);
> -		break;
> -	default:
> -		BUG("unknown subcommand %d", cmdmode);
> -	}
> +	res = fn(argc, argv, prefix);
>  	free_terms();

The real meat of this is here, and looks much better on top of SZEDER's
series in "next" ...

>  
>  	return is_bisect_success(res) ? 0 : -res;
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 405cf76f2a3..e19847eba0d 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -58,26 +58,26 @@ case "$#" in
>  	help)
>  		git bisect -h ;;
>  	start)
> -		git bisect--helper --bisect-start "$@" ;;
> +		git bisect--helper start "$@" ;;
>  	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
> -		git bisect--helper --bisect-state "$cmd" "$@" ;;
> +		git bisect--helper state "$cmd" "$@" ;;
>  	skip)
> -		git bisect--helper --bisect-skip "$@" || exit;;
> +		git bisect--helper skip "$@" || exit;;
>  	next)
>  		# Not sure we want "next" at the UI level anymore.
> -		git bisect--helper --bisect-next "$@" || exit ;;
> +		git bisect--helper next "$@" || exit ;;
>  	visualize|view)
> -		git bisect--helper --bisect-visualize "$@" || exit;;
> +		git bisect--helper visualize "$@" || exit;;
>  	reset)
> -		git bisect--helper --bisect-reset "$@" ;;
> +		git bisect--helper reset "$@" ;;
>  	replay)
> -		git bisect--helper --bisect-replay "$@" || exit;;
> +		git bisect--helper replay "$@" || exit;;
>  	log)
> -		git bisect--helper --bisect-log || exit ;;
> +		git bisect--helper log || exit ;;
>  	run)
> -		git bisect--helper --bisect-run "$@" || exit;;
> +		git bisect--helper run "$@" || exit;;
>  	terms)
> -		git bisect--helper --bisect-terms "$@" || exit;;
> +		git bisect--helper terms "$@" || exit;;
>  	*)
>  		usage ;;
>  	esac

...I did wonder if OPT_SUBCOMMAND() supported subcommands "--like-this"
as opposed to "this", if so the renaming of all of these could be split
up into its own change.

Maybe not worth it, but it's a very large commit, which does at least:

 * Migration to that new API
 * Stray whitespace changes while at it
 * Migrating the sub-command functions themselves to parse_options()
   (good!), but not strictly required for OPT_SUBCOMMAND() (an
   orthagonal change).
 * Renaming the "verbs" for the internal helper from
   e.g. "--bisect-skip" to "skip", which is what we want eventually, but
   does inflate the almost 500-line change.

