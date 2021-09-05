Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC09C433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 08:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B7960F90
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 08:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbhIEJAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 05:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhIEJAM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 05:00:12 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9DBC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 01:59:09 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a13so4581766iol.5
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=npFRySaIEoxoeR26CWBWTTK/f6zoAREl5ELhNVsw+aU=;
        b=Az7A4N4wNgyE+9+jH2yTnmUb36oj32toGskagveH0S/dL3GSXof17AobolrMomjXNO
         MEA1u1PvRiPdP7nmZ3f3ZwynIYiD/CbAhPTzz+dZ2yT2YZsxqzf9mZYyK7KlT4znwYvO
         U4/0n9yd6hL70ZULNHounHn52QmYmwkuUxPOfQAyQwIYn2DpUuRK9hqQoopJY5JAjxd9
         qES5fuL8vaCsNTtk+3zf7TSVx7QbiCokKOiSnL0ZtPEQArRNrNQk1XPCEJR38Qr1XyXI
         EUoWfm0l5FW1Mb7LnTrGvLbBxMmWlX6VtiV2uUf2Jl3S4PJSP2zMWbLaM2BIm8GpTCbo
         1j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=npFRySaIEoxoeR26CWBWTTK/f6zoAREl5ELhNVsw+aU=;
        b=EsjdZiTdUKllE6WZTSq0JecioUQ4It4/C6wQ1LNeFmmeFKyAUtaHstZyE68+J/1PMw
         lKjGGUh6aE00qzAXpMw3DfnYGNXWnF1aydHvSElHSm7zM+eV8f2Hz93uPvZ/8FD4RRzy
         U8jsk97nu+0M7FyR/zL/h8Ijblf2U9fjy8CB1MaWfD6eYwsVPnd+IkyRLO1Omrv24tU1
         KJxC5ZkiU/bZGdXKXA4J125vtde/b5BCNegcZpHoY596gK283/gWYA76GvSkgt81kv+X
         HdAEaHhnYlFqaXsYMJC4Qi4D+EZzW+y1PWcq+BDqPjqTDY3J5z2262vHtQCDJ5iVWVde
         jIyQ==
X-Gm-Message-State: AOAM532ipqFgZYczXieURNC+MOKKq9BlUXpkyiO6QIJQgZ1XMLx7uJqh
        bpYttClkqecLZen/f5QmvSrgL0XskBp559oMAuc=
X-Google-Smtp-Source: ABdhPJx1EkL6sf56XN0nrMLyq6teV3a4VGbpQe1MeJprdPtct9z/R1ZOz3oxwCtHzwXlCevBQhFPWmlD/tdPWgb76qk=
X-Received: by 2002:a6b:d209:: with SMTP id q9mr5600560iob.206.1630832348991;
 Sun, 05 Sep 2021 01:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <CAP8UFD2SNyCj6Weo4EeHt0Z-CW9CEJbQbzmU7jhwfJdNW9CrYQ@mail.gmail.com>
 <CAOLTT8QufEU5Q64JfQyEOs4FYCsrNX2jgj8PdmYziVtKnRyu4w@mail.gmail.com> <YTNrehKnfPo3E5RI@coredump.intra.peff.net>
In-Reply-To: <YTNrehKnfPo3E5RI@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 5 Sep 2021 16:58:57 +0800
Message-ID: <CAOLTT8S1Tfu6YWcoHhZcydQYd_yBBCavdqyV_TzoOrEW6zHXGQ@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <ttaylorr@github.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=884=E6=97=A5=E5=91=
=A8=E5=85=AD =E4=B8=8B=E5=8D=888:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Sep 04, 2021 at 03:40:41PM +0800, ZheNing Hu wrote:
>
> > This may be a place to promote my patches: See [1][2][3].
> > It can provide some extra atoms for git cat-file --batch | --batch-chec=
k,
> > like %(tree), %(author), %(tagger) etc. Although some performance
> > optimizations have been made, It still has small performance gap.
> >
> > If the community still expects git cat-file --batch to reuse the logic
> > of ref-filter,
> > I expect it to get the attention of reviewers.
> >
> > The solutions I can think of to further optimize performance are:
> > 1. Delay the evaluation of some ref-filter intermediate data.
> > 2. Let ref-filter code reentrant and can be called in multi-threaded  t=
o take
> > advantage of multi-core.
>
> I don't think trying to thread it will help much. For expensive formats,
> where we have to actually open and parse objects, in theory we could do
> that in parallel. But most of our time there is spent in zlib getting
> the object data, and that all needs to be done under a big lock.
>

This big lock is "obj_read_lock()", right? If there are indeed the limitati=
ons
of these locks, I am afraid that the parallel scheme is not good.

> For little formats (e.g., just printing "%(refname)"), we need to
> serialize the output anyway. So our unit of work is so tiny, I suspect
> that the threading overhead would be a net negative.
>

Make sence.

> I was coincidentally looking at ref-filter last week, and it seemed to
> me that a lot of the slowness is because of the over-use of malloc

Agree. malloc() and data-copy is the reason for the poor performance of
ref-filter.

> (e.g., we allocate a substring for every atom_value, and then form them
> into a separate buffer). If we could parse the original format into a
> form that could be traversed without having to do further allocations,
> just writing directly to a strbuf (or even a file handle), I think that
> would be a big improvement.
>

This patch has been tried to eliminate some malloc and data-copy:
https://lore.kernel.org/git/3760ff032bb1dec3812881fd408f8d78ec125477.162918=
4489.git.gitgitgadget@gmail.com/
It is indeed possible to obtain some optimizations.

> I just posted the results of some of my experiments to the list:
>
>   https://lore.kernel.org/git/YTNpQ7Od1U%2F5i0R7@coredump.intra.peff.net/
>
> I don't think that gives any kind of useful base to build on, but it
> shows what's possible by skipping past various segments of the
> ref-filter code.
>
> -Peff

Thanks.
--
ZheNing Hu
