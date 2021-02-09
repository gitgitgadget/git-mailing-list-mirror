Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE7BC433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 10:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C731964EAC
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 10:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhBIKQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhBIKIK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 05:08:10 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960FBC0617AA
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 02:07:24 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id t25so16990084otc.5
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 02:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBLaVy2R5Lt3yoLYMy3fIP5oLepw++oRv/6F7Yv3Eco=;
        b=Fa+ehyARPGBA1csRF50yGgq4S5rvrJ8qUviT2ptC3NKc3lTJ3xdc2C5B/ZQkMMkiWX
         TngGL8F7gWOcEpnrdTcf8XPTGkSDYzv7HJeHeSIugzD2UPhrSsSBJxY7Qx/tDFs3ZKPL
         njgdemnyFOAwxryr8PBzM4Om10rCKCKeZFJc30+hIruYW/7eRH2gNip1OLlS02CwR4qP
         K1vU0FZtQ6dj/UKyigBZ9Omq1oa24fFOLmucv+rWsg/+Y8fmK3Hi3/1vwT8oVnP5QQ6X
         deLyFgoWL0n6rTPkfKPsIm1UhvphL7sORyRXLy/PVlYF68aZNivu7C2obgG5tbU9BmMx
         UUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBLaVy2R5Lt3yoLYMy3fIP5oLepw++oRv/6F7Yv3Eco=;
        b=t6F/vp+Jj1HEvi/f47rdBR402zpe2SNw2AHAiygoTDUm8+7HzO1/cUbnlihJx85a6j
         m15FlpzxpXiR029P3qkS5UdyEetbGm18OTQKXLc9HDQGlPG9yLpgkpdKuxRAUNzwfYuv
         jVfFPQEMQCt5aE+G59MxyAMB/2iVFxbzLnSNW2MEwu3j+aXX+Rwb8lG/0b/V3Qse4Gnw
         mkX7NJ56u6ReoEHkEQ4KVgseH9gJfGKAVpf5WgHlrpV13VAoS2tf7RbTWaoeBD8yAgKz
         VfkwgciljijBMUs2CAvuZhd/Eizea7+FYwZJilWPgr7nF48FdLIxVIEXH3SO/4Q/x9KU
         TJUg==
X-Gm-Message-State: AOAM530MntAlo5j9VtxTouanrLpolfaKXEdS6J9Z8B2ChniIyAeNDu+q
        VltNYVgbLNUyHIIf64cfE8Lp+mHAXkmenO6s4XI=
X-Google-Smtp-Source: ABdhPJyPEAEaZ+zrnkYISk83TOrMNCUEqRumOIv9zuoaBAvGwHmr/hVhcDjwKws6unp0WiAG2F5e2GVuak0/4B8dT3U=
X-Received: by 2002:a9d:7dd3:: with SMTP id k19mr4905740otn.162.1612865244017;
 Tue, 09 Feb 2021 02:07:24 -0800 (PST)
MIME-Version: 1.0
References: <5bd9dce8f611c5fe380c9f58dbdfa2dc6d2fd51f.1612813249.git.matheus.bernardino@usp.br>
In-Reply-To: <5bd9dce8f611c5fe380c9f58dbdfa2dc6d2fd51f.1612813249.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Feb 2021 02:07:12 -0800
Message-ID: <CABPp-BFx6HmoVBsS2Aeb+GgZTC8axwGcuWrkpaCFxM-j2SOMww@mail.gmail.com>
Subject: Re: [PATCH] grep: error out if --untracked is used with --cached
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 8, 2021 at 11:47 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> The options --untracked and --cached are not compatible, but if they are
> used together, grep just silently ignores --cached and searches the
> working tree. Error out, instead, to avoid any potential confusion.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  builtin/grep.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index ca259af441..392acf8cab 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1157,6 +1157,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>         if (!use_index && (untracked || cached))
>                 die(_("--cached or --untracked cannot be used with --no-index"));
>
> +       if (untracked && cached)
> +               die(_("--untracked cannot be used with --cached"));
> +
>         if (!use_index || untracked) {
>                 int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
>                 hit = grep_directory(&opt, &pathspec, use_exclude, use_index);
> --
> 2.29.2

Reviewed-by: Elijah Newren <newren@gmail.com>
