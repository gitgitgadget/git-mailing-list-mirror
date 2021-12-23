Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B552C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 17:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349384AbhLWRE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 12:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244295AbhLWREZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 12:04:25 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDBDC061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 09:04:25 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id p37so11008418uae.8
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 09:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SvPU9t9hprLx9Y2rv/IVY4iRDcTEQKI13PO6Hi6gB14=;
        b=HNVaxj4JPpiTKy1aiv8UEY+WOaMe9SigPUSrXIRr5mvjf2f1yg51uHyr2W+lrigPEq
         lguix3TqXJeHRDzamP3BTFYFJIaCvGbaI3HfR97q5yFZpwCshW0XQ9IOKaxNThcXUIk4
         VXhHu1XhYZ5y3c1Y7r7RrciNT8AI8VIZjzSUF/DvFVZp4lPKSVHKeTJjcLJ44NT5OC1A
         8NSRM9DhcSXs/xyqF2A+3Xb8ooL7ANCvU0fYHr6190aCPpRgkRi6C1HHQpeLeBFsW7xg
         KTYy98oCxYGzn2tmFXoDwVYWGIHMvM1RiiVllPBbEkbECUa+LSYHbwPXONndHJpHsMWZ
         BydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SvPU9t9hprLx9Y2rv/IVY4iRDcTEQKI13PO6Hi6gB14=;
        b=XpysWl15J3Q2z+QJeyojMpJkAAPh80pWz9CRidmZeGeGf5pae/GlikfPZyqiLXLWiZ
         HStyVUotEe5i01QarTqblV68X8OW9zp8HlFJQIctfFsiwAvGo6wwpu09ibkiqalMdVYR
         J13dFf5FNNzA5iY5JjWNi1VoqNVV9ty5KwWBrDOpxyl4nUVg3C3LkUQ6gpSGNtqiYrEd
         SI5HrY4unbkN3H2BOaS0L6OnIenPh1YqOpE3ssIEW5SNNWjOzNkf4OXDu8umw/kvoPKa
         GohxxObLGXum8e9WXubq9PXFax7oZ0dAKobngh5EB/bTc3aDTbSEskjhUEXtmPWeSx8M
         bzSA==
X-Gm-Message-State: AOAM531fNpDDOVI3LfixvTP/bubYEpPNogvoXOBtWjWrLcnsBZnaAv5T
        tlhS6oaP3McxyWyeMhKJ+sjPUdNAmhxVemTslFFiHQ==
X-Google-Smtp-Source: ABdhPJz/S3JTz6+0tqMVW/BurlI3yLdPi6oeXK0rbxc7SyLVzSS172/ObEEw2Qwy+yWkxAWP5/GXewEmvNXughyp/WU=
X-Received: by 2002:ab0:4465:: with SMTP id m92mr1103895uam.47.1640279064163;
 Thu, 23 Dec 2021 09:04:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com> <9ab631a3b29addaa54415139e7f60a79a19a6edb.1640199396.git.gitgitgadget@gmail.com>
 <xmqqtuf0fe3r.fsf@gitster.g>
In-Reply-To: <xmqqtuf0fe3r.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 23 Dec 2021 18:04:12 +0100
Message-ID: <CAFQ2z_OLCzOYXgXCTXyLOwwk7EBkPzwH=KASDmuJbur=q7L1Jg@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] reftable: fix resource leak in block.c error path
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 11:51 PM Junio C Hamano <gitster@pobox.com> wrote:
> > +     if (err)
>
> Is the convention for reader_init() different from all other
> functions?  It makes reader wonder why this is not
>
>         if (err < 0)
> > +             reftable_block_done(&block);
>
> even though it is not wrong per-se (as long as "zero means success"
> is a part of the return value convention).

err > 0 is returned when we reach the end of the iteration, and this
function can generate err=3D=3D1.

Normally, block_reader_init() transfers the block to the block_reader.
If err > 0, we skip that, so we'd be leaking the block.

At the same time, this means the "if (err)" is superfluous. In the
success case, the block was transferred to the block_reader, so the
reftable_block_done() call is a nop.

>
> > +
> > +     return err;
> >  }
>
> This one is new in this round.  All look good, other than that one
> check for error return.
>
> > diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
> > index 5f6bcc2f775..6e88182a83a 100644
> > --- a/reftable/readwrite_test.c
> > +++ b/reftable/readwrite_test.c
> > @@ -254,6 +254,71 @@ static void test_log_write_read(void)
> >       reader_close(&rd);
> >  }
> >
> > +static void test_log_zlib_corruption(void)
> > +{
> > +     struct reftable_write_options opts =3D {
> > +             .block_size =3D 256,
> > +     };
> > +     struct reftable_iterator it =3D { 0 };
> > +     struct reftable_reader rd =3D { 0 };
> > +     struct reftable_block_source source =3D { 0 };
> > +     struct strbuf buf =3D STRBUF_INIT;
> > +     struct reftable_writer *w =3D
> > +             reftable_new_writer(&strbuf_add_void, &buf, &opts);
> > +     const struct reftable_stats *stats =3D NULL;
> > +     uint8_t hash1[GIT_SHA1_RAWSZ] =3D { 1 };
> > +     uint8_t hash2[GIT_SHA1_RAWSZ] =3D { 2 };
>
> Will this code be exercised when compiling with SHA256 support?  If
> not, this is perfectly fine, but otherwise, this needs to be MAX,
> not SHA1, no?

The code is parameterized in terms of hash_size, so we don't have to
test both flavors exhaustively. There is a
test_table_read_write_seek_linear_sha256() that ensures that the basic
functionality works for SHA256.

> > +     char message[100] =3D { 0 };
>
> You're filling this to the sizeof(message)-1, so we can afford to
> leave it uninitialized.

At the same time, we can afford to initialize it :-)

I'd rather not think about this, and always initialize everything.

> > +     for (i =3D 0; i < sizeof(message)-1; i++)
>
> Style: SP around "-" on both sides.

done.

(I assume I don't have to resend the whole series for these small
tweaks? I'll wait if anyone else has comments, and send a reroll early
January)
--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
