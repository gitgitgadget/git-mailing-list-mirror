Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8861C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 02:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhLFCz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 21:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhLFCzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 21:55:25 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D3DC0613F8
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 18:51:57 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b40so21727301lfv.10
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 18:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lk3bpRb3WFVx+G9z9B6KWXtTAF3SRkspIth8ALyNJgI=;
        b=joh/G8sKksAIGaUZrxR2X9+B9EypLOxM2OWPevaJX2picHw91xTwCsI96er8zu16qr
         hXUpAwCJhaC1JWM9AfXjQmoS6OdTsg8WQTqb6YFxNQiVW6W1z1Iqrsp23+y8d42WjfiX
         xO5CW7AJMVPgvTV0QP5vbcDExKSDYOs1Hd31uCtfNArWHzSuoJQSDPVe5gSWMQHSjBBR
         ZnaBj6eqWPXfL8Ah/b6ZXz573NrvgBkDIjArNjJITA965B/3zUqWXWNA9iIBUdF50ESJ
         JrStEjkUqQVky07fZlW3+laqDdSAm5+l/L4hOzQ1R/j8rgc4bjrK3T6rbSGfAIBjrvgA
         VK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lk3bpRb3WFVx+G9z9B6KWXtTAF3SRkspIth8ALyNJgI=;
        b=3EDHrjh6AnMAaiM/F7S1M2Y7N2rWY6y8y+rIGL+/Zj3R5f7RVwwbteVaSAl82eGlm5
         D095F2Oy8A7yhJS41nINACoXuHbB1pwTVm1Hd2siiyTN6aT3RzYbQjB3JyCmckU3N35G
         xQPeiUtN58tIFqIEYUxBmX2sBrihrqi0Mrg8d8Zt8vwefqkKuxlUofmHGWpVlkdDs5QY
         tCMP8RsAi+OjRpc5Jxe7lzfuoVvgFHIS1pDl+18TVUiV8ce5ULeQTKuWuIbPujnMmecR
         4aEe0evzg/8w/uIo9XG09KY7nP/MwlUwkfRtGuJEVrnFtOZvreFeaOVi/PslRLjubdRw
         IAIw==
X-Gm-Message-State: AOAM533kARFyqrBEPuMR/IYZyZDUto86E23p0tK5ruPsK47c81nUPtK2
        K0s6+pJx9ihAKzDS1E5Xv80hCP1NigBOglGuBwI=
X-Google-Smtp-Source: ABdhPJxs7fLTo7eH+q0MVknK9+Vn7Yaz4ed9GWn3YXx371Z0r7P3kooftBch01UiTfNDcRZVUQLRvH7Y/M8cjgfTkVk=
X-Received: by 2002:a05:6512:ace:: with SMTP id n14mr32314853lfu.53.1638759115651;
 Sun, 05 Dec 2021 18:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20211122033220.32883-1-chiyutianyi@gmail.com> <20211203093530.93589-3-chiyutianyi@gmail.com>
 <211203.86v905stru.gmgdl@evledraar.gmail.com>
In-Reply-To: <211203.86v905stru.gmgdl@evledraar.gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Mon, 6 Dec 2021 10:51:44 +0800
Message-ID: <CAO0brD2_TvxCMhGiyZC5ex-73dk+3CafWFT43K9CPfE8WAXKXQ@mail.gmail.com>
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

On Fri, Dec 3, 2021 at 9:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
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
> > +             strbuf_addstr(&filename, the_repository->objects->odb->pa=
th);
> > +             strbuf_addch(&filename, '/');
> > +     } else {
> > +             loose_object_path(the_repository, &filename, oid);
> > +     }
> >
> >       fd =3D create_tmpfile(&tmp_file, filename.buf);
> >       if (fd < 0) {
> > @@ -1939,12 +1946,31 @@ static int write_loose_object(const struct obje=
ct_id *oid, char *hdr,
> >               die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(=
oid),
> >                   ret);
> >       the_hash_algo->final_oid_fn(&parano_oid, &c);
> > -     if (!oideq(oid, &parano_oid))
> > +     if (!is_null_oid(oid) && !oideq(oid, &parano_oid))
> >               die(_("confused by unstable object source data for %s"),
> >                   oid_to_hex(oid));
> >
> >       close_loose_object(fd);
> >
> > +     if (is_null_oid(oid)) {
> > +             int dirlen;
> > +
> > +             oidcpy((struct object_id *)oid, &parano_oid);
> > +             loose_object_path(the_repository, &filename, oid);
>
> Why are we breaking the promise that "oid" is constant here? I tested
> locally with the below on top, and it seems to work (at least no tests
> broke). Isn't it preferrable to the cast & the caller having its "oid"
> changed?
>
> diff --git a/object-file.c b/object-file.c
> index 71d510614b9..d014e6942ea 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1958,10 +1958,11 @@ int write_loose_object(const struct object_id *oi=
d, char *hdr,
>         close_loose_object(fd);
>
>         if (is_null_oid(oid)) {
> +               struct object_id oid2;
>                 int dirlen;
>
> -               oidcpy((struct object_id *)oid, &parano_oid);
> -               loose_object_path(the_repository, &filename, oid);
> +               oidcpy(&oid2, &parano_oid);
> +               loose_object_path(the_repository, &filename, &oid2);
>
>                 /* We finally know the object path, and create the missin=
g dir. */
>                 dirlen =3D directory_size(filename.buf);

Maybe I should change the promise that "oid" is constant in
"write_loose_object()".

The original write_object_file_flags() defines a variable "oid", and
completes the calculation of the "oid" in
"write_object_file_prepare()" which will be passed to
"write_loose_object()".

If a null oid is maintained after calling "write_loose_object()",
"--strict" will become meaningless, although it does not break existing
test cases.
