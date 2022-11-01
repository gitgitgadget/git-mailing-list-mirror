Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9E0C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKAWXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiKAWXB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:23:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEE21A824
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:22:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t25so40724750ejb.8
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TLc/D3XlQjG/XjT6lCyHxo/SNBii4z7LzrU/2QNFO4w=;
        b=TfNeDkV8hteNPoiniYbxp2Qh09a7tD75EGWRf6sFlZ6X4F4EWyBVTvM5N/cifM0UeJ
         9+etf3KIF64M9DJXqTw3tRMUHwoTZW2xFy3cP4dovK2fuD6yKCQ/hgmbK4Tl8M8sVW2E
         pBWGNxmY761sWr3i7r3KCUpASLLd6ss2Swmwp4e7Oll5Gli15m+Y1iQXavF1cEwjUA8S
         8DiVuC7E/3H9WlaJOFqtpq3VmLvwscPV9TUSQP8zO9x5spDXn/XoQj1cEbCLf+9uwtdZ
         YBYujMGcr2Xkp91ZQmna6hJG9H/28PTtxx/Blzuv3hpMrGMSDLMzM1Fcqlv6hGG0bJTT
         SNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLc/D3XlQjG/XjT6lCyHxo/SNBii4z7LzrU/2QNFO4w=;
        b=Wn9igqiQRSLL/O1sMDosU+cZuhakvahvcOHObdo7W9vnaA6OF33lYbk20YnquN77Am
         z9Gb3+jSEgsqfZAdbsDdEyvJma6B6kOXcIp8O0whXAkLm2XH+9X/zpao4HsQvL2EKHsd
         QoXORw7zGGKQRV1KKADQeCyym56x3eGKGEeUqfiVvbVy2x+9ia5q4cfOpPFGdT5OuKUV
         MUtphCAZgtz4f26Lw2Pcl7HtOi87PnAbibiOoSQoW4HJvE9Le7kTxffKDxaxaWKkbqrz
         87zPDWPB9Z2fFL8yfXkGm7LQAivS6+LvwIhSYCoRJpTrQnOHuTxPfctpGCfeEMXdjtfd
         VmkA==
X-Gm-Message-State: ACrzQf1VWbFiNKEYwzmfpxDXaKARlDXv80pDTwFQUaQw7eWaJ+5L+qzs
        MLNFNYZ4a9Cp4s0F3xHEQpmkyWKGazA+oA==
X-Google-Smtp-Source: AMsMyM77G19JlmOgi9AIetb6nbetEOn4/0FJBts5IHwcpbQuLxEe2mQw0XYj6hx0k4sH5FyML3Brrw==
X-Received: by 2002:a17:906:ccd1:b0:7ad:e22f:3ffc with SMTP id ot17-20020a170906ccd100b007ade22f3ffcmr9127773ejb.85.1667341375455;
        Tue, 01 Nov 2022 15:22:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090603d600b007a4e02e32ffsm4633081eja.60.2022.11.01.15.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:22:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opzeo-00Bb6W-1P;
        Tue, 01 Nov 2022 23:22:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Date:   Tue, 01 Nov 2022 23:17:42 +0100
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
        <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
        <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
        <221101.86a65b5q9q.gmgdl@evledraar.gmail.com>
        <Y2GHjnuyuwGpY3II@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2GHjnuyuwGpY3II@nand.local>
Message-ID: <221101.86y1su2u2p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 01 2022, Taylor Blau wrote:

> On Tue, Nov 01, 2022 at 04:01:18AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> > Yeah, I think it is crappy UX, too. It's just that I think the tests
>> > should not _asserting_ the bad behavior. At most, they should tolerate
>> > the bad behavior as a band-aid. So I think Dscho's patch is doing the
>> > right thing (and I do agree that we should fix the immediate CI pain by
>> > adjusting the tests, and letting the user-visible fix proceed
>> > independently).
>>
>> The tests aren't just asserting the bad behavior, they're also ensuring
>> that it doesn't get worse. 1 warning is ideal, 2-3 is bad, but
>> tolerable, but if we start emitting 500 of these it would be nice to
>> know.
>
> I admit that this kind of argument does not sway me.
>
> Is it likely that we would suddenly start spewing 500 such warnings? If
> we did, are there no other tests that would catch it? And even if *that*
> were the case, would nobody happen to notice it in the meantime either
> during development or when we queue an affected topic onto 'next' for
> wider testing?
>
> I guess the answer is that it's possible that we'd miss such a
> regression in all of those above places, but to me it seems extremely
> unlikely that we'd let such a regression through without noticing.

Literally 500? Probably not, that was hyperbole to make a point, but
several, low tens? Yeah, I know of at least a couple in-tree off the top
of my head.

The point, which I assumed was clear is that we literally wouldn't
notice if it were 500, and that sort of thing is a common pattern in our
tests. I.e. in most cases we'd ideally test_cmp known output (at least
to the extent of assuring ourselves that we're getting it right).

Instead we often just grep it, or don't test it at all. Sometimes for a
good reason (e.g. the output containing absolute paths), but more often
than not for no good reason.
