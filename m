Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDC5C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 09:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiADJtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiADJtu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 04:49:50 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC1C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 01:49:50 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id i5so47161025uaq.10
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 01:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AUWAYrGIOKW7HVBmvM7CxDq6aDYJwnUza9E+yinLHsA=;
        b=dK+TdTZO3NKD/3EOtnIF71GWtpR8g95Y2/N0oqiRhalpbqRnfe2FlIU9S8VG/hiNFe
         0/PIAQ3t5OGuBRc0sIZ5SCdK4Hi60nOPH5IK+bJ8eJuNR7OrtWanSYPVLMd/XsM7CH31
         sPLqNwgq/F/WlPEoT5r7WNCFkHYV9O28TsR62j19Kh5aB8Kmzw07J8COIoxcjpy3IPeD
         MS5fWYTQX/OddMZPcjgDcLjFxhO2GilEbaCTDyoRq58WJ3g8rL6Vo+ojbYTUaJdUR3nH
         AKDvayKQplVMq8/PymOUF/7utczQ8ROrAqPcvofn0fYYhyhMf8X3VIJJmhEy9O3NAcXy
         SHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AUWAYrGIOKW7HVBmvM7CxDq6aDYJwnUza9E+yinLHsA=;
        b=ZmTXqN1Me3gGZojt77t+F+/A4AVlRbosgnOO0laWN7Rb1vqoaX9fsf4jMsMaA8Ags9
         bouZU5S8GawV55bfraTEiTQd5LV/AW8es3Y41Ln15jqd0VCFTikZ3DsXqgVk1m7aGCW1
         LfhfqMr8HwrUiVK6SeqQZSo+sCrspLIOBMa2RpTAdyEC4YiwDp/5Dih/NiHREA9FMcFm
         CORaTe0q+XG/2c68X9gE7DVIPVVIYO2QVDeyD76VRk2MrzD4sCE26o9B+C178rMeYH+r
         DXt8V4n77t84vfDpOXISRqep1z36OdAif3BzsvmMtxzXUoev0nFFSb8uPB12j2a6pXNQ
         Vx2g==
X-Gm-Message-State: AOAM531Qh28MWxe6YyvuFuTjDuato4k0LJhmaudI6Qze/SgbWLYUp/7T
        r06gjDDY9kY+jAfNnVJHy1D5SFQVcHIr7e7O8vg=
X-Google-Smtp-Source: ABdhPJzyUnETl3PgPDhyusRaAqih6NUC/Zo+FhbQ6Q5OEOQ9rR/z3NBcVpvAERheEDNosu2smpF4hUuOgcuG8tv+wGs=
X-Received: by 2002:a67:6505:: with SMTP id z5mr14738903vsb.16.1641289789806;
 Tue, 04 Jan 2022 01:49:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641043500.git.dyroneteng@gmail.com> <d77c895a4b9d5cb86443279c0156196254895ef4.1641043500.git.dyroneteng@gmail.com>
 <xmqqwnjgfe4t.fsf@gitster.g>
In-Reply-To: <xmqqwnjgfe4t.fsf@gitster.g>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Tue, 4 Jan 2022 17:49:38 +0800
Message-ID: <CADMgQSRXJ0F0=egA_PcEz0NzXZMVo1nLv1N8dGyoRhdDsZPc9w@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] ls-tree: split up the "init" part of show_tree()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:

> Don't we need some comment that explains what the function does,
> what its return value means, etc.?
>
> It seems that even from its returned value, the caller cannot tell
> if *retval was set by the function or not.  Perhaps it makes a much
> cleaner API to assign 0 to *retval at the beginning of this function,
> just like the original did so anyway? ...

Oh, sorry for that, I did not notice the "retval" before because the
naming is unimpressive and the tests were passed, though...

I just looked at it, actually, it's important, not as what it is named, it
affects the result. The "retval" actually determine whether  to
CONTINUE reading the current "tree" or BREAK into the next
one [1] .

So, I think this commit should be modified despite the tests are passed,
firstly, I want to rename "retval" to another name that makes sense,
then just make the relevant "if" and "return" logic more clearly with the
newname, finally, it'll be consistent with the definitions in "read_tree_at=
()"
at "tree.c" [1].


[1] https://github.com/dyrone/git/blob/master/tree.c#L40

Thanks.

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=BA=8C 10:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Teng Long <dyroneteng@gmail.com> writes:
>
>
> > -static int show_tree(const struct object_id *oid, struct strbuf *base,
> > -             const char *pathname, unsigned mode, void *context)
> > +static int show_tree_init(enum object_type *type, struct strbuf *base,
> > +                       const char *pathname, unsigned mode, int *retva=
l)
>
> Don't we need some comment that explains what the function does,
> what its return value means, etc.?
>
> >  {
> > -     int retval =3D 0;
> > -     size_t baselen;
> > -     enum object_type type =3D OBJ_BLOB;
> > -
> >       if (S_ISGITLINK(mode)) {
> > -             type =3D OBJ_COMMIT;
> > +             *type =3D OBJ_COMMIT;
> >       } else if (S_ISDIR(mode)) {
> >               if (show_recursive(base->buf, base->len, pathname)) {
> > -                     retval =3D READ_TREE_RECURSIVE;
> > +                     *retval =3D READ_TREE_RECURSIVE;
> >                       if (!(ls_options & LS_SHOW_TREES))
> > -                             return retval;
> > +                             return 1;
> >               }
> > -             type =3D OBJ_TREE;
> > +             *type =3D OBJ_TREE;
> >       }
> >       else if (ls_options & LS_TREE_ONLY)
> > -             return 0;
> > +             return 1;
> > +     return 0;
> > +}
>
> It seems that even from its returned value, the caller cannot tell
> if *retval was set by the function or not.  Perhaps it makes a much
> cleaner API to assign 0 to *retval at the beginning of this function,
> just like the original did so anyway? ...
>
> > +static int show_tree(const struct object_id *oid, struct strbuf *base,
> > +             const char *pathname, unsigned mode, void *context)
> > +{
> > +     int retval =3D 0;
>
> ... It would mean we can lose this initialization.
>
> > +     size_t baselen;
> > +     enum object_type type =3D OBJ_BLOB;
> > +
> > +     if (show_tree_init(&type, base, pathname, mode, &retval))
> > +             return retval;
>
> >
> >       if (!(ls_options & LS_NAME_ONLY)) {
> >               if (ls_options & LS_SHOW_SIZE) {
