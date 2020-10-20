Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D90CC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 18:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52282098B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 18:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMrc1w9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437311AbgJTSK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 14:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408957AbgJTSKz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 14:10:55 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179BDC0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 11:10:54 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id g7so3547179ilr.12
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qk6A1ymYKQHsMM3oLMJzzgUFbufGihMUqfX9dq3MyGs=;
        b=SMrc1w9c37swW4w74Ie3KoaVvfE0uQSbkKEnhpm6ERNDc11AtfXUMOW29H1LJUVx48
         6N9GS+07Pi45Z2yy4yle78UAyawUkn7TPxSKA4OtkQYShQL1qfYLSQZF/kSNcvYCQcSS
         ac3KycK+efokYb32eorxCfGxwv77U/luQCZH8rA5X2tLcXlqZh7t+Ur1/BTnvp9QEHgF
         jOdaQkSJ9wAnBo4yXVUHhoYDTBYB2IWADQu9SckdHnj3kGARNNHwayVeIeARLcwpXIxb
         JmAUepmkth4vZyWAIrR/bCnARbHcX/Y8CJ/Q0jHNhqhrG54XM+Mx7rhGmnyhgCRNiRGv
         9rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qk6A1ymYKQHsMM3oLMJzzgUFbufGihMUqfX9dq3MyGs=;
        b=s/ytTJvN3SIqB7+aC8iP7nSpNffuXEfnFsSNdItpLUHl3/7J/SXWnCycOIBjzA85/6
         TrcfrFwvBaEx8ksrqw+Lk4EUxqpU2EvRSwyH+3edPI/7nI9Lb7tch+7QMxXqfn8urTaY
         SHA4CEiv+Ee9nhbozfjPFkKxQaPOz5va9Rn86nMv5hyPblUh3/Xn0UWNC6+J9+9q7x1D
         7qzjQ7b8UGXV9/jPfGMOWNdZamd9Da5QBaQXcgb/MX1UKEwQYgKfoSeIz5hPW0KhJgkc
         GrfJYCLMaxmyEuGegDKlnz1G2VWC6yuYdQZljfnn21MKG1pVSqqBvvnAxmaY3zejSvYK
         cUaA==
X-Gm-Message-State: AOAM530xuiWeFR1kS0teL2uISnmu9cT8RMzWDfFzzah5SS2HcwT3Qf3t
        UIx1Rt3ZYGi+eCINETxhmH/U5GhB28Fx6vBEp7oQEk+jdCA=
X-Google-Smtp-Source: ABdhPJwkWF+HK5ZIDIxOym86k2k4IMTbCyg42FxYcT0cG5947YSVf/Bpk8tT6zWPlS2JamGuzOZseOB+IKbwEvy7vbc=
X-Received: by 2002:a92:d6c1:: with SMTP id z1mr1334045ilp.193.1603217453456;
 Tue, 20 Oct 2020 11:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com> <7af89857-5495-d008-3d8f-09b5fed32775@gmail.com>
In-Reply-To: <7af89857-5495-d008-3d8f-09b5fed32775@gmail.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Tue, 20 Oct 2020 23:40:42 +0530
Message-ID: <CAHjREB7Xhga3da9vGyXxJo6MCi9P9CyezzO66Xh2X2+rDFkQjw@mail.gmail.com>
Subject: Re: [OUTREACHY][PATCH] diff: do not show submodule with untracked
 files as "-dirty"
To:     phillip.wood@dunelm.org.uk
Cc:     Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Phillip,

> I think we require your full name on the From line to match the
> Signed-off-by line below (c.f.
> https://lore.kernel.org/git/xmqqpn5dd5dv.fsf@gitster.c.googlers.com)

> That is a good summary of the issue that this change addresses, we
> normally wrap lines at 72 characters though.

This was sent by gitgitgadget so I am unable to find how I can
customize it. Can you help me with this? Or else I have set the Travis
so should I send another patch using send-email?

> This unconditionally overrides diff.ignoreSubmodules, grepping seems to
> show that we don't have any tests that test a config value of "none".
> There are a few that check "dirty" which we should look at to consider
> if they still add value now we've changed the default.

Yes, sorry, noticed it now. I have now added a flag in diff_flags.
Also, do I have to add tests that check whether diff.ignoreSubmodules
is not being overwritten?


>       if (diff_no_prefix) {
>               options->a_prefix = options->b_prefix = "";
> diff --git a/submodule.c b/submodule.c
> index b3bb59f066..762298c010 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1678,6 +1678,8 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>       strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
>       if (ignore_untracked)
>               strvec_push(&cp.args, "-uno");
> +     else
> +        strvec_push (&cp.args, "--ignore-submodules=none");
>
> We need to do this as a consequence of changing the default for
> '--ignore-submodules`, we should think what the consequences are for
> other users of `git status` and whether we need to do something similar
> there if diff.ignoreSubmodules is not set.
>

Oh okay. I understood what you said. But I couldn't figure out how to
do that. As all the tests of status were passing so I don't think
there might be any issue with this.

>
> I think we want to keep testing that we get the correct output when
> --ignore-submodules=none as well as maybe adding a couple of new tests
> that check the default in this file, rather than changing the expected
> output.
>

Thanks, I have added more tests.

Thanks and Regards,
Sangeeta
