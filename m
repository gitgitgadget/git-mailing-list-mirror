Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFB9C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 15:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016E160F56
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 15:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbhHDP0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 11:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbhHDP0k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 11:26:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204DAC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 08:26:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u3so4351804ejz.1
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=bDjQGlzFmID1Y00eEaNx3nxNXZqZXCaq2aflT9ynioA=;
        b=o+XEqzuFD01Nj3RHLF7d/5ddlWt75o2AjKXWAMIXSBB/zH8UbZE94iKXaSx1Mz7f4b
         Boq+rumW6o3cA9pgRoW/X4X4V86QtAXFvkeI7zgV+0FTYOagCQmCWYVDr63SPEGm52SR
         5H0s7O9sdxUe1J53XnMHW0MeNkQ+gl2g5lCC43SA+IvNP93rUzNfZY6Ehhnx3btVDEIl
         kKVYfQ6ZIwIRQ2opRHoy/YRvBqXfFxARZWpqFqJCaKZtZgOBMYvC5zUDomEQ34LvgbQG
         vO2oC3oHbG+grOEvjYBBldFpbfPk3pC5lUa5j0YYdtL+4GNAaCsG0ZzCCN+paBu5MBCy
         B4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=bDjQGlzFmID1Y00eEaNx3nxNXZqZXCaq2aflT9ynioA=;
        b=HSj/CBx7DWFi8cFQo+S+3eMjNUYH0yPG+KFzOt0m/3oGq7QDxzNJxAq7V8+ojAN3hV
         0kFcODeSDmhpcB0BUUKwW52uWtyYqNJEg8tNZgqYuvo7pQxAEfSB+08HD5HCt48lZGlm
         Ub69dhNt9flOcxjq3lb+OMNhButmn35/H7l34AksUCctdY/YIQ89ka/IjQEWaJ7PVptx
         pnOQjiWRenRh6ZOGJ39FeQGzv/YzcIoahv4KSViM3+VtlqS+/O+cS+dForWkqjNZ+yZR
         FinUQnraRtaYYEV9jezDKBOUuYfpgqm+Kwh0bHxS/xeKFPEujwvtpyb2HxxKMkcO+D2z
         vA1A==
X-Gm-Message-State: AOAM530d0rf5WuKPkuAgOTPdBRu4DKxK1apddVYQRwNU13vHk21eJrFl
        NuLIyFeZ/6LEUQ9H/UcxOcg=
X-Google-Smtp-Source: ABdhPJykHWgqjtrbICMklhcybBxoSZoIcJM5uRZ5YHj2fQ3HercuSws7DK2FG9gjD713NugyWaS42w==
X-Received: by 2002:a17:906:85cc:: with SMTP id i12mr25854123ejy.405.1628090785690;
        Wed, 04 Aug 2021 08:26:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c15sm1071822edu.78.2021.08.04.08.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:26:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] diff: --pickaxe-all typofix
Date:   Wed, 04 Aug 2021 17:26:10 +0200
References: <20210804122419.53968-1-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210804122419.53968-1-bagasdotme@gmail.com>
Message-ID: <87o8admdsv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 04 2021, Bagas Sanjaya wrote:

> When I was fixing fuzzies as I updating po/id.po for 2.33.0 l10n round,
> I noticed a triple-dash typo (--pickaxe-all) at diff.c, which according
> to git-diff(1) manpage, the correct option name should be --pickaxe-all.
>
> Fix the typo.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index 82f88de755..a8113f1707 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4640,7 +4640,7 @@ void diff_setup_done(struct diff_options *options)
>  		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
>  
>  	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
> -		die(_("---pickaxe-all and --find-object are mutually exclusive, use --pickaxe-all with -G and -S"));
> +		die(_("--pickaxe-all and --find-object are mutually exclusive, use --pickaxe-all with -G and -S"));
>  
>  	/*
>  	 * Most of the time we can say "there are changes"
>
> base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd

Thanks, that's my typo from d26ec880096 (pickaxe: die when --find-object
and --pickaxe-all are combined, 2021-04-12) and this fix looks good to
me, sorry about that.
