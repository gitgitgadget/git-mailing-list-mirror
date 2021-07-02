Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0374FC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D368961416
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhGBLpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 07:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhGBLpu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 07:45:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772C8C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 04:43:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i5so12886606eds.1
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 04:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nS021vkRumd1/MMXpfowKwjzk+Y5nlHdcqP/nUR1lZs=;
        b=gfJ148dl3WIlpHbiWNXzgZq+j9roZfxFtGMz2ddJGIxiTWGDJA+qFZNao4eqMZJh3O
         OfM/s1bnIDyc+dn1C0F86jB53QEteHhq/7pmHgPuR8hTh674V11SZT29ib8a7x05ov/Q
         CccUGr0R6QQHxw4zBvdp3iuv8ftfeTUc/tjIMdgQXhTKq2bHUt88HgQtHA+TwMIOtNkH
         f7siRdWtllevQMA0qGm1fHKlyD5o6YfOFweM+VxtxzVzSZnEddO9AlGf0MbNrVm0SbcN
         AlYuweVbDoHaq758ryfOBOCI6GidNf6QbLc6zyWhHm0apdRdMr9VOeBXMFCYDq0nDM5D
         4T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nS021vkRumd1/MMXpfowKwjzk+Y5nlHdcqP/nUR1lZs=;
        b=J7yv5dKaIaEIe5ifO7997UwxgHPQf9zisyGNt7GdXIIgvzTMbIOW+ZhnQP41FsyhHa
         q+UUYJx/nqgBx7E2B9Tx8tuqJKU1crzkL8x8Oxnd3eF+sCUJ7qkPHku4DcUNV6OAQTlQ
         Pn9IcQSqPeQBONAFEo+28+ZFqRN7iGHU7YGyI4HCQ60w66Czqc82o6h3Gf0DAhiYnNOC
         FO1WNATDFUxbKt97EwgS5QBaFsMtnq9LvKaEOlfGiprQ3WtypNEK9XcaXeYSwyHTEoLn
         wqPo0Tm2VAy6hvO3uwoen9juwMT7Bh/L9KURR1RbFyqRZPu2RxP27e4txYRyuzXQb9eN
         lQuw==
X-Gm-Message-State: AOAM532rpd/aqRPqTfjAqu8NqYuZ9CoqY5IixD066eAk6I1fuXCAZfg1
        HRTkj0idW1oMGeXE/+2qAJI=
X-Google-Smtp-Source: ABdhPJwMrOCaKXg/ppNwzuk+eNFdVncYmGugRlDdFOWvwgNMSDjTwDA3KNVctQSXVGuXTOOaptSJ3A==
X-Received: by 2002:a50:d081:: with SMTP id v1mr6349560edd.318.1625226196908;
        Fri, 02 Jul 2021 04:43:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ja11sm955568ejc.62.2021.07.02.04.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 04:43:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] config: add default aliases
Date:   Fri, 02 Jul 2021 13:32:48 +0200
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210702100506.1422429-6-felipe.contreras@gmail.com>
Message-ID: <8735sxaqln.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 02 2021, Felipe Contreras wrote:

> These are all the aliases everyone agrees are essential.
>
> Virtually all VCS in the world have aliases, except git, so let's change
> that.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-branch.txt      |  4 ++++
>  Documentation/git-cherry-pick.txt |  4 ++++
>  Documentation/git-commit.txt      |  4 ++++
>  Documentation/git-mergetool.txt   |  4 ++++
>  Documentation/git-rebase.txt      |  4 ++++
>  Documentation/git-status.txt      |  4 ++++
>  config.c                          | 29 +++++++++++++++++++++++++++++
>  config.h                          |  3 ++-
>  t/test-lib.sh                     |  2 ++
>  9 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 94dc9a54f2..fbf5ebd27a 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -24,6 +24,10 @@ SYNOPSIS
>  'git branch' (-d | -D) [-r] <branchname>...
>  'git branch' --edit-description [<branchname>]
>  
> +ALIAS
> +~~~~~
> +'git br'

I think for these it would be good to explicitly mention the mnemonic, e.g.:

'git br', git 'br'anch. It's pretty obvious in this case, but not all of
them. This also addresses the '"ci" or "co"' discussion downthread
somewhat, i.e. at least we'll see if we always pick the first two
letters, or if it's somewhat arbitrary.

> +~~~~~
> +'git pi'

I've got this this as 'git chrp' locally FWIW, I'd think this would make
more sense if it was called 'git pick'.

> +~~~~~
> +'git co'

Not going to wade into the downhtread co/ci discussion, except to say
that this is 'co'mmit, i.e. first two letters, like 'br'anch.

>  'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
>  
> +ALIAS
> +~~~~~
> +'git mt'

Maybe it's just me, but I don't think I've ever used git-mergetool
directly. I don't think it's worthy of squatting on such a short name.

> +ALIAS
> +~~~~~
> +'git rb'

So 'r'e'b'ase, not 're'base.

>  'git status' [<options>...] [--] [<pathspec>...]
>  
> +ALIAS
> +~~~~~
> +'git st'

FWIW I've got this aliased to 'git status --short', anyway, 'st'atus, so
first two letters...

> +static int git_config_default(config_fn_t fn, void *data)
> +{
> +	int ret = 0;
> +	struct config_source source;
> +
> +	if (getenv("GIT_NO_DEFAULT_ALIASES"))
> +		return 0;

Can't we just include this under GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS?
Maybe rename it to GIT_TEST_DISALLOW_ABBREVIATED now that the "OPTIONS"
part is considered inaccurate.

> +	memset(&source, 0, sizeof(source));
> +	source.prev = cf;
> +	source.origin_type = CONFIG_ORIGIN_DEFAULT;
> +	cf = &source;
> +
> +	ret += fn("alias.co", "commit", data);
> +	ret += fn("alias.rb", "rebase", data);
> +	ret += fn("alias.st", "status", data);
> +	ret += fn("alias.br", "branch", data);
> +	ret += fn("alias.pi", "cherry-pick", data);
> +	ret += fn("alias.mt", "mergetool", data);

I haven't looked but does this also inject things into the configset
API, or is it just going to be used by things that do
git_config_mycommand and fall back on git_config_default?

As long as the aliases mechanism picks it up I suppose it's fine.

>  static int config_parse_pair(const char *key, const char *value,
>  			  config_fn_t fn, void *data)
>  {
> @@ -1897,6 +1921,9 @@ static int do_git_config_sequence(const struct config_options *opts,
>  		repo_config = NULL;
>  
>  	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
> +
> +	git_config_default(fn, data);
> +
>  	if (git_config_system() && system_config &&
>  	    !access_or_die(system_config, R_OK,
>  			   opts->system_gently ? ACCESS_EACCES_OK : 0))
> @@ -3497,6 +3524,8 @@ const char *current_config_origin_type(void)
>  		return "submodule-blob";
>  	case CONFIG_ORIGIN_CMDLINE:
>  		return "command line";
> +	case CONFIG_ORIGIN_DEFAULT:
> +		return "default";
>  	default:
>  		BUG("unknown config origin type");
>  	}

Ah, this is likely it, do we incclude this in 'git config -l' etc? 

> diff --git a/config.h b/config.h
> index 9038538ffd..bc3ecca313 100644
> --- a/config.h
> +++ b/config.h
> @@ -58,7 +58,8 @@ enum config_origin_type {
>  	CONFIG_ORIGIN_FILE,
>  	CONFIG_ORIGIN_STDIN,
>  	CONFIG_ORIGIN_SUBMODULE_BLOB,
> -	CONFIG_ORIGIN_CMDLINE
> +	CONFIG_ORIGIN_CMDLINE,
> +	CONFIG_ORIGIN_DEFAULT
>  };
>  
>  enum config_event_t {
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 49b80a4eb5..a15965e2f4 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -456,6 +456,8 @@ GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-sha1}"
>  export GIT_DEFAULT_HASH
>  GIT_TEST_MERGE_ALGORITHM="${GIT_TEST_MERGE_ALGORITHM:-ort}"
>  export GIT_TEST_MERGE_ALGORITHM
> +GIT_NO_DEFAULT_ALIASES=1
> +export GIT_NO_DEFAULT_ALIASES
>  
>  # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
>  GIT_TRACE_BARE=1

Really needs more tests.

We had some other thread where this was discussed where I suggested that
we implement some way to include default config. Ah, here it is:
https://lore.kernel.org/git/87eedj74dr.fsf@evledraar.gmail.com/

It's more work for this, but I think it would really go a long way to
addressing the concerns people are going to have about this.

I think we should not opt-in to this from day one, but have some knob to
enable including one of those shipped-by-default alias includes. Then
people could trivially mock svn/cvs or whatever their favorite VCS is,
and eventually as people vote with their feed we could pick a canonical
one.
