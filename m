Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22986C433ED
	for <git@archiver.kernel.org>; Sun,  9 May 2021 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AD3613C5
	for <git@archiver.kernel.org>; Sun,  9 May 2021 13:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhEINl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 09:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhEINl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 09:41:57 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E9CC061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 06:40:54 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id t3so12296896iol.5
        for <git@vger.kernel.org>; Sun, 09 May 2021 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Qm/rW67MJQM65qXA7M+GyYN6p8p+BB9JLeVowb1Nvs=;
        b=NaDiw59HAJ0Pr4MaFH1oeM3ElBSDxB4Nq4SDIs1vUgPOfS+VJzhrQ2ZNrhYJqyQNWE
         4KQezj5u+RM9tokMJ7smrOx5ojBqXml68tCdV7uqVkLN5D1smO+IvaGSrgn63P9vODnA
         gElJvsz1CjHvDo4msK/EzFb3dakf8PfPG7jp/Pt0i3WKmCQaUv8OLqTAgDIusbJ+lHyx
         yIKCPGei4ioY++/kGOoIpwQDpD2tNK+C+k7sOM83tjz9xc9ANZk/h9Z9GmiQQtaNVVl0
         B/oGV3cE7pv6EoRNXVsKAMj3kZ1bLEtaG35+MpgPYQM+Kmgl1qlo9EJG94+8InKT9jBD
         u/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Qm/rW67MJQM65qXA7M+GyYN6p8p+BB9JLeVowb1Nvs=;
        b=WDI9Z6X/WqsA+uGyDjrKbjZqKJdjSiHACD1xrm8ZRoLZgkWGhIWsWFM4FUTcFCGkOj
         UayQIM1OMX22xXHRHPVlLBlDPDjD0+hqF8WqSmtrHXG3d0XltYdVKG8N8ywba2szhQCg
         7bqnWrQcwK+NJ36clF5r5vTHwdlyfmn/6WLA1CsFkFIMR73BRkB9CEwJgxpoGvd4EIk9
         vBV9vwApJoKelvxAdWw+FDY7m57ymxv5ppiaymWKC45vQ9zIzRqmTJh0N+zKqlXzbq9W
         DFu8Mu33Ltobi0q7NLZQGDuMk2HztqvhyNI8ZmRc8mDmsg12WQLHrOF+el/xeAZAMPyn
         aE6w==
X-Gm-Message-State: AOAM531f+rDrdepURgsKd8SlsBfmfYttgBp3RpHc7CNGI7Ryy4uEs3/t
        fMdL9kgBjhSacL9OmRbG7S7X6VOkX/cZUQhjsGY=
X-Google-Smtp-Source: ABdhPJz5TBpimuQ75uDhiucjtcbRngfA7brE9SDq9Gcf6iGr2J9uxX6HQ7l5twrsWFulkHsMF2u4yecd9eq+pGQQa/Y=
X-Received: by 2002:a5d:89c5:: with SMTP id a5mr15110572iot.172.1620567653516;
 Sun, 09 May 2021 06:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
 <3770df1829830229e768607b699730d2a7c21c5e.1620487353.git.gitgitgadget@gmail.com>
 <CAP8UFD0mOmqWUS49wywDVoWOyAkCRSUY5+i7Gqq-ZZSNCr-jvg@mail.gmail.com>
In-Reply-To: <CAP8UFD0mOmqWUS49wywDVoWOyAkCRSUY5+i7Gqq-ZZSNCr-jvg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 9 May 2021 21:40:37 +0800
Message-ID: <CAOLTT8TGa2U=O6jAOcmqVwiKv6RiSt5j7FuA_XTO=JVi73ts2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC][RFC] ref-filter: introduce enum atom_type
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=889=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=882:21=E5=86=99=E9=81=93=EF=
=BC=9A
>
> > At the same time, The value of an atom_type is the coordinate
> > of its corresponding valid_atom entry, we can quickly index
> > to the corresponding valid_atom entry by the atom_type value.
>
> I am not sure it's worth having an atom_type field for each valid_atom
> element if the value of that field is already the index of the
> element, because then one would always be able to replace
> `valid_atom[i].atom_type` with just `i`. Or is it for some kind of
> type safety issue?
>

Well, I think the security issue here is just to allow used_atom and valid_=
atom
to be correctly mapped through atom_type. We don=E2=80=99t want the coder t=
o forget to
update "enum atom_type" when adding new atoms to valid_atom in the future.
So maybe Junio's suggestion is reasonable, we delete the member atom_type i=
n
valid_atom, but maintain the connection between atom_type and valid_atom it=
ems
by specifying atom_type as array coordinates.

> I wonder if the enum should be instead defined like this:
>
> enum atom_type {
> ATOM_UNKNOWN =3D 0,
> ATOM_REFNAME,
> ...
> ATOM_ELSE,
> ATOM_INVALID, /* should be last */
> };
>
> As a struct containing an atom_type would typically be initialized
> with 0 after being allocated, `ATOM_UNKNOWN =3D 0` could ensure that we
> can easily distinguish such a struct where the atom_type is known from
> such a struct where it is unknown yet.
>
> Having ATOM_INVALID as always the last enum value (even if some new
> ones are added later) could help us iterate over the valid atoms using
> something like:
>
> for (i =3D ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++)
>         /* do something with valid_atom[i] */;
>

Thanks, this suggestion is good!

> > +
> >  /*
> >   * An atom is a valid field atom listed below, possibly prefixed with
> >   * a "*" to denote deref_tag().
> > @@ -122,6 +166,7 @@ static struct used_atom {
> >         const char *name;
> >         cmp_type type;
> >         info_source source;
> > +       enum atom_type atom_type;
> >         union {
> >                 char color[COLOR_MAXLEN];
> >                 struct align align;
> > @@ -500,53 +545,54 @@ static int head_atom_parser(const struct ref_form=
at *format, struct used_atom *a
> >  }
> >
> >  static struct {
> > +       enum atom_type atom_type;
> >         const char *name;
> >         info_source source;
> >         cmp_type cmp_type;
>
> I can see that the fields are already not in the same order as in
> struct used_atom, but my opinion is that it would be better if they
> would we as much as possible in the same order. Maybe one day we could
> even unify these structs in some way.
>

Yes, atom_value, valid_atom, used_atom, It may be difficult to read for the
first time. Maybe unifying them is a good direction for the future.

> Also as discussed above we might not even need to add an atom_type to
> valid_atom[].
>

OK.

> >         int (*parser)(const struct ref_format *format, struct used_atom=
 *atom,
> >                       const char *arg, struct strbuf *err);
> >  } valid_atom[] =3D {
>
> > @@ -628,6 +674,7 @@ static int parse_ref_filter_atom(const struct ref_f=
ormat *format,
> >         at =3D used_atom_cnt;
> >         used_atom_cnt++;
> >         REALLOC_ARRAY(used_atom, used_atom_cnt);
> > +       used_atom[at].atom_type =3D valid_atom[i].atom_type;
>
> As discussed above, if the value of an atom_type is the coordinate of
> its corresponding valid_atom entry, then here the following would be
> simpler:
>
>        used_atom[at].atom_type =3D i;
>

I agree.

> >         used_atom[at].name =3D xmemdupz(atom, ep - atom);
> >         used_atom[at].type =3D valid_atom[i].cmp_type;
> >         used_atom[at].source =3D valid_atom[i].source;
> > @@ -652,7 +699,7 @@ static int parse_ref_filter_atom(const struct ref_f=
ormat *format,
> >                 return -1;
> >         if (*atom =3D=3D '*')
> >                 need_tagged =3D 1;
> > -       if (!strcmp(valid_atom[i].name, "symref"))
> > +       if (valid_atom[i].atom_type =3D=3D ATOM_SYMREF)
>
> In the same way as above, the above line might be replaced with the simpl=
er:
>
>        if (i =3D=3D ATOM_SYMREF)
>
> >                 need_symref =3D 1;
> >         return at;
> >  }

Thanks!
--
ZheNing Hu
