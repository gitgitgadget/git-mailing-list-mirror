Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FF5C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 19:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4566140B
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 19:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhJDT7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 15:59:01 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:34581 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhJDT7B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 15:59:01 -0400
Received: by mail-ua1-f54.google.com with SMTP id h4so5109394uaw.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 12:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BC3h0gqEfn3sUAF8D22PfuSS2QttWEJ3uS3pisxZflI=;
        b=2Jl2mIJ+K5Cz7lRgJOYeCFuxCAQXAj/KRNtAc+vkFUbs3MhWxi4uNWx6n6WlxXa7Bg
         o7QuaCryba7clybi2JJ/o6vt/4JkyYbEhMJ3HYICMtl8T3skhIhuo4L++xucWbrKEcVd
         bsQ2LowMa/JRlic+JCwEYDQ3f0OIOskxDv+WbtD0EUD121wRcxt1rH4xTPlFKny0PuCH
         Qn07jwAQBOV+4pR19h/tDt/VsR2VbRtqsTuqczsN2KWtsUUiYBpqaSEcz+werxmRfTn1
         CmZdW84ELl91wVDWwY67qaDGQrgkGAlc0kw6JvccoqcXhjlTg/0BwYJEgfsKWXkpKKhy
         Im6g==
X-Gm-Message-State: AOAM533UEfRDUU+64OScTTkcD70MU4RnD8s5/n1HDGkOEV8db3QyZ4bi
        Jbks8agr+Z4+M9fXEIZvp8FITwW62SF6qNoYgG4QhPUC
X-Google-Smtp-Source: ABdhPJx2aOKgu5fZxEnyfHyK8QDEvrSq1CJXk64DtlmcgAInl6oI1//tyNAhQmR2oVnsPy6IOr7U9VMGeTLxkKbs8qU=
X-Received: by 2002:ab0:540d:: with SMTP id n13mr8923663uaa.78.1633377431233;
 Mon, 04 Oct 2021 12:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdXuTqUu6-b0y6VSFbEz7HKdH6U+__n7B8JRnO_ZWNeeLQ@mail.gmail.com>
 <87r1d0svy4.fsf@igel.home> <CAMuHMdUk5=sqFvy51nxv5g3UFPhQnZ-6dBOS=xVDWdTxuLKuRQ@mail.gmail.com>
 <xmqqczokwrt9.fsf@gitster.g>
In-Reply-To: <xmqqczokwrt9.fsf@gitster.g>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Oct 2021 21:56:59 +0200
Message-ID: <CAMuHMdVHuxzKv7z+oVnPXSBi8bLnGMZDcXdgtGR4N15UQttciQ@mail.gmail.com>
Subject: Re: git send-email splits name with comma
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Oct 4, 2021 at 8:47 PM Junio C Hamano <gitster@pobox.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Mon, Oct 4, 2021 at 4:31 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> >> On Okt 04 2021, Geert Uytterhoeven wrote:
> >> > If the name of an email address contains a comma, it will be split
> >> > incorrectly into multiple addresses.
> >>
> >> If you want to include a comma in the display-name part of an address,
> >> you need to use the quoted-string form of the phrase.
> >
> > Adding more quoting like:
> >
> >     git send-email --to "\"foo bar, geert\" <geert@linux-m68k.org>"
> >
> > indeed works.  But I feel git send-email could do better, given it already
> > receives the full email address in a single argv[] entry.
>
> Sorry, but I do not quite follow.
>
> If I were to send a message both to the list and to you, wouldn't
>
>     git send-email --to "l-k@vger.k.org, geert <g@l-m68k.o>"
>
> a valid way to do so?

Oh wait, I never realized --to and --cc take multiple email addresses;
I also use multiple --to/--cc options instead.
So the behavior I see is actually the expected behavior.
Thanks, and sorry for the noise.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
