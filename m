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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE85C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C6422C9F
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgLDXKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDXKE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:10:04 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992FAC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:09:24 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id s75so4973909oih.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNBUvaXiQLrTd61b53G7hp66JZXUbvgT1hf1zocDb4I=;
        b=GOv7m7FhzzpBHyCcs8JceQZIXhS1wfwJPAR+PWN3Izilux1zy9TEGtjSxg73aIxibc
         UIMfjV2Le93QNtJkNx0zxIBjvI7Jyu3mbh0GZBi6f9nqTT3qCaFpU09hpsis62sR+sAK
         xK7xBqerXosX+CucSKqBMW5gcpGHWf7mBRKh+L4x8MKoFNgZoEsj4UJwOXdGJ+Jsb+08
         ME6r7eDG5vVdTSzqGfrJiU7eejK3s7VBQIiEVTntaG+HA894/fystZjgDb3+rcFpyiM6
         RfGvhy3783g1HEf4D3MwYmHs1Y/2V8oKq8XwL9tkkS90p3Zvt+xjc1NWlOPPSIgLiuOO
         0Utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNBUvaXiQLrTd61b53G7hp66JZXUbvgT1hf1zocDb4I=;
        b=Z0/A5LZubBeNcCXOLvNPTDmn+1EiOyY9miAqHbHVQn37sOGn5QZOR3lWIxHpitD/JA
         B+ygQcU70UYIftneRr7TrmzaJNOfW2NIaSfxFHjdOvWttxzrBbVv0QyEWHi0xWPQD+35
         2cTg+PrcL9M1P8J9JxnsfglH3ThDkqrXzuEnT+VFFdiNhmTPEVi3N7vmqEmdTaiQRLp9
         5+5ivx4kViR94uAvkuRgXMDJ7xuaeUxVv6YjMRap2kFTywR1VEuJXokO7homQU3RRrU5
         VpgCXLTb58PpYYUzmZrIMXl/5303L1chQgDpLzajJldNpimKFxFyxlLN1pxTs+T2tJ2h
         fXuA==
X-Gm-Message-State: AOAM531gTjiEM4EACTwEDJyUF7ONQKi2TUNXSjBEOgakLyoa/5cdjIQL
        UCEwGy9qdDEJQwoiyu0SdEwxzo22ZofIOIBqSE4=
X-Google-Smtp-Source: ABdhPJzDst01GY0bdaoHcTSZ23N6ZZgF0l2dnL4iaag49E+8NvTH426Whc+fLxetPFAkxj96Zm5H6Dq7/nKmTwkf9pY=
X-Received: by 2002:aca:49d5:: with SMTP id w204mr4739433oia.167.1607123363873;
 Fri, 04 Dec 2020 15:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com> <20201204061623.1170745-6-felipe.contreras@gmail.com>
In-Reply-To: <20201204061623.1170745-6-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 15:09:12 -0800
Message-ID: <CABPp-BHs-eaJcTMcOPEsDx7PbBfoM0Uf7-vWi33OVOcTEgAgmg@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] pull: trivial cleanup
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> There's no need to store ran_ff. Now it's obvious from the conditionals.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/pull.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index c38548dab8..8daba7539c 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1024,19 +1024,18 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>
>         if (opt_rebase) {
>                 int ret = 0;
> -               int ran_ff = 0;
>                 if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
>                      recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
>                     submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
>                         die(_("cannot rebase with locally recorded submodule modifications"));
> +
spurious change?

(It does make it look nicer, though.)

>                 if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
>                         /* we can fast-forward this without invoking rebase */
>                         opt_ff = "--ff-only";
> -                       ran_ff = 1;
>                         ret = run_merge();
> -               }
> -               if (!ran_ff)
> +               } else {
>                         ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> +               }
>
>                 if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
>                              recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
> --
> 2.29.2

Yeah, reads better to me after this cleanup.
