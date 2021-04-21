Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73216C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5EF61435
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbhDUSDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbhDUSDE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 14:03:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF06C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:02:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y3so14119961eds.5
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KY4tQ5Rji0Sy6r3GCk5NFWQAsZtXKmIqzTH4rCY9Ycw=;
        b=Lu+R7PSbNd5Rv5HQ9GGcEzY1ngaXoqXNqSM0aPCe0wqlgk8xOxL1PV/f/unJwMgxEQ
         K4d6vUMzpyHlDFpqpg8U37fg+WUuZgaPIKmFCPrGgmjP7PSZfTXRekl8eC6gUJgnDXTo
         pPh2KD8alDbY3cVBtCPlrwtTQZCp/vWFX/JJsIRFs4UriFGh8A6jdrsHWZsYpibiDnAh
         5nZ8AUFyUChXjFB9hksv4FMusJxoD8yvYIBDTCVUb7mmAMTFLZI0zuidPB/uh3j+M2jh
         /v202/vwt1wGwh/RQJIuCqZhlEIVO5gP9H/o9ShfN1j22MyqgJwGp6p9VJpGaYVGG0w4
         48SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=KY4tQ5Rji0Sy6r3GCk5NFWQAsZtXKmIqzTH4rCY9Ycw=;
        b=oKIwut8UA+z5TUTt5B5gKR8UMw/djRVP4RUEBkNuDYy5LXjQ6UXKY9odgvhKVORcBz
         OWXj9kX5E7ZMTDCcX2ZtZ7dOyqXBd3OtiZopbarN1uRSGXIxA2WBHEeng7nmnE83BZvz
         epK0fVlbcFHYV4eUXZwEEZlQPfnji3johUBcxSoZFPM2da713IZePbEnYRo5sP7JpOJu
         QvymFl5AHHpwWLvhUKqHwDbrvF6kpeQHDZCZIyFt2sGbkXNLZDdOTzSW5C9Wu0bXEBV4
         HzNmgq2w+2tl8uBO6EIsm396GoG3ARdfueXMEGgG5FX2RqzXTq2aJZcQ96z08Lxr2AjH
         fR0w==
X-Gm-Message-State: AOAM5305l9MCeWvNXFKd1JpUnY04j25C2n/aYf0ttbExB3JhSER7JcGR
        U31UFYOI5nA/U2PDnlsMIWoZUvYmu/6IQg==
X-Google-Smtp-Source: ABdhPJxMQ+kzeDQj3taIGi0uqgZdRVIyG2193aHf6XL2xS/YhSSpqfucMl5uDmrTRGMbE+jvMos1+Q==
X-Received: by 2002:a50:fe01:: with SMTP id f1mr41018287edt.272.1619028143877;
        Wed, 21 Apr 2021 11:02:23 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g12sm96552edr.83.2021.04.21.11.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 11:02:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/5] test helpers: remove unused test-tool path-utils
 slice-tests
References: <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
 <patch-3.5-44948c6ace9-20210421T144921Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <patch-3.5-44948c6ace9-20210421T144921Z-avarab@gmail.com>
Date:   Wed, 21 Apr 2021 20:02:22 +0200
Message-ID: <87a6pr349d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 21 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This utility was last used in the code removed in 4c2c38e800f (ci:
> modification of main.yml to use cmake for vs-build job,
> 2020-06-26). Let's also remove this now-dead code.

This patch needs to be dropped, turns out it's used outside of t/ in
ci/, didn't think to grep for test helpers there. Will hold off on a
re-roll for a bit pending further feedback.

Junio, unless you'd like to have it sooner than later?
