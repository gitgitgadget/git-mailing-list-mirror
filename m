Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E4C05027
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 02:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjBOC4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 21:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBOC4n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 21:56:43 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9FA2CFD0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:56:42 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id r3so6235759pfh.4
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDNFxhk5kIsNqBWneYjrV7FpebGjtWv3Z5cg3sNHNSo=;
        b=D9+hBUjRs9IfnloipTQwWkou2dSo4fr9+XePF/KsK6yxN+iOsNktHOd+MVIAEuq7Oq
         8lYMoPu/DT6MCUC9fGMX9+YE+BGJlaUksDTbHxKdbAaKw42grvCISIguow3RPgoT0LYm
         dieXVhybiobeaYMzjZ4D5Z/GxFcHNrYGC6C61t9V+byrFzFjR92omz/nBIk2c207ZrXB
         XWgb2mKX2+94g1GzLgEVXnyV02GKhjVwMK0lfFaw34rXCXLqvLBmSYkaNrN2IHQ2q/0m
         hhvgm05TwYS+sSpNGZUMJXSWtAjItm3PCWDYBMK7BuASo88WOKgXbUMgbgtPcqFLZOIY
         Lm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DDNFxhk5kIsNqBWneYjrV7FpebGjtWv3Z5cg3sNHNSo=;
        b=vSpnsKJx996rAB59m3Q4f+Rf8KHMQnXHgfxeQuzzibKpRMUOiPxJy3oXPnSvGNoLeC
         9mZpRQs3wLOs25d3u0MtJzIWeph8n42szLv+gJCFmzI1f3SBhpLZdOVFPVfrQTrLJ/xC
         eVNj6qJPLhcxrq8MW17VW7zGznKNqO0RwnvS7y2fnZFaOhfe+eShPIFy06anKE5BROeM
         Zal+7UyuJBgdrx6nekiVjNWGFa+1OV2MAmFnmKEiac8ZGUS/VQ6VCMcqMbJJIgfzj3mA
         ePNJ1WTZb1NbWNhKcvdj4Dmjj4S38/K9H+fJ17OL+B0l6j10fJbzqBjf+g0iRVRo7YgO
         4jOQ==
X-Gm-Message-State: AO0yUKVqPN1ZIqHg42uiiCQulC1VChMw3fPFenLDE0KGnVZzNKDXh9oX
        yJ8peE2cwmCbumJxeb8iBdI=
X-Google-Smtp-Source: AK7set9wAVlUob0hGA3CKBpQgtPSqihkzr1THoApZWtqUz5zvREUvHVePz4J0EzkRrQxH3qQMwhYXQ==
X-Received: by 2002:a62:1b52:0:b0:583:9b05:d1f0 with SMTP id b79-20020a621b52000000b005839b05d1f0mr294287pfb.33.1676429801697;
        Tue, 14 Feb 2023 18:56:41 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id v25-20020a62a519000000b005809d382016sm10417896pfm.74.2023.02.14.18.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 18:56:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 2/2] diff: teach diff to read gitattribute
 diff-algorithm
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
        <cb0305631496eb4c2d51e5b586ac0ca8580c7dc1.1676410819.git.gitgitgadget@gmail.com>
Date:   Tue, 14 Feb 2023 18:56:40 -0800
In-Reply-To: <cb0305631496eb4c2d51e5b586ac0ca8580c7dc1.1676410819.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Tue, 14 Feb 2023 21:40:19
        +0000")
Message-ID: <xmqq4jrn3ac7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> It can be useful to specify diff algorithms per file type. For example,
> one may want to use the minimal diff algorithm for .json files, another
> for .c files, etc.
>
> Teach the diff machinery to check attributes for a diff driver. Also
> teach the diff driver parser a new type "algorithm" to look for in the
> config, which will be used if a driver has been specified through the
> attributes.
>
> Enforce precedence of diff algorithm by favoring the command line option,
> then looking at the driver attributes & config combination, then finally
> the diff.algorithm config.
>
> To enforce precedence order, use the `xdl_opts_command_line` member
> during options pasing to indicate the diff algorithm was set via command
> line args.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  Documentation/gitattributes.txt | 41 ++++++++++++++++++++++++++++++++-
>  diff.c                          | 25 +++++++++++++-------
>  diff.h                          |  2 ++
>  t/lib-diff-alternative.sh       | 38 +++++++++++++++++++++++++++++-
>  userdiff.c                      |  4 +++-
>  userdiff.h                      |  1 +
>  6 files changed, 100 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index c19e64ea0ef..7e69f509d0a 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -736,7 +736,6 @@ String::
>  	by the configuration variables in the "diff.foo" section of the
>  	Git config file.
>  
> -
>  Defining an external diff driver
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Unrelated change?  Wider paragraph gap between two sections than
other inter-paragraph gaps inside a single section is what original
had, and I think that is a reasonable thing to keep.

> @@ -758,6 +757,46 @@ with the above configuration, i.e. `j-c-diff`, with 7
>  parameters, just like `GIT_EXTERNAL_DIFF` program is called.
>  See linkgit:git[1] for details.

In other words, this new section wants another blank line before to match.

>  
> +Setting the internal diff algorithm
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The diff algorithm can be set through the `diff.algorithm` config key, but
> +sometimes it may be helpful to set the diff algorithm by path. For example, one
> +might wish to set a diff algorithm automatically for all `.json` files such that
> +the user would not need to pass in a separate command line `--diff-algorithm` flag each
> +time.

That's an overly wide paragraph.

> +
> +First, in `.gitattributes`, you would assign the `diff` attribute for paths.
> +
> +*Git attributes*

Discard this line (mimic an existing section, like "Defining a
custom hunk-header").

> +------------------------
> +*.json diff=<name>
> +------------------------
> +
> +Then, you would define a "diff.<name>.algorithm" configuration to specify the
> +diff algorithm, choosing from `meyers`, `patience`, `minimal`, and `histogram`.
> +
> +*Git config*

Likewise, discard this line (I won't repeat but the next hunk has
the same issue).

> diff --git a/diff.c b/diff.c
> index 92a0eab942e..24da439e56f 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4456,15 +4456,11 @@ static void run_diff_cmd(const char *pgm,
>  	const char *xfrm_msg = NULL;
>  	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
>  	int must_show_header = 0;
> +	struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, attr_path);

Do we run this look-up unconditionally, even when .allow_external
bit is not set?  Why?

> -
> -	if (o->flags.allow_external) {
> -		struct userdiff_driver *drv;
> -
> -		drv = userdiff_find_by_path(o->repo->index, attr_path);
> +	if (o->flags.allow_external)
>  		if (drv && drv->external)
>  			pgm = drv->external;
> -	}
>  
>  	if (msg) {
>  		/*
> @@ -4481,12 +4477,17 @@ static void run_diff_cmd(const char *pgm,
>  		run_external_diff(pgm, name, other, one, two, xfrm_msg, o);
>  		return;
>  	}
> -	if (one && two)
> +	if (one && two) {
> +		if (!o->xdl_opts_command_line)
> +			if (drv && drv->algorithm)
> +				set_diff_algorithm(o, drv->algorithm);

The idea here seems to be "if there is no explicit instruction, and
if the diff driver specifies an algorithm, then use that one", which
is very straightforward and sensible.  Can we reliably tell if we
had an explicit instruction to override the driver?  That should
probably appear in other parts of the code, I guess.

>  		builtin_diff(name, other ? other : name,
>  			     one, two, xfrm_msg, must_show_header,
>  			     o, complete_rewrite);
> -	else
> +	} else {
>  		fprintf(o->file, "* Unmerged path %s\n", name);
> +	}
>  }



> @@ -4583,6 +4584,10 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
>  	const char *name;
>  	const char *other;
>  
> +	struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, p->one->path);
> +	if (drv && drv->algorithm)
> +		set_diff_algorithm(o, drv->algorithm);

Interesting.  Does external diff play a role, like in run_diff_cmd()
we saw earlier?

> @@ -5130,6 +5135,8 @@ static int diff_opt_diff_algorithm(const struct option *opt,
>  		return error(_("option diff-algorithm accepts \"myers\", "
>  			       "\"minimal\", \"patience\" and \"histogram\""));
>  
> +	options->xdl_opts_command_line = 1;

OK, calling this member "xdl_" anything is highly misleading, as it
has nothing to do with the xdiff machinery.  How about calling it
after what it does, i.e. allowing the attribute driven diff driver
to specify the algorithm?  options.ignore_driver_algorithm or
something?  The options coming _from_ the command line may happen to
be the condition to trigger this behaviour in this current
implementation, but it does not have to stay that way forever.
Losing "command line" from the name of the flag would make it
clearer what is essential (i.e. this controls if the diff driver is
allowed to affect the choice of the algorithm) and what is not (i.e.
we happen to let it decided based on the presence or absense of
command line choice).

Thanks.
