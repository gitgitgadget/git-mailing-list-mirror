Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB252C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C915260551
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhDMOwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhDMOwG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:52:06 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043B4C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:51:46 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id c15so14323436ilj.1
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CHcoo23hzgsBmdR+/mVIn9ZW9uyv9fAoClZoNQ8Of5o=;
        b=IHNY9Na4//i1Oo7hkQUk2+eiYRc3QCNaW3ZTg8ZxX2KEGXuu5qUYT/vmUrtLMexr8U
         /u0n8Sn8f+xP2Ksb2uOfYg3FHUOlaRiImw7IMl88kh+gIW6O/V58XCo/1WqBsqYWmMih
         Rs72nprX2OK7SnPdbDObOwT5qrG8OIQHOAnuqByMqAv/GGbpQMkV1EREIL6lZsTPyp43
         MMVoFquOi/PNGgzmXoi+XbHGNG7Yp1o7bVkupXPxUrFQCgkBbn/j7wKForcEl8Udm3C8
         Ky5qXqxYnEyswwEyhkfReJsMOVrPntVSZUINw3qb2hJjhyWQiOs3KGp7ieaKbLXJXaL/
         wJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CHcoo23hzgsBmdR+/mVIn9ZW9uyv9fAoClZoNQ8Of5o=;
        b=tTKRGGAndhY5cehXPV9oZF8wGwCVgW8neDLLRzQDuH70cW7n23Dj8Gvgaz6/B0+zR+
         4HJjIWQFuZiKBfP4Jj5qnz1jbDTZEIBhdR27GYhMwhsazbkd/ASlSXx+XGVDmdb80AGC
         6drT2uNmxzUOxBgA4Pkn6Xz0Dp3PXN4Sjr1FPsZf2OBtPy3i0KkBC2OI3CS/VZsyOEhQ
         ojBLBqobolV/cBAt4tG1N3MF5/4W37PVt166HIgTtKOntz3pZqy4kIao+N4I/WaZUVa0
         CRGkXj0V9r8BfrkdPQKmO9YEFOKm0X/X97kZBE5R/TjnfbstupS7owS3VxjNSm/9AKRI
         GsKA==
X-Gm-Message-State: AOAM532D8B929D0nmBPaYA30NoSHjCnVvMF9OWTZ4FS7+/ORIrhHRxUz
        q+TDzxWWN2yyLt0AEMxSF5T4FR/x9dZvmA41Iz4=
X-Google-Smtp-Source: ABdhPJzV00qV30BXDX9IRYuEe0HRDKOUP0WT5irsdXxpbeRUrleAaLKs26+k8I7rLcTWJot+Syfl1008W1+05yjWDXE=
X-Received: by 2002:a92:d308:: with SMTP id x8mr27617810ila.301.1618325506021;
 Tue, 13 Apr 2021 07:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
 <CAOLTT8RTA0inxgxbd3qDToKYxwgXGKvJikXWsXg7oQ4asFj+HQ@mail.gmail.com>
 <CAOLTT8SW0n=x3HBL=php0aC1nhP7eU-MHFLustC3H0opxGRV1w@mail.gmail.com> <YHU86dPKODAPDXY0@coredump.intra.peff.net>
In-Reply-To: <YHU86dPKODAPDXY0@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 13 Apr 2021 22:51:30 +0800
Message-ID: <CAOLTT8Q2eV-0TemhiCL21fRWT=P6E8=Qajs1EjekTNN7XEmwpw@mail.gmail.com>
Subject: Re: GSoC Git Proposal Draft - ZheNing Hu
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B44=E6=9C=8813=E6=97=A5=E5=91=
=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Apr 11, 2021 at 11:34:35PM +0800, ZheNing Hu wrote:
>
> > > Why is Olga=E2=80=99s solution rejected?
> > > 1. Olga's solution is to let `git cat-file` use the `ref-filter` inte=
rface,
> > > the performance of `cat-file` appears to be degraded due "very eager =
to
> > > allocate lots of separate strings" in `ref-filter` and other reasons.
> >
> > I am thinking today whether we can directly append some object informat=
ion
> > directly to `&state->stack->output`, Instead of assigning to `v->s` fir=
stly.
>
> Yes, that's the direction I think we'd want to go.
>
> > But in `cmp_ref_sorting()` we will use `get_ref_atom_value()`, It is po=
ssible
> > to compare `v->s` of two different refs, I must goto fill object info i=
n `v->s`.
> >
> > So I think this is one of the reasons why `ref-filter` desires to
> > allocate a large
> > number of strings, right?
>
> Yeah, I think sorting in general is a bit tricky, because it inherently
> requires collecting the value for each item. Just thinking about what
> properties an ideal solution would have (which we might not be able to
> get all of):
>
>   - if we're sorting by something numeric (e.g., an committer
>     timestamp), we should avoid forming it into a string at all
>
>   - if the sort item requires work to extract that overlaps with the
>     output format (e.g., sorting by authordate and showing author name
>     in the format, both of which require parsing the author ident line
>     of a commit), ideally we'd just do that work once per ref/object.
>

Yes i can understand.

>   - if we are sorting, obviously we have to hold some amount of data for
>     each item in memory all at once (since we have to get data on the
>     sort properties for each, and then sort the result). So we'd
>     probably need at least some allocation per ref anyway, and an extra
>     string isn't too bad. But if we're not sorting, then it would be
>     nice to consider one ref/object at a time, which lets us keep our
>     peak memory usage lower, reuse output buffers, etc.
>

Yes, storing these strings in memory is beneficial for sorting.

> I think some of those are in competition with each other. Minimizing
> work shared between the sorting and format steps means keeping more data
> in memory. So it might be sensible to just treat them totally
> independently, and not worry about sharing work (I haven't looked at how
> ref-filter does this now).  TBH, I care a lot less about making the
> "sorting" case fast than I do about making sure that if we _aren't_
> sorting, we go as fast as possible.
>

Okay, so we just focus on the "nosort" case.
I am thinking about finding those cases that git do not need sort and we ca=
n
make a flag like "nosort =3D 1", and then use this "nosort" flag in
`ref-filter` to do the
string copy optimization what we want.
But the problem now is that `git for-each-ref` itself does not support
`--un-sort`,
and it have a default sort order by `refname`. I suspect that there are no
unsorted situation here for us to improve (Any other command call
`ref_array_sort()`
will also have similar situation, and it seem cause a little memory leak, t=
he
ref_sorting entries in sorting_tail aren't free, right?)

> -Peff

--
ZheNing Hu
