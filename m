Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AAFC25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 10:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiHTK1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 06:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTK1h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 06:27:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F52D9DF9C
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 03:27:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r4so8276489edi.8
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 03:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=j4OhY60ZlrzTZAPFe6be7SZUoCHhop9Cnqy4WK2K6to=;
        b=g/X3kNPdJP83NkL86lKgcFu9uBpTPYC0wx82NJNbq0FlsqlNLHMxkXnSCUppvLrfaJ
         kQa2TWUF/jNglbVVdJkPuf4gKzqMrM+7mMCSC3CBlTbQ2BVhBAfJ92hyUQZvymSciSuU
         syKNUP9/sxcxiJNk76DS9DnVDyuzg7Mr0Mv/cwOn3I5XIjbc7Zzv8skcGtI5hd1knis6
         95TdTKiIOWj0n4y4mLfuFyH9uUgeugloYQ3XCSvXMFZdWlEJnHSmPb/ZwqvgjnHfQj2m
         3vwaJex+kNGjH/xyuisqGAivs9+2MlqLVmzKT+lijgdz8eAZiclHwpX4EP1dbP2kJVJj
         JESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=j4OhY60ZlrzTZAPFe6be7SZUoCHhop9Cnqy4WK2K6to=;
        b=34BB9x5whVA9X92RxpzdB3gTvYxSpbigz0kMWcds478cI8/ZOvP8qoirimmR/2qf4m
         qS3eCtvDjSuXpwrrtOIigsgqXi3BeXWOYA4/l3XA3HPogtMflhC7LUkneI1YcOUkys/r
         R8Y9mge6Y0fuTIdby939QOITCLXt+7EJsBulNayPBT5AZxc2gEsffO14zzagdpql/pK9
         tzzri9aw+QGu+Vi3loy4G2u6Y+haAkg+WkO4axHHuPOX7FLjfKF3t+KYYXQHM1HEAqcC
         oZE8Q934pkQhNX2bs3Zx3Nwbd4qVWYhqdMqiM/aj77Nny3wG5Rfd0CNEAR5PF8c1B+Ra
         TrOA==
X-Gm-Message-State: ACgBeo1K9ktKK59NfLgcDUlqOmzvUw4TRauHEkK0T4cCrYQ5Ibi4LTbF
        zAK7804Oe0+1wDJwc21dPqCf9TruGtg=
X-Google-Smtp-Source: AA6agR7UDXdZPQZBrb3TZ5L8yAOa/eP9Qzhue7egBqgu/OQgnJCyO7P4dYeAbBqfNP1FMwSi1NutOg==
X-Received: by 2002:a05:6402:451:b0:446:7349:f9e8 with SMTP id p17-20020a056402045100b004467349f9e8mr1892006edw.180.1660991254494;
        Sat, 20 Aug 2022 03:27:34 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id q3-20020a056402040300b00445e1489313sm4366894edv.94.2022.08.20.03.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 03:27:33 -0700 (PDT)
Date:   Sat, 20 Aug 2022 12:27:31 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 19/20] builtin/stash.c: let parse-options parse
 subcommands
Message-ID: <20220820102731.GC3373722@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-20-szeder.dev@gmail.com>
 <220819.86czcw59w6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220819.86czcw59w6.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 09:06:32PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Aug 19 2022, SZEDER Gábor wrote:
> 
> > 'git stash' parses its subcommands with a long list of if-else if
> > statements.  parse-options has just learned to parse subcommands, so
> > let's use that facility instead, with the benefits of shorter code,
> > and listing subcommands for Bash completion.
> >
> > Note that the push_stash() function implementing the 'push' subcommand
> > accepts an extra flag parameter to indicate whether push was assumed,
> > so add a wrapper function with the standard subcommand function
> > signature.
> >
> > Note also that this change "hides" the '-h' option in 'git stash push
> > -h' from the parse_option() call in cmd_stash(), as it comes after the
> > subcommand.  Consequently, from now on it will emit the usage of the
> > 'push' subcommand instead of the usage of 'git stash'.  We had a
> > failing test for this case, which can now be flipped to expect
> > success.
> >
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  builtin/stash.c  | 53 ++++++++++++++++++++++--------------------------
> >  t/t3903-stash.sh |  2 +-
> >  2 files changed, 25 insertions(+), 30 deletions(-)
> >
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index a14e832e9f..1ba24c1173 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -1739,6 +1739,11 @@ static int push_stash(int argc, const char **argv, const char *prefix,
> >  			     include_untracked, only_staged);
> >  }
> >  
> > +static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
> > +{
> > +	return push_stash(argc, argv, prefix, 0);
> > +}
> > +
> >  static int save_stash(int argc, const char **argv, const char *prefix)
> >  {
> >  	int keep_index = -1;
> > @@ -1787,15 +1792,28 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
> >  	pid_t pid = getpid();
> >  	const char *index_file;
> >  	struct strvec args = STRVEC_INIT;
> > -
> > +	parse_opt_subcommand_fn *fn = NULL;
> >  	struct option options[] = {
> > +		OPT_SUBCOMMAND("apply", &fn, apply_stash),
> > +		OPT_SUBCOMMAND("clear", &fn, clear_stash),
> > +		OPT_SUBCOMMAND("drop", &fn, drop_stash),
> > +		OPT_SUBCOMMAND("pop", &fn, pop_stash),
> > +		OPT_SUBCOMMAND("branch", &fn, branch_stash),
> > +		OPT_SUBCOMMAND("list", &fn, list_stash),
> > +		OPT_SUBCOMMAND("show", &fn, show_stash),
> > +		OPT_SUBCOMMAND("store", &fn, store_stash),
> > +		OPT_SUBCOMMAND("create", &fn, create_stash),
> > +		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
> > +		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
> >  		OPT_END()
> >  	};
> >  
> >  	git_config(git_stash_config, NULL);
> >  
> >  	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
> > -			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_DASHDASH);
> > +			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
> > +			     PARSE_OPT_KEEP_UNKNOWN_OPT |
> > +			     PARSE_OPT_KEEP_DASHDASH);
> >  
> >  	prepare_repo_settings(the_repository);
> >  	the_repository->settings.command_requires_full_index = 0;
> > @@ -1804,33 +1822,10 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
> >  	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
> >  		    (uintmax_t)pid);
> >  
> > -	if (!argc)
> > -		return !!push_stash(0, NULL, prefix, 0);
> > -	else if (!strcmp(argv[0], "apply"))
> > -		return !!apply_stash(argc, argv, prefix);
> > -	else if (!strcmp(argv[0], "clear"))
> > -		return !!clear_stash(argc, argv, prefix);
> > -	else if (!strcmp(argv[0], "drop"))
> > -		return !!drop_stash(argc, argv, prefix);
> > -	else if (!strcmp(argv[0], "pop"))
> > -		return !!pop_stash(argc, argv, prefix);
> > -	else if (!strcmp(argv[0], "branch"))
> > -		return !!branch_stash(argc, argv, prefix);
> > -	else if (!strcmp(argv[0], "list"))
> > -		return !!list_stash(argc, argv, prefix);
> > -	else if (!strcmp(argv[0], "show"))
> > -		return !!show_stash(argc, argv, prefix);
> > -	else if (!strcmp(argv[0], "store"))
> > -		return !!store_stash(argc, argv, prefix);
> > -	else if (!strcmp(argv[0], "create"))
> > -		return !!create_stash(argc, argv, prefix);
> > -	else if (!strcmp(argv[0], "push"))
> > -		return !!push_stash(argc, argv, prefix, 0);
> > -	else if (!strcmp(argv[0], "save"))
> > -		return !!save_stash(argc, argv, prefix);
> > -	else if (*argv[0] != '-')
> > -		usage_msg_optf(_("unknown subcommand: %s"),
> > -			       git_stash_usage, options, argv[0]);
> > +	if (fn)
> > +		return !!fn(argc, argv, prefix);
> > +	else if (!argc)
> > +		return !!push_stash_unassumed(0, NULL, prefix);
> >  
> >  	/* Assume 'stash push' */
> >  	strvec_push(&args, "push");
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index 2a4c3fd61c..376cc8f4ab 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -25,7 +25,7 @@ test_expect_success 'usage on main command -h emits a summary of subcommands' '
> >  	grep -F "or: git stash show" usage
> >  '
> >  
> > -test_expect_failure 'usage for subcommands should emit subcommand usage' '
> > +test_expect_success 'usage for subcommands should emit subcommand usage' '
> >  	test_expect_code 129 git stash push -h >usage &&
> >  	grep -F "usage: git stash [push" usage
> >  '
> 
> This isn't on you, but I found the control flow here really confusing. I
> wonder if we could this cleanup before/squashed in. I may have missed
> some cases, but it passes all tests.

I think it would be better to leave this for later.  I did notice that
something is fishy around this 'force_assume' flag (argv[0] can never
possibly be "-p") added in 8c3713cede (stash: eliminate crude option
parsing, 2020-02-17), and even after your patch some of that fishiness
remains (e.g. argv[0] can't possibly be "--" either).  Unfortunately,
the commit message doesn't explains what was intended, and I couldn't
spend time on figuring it out, either.


> I.e. the whole business of pushing this "did we assume?" around goes
> away if we simply pass the command-line as-is to push_stash(), and ask
> it to determine this.
> 
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 1ba24c11737..a588389d66b 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1665,10 +1665,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  	return ret;
>  }
>  
> -static int push_stash(int argc, const char **argv, const char *prefix,
> -		      int push_assumed)
> +static int push_stash(int argc, const char **argv, const char *prefix)
>  {
> -	int force_assume = 0;
>  	int keep_index = -1;
>  	int only_staged = 0;
>  	int patch_mode = 0;
> @@ -1696,20 +1694,22 @@ static int push_stash(int argc, const char **argv, const char *prefix,
>  		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
>  		OPT_END()
>  	};
> +	int push_assumed = argc == 1 || strcmp(argv[1], "push");
>  
> -	if (argc) {
> -		force_assume = !strcmp(argv[0], "-p");
> -		argc = parse_options(argc, argv, prefix, options,
> -				     push_assumed ? git_stash_usage :
> -				     git_stash_push_usage,
> -				     PARSE_OPT_KEEP_DASHDASH);
> +	if (!push_assumed) {
> +		argc--;
> +		argv++;
>  	}
>  
> +	argc = parse_options(argc, argv, prefix, options,
> +			     push_assumed ? git_stash_usage :
> +			     git_stash_push_usage,
> +			     PARSE_OPT_KEEP_DASHDASH);
>  	if (argc) {
>  		if (!strcmp(argv[0], "--")) {
>  			argc--;
>  			argv++;
> -		} else if (push_assumed && !force_assume) {
> +		} else if (push_assumed) {
>  			die("subcommand wasn't specified; 'push' can't be assumed due to unexpected token '%s'",
>  			    argv[0]);
>  		}
> @@ -1739,11 +1739,6 @@ static int push_stash(int argc, const char **argv, const char *prefix,
>  			     include_untracked, only_staged);
>  }
>  
> -static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
> -{
> -	return push_stash(argc, argv, prefix, 0);
> -}
> -
>  static int save_stash(int argc, const char **argv, const char *prefix)
>  {
>  	int keep_index = -1;
> @@ -1791,8 +1786,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
>  	const char *index_file;
> -	struct strvec args = STRVEC_INIT;
> -	parse_opt_subcommand_fn *fn = NULL;
> +	parse_opt_subcommand_fn *fn = push_stash;
>  	struct option options[] = {
>  		OPT_SUBCOMMAND("apply", &fn, apply_stash),
>  		OPT_SUBCOMMAND("clear", &fn, clear_stash),
> @@ -1803,7 +1797,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
>  		OPT_SUBCOMMAND("show", &fn, show_stash),
>  		OPT_SUBCOMMAND("store", &fn, store_stash),
>  		OPT_SUBCOMMAND("create", &fn, create_stash),
> -		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
> +		OPT_SUBCOMMAND("push", &fn, push_stash),
>  		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
>  		OPT_END()
>  	};
> @@ -1811,6 +1805,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
>  	git_config(git_stash_config, NULL);
>  
>  	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
> +			     PARSE_OPT_KEEP_ARGV0 |
>  			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
>  			     PARSE_OPT_KEEP_UNKNOWN_OPT |
>  			     PARSE_OPT_KEEP_DASHDASH);
> @@ -1821,14 +1816,11 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
>  	index_file = get_index_file();
>  	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
>  		    (uintmax_t)pid);
> +	
> +	if (fn != push_stash) {
> +		argc--;
> +		argv++;
> +	}
>  
> -	if (fn)
> -		return !!fn(argc, argv, prefix);
> -	else if (!argc)
> -		return !!push_stash_unassumed(0, NULL, prefix);
> -
> -	/* Assume 'stash push' */
> -	strvec_push(&args, "push");
> -	strvec_pushv(&args, argv);
> -	return !!push_stash(args.nr, args.v, prefix, 1);
> +	return !!fn(argc, argv, prefix);
>  }
