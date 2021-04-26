Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F19C43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1525661009
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 18:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbhDZSCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 14:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbhDZSCS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 14:02:18 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1882BC061756
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 11:01:34 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id u23so8227990vkl.12
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V6/wpr4mfnv8IJb6hud6KaLYROw/Ez3ridlLSItuqfs=;
        b=ATUuqo39YVzW9W6isHy6cIXPMGFe0jv1DFF0QzPCxRaL1pGWNfbqeeFyidcwGMCO63
         V1xHBCaimVSpnJdsEmprCm2FMh0EjHLmwJpP2MVxroKZ8UfLm3Hqtzzeg0fEfwAAcBvW
         QsAxGKK2dK93ho9NrqzUOQ/I3cEav2WfvR2gQdPvWHEO9j0uQC1jDDR9QBFq/tm5Fs0C
         cDT3GcQsm+weXNKXoLNe+GgD/pzJWsTo9Y2KxOv+rma0LFGdCx1Px/9jcwyi4HiYAXXD
         +6yo8dqkB8kiTM8lcb+rIT3Os3tK7yxCBN+/XL2FsCQfEMHctO634pUe0EKrdodIkTfA
         t+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V6/wpr4mfnv8IJb6hud6KaLYROw/Ez3ridlLSItuqfs=;
        b=MmhS2lnSMNuPWpmkvJnx2e1mmbCzoIqwi9lmLNHZFcvgBHx9IxG1PkdYewnDsfKMt0
         D/ZF7CwOixYaCARbBVgqY/AkPx0Q+ISu4UA0IFfY8Aj1VDl4FQ9EIV7KOWRXbAVNvpbA
         jjs5JWRDPvwCJ42vhdFMJeW2N2R7fbZZwdN2Inonu3K3BcKv6MuQZu1PRAX177d9zUv+
         pAd7olBpdC7KM81Hj1UkMwx99sD3IhuUGsyxBQNix3BWWC3tEsq0YdT9QAUJtVzk3wjQ
         uz6QwzRGi/KqzGV1j6AsrX+Jj/nry2lZvaBGXK6GdNy1Xi2Ni9iW7g56kTe8XPZQ/6ce
         FPEw==
X-Gm-Message-State: AOAM532gZldPeflLDocmE2lkKCHBJiVG2tYTOQP3p4ACDoAAz5m7cjhI
        R9E6iyCIbIBXZ+CagodqwdrBb0mf69mvSqlfKw1N0Q==
X-Google-Smtp-Source: ABdhPJy4dK1Kmzsvv9l4bHNVTzC7jsSst7wuxFj8bcf5HAzYum0k5dOLvI2zEghM/8XXid1gxavNxaAy4JzATBFCHT0=
X-Received: by 2002:a1f:5c97:: with SMTP id q145mr13675355vkb.25.1619460093100;
 Mon, 26 Apr 2021 11:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
 <871rb45ftz.fsf@evledraar.gmail.com> <CAFQ2z_MMAM6jZ0+zRi+8fyS69Qw4fKQSsXgQW2zW7tcMdmN=QQ@mail.gmail.com>
 <20210422045953.GC2947267@szeder.dev> <CAFQ2z_Md=LAkJzohf3E5ogWGQHzxN_ik=yHAGmxm7bg-yT6-Zw@mail.gmail.com>
 <20210423051255.GD2947267@szeder.dev> <CAFQ2z_NgFC-7zENyD7HkEgvS6Dtc4qYqPRFL3m1LsbXnrFkPsA@mail.gmail.com>
 <CAFQ2z_N9_eXtuGcXSj1bwP5sy+t1fn8Q=X1na0jK9OpzDz2UAA@mail.gmail.com> <87mttp1hv3.fsf@evledraar.gmail.com>
In-Reply-To: <87mttp1hv3.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 26 Apr 2021 20:01:21 +0200
Message-ID: <CAFQ2z_MLSb1kv42KcjWvWNy1FkmKiMiAtB_7VTc2TDgNKP1HfA@mail.gmail.com>
Subject: Re: [PATCH 04/18] t1401-symbolic-ref: avoid direct filesystem access
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 11:16 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> It's not a cleanup routine that's failing, but potentially the "setup
> the next test" routine.
>
> In this case it's probably best to invert the logic, i.e. to make the
> tests do:
>
>         test_when_finished "rm -rf copy" &&
>         git clone . copy &&
>         <test-logic>
>
> Rather than:
>
>         reset_state &&
>         <test-logic>
>
> That also makes it more obvious what's setup and what/where tests rely
> on things carried forward from previous tests.

I'm using $TAR to recreate the repo scratch now. It appears to work.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
