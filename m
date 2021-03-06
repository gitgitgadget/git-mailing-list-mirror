Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0899BC433E9
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 17:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C2D65015
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 17:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhCFRxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 12:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhCFRww (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 12:52:52 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2843EC06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 09:52:52 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b13so7931291edx.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 09:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fukzAvGSvjExCSsCoHu7HTAEgT1XPiBQmc4+JUWwQNs=;
        b=bCfnN5TzJNeryjJYohi2PI4TPZ7jC3QQCq+c1FIiye1sZ/KgzzOtuEjbQcJBv9c48N
         86iC+lpKcV2V6bhJg2d2P7e/Wffk5RH5nfevTrgbqV2YuOVFUIUbcZr4KKl+mcty2gcC
         gVoTBSkvmTFl1wHUQMQ9q5o1g3RjRYtrs8JxeZ9SZ+7yq1Iuutlq5Otdne+6pmhDoTed
         EwkX7J/x5XkBk9VwIHNKzOKPpNKAfdR5Ndt5f/AOOn4U62/t8R/FOKOarVkTGOnsGYhR
         wP/zR/hmZLND9UgDSAZmVoH5UVHH1hX16Y0xy5cWWQ03XiXOZdpTiDtrMPgBS/oX8JXn
         qajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=fukzAvGSvjExCSsCoHu7HTAEgT1XPiBQmc4+JUWwQNs=;
        b=Vdme63fNSu6RdHzLfHz/Gd27jc6RIL1WpAbwSnKzX1JQEXbYaLveZNNYY+WrY4zKwf
         OMQZmMf21tknnS8gDMWoVzCqXSUzPge/cGyu7I+/WIB96MC8lzL50Szk/W32e+GhIbGz
         huzfumDvZ6GoLUSRE0+bFRztU7ozfDFgPIASQbblhHPMu9azESDophNUD8Pl0DJ8J6Br
         gMCzTjr/FRCUZJa1pM3OeaRGsYjaQCVZlkCuXZU7BXKGwawsIQUNK4i0sNX/zqzvlpzI
         MOrTsDVLzdZsPA9WFPqD0b2ndrbET2DZ9aBC2G4Am9cQ+Y1klWe3Uxeu059Jd5yCwZsJ
         ssOg==
X-Gm-Message-State: AOAM5304DwXREVcVKxTSSy64b+h53WywcDLlOKdGW25GwQ9Wjq3xjucW
        aJrCbBktoeZCCppT42sBQfo=
X-Google-Smtp-Source: ABdhPJzkfRbX+/MwKi9erDPwo9Nup7/oJu3p5I5Cpc27zRF/RaJ3Qf1jtF2vuXzUMbI41r5C+J2Xyw==
X-Received: by 2002:aa7:d74d:: with SMTP id a13mr4997299eds.199.1615053170796;
        Sat, 06 Mar 2021 09:52:50 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x20sm3572288ejv.66.2021.03.06.09.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 09:52:50 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe=2E?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 0/4] Makefile/coccicheck: fix bugs and speed it up
References: <20210302205103.12230-1-avarab@gmail.com>
 <20210305170724.23859-1-avarab@gmail.com>
 <3aac381e-2ce9-e35e-498c-9c26df235aed@web.de>
 <87ft18tcog.fsf@evledraar.gmail.com>
 <c654c7f8-bcdd-ab58-cddb-a1005a9b8914@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <c654c7f8-bcdd-ab58-cddb-a1005a9b8914@web.de>
Date:   Sat, 06 Mar 2021 18:52:49 +0100
Message-ID: <87czwctbim.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 06 2021, Ren=C3=A9 Scharfe. wrote:

> Am 06.03.21 um 18:27 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Do these sorts of rules really benefit that much from the type
>> v.s. expression? If yes we'll obviously need to support it, but if (and
>> I haven't looked closely) we can equally rewrite them with "expression"
>> (or it would be good enough) we could be quite a bit faster by
>> default...
>
> Type information is essential for many (most?) semantic patches.
> Untyped replacements could be done more easily using sed or similar.

We have 65 individual hunks in *.cocci by my count $((/ (cat *.cocci |
grep -c ^@@) 2)), but only 9 of those use the "type T" construct, which
AFAICT is the only thing affected.

There's still plenty of reason to use spatch without headers being
included, it's still doing a full parse and knows that something's a
function, and otherwise cares about C syntax etc.

Anyway, I'm not saying you don't need it, just that AFAICT it's a small
minority of the rules that require the includes.
