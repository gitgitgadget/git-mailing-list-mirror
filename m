Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70D5C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9531F2074D
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFyte/+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgGAKRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbgGAKRB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 06:17:01 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED5DC061755
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 03:17:01 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id f24so12989261vsg.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 03:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=02XSS7apjrq2odJ9dNiONTN7L6tTG4pp7GyNWZ4MiSY=;
        b=AFyte/+qivJGTnVdxix/68PsERJtcQVABl6fnl1Cq5oXV5rrNxTDPfNeMnPHkijzQ5
         EuB0ca8qTTOuHmudNynJdJAirXoU6/bMpg2Bmes/Ejfyh6c6rqiFBKmiXr74K5qfMC5L
         qpJUAFuszzVbsaw3XS0JiWuvubkAMOmU77Vw6NRO2PLt124Tec+sAPfUF0mzZlYn0Jkk
         YQnublcFdYrX+4NIA3zKDORcG297HO+OXCLO87zdvPeVUKgPSDJsEp3usi7zcdRwOwGM
         70M/wbITeMZfHKeVWLaSBJVwm0ACjhCcCGFMRA9HG/VKsGkob77cEXR3KvJj9VH3FmoA
         fB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=02XSS7apjrq2odJ9dNiONTN7L6tTG4pp7GyNWZ4MiSY=;
        b=qkmKmgTHP97k9xzKtYkmgFPObsPiaY8KHyuVpMF51EyZNUbJ5kM7aOb2XKRVBtUGta
         eAqedx5WUBlEOsuoH9AX18KmBEWUJ0/pMWv2k0yoy6tRPtcYPX06b87kbpP6k6ncW27w
         59qQAW+RfaSloEDvGyLzz6ZpnRI2SSA1/LsOKTFr+pNIf9s7593O7YsdIvqkNDxbTIuA
         V5Z2RYLAJqvQ79RAJ6bu5OVVrt7bP/ZwP5X1mr8Kyk/a3jNmK4jzFIZZkgQVeMb6su1i
         MzweG3VekTZZo1oy/81TXBA4yZvdnyqMWT8B0TV0DOj2/gLTxOSp0bJykxO7YvWxmWMT
         ga1g==
X-Gm-Message-State: AOAM532nU/s3Gcgs28OgJTojwx/FrWhqWinQymv3nOX0adE84LraoPcy
        WC5nacOpA7VbeUd6yo7x82lxrQNTdYc4Fs5QbeqzFg==
X-Google-Smtp-Source: ABdhPJzD26YwjMYrBQ2VByLFqLy3ObTsM8ySksZJMYFBPOT4yMWJD+Ms2Q+KYDn03JoUA0JT5oSPEh69tFw4m+L1dJQ=
X-Received: by 2002:a67:c011:: with SMTP id v17mr20320242vsi.56.1593598620068;
 Wed, 01 Jul 2020 03:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
 <pull.539.v19.git.1593457018.gitgitgadget@gmail.com> <xmqqimf9fppn.fsf@gitster.c.googlers.com>
 <CAFQ2z_MbiTEzztU9a8beMAQFn1-ozBUwKD1JyhXHUnoTTto0TA@mail.gmail.com> <xmqqbll0drtz.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqbll0drtz.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 1 Jul 2020 12:16:47 +0200
Message-ID: <CAFQ2z_MZoc3Q15O0LDTgVYV7nKEK1Oc8GLWEZYrrFjU9VSsUCQ@mail.gmail.com>
Subject: Re: [PATCH v19 00/20] Reftable support git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 1, 2020 at 2:03 AM Junio C Hamano <gitster@pobox.com> wrote:
> > Do you have an opinion on
> > https://public-inbox.org/git/pull.665.git.1592580071.gitgitgadget@gmail=
.com/
> > ?
> >
> > There is some overlap with in sequencer.c, and Phillip's approach is
> > likely more principled, so I'd like to base reftable on that.
>
> I assumed that these were offered to you as possible improvements to
> be folded into your series, so I didn't read them very carefully and
> I didn't queue them myself.  I expected that I would see them,
> possibly modified to fit the context better, as part of your series
> sent from you, perhaps to become a part of early clean-up portion of
> your topic.

They are changing the signature of widely used functions, which is
useful for my series but not completely necessary. I would rather that
someone else decides on how to go forward with the series.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
