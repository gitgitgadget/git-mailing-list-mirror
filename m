Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9164AC433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 01:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhL0BRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 20:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhL0BRk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 20:17:40 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248ECC06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:17:40 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a9so29431782wrr.8
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KbCO+TAgnflZIl1hIbsbC/UANRBondty+3sfg1d0ZR0=;
        b=iZuPlE2O8I96e1hNfZqmMua3T6Y+A/jlghf0YeM6AywrYYWSPRTXONBVzQ+2rTEgN8
         +vk8OfiqfXxiPmDunPpGoeBUH+Vx/0bjCBDm0d8TK+SJhX8PcMzz8LsptIwHeUpXYRLb
         x8dTmu4xN/Az31lQFov8r1pFD6sOYqUIqtAjxY8lPFI/DSONE9c5a3zZCLtk/QJ2P/eX
         ypH4VEoSkhHv1FgL5/ICili15WDnuOWR1yLduOOZU76KyE6aO0VEb7Zyg7og3FYrHTHm
         OzPsG7LLB7EfNpmj+FHeikOholz8zAONMqncxL+DViaaUkfxDeznkkkWaLDr1FG4dXej
         4+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KbCO+TAgnflZIl1hIbsbC/UANRBondty+3sfg1d0ZR0=;
        b=mACq8ciSShzNvXdtfg/HUkOzGabNjQnFetuKURvWIuXloK/2j848zBZu015X10R1fC
         4HL1tHOYE6MLvIg1BRvN7V6ic05g4KVtgXd15zOkvkWn1c1atf/CN5FsL2sKfo9xsQf4
         rGRYIJrriTe/sRSripSp7y1AvQwMQmZD8UtLdRWB8DaCWyKkjkm1pXG0U7bep6h7yJp6
         wm3trk3XlDJdyxf0JUtXt5TpibBoA9blcms55Kjlv0p9twILsDunCHsRn+Bhn9tAJF6U
         NyxM/0czAs6QYBjryA0r10Rly1zd6f6vvbmdRkG42l/TpRfhmoKDg8fRoyj5QrqHPN6l
         17bw==
X-Gm-Message-State: AOAM531UPLsB2mb9+jS/wD2ushnJDH5E3wF7PB05Q2ktka+YZnRMFnjj
        9TXwFJSBnabPZhN1zxgcACo=
X-Google-Smtp-Source: ABdhPJwGm50OdxKMN7zIQXDPthWBzhq8p0V8wbyYkC6a/SkliOXJ+/mdezsKd/GA3ygv2OaPJHeJEw==
X-Received: by 2002:a05:6000:2c2:: with SMTP id o2mr11168189wry.210.1640567858692;
        Sun, 26 Dec 2021 17:17:38 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id t11sm13666693wrz.97.2021.12.26.17.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 17:17:38 -0800 (PST)
Date:   Mon, 27 Dec 2021 02:17:36 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v7 7/7] various *.c: use isatty(0|2), not
 isatty(STDIN_FILENO|STDERR_FILENO)
Message-ID: <20211227011736.jea5qvn3mffusxnc@gmail.com>
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
 <patch-v7-7.7-0670d1aa5f2-20211217T041945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v7-7.7-0670d1aa5f2-20211217T041945Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nit: I'd maybe drop the "various *.c: " subject prefix. It's already
implied that the change is across the entire tree.

On Fri, Dec 17, 2021 at 05:25:02AM +0100, Ævar Arnfjörð Bjarmason wrote:
> We have over 50 uses of "isatty(1)" and "isatty(2)" in the codebase,
> and around 10 "isatty(0)", but these used the

nit: ambiguous pronouns like "these" here can trip up the reader for a
second. Maybe "three places" is clearer.

> {STDIN_FILENO,STD{OUT,ERR}_FILENO} macros in "stdlib.h" to refer to
> them.
> 
> Let's change these for consistency, and because another commit that
> would like to be based on top of this one[1] has a recipe to change
> all of these for ad-hoc testing, not needing to match these with that
> ad-hoc regex will make things easier to explain.

this sentence is quite long, and it also doesn't help that "these" refers
to something other than it did in the previous sentence.
Here's my attempt:

	Let's change these for consistency.  This makes it easier to change all
	calls to isatty() at a whim, which is useful to test some scenarios[1].

> Only one of these is
> related to the "struct progress" code which it discusses, but let's
> change all of these while we're at it.
> 
> 1. https://lore.kernel.org/git/patch-v6-8.8-bff919994b5-20211102T122507Z-avarab@gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/bisect--helper.c | 2 +-
>  builtin/bundle.c         | 2 +-
>  compat/mingw.c           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 28a2e6a5750..21360a4e70b 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -830,7 +830,7 @@ static int bisect_autostart(struct bisect_terms *terms)
>  	fprintf_ln(stderr, _("You need to start by \"git bisect "
>  			  "start\"\n"));
>  
> -	if (!isatty(STDIN_FILENO))
> +	if (!isatty(0))
>  		return -1;
>  
>  	/*
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index 5a85d7cd0fe..df69c651753 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -56,7 +56,7 @@ static int parse_options_cmd_bundle(int argc,
>  
>  static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
>  	int all_progress_implied = 0;
> -	int progress = isatty(STDERR_FILENO);
> +	int progress = isatty(2);
>  	struct strvec pack_opts;
>  	int version = -1;
>  	int ret;
> diff --git a/compat/mingw.c b/compat/mingw.c
> index e14f2d5f77c..7c55d0f0414 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2376,7 +2376,7 @@ int mingw_raise(int sig)
>  	switch (sig) {
>  	case SIGALRM:
>  		if (timer_fn == SIG_DFL) {
> -			if (isatty(STDERR_FILENO))
> +			if (isatty(2))
>  				fputs("Alarm clock\n", stderr);
>  			exit(128 + SIGALRM);
>  		} else if (timer_fn != SIG_IGN)
> -- 
> 2.34.1.1119.g7a3fc8778ee
> 
