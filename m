Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F68EC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 19:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiAKTcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiAKTcA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 14:32:00 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D90C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:32:00 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 191so200753vkc.1
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WgT9Slz44QqvUBaA9e8PpDBmhhLvYyag4TQett+A5s0=;
        b=k5PNpu3XCS4Yyj3zdHcbT5vXEmN9D7HDlKrV/caOTGaFilYHiiEL8ioy5uP+2xkjUk
         SKlJrhORqsJqxrR7JdZT7nzpn1pNPa11Y0tUACpjrd2dVzY35ut04Yoa6sdfq4IoHgSX
         W3C9FcknvnTbqcPIeTBae85azq7opQBbEfMr1kvZ6eLWCj4L0FcjvxhiQaTDyto59S10
         6kXzwHJne0mLfdXIf+9OjzZ2O8T/cEAW7rxeoX1Iwz/OhQb7fcHyUsV/U/wC89+l98Zc
         y4kSiL2NRR84IBmmaEAPwEKRCVMv6mERUWjVEwxCl9v5RItU8Z9eSs8VQhSZGpqhJTKr
         SNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WgT9Slz44QqvUBaA9e8PpDBmhhLvYyag4TQett+A5s0=;
        b=iZHzyKdk55MWa/miGRRajIzYT2+Ad6HYjchJ8+TmyddDWcQLKSDaWmkg7irY0j6gel
         i4sz+g4/UCVQ2WDh+fXKekyOep+ONfpe7oo6wAxxtPRUOrVcEFNcJk8rZuZXMI0/H9v4
         RBlip1ae58vyUFcgq+S16Vv0fU/wA+R9i9u6a4KxsSF1mtilYfBB3cM/eK1+XQsZwxj2
         DZdSjJ5DjkG8qNT+qZq9/El6ok96JHa805jkt9Af6jek/afhiM3E5KaJ+t9HzCxkFUUc
         wjD0j1RswiI598hlOXSSpXBPC16j63pizB9XhUHaEfYRbvNq1+8SJu+87S2TI/1KCBra
         NpdQ==
X-Gm-Message-State: AOAM530ofT1/UNfv26q/McLNkL7ZHCABpDNdbJU/CLfO0a3kJK7CK7Wk
        odprCoYQu9wuGjufnoo+lzWVV+OHOV3sesoBSkDK2Q==
X-Google-Smtp-Source: ABdhPJzlavDXBWi3wqLr1kwYXWxf5oi3cpbtZ3an65MedVy9YjF4ehDo0G6fDXc1uSsInxXbHrwCahWnZhX0MwIhHck=
X-Received: by 2002:ac5:cda4:: with SMTP id l4mr2969462vka.10.1641929519052;
 Tue, 11 Jan 2022 11:31:59 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com> <Yd3aZ5Q9Ph0H+Ijn@nand.local>
In-Reply-To: <Yd3aZ5Q9Ph0H+Ijn@nand.local>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 11 Jan 2022 20:31:47 +0100
Message-ID: <CAFQ2z_M0Fjjx8tAd_cXqk9K9q43hwienEy=UsLJi2aW8G3sEwA@mail.gmail.com>
Subject: Re: [PATCH 3/3] reftable tests: avoid "int" overflow, use "uint64_t"
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 8:28 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Tue, Jan 11, 2022 at 05:40:23PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> > diff --git a/reftable/merged_test.c b/reftable/merged_test.c
> > index 24461e8a802..b87ff495dfd 100644
> > --- a/reftable/merged_test.c
> > +++ b/reftable/merged_test.c
> > @@ -24,8 +24,8 @@ license that can be found in the LICENSE file or at
> >  static void write_test_table(struct strbuf *buf,
> >                            struct reftable_ref_record refs[], int n)
> >  {
> > -     int min =3D 0xffffffff;
> > -     int max =3D 0;
> > +     uint64_t min =3D 0xffffffff;
> > +     uint64_t max =3D 0;
>
> Han-Wen: it looks like the loop below the context here is to set the
> min/max of update_index over all of the ref records?

correct.

> But perhaps not so from a width perspective, if sizeof(int) !=3D 8 (thoug=
h
> I suspect in practice that we are unlikely to have enough possible
> values of update_index for that to matter).

correct.

> In any case, you're only setting the lower half of `min` high. Maybe:
>
>     uint64_t min =3D ~0ul;

yeah, that works.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
