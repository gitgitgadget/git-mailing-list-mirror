Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19486C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 12:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0269861D9F
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 12:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhF2Mun (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 08:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhF2Mul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 08:50:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE76C061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 05:48:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg14so36120537ejb.9
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2CzligkKJwCkj20f8G0X1kcUVdwz6XRDNM9RcUSxb8U=;
        b=Gqeg8mc4UY2BKlKmuwLwxiL5ThAdk0S5qGTBPClvbSZioHHPwL+qcsaru4ZHPltTpx
         w0V1raIegDhEHbqWbQPFgv3BqPQzrQyjLskyF483pt5NPpRGvBovokrRoDOBI4wGQ2Xc
         HKHyl+r0JzEj6z750Zuo41C4HYsphah/7h9LXQ6xECZ+hD8C9hQYqAeVRQP1wQfNSTG2
         ULq+uP5/gXHi8TNb3VccMgl3hs62TiTb/wxA9zJJelAkWO3jl84RVdzl0cEGT23w4x5f
         200lQzn8086qy8Lt8h9kP300yRtF/PcQgQsdaFpmW7hb0fPFG657soZOTbV4DtFaX2x/
         uo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2CzligkKJwCkj20f8G0X1kcUVdwz6XRDNM9RcUSxb8U=;
        b=tlxFxgBY/3y0qjp8eRejtqGFHY7oF2rPTUA4UHx0LX07Y3BBT5kRSubxEYW0+8f2t4
         hrfAQL5yscAKuIjS72D0idrCY6AGd24e9luFz9jnP/7HOvGCQOiDZtojpAa1fLOkB+PA
         Z0hX5MIfkS1TSgKjPQpoGIQrbpRc5psRgC06h8++Ev47MehS903UlWhK4KkxEgyr8+wq
         awDJOKf7Zq1hpKIRkjRinWlNyNJSU8CVVvIoXXyRaKqRH4zjrJtd1wuUy/OZiHanMaSX
         i1iZzW7K/WWAMwt0ElxEmVBpg1PLfM733y7ihyL1F6+e61sZbL2ch2Z/Q6zGt6PTsTWr
         qBBg==
X-Gm-Message-State: AOAM530uekXY7yMQfBYfDvH0I7AG5+XA1rhsp+s+TyCYQbfziUbIG1nH
        cbBKoKqLxPKceGGlbI0Vs7s=
X-Google-Smtp-Source: ABdhPJz391hSaziidOdy0jnXO7D9z0K4Xjv6imWo7HAWjwFpYKGzJoYNDV94Xv5Gu6gVsDN02SziZw==
X-Received: by 2002:a17:907:1c98:: with SMTP id nb24mr9030551ejc.316.1624970890796;
        Tue, 29 Jun 2021 05:48:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id lz19sm1215172ejb.48.2021.06.29.05.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 05:48:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Date:   Tue, 29 Jun 2021 14:29:37 +0200
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
        <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
        <87a6nryt51.fsf@evledraar.gmail.com> <xmqqsg1iseza.fsf@gitster.g>
        <xmqqbl86qtyf.fsf@gitster.g> <87bl85y15s.fsf@evledraar.gmail.com>
        <YMvuprVu1MnokHM5@camp.crustytoothpaste.net>
        <xmqqr1gyjpyb.fsf@gitster.g> <xmqqfsx162nu.fsf@gitster.g>
        <b22f7fe0-4096-2c17-4c6b-dad08cd2a7e6@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <b22f7fe0-4096-2c17-4c6b-dad08cd2a7e6@gmail.com>
Message-ID: <87o8bog7li.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 28 2021, Derrick Stolee wrote:

> On 6/28/2021 6:32 PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> I would like to consider that the last draft I did [*1*] based on
>>> earlier suggestions by Derrick and =C3=86var would be a reasonable midd=
le
>>> ground.
>>>
>>> I'll go mostly offline next week---I'd notice if the list came up
>>> with a vastly different concensus when I come back, but hopefully
>>> not ;-)
>>=20
>> Well, I misspoke.  If the list reached a consensus while I was away,
>> then that would have been a happy outcome, whether it was close to,
>> or vastly different from, the one I suggested.
>
> I hope that my reply to your attempt was clear that I found it to
> be a good approach. I'm happy with it.

Since you posted the v3 of this patch series there's been on the order
of 30 E-Mails dowthread of v3 4/4, but your only replies have been to
Junio.

What phrasing (if any) we use for prose guidelines in the
CodingGuidelines doesn't cover the various outstanding questions. Mostly
point-by-point feedback from myself & Felipe.

Per my upthread [1] do you plan to address that feedback & re-roll, or
ignore it?

1. https://lore.kernel.org/git/87a6nryt51.fsf@evledraar.gmail.com/
