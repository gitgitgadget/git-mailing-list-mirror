Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9587C4743E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB4F61078
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhFHMpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbhFHMpL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 08:45:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9046AC061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 05:43:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ho18so21413029ejc.8
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 05:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zhFaXUkUNfTxzdubICzD740onlmpC7X1pbmORyEJbsg=;
        b=d2bejgsi80HZZNWhx3JJU6E+kSj2Em1kOFW6/M9yOmsELiqNH57YSzN1Usc+8aUC1u
         VIXfxBbah5xtOucB5kRXOeu2P/y2rAmltGmK0fq1xuheDORDRJHFVgU+BNxovCGgmd1p
         YriAVkelFNy3XT+FS8yTnFgBpFMKAdPcFL551W9rIR+BbdH1Fq/zWOIqiTRYQM2nFKEh
         us8jJtzbg8QQ7a4mA2bSZYLJcgBHzkG/+59PGagfUvZJEQ+T+CzRuroZWs/pd9SzwHIT
         QPfxVJuM2mkT/FMIwMdfXxowsLUhOQ/iWeNtt5+yivm4dkzOq454PfOZ+02NZZGDno7Y
         8RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zhFaXUkUNfTxzdubICzD740onlmpC7X1pbmORyEJbsg=;
        b=AuLYS1tfhHqRH2IPvpMnhve9HF5WDIhl7n4JAf9q8i6PZUcCULW/0NwNiBviqcWJRq
         m+ER7Y43x49AswrRNu9x6xpBpvpkTGvnnoqAcOwSuFDSIRzp0JsyawVKcJ0v9JoMo3wD
         KxVXhP49K1LwbrVx1ESafMyv5r3bke6UXog/XAdqzUYqL5bZ5xqt5rGTr438AJq2X26v
         DPtdugRVsnZPKHv5MmrAcvAvjVOtPDAs3uyOHyZ1wfakka1askZLMyuic0TPQRmmJwJg
         TG4mrPDLsvYNEZnuwwO7x0iH8hUADX5plmV1fs4QaPuKBVD2qBoG7JKEWJsgKQd2Os9E
         8/xQ==
X-Gm-Message-State: AOAM533ufOk9cWOdHGMYwyO/f1wEytlpx116c6rD8qCGRG2XGsLhuf2Y
        ZSdLyqRfsR2uYHJxbLy0b6cNyzT8+Nx/2g==
X-Google-Smtp-Source: ABdhPJw7po6o0ysXMOCnIxS2NFPxNKsfRAAbFUBLISeW+7SFvEdUtAJ6l1MjxHqSM7RuPCxOyRQ+9g==
X-Received: by 2002:a17:906:311a:: with SMTP id 26mr16520156ejx.517.1623156196866;
        Tue, 08 Jun 2021 05:43:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d24sm8839480edr.95.2021.06.08.05.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 05:43:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] help: colorize man pages
Date:   Tue, 08 Jun 2021 14:35:24 +0200
References: <20210523054454.1188757-1-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210523054454.1188757-1-felipe.contreras@gmail.com>
Message-ID: <87o8cg34t8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 23 2021, Felipe Contreras wrote:

> We already colorize tools traditionally not colorized by default, like
> diff and grep. Let's do the same for man.
>
> Our man pages don't contain many useful colors (just blue links),
> moreover, many people have groff SGR disabled, so they don't see any
> colors with man pages.
>
> We can set LESS_TERMCAP variables to render bold and underlined text
> with colors in the pager; a common trick[1].
>
> Bold is rendered as red, underlined as blue, and standout (prompt and
> highlighted search) as inverse cyan.
>
> Obviously this only works when the less pager is used.
>
> If the user already has LESS_TERMCAP variables set in his/her
> environment, those are respected and nothing changes.
>
> A new color configuration is added: `color.man` for the people that want
> to turn this feature off, otherwise `color.ui` is respected.
> Additionally, if color.pager is not enabled, this is disregarded.
>
> Normally check_auto_color() would check the value of `color.pager`, but
> in this particular case it's not git the one executing the pager, but
> man. Therefore we need to check pager_use_color ourselves.
>
> Also--unlike other color.* configurations--color.man=3Dalways does not
> make any sense here; `git help` is always run for a tty (it would be very
> strange for a user to do `git help $page > output`, but in fact, that
> works anyway, we don't even need to check if stdout is a tty, but just
> to be consistent we do). So it's simply a boolean in our case.
>
> So, in order for this change to have any effect:
>
>  1. The user must use less
>  2. Not have the same LESS_TERMCAP variables set
>  3. Have color.ui enabled
>  4. Not have color.pager disabled
>  5. Not have color.man disabled
>  7. Not have git with stdout directed to a file
>
> Fortunately the vast majority of our users meet all of the above, and
> anybody who doesn't would not be affected negatively (plus very likely
> comprises a very tiny minority).
>
> [1] https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
>
> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Phillip Wood <phillip.wood123@gmail.com>
> Comments-by: Jeff King <peff@peff.net>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

I've been running with this on my personal git build since May 26th. I
haven't had any issues with it, and I like the new coloring.

I for one would like to have this picked up by Junio.

I think this is a good example of a change that we're better off just
merging down and then reverting if the wider audience of git users hates
it, rather than trying to come to some perfect consensus here
on-list.

We have a wider audience running "next" than "seen" (but this didn't
even make "seen"), if this were to make it into a release and users
overwhelmingly dislike it it's no big deal. There's a config option to
turn it off, and/or we could make it opt-in later.

Alternatively this could be opt-in and not fall under the color.ui=3Dauto
umbrella, or only in combination with feature.experimental (or a new
ui.experimental?, which would default to that?).

But in any case if judgement call UI changes are always hidden behind
options we'll never make forward progress on things that are possibly
better defaults (and if they're not, we can always simply revert the
change).
