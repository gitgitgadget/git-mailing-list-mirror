Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE10C4167B
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242196AbiBWVWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242749AbiBWVV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:21:29 -0500
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228524EA38
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:21:01 -0800 (PST)
Received: by mail-pf1-f169.google.com with SMTP id y5so62069pfe.4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcVsiEaqiJ6QpyewmfraREEaOtTSlIAcJnNC+SN3Qgg=;
        b=z7XPCrHeuWo4/mpaq2z5D2DBrz1c1vUGTryOciTJeF1LLzGd+YVHO1uFKO5k4Cu4AW
         9tcFwb7CGTHYw9FyM0yYdt1TVaQhQZ+UJgJn+RymAJPEKyeDx2gBkP23kiDSyj+4tFnR
         XQcYYRiWEWffJWznyBLmbwtnMY7q3xZLvyXHBc4cMcQG13/eeM5LAoRFPhT+jdwgRHvK
         o1oTXBqUGRK/frHFiUFEbqrw674qKRVDk3aCL6PMlieeimAauXIOZdryQQJyCiYV+Bpz
         chHf4oc55gqbqLlj0I7ArhWvs6ASncltHJraDHOTK1yPZ5tky6sdeLKn/ZIf1HUEImaA
         GCOg==
X-Gm-Message-State: AOAM530KKnq3IlKV4PE9E0OOgnKw+XPfEPoUnu80KmbryWxqC6N6qpqw
        rKsXfPkue2bnGtxAUDy2pIJYLYrRm7G04bME7gBuCzxXhIs=
X-Google-Smtp-Source: ABdhPJw+pWLU9ecY9GfwebPq1Q/CYT3RtAWfKC5H362zXdOhic5QYhUswz+XZ06sV/3yGf595+F9nakA8cXKWZlQAoA=
X-Received: by 2002:a05:6a00:1503:b0:4e1:d277:cca with SMTP id
 q3-20020a056a00150300b004e1d2770ccamr1498844pfu.4.1645651260325; Wed, 23 Feb
 2022 13:21:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.1147.git.1645030949730.gitgitgadget@gmail.com>
 <pull.1147.v2.git.1645545507689.gitgitgadget@gmail.com> <CAPig+cRq7H2bnkcU-V5uiWA9z=FLvxj3ji0bhO3DMX9HfptHtQ@mail.gmail.com>
 <xmqqilt5th8s.fsf@gitster.g>
In-Reply-To: <xmqqilt5th8s.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 23 Feb 2022 16:20:49 -0500
Message-ID: <CAPig+cRUqtr3jgtL6t_fdm8T7mj1vZ3ONK8onvhv8aqqY87rLg@mail.gmail.com>
Subject: Re: [PATCH v2] add usage-strings check and amend remaining usage strings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Lawall <julia.lawall@inria.fr>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 4:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> +               if (opts->type != OPTION_GROUP && opts->help &&
> >> +                       !(starts_with(opts->help, "HEAD") ||
> >> +                         starts_with(opts->help, "GPG") ||
> >> +                         starts_with(opts->help, "DEPRECATED") ||
> >> +                         starts_with(opts->help, "SHA1")) &&
> >> +                         (opts->help[0] >= 65 && opts->help[0] <= 90))
> >
> > This list of hardcoded exceptions may become a maintenance burden. I
> > can figure out why OPTION_GROUP is treated specially here, but why use
> > magic numbers 65 and 90 rather than a more obvious function like
> > isupper()?
> >
> > Perhaps instead of hardcoding an exception list and magic numbers, we
> > can use a simple heuristic instead. For instance, if the first two
> > characters of the help string are uppercase, then assume it is an
> > acronym (i.e. "GPG") or special name (i.e. "HEAD"), thus allowed.
> > Maybe something like this:
> >
> >     if (opts->type != OPTION_GROUP && opts->help &&
> >         opts->help[0] && isupper(opts->help[0]) &&
> >         !(opts->help[1] && isupper(opts->help[1])))
>
> Much better than what was posted, but such a heuristic deserves some
> in-code comment to check why we see the first two.

Yes, I had the same thought as soon as I walked away from the computer
and was going to post a follow-up email to say as much but got
distracted by other things and never got around to it. Thanks for
filling in the gap.
