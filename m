Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1411AC433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 09:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhKXJDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 04:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhKXJDX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 04:03:23 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF77EC061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 01:00:13 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y26so5278273lfa.11
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 01:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aUDGJDOmYIhDhCdm5fFU76NMQX4oReifubaBKyS9KMo=;
        b=mUuXoY7lDCE7MOAlIQZdmTCueQRBBm/Zar7WPRAl24c14Iovax8YgJwtxEnxasaFjM
         npyDbbmUOdypfW52n28Ls+BOvxvXdiPfJF7HYEFcViUaJESAqOy6sHHp3LRntg5BESbT
         wHST7e9wYI7ZfPaCv00JO3IFomOQ+7KLb4iHzKE65hRbnR7UVQWrkOW/CTLNGCv4/SWl
         5KZlvzCqy11ZKm0IaypIiTluzdwgBap7STagLezlGCmeDwRtmfIEMXnIVYLWdTih0ols
         fp6OBvzbKPdNSOtR+Kz2qj/OIqIXOD2vqFWn3O8ozDKKKwAo7G3iemGlsmH3imVDwiZ0
         Jc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aUDGJDOmYIhDhCdm5fFU76NMQX4oReifubaBKyS9KMo=;
        b=XICKg5YPqFAZbE+Lkke5cfGoYpM7GuD+GN2nOUobFX5Wfy0ZU3PIYSTBEQAYh4hQyn
         PjSpAUPoXU1eeEX4rxisjm5M/dt5AOSuQqjZ6VK7bFjLcVDQ70pAs/u2uMKt3Af42e21
         aoOB1iVFo4LduuD0iBBpqpaKgMQFlDi9fPhZ79I7BJ/rk/CzXi9uM+4MtXzCY9ZgVZkz
         khhJxgz601e+Q7o0fWNTF1y8t15rzBNfRrVH2Z10GZ9gkhP/5a97h8cmPDgoabuZWMLj
         L2jkzr+vNiXKjPTg/HRlEk2xkJSBaAu2Gaszz0obaDHcXr+MAjQEguKR44gf468WQW4g
         0Wuw==
X-Gm-Message-State: AOAM531WvP/j3n62Dk/qGG/nfvAxP0WLMCI9gR1vh4gqElASZcgwoe+6
        F0WVyfTNwzOqjQ03bWy5e44C3qpr/N/tof1nxYkudCGHfMuZcvL/
X-Google-Smtp-Source: ABdhPJyV4HUUJ8umIgvsrwe0GgGzVDCzovKFj2MbFc4R4u19bPUqCD+WZaBPh+l8Bpml5UtR9olDExgs6WZ1KJQpmaw=
X-Received: by 2002:a05:6512:2314:: with SMTP id o20mr12263696lfu.51.1637744411873;
 Wed, 24 Nov 2021 01:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com> <20211122033220.32883-2-chiyutianyi@gmail.com>
 <xmqqczmq78x7.fsf@gitster.g>
In-Reply-To: <xmqqczmq78x7.fsf@gitster.g>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Wed, 24 Nov 2021 17:00:00 +0800
Message-ID: <CAO0brD3tQuzyHXbdndJrgqYd21pANYntmg5h7YKasne7QQ6Now@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] object-file: refactor write_loose_object() to read
 buffer from stream
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>
> Han Xin <chiyutianyi@gmail.com> writes:
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
>
> Possibly a stupid question (not a review).
>
> How does this compare with "struct git_istream" implemented for a
> few existing codepaths?  It seems that the existing users are
> pack-objects, index-pack and archive and all of them use the
> interface to obtain data given an object name without having to grab
> everything in core at once.
>
> If we are adding a new streaming interface to go in the opposite
> direction, i.e. from the working tree data to object store, I would
> understand it as a complementary interface (but then I suspect there
> is a half of it already in bulk-checkin API), but I am not sure how
> this new thing fits in the larger picture.
>

Thank you for your reply.

Before starting to make this patch, I did consider whether I should
reuse "struct  git_istream" to solve the problem, but I found that in the
process of git unpack-objects, the data comes from stdin, and we
cannot get an oid in advance until the whole object data is read.
Also, we can't do "lseek()=E2=80=9C on stdin to change the data reading pos=
ition.

I compared the implementation of "bulk-checkin", and they do have
some similarities.
I think the difference in the reverse implementation is that we do not
always clearly know where the boundary of the target data is. For
example, in the process of "unpack-objects", the "buffer" has been
partially read after calling "fill()". And the "buffer" remaining after
reading cannot be discarded because it is the beginning of the next
object.
Perhaps "struct input_stream" can make some improvements to
"index_bulk_checkin()", so that it can read from an inner buffer in
addition to reading from "fd" if necessary.

>
>
> > Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> > ---
> >  object-file.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
> >  object-store.h |  5 +++++
> >  2 files changed, 51 insertions(+), 4 deletions(-)
> >
> > diff --git a/object-file.c b/object-file.c
> > index c3d866a287..227f53a0de 100644
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
> > +
> > +static const void *feed_simple_input_stream(struct input_stream *in_st=
ream, unsigned long *len)
> > +{
> > +     struct simple_input_stream_data *data =3D in_stream->data;
> > +
> > +     if (data->len =3D=3D 0) {
> > +             *len =3D 0;
> > +             return NULL;
> > +     }
> > +     *len =3D data->len;
> > +     data->len =3D 0;
> > +     return data->buf;
> > +}
> > +
> >  static int write_loose_object(const struct object_id *oid, char *hdr,
> > -                           int hdrlen, const void *buf, unsigned long =
len,
> > +                           int hdrlen, struct input_stream *in_stream,
> >                             time_t mtime, unsigned flags)
> >  {
> >       int fd, ret;
> > @@ -1871,6 +1889,8 @@ static int write_loose_object(const struct object=
_id *oid, char *hdr,
> >       struct object_id parano_oid;
> >       static struct strbuf tmp_file =3D STRBUF_INIT;
> >       static struct strbuf filename =3D STRBUF_INIT;
> > +     const void *buf;
> > +     unsigned long len;
> >
> >       loose_object_path(the_repository, &filename, oid);
> >
> > @@ -1898,6 +1918,7 @@ static int write_loose_object(const struct object=
_id *oid, char *hdr,
> >       the_hash_algo->update_fn(&c, hdr, hdrlen);
> >
> >       /* Then the data itself.. */
> > +     buf =3D in_stream->read(in_stream, &len);
> >       stream.next_in =3D (void *)buf;
> >       stream.avail_in =3D len;
> >       do {
> > @@ -1960,6 +1981,13 @@ int write_object_file_flags(const void *buf, uns=
igned long len,
> >  {
> >       char hdr[MAX_HEADER_LEN];
> >       int hdrlen =3D sizeof(hdr);
> > +     struct input_stream in_stream =3D {
> > +             .read =3D feed_simple_input_stream,
> > +             .data =3D (void *)&(struct simple_input_stream_data) {
> > +                     .buf =3D buf,
> > +                     .len =3D len,
> > +             },
> > +     };
> >
> >       /* Normally if we have it in the pack then we do not bother writi=
ng
> >        * it out into .git/objects/??/?{38} file.
> > @@ -1968,7 +1996,7 @@ int write_object_file_flags(const void *buf, unsi=
gned long len,
> >                                 &hdrlen);
> >       if (freshen_packed_object(oid) || freshen_loose_object(oid))
> >               return 0;
> > -     return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
> > +     return write_loose_object(oid, hdr, hdrlen, &in_stream, 0, flags)=
;
> >  }
> >
> >  int hash_object_file_literally(const void *buf, unsigned long len,
> > @@ -1977,6 +2005,13 @@ int hash_object_file_literally(const void *buf, =
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
> > +     };
> >
> >       /* type string, SP, %lu of the length plus NUL must fit this */
> >       hdrlen =3D strlen(type) + MAX_HEADER_LEN;
> > @@ -1988,7 +2023,7 @@ int hash_object_file_literally(const void *buf, u=
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
> > @@ -2003,14 +2038,21 @@ int force_object_loose(const struct object_id *=
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
> >       if (!buf)
> >               return error(_("cannot read object for %s"), oid_to_hex(o=
id));
> > +     data.buf =3D buf;
> > +     data.len =3D len;
> >       hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(=
type), (uintmax_t)len) + 1;
> > -     ret =3D write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
> > +     ret =3D write_loose_object(oid, hdr, hdrlen, &in_stream, mtime, 0=
);
> >       free(buf);
> >
> >       return ret;
> > diff --git a/object-store.h b/object-store.h
> > index 952efb6a4b..ccc1fc9c1a 100644
> > --- a/object-store.h
> > +++ b/object-store.h
> > @@ -34,6 +34,11 @@ struct object_directory {
> >       char *path;
> >  };
> >
> > +struct input_stream {
> > +     const void *(*read)(struct input_stream *, unsigned long *len);
> > +     void *data;
> > +};
> > +
> >  KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
> >       struct object_directory *, 1, fspathhash, fspatheq)
