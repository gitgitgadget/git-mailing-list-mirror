Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA0BC433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 00:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350381AbiASAPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347584AbiASAPa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 19:15:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF3C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:15:29 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q25so2995978edb.2
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TvAN0ICX7jGIhyguU4QQbrVHo/HJ9UOU5B0VdzBIQds=;
        b=blfHRHHuq+CNpwZAvJ3q2F+Vflzkq49sFi6/aBE1NRV2Do71W0Hc9UHEgwEJaROc/Z
         oNDPZcPGm7fe5m6mc2j5uidFZ9Hk3KJC+uAW5Y1z+S68JOUiV1LgFvvZxK4HMdaoqnde
         7/as9Hhd8APbdi86DOYEcHNogkxPq/3nhQ5daV7sMWS7/gqfjJGqkG3wDAoHOGXHAQg7
         J5aiHywyG3eZDeCupoPGsmToMlxEgW0/UJd4L/TcHW7fx13cD1JACHflT/GflK4x4dp/
         M9i6ORNYpD56LC9f/HAWMP+9Nujk3kbrw5gC044YWAfrOtJWQ+bC7rzTN+U4NqrgfeSe
         Y3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TvAN0ICX7jGIhyguU4QQbrVHo/HJ9UOU5B0VdzBIQds=;
        b=RtcnlBSpwjOtOBFAVN601RjkHdsA8aYovn6OVjM0+W7+F59yin56PO3FMRRjJWr4Wv
         FNhI7RtDSi6bcEExypCpYxObs+wNzzvMYCay02YyLA5zFNhkaLVdvK6jdLEboPWEfR49
         rMlRVMfMZIrTz1qwA7ONTxu9/N5lu1H/6Oy4CMNVksYDTJLm7y0SBUk5QF93HERHyEzo
         O4p5cgPnqrWHj0jUWhTemtVITngZdN7EEMuaEMlc73d6XyN32EVNG39DdpjezkHKBwyR
         vEY1S1dDMahSbPkNL/hfv8BNtvrfRf573pC1GVAyFSb7ZGsFPRPHyawHBuzrDXEZZPqd
         dF9w==
X-Gm-Message-State: AOAM532E6tz5cs/cDNRIBKespDLEaC6KmhnQO4W7nfzj4vJzSBc5LMOp
        mVL3FVXrYiS4xZhubPdX8HA=
X-Google-Smtp-Source: ABdhPJzv+KSUcVDfDcDEMFQXkyULmDB/OZxoM9MmPluHmcA7Cp7s+dmPaflOx31HujTX78spQsAeKA==
X-Received: by 2002:a17:907:2d11:: with SMTP id gs17mr22957782ejc.198.1642551327665;
        Tue, 18 Jan 2022 16:15:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y2sm457061eda.45.2022.01.18.16.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 16:15:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9ydI-001gM8-Sv;
        Wed, 19 Jan 2022 01:15:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH] Makefile: FreeBSD cannot do C99-or-below build
Date:   Wed, 19 Jan 2022 00:36:21 +0100
References: <xmqq4k7j68eg.fsf@gitster.g>
 <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
 <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
 <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
 <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
 <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net> <xmqqilumayfh.fsf@gitster.g>
 <xmqqzgny7xo7.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2201181308540.2121@tvgsbejvaqbjf.bet>
 <xmqq1r15szpg.fsf_-_@gitster.g>
 <20220118214720.GA8652@neerajsi-x1.localdomain>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220118214720.GA8652@neerajsi-x1.localdomain>
Message-ID: <220119.861r14pomb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Neeraj Singh wrote:

> The approach of building with C11 on FreeBSD is a good one
> compared to trying to hack around the headers.

The "hack around the headers" suggests that you've seen my
alternate[1]....

> It appears more like a compiler bug that's being worked around
> here. The FreeBSD header supposedly uses a GCC extension if the
> C standard version is less than C11.  See: 
> https://github.com/freebsd/freebsd-src/blob/1e7b5f950b2d54ddb257d008592563c4d753aa54/sys/sys/cdefs.h#L317

...which discusses how the line you're linking to here and
__has_extension() interact, it's not a compiler bug, unless I'm missing
something.

I.e. it's just a FreeBSD include asking the compiler the wrong question
and/or not suppressing the warning (e.g. via "#pragma clang
system_header").

> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>

Accidentally addition?

1. https://lore.kernel.org/git/patch-1.1-06cc12be94d-20220118T151234Z-avarab@gmail.com/
