Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AFFC05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 21:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBQVvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBQVvC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 16:51:02 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9805532503
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:51:01 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id l16so1391839pgt.5
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1i1obw1RuepynzJ0CcFqo409jW6nsxvdHF8PUKivHkw=;
        b=V882/R0CjkB7gO40aiGTsgl8tl6rygQYV88VeESxgLlui6/IHnjsx8QbxPCOmkzwm6
         vXXjSp0NkrL5E0tW5gmNlunERAFwqyJiZZ9SYEOyJWDAdPNvWW+Tnv+VenRIqMzqasug
         1VPGk6olY3AYuIRQgJ7rN0U+XrkWy4yd6fJf6C0rsQqoVHOgO728BWGzU0Lz5KoN9/NH
         NK0USElTmXEieCgOVpFKdyuzzi2JDuMObzqvHX46yGGtZEBh96Fl3OwYxGnPJ17JaK5m
         k6/v9ZGJ3cqMKjL5p7wJghxeM3GuNqaSxDvQwCGsT89lYN4h2AEWvBCQnN6pJMZbRbEE
         sW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1i1obw1RuepynzJ0CcFqo409jW6nsxvdHF8PUKivHkw=;
        b=1c0QX8HLb3kTlrUjSHd01ZD4rj1XsoCE3FsOF2BUaW0RZr92vqB/xUzu5osdLJB24U
         3Nztf1kShsISvBZM0zOnYHxYNsra6RoQ+nVWTiB86NfU3ljMsMrc+j8dD73Oe2wQNLiE
         v2lKGkpUaGGeL7lSIsP5JEXychD6C98x4de69CBlOnfmVJKS34yjh4KybggHlZ50O7LS
         D1LvTGKSAYqnp0VW61hVc1puoald3nFvugd5BBh/bd9hxUFYpmVWaAUMHqc18NfH+7Wp
         jaVqLyS2JtOn+4+7RBetb8EM0th33Qgua2HlNGohhLzxO9H3JCVM50DWqnG3bs0dVXnG
         5pJw==
X-Gm-Message-State: AO0yUKXpxEOrncr2PqKht9auefwWq9cbEEq9uz9NALp4Yt0LzBGL+oiX
        bV9okGjEEe4a+95kXbxx+QV+4eoYy+M=
X-Google-Smtp-Source: AK7set8PJhxDgyLhNkfd/Q/NJwX+7KXUvpNCkteUZuMY3Li0XDcsWK0p2U+Epw1yz1/HDaa2vf5Yww==
X-Received: by 2002:aa7:8f04:0:b0:5a8:4883:4213 with SMTP id x4-20020aa78f04000000b005a848834213mr2180942pfr.20.1676670660864;
        Fri, 17 Feb 2023 13:51:00 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id s10-20020aa7828a000000b005809d382016sm3502751pfm.74.2023.02.17.13.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 13:51:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 2/2] diff: teach diff to read algorithm from diff driver
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
        <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
        <b330222ce83bdf03c20085ff10fcff8a090474d5.1676665285.git.gitgitgadget@gmail.com>
Date:   Fri, 17 Feb 2023 13:50:59 -0800
In-Reply-To: <b330222ce83bdf03c20085ff10fcff8a090474d5.1676665285.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Fri, 17 Feb 2023 20:21:25
        +0000")
Message-ID: <xmqqfsb4klks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

Looking good.  Some comments below.  Many of them minor.

> +Setting the internal diff algorithm
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The diff algorithm can be set through the `diff.algorithm` config key, but
> +sometimes it may be helpful to set the diff algorithm by path. For example, one

I would have expected "per path" instead of "by path".

> +might wish to set a diff algorithm automatically for all `.json` files such that
> +the user would not need to pass in a separate command line `--diff-algorithm`
> +flag each time.

While this is not incorrect per-se, I think the first paragraph of
the proposed commit log message was a lot more convincing.  Your
changes may not be limited to a single kind of files, and a command
line option is simply not enough.  You may want one algorithm for
".json" while using another for ".c", which was really an excellent
example you gave.

> +This diff algorithm applies to user facing diff output like git-diff(1),
> +git-show(1) and is used for the `--stat` output as well. The merge machinery
> +will not use the diff algorithm set through this method.

Is "format-patch" considered "user-facing"?

> +NOTE: If the `command` key also exists, then Git will treat this as an external
> +diff and attempt to use the value set for `command` as an external program. For
> +instance, the following config, combined with the above `.gitattributes` file,
> +will result in `command` favored over `algorithm`.
> +
> +----------------------------------------------------------------
> +[diff "<name>"]
> +  command = j-c-diff
> +  algorithm = histogram
> +----------------------------------------------------------------

Isn't this a bit too verbose, given that the reader has just seen
the external diff driver section.  I wonder something like this is
sufficient, without any sample configuration?

    NOTE: If `diff.<name>.command` is defined for path with the
    `diff=<name>` attribute, it is executed as an external diff driver
    (see above), and adding `diff.<name>.algorithm` has no effect (the
    algorithm is not passed to the external diff driver).


> diff --git a/diff.c b/diff.c
> index 5efc22ca06b..04469da6d34 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4456,15 +4456,13 @@ static void run_diff_cmd(const char *pgm,
>  	const char *xfrm_msg = NULL;
>  	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
>  	int must_show_header = 0;
> +	struct userdiff_driver *drv = NULL;
>  
> -
> -	if (o->flags.allow_external) {
> -		struct userdiff_driver *drv;
> -
> +	if (o->flags.allow_external || !o->ignore_driver_algorithm)
>  		drv = userdiff_find_by_path(o->repo->index, attr_path);
> -		if (drv && drv->external)
> -			pgm = drv->external;
> -	}
> +
> +	if (o->flags.allow_external && drv && drv->external)
> +		pgm = drv->external;

OK.  There is no explicit "pgm = NULL" initialization in this
function, but that is done by the caller passing NULL to the
function as a parameter, so it all makes sense.

> @@ -4481,12 +4479,16 @@ static void run_diff_cmd(const char *pgm,
>  		run_external_diff(pgm, name, other, one, two, xfrm_msg, o);
>  		return;
>  	}
> -	if (one && two)
> +	if (one && two) {
> +		if (drv && !o->ignore_driver_algorithm && drv->algorithm)
> +			set_diff_algorithm(o, drv->algorithm);

For symmetry with the above choice of pgm we just saw, the order of
the condition might be easier to follow if written like so:

	if (!o->ignore_driver_algorithm && drv && drv->algorithm)

It would not make any measurable difference performance-wise either way.

> @@ -4583,6 +4585,14 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
>  	const char *name;
>  	const char *other;
>  
> +	if (!o->ignore_driver_algorithm) {
> +		struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, p->one->path);

That's an overlong line.

> +
> +		if (drv && drv->algorithm) {
> +			set_diff_algorithm(o, drv->algorithm);
> +		}

No need to have {} around a single statement block.

> +	}
> +
>  	if (DIFF_PAIR_UNMERGED(p)) {
>  		/* unmerged */
>  		builtin_diffstat(p->one->path, NULL, NULL, NULL,
> @@ -5130,6 +5140,8 @@ static int diff_opt_diff_algorithm(const struct option *opt,
>  		return error(_("option diff-algorithm accepts \"myers\", "
>  			       "\"minimal\", \"patience\" and \"histogram\""));
>  
> +	options->ignore_driver_algorithm = 1;
> +
>  	return 0;
>  }
>  
> @@ -5145,6 +5157,8 @@ static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
>  		BUG("available diff algorithms include \"myers\", "
>  			       "\"minimal\", \"patience\" and \"histogram\"");
>  
> +	options->ignore_driver_algorithm = 1;
> +
>  	return 0;
>  }
> @@ -5285,6 +5299,7 @@ static int diff_opt_patience(const struct option *opt,
>  	for (i = 0; i < options->anchors_nr; i++)
>  		free(options->anchors[i]);
>  	options->anchors_nr = 0;
> +	options->ignore_driver_algorithm = 1;
>  
>  	return set_diff_algorithm(options, "patience");
>  }


I was hoping that set_diff_algorithm() can be the shared common one
that signals we were told to use a specific algorithm, but it also
is called from internal codepaths so it cannot be it.

It is probably not worth introducing an extra helper that only calls
set_diff_algorithm() and sets ignore_driver_algorithm bit only for
that to reduce three-times repetition.

OK.

> diff --git a/userdiff.c b/userdiff.c
> index d71b82feb74..ff25cfc4b4c 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -293,7 +293,7 @@ PATTERNS("scheme",
>  	 "|([^][)(}{[ \t])+"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
>  	 "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
> -{ "default", NULL, -1, { NULL, 0 } },
> +{ "default", NULL, NULL, -1, { NULL, 0 } },
>  };

I was surprised that there is so little damage to the built-in
userdiff driver definitions, but this is thanks to the PATTERNS()
and IPATTERN() macro that use designated initializers.  Very nice.

Nicely done.
