Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E844C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 02:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhLFCLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 21:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhLFCLH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 21:11:07 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FF5C061751
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 18:07:39 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id z7so21529832lfi.11
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 18:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IksdOEmjaMvzsJoY2ECgiNmyz+8D/9C1pe0jqNvzbZU=;
        b=oifVp7kVEekGAhwJeeuNjnZW0IrI08hnmFfcPTjyssk5B5PV0hh7Eu5QCF1bS2/4FZ
         inaG0efdlBwBKhUNcJFSjS28/oQNCKJk4xPAFu1NaKgUgl/BVC2YWiGuaAH52o86GX6q
         Nm2JrR6hXOsTFwZpC8L6oKpTH8W2YT1dCKxu2LQWccYgVGdU8qgVe2OLtdi1D2C0z29c
         hBE9+x2JWxrx+17eINN4ej6ozOa0eEfiSIWrxnJ58DmllxQdKRqGlmsaWrBUSjY0XvYM
         lUmyobSzqXI4eseqlPFi8rIQBU6t6LEk/iL9QNrK2oMmuGojB+Ir+yMZT43FN8VxryJP
         QakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IksdOEmjaMvzsJoY2ECgiNmyz+8D/9C1pe0jqNvzbZU=;
        b=CLVdBsWrDvhEnq/lFvyyJXHHimOrZHcsk4C5w9/hQiz1prvS72TOSjBDI4mjBygNo/
         WewP/ZomRXCQi3f/dpCWlvDIA9j2FnwxhEBwruD5U6wH/OAYdIvrHgsxQpJlHTCKmCY0
         +72/S3pWATtWzw4De8rRwbSLkOzGJoTxx1OhCkweLnox3YH0gZIgAxNfNDyEms11VY0m
         EL5tq0Po1uOxjKLhbZJivBPbYIgUjlmF9ixBaaA8zedF2cwfv+3h/DSW1/fPkPRcV7NM
         kj/Go4TyIKTUjd2ngB4Ie9G9aO0/OyymTsGE+E/vxE7DP+SeqvxI8U6su2j91NEGew3z
         IRGQ==
X-Gm-Message-State: AOAM532bGxwkiolQsMZNXJ/SmcDXkA8m7fLi3CtcxRtJLjmGAHsx+3Xv
        gioeq/oDchP6cP7U1SmSe3tzDaxO5NZfpaWFsqA=
X-Google-Smtp-Source: ABdhPJyr9EGsmqu/vnC4YaftU9+8nvRly99CFxz6Zr5MCbrnurI1NHcUFzVCVgPgt6PintDFMpZMqfKaMuK51aqCeLI=
X-Received: by 2002:a19:5052:: with SMTP id z18mr32723214lfj.23.1638756457131;
 Sun, 05 Dec 2021 18:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20211122033220.32883-1-chiyutianyi@gmail.com> <20211203093530.93589-2-chiyutianyi@gmail.com>
 <211203.86r1atst50.gmgdl@evledraar.gmail.com>
In-Reply-To: <211203.86r1atst50.gmgdl@evledraar.gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Mon, 6 Dec 2021 10:07:25 +0800
Message-ID: <CAO0brD2s9ZiVc+1BvE8r_86YvywJOrdyth1R+O1r5KwRtnuCrQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] object-file: refactor write_loose_object() to read
 buffer from stream
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 9:41 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Fri, Dec 03 2021, Han Xin wrote:
>
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > We used to call "get_data()" in "unpack_non_delta_entry()" to read the
> > entire contents of a blob object, no matter how big it is. This
> > implementation may consume all the memory and cause OOM.
> >
> > This can be improved by feeding data to "write_loose_object()" in a
> > stream. The input stream is implemented as an interface. In the first
> > step, we make a simple implementation, feeding the entire buffer in the
> > "stream" to "write_loose_object()" as a refactor.
> >
> > Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> > ---
> >  object-file.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++----
> >  object-store.h |  6 ++++++
> >  2 files changed, 55 insertions(+), 4 deletions(-)
> >
> > diff --git a/object-file.c b/object-file.c
> > index eb972cdccd..82656f7428 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1860,8 +1860,26 @@ static int create_tmpfile(struct strbuf *tmp, co=
nst char *filename)
> >       return fd;
> >  }
> >
> > +struct simple_input_stream_data {
> > +     const void *buf;
> > +     unsigned long len;
> > +};
>
> I see why you picked "const void *buf" here, over say const char *, it's
> what "struct input_stream" uses.
>
> But why not use size_t for the length, as input_stream does?
>

Yes, "size_t" will be better here.

> > +static const void *feed_simple_input_stream(struct input_stream *in_st=
ream, unsigned long *len)
> > +{
> > +     struct simple_input_stream_data *data =3D in_stream->data;
> > +
> > +     if (data->len =3D=3D 0) {
>
> nit: if (!data->len)...
>

Will apply.

> > +             *len =3D 0;
> > +             return NULL;
> > +     }
> > +     *len =3D data->len;
> > +     data->len =3D 0;
> > +     return data->buf;
>
> But isn't the body of this functin the same as:
>
>         *len =3D data->len;
>         if (!len)
>                 return NULL;
>         data->len =3D 0;
>         return data->buf;
>
> I.e. you don't need the condition for setting "*len" if it's 0, then
> data->len is also 0. You just want to return NULL afterwards, and not
> set (harmless, but no need) data->len to 0)< or return data->buf.

Will apply.

> > +     struct input_stream in_stream =3D {
> > +             .read =3D feed_simple_input_stream,
> > +             .data =3D (void *)&(struct simple_input_stream_data) {
> > +                     .buf =3D buf,
> > +                     .len =3D len,
> > +             },
> > +             .size =3D len,
> > +     };
>
> Maybe it's that I'm unused to it, but I find this a bit more readable:
>
>         @@ -2013,12 +2011,13 @@ int write_object_file_flags(const void *b=
uf, unsigned long len,
>          {
>                 char hdr[MAX_HEADER_LEN];
>                 int hdrlen =3D sizeof(hdr);
>         +       struct simple_input_stream_data tmp =3D {
>         +               .buf =3D buf,
>         +               .len =3D len,
>         +       };
>                 struct input_stream in_stream =3D {
>                         .read =3D feed_simple_input_stream,
>         -               .data =3D (void *)&(struct simple_input_stream_da=
ta) {
>         -                       .buf =3D buf,
>         -                       .len =3D len,
>         -               },
>         +               .data =3D (void *)&tmp,
>                         .size =3D len,
>                 };
>
> Yes there's a temporary variable, but no denser inline casting. Also
> easier to strep through in a debugger (which will have the type
> information on "tmp".
>

Will apply.

> >  int hash_object_file_literally(const void *buf, unsigned long len,
> > @@ -1977,6 +2006,14 @@ int hash_object_file_literally(const void *buf, =
unsigned long len,
> >  {
> >       char *header;
> >       int hdrlen, status =3D 0;
> > +     struct input_stream in_stream =3D {
> > +             .read =3D feed_simple_input_stream,
> > +             .data =3D (void *)&(struct simple_input_stream_data) {
> > +                     .buf =3D buf,
> > +                     .len =3D len,
> > +             },
> > +             .size =3D len,
> > +     };
>
> ditto..
>
> >       /* type string, SP, %lu of the length plus NUL must fit this */
> >       hdrlen =3D strlen(type) + MAX_HEADER_LEN;
> > @@ -1988,7 +2025,7 @@ int hash_object_file_literally(const void *buf, u=
nsigned long len,
> >               goto cleanup;
> >       if (freshen_packed_object(oid) || freshen_loose_object(oid))
> >               goto cleanup;
> > -     status =3D write_loose_object(oid, header, hdrlen, buf, len, 0, 0=
);
> > +     status =3D write_loose_object(oid, header, hdrlen, &in_stream, 0,=
 0);
> >
> >  cleanup:
> >       free(header);
> > @@ -2003,14 +2040,22 @@ int force_object_loose(const struct object_id *=
oid, time_t mtime)
> >       char hdr[MAX_HEADER_LEN];
> >       int hdrlen;
> >       int ret;
> > +     struct simple_input_stream_data data;
> > +     struct input_stream in_stream =3D {
> > +             .read =3D feed_simple_input_stream,
> > +             .data =3D &data,
> > +     };
> >
> >       if (has_loose_object(oid))
> >               return 0;
> >       buf =3D read_object(the_repository, oid, &type, &len);
> > +     in_stream.size =3D len;
>
> Why are we setting this here?...
>

Yes, putting "in_stream.size=3Dlen;" here was a stupid decision.

> >       if (!buf)
> >               return error(_("cannot read object for %s"), oid_to_hex(o=
id));
>
> ...Insted of after this point, as we may error and never use it?
>
> > +     data.buf =3D buf;
> > +     data.len =3D len;
>
> Probably won't matter,  just a nit...
>
> > +struct input_stream {
> > +     const void *(*read)(struct input_stream *, unsigned long *len);
> > +     void *data;
> > +     size_t size;
> > +};
> > +
>
> Ah, and here's the size_t... :)
