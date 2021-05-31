Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2739C47083
	for <git@archiver.kernel.org>; Mon, 31 May 2021 16:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9823561370
	for <git@archiver.kernel.org>; Mon, 31 May 2021 16:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhEaQUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhEaQRN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 12:17:13 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD0EC04C4BA
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:48:55 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id x2so6130732vss.3
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MB92O2eIxJryp6XBbVNGimX+ACneP7w70qdzb4h0I3U=;
        b=ND2zoIkhSzocGN6eO3CaJJHQGZ/enFBq8RU8MTpaHMZoFYPxg/Rlf8KwX4VQRb2Fxv
         YSvibOm0wilTFIQj0JJscVa+gaNEyY+uLZyqoGClo0jX4aucWSnbbtu7L5a/Bgm5QGwq
         h7CArTm4LrX0wzor8bPEWpuDuQkFiwSXqD2ULDp6RDS2QlPejTJtXHIsJiSfhD0hNpOj
         A1DQ5hFbTay7e6HPMtXpLiIsM5BpUVvumBHgKIUr0OrfX0MOF3h/jJw7ZTwY7HQRmsLI
         ojaxwGm6BFnl/oCYFRFALUbetfOWOfSgBE6vSqkCYXcYJYQvsf08Qvmh5rLCoDcpqOhy
         qXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MB92O2eIxJryp6XBbVNGimX+ACneP7w70qdzb4h0I3U=;
        b=CK2PsxxpReBd+wzWlEHRDKMDzG6QCHsAy4VjaFqKqNxB1VCa1qWrXZHjKfWIF4kJ1p
         O33wyykgT6zwIdPtOc22dHg80Jia1ioMzmYxMXAxEwIxiEflHR1lCZeHX/wcD1FNmmFj
         QDldmwOOaiGuIBHydBIiCkVZjUzLGn89Igs3Nq2emRHZGrw8ZTA8L2+e5QXGwKPiuFR3
         E4MIZrUMKPbG7hdDek1yYVYAfUpnxzihTCypqvn4pkH6wglSkSjUD1Y7ID65BWAwxGET
         kpLU4UCkTtD+6bOGnG4xQi0R9hQkZjUOnGiFwgoyp5lYrNworuiu5XQuPLrM0Jk6vcRW
         2iTg==
X-Gm-Message-State: AOAM533whioBDyEdXOXUEmMKb9PQENOkRS1CE7axHcvrwWxwbxgaSlJO
        0fXZ6iKfVC1DbzHz4tqTjn/qqLBd0jxQEz2TAadr9A==
X-Google-Smtp-Source: ABdhPJynh6qrVrmMd72vtm9GGvl2Juauw//ArCn+QmAP+oTbJbfSNfK4Bl2i8u5dUfjFPfdXmntiRIpbVWVkjbCxVtQ=
X-Received: by 2002:a67:eb53:: with SMTP id x19mr13887692vso.28.1622472534334;
 Mon, 31 May 2021 07:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com> <e6222944a3eb441d44ab6c7d1e9b873f5546220a.1619519903.git.gitgitgadget@gmail.com>
 <877djtqw5d.fsf@evledraar.gmail.com>
In-Reply-To: <877djtqw5d.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 May 2021 16:48:43 +0200
Message-ID: <CAFQ2z_N2CfX9UYZTBV_kcssz6Pku4GqjtdZ=ZRiMAyCyNn+Chw@mail.gmail.com>
Subject: Re: [PATCH v2 02/21] t/helper/ref-store: initialize oid in resolve-ref
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 5:09 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > This will print $ZERO_OID when asking for a non-existent ref from the
> > test-helper.
> >
> > Since resolve-ref provides direct access to refs_resolve_ref_unsafe(), =
it
> > provides a reliable mechanism for accessing REFNAME, while avoiding the=
 implicit
> > resolution to refs/heads/REFNAME.
> >
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > ---
> >  t/helper/test-ref-store.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> > index bba5f841c6ab..01d8f3285dc8 100644
> > --- a/t/helper/test-ref-store.c
> > +++ b/t/helper/test-ref-store.c
> > @@ -118,7 +118,7 @@ static int cmd_for_each_ref(struct ref_store *refs,=
 const char **argv)
> >
> >  static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
> >  {
> > -     struct object_id oid;
> > +     struct object_id oid =3D { 0 };
> >       const char *refname =3D notnull(*argv++, "refname");
> >       int resolve_flags =3D arg_flags(*argv++, "resolve-flags");
> >       int flags;
>
> This feels a bit magical, later we have this:
>
>         printf("%s %s 0x%x\n", oid_to_hex(&oid), ref ? ref : "(null)", fl=
ags);
>
> Isn't ref always going to be NULL in that case too? Wouldn't it make
> more sense to not zero this out and instead do:
>
>     if (ref)
>         /* current code, mostly */
>     else
>         use zero_oid()

for programmatic access, the if will actually make it harder to parse
out what is happening, so I think this solution is better. Note that
the function already handles ref =3D=3D null, so changing the printf
format in this way can only serve to break other tests.

> That seems more straightforward to me than this implicit proxy for
> zero_oid(). Also, isn't the point of zero_oid() to not make this

used null_oid() instead (zero_oid() doesn't exist in C).

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
