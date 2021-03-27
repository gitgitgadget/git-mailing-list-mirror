Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D3DC433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 19:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B9561992
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 19:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhC0TrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 15:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhC0Tq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 15:46:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289ADC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 12:46:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u21so13366014ejo.13
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zrFqiCt33t5xTQHpywRW69MpAj1cYxkx82oTgNC/cOI=;
        b=eyPvIOX+hwDZuIv++m5ZqZnZCdWmhBGMEazjJ1kthiRYkAjEHwxHk1OTVsFS3hD+ci
         bh5kqa43N1zQWG2Nxaa2m7160Gyilm2KIp+ztAnZnhRDWvVc+B7hpvOy08duDSiRyCpZ
         HRJ2a321R0Nl4y/cdc0WQyx8/r/8znuy5mZLKSViqVqQwa5tlx5s3MiKDirkQjsA7CcT
         VgDKuTO9ggN6cuaImnGvIvc0VZfYuy328er8ZD9ehZndcLNjDz48FnahS8EFtlJAO3rp
         5RUgYNUTBVH1iAuqPwIhwerTYb8B3Kf7rjtmKRaILRLdBzNhTFYeHiFhfITRWt6vgaJB
         hxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=zrFqiCt33t5xTQHpywRW69MpAj1cYxkx82oTgNC/cOI=;
        b=pVnXFrxEOnClph1/tgGJGVfG5Usg3PzF4y9bWMvLcDJonpH/q6iKRFvWfam9Q77Dnd
         fpRpAVwkZ+L1DsbFSKlAMV5nn8HciFbAfKOfbSmTz3WOoYfdN3Yg0eYvWNB65mWPdI88
         kZp0wQYgIy+IpWH5TBKo/uIBvhTxlm/RFjXAtR98l9jeB5F3yf1FjjaiIeM3e2iwY4I9
         iAnNcP7GTIJNXHArE3pb0/n5leUTzaZYTevBylnI8EBydDOAIRkplsHYHPUjg1L8xMoq
         KBpQxWCpcH252k3deno//Au5gyjGf/HvCuEMLZNA3MwYwytyjv8zYe33ePgc1KpYP6b8
         0RPg==
X-Gm-Message-State: AOAM5315RVopOBSUW4Hyc/rju3/VSX+HNfljhbdAJgBF3kcasO+Nb427
        TKDxhut4iTzH67ES+kykbAB6HqplpBQ=
X-Google-Smtp-Source: ABdhPJwrVUc1CQwxByOnW8b+DqmggGGkX7Bh6VAhwXXXCSGl463UI9mvt8uf+IcE6unKVLsg3NRO/A==
X-Received: by 2002:a17:906:d797:: with SMTP id pj23mr21823538ejb.367.1616874415871;
        Sat, 27 Mar 2021 12:46:55 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id mc2sm5547954ejb.115.2021.03.27.12.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 12:46:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v4 0/4] Makefile/coccicheck: fix bugs and speed it up
References: <20210306192525.15197-1-avarab@gmail.com>
 <cover.1616414951.git.avarab@gmail.com> <xmqqpmzkqypx.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqpmzkqypx.fsf@gitster.g>
Date:   Sat, 27 Mar 2021 20:46:54 +0100
Message-ID: <87k0psnzv5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 27 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> A v4 (I'm counting the 5/4 patch I sent to v2 as a v3) which produces
>> the exact same end result as that v2 + 5/4 patch, but with a rewritten
>> commit message/squash as requested by Junio.
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>>   Makefile/coccicheck: add comment heading for all SPATCH flags
>>   Makefile/coccicheck: speed up and fix bug with duplicate hunks
>>   Makefile/coccicheck: allow for setting xargs concurrency
>>   Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
>>
>>  Makefile | 34 +++++++++++++++++++++++++---------
>>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> It seems that after some back and forth, nobody is talking about
> this series anymore since Wednesday 24th.
>
> Am I correct to assume that we are now all waiting for a cleaned-up
> new iteration to get us closer to the finalized version?

Let's just eject it as noted at the end of [1] (last 4 paragraphs), I
should have sent a reply to the "What's Cooking" or something, sorry.

1. https://lore.kernel.org/git/877dlwotjc.fsf@evledraar.gmail.com/
