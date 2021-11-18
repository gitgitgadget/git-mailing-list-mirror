Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44695C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 05:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F0B61B39
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 05:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbhKRFxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 00:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbhKRFw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 00:52:56 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C846C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 21:49:57 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id d2so5157432qki.12
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 21:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=odLyJyR4eyv4es5aAopNoLh0EXWFvxWzikRaF8M6UAM=;
        b=OPu6et1BH0m+wU3gGFUAoM9FNW3dviJ9vGKItqFLLaIjGhIP9qHz/rJDXEJkYyoEpj
         vBdwk4YaR4nFTB+TZPbwSGxe1JiwT/QNg/duEoCcilG5/IqzHlHoiUBU6Ry7eZ/3nJ3g
         V2O61q3I72Kf095Ih1+zg/S+QpNKzZxgP+0dxgaDtWWDlG6IK/VXiQgY8OK/7t9ub1gO
         b+jMNo+Vdlp9HPjei/LEosw+VSpbJMrmsLeGbDUSWqZS603hbaJ9cbg9lAlDqMlfOrqU
         mkRCbzaoB7DKj8Tq1f1TlIzZFR5ko2RYOir6b4Dz4BOqTs5fUgT7HNdb2z+CwK6emAKW
         V8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=odLyJyR4eyv4es5aAopNoLh0EXWFvxWzikRaF8M6UAM=;
        b=kGoMnGeo2qn1l/YhVHJbL1vLzb5trZjfJDpHR0YiCcoAgLo+U1mtAwwZN/hsS2q26F
         7aPCrwonqOpvqgHuPaOA6NjACgoNo+3FcmuBJd7aWGiAKbqxh6/g+zH3xsZWigLkCmyt
         TEBsvd05jRpgV61UBfMmqaaVvSaalUEMWgScMqJQudEjfK2rRuT2gFyHv4kxgWLNqDI6
         uMmBfn7RICI0Rt1xxICRCn6dYiXnhVOo/oXq7/evlFXsu+4DHp89D2FRdSa4N1GzeeYm
         MGYK5de9FoyEVYpVfaPUimMTuJRcyAtLMBwx6RvCaDRySOXmsIrJ2sYaun5eO/KcrIYL
         +Uww==
X-Gm-Message-State: AOAM533aNcUcht5iX5Z3THoPwPsc1eduHjP5Qd2rbbFoA916U9xq9lev
        SV8zn6ZFX4zFFjWioAY8rY90YUUuBXd0L4geKEA=
X-Google-Smtp-Source: ABdhPJwk6RclOKBYvmDjHwi6EEjJXBXEbRLNaD0G/St+BrX5TgEdVdEQ3MlTFikppLD+n5oGumI08i3Mxid/TOtg8h4=
X-Received: by 2002:a05:620a:c4a:: with SMTP id u10mr18265929qki.69.1637214596546;
 Wed, 17 Nov 2021 21:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com> <20211112094010.73468-3-chiyutianyi@gmail.com>
In-Reply-To: <20211112094010.73468-3-chiyutianyi@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 18 Nov 2021 13:49:45 +0800
Message-ID: <CANYiYbESTJKOGQ0_70X6V6JuwaDZTL-a3fLqyH_SapOoQJw9BQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] object-file.c: handle nil oid in write_loose_object()
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
> When read input stream, oid can't get before reading all, and it will be
> filled after reading.

Under what circumstances is the oid a null oid?  Can we get the oid
from =E2=80=9Cobj_list[nr].oid=E2=80=9D ?
See unpack_non_delta_entry() of builtin/unpack-objects.c.

> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  object-file.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index b0838c847e..8393659f0d 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1893,7 +1893,13 @@ static int write_loose_object(const struct object_=
id *oid, char *hdr,
>         const char *buf;
>         unsigned long len;
>
> -       loose_object_path(the_repository, &filename, oid);
> +       if (is_null_oid(oid)) {
> +               /* When oid is not determined, save tmp file to odb path.=
 */
> +               strbuf_reset(&filename);
> +               strbuf_addstr(&filename, the_repository->objects->odb->pa=
th);
> +               strbuf_addch(&filename, '/');
> +       } else
> +               loose_object_path(the_repository, &filename, oid);
>
>         if (!dry_run) {
>                 fd =3D create_tmpfile(&tmp_file, filename.buf);
> @@ -1942,7 +1948,7 @@ static int write_loose_object(const struct object_i=
d *oid, char *hdr,
>                 die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(=
oid),
>                     ret);
>         the_hash_algo->final_oid_fn(&parano_oid, &c);
> -       if (!oideq(oid, &parano_oid))
> +       if (!is_null_oid(oid) && !oideq(oid, &parano_oid))
>                 die(_("confused by unstable object source data for %s"),
>                     oid_to_hex(oid));
>
> @@ -1951,6 +1957,30 @@ static int write_loose_object(const struct object_=
id *oid, char *hdr,
>
>         close_loose_object(fd);
>
> +       if (is_null_oid(oid)) {
> +               int dirlen;
> +
> +               /* copy oid */
> +               oidcpy((struct object_id *)oid, &parano_oid);
> +               /* We get the oid now */
> +               loose_object_path(the_repository, &filename, oid);
> +
> +               dirlen =3D directory_size(filename.buf);
> +               if (dirlen) {
> +                       struct strbuf dir =3D STRBUF_INIT;
> +                       /*
> +                        * Make sure the directory exists; note that the
> +                        * contents of the buffer are undefined after mks=
temp
> +                        * returns an error, so we have to rewrite the wh=
ole
> +                        * buffer from scratch.
> +                        */
> +                       strbuf_reset(&dir);
> +                       strbuf_add(&dir, filename.buf, dirlen - 1);
> +                       if (mkdir(dir.buf, 0777) && errno !=3D EEXIST)
> +                               return -1;
> +               }
> +       }
> +
>         if (mtime) {
>                 struct utimbuf utb;
>                 utb.actime =3D mtime;
> --
> 2.33.1.44.g9344627884.agit.6.5.4
>
