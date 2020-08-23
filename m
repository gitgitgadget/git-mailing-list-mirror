Return-Path: <SRS0=2KbR=CB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1083AC433E1
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 06:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D273D20768
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 06:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5wutkzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgHWGu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Aug 2020 02:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgHWGu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Aug 2020 02:50:56 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15663C061573
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 23:50:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t10so7963488ejs.8
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 23:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ooz9u9vpYLF9sqgqCl3rnXdBHouOUXZPXssg65cUWII=;
        b=J5wutkzYWknKvEUYa4out+b4eGU4AgOLJvNxXMRZrbg8mzNsH2UPsYmf4mye0mTFkY
         C84NwyX3ktHqQs+Z52Zo8gZy7J0AzpqMbLlwWdWlU35ifVX3Q3r3Wg3qwDbiE2iKF4v0
         pctzXofRJnGpGE8hnjOX7YWJH2bhQzUQygbOq885GveZLqq2W2GtIJveuIGfU9ycHjl3
         TUHS93BGVnr7uelaYs/dYLcQhLKEB/fpJFc2KChdjIAQXgLscHXE7crDWbNy4Bo4UyLy
         FgY4rKT0enOIgR+5OiQR1BId4H4Lt+YMcRfT4EELF2k3IdLUG7hamDjkvEwZznRZzOkg
         cxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ooz9u9vpYLF9sqgqCl3rnXdBHouOUXZPXssg65cUWII=;
        b=iHVh3sFsvfAZv3WpPVesJBKPZgy4s1mKiC+7pJ9qddWQ0jRM2ASaT7YDAOAo6i/vkL
         YMKDIKvyIuQKmBk5ngIT8jkfU/usWH5KNzy+F9Q5TpqLvCOyk5YBv+O58k9AWvptMtES
         I1wxsvZMGpfg+h90xSX8+4SvKORb/qKmnr7Uj153zwqVNpuRBXA7OnuL+J3tgH3G5VaY
         GlXBHQrH/K8bUjYltpicMwyq1Cgc5LJOgkBIqCUqX4hozM153/k2k4gdpxKJU5XUVaSA
         WOJv0KQVwm8kfo8g6tca2aNZlmKcuxLeuYFHUq2FtQf8Ig4YX0E2BVCnTQ81jhPD2UH+
         hb4g==
X-Gm-Message-State: AOAM531lTo6DVFKEB3pbk+8SnAdNtZU5qYtyE+3Z+M4Qitba29UolRh2
        FYQT9IuwBjyGaFqFRh8JJ+KgmF3Yt/QsqRpzqWw=
X-Google-Smtp-Source: ABdhPJxa65+pl0IkneehHx2sGRyVpkoFnFiDn+0IO+teeTirV7pEtBYTTmyDu1ePpgH4md04Wzt5ShsqE3M94Z9+Zic=
X-Received: by 2002:a17:906:e0c2:: with SMTP id gl2mr334650ejb.160.1598165454754;
 Sat, 22 Aug 2020 23:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200822203203.66116-1-alipman88@gmail.com>
In-Reply-To: <20200822203203.66116-1-alipman88@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 23 Aug 2020 08:50:43 +0200
Message-ID: <CAP8UFD123OpGJOMOeY0Feub8o5H3eF_DSLtYTp_Gu8fWXUS1rA@mail.gmail.com>
Subject: Re: [PATCH] bisect: add first-parent option to documentation
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 23, 2020 at 1:06 AM Aaron Lipman <alipman88@gmail.com> wrote:
>
> Ensure that the [--first-parent] option is listed in the output of
> git bisect -h
>
> Signed-off-by: Aaron Lipman <alipman88@gmail.com>
> ---
> This patch updates a piece of documentation I missed when submitting the
> first-parent option a few weeks ago.

Thanks!

>  git-bisect.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index c7580e51a0..c28e35b0fa 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -4,7 +4,7 @@ USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|view|replay|
>  LONG_USAGE='git bisect help
>         print this long help message.
>  git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
> -                [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
> +                [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]

This looks good to me as this matches what's in "Documentation/git-bisect.txt".

Best,
Christian.









> 2.24.3 (Apple Git-128)
>
