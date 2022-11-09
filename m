Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E763BC4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 03:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKIDFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 22:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKIDFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 22:05:30 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D7D23389
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 19:05:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id a5so25287569edb.11
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 19:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+gAsMokLJNHMhbdJJ9VTD+AflvQHhzU/CfuHeuTmYEY=;
        b=OIZ9SGyIVg6r6SAY2Hc4+21nGKp5k5otjiqSjWuAuNm8o2O0vWtMc3XT71DmOIHGLl
         8E1lG9uAnJey2cOCjm/4FrnLC3kSybxoGbxIAaEStqMrxPrVvJHI+3blaVpqVmlwcdtQ
         Mdv73DDtcAdzHKMtaFfaOyByjAH9Dc+kr1Q/M0PKdxG1MjXjEPBtrwYiu3/a9N1nSOEi
         haOxGOEkZYN56AhdYBwnNtv5etr48GRO0mEmOKce06qrUGMqsZqGgHB06vkeHY+AD6a3
         lsd4evAjT5uz8m2h+k6UlgPH4UxUPU4SFqEbUcFgo1W/2LTr4+ILyebRXrj9bRxl9wA4
         /Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gAsMokLJNHMhbdJJ9VTD+AflvQHhzU/CfuHeuTmYEY=;
        b=yTDY4wbvDhw57YcDQUFMTbFX7nPxuvO5QnAlzKMqn/huTvq35CNE2kU/VJQk8e2dL2
         3wUuU8bNg+y55a5/Cah/yKKpyrZTUn8FAe7v6WhoiIBLTL8TKdRSGO4YfEKusC+MjmP+
         quwkqf5P4HoAUFMVRfjEOHg+ZitfdDjT8mizXn56VRh5NmUjwglozfFvqc7fCd4lPr7Y
         EyWdW1Z7bNtmiUyF9V7/bEupWCJR9v+NzkuvR7R0tCLzmc91jGIqTBX3KS3p+TYqzL2X
         7gyZgSHuVsEGwD0zewgkm0KD+LamHsUkGAghWxsMj6kT15TfoLS3xDj8fzdfKvGXEHzp
         ePdA==
X-Gm-Message-State: ACrzQf3PWl99mWq+5q8U+/MmLH1MPlaO/hSvN9s0L0HuSq1lM8K5qmTR
        92IxmClmvZoWspBaxDdjERh0f1HEfjP2zQ==
X-Google-Smtp-Source: AMsMyM6kiKoFutrpg9hq19VHoK3KDkBl5lbaVnZlXd2FWZ5+b/EqHH1Kc86Jo3xOPHaD5rLGwebPqg==
X-Received: by 2002:a05:6402:694:b0:463:1c9f:c7c0 with SMTP id f20-20020a056402069400b004631c9fc7c0mr55128956edy.214.1667963127651;
        Tue, 08 Nov 2022 19:05:27 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906219100b007add1c4dadbsm5364413eju.153.2022.11.08.19.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:05:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osbP4-000ohC-1F;
        Wed, 09 Nov 2022 04:05:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] submodule--helper: teach --toplevel-cwd-prefix
Date:   Wed, 09 Nov 2022 03:37:27 +0100
References: <20221109004708.97668-1-chooglen@google.com>
 <20221109004708.97668-2-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221109004708.97668-2-chooglen@google.com>
Message-ID: <221109.867d04rfnt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, Glen Choo wrote:

> The top-level "--super-prefix" option (i.e. "git --super-prefix") is
> overloaded:
>
> - "git submodule--helper" passes the relative path between the top-level
>   "git" process's cwd and the current repository
> - "git read-tree" passes the path from the root of top-level
>   superproject's tree to the the current repository.
>
> In both cases, "--super-prefix" is only used to display meaningful paths
> from the superproject to a nested submodule.

The "overloaded" here could really use some elaboration.

Yes, we have different built-in commands that use it, but their use is
mostly mutually exclusive, i.e. when "submodule status" recurses into
itself it using an option called "--super-prefix" doesn't impact "git
read-tree", even though it uses the same option & env variable to
communicate the same concept.

But I'm totally willing to buy that it's simpler to e.g. have "git
submodule--helper status" or whatever use its own option to carry this
forward, rather than some option to "git" itself. Or if some commands
just need a --some-option, but not the environment variable.

But this doesn't really address that and ....

> Let's address this overloading by breaking it up into its constituent
> use cases. Teach "git submodule--helper" the "--toplevel-cwd-prefix"
> option, which replaces its usage of "git --super-prefix". (A future
> patch will address the "git read-tree" use case.) This value is only
> used in builtin/submodule--helper.c, but it is stored in submodule.c,
> since it may be needed by other builtins in the future.

...Uh, other built-ins might use it in the future? :) Wouldn't we be
right back to a --super-prefix then, which is a cross-built-in
semi-standard way to communicate this sort of information? So instead of
a hypothetical current:

	git submodule some-subcommand
		=> git --super-prefix submodule/ submodule -C submodule/ some-subcommand
			=> git --super-prefix submodule/ fetch

Or whatever, we'd do what? Have each of the now split-up commands take
their own flag for this? E.g.:

	git submodule some-subcommand
		=> git submodule -C submodule/ --toplevel-cwd-prefix submodule/ some-subcommand
			=> git fetch --submodule-prefix submodule/

Or are you really trying to say that it was a hassle to pass down this
through the various functions to all the callers, so emulating what we
did with the previous global was easier if it was a new global?
I.e. it's not about passing it to other built-ins, but between
submodule--helper itself?

I think doing that and chipping away at this from the bottom-up would be
a much better approach, at least for some cases.

E.g. just to have "absorbgitdirs" itself support a "--super-prefix"
option, not "git" or "git submodule--helper".

Then we just pass that down to absorb_git_dir_into_superproject(), which
will only invoke "git submodule--helper absorbgitdirs", which we'll then
tell about the super-prefix with a "--super-prefix" option to that
subcommand.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c75e9e86b0..acb838e4d6 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -115,18 +115,18 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
>  /* the result should be freed by the caller. */
>  static char *get_submodule_displaypath(const char *path, const char *prefix)
>  {
> -	const char *super_prefix = get_super_prefix();
> +	const char *toplevel_cwd_prefix = get_toplevel_cwd_prefix();
>  
> -	if (prefix && super_prefix) {
> -		BUG("cannot have prefix '%s' and superprefix '%s'",
> -		    prefix, super_prefix);
> +	if (prefix && toplevel_cwd_prefix) {
> +		BUG("cannot have prefix '%s' and toplevel_cwd_prefix '%s'",
> +		    prefix, toplevel_cwd_prefix);
>  	} else if (prefix) {
>  		struct strbuf sb = STRBUF_INIT;
>  		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
>  		strbuf_release(&sb);
>  		return displaypath;
> -	} else if (super_prefix) {
> -		return xstrfmt("%s%s", super_prefix, path);
> +	} else if (toplevel_cwd_prefix) {
> +		return xstrfmt("%s%s", toplevel_cwd_prefix, path);
>  	} else {
>  		return xstrdup(path);
>  	}

At the end of this series git.c has stopped knowing about
"--super-prefix", so I don't see why we need the churn of renaming
this. Even if we just make built-in commands take it now, isn't that
sufficient? We'd still need...

> @@ -364,9 +364,10 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
>  		cpr.dir = path;
>  		prepare_submodule_repo_env(&cpr.env);
>  
> -		strvec_pushl(&cpr.args, "--super-prefix", NULL);
> +		strvec_pushl(&cpr.args, "submodule--helper",
> +			     "--toplevel-cwd-prefix", NULL);
>  		strvec_pushf(&cpr.args, "%s/", displaypath);
> -		strvec_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
> +		strvec_pushl(&cpr.args, "foreach", "--recursive",
>  			     NULL);
>  

...to do this, but not all the function & variable renames.

>  	struct option options[] = {
> +		OPT_CALLBACK_F(0, "toplevel-cwd-prefix", NULL, "path",
> +			       "path from top level cwd to working tree root",
> +			       0, option_parse_toplevel_cwd_prefix),
>  		OPT_SUBCOMMAND("clone", &fn, module_clone),
>  		OPT_SUBCOMMAND("add", &fn, module_add),
>  		OPT_SUBCOMMAND("update", &fn, module_update),
> @@ -3375,21 +3378,10 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>  		OPT_SUBCOMMAND("set-url", &fn, module_set_url),
>  		OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
>  		OPT_SUBCOMMAND("create-branch", &fn, module_create_branch),
> +
>  		OPT_END()
>  	};
>  	argc = parse_options(argc, argv, prefix, options, usage, 0);
> -	subcmd = argv[0];
> -
> -	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
> -	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
> -	    strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
> -	    get_super_prefix())
> -		/*
> -		 * xstrfmt() rather than "%s %s" to keep the translated
> -		 * string identical to git.c's.
> -		 */
> -		die(_("%s doesn't support --super-prefix"),
> -		    xstrfmt("'%s %s'", cmd, subcmd));
>  
>  	return fn(argc, argv, prefix);
>  }

Re some of the things I was aiming for in the WIP submodule built-in
series by splitting up "submodule--helper", before this we'll only
accept it for certain subcommands, e.g.:

	$ ./git --super-prefix=blah/ submodule--helper summary
	fatal: 'submodule--helper summary' doesn't support --super-prefix

Whereas now we'll accept it:

	$ ./git submodule--helper --toplevel-cwd-prefix=blah/ summary
	$

I'm not necessarily against that, but it does seem to run somewhat
counter to the divide-and-conquer of eventually getting rid of this
super-prefix (or whatever we call it) business.

And in any case, if that's what we're going to do let's loosen that up
and justify that change in its own commit, separate from a
rename/refactor. I.e. you could start by removing this strcmp(...) &&
strcmp(...), along with an explanation for why we won't need to care
about which "submodule--helper" subcommand needs it anymore.

> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> index 2859695c6d..a9efebc7ec 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -54,15 +54,24 @@ test_expect_success 'setup nested submodule' '
>  '
>  
>  test_expect_success 'absorb the git dir in a nested submodule' '
> +	# Touch the files so that they show up in git status
> +	>expect.err &&
> +	>actual.err &&
>  	git status >expect.1 &&
>  	git -C sub1/nested rev-parse HEAD >expect.2 &&
> -	git submodule absorbgitdirs &&
> +	git submodule absorbgitdirs 2>actual.err &&
>  	test -f sub1/nested/.git &&
>  	test -d .git/modules/sub1/modules/nested &&
>  	git status >actual.1 &&
>  	git -C sub1/nested rev-parse HEAD >actual.2 &&
>  	test_cmp expect.1 actual.1 &&
> -	test_cmp expect.2 actual.2
> +	test_cmp expect.2 actual.2 &&
> +	cat >expect.err <<-EOF &&
> +	Migrating git directory of ${SQ}sub1/nested${SQ} from
> +	${SQ}/Users/chooglen/Code/git/t/trash directory.t7412-submodule-absorbgitdirs/sub1/nested/.git${SQ} to
> +	${SQ}/Users/chooglen/Code/git/t/trash directory.t7412-submodule-absorbgitdirs/.git/modules/sub1/modules/nested${SQ}
> +	EOF
> +	test_cmp expect.err actual.err

I'm afraid I'll need to change my name & OS for that to pass for me :)

This reminded me to send in:
https://lore.kernel.org/git/patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com/
; which fixes this message, & adds more tests for this output.
