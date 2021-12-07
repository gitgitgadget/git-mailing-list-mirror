Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFC2C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 06:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhLGGwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 01:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhLGGwe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 01:52:34 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D324C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 22:49:04 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m27so31098565lfj.12
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 22:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Ev0BrftOtGzijlRClg+V7116fyIi3TzRjj+ikc+xp4=;
        b=ILxlqzQN2AvOrgfVjqrZDbw8fB2xFk/l6TyG9nv9GRSfHNuq57RfM/WefelK/tabC1
         QVjhEL4t9HSyPgFfC9apTZ2m/o8HsH6E2oPB+7MFfaT7nuL+7eJy+tI8FG27oybF1naT
         Ve3roE1hAUNWx7YAK3cFTIgtNdryVY/+f0pnnY6HOUC12kMTB8Di6Xa+bXO9T8N3isPG
         eUSydXNX/9F5dmVe1uI0VwoQ+qmPRFgCR2XBVISTyVbmkUZ4Xt8BlKtnRd/csyBcof12
         t9Dlp7eMsErZx4HwUkOM2/QeFlifkN5JyELTL/Ixwu90T3CAzd1MR26hOAtL9RNL1qFh
         TdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Ev0BrftOtGzijlRClg+V7116fyIi3TzRjj+ikc+xp4=;
        b=U1u66RGSZkHm4912BAmD4QuYxw7bl11YdMi6hfVbU+UEUb4Mo47RP7UjlMdZqJoHSq
         rMAlHkSJncpnOy5PyR3k6di/4gl2LDpqqCkkuGIvI7yuRqNxg+bXgL3PYyZr9xxapk03
         Chh5gW46WuGZ0ADCgPcjDFwMpdMQTrQI80LkKjnxoAPSZ5iazj1Wkc8jEBqjdtB4DB0b
         6roZkFwRJ1OCQHuBVmoqNWT7qibfrIWjBL3uncJF64w1JXhp2928Bte6qDkpz0QkKU0w
         +uRsfao8W+wWNiroNJRsQ20+r5n/364Gn5axMx/4BF51SoE6zlP3jcMEp4x/PUq8cJRu
         U6NQ==
X-Gm-Message-State: AOAM531wLzzfWTgNbZbTMZwfhoCfUc3Fbvh+CJ2Bc2XAsKDtZ38eOnZX
        yPMJs7fvwNgdLt8RwEBrLy+TNyBOw2wSeiK0m4o=
X-Google-Smtp-Source: ABdhPJwJsvqzl7/zgK+NyxiSbGvEpvSFZUiYAC0nMH1TdbuzzfxU4kPG3c092mJiHqe0PoJWIsp+qHl0GHhpJCRNJr4=
X-Received: by 2002:a05:6512:130e:: with SMTP id x14mr40169280lfu.366.1638859742396;
 Mon, 06 Dec 2021 22:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20211122033220.32883-1-chiyutianyi@gmail.com> <20211203093530.93589-6-chiyutianyi@gmail.com>
 <211203.86a6hhsqwf.gmgdl@evledraar.gmail.com>
In-Reply-To: <211203.86a6hhsqwf.gmgdl@evledraar.gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Tue, 7 Dec 2021 14:48:51 +0800
Message-ID: <CAO0brD1_h0qC=Qk2K1c1aZ=0u73BQnE50xZ0W6py0=m4TgB3XA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] unpack-objects: unpack_non_delta_entry() read data
 in a stream
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

On Fri, Dec 3, 2021 at 10:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Dec 03 2021, Han Xin wrote:
>
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> > [..]
> > +static void write_stream_blob(unsigned nr, unsigned long size)
> > +{
> > +     char hdr[32];
> > +     int hdrlen;
> > +     git_zstream zstream;
> > +     struct input_zstream_data data;
> > +     struct input_stream in_stream =3D {
> > +             .read =3D feed_input_zstream,
> > +             .data =3D &data,
> > +             .size =3D size,
> > +     };
> > +     struct object_id *oid =3D &obj_list[nr].oid;
> > +     int ret;
> > +
> > +     memset(&zstream, 0, sizeof(zstream));
> > +     memset(&data, 0, sizeof(data));
> > +     data.zstream =3D &zstream;
> > +     git_inflate_init(&zstream);
> > +
> > +     /* Generate the header */
> > +     hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(O=
BJ_BLOB), (uintmax_t)size) + 1;
> > +
> > +     if ((ret =3D write_loose_object(oid, hdr, hdrlen, &in_stream, 0, =
0)))
> > +             die(_("failed to write object in stream %d"), ret);
> > +
> > +     if (zstream.total_out !=3D size || data.status !=3D Z_STREAM_END)
> > +             die(_("inflate returned %d"), data.status);
> > +     git_inflate_end(&zstream);
> > +
> > +     if (strict && !dry_run) {
> > +             struct blob *blob =3D lookup_blob(the_repository, oid);
> > +             if (blob)
> > +                     blob->object.flags |=3D FLAG_WRITTEN;
> > +             else
> > +                     die("invalid blob object from stream");
> > +     }
> > +     obj_list[nr].obj =3D NULL;
> > +}
>
> Just a side-note, I think (but am not 100% sure) that these existing
> occurances aren't needed due to our use of CALLOC_ARRAY():
>
>     diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
>     index 4a9466295ba..00b349412c5 100644
>     --- a/builtin/unpack-objects.c
>     +++ b/builtin/unpack-objects.c
>     @@ -248,7 +248,6 @@ static void write_object(unsigned nr, enum object=
_type type,
>                             die("failed to write object");
>                     added_object(nr, type, buf, size);
>                     free(buf);
>     -               obj_list[nr].obj =3D NULL;
>             } else if (type =3D=3D OBJ_BLOB) {
>                     struct blob *blob;
>                     if (write_object_file(buf, size, type_name(type),
>     @@ -262,7 +261,6 @@ static void write_object(unsigned nr, enum object=
_type type,
>                             blob->object.flags |=3D FLAG_WRITTEN;
>                     else
>                             die("invalid blob object");
>     -               obj_list[nr].obj =3D NULL;
>             } else {
>                     struct object *obj;
>                     int eaten;
>
> The reason I'm noting it is that the same seems to be true of your new
> addition here. I.e. are these assignments to NULL needed?
>
> Anyway, the reason I started poking at this it tha this
> write_stream_blob() seems to duplicate much of write_object(). AFAICT
> only the writing part is really different, the part where we
> lookup_blob() after, set FLAG_WRITTEN etc. is all the same.
>
> Why can't we call write_object() here?
>
> The obvious answer seems to be that the call to write_object_file()
> isn't prepared to do the sort of streaming that you want, so instead
> you're bypassing it and calling write_loose_object() directly.
>
> I haven't tried this myself, but isn't a better and cleaner approach
> here to not add another meaning to what is_null_oid() means, but to just
> add a HASH_STREAM flag that'll get passed down as "unsigned flags" to
> write_loose_object()? See FLAG_BITS in object.h.
>
> Then the "obj_list[nr].obj" here could also become
> "obj_list[nr].obj.flags |=3D (1u<<12)" or whatever (but that wouldn't
> strictly be needed I think.
>
> But by adding the "HASH_STREAM" flag you could I think stop duplicating
> the "Generate the header" etc. here and call write_object_file_flags().
>
> I don't so much care about how it's done within unpack-objects.c, but
> not having another meaning to is_null_oid() in play would be really
> nice, and it this case it seems entirely avoidable.

I did refactor it according to your suggestions in my next patch version.
Using a HASH_STREAM tag is indeed a better way to deal with it, and it
can also reduce my refactor to the original contents.

Thanks.
-Han Xin
