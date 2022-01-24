Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030C6C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 15:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiAXPez (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 10:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiAXPey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 10:34:54 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A91C06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 07:34:54 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id c36so31631585uae.13
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 07:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O8TmqdZeZUEz8ws2wiGuLgUZ3GFabGsMA3Pbazm/PD8=;
        b=AFL5ZsTxNQLoTftFTgdWzR93scaabC947oHopfeFUB9iTyrHroiF/03/lpVw31VH9n
         Fd6mlwxuCcZlWRtxqLwwfTZMuzuTTu6GXcjgYA7EMZVAx0u4174myb2MUmvducVzIQiJ
         qDn+10/IEs6Bv6NUVH5JyRzniKOvOJt/c1hgKWxVMjz27J8lXuN0dTlfAP6Csgb/GjRG
         U5LTbJ7gQnFhQJFvRPK/ouAod8SgDEtdTiFXNJFUGhlvTZVmAZN8nL2jOGpZdEglkPqU
         kSSO1wu2tQuNP87JZ3fph0EJArGehr8C6iPOAUvYQLHHgIFQwsFxsODng/pXJ0xxiBhB
         rVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O8TmqdZeZUEz8ws2wiGuLgUZ3GFabGsMA3Pbazm/PD8=;
        b=DogzImCQSHK4NtJEs0JQofjvRjRKuPkI94siBbVe5+nXxfYs02+WsGh1yJYnaKgrW4
         rA6Iy76IGjQLjWToTaJS3P4OtmT3NIIKbxbY/fFgMLGd/zTmLEL0/u9HSADEt9zAW0UM
         nm13HMlP9kuMwMoUNv+ufwCg7ss5KDjyBHzD1cmgQAWU2OyCL8DX0+UBNWtKesR4MpD9
         wWwKdi+zroNLtWUp0UIEyi/JbHTjgDJF6L6gWPRLP7ulIfSEoioDFs7JH6IX9RGILRWU
         CKS9+DDKAG6J+rb8mPmwl8uQjbosP5AJXNrzl7Py/fqgQzf5PMF2l2+G8FxIFafhz/wX
         GuLg==
X-Gm-Message-State: AOAM532jKy2YYHxAjIb3R3O3X4OyLKLvYegNvH4eXofcK6XNJ6aP4Ack
        /30IVw8U1unnDqX0SXzOkJm1CeHVwmBRwflN7NrhSg==
X-Google-Smtp-Source: ABdhPJzs7IMjXPJnpFUa1iCwHRjMUShkY3DOKbt6E5me7nwd6rK8NbHy2GBW1LFZlGq4Jg2Xy8MEBxMTUCSHKAVEd5o=
X-Received: by 2002:a67:d98f:: with SMTP id u15mr2666898vsj.16.1643038493673;
 Mon, 24 Jan 2022 07:34:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com> <54bcac325bd542aa81328e5616b2b7573d43adac.1642691534.git.gitgitgadget@gmail.com>
 <220121.86fsphjml0.gmgdl@evledraar.gmail.com>
In-Reply-To: <220121.86fsphjml0.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 24 Jan 2022 16:34:41 +0100
Message-ID: <CAFQ2z_PAqW+RS2Znaf2wwOJfdNfkjP1VV84=xaPu_1EAuX+u5w@mail.gmail.com>
Subject: Re: [PATCH v6 14/15] reftable: make reftable_record a tagged union
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 21, 2022 at 1:32 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > This reduces the amount of glue code, because we don't need a void
> > pointer or vtable within the structure.
> > [...]
> > -     struct reftable_record rec =3D { NULL };
> > -     reftable_record_from_ref(&rec, &ref);
> > +     struct reftable_record rec =3D { .type =3D BLOCK_TYPE_REF,
> > +                                    .u.ref =3D {
> > +                                            .refname =3D (char *)name,
> > +                                    } };
> >       return tab->ops->seek_record(tab->table_arg, it, &rec);
> >  }
>
> Both for this & the below don't we prefer to have such assignments on
> their own line? I.e.:

I generally let clang-format do formatting for me, but it looks like
it doesn't want to make a decision about where to put line breaks
here.

I've made the style consistent.
> > +     struct reftable_record clean =3D {
> > +             .type =3D typ,
>
> ...only this "type" member, which won't confuse a compiler.
>
> > +     switch (typ) {
>
> ...but actually...

typ vs type is a remnant of the Go origins (type is a reserved word in Go).

I fixed up a couple of places where I add it newly in the commit, but
it makes more sense to change this throughout in a separate commit.

> > +     return clean;
> > +}
>
> ...reading this whole function shouldn't this be a more normal *_init()
> pattern function where the caller just populates the ".type =3D ", and we
> init the rest here? That would also make the ownership more obvious, and
> if any future API user needs to pass in variable on the heap instead of
> us returning it on the stack here...

this function exists so you can initialize as part of a list of
declarations , eg.

 struct reftable_record rec =3D reftable_new_record(block_reader_type(br));
 struct strbuf key =3D STRBUF_INIT;
 int err =3D 0;
 struct block_iter next =3D {
  .last_key =3D STRBUF_INIT,
 };
 int i =3D binsearch(br->restart_count, &restart_key_less, &args);

with init functions, you have reorganize all of these blocks.


> > -/* zeroes out the embedded record */
> > +/* frees and zeroes out the embedded record */
> >  void reftable_record_release(struct reftable_record *rec);
>
> I didn't follow all the vtable entries, but for these:
>
>     4 matches for ".release =3D" in buffer: record.c
>         440:        .release =3D &reftable_ref_record_release_void,
>         582:        .release =3D &reftable_obj_record_release,
>         925:        .release =3D &reftable_log_record_release_void,
>        1052:        .release =3D &reftable_index_record_release,
>
> Some zero'd the data out already, but for
> "reftable_index_record_release" isn't promising this a bug, as we don't
> want to memset() to 0 a strbuf_init()?

Isn't strbuf_release() -which is used- the correct way to clear out a strbu=
f?

>>       }
>> -
>
>...more stray whitespace...

If you trim this much context, can you provide a line number?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
