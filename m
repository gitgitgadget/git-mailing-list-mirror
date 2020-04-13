Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DB1C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 15:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6BA20732
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 15:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="oLRuth9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgDMPtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbgDMPtr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 11:49:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F8DC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 08:49:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so4639799pfl.12
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jJMUgkGK+10taFjCZtJLVNmn7pl5kWF4g2Go7xCcZyk=;
        b=oLRuth9pX5UYfR/jQLK5+DGIkOiOGmUrprSfl/8fHnoBdeB4J6XTQi13+c6l2o9k9b
         cMhLSQgwVdw+RFmf0faApZuRwegEruEqHhWYkkFl/Br8EJ0R3lP2UOWTIHszVaMfJgmZ
         mZG44C2feALN0B/k9px/TrBo+3V1MAp5zq1REt/n50Y8PV4lturVaQPpq4R1nhxvshCn
         X4zN15GwCx0gyvSDVR7mrU1d/TqCGhEHiLSWyw8iiGHJIvydSBnKabXj1b2JC3tGA2oR
         eCiCL9DREMdVRh4ZjkSbQKBjHOHpyvoB+1vhJ1FqBCf1h5PjEvc2vTN9AAhtSyCJmd3o
         Z8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jJMUgkGK+10taFjCZtJLVNmn7pl5kWF4g2Go7xCcZyk=;
        b=LyZO/FcFehTTW4Pp9/8NXspYsVr+JiKufBc3oMOg2vn2GwJnyJqUKlCQ13dmg70CEZ
         zgxczOxjtCw0oMmwCBRR0+2z4ocoAlLK4Ab1ykdH2wg91EtyVs22js+QCfkz8J3zwUN9
         AR6OweB3HyAIh3eV5TmJ7KHEFljc4atf8wXUNUQEyZxEH5hKwRkmNjxx0SiAR0ximVD1
         yVhXPPhMv7pMjdbflg05rMD/D/D97Mt3kqwNAtlfzoeMaUVbHHvz9lOVoTIHBa3/ec6a
         cIikOZjq6rw5pCeYms+Ta6cMaYmkyAD4ntEcec826UyLN4jM7fdqqIUe3HEGxqpHjreZ
         N//Q==
X-Gm-Message-State: AGi0PubcOhatoxhvIb9zX2cyDRtBeTtd9PArb6oqIYl5LYuNf1KLsdFG
        YDFTqkj303/1Q+yohSVWpwwFYQ==
X-Google-Smtp-Source: APiQypIyexjFSE39YNtZI/ijBc3CG0wtLaUHthMKF9sERrXpzwqj1mnjqM7AvaPhWr3gU63dIUchsQ==
X-Received: by 2002:aa7:848f:: with SMTP id u15mr8556039pfn.2.1586792986824;
        Mon, 13 Apr 2020 08:49:46 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id nk12sm9633519pjb.41.2020.04.13.08.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 08:49:46 -0700 (PDT)
Date:   Mon, 13 Apr 2020 09:49:45 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] log: add log.excludeDecoration config option
Message-ID: <20200413154945.GA59601@syl.local>
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, Apr 13, 2020 at 03:28:39PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> In 'git log', the --decorate-refs-exclude option appends a pattern
> to a string_list. This list is used to prevent showing some refs
> in the decoration output, or even by --simplify-by-decoration.
>
> Users may want to use their refs space to store utility refs that
> should not appear in the decoration output. For example, Scalar [1]
> runs a background fetch but places the "new" refs inside the
> refs/scalar/hidden/<remote>/* refspace instead of refs/<remote>/*
> to avoid updating remote refs when the user is not looking. However,
> these "hidden" refs appear during regular 'git log' queries.
>
> A similar idea to use "hidden" refs is under consideration for core
> Git [2].
>
> Add the 'log.excludeDecoration' config option so users can exclude
> some refs from decorations by default instead of needing to use
> --decorate-refs-exclude manually. The config value is multi-valued
> much like the command-line option.
>
> There are several tests in t4202-log.sh that test the
> --decorate-refs-(include|exclude) options, so these are extended.
> Since the expected output is already stored as a file, simply add
> new calls that replace a "--decorate-refs-exclude" option with an
> in-line config setting.
>
> [1] https://github.com/microsoft/scalar
> [2] https://lore.kernel.org/git/77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com/
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     log: add log.excludeDecoration config option
>
>     This was something hinted at in the "fetch" step of the background
>     maintenance RFC. Should be a relatively minor addition to our config
>     options.
>
>     We definitely want this feature for microsoft/git (we would set
>     log.excludeDecoration=refs/scalar/* in all Scalar repos), but we will
>     wait for feedback from the community.
>
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-610%2Fderrickstolee%2Flog-exclude-decoration-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-610/derrickstolee/log-exclude-decoration-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/610
>
>  Documentation/config/log.txt |  5 +++++
>  builtin/log.c                | 14 ++++++++++++++
>  t/t4202-log.sh               | 22 ++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
>
> diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
> index e9e1e397f3f..1a158324f79 100644
> --- a/Documentation/config/log.txt
> +++ b/Documentation/config/log.txt
> @@ -18,6 +18,11 @@ log.decorate::
>  	names are shown. This is the same as the `--decorate` option
>  	of the `git log`.
>
> +log.excludeDecoration::
> +	Exclude the specified patterns from the log decorations. This multi-
> +	valued config option is the same as the `--decorate-refs-exclude`
> +	option of `git log`.
> +

Thanks for this documentation update. Do you think that it would be
worth updating the entry for '--decorate-refs-exclude', too? I figure
that it would be good, since scripters who look at 'git log's man page
before 'git config's would have a trail to follow in case they want a
persistent '--decorate-refs-exclude' option.

>  log.follow::
>  	If `true`, `git log` will act as if the `--follow` option was used when
>  	a single <path> is given.  This has the same limitations as `--follow`,
> diff --git a/builtin/log.c b/builtin/log.c
> index 83a4a6188e2..d7d1d5b7143 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -236,7 +236,21 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  	}
>
>  	if (decoration_style) {
> +		const struct string_list *config_exclude =
> +			repo_config_get_value_multi(the_repository,
> +						    "log.excludeDecoration");
> +
> +		if (config_exclude) {
> +			struct string_list_item *item;
> +			for (item = config_exclude->items;
> +			     item && item < config_exclude->items + config_exclude->nr;
> +			     item++)

Any reason not to use the 'for_each_string_list_item' macro in
'string-list.h' for this?

> +				string_list_append(&decorate_refs_exclude,
> +						item->string);
> +		}
> +

On my first read, I thought that there might be some value in using a
hash set here, since I (incorrectly) thought that only literal reference
names were added here, in which case we'd benefit from a constant time
lookup.

But, since we store patterns here, it's not helpful for us to have a
constant time lookup, since we don't have anything to look up in the
first place! I guess you could expand out all of these patterns ahead of
time, but I don't think that this is universally a good thing to do. We
may have a pattern like 'refs/heads/*', but we're only doing a 'git log'
over a part of history that doesn't have many/any refs pointing at it,
in which case expanding ahead of time was a bad thing to do.

Of course, 'string_list_append' is going to potentially introduce
duplicate patterns, but I don't think that should be a huge problem,
since 'ref_filter_match' stops as soon as it finds an exclude/include. I
guess you could use 'string_list_insert', but it makes insertions more
expensive without a clear benefit.

>  		rev->show_decorations = 1;
> +
>  		load_ref_decorations(&decoration_filter, decoration_style);
>  	}
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 0f766ba65f5..b5de449e510 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -787,6 +787,9 @@ test_expect_success 'decorate-refs-exclude with glob' '
>  	EOF
>  	git log -n6 --decorate=short --pretty="tformat:%f%d" \
>  		--decorate-refs-exclude="heads/octopus*" >actual &&
> +	test_cmp expect.decorate actual &&
> +	git -c log.excludeDecoration="heads/octopus*" log \
> +		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
>  	test_cmp expect.decorate actual
>  '
>
> @@ -801,6 +804,9 @@ test_expect_success 'decorate-refs-exclude without globs' '
>  	EOF
>  	git log -n6 --decorate=short --pretty="tformat:%f%d" \
>  		--decorate-refs-exclude="tags/reach" >actual &&
> +	test_cmp expect.decorate actual &&
> +	git -c log.excludeDecoration="tags/reach" log \
> +		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
>  	test_cmp expect.decorate actual
>  '
>
> @@ -816,6 +822,14 @@ test_expect_success 'multiple decorate-refs-exclude' '
>  	git log -n6 --decorate=short --pretty="tformat:%f%d" \
>  		--decorate-refs-exclude="heads/octopus*" \
>  		--decorate-refs-exclude="tags/reach" >actual &&
> +	test_cmp expect.decorate actual &&
> +	git -c log.excludeDecoration="heads/octopus*" \
> +		-c log.excludeDecoration="tags/reach" log \
> +		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
> +	test_cmp expect.decorate actual &&
> +	git -c log.excludeDecoration="heads/octopus*" log \
> +		--decorate-refs-exclude="tags/reach" \
> +		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
>  	test_cmp expect.decorate actual
>  '
>
> @@ -831,6 +845,10 @@ test_expect_success 'decorate-refs and decorate-refs-exclude' '
>  	git log -n6 --decorate=short --pretty="tformat:%f%d" \
>  		--decorate-refs="heads/*" \
>  		--decorate-refs-exclude="heads/oc*" >actual &&
> +	test_cmp expect.decorate actual &&
> +	git -c log.excludeDecoration="heads/oc*" log \
> +		--decorate-refs="heads/*" \
> +		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
>  	test_cmp expect.decorate actual
>  '
>
> @@ -846,6 +864,10 @@ test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
>  	git log -n6 --decorate=short --pretty="tformat:%f%d" \
>  		--decorate-refs-exclude="*octopus*" \
>  		--simplify-by-decoration >actual &&
> +	test_cmp expect.decorate actual &&
> +	git -c log.excludeDecoration="*octopus*" log \
> +		-n6 --decorate=short --pretty="tformat:%f%d" \
> +		--simplify-by-decoration >actual &&
>  	test_cmp expect.decorate actual
>  '
>

Thanks for the tests, they look good. I like your strategy of repeating
the test with and without the new config settings.

>
> base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
> --
> gitgitgadget

Thanks,
Taylor
