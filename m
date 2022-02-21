Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55553C433FE
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377865AbiBUOdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:33:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377983AbiBUOcr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:32:47 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A688220F5
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:32:24 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id w128so8024469vkd.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a2meDT4IZWyshGW7S4puXprQQ6oR6BnZfRsLgrIP5uI=;
        b=sL4rac8/1YjNV8fDlOeUOWG8mBQUMg1BRxaz40rHCHKAjIyJqBAuuW0drQb+mzSmeV
         Y3Qkr3/K2qpx6XQZ4Jr+CDjrnrkI/0JwGdWHRQoE8MIjvCGrwkiP/P5jA0VpzYx69kyI
         FhoQfZeEa/JBuNKSU+YRxjsWSFuzJQ6iPvLNjnWUox5UJr2kXJA4wHHoPZ0vaQeGGn2w
         HGDeUUir7CDyZJdh6xtx7GqbK3yt0ikCaCR+84oMvNq1JpuNUdwEjgwsqFJ0Na7PL3X0
         6YjZTpNAd1705j4asqxIV5EJWBYtauz7W8UMIa+HNrgD6bvRZ/BW6d3XEQbaGIjk782a
         GiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a2meDT4IZWyshGW7S4puXprQQ6oR6BnZfRsLgrIP5uI=;
        b=6PEOtZl5x2zFftwa6B8PN4lYOEipOg5CBA1ISYn7jzwlHVurcnbCW1xlPgB9iZHqzV
         rpjDFMh9tth6cEpF2rs7MG8lND4e2ONbEwT0A0XxnFQv0doN8kJN8G2HioX69gP4SVXw
         0ZcMw2x7yNvH1doH8ueZMPwaKaTpBzTkte0VgAuHGfUqkoBy6MbZx30ziF3hw4aQCwod
         v+Km40zEE2kfEYv6jKvek7ViiSxfpRhNKrKLzd2YQTxBzDaLyUPXUgoq+dPVhnTSUgB3
         9e9wcNadhSHfp8mTvn6BWsrysjuRD/P7ESlrmi4v8moZlZQfTsOeRfp98op9UlEoS4Ry
         9LAw==
X-Gm-Message-State: AOAM531diUtrsRW2gvDP9RCyUDMyR4xVb4mr5kaeoY6iYpm+2f14Ph9D
        EyNqFXjKe2ecmlJmFXdaYGnjJ4sg6xCEHZ4g+z65pZdNZho=
X-Google-Smtp-Source: ABdhPJwLS+u7SePxb3H+KbDoF9oIQ2aHg7S+Xb1QFFTME/sPC4m/Lw+bUKAe24YCPUTnhmkiaNMqKmWR/MC9CGzIx2M=
X-Received: by 2002:a05:6122:16a4:b0:331:1be5:3d2c with SMTP id
 36-20020a05612216a400b003311be53d2cmr7893301vkl.33.1645453943108; Mon, 21 Feb
 2022 06:32:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
 <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com> <ba036ee8543b2dc28ac046eb0c8c0aef9e751c80.1645106124.git.gitgitgadget@gmail.com>
 <xmqqee4159r6.fsf@gitster.g>
In-Reply-To: <xmqqee4159r6.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 21 Feb 2022 15:32:11 +0100
Message-ID: <CAFQ2z_OkZwvvxY=9A8cVGVEyM49oWXQA_4zngu1QnKce-zb2gQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] reftable: avoid writing empty keys at the block layer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 18, 2022 at 12:55 AM Junio C Hamano <gitster@pobox.com> wrote:
> > @@ -358,6 +363,8 @@ int block_reader_first_key(struct block_reader *br,=
 struct strbuf *key)
> >       int n =3D reftable_decode_key(key, &extra, empty, in);
> >       if (n < 0)
> >               return n;
> > +     if (!key->len)
> > +             return -1;
>
> It is curious that this gets a different error out of the same
> sequence, i.e. decode-key did not return an error but the length of
> the key happens to be 0, not FORMAT_ERROR.

fixed.

> > --- a/reftable/writer.c
> > +++ b/reftable/writer.c
> > @@ -240,14 +240,13 @@ static int writer_add_record(struct reftable_writ=
er *w,
> >
> >       writer_reinit_block_writer(w, reftable_record_type(rec));
> >       err =3D block_writer_add(w->block_writer, rec);
> > -     if (err < 0) {
> > +     if (err =3D=3D -1) {
> >               /* we are writing into memory, so an error can only mean =
it
> >                * doesn't fit. */
> >               err =3D REFTABLE_ENTRY_TOO_BIG_ERROR;
> >               goto done;
> >       }
> >
> > -     err =3D 0;
>
> Is this "doesn't fit" related to "we catch 0-length keys", or an
> unrelated fix was included in this step by "rebase -i" mistake?

We don't want to reinterpret API_ERROR (from block_writer_add) as
ENTRY_TOO_BIG_ERROR, so we have to tweak the condition here.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
