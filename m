Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1D2C3524D
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 17:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD81B20721
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 17:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzmX3N22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgBCRKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:10:11 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40372 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgBCRKL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 12:10:11 -0500
Received: by mail-wm1-f48.google.com with SMTP id t14so93142wmi.5
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 09:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RAHbCvD/xFxQKuzYq+WNB9fLR1t+0PclJYk/n+ZE5U4=;
        b=HzmX3N22Yilqp8X1gJpO+7/IEtmp6XZU0EkQTuyPF1dCIxO4gnCwUf5xBJgXj9+RAt
         ARdPkIDMbWvYFUw/9hvlYU5sOo+pSnrCWvVYcnEgKUgSAHQvEEOKZYip1kklLhpc/Sys
         6dSDxfKGqIEtvxj9E0Ti/7kncGGEcOvCMZvLnReN4lVkgSscRAUxzEkDgKUe76xyIXRU
         xso6cPD7yXVlf/dY/lNQpSHV3+b057FjhSut2MygivcFO39J5iCBMwSMi/xxF2UVQh9x
         Xm91QBAKK/ltiegDpaBbt7ATlhHUsg5ucNMnBfWMxJpJqpvYyNxF7TM1QvDRdI3Pue9m
         LrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RAHbCvD/xFxQKuzYq+WNB9fLR1t+0PclJYk/n+ZE5U4=;
        b=avjtzEzH3tbUJEX86+R2om9kqTpPQSJtpkK1f7I/z8d2ry75StISPLNwSeLbEwfoo4
         sMYZ8Zg7E2nOop6XyA6uJ6yr6kDk6nf15sNrdnq+gTQ9uTpEKyJgKscJNgNK5LLNdPOe
         B6CbjWEgBTGUCQ4uh7OU2xeXbivENFdcmhNMo97UBnZRoilO676NgYLkPwzmWClEMwNZ
         Q2iZYeRERuMLdYA2kU9wU8xerbxex5dzH4tWA3TKwzLov/1+bnmXgU3BjnPZLdZ4pYIO
         e3wYFXw1Z1JqmwQSbWpkXPFqosTz7c+HR1ipTj7UvZaS8Jj39FTwAf3wnyOLtxAdz3UI
         dPMA==
X-Gm-Message-State: APjAAAUtUGEpgKxJf+pjJn+8n0fPIfdbzajrz2gkZB7j3QXHdbMOTbAY
        NS50glEAtcP6KcGwo+bxIUsR/YGEwAtLEVAesGSE4A==
X-Google-Smtp-Source: APXvYqyhP7zKCYlH3ZQU2Q1XgjROCVXfJG3HwzmGz915g4E+WKsDLrh3+DdkNZ8RCzxyNr1lu6udLV6VQpJXU7+yqJ4=
X-Received: by 2002:a1c:610a:: with SMTP id v10mr72406wmb.44.1580749809625;
 Mon, 03 Feb 2020 09:10:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <9138554.c73hJVQVja@mfick-lnx> <CAFQ2z_NkU6ekZkMqZpcFSEr8M3kfw0tiVCB2doHp3QTZtQ8UNg@mail.gmail.com>
 <2165647.H0RpPiDeFZ@mfick-lnx> <CAFQ2z_OgGvX3mFLeWSvEqdfxupRuHN_eFgqENaCRHHpO364_xA@mail.gmail.com>
 <20200130072122.GC2189233@coredump.intra.peff.net> <CAFQ2z_PvKiz==GyS6J1H1uG0FRPL86JvDj+LjX1We4-yCSVQ+g@mail.gmail.com>
 <20200203170555.GB3525@coredump.intra.peff.net>
In-Reply-To: <20200203170555.GB3525@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 3 Feb 2020 18:09:56 +0100
Message-ID: <CAFQ2z_P4p+Vg7AFPusSqEYL3RdtcYh+47vgiXD4RV+LqnDVaVQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 3, 2020 at 6:05 PM Jeff King <peff@peff.net> wrote:
> PS I don't know if it's set in stone yet, but if we're changing things
>    around, is it an option to put reftable-list inside the reftable
>    directory, just to keep the top-level uncluttered?

If we're moving things around, we can add this little difference too.
The original idea was to create a conflict with the old-style storage,
but putting the list in reftable/ actually makes files -> restable
conversion slightly more atomic.

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
