Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0ED1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 21:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437705AbfBNVQZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 16:16:25 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37390 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392645AbfBNVQY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 16:16:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id m12so6246174edv.4
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 13:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/0z1N6dHH4YjZ3+VwPUB6FJW74vo0YdCiafXZBSPpA=;
        b=Wm7TP6uikkSMlOCTrhcvIaqQznXU5SUCBtl+BFqQiPDlL0c0NY6Z5ace02DrmR7ZjA
         lxwmaW0HtDiipzxflp3xVgywa0qkgsO34QxnEQgZVCaYq6FeQkvz4z/t0zUqFxxvdCSK
         04mtV3Ovi6FxWNbvwD+KZCHY2e8soR7H3IlSKLdbOyGdvMwq883VeO1FzgQaaSI2/ezZ
         4VuoTjdrnZBeezC5tqhFWI/iXgrNuRccJ+6GL2n7bGZHCbnsT5ytvgNEgNokY5fajwBc
         2GPxK3fuuhDnA7pBd2jU0W63fkYNzw9W0JtSWBhiOjyVBwLF67WXbc9e41ypmeZ8lWzJ
         BT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/0z1N6dHH4YjZ3+VwPUB6FJW74vo0YdCiafXZBSPpA=;
        b=kGeBoxbwks1kTU6D5FHBKqrgttLGhQmmFK/BBGWOIxDhZqv8yFCfUFt+ZUSaYx8/DX
         Puumi7A+HKhh3jFdPaayhE+J43sktY9oJpsZOvzb9gxTkUqvcqGxsjiGaW2TB7OW3zu+
         AeQIl1C6fI9yGf5Lm0GFzoSGl9z9DJ2SzuqbnTeJbcjy5EA/Qr2sEb2lhvUGbGd4dpLZ
         z0eH09ewzIsxKDEH7pgW83h0VMx0KGi2irDHFayaynPQoEKIMo4SJPpksXRlEoZi7uIF
         mkfrnzl9lQ96Nbv0gLBmM2XEccuSdqiK+stvzphAhIK+eVQFyRTSx1J9pRSeJWBqSApi
         r8IQ==
X-Gm-Message-State: AHQUAuaPHdlEPINsjoouFyfJQwPfb4oWE7e87sMxswccnF5BsjvI4jtv
        P7HE7hGjY25J3HnOwe/njozREDmF2POXay7YSmc=
X-Google-Smtp-Source: AHgI3IZuVLyzlEpUmgtVnqhRv+7jrh85fAQsDVDoixJdA0hlY76vjt9eMJI3yG8Hy+H+pcBVnLMhJC2O4FsGmkswlCM=
X-Received: by 2002:a17:906:4988:: with SMTP id p8mr4217721eju.75.1550178982963;
 Thu, 14 Feb 2019 13:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20190213205554.4086-1-matheus.bernardino@usp.br>
In-Reply-To: <20190213205554.4086-1-matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Feb 2019 22:16:11 +0100
Message-ID: <CAP8UFD1aBn8=KOTp-D=CmO1iEnWUBS1-jR-aqfg3MZ7HZRU7Pg@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH] clone: use dir-iterator to avoid explicit dir traversal
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 1:16 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Replace usage of opendir/readdir/closedir API to traverse directories
> recursively, at copy_or_link_directory function, by the dir-iterator
> API.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
> This is my microproject for GSoC 2019. It's still a RFC because I have
> some questions. Any help will be much appreciated.

Thanks for working on a microproject!

> There're three places inside copy_or_link_directory's loop where
> die_errno() is called. Should I call dir_iterator_abort, at these
> places, before die_errno() is called (to free resources)?

I don't think it's necessary. We care about freeing resources when we
report errors (for example by returning an error code from inside a
function), but not when we are exiting.

> -static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> -                                  const char *src_repo, int src_baselen)
> +static void mkdir_if_missing(const char *pathname, mode_t mode)

It looks like your patch is both splitting copy_or_link_directory()
into 2 functions and converting it to use the dir-iterator API. Maybe
it would be better to have 2 patches instead, one for splitting it and
one for converting it.

>  {
> -       struct dirent *de;
> +       /*
> +        * Tries to create a dir at pathname. If pathname already exists and
> +        * is a dir, do nothing.
> +        */

I think we usually put such comments just before the function. And
maybe it could be shortened to "Create a dir at pathname unless
there's already one"
