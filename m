Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1C8C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 03:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiLGD5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 22:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGD53 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 22:57:29 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1598151C19
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 19:57:29 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s5so23117056edc.12
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 19:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O+5PWymU0RQ0BE2LHyjR8bfAWwvPRRE9kuVXG5F5oyQ=;
        b=pgjB+ovhSj9RmU/hXRrHHV9DSzjvPpsz/2jhXCdzV2o5xRTzD+EBMIjr9fycjzftrU
         0k6Q1E3gygQudrzpz2au8kks3VNzr4FKW5XCrqGui55jRt7WjiCQ+ah0iY774AmKiC7S
         X0VL4G1iGOWInyiPt/pLEsW+oHqafGBJAhh4hUvxfeMcmoRXT6TX+JFYtSpaUWlv6jQ4
         NFwwqSn5q5HC5Y6Ffoh6lG7zn6qEvxMN7knRzNoLnpoETkd4ff2emD5OesQp+50Qs7Yy
         JJE2mmIWPIKVczDQtiS0+tAW6Rap76g7D9QVjKqAGabiGdUEEbNF2Pn0jhOKRO+t8B36
         251Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+5PWymU0RQ0BE2LHyjR8bfAWwvPRRE9kuVXG5F5oyQ=;
        b=4sPar1n4c9QvPC6EhIJKFmd9wDNwZ8qnxl8awJm718+HoMpo6G2xE5TdirVyi1kz2S
         JxWc0lZ15HokAaKGZL/XvpTcEBel4FJa7E8yEHgOOnTQtF2lj8vWLE2npRp+pPKjNa0C
         rrsbAbRQUihTkQv5zFPb2JCguK0NTsCuqtBhFiZAesu4TYUoqcZJyFwZViJcez0EyQRg
         lhxblt/ExgQTOZKpGfwtRhoRtt9utxzbPcJxyvguAkYzEMuuTFEqTswqw+e57jjcw4PO
         oFxWb3T1+2s0Gu+oHmQioN3BSgLpz7u4bC5RQPFKG0dxziR85xCXtIlDk4uKdob0iTYW
         9MIg==
X-Gm-Message-State: ANoB5pnMk7sx2lZ6jEazzd8IXmpuXOT7wHi203fN1CUcJJfmU9O0cF+I
        Ev19hgiHEvQbyJahfk9tvlDEvN5O01w6TQ==
X-Google-Smtp-Source: AA0mqf4QM9Wof849FDrwI1I1tUNIylDsndApWNqFjG69DSUX4+/QyoF7xPSMGnorGYUS4bVfsKGOEw==
X-Received: by 2002:aa7:d4ce:0:b0:46c:d2b3:3e41 with SMTP id t14-20020aa7d4ce000000b0046cd2b33e41mr8722782edr.396.1670385447463;
        Tue, 06 Dec 2022 19:57:27 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id k17-20020aa7c051000000b0046bd3b366f9sm1693427edo.32.2022.12.06.19.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 19:57:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2lYk-004JGE-1t;
        Wed, 07 Dec 2022 04:57:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Date:   Wed, 07 Dec 2022 04:51:04 +0100
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
 <Y45yaYV3xFB/xR2G@nand.local> <Y46eVnYrcOGAbUhi@coredump.intra.peff.net>
 <Y4/6eDxUeSLYss/a@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y4/6eDxUeSLYss/a@nand.local>
Message-ID: <221207.867cz3c1cp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, Taylor Blau wrote:

> On Mon, Dec 05, 2022 at 08:43:50PM -0500, Jeff King wrote:
>> On Mon, Dec 05, 2022 at 05:36:25PM -0500, Taylor Blau wrote:
>>
>> > On Mon, Dec 05, 2022 at 10:01:11PM +0100, Ren=C3=A9 Scharfe wrote:
>> > > This rule would turn this code:
>> > >
>> > > 	struct foo *bar =3D xcalloc(1, sizeof(*bar));
>> > > 	int i;
>> > >
>> > > ... into:
>> > >
>> > > 	struct foo *bar;
>> > > 	CALLOC(bar);
>> > > 	int i;
>> > >
>> > > ... which violates the coding guideline to not mix declarations and
>> > > statements (-Wdeclaration-after-statement).
>> >
>> > Yeah, I was wondering about this myself when I wrote this part of the
>> > Coccinelle patch.
>> >
>> > Is there an intelligent way to tell it to put the first statement after
>> > all declarations? I couldn't find anything after a quick scan of the
>> > documentation nor our own patches.
>>
>> It feels like generating the code as above is not the end of the world.
>> The most valuable thing that coccinelle is doing here is _finding_ the
>> location, and telling you "it's supposed to be like this". It is great
>> when the "this" post-image is perfect and doesn't need further tweaking.
>
> I have to agree. If Coccinelle can generate the right output; great. But
> if it can't, the amount of additional work to reorganize an already
> generated and mostly correct *.patch from the tool seems minimal by
> comparison.

It can, but you need to write your semantic patch to match your
intent. If you write e.g.:

	- int x;
        + int y;
        + foo();

That means "add the int y and foo() line right after that "int x" line
you removed.

Whereas what you want in this case is closer to:

 - match the "int x" line
 - remove or amend it
 - skip past all subsequent declarations
 - skip past all code that isn't referring to the "x variable?
 - insert the "CALLOC_ARRAY" (or whatever) before that first "x" use.

I don't know offhand how to match this, but presumably it's some mixture
of the wildcard syntax ("...", "<... ...>" etc.) and matching a
"statement", or maybe marking the "int x" with the "@pos" syntax, and
referring to that position again.

I usually just browse through the coccinelle.git for *.cocci examples
and/or read the PDF (*not* the manual page, which discusses almost none
of the syntax) documentation.

See:

	git grep -F '...' -- contrib/coccinelle=20

For some in-tree use of this, the unused.cocci I added recently is
probably the closest equivalent to what you'll want.


