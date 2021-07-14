Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA9C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04878613B2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbhGNIqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbhGNIqr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 04:46:47 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084DAC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:43:56 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id q124so306339vka.8
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IWG1ytXWabq/2g0RkxtRubZMwbbdJlNk/uVSoXVHWOo=;
        b=sx3zg1kPVG809NohrKacrOcKsLVDPa9BWXPXUkPs80WyHNC38ApZY4vqWkT5L0Qy7+
         tuxx9wCHmonj619baLM6Y0BUQ2eCZiVKxhVGnkOPNTITzZhW3Q3j7B0SfzRtiIXgfxVz
         bKgoBmgFqFTAepdZahY9zX2dkiK8lDypnW6Yr9Fnb8V93qsB5W/VkF+HZg0JI9I2qI1a
         czVZafnJmGXwPC5zaAWT1Q23RRhKzjPWYina8sT5Wndn8iadiVLjBj3A4s5BMfByC8iF
         D2ex78y18qchtW/CbzrtmL/Yhj9BmTmMaZTeNF+tCQXFkTYRn8vMJqMWFPJ1+5VsvbO8
         U51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IWG1ytXWabq/2g0RkxtRubZMwbbdJlNk/uVSoXVHWOo=;
        b=jUvTVEfRqR1Az4XKpiB7MLKMnnibAkSwlt2abAiuM9MBQ+Xuhee9tUt9ANy2RoJBpv
         d1xvKL+EiXXDohL7ARnL8AtyqNYJk4tqpNzIHqLFAPIYfA+EDdRb7BZxWXh3vTR3Ixic
         v6LgOo7Xdmtxg5VjH7sfi80MtdCAhHsXMXUD2BIPqr48Aa/nkfE65tEejX8wi+Whtmr8
         ifk0LZWEfrb8pLneMhpDJaYFin0qPTYcwHtuBY4l8yx9aEE4rMGKVpH6cs6vPqVKNfGb
         CJ7q+3kCKOnsU7ayO4In22z8KrB/BZv5GnbChdTlF/PotyuF3L58bVa8H2yS7WE6iW7p
         WG6g==
X-Gm-Message-State: AOAM531ehYcjwj0FafrcZgaiiscx3j6f9lcQ447sQjuUMmG919tXmlXe
        F0qQqhvu0URTb4GI9D4CPzRz44c0B6OJpYOLEw+4vw==
X-Google-Smtp-Source: ABdhPJyMgICTooPa3lDFMgo6EtlirByBgzklKSr81tjvF1pOarAhQqSaaqRDnFf951giY6/bLihw6SAWt6Jl+ImSmkU=
X-Received: by 2002:a1f:7c81:: with SMTP id x123mr10506565vkc.24.1626252235084;
 Wed, 14 Jul 2021 01:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
 <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
 <CAFQ2z_M7FzR6HEea2Xj-j=LiTsjQvpGJc+h+D+GgU=ZEkWm50A@mail.gmail.com>
 <87h7gy2hn1.fsf@evledraar.gmail.com> <87lf691e6t.fsf@evledraar.gmail.com>
In-Reply-To: <87lf691e6t.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 14 Jul 2021 10:43:44 +0200
Message-ID: <CAFQ2z_NcBZS7w2YQ0CCT-0ffHdjk229OcLc5Zg4v7Tej62CGiA@mail.gmail.com>
Subject: Re: [PATCH v6? 00/17] refs API: get rid of errno setting entirely
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 10:40 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> >> It adds resolve_refs_unsafe_with_errno() to the  public API in refs.h,
> >> and I think it has an ugly signature, but I suppose it's better than
> >> having the output be implicit through the global errno variable.
> >
> > Yeah it is a bit ugly, perhaps we should just end up using the old name
> > once there's no callers of the old one?
>
> I looked at doing this, I don't think it's worth it.
..
> And in any case with reftable I suspect that we'll end up refactoring
> further down the line sooner than later, i.e. to pass a "struct strbuf
> *err" or something, so getting it 100% right here seems premature.

SGTM.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
