Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0146C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60B36146D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhCDAWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhCCLqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 06:46:17 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F19C061223
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 03:45:23 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id bd6so16271501edb.10
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 03:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QQQRpYRRAuEGeZUcgtSOIjru+14cZtcwXnwFavEgy6g=;
        b=RoTMtdPbCUA4HPeKGOpCcO167zz8uxNelpZASCK6QRmYOvZC67H6MOUYq+u/QlypNf
         1HvNOQa+Tg+bG2lpcPK7R09dYbMtJH6s1zRV93UR8L5nlIye0TztSmdVfpF2w+3UuHOu
         usb1vlNki05Cy0H6NkQ8r6GzRbKzU+ytF5DUmjI6VqUxvfY/CuxpuIRjIODywmmdCe2d
         GAlexUoIYqxRVEI9Q/gW0CPhOoMdwJfCjqG8xfwG8IiU6YstzrtGIPybxqCCcnUMztzL
         IGdUaXCUI6rZ1NRca0Fttt8Vly2tfiXkKE50GYWgmz1vrp8YXlo2v2Pup84oW9cHt15E
         x41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=QQQRpYRRAuEGeZUcgtSOIjru+14cZtcwXnwFavEgy6g=;
        b=Rm1zB0WWhLRJMxqe4BGrq9fx8+aPGOGAlfSmX4IxFxL+MazlHL3j4I85SC7lu2gJBy
         FlKwvLeEtQhU+337vkk3zq1QpVEyZyI9updzBIEkR/3RgNDVh7983JU22nC0As1+ePGD
         dLtdZofSmvkTuzEZ4Ic1oLncDFAeSovBfKdsitjoC1ufw89AEKs2Ik65mDOTAcFDUQ7T
         fTVdWuICcG2NRRat1/iFFCoPi+7L5hwnrO/vjCxSXdn6u/33/55FUnuJ54X611HOoa02
         LRm0lvMwnh5K6Q+5RPfYa1G6ozjzYJMuwNIGzT0r1zsYqGZ+FYdb96cgTT+FI+2dC0v+
         BrsQ==
X-Gm-Message-State: AOAM530bPDVjW+7BSuQtXTX7L7yoKd8lCkJNtO1k2xSzDd16TEJstvF8
        DbIdty1wWoXKfaksiDkU7y3ynE5CPJ2Htw==
X-Google-Smtp-Source: ABdhPJwM3KhpzIb0UHUWYOoZHFOeRXW6WEcMXrd3RkRW3h3HFquqi+xRt/t+U6WzpBftkHdteSZMqg==
X-Received: by 2002:aa7:c410:: with SMTP id j16mr24525796edq.135.1614771921858;
        Wed, 03 Mar 2021 03:45:21 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o4sm21641884ejj.45.2021.03.03.03.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 03:45:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: fix bugs in coccicheck and speed it up
References: <20190506234334.GA13296@sigill.intra.peff.net>
 <20210302205103.12230-1-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210302205103.12230-1-avarab@gmail.com>
Date:   Wed, 03 Mar 2021 12:45:20 +0100
Message-ID: <87a6rkjwa7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

A few notes, for a probable re-roll sometime later:

> I've often wondered why "make coccicheck" takes so long. This change
> speeds it up by ~2x and makes it use much less memory. Or a reduction
> of a max of around ~2GB per-process (under the old
> SPATCH_BATCH_SIZE=3D0) to around ~200MB.

I've also tested this with e.g. "strace -c -f -e trace=3Dopenat ",
before/after with just contrib/coccinelle/swap.cocci.patch:

    192612
    13106

Grepping e.g. for strbuf.h shows that when running "make coccicheck" we
open it 12 times as expected (we have 12 rules)

    strace -f -e trace=3Dopenat make -j8 coccicheck 2>&1|grep 'openat.*"str=
buf\.h"' | wc -l
    12

(Is there a more direct way to filter this type of thing with strace?)

Before:

    $ strace -f -e trace=3Dopenat make -j8 coccicheck 2>&1|grep 'openat.*"s=
trbuf\.h"' | wc -l
    137

> [...]
> I'm also the whole "cat $@.log" introduced in [3]. Since we don't call
> this in a loop anymore (and xargs will early-exit) we can just rely on
> standard V=3D1 for debugging issues.

Noticed by Denton in the side-thread, should be:

    I'm also removing the whole "cat $@.log" feature introduced in...

> +		xargs \
> +			-n 32 $(SPATCH_XARGS_FLAGS) \

As an aside this relies on xargs not barfing on "xargs -n 1 -n 2",
i.e. taking 2 over 1. I tested it on Linux/AIX/OpenBSD/Solaris, works
consistently on all of them.
