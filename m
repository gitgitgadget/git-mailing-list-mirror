Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA3FC433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 00:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbiBIA0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 19:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbiBIA0h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 19:26:37 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F06C06157B
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 16:26:36 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id yw18so1580243ejb.3
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 16:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tSmBxudIN6xNa6Wg8ac90UsSp/sMT6iRZ4GLTQDPxW8=;
        b=VaJ+1BaJwtg36MLeadNjBdOM0ORbErKWGWvKz3wIuR/6zz4tH1C22ok3oNt8nfYNlU
         dzsfAjFjeAWGXUnfVfmf2An14OZiNsxu6iOH4EZTY4AW1f9/3Ur978McVme7MesQo3ql
         raF8o9dOhJJsXVlMUAyU6VLHgjvbx5STceieyU3LuPFp8BM+4exsIJueIVBW7uoecPH/
         KLcufJeE12vujGxM3B/G2CAWQ3K86TDwE+lDgh/OiObMI2MmGlAd0QcjVc6BqJNhsIDv
         HXxRwmwxx+RJDZy4vtjsrFz6kM8cXkrV5Di6TUTcNz3UHkmMbVLztfWKKRH9D014U1cC
         rGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSmBxudIN6xNa6Wg8ac90UsSp/sMT6iRZ4GLTQDPxW8=;
        b=0dMUB5GguFUFr/OTu4WF68Y9hBsx+LjBF5uN7VwNReteSPMX65eIRp6cZ4J/CjnrzW
         bEspBBBYowtQ6K7IYmsGnEvC/jZhDdDHekkt4bO2aWERBKPsFf4lHQQoKDGq1mogCsFn
         8Z1O9Za5wkxD3PuqWS9niTFBWXv/h45/C5aIIV9reqK+CIeRLPSeHSeezU0akA0TMU+3
         IUssEuGXoCeI/xTI5FB6h6BQLl1ETAKdGyKQ+LScV9lm8CF3MgBAK3JmrYGoypamqylc
         erL8Jni+XDH0rJn63JR341dy2fm7SBkZpI+zdjetbp22/IReg2yzviFHyoZp/euGkDex
         S06w==
X-Gm-Message-State: AOAM531SXkzumHpQBFjNSLT+iGv5bB2KmpcCh6D9iuiLSIyStCa4uR5q
        o3LAiTMMAukXtxG7iiI0PRikRm2hS98yBJwehnB9vvoHGYo=
X-Google-Smtp-Source: ABdhPJy7pyn8HWPyZFtOHRXawgR4X+zgeCMO5BvKtiixwUKKeNKhcCQoVgzNVM4YyHlkv7j3WLAREabDvmSqqI/VQ0k=
X-Received: by 2002:a17:907:7da8:: with SMTP id oz40mr5885816ejc.328.1644366395182;
 Tue, 08 Feb 2022 16:26:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <1b14ed3d7976b8fe4149822dcbb32343e0554a38.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <1b14ed3d7976b8fe4149822dcbb32343e0554a38.1643328752.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Feb 2022 16:26:23 -0800
Message-ID: <CABPp-BFfaOmmW6aX=3nyLQjKsK7Y7cNMKRUqGHTgSdGP3F1=-g@mail.gmail.com>
Subject: Re: [PATCH 08/11] bisect--helper: using `--bisect-state` without an
 argument is a bug
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 28, 2022 at 3:30 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `bisect--helper` command is not expected to be used directly by the
> user. Therefore, it is a bug if it receives no argument to the
> `--bisect-state` command mode, not a user error. Which means that we
> need to call `BUG()` instead of `die()`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/bisect--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 4450305c81c..009c919a989 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -872,7 +872,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
>         struct oid_array revs = OID_ARRAY_INIT;
>
>         if (!argc)
> -               return error(_("Please call `--bisect-state` with at least one argument"));
> +               BUG("bisect_state() called without argument");
>
>         if (bisect_autostart(terms))
>                 return BISECT_FAILED;
> --
> gitgitgadget

Makes sense.
