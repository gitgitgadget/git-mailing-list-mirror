Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8CFC433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6DC2224D
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/6K+Ctr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGWP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGWP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 18:15:28 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F42C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 15:15:27 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j23so1487075vsq.7
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jv5GgguYdS2Hgv4SRROZDKmrEzrUz0/Q3hatK9yyfEU=;
        b=H/6K+Ctr/M30zossQsGRWwSbdHRwX2HhKg/yCMvIpip+BVc2ygtRc8M8vnt09ybj5d
         tNaFxR5eUxuTInokj5tMJTndIH8+2jB1v7pigdgQgngAhvEpBWmbXfEG9MheN360ZSOB
         R07EwiS26wtYxmc6rsyCz00cwRWYtH2PrFUvjiXcZTSKJBc1jT1eJEE+4bXICAppR7SR
         q11hfsloG47fJCCYULQxXojR5847B5FFJ7y+VIyIgVx17JL9thtm6g08HPm6aqJmKPaX
         A9yQuYEkWMt/5Fi17kuzMu6DErReLF0aSDFQkurcY6Gyl1K0JIYk8ULqgJs2MNB4tIYy
         B63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jv5GgguYdS2Hgv4SRROZDKmrEzrUz0/Q3hatK9yyfEU=;
        b=IV6jI3XXNveM+6qGBnIJDnqF0cLn22KoDiitFu/XREIpmjhRX53f+9mKRDm/I2DKZf
         +HoAh0ifBP7BasWUwUdvc5s7pBhjQcn+XovF68JS2xh3cSolxxXNfQmIEroSmM7pk89l
         bBNOAPHBAIeTM4tomZzYRw2KZAgmvk+MhhwjJ1Q0G3YtBDM2rAFf1mr8AEeB6KxLh1Ll
         pacTe9LeUr97YriBaKwM/xwY1LOA784AeLElTzgMYzunPDd4yiv7ytdMZU3UFYM7DY3T
         SFUk8wk5icdg8k6IryMRPE500GJApBLemim1Xxzl7+Yx9srAk/O+Rb4TLattTwr62QSw
         965Q==
X-Gm-Message-State: AOAM531S1ZkZ8i8uDB/aV9D7KvQYwV6aTgA7aWE+SoVRFyFj1409Q7ei
        ibkVBzvYVGFNE2lnnxkBtZZy+lol0aKixUzga78=
X-Google-Smtp-Source: ABdhPJyPKsb5ufu1yd15jVI0C1UFuOTKKKW9TIaRi726XwFFNDLa+w4KR0225CfLV7FUmPAyJe5N2OswjHTnf0Pudkk=
X-Received: by 2002:a67:bb06:: with SMTP id m6mr13041912vsn.54.1596838526260;
 Fri, 07 Aug 2020 15:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200806202358.2265705-1-martin.agren@gmail.com>
 <20200806230837.GA8085@camp.crustytoothpaste.net> <CAN0heSptiJL9d86ZeNPMUaZeTA68juwTyf3K-uWR=K-vt=1Hrg@mail.gmail.com>
 <xmqqr1sifaeu.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1sifaeu.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 8 Aug 2020 00:15:13 +0200
Message-ID: <CAN0heSqyBzW_+vWSAxV9O1XAJKmQgrhCms7mSa+hFFx35uU05w@mail.gmail.com>
Subject: Re: [PATCH] Documentation: mark `--object-format=sha256` as experimental
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 7 Aug 2020 at 22:50, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> >> I'm fine with marking the functionality experimental for a few release=
s,
> >> since it is possible we have bugs people haven't found, and adding a
> >> note about interoperability after that point, since I think that's a
> >> fair and valuable issue.  I think if we go a few releases without any
> >> major issues, we can change this to the following:
> >>
> >>   Note that a SHA-256 repository cannot yet share work with "regular"
> >>   SHA-1 repositories.  Many tools do not yet understand SHA-256
> >>   repositories, so users may wish to take this into account when
> >>   creating new repositories.
> >
> > With respect, I think that's too aggressive. By that time, we may
> > conclude that, e.g., the "v2 pack indices with SHA-256" file handling i=
s
> > robust. But I'd be surprised if using `git init --object-format=3Dsha25=
6`
> > in June 2021 won't cause *some* extra work for users or ourselves
> > further down the line compared to using a regular SHA-1 `git init`.
> > Pushing to a SHA-1 hosting service will become *possible* at some point=
,
> > but maybe it won't be *efficient enough to be practical in the real
> > world* until some time after that.
>
> IOW, you question "if we go a few releases without any major issues"
> part?  I tend to agree that for a large change like this, a few
> releases may not be sufficiently long time for a feature that is
> marked as experimental in big flashing red letters to get exercised
> enough to get major issues noticed.

Yeah, thanks for summarizing what I failed to express using so many
words.

I'm fully open to the idea that some people want to leave SHA-1 behind
and that they can do it today, in some "local" sense. If those people
are fully aware that they are guinea pigs, it might actually be ok for
us to subject them to a few rounds of "oops, Git v2.32.0 produces data
that v2.34.0 and later will barf on". Or at least it would be on our
table whether we wanted to be that cavalier.

Once SHA-256 repos as such are no longer experimental, I fear that we
can only buy ourselves that leeway by introducing fiftyeleven different
config flags for "please produce auxiliary files X even if you don't
actually use them", "please do use X, and I'm fully expecting to trip on
them if you decide to tweak them in backwards-incompatible ways", and so
on. The alternative to buying such leeway might be to establish, pretty
early on, a respectable set of things we support "for compatibility
reasons".

> > Now would probably be a good time to update the hash transition
> > documents, first of all to tick off what we've already done, and second=
,
> > to reassess the rest.
>
> Yes, it is a good idea to stop and see where in the overall large
> picture we currently are.

Martin
