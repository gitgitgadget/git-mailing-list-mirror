Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0992EC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 02:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB61D61058
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 02:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhKDC0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 22:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKDC0M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 22:26:12 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C914C061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 19:23:35 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id h133so2286441vke.10
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 19:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qo0EEAVwxTbkGxc21rumJDIiK9W+QHmNvCols4fFIU=;
        b=iiVCLBX0WMsiNICud9adq0N9Mg30lwce2r4WuHUdcC7A9vGa/scBPv51oUUmEbVDAt
         q8RdZVhm0tFOOGB67X+nKwIRfUyolp4Sw07mj79RaY6O1J80/bUwR6Dh7o3h7BUGbI0T
         CBUMu8PPCUDf4qZMmuVky/OsCFz8TF227hP1iwyrmWRPrDCikTXsntjRusHcedoOOvJs
         yaTRlJY4pzvNMu58hDMtPr3Li5SmAAeHRP/7hJxZHA14FZJqVqczt1ihz5KOKNDh1WdG
         ZM1Y9KDqLM5PW3Tj7XguAaVW7S5clV21QimkKoOu97+X9Uwjldim9hTQguHbDsgREWop
         vfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qo0EEAVwxTbkGxc21rumJDIiK9W+QHmNvCols4fFIU=;
        b=poUPgb8D0JX1D7JcbdOmcD5SMCM9FLnl/+Q+3JjreBajnGUwCOR5N4T/kx2qTQ6Mic
         ncXV+xKH09sVrTDhQBn0QfIR9Pr8scq4CJeLs/xnN02CY1TLZPDsYWuGbHLRUnhuxb9L
         w5QQNj91SbEov5iXZoS8aTwRkwfwHO97/gF7UcV2UK8CaYuQXfhHcdeFuAfxttensdyM
         aUYzl4uixUDQy9Nez4NKku2Je/+UWYiJxrRhm06XOswT8LRlTdR1jAig5C9Q3xDdhK8I
         3OomRp3oa0qqIzTOoktEFSjdhr/77B4g822/EdM+54Cp/jxy7+lzj/JNhzAdtgF+5C9v
         HAEw==
X-Gm-Message-State: AOAM532AicMGgYSXJuPzH2G98Rn6G9orjPrNgjM60C8Lae42TLQ+QIJp
        JcfgkNV7UOsfl5rAv8StRyjRgWXBJgdGDJnFA8M=
X-Google-Smtp-Source: ABdhPJxy/z6G4ADKmKzsUEJy9XljvPZsHLkUFiSPJhkmPE7XukctNujJ9fk+Dgr5m4mC1SOAIMY8KU54XrhE0uL0kCA=
X-Received: by 2002:a1f:324a:: with SMTP id y71mr18169253vky.23.1635992614117;
 Wed, 03 Nov 2021 19:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
In-Reply-To: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 3 Nov 2021 19:23:23 -0700
Message-ID: <CAPUEspjw4zypiywCBRc=y9uC4G5CKTE35GLVf_wDY436oO0C5w@mail.gmail.com>
Subject: Re: [PATCH] async_die_is_recursing: fix use of pthread_getspecific
 for Fedora
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.email,
        eschwartz@archlinux.org, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 3, 2021 at 6:48 PM Victoria Dye via GitGit
> The fix imitates a workaround added in SELinux [2] by using the pointer to
> `ret` as the second argument to `pthread_getspecific`.

the SELinux workaround uses a valid global pointer though; while this won't

> diff --git a/run-command.c b/run-command.c
> index 7ef5cc712a9..a82cf69e7d3 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1099,7 +1099,7 @@ static NORETURN void die_async(const char *err, va_list params)
>  static int async_die_is_recursing(void)
>  {
>         void *ret = pthread_getspecific(async_die_counter);
> -       pthread_setspecific(async_die_counter, (void *)1);
> +       pthread_setspecific(async_die_counter, &ret); /* set to any non-NULL valid pointer */

I guess this would work, since the pointer is never dereferenced, but
the use of (void *)1 was hacky, and this warning seems like the right
time to make it less so.

Would a dynamically allocated pthread_local variable be a better
option,  or even a static global, since we don't care about its value
so no need to worry about any races?

If neither, would MAP_FAILED also trigger the warning?

Carlo
