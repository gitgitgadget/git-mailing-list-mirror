Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ADEC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA35A610A0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhKSHc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 02:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhKSHc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 02:32:28 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698DDC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 23:29:27 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x15so38865876edv.1
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 23:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YPSA2MFk2Gn85ZYjb1uB5ZYzIHc5pS1yGe5fiI1mLic=;
        b=dvFxBl2fyiLv49bYHHrQ9nBBfzEF0tIj4/hmUPE6lo9zQEFJMDi360nIc+NlBp6dZN
         LcRZU3FiGE8agppEA5B7E3RkWHBK7giSiSAtu4WgXb7cE7nACUBb9XN95ByzNiKM00QO
         ywur6jDXcFg1iXq0pr9xu08lY7iT90KEUlzFBCAZMBcGn33+XEhtT4HgtzMTbYSLeID+
         fsfv6gHJpZYDtikL+2qoDqtgMXm63N/h2lyPXYRNI1RvVPuxBLg5FCrMsCxBw91ohTxx
         AR3llqPaD8jhSqCKYyDHrQhOYI/iBPkAHDlByyyqZLUPbHRCUMaEv1nyW+zV4tm22sCW
         TAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YPSA2MFk2Gn85ZYjb1uB5ZYzIHc5pS1yGe5fiI1mLic=;
        b=uUym9/4ZBkimC5DuBT2DXuDuzvh+lKtfEPAa1eN26u9Z5eS+7Gi00+77W0U6lKqRth
         UijiJveFQZE98KDBM/qNTGCTFZq00bksm6nsBpfFzStv/dvITq19rCO4vUHgCZgez4dY
         gs7bx0BaoBTDfBQ56u1MJNsOSTBmUB5PK+soATZ2TeLWdVZxf6Q3hLNkH44HBd5+7Axj
         eWNIxy22eIKLIXOy1guVNWBcKHEMo13gi+DudmKdimS9eowp7isOwzt9QPPqaP78y6jv
         wGziPerBf+KYXmmT5YU6bFnrHLd3HPlSFyVo1fF4X8PQ1lj30mIWNOisO2WQVGKICfZ1
         O9Sw==
X-Gm-Message-State: AOAM531t79yE7RWkXYLxW+pi3YP2m2MPcFVjSt8js2dCZ+AWR2B64KPz
        LsLx0vITNyG2NTOaXajVr04=
X-Google-Smtp-Source: ABdhPJwKO3nrz4FxEpZeRqtVFYcCmBMwZm1AqF23G9LLlBIOQ4/sipgCKupSqQh2HbMTbHOLFT3SsQ==
X-Received: by 2002:a05:6402:5194:: with SMTP id q20mr21285784edd.123.1637306965908;
        Thu, 18 Nov 2021 23:29:25 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u16sm808372ejy.16.2021.11.18.23.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:29:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnyKq-000aea-TK;
        Fri, 19 Nov 2021 08:29:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian@gitlab.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix parallel build race
Date:   Fri, 19 Nov 2021 08:08:11 +0100
References: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com>
 <YZR0djZbRUicXcQm@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2111180012470.21127@tvgsbejvaqbjf.bet>
 <211118.86tuga5o68.gmgdl@evledraar.gmail.com> <YZWqK38NRjD7aPOG@danh.dev>
 <nycvar.QRO.7.76.6.2111181529380.11028@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111181529380.11028@tvgsbejvaqbjf.bet>
Message-ID: <211119.86ee7c4n8r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 18 2021, Johannes Schindelin wrote:

> On Thu, 18 Nov 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
>
>> [Git's CMake-based build] couldn't be configured on Linux system,
>
> That was an explicit decision in
> https://lore.kernel.org/git/xmqq1rmcm6md.fsf@gitster.c.googlers.com/:
>
> 	Let's not worry about cross-platform and instead stick to Windows
> 	and nothing else for now to expedite the process.  As long as it
> 	is advertised as such, nobody would complain that it does not work
> 	on Linux or macOS.

That was said at a time when the CI didn't have a hard dependency on
this cmake integration, which as noted in the recent discussion
downthread of [1] made it so that for changes in this area you need to
maintain both the Makefile and contrib/buildsystems/CMakeLists.txt in
lockstep, least that CI is broken.

So we've created a scenario where in order to make certain changes to
git.git, you need to either go through a very painfully slow
edit/push/test cycle via the CI, with each test taking anywhere between
~5m-60m, depending on what step it might fail at. Or, install your own
copy of that proprietary OS locally.

In other areas we often don't have any hard line separating such
platform-specific code from the rest of the codebase. But for anything
else I can think of it's in its own files or ifdefs, and usually doesn't
require maintaining dual-implementations in lockstep, except if the
interface itself is changing.

Or that code is at least in a common language like C, Sh, Perl etc., and
doesn't require you to learn a new tool/language just for maintaining
the propriterary-specific portability code.

So I think it would be most welcome to get patches to
contrib/buildsystems/CMakeLists.txt to make it portable, cmake itself
is, and AFAICT the only inherently Windows-specific part of it is some
small part dealing with generating a file for VS to consume, which
presumably can be in some if/else construct within that file (I haven't
checked out Phillip Wood's portability patches).

1. https://lore.kernel.org/git/patch-1.1-bbacbed5c95-20211030T223011Z-avara=
b@gmail.com/
