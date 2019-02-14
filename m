Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FF0F1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 19:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502872AbfBNTrK (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 14:47:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38740 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394670AbfBNTrI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 14:47:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id v26so7302942wmh.3
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 11:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=n9QCQ8TOOW+VL8eNkSsWNOMNdrg1qcb43q8utNeLrj0=;
        b=Sz2SfsCpW9dX2XMg96/13UflKmruBkum3udPI7XUPaQ1uyCJau6pTlDz+7heTEDrC0
         EeV6HxOoa7qDDnFNJzE7yBAZR7wfv+vn/4ttLWGAxvIgtHa5SAjxzfcnH8H5+SnK9lig
         E2aBPXn1tOIP8A7/UAPPvEvexNbYITweoSBU2LBHxFE0COO56uS5Byg5jGLL+QuV2sBk
         QIDPZtj93jmD5fPrQIpIgsznfOm0+vQKm8jbhnHnbRfN0UTUiK4vYh5IgwYOq8z1yOA9
         Ex29A/PWnniAZk52w0BfzImgLc2LL1/P2ByP6M/Ffy0bprkpt0llE7xFGSZ8dV9lJOCg
         PXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=n9QCQ8TOOW+VL8eNkSsWNOMNdrg1qcb43q8utNeLrj0=;
        b=Qe3fZQssqzzj+BzqC63RKhw1zya8oea7eMgWgZFV8+qRA0ewT+2dpiSyHMh9yMjR/C
         FfG6yQhEUT30YSQynaMExwzlFamsZ5KGL40BXxm0/0ELgB5qAmB0f38lGW/BMWpzlOih
         6bnYY+vbtLRQFFxkQSwh692bL8+lLX1Yrfh1Z+y+D9DauBYVDiQuLPrR/EfnAFuz3Uer
         6/bR3TeWIl7PX/UgiROnpRiig5uyBoJXy9S1P8zsO3jEkj+kvfZz45q0o3pF9+XPUwzC
         7QL2jH8P9MDuz84YWRq886KNmVtN7GJasyBIOGXFvik47rBZKNOgLxRR92X8LsW2+IEf
         wh3A==
X-Gm-Message-State: AHQUAuYbyg9TiYRCwmQxY/OuURsf7Ho3gosUJS3ZP30NfcT0ny11Yc0m
        0poqW4eBrgKVZlYpmgGo/Yk=
X-Google-Smtp-Source: AHgI3IZPfv1MBdL370MqhvtdY82hKue21w3CGIhPPFrIRq9ihuc8CHBCV4MPPoo62SRK5llsvVq3cA==
X-Received: by 2002:a1c:7011:: with SMTP id l17mr4033052wmc.8.1550173625050;
        Thu, 14 Feb 2019 11:47:05 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w23sm3987619wmc.38.2019.02.14.11.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 11:47:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sylvain Lacaze <sylvain@lacaze.me>, git@vger.kernel.org
Subject: Re: [PATCH] diff: reuse diff setup for --no-index case
References: <CAH1FtBpcZJ8V4B=RJ0SfC+kehpmpaBGafDzXvi8i33rc++jOUw@mail.gmail.com>
        <20190213201118.GA13261@sigill.intra.peff.net>
Date:   Thu, 14 Feb 2019 11:47:02 -0800
In-Reply-To: <20190213201118.GA13261@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 13 Feb 2019 15:11:19 -0500")
Message-ID: <xmqqo97e885l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] diff: reuse diff setup for --no-index case
>
> When "--no-index" is in effect (or implied by the arguments), git-diff
> jumps early to a special code path to perform that diff. This means we
> miss out on some settings like enabling --ext-diff and --textconv by
> default.
>
> Let's jump to the no-index path _after_ we've done more setup on
> rev.diffopt. Some of these options won't affect us either way (e.g.,
> items related to the index), but that makes it less likely for these two
> paths to diverge again in the future.

OK.

> Note that we also need to stop re-initializing the diffopt struct in
> diff_no_index(). This should not be necessary, as it will already have
> been initialized by cmd_diff() (and there are no other callers). That in
> turn lets us drop the "repository" argument from diff_no_index (which
> never made much sense, since the whole point is that you don't need a
> repository).

I really like this part of the change.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Generated with --inter-hunk-context=13 so you can see the actual list of
> options.
>
>  builtin/diff.c           | 7 ++++---
>  diff-no-index.c          | 8 +-------
>  diff.h                   | 2 +-
>  t/t4053-diff-no-index.sh | 8 ++++++++
>  4 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 9f6109224b..458ce326c8 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -338,28 +338,29 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  		       "--no-index" : "[--no-index]");
>  
>  	}
> -	if (no_index)
> -		/* If this is a no-index diff, just run it and exit there. */
> -		diff_no_index(the_repository, &rev, argc, argv);
>  
>  	/* Otherwise, we are doing the usual "git" diff */

This "Otherwise, " can be replaced with "We've dealt with the
'--no-index' mode with the above.  In the remainder of the
function,".

>  	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;

This does not hurt but by definition is irrelevant in "--no-index" mode.

>  	/* Scale to real terminal size and respect statGraphWidth config */
>  	rev.diffopt.stat_width = -1;
>  	rev.diffopt.stat_graph_width = -1;
>  
>  	/* Default to let external and textconv be used */
>  	rev.diffopt.flags.allow_external = 1;
>  	rev.diffopt.flags.allow_textconv = 1;

These four do matter in "--no-index" mode.

>  
>  	/*
>  	 * Default to intent-to-add entries invisible in the
>  	 * index. This makes them show up as new files in diff-files
>  	 * and not at all in diff-cached.
>  	 */
>  	rev.diffopt.ita_invisible_in_index = 1;

This falls into the same category as skip_stat_unmatch.

> +	if (no_index)
> +		/* If this is a no-index diff, just run it and exit there. */
> +		diff_no_index(&rev, argc, argv);
> +
>  	if (nongit)
>  		die(_("Not a git repository"));
>  	argc = setup_revisions(argc, argv, &rev, NULL);

To summarize, I would suspect that two further improvements on this
patch are:

 (1) move "Otherwise" comment to the right place

 (2) make the two assignments that are irrelevant to "--no-index"
     after we jumped to diff_no_index().

The latter is optional, but may be good for code health by making
developers _think_ if an option is applicable to "--no-index" mode.
I dunno.

> diff --git a/diff-no-index.c b/diff-no-index.c
> index 9414e922d1..6001baecd4 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -233,20 +233,14 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
>  	}
>  }
>  
> -void diff_no_index(struct repository *r,
> -		   struct rev_info *revs,
> +void diff_no_index(struct rev_info *revs,
>  		   int argc, const char **argv)
>  {
>  	int i;
>  	const char *paths[2];
>  	struct strbuf replacement = STRBUF_INIT;
>  	const char *prefix = revs->prefix;
>  
> -	/*
> -	 * FIXME: --no-index should not look at index and we should be
> -	 * able to pass NULL repo. Maybe later.
> -	 */
> -	repo_diff_setup(r, &revs->diffopt);

;-)

