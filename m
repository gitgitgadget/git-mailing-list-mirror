Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BE7C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 02:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3EDE60F4C
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 02:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhHUCQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 22:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUCQw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 22:16:52 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5675C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 19:16:13 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f11so14602889ioj.3
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 19:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aIo5Zeom+9IjPF+L03Y8TFLjMhHiXerFNwu/EbiEftk=;
        b=SiCytT7FkP9RyhhpvoiBoY/UjopEsDXjQ6WJJo+9AijM2yfx0KXfdPPv6UsUfZUrVP
         q7LDmqT7ICxPGDMmYQ/+TeUMlRZiIe9jefJwkaBZm6iP4H3hA08X6SmFDndEL4ir4VFx
         05wLdByI2T5H5BhvYbbIWzlYIbRPHpgsYx4u02/vTMWnRA4+BMV05ZiMWV53/vYUaOnK
         sfGwz5na5NhFSWFuROhG2qj13QBQ2Ob7X1HFA9rMrhpPShQ/qHlaY/gp0DL/NeqJH4pt
         XW0CYULWaSvch0Ro3U7yKQ+v06rR3geV+kwQZ7i6vPoVyFcQ5TVJKuy+tfHX0XRarTAv
         uOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aIo5Zeom+9IjPF+L03Y8TFLjMhHiXerFNwu/EbiEftk=;
        b=RaDUQVFQeBDo2YsJZChyTT6/N6rhmSKfxTQdBP3PLpnuUdlFq3S2XsNpt9VyNgDTiq
         /+pZYVcNaBetRTHZ57JsAjpHp4iNN1ui0kktHaOgHkG78TCwS7OIqboXvZHIVONH2pZg
         15mLO5sFzj+O5tyJb/4lJWpJddTc1rllgXeN9wVJ117yMFer9AwvwC0AOmi8fMyrV6KQ
         zMNJMh58Uv9YbJnUjdVZoebkGjN6KcrdTEDSnaoD5BiqstwYOMoSVNqDTE/xJ+HwcUuH
         0J9W+5eHNYRPSxoyvNfIOdpnRtv5MkYe2seAywAgZ+OnAMdB92AflyqVTgVbs17B/uoH
         JVpw==
X-Gm-Message-State: AOAM5319KV5+BnVj3i5ptDnQMpPP97LSR6XJU7tmlXbU6i4hVlq0kAJ6
        36Sg1+rPr0IbucJ5cT3CVIlNTNKKaLgkB2BKqYY=
X-Google-Smtp-Source: ABdhPJwVBtAwbrdW+JlWJD9lJFJDo+C22+YB2u7lyOGO/WXewVnZmwEq3TiPq1f5rrl+2uzgeF2RB+ZMDOj0KA9f2n8=
X-Received: by 2002:a02:cd0c:: with SMTP id g12mr7381681jaq.130.1629512173365;
 Fri, 20 Aug 2021 19:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
 <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com>
 <CAOLTT8TB0HUBnYc1U7o36wBp=qxKDOLA6D9K19niNt_y_W==ag@mail.gmail.com>
 <CAP8UFD15vZ4B3dxPamaxqySZgLwffHU1Rx21bHRLY9zndjvAew@mail.gmail.com>
 <CAOLTT8SjLPXT7ows-MZQLmDwzPN5pUrqj26+PHVbTevkBn3Tug@mail.gmail.com>
 <CAOLTT8RY213BMTq+wx8yS=0QjY55L1BnCgPHQph1uos2oX03gw@mail.gmail.com> <CAP8UFD0aDrqHxNp2ztecmZR49gs=SVJTN1NUzJvz6+ewpY-_wA@mail.gmail.com>
In-Reply-To: <CAP8UFD0aDrqHxNp2ztecmZR49gs=SVJTN1NUzJvz6+ewpY-_wA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 21 Aug 2021 10:16:02 +0800
Message-ID: <CAOLTT8St0PGPsw6zki2fwO3iVG_4W=s6GEqZfp3cmH=xngcO2A@mail.gmail.com>
Subject: Re: [GSOC] [QUESTION] ref-filter: can %(raw) implement reuse oi.content?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=
=8820=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:58=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Wed, Aug 18, 2021 at 1:11 PM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8818=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:07=E5=86=99=E9=81=93=EF=BC=
=9A
> > > I think the 'buf' is not freed in ref-filter logic.
> > >
> > > But one thing worth noting is:
> > >
> > > parse_object_buffer() may take this buffer away, and store it in
> > > tree->buffer or use set_commit_buffer() to store it in commit_slab.
> > >
> > > So in theory, as long as we don=E2=80=99t use parse_object_buffer(), =
this
> > > dynamically allocated memory can be used freely for us. If we use
> > > parse_object_buffer() and free the buffer, there seems to be a risk,
> > > but it does not appear so far.
> > >
> >
> > When parse_object_buffer() hints that we don=E2=80=99t free the buffer =
when
> > eaten =3D=3D 1, I have a better idea, If the buffer is "eaten", we copy=
 it,
> > otherwise we use the originally allocated space.
> >
> > -static void grab_sub_body_contents(struct atom_value *val, int deref,
> > struct expand_data *data)
> > +static void grab_sub_body_contents(struct atom_value *val, int deref,
> > struct expand_data *data, int eaten)
> >  {
> >         int i;
> >         const char *subpos =3D NULL, *bodypos =3D NULL, *sigpos =3D NUL=
L;
> > @@ -1499,7 +1499,10 @@ static void grab_sub_body_contents(struct
> > atom_value *val, int deref, struct exp
> >                         unsigned long buf_size =3D data->size;
> >
> >                         if (atom->u.raw_data.option =3D=3D RAW_BARE) {
> > -                               v->s =3D buf;
> > +                               if (eaten)
> > +                                       v->s =3D xmemdupz(buf, buf_size=
);
>
> Can the 'buf' already be eaten at this point? I thought that it could
> be eaten only through v->s so after this code.
>

I think where the 'buf' is eaten is parse_object_buffer(). set_commit_buffe=
r()
or parse_tree_buffer() cache the 'buf'. 'eaten' means we don't need to free=
 it
manually. In grab_sub_body_contents() we can indeed write the address of
'buf' to v->s, but what I worry about is that before we completely write v-=
>s to
the output buffer through append_atom(), will this buf be freed in
somewhere else?

> > +                               else
> > +                                       v->s =3D buf;
> >                                 v->s_size =3D buf_size;
> >                         } else if (atom->u.raw_data.option =3D=3D RAW_L=
ENGTH) {
> >                                 v->s =3D xstrfmt_len(&v->s_size,
> > "%"PRIuMAX, (uintmax_t)buf_size);
> >
> > As parse_object_buffer() does internally: the buffer of commit/tree obj=
ects
> > needs to be copied, but blob/tag not. You said that the number of commi=
ts
> > is generally significantly greater than the others. It seems that we ca=
nnot
> > make full use of this idea. But remember the "skip_parse_buffer" before=
?
> > If we skip the parse_object_buffer(), this buffer is also "!eaten".
> >
> > In other words, those default paths of git cat-file --batch are include=
d in it!
> > So from the perspective of performance regression, this patch will be
> > beneficial.
>
> Yeah, it seems that we can benefit from something like this, but it'd

Only when the data allocated to us is dynamically allocated and we do have
the ownership of it, we can benefit by reducing copies and allocate
memory again.

> be nice if things were clarified a bit more.

OK. In get_object(), eaten means that the oi->content we obtained is cached
by git in parse_object_buffer(). This means that we don't need to free this=
 buf
manually. In 28511adfa5 ([GSOC] ref-filter: skip parse_object_buffer()), we=
 skip
parse_buffer() when using some atoms, which can avoid some meaningless pars=
ing.
So under this path, our'buf' is not cached. This means we have
ownership of it, so we
can free it freely, and benefit from this.

Thanks.
--
ZheNing Hu
