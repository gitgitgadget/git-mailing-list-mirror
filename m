Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A655EC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D9F60FC0
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhHaU6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhHaU56 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:57:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50603C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:57:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n5so1112671wro.12
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kIBW61Ol29vZjh7Q+SkS8MhAGu+J8hcvqnC4scekeeU=;
        b=IJ1GVuyJ8eo7TBwayvx9t6Lbh0YYcvqJ83xNAoPlcDEZX1WrtxZx1UyqhBkjUx8XaX
         2g82clnRRSYgyOh9kxegE2/rBSw8HAOHGoidlKmhwaaBy2SpzmJLkiKQ4cEyGFrtAohu
         HfU1zidKWVr/3LI7PkBrz/1QK/GdtewJKYm96mdCMUEarncUR8HKhS4t4IBj8KXImN53
         zzBKHVw5cNR7JwDNzb2FQXwnw5cdSbOXaQbgq0d0dAvUfHLuzcmaNiJzEnoRMtPsfTXb
         +px2QYgLRyFcudIBecJVaoskTzuynM7h6qmrZ1krQMUe7mS/07jjMLM6j6ZCspomGSNt
         P37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kIBW61Ol29vZjh7Q+SkS8MhAGu+J8hcvqnC4scekeeU=;
        b=btMiy2jeVD/z96egkuuGujwwLgT8HD1H/Fqf5i6kmqmmukFlW0aPWeQxK7xEaecU6P
         GGkflfY3203+Xjzk4i9qmAeuBdPahKYq8pGPOBSUdHfqM6udGESMYOt9F7MjTZltUxRx
         skl4iVRGSjyiXPI3E7kmV3tMg4N0MWb1Ly16KqjxHNR7uISQBLR1vumgBMsR9Whg2AGv
         2ehGpDIYeL/qcf1I0/47Rf2Zwn5pJkglS/sXohE/zgwmjstbu34cD+AjPybuAZfX6HEI
         WIczSuLQ4/69W6SjFDqMOBnHtJJmSqbXY2K0jgOL7CnZ2f3q7h/ymc0QRRtZabiYrfRk
         J1tw==
X-Gm-Message-State: AOAM531j37oagPCUtaAh5V/oO2p4TkJqdhU+Pow3U8RkQ518GeiaKOX3
        QgykyzBVptOOsgSRMM2zy+By3QpTKiu+jw==
X-Google-Smtp-Source: ABdhPJwxZqGSdPZ5Wz9hY2JmmFkf8OR6g3go1npXU0aHFwjRxqJloqpMBn/Cme40D8unlYfkdQ1KsA==
X-Received: by 2002:adf:8169:: with SMTP id 96mr34146698wrm.207.1630443420857;
        Tue, 31 Aug 2021 13:57:00 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s13sm3408788wmc.47.2021.08.31.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:57:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub
 workflow
Date:   Tue, 31 Aug 2021 22:51:55 +0200
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com>
 <20210809013833.58110-4-carenas@gmail.com>
 <1b096830-3e01-efbe-25dc-c0505c8bac7b@gmail.com>
 <87zgszxirn.fsf@evledraar.gmail.com>
 <CAPUEspj43=z8nSdh8UAiqZ+UR8UAZkSsQr1WviGtasQ7d-fHTQ@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAPUEspj43=z8nSdh8UAiqZ+UR8UAZkSsQr1WviGtasQ7d-fHTQ@mail.gmail.com>
Message-ID: <87bl5dwcx0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 31 2021, Carlo Arenas wrote:

> On Mon, Aug 30, 2021 at 4:40 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Mon, Aug 09 2021, Phillip Wood wrote:
>> > On 09/08/2021 02:38, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>> >> similar to the recently added sparse task, it is nice to know as early
>> >> as possible.
>> >> add a dockerized build using fedora (that usually has the latest
>> >> gcc)
>> >> to be ahead of the curve and avoid older ISO C issues at the same tim=
e.
>> >
>> > If we want to be able to compile with -Wpedantic then it might be
>> > better just to turn it on unconditionally in config.mak.dev. Then
>> > developers will see any errors before they push and the ci builds will
>> > all use it rather than having to run an extra job. I had a quick scan
>> > of the mail archive threads starting at [1,2] and it's not clear to me
>> > why -Wpedaintic was added as an optional extra.
>>
>> This is from wetware memory, so maybe it's wrong: But I recall that with
>> DEVOPTS=3Dpedantic we used to have a giant wall of warnings not too long
>> ago (i.e. 1-3 years), and not just that referenced
>> USE_PARENS_AROUND_GETTEXT_N issue.
>
> when gcc (and clang) moved to target C99 by default (after version 5)
> then that wall of errors went away.  Indeed git can build cleanly in a
> strict C99 compiler and until reftable was able to build even with gcc
> 2.95.3
>
> the nostalgic can get it back with `CC=3Dgcc -std=3Dgnu89`, and indeed I
> was considering this might be a good alternative to the defunct
> gcc-4.8 job, where the weather balloons breaking with strict C89
> compatibility could be explicitly coded.
>
>> So if we turn pedantic on in DEVOPTS by default, wouldn't it make sense
>> to at least have a CI job where we test that we compile with
>> USE_PARENS_AROUND_GETTEXT_N (which at that point would not be the default
>> anymore).
>
> agree, and indeed was thinking it might be worth combining this job
> with the SANITIZE one for efficiency.

On the other hand maybe we should just remove
USE_PARENS_AROUND_GETTEXT_N entirely, i.e. always use the parens.

That facility seems to have been added in response to a one-off mistake
in 9c9b4f2f8b7 (standardize usage info string format, 2015-01-13). See
https://lore.kernel.org/git/ecb18f9d6ac56da0a61c3b98f8f2236@74d39fa044aa309=
eaea14b9f57fe79c/. That
later landed as 290c8e7a3fe (gettext.h: add parentheses around N_
expansion if supported, 2015-01-11).

It doesn't seem worth the effort to forever maintain this special case
and use CI resources etc. to catch what was effectively a one-off typo.
