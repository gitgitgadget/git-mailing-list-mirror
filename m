Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE4C433FE
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 03:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhLFDPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 22:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbhLFDPw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 22:15:52 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7B3C0613F8
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 19:12:24 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id n12so21963604lfe.1
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 19:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Ps+CS8JuyQadFo+xKDlvztMkbDPfRP2SEBdRKNmA0U=;
        b=c6qDVhIA7aITZPCJ0FN0Jh/LxUFaIEwFWVU3eyupXWjVULsP/5jl/pwLexespX+Jgc
         imLO0FR7WOuu3FzHw0/KoMyerkuBWvk/4V6RIigq8WPdIwJ+R9h2H0CxisUioNw1vnT3
         BIFF/6+fQuS9PfaZTicWHyGbWzrpc8a4Mix6/2Yb4EnJCPz7V1NCWjIuw6QkdEtOmIh/
         w63c4PSqniB3lyqbt7QNecjzDVTdyotMS2qUdd7k2hkfKukyLfq41QgYbOmzekbmRhG6
         5Bhl23REcZxXI5Lln4GOHeOLHcgi+Ij8Bcd47s8FFngNY5Zsmv8O9Z2DD1TjBLug1eUS
         bYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Ps+CS8JuyQadFo+xKDlvztMkbDPfRP2SEBdRKNmA0U=;
        b=76mPcyrdOUtQugBLcPrUxHwWBON0M0hu63hmwwW8hMg8Jjrc8vxTs2FImayZ0Z2RT0
         MSsZyVgUEPpvTOe8UYx+7d0sudahQ95ZkSH4lt6ijZrq672sGlqrTUuj6TDdf3HavOkh
         4EdlIKcpfyUwkZ/YIfqXWGjRcZFjrlkeUdIVhnTMTkQJlB3f50LK2F41fd9eYL30krHa
         vdL1HGspz/kJmcAP17CKOGPzkEYLE5pjiZN4qGbsd8whc4N+gXKU3XQqu/w91VKzFSZ0
         +nfvO1MyLCMXZrLTvOjZNGNgfqBGdVuv4x8QyGXzB9tSqyY6tMrQgWJKPfqXuIQEBdD4
         nC4A==
X-Gm-Message-State: AOAM533bgrGP7m0HYYNX8AJ5Ffb6uzN9CciuWdAYaiWXQZNi3LiMlFiM
        agOR2MahoZp2FValtSBfrHLds72dWO5l1ymJUg7M5fkEovEs1Q==
X-Google-Smtp-Source: ABdhPJzYhhR0INTIcC9pxU+tAWFQA11auClm8kU0Nl2Odvi8lszGUB5rxabznYw+s3+jqjysPnZN1g04EIcAs33X/yU=
X-Received: by 2002:a19:6454:: with SMTP id b20mr32569891lfj.469.1638760342716;
 Sun, 05 Dec 2021 19:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20211122033220.32883-1-chiyutianyi@gmail.com> <20211203093530.93589-3-chiyutianyi@gmail.com>
 <211203.86mtlhssj4.gmgdl@evledraar.gmail.com>
In-Reply-To: <211203.86mtlhssj4.gmgdl@evledraar.gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Mon, 6 Dec 2021 11:12:11 +0800
Message-ID: <CAO0brD3=J1hQPypqqmyYqL9wP+xxThAO6womU_h_s0wDBqJWbg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] object-file.c: handle undetermined oid in write_loose_object()
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

On Fri, Dec 3, 2021 at 9:54 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Fri, Dec 03 2021, Han Xin wrote:
>
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > When streaming a large blob object to "write_loose_object()", we have n=
o
> > chance to run "write_object_file_prepare()" to calculate the oid in
> > advance. So we need to handle undetermined oid in function
> > "write_loose_object()".
> >
> > In the original implementation, we know the oid and we can write the
> > temporary file in the same directory as the final object, but for an
> > object with an undetermined oid, we don't know the exact directory for
> > the object, so we have to save the temporary file in ".git/objects/"
> > directory instead.
> >
> > Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> > ---
> >  object-file.c | 30 ++++++++++++++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
> >
> > diff --git a/object-file.c b/object-file.c
> > index 82656f7428..1c41587bfb 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1892,7 +1892,14 @@ static int write_loose_object(const struct objec=
t_id *oid, char *hdr,
> >       const void *buf;
> >       unsigned long len;
> >
> > -     loose_object_path(the_repository, &filename, oid);
> > +     if (is_null_oid(oid)) {
> > +             /* When oid is not determined, save tmp file to odb path.=
 */
> > +             strbuf_reset(&filename);
>
> Why re-use this & leak memory? An existing strbuf use in this function
> doesn't leak in the same way. Just release it as in the below patch on
> top (the ret v.s. err variable naming is a bit confused, maybe could do
> with a prep cleanup step.).
>
> > +             strbuf_addstr(&filename, the_repository->objects->odb->pa=
th);
> > +             strbuf_addch(&filename, '/');
>
> And once we do that this could just become:
>
>         strbuf_addf($filename, "%s/", ...)
>
> Is there's existing uses of this pattern, so mayb e not worth it, but it
> allows you to remove the braces on the if/else.
>
> diff --git a/object-file.c b/object-file.c
> index 8bd89e7b7ba..2b52f3fc1cc 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1880,7 +1880,7 @@ int write_loose_object(const struct object_id *oid,=
 char *hdr,
>                        int hdrlen, struct input_stream *in_stream,
>                        time_t mtime, unsigned flags)
>  {
> -       int fd, ret;
> +       int fd, ret, err =3D 0;
>         unsigned char compressed[4096];
>         git_zstream stream;
>         git_hash_ctx c;
> @@ -1892,7 +1892,6 @@ int write_loose_object(const struct object_id *oid,=
 char *hdr,
>
>         if (is_null_oid(oid)) {
>                 /* When oid is not determined, save tmp file to odb path.=
 */
> -               strbuf_reset(&filename);
>                 strbuf_addstr(&filename, the_repository->objects->odb->pa=
th);
>                 strbuf_addch(&filename, '/');
>         } else {
> @@ -1902,11 +1901,12 @@ int write_loose_object(const struct object_id *oi=
d, char *hdr,
>         fd =3D create_tmpfile(&tmp_file, filename.buf);
>         if (fd < 0) {
>                 if (flags & HASH_SILENT)
> -                       return -1;
> +                       err =3D -1;
>                 else if (errno =3D=3D EACCES)
> -                       return error(_("insufficient permission for addin=
g an object to repository database %s"), get_object_directory());
> +                       err =3D error(_("insufficient permission for addi=
ng an object to repository database %s"), get_object_directory());
>                 else
> -                       return error_errno(_("unable to create temporary =
file"));
> +                       err =3D error_errno(_("unable to create temporary=
 file"));
> +               goto cleanup;
>         }
>
>         /* Set it up */
> @@ -1968,10 +1968,13 @@ int write_loose_object(const struct object_id *oi=
d, char *hdr,
>                         struct strbuf dir =3D STRBUF_INIT;
>                         strbuf_add(&dir, filename.buf, dirlen - 1);
>                         if (mkdir(dir.buf, 0777) && errno !=3D EEXIST)
> -                               return -1;
> -                       if (adjust_shared_perm(dir.buf))
> -                               return -1;
> -                       strbuf_release(&dir);
> +                               err =3D -1;
> +                       else if (adjust_shared_perm(dir.buf))
> +                               err =3D -1;
> +                       else
> +                               strbuf_release(&dir);
> +                       if (err < 0)
> +                               goto cleanup;
>                 }
>         }
>
> @@ -1984,7 +1987,10 @@ int write_loose_object(const struct object_id *oid=
, char *hdr,
>                         warning_errno(_("failed utime() on %s"), tmp_file=
.buf);
>         }
>
> -       return finalize_object_file(tmp_file.buf, filename.buf);
> +       err =3D finalize_object_file(tmp_file.buf, filename.buf);
> +cleanup:
> +       strbuf_release(&filename);
> +       return err;
>  }
>
>  static int freshen_loose_object(const struct object_id *oid)

Yes, this will be much better. Will apply.
