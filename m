Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41996C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 05:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15DBB61B29
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 05:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243129AbhKRFps (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 00:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243124AbhKRFps (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 00:45:48 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6393AC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 21:42:48 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id o63so5185360qkb.4
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 21:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ethNN4qeQBw9/2qfl5yZZCqDYON1GqCNINRRVwvsWsk=;
        b=CtagMcY4spn9RnlPFkoeG+qx4dhLkKtGQaNkwa8gKBGlPJDCGv2tvoDVIgv5ZRThmr
         CuviDvEOeBoBLNP6gVO5yUv1TPmyfCJWZKICkVCpbPOR8Klu6s39X4XgDdh5fA22PSTa
         kNd7nlcooLksTna5BXZ7lme9U1TP4B1EGXQg/6w5DYZkaeL8TwaUguJxZFV9No5fRawQ
         sf2vBjT66FgLfMoD/W8kqLx5SWTjW9WY5Gvkci0qhyfD5uwAXPiQKe/CYznerMZvAMq7
         rlEV974Xb7/f+QICw3qByfH2uW0+TSKt1wJv3Rh2ml2aVoiOtpLSc7mXutyLgtmNYyNj
         gMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ethNN4qeQBw9/2qfl5yZZCqDYON1GqCNINRRVwvsWsk=;
        b=FzviP3ZaISnswkshpdcN81GK14gSq6y6sMxY1G3RiwCMA7jRwS6RqwqW4UmdUPT0SD
         d4mkaX17fyhFwuZPyA8ukuoA11ufRA5QeDWvM1qlzJV9nT7yf4r9+SH2D8k7v3+X2Jcj
         Ean6iEAuv5BN4Sh5NA4MQb1SifyJuV0hEQh/N9Zsye28DkXYBy3M7E0rqchpPFK8M5d4
         RzPdD7i5YK+WafYZO+CZ3e9nsWItBGGvLwfx+4IyH+qKg0MzKNhvJ4TVXKdyv2k/ED4w
         lbO2yBor08C7jud3w1un8Q2qZsH2F6rzVNeZeQgS8XAghMFR1hQE/Vnn42XjOfyNrSKu
         U0Cg==
X-Gm-Message-State: AOAM531WiuJJdYgZpCyWInCHPnVesRV/9m0inBtjR19N9fBcUKGi/om0
        9fay8P0KWhjEnoHuZDLZeQ4GSpKPhLAAZIOo7Z6fO+UOAJYnYQ==
X-Google-Smtp-Source: ABdhPJx+fuTDuD5mcf2MnhevAIT/i/0pY8CHu3sC01d/30VPgycj8I7fRVQj7jrKjtdPx1NhxlCDKFxSg7I2DRPupJ4=
X-Received: by 2002:a05:620a:710:: with SMTP id 16mr18111521qkc.379.1637214167430;
 Wed, 17 Nov 2021 21:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com> <20211112094010.73468-2-chiyutianyi@gmail.com>
In-Reply-To: <20211112094010.73468-2-chiyutianyi@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 18 Nov 2021 13:42:36 +0800
Message-ID: <CANYiYbHvpVH7CvhGOUZojVkXd7eztC+wQ_R8=Ta9hPwjjAvWoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] object-file.c: add dry_run mode for write_loose_object()
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 12, 2021 at 5:42 PM Han Xin <chiyutianyi@gmail.com> wrote:
>
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> We will use "write_loose_object()" later to handle large blob object,
> which needs to work in dry_run mode.

The dry_run mode comes from "builtin/unpack-object.c", throw the
buffer read from "get_data()".
So why not add "dry_run" to "get_data()" instead?

If we have a dry_run version of get_data, such as "get_data(size,
dry_run)", we do not have to add dry_run mode for =E2=80=9D
write_loose_object()".

See: git grep -A5 get_data builtin/unpack-objects.c
builtin/unpack-objects.c:       void *buf =3D get_data(size);
builtin/unpack-objects.c-
builtin/unpack-objects.c-       if (!dry_run && buf)
builtin/unpack-objects.c-               write_object(nr, type, buf, size);
builtin/unpack-objects.c-       else
builtin/unpack-objects.c-               free(buf);
--
builtin/unpack-objects.c:               delta_data =3D get_data(delta_size)=
;
builtin/unpack-objects.c-               if (dry_run || !delta_data) {
builtin/unpack-objects.c-                       free(delta_data);
builtin/unpack-objects.c-                       return;
builtin/unpack-objects.c-               }
--
builtin/unpack-objects.c:               delta_data =3D get_data(delta_size)=
;
builtin/unpack-objects.c-               if (dry_run || !delta_data) {
builtin/unpack-objects.c-                       free(delta_data);
builtin/unpack-objects.c-                       return;
builtin/unpack-objects.c-               }


> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  object-file.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 1ad2cb579c..b0838c847e 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1880,9 +1880,10 @@ static const char *read_input_stream_from_buffer(v=
oid *data, unsigned long *len)
>
>  static int write_loose_object(const struct object_id *oid, char *hdr,
>                               int hdrlen, struct input_stream *in_stream,
> +                             int dry_run,
>                               time_t mtime, unsigned flags)
>  {
> -       int fd, ret;
> +       int fd, ret =3D 0;
>         unsigned char compressed[4096];
>         git_zstream stream;
>         git_hash_ctx c;
> @@ -1894,14 +1895,16 @@ static int write_loose_object(const struct object=
_id *oid, char *hdr,
>
>         loose_object_path(the_repository, &filename, oid);
>
> -       fd =3D create_tmpfile(&tmp_file, filename.buf);
> -       if (fd < 0) {
> -               if (flags & HASH_SILENT)
> -                       return -1;
> -               else if (errno =3D=3D EACCES)
> -                       return error(_("insufficient permission for addin=
g an object to repository database %s"), get_object_directory());
> -               else
> -                       return error_errno(_("unable to create temporary =
file"));
> +       if (!dry_run) {
> +               fd =3D create_tmpfile(&tmp_file, filename.buf);
> +               if (fd < 0) {
> +                       if (flags & HASH_SILENT)
> +                               return -1;
> +                       else if (errno =3D=3D EACCES)
> +                               return error(_("insufficient permission f=
or adding an object to repository database %s"), get_object_directory());
> +                       else
> +                               return error_errno(_("unable to create te=
mporary file"));
> +               }
>         }
>
>         /* Set it up */
> @@ -1925,7 +1928,7 @@ static int write_loose_object(const struct object_i=
d *oid, char *hdr,
>                 unsigned char *in0 =3D stream.next_in;
>                 ret =3D git_deflate(&stream, Z_FINISH);
>                 the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
> -               if (write_buffer(fd, compressed, stream.next_out - compre=
ssed) < 0)
> +               if (!dry_run && write_buffer(fd, compressed, stream.next_=
out - compressed) < 0)
>                         die(_("unable to write loose object file"));
>                 stream.next_out =3D compressed;
>                 stream.avail_out =3D sizeof(compressed);
> @@ -1943,6 +1946,9 @@ static int write_loose_object(const struct object_i=
d *oid, char *hdr,
>                 die(_("confused by unstable object source data for %s"),
>                     oid_to_hex(oid));
>
> +       if (dry_run)
> +               return 0;
> +
>         close_loose_object(fd);
>
>         if (mtime) {
> @@ -1996,7 +2002,7 @@ int write_object_file_flags(const void *buf, unsign=
ed long len,
>                                   &hdrlen);
>         if (freshen_packed_object(oid) || freshen_loose_object(oid))
>                 return 0;
> -       return write_loose_object(oid, hdr, hdrlen, &in_stream, 0, flags)=
;
> +       return write_loose_object(oid, hdr, hdrlen, &in_stream, 0, 0, fla=
gs);
>  }
>
>  int hash_object_file_literally(const void *buf, unsigned long len,
> @@ -2023,7 +2029,7 @@ int hash_object_file_literally(const void *buf, uns=
igned long len,
>                 goto cleanup;
>         if (freshen_packed_object(oid) || freshen_loose_object(oid))
>                 goto cleanup;
> -       status =3D write_loose_object(oid, header, hdrlen, &in_stream, 0,=
 0);
> +       status =3D write_loose_object(oid, header, hdrlen, &in_stream, 0,=
 0, 0);
>
>  cleanup:
>         free(header);
> @@ -2052,7 +2058,7 @@ int force_object_loose(const struct object_id *oid,=
 time_t mtime)
>         data.buf =3D buf;
>         data.len =3D len;
>         hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(=
type), (uintmax_t)len) + 1;
> -       ret =3D write_loose_object(oid, hdr, hdrlen, &in_stream, mtime, 0=
);
> +       ret =3D write_loose_object(oid, hdr, hdrlen, &in_stream, 0, mtime=
, 0);
>         free(buf);
>
>         return ret;
> --
> 2.33.1.44.g9344627884.agit.6.5.4
>
