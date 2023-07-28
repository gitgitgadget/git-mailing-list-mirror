Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE97C001E0
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 03:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjG1DlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 23:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjG1DlO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 23:41:14 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD992727
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 20:41:10 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57045429f76so17515297b3.0
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 20:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690515670; x=1691120470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5FQGoXArnhw0n2CL39LnygTOQMv6D9reULyOASyNa0=;
        b=Dcxe+1piK+zXrIqPTN+WASCV7/b5eNIf8GH4KmFKupvjzQ+UXf6JfogBejJXBwfl45
         gXjpMFu2KCAkEg8+IeKkQQbid8TCDDnH0l9gM3od5VEGOE12IV3hFQvGy0o5mL76iJXG
         VMJOME6CrSZnXumC+0IsGts6Ehxssw5oEQxSB2GxGd8oLqbKuKXJgBTB0UlajwAPYM9F
         TSNvbzJCm9bwa43qoB7DBo1xLNDQ+KkC3BisryM+EndyaJY5Rx4wDxYU63Ld9/gbqvja
         j93EIrlYPOfYB0wShgStdvqRgfWE0GiJitCTuDE7n4uWfy2VU+bqShFLWtYJZU+Auj1m
         zP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690515670; x=1691120470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5FQGoXArnhw0n2CL39LnygTOQMv6D9reULyOASyNa0=;
        b=X1P0J6RrEXZ+qEh1oDqdeBe2uBDKw0snefVG7nC7aTqxIrvWyJYwZ1O/ESOC+tepTl
         S8NZ1GZvaWGD9x4IbiGiwv/UXd7bK4rHPA8BWl3WJSnP1mIfKJNDiEz7r2fEJIGGPRtJ
         0K0MOpmz8XfU/GkTiGJVG20fx+5taB9NwC/ldT2F1r1QraP+CNonnWLtCjDcgUCuVNc5
         dTWRBYU3UcsGGAuEbBRwmvLFwEavddDHKCY7/6qk2BNdR2FMHdN1FyTK9tfCQF+ehra+
         N/MrtD07Pd3YreNzGBsWV+YwrUZ3e/v69UTvjAc0UJJMgA+d4OwqozUbBDFEMd0JHU0P
         yLpQ==
X-Gm-Message-State: ABy/qLalQg8MeUUTaMUpjsWFztwwSD0OJ+O3ypQCYhLhN88KgFCqNcg2
        ysJr/AUcdBDbqbTA02N34er7C0m9vSSonbMzlhGElWFHdqPsKrgm
X-Google-Smtp-Source: APBJJlFj3T0SVE4GpmpLxb7oFdpwooRwxv5WQaDxKw7WK4F/ix9epsQ3V6jNSL0cvb3UZnJ8Kk+1I41ROuwGLEqg7+E=
X-Received: by 2002:a81:6007:0:b0:577:4005:d885 with SMTP id
 u7-20020a816007000000b005774005d885mr639922ywb.15.1690515670075; Thu, 27 Jul
 2023 20:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
 <xmqqo7k7c1yw.fsf@gitster.g> <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
 <xmqqila6cz0n.fsf@gitster.g> <ZMKtcaN7xYaTtkcI@nand.local>
In-Reply-To: <ZMKtcaN7xYaTtkcI@nand.local>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 28 Jul 2023 11:40:58 +0800
Message-ID: <CAOLTT8Ru+3efmUNMOwbhzwRu-FW-SVPYn88-xtrRQiRuweFG+Q@mail.gmail.com>
Subject: Re: [QUESTION] how to diff one blob with nothing
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=8828=E6=97=A5=
=E5=91=A8=E4=BA=94 01:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jul 26, 2023 at 11:23:52AM -0700, Junio C Hamano wrote:
> > ZheNing Hu <adlternative@gmail.com> writes:
> >
> > >> If you haven't created one, of course it would fail.  It should help
> > >> to do
> > >>
> > >>     $ git hash-object -w --stdin </dev/null
> > >>
> > >> before running
> > >>
> > >>     $ git diff 00750edc e69de29bb
> > >>
> > >
> > > This is a viable solution, but it's a bit ugly since a read-only "dif=
f"
> > > requires =E2=80=9Dwrite=E2=80=9C an empty blob.
> >
> > If you do not even have an empty blob, you have no business
> > comparing some other blobs you have with it, do you?
> >
> > If you do not have a file with a single line "hello, world\n" (that
> > hashes to 4b5fa63702dd96796042e92787f464e28f09f17d if written in a
> > blob), then you cannot do "git diff 4b5fa637" with anything and
> > expect it to work.  It is the same thing.
> >
> > Besides, if you _know_ you want to compare a blob X to emptyness,
> > you are better of doing "git cat-file blob X" in the first place.
>
> Yeah, exactly. In 346245a1bb6 (hard-code the empty tree object,
> 2008-02-13), the rationale was partly that having the empty tree object
> is useful for showing some diffs, such as for the initial commit.
>
> But I can't think of a similar argument for the empty blob. Like Junio
> said, if you're purposefully diff-ing against the empty blob, wouldn't
> you simply want the entire contents anyway? If that's the case, cat-file
> seems like a much more appropriate tool.
>

Here, it is necessary to compare multiple versions of blobs while also
considering the situations of creation and deletion.

Well, what I need is the "diff" content, with lines in the diff indicating
'+' or '-' signs. This can be achieved by manually adding them, but it is
not very compatible with the original logic.

> Thanks,
> Taylor
