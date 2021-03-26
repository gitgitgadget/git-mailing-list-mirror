Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D1EC433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9C761A48
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhCZKZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCZKZk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 06:25:40 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8F9C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:25:39 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id z15so5229173oic.8
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=guIPfC5ku4SIa5Rs+J3uQspv2yiGxmtYOmpCipIKs60=;
        b=DVbgBS4I9+YRPtBHPumBFmdQ/LiMSKd7k/b6VXg1cfYEP1FQQ+Np4N8opRhXk/4tDk
         36bjkntg2g4JoJiCqn6z7DFofRkgfAfJqHqil62HwH/k5WvIZCqOzflu0SxOkdf/KnDU
         aOgQhedkHfir2KPNYnO5J9x2YzDTI2asgrZzP17TJ62hJMhB/ts1V6PK7ji7C+P6iwws
         pfkEdfE/+0xkWimhWtskyi33tpeCh3nUJ2wMHn/6P2mOlxpSf3N1mSuytK8ZqotcDrpN
         KmPUB1h749L0teo8Xn0tLk3LY3zzR0DSYEUew4aiVrrN2wA5rqbp/ZwZokIQGVrE+hb3
         ZLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=guIPfC5ku4SIa5Rs+J3uQspv2yiGxmtYOmpCipIKs60=;
        b=kTUeuzKBhCmVCvvtHtAxls0+dxoMs4hgU3crjy26WFpV6Ah3G4cBMkqEOS8GrwFB1s
         jq1UmrgaaGGxEXrMBfl3W4h7SHhDFXrRUPvqCf5Uu01IVbECeDf4O80mRMjd6JunFoNs
         Mv502qVLyLUoY3IzOXecH1bC94fxHccYmdcQrkdfV1aSxYdNz32bmZATsBIpjinJVdMe
         XVrXtnSobX3V73xPxiTzwp/DXqBuYewOSzyDDiX83k/uJ6ca1QnwXBNK1evSOf4QYM9O
         sn/twhd8NIGLueFgIRC2Y144jwjwJ25KGzTxT9aoTsNeurZgErjRIEDsTlFzYDXcB2Cw
         suig==
X-Gm-Message-State: AOAM531+1vBBN7z2rgQ2bYQjPBOIbrA2ztfpdT0m+krt6YBnS0LYj2NM
        EH+k/brdbKBvVuRoKLsZK/E8zbNNwmPzJlHUX6M=
X-Google-Smtp-Source: ABdhPJwIDdn7RYWEydtmxS6RiZG1fmb3K2mGACZNPlT+iTQaC9B0qdLwgKkttpS8iR0UR5fg9SKp+zMSbw/elSQqYns=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr9563939oia.44.1616754338734;
 Fri, 26 Mar 2021 03:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
 <xmqqczx0sq1o.fsf@gitster.c.googlers.com> <YCwJ8tORQg2Air4r@nand.local>
 <xmqqmtw3pzu3.fsf@gitster.c.googlers.com> <YCwhPG6RaAhU9ljg@nand.local>
 <CAP8UFD1QG_b6ax-HodLRRcdLKgWJhPDghjLfjnyan1Zi80en7A@mail.gmail.com>
 <xmqqsg4l3h32.fsf@gitster.g> <CAP8UFD0rRff7oCMH=DeTQ-tZw7STLwSHLecWxRr_rQVyHuxJuA@mail.gmail.com>
 <CAOLTT8TFTcw9fkfPk-vi3REtZqCWYS28LEP5jfy-TmYuWf747g@mail.gmail.com> <xmqqmturw13r.fsf@gitster.g>
In-Reply-To: <xmqqmturw13r.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 26 Mar 2021 18:25:26 +0800
Message-ID: <CAOLTT8QPJJWh_Xm=n+i7z5+5w=eBq9tcr5-yBmhovzqOXP=jnQ@mail.gmail.com>
Subject: Re: Bug Report: Multi-line trailers containing empty lines break parsing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:16=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=
=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:54=E5=86=99=E9=
=81=93=EF=BC=9A
> >>
> >> Maybe it's not enough, but the doc already has the following:
> >>
> >> ------
> >> Existing trailers are extracted from the input message by looking for
> >> a group of one or more lines that (i) is all trailers, or (ii) contain=
s at
> >> least one Git-generated or user-configured trailer and consists of at
> >> least 25% trailers.
> >> The group must be preceded by one or more empty (or whitespace-only) l=
ines.
> >> The group must either be at the end of the message or be the last
> >> non-whitespace lines before a line that starts with '---' (followed by=
 a
> >> space or the end of the line). Such three minus signs start the patch
> >> part of the message. See also `--no-divider` below.
> >>
> >> When reading trailers, there can be whitespaces after the
> >> token, the separator and the value. There can also be whitespaces
> >> inside the token and the value. The value may be split over multiple l=
ines with
> >> each subsequent line starting with whitespace, like the "folding" in R=
FC 822.
> >> ------
> >
> >
> > Maybe I don't have enough right to speak on this issue, but I always th=
ink that
> >  the empty line is intentional by the designer, especially when I test =
it.
>
> People like you, who is relatively new to the system and the list,
> are valuable source of information for us to learn where in the
> current system and documentation we have room to improve and
> clarify.  You do have right, and we welcome your input.
>

Thanks:)

> Care to clarify what you mean by "the empty line is intentional by
> the designer"?  The designer of the current "trailer" intended to
> make the "last paragraph" (where "paragraph" is defined as a run of
> lines without an empty line in it, so that one or more continguous
> empty lines separate "paragraphs") where the trailers sit in the log
> message.  Is that what you mean?  Or something else?

Emmm, I mean generally speaking, the entire commit infomations is divided i=
nto
three paragraphs: "subject"/"message"/"trailers".

When we use `--parse` to get those trailers, normally it can indeed be obta=
ined,
But if in the middle of the trailers have a extra empty lines or lines with=
 only
whitespaces, All trailers before the blank line will be discarded, I think =
it is
acceptable.Because It seems that the previous content belongs to the messag=
e
section.

Like this:
------
(subject)

First paragraph:
hello world

Second paragraph:
what happen if some thing like

this: Use git to commit code to git

Signed-off-by: CoCo <cc@gg.com>
Deleted-by: ADL <a@gg.com>
-----

"this: Use git to commit code to git" seem like a trailer,
but it's user's message.

So I think the purpose of these blank lines is to separate the
three parts of the commit information. It is normal for the blank
lines inside trailers to cause ambiguity.

Please correct me if I what I said is wrong.
--
ZheNing Hu
