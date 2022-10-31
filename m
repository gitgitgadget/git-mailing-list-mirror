Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2299FA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 15:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiJaPaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 11:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiJaPaU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 11:30:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E202BE9
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 08:30:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x2so17998860edd.2
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kSkjA6roJ9WhTTtskIDnFOrFjjoFTVFtsCWl7t52JUg=;
        b=FNv4oT0fziw0PTehWPMRHGAqLPv6Tn1Tcjj8dVNDOMt3bwCwTZ+GcTEe/KL3uu07G+
         xpp4ES1ZWYWRuxISresxS2Ar6leAp18IIpQrdrMG61iw7iR7L7FErSE0y5TiIwy+q8GJ
         1s+Smm5Uvu0XFEeX8w3q8eX7DhlleRSkIXQii2+bF8o72t/PV6nboG+mZNynFs5rm1T3
         3Yws/YDGGy9fzNAUWU62u4F1+9cyoXBvY4fFywhxl6X0B39Pewst0KAVMAMDUfXIs5OL
         YzdNbw041LC80RUbwYE06q5ADz3rAq5nWppZrNK/YBulhvomFLEDZ/blkjY7m7rKtq78
         0/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSkjA6roJ9WhTTtskIDnFOrFjjoFTVFtsCWl7t52JUg=;
        b=wlJh25uKxIEd/DiN7X5SW4F127l1gr2cLwJS/U+0RX8cj8hRMb7VzSyuuZjYKJQy+L
         myZkBtBA7aY7SfJPO4LgaJ8Cvbo1p3VAeaScATuiqZCfywCjfNarm7WuAwh21HrlaWzp
         5iGYgEbgTYwRvmTP338z5Q+ySW3D8EB88DYUWrsWMvkn7gtSYo9Wky4FeztJV3Dajbnz
         6LLhvv67K6tybCOnRnDPEzPzUvv6rC23z/hKAqBcGpMCIW9uTniusttPqlsvnlzHDloF
         gab2gF/9nWypFQCWIMKUzMcH3HLgtrvgs5NMmYZslKfPaqBCkea5zx0tp22um9tguVUX
         HZbw==
X-Gm-Message-State: ACrzQf26RKbc79dSgVyi3mlcocYJuuKmFGozF74qfhphCdsM06zJHJVf
        NkFEm5ZFPGSTvR+yD80t7/Y=
X-Google-Smtp-Source: AMsMyM54G/xV/YYJiHEmg+9qbXtLL/oeOQvbCRJONKIyPsNiGC4y5/p+loH0HIWqkeBL/QiFf7Mw8Q==
X-Received: by 2002:a05:6402:3645:b0:45f:e918:9f35 with SMTP id em5-20020a056402364500b0045fe9189f35mr13862951edb.118.1667230216369;
        Mon, 31 Oct 2022 08:30:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b007a1d4944d45sm3129359ejh.142.2022.10.31.08.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:30:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opWjv-00Ag66-1D;
        Mon, 31 Oct 2022 16:30:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/12] run-command: remove run_command_v_*()
Date:   Mon, 31 Oct 2022 14:35:01 +0100
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
 <c14503ea-0b76-464a-02d5-0b001a462083@web.de>
 <Y1685tnqts37KHnm@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y1685tnqts37KHnm@nand.local>
Message-ID: <221031.86leow6mew.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 30 2022, Taylor Blau wrote:

> On Sun, Oct 30, 2022 at 12:58:13PM +0100, Ren=C3=A9 Scharfe wrote:
>> > Changes since v1:
>> > - Do the return value fix earlier; it was only an afterthought before.
>> >   Keep the colon (no "while at it, ...").
>> > - Break out the xstrdup(), oid_to_hex_r() and C99 cleanups.
>> > - Convert tricky string arrays before strvecs because =C3=86var didn't=
 like
>> >   the opposite order.
>> > - Extend the example code in tmp-objdir.h so it still only requires
>> >   "cmd".
>>
>> Forgot one:
>> - Fix grammar error in run-command.h added by the series in a comment
>>   that goes away at the end.
>>
>> Ren=C3=A9
>
> Thanks, replaced. This round is looking good to me, though let's hear
> from =C3=86Var before we start merging this down.

This LGTM. I don't think any of these are worth a re-roll, but just to
clarify in reply to the comment in the v2 CL:

 * I thought the C99-specific stuff, free() etc. might be worth
   splitting out[1], but not to the extent of churning through first
   moving the existing API use around, and then converting it to
   run_command().

   I.e. v1 had e.g. the am.c change as part of the large 3/8. Here
   there's 3/12, and we then re-visit that same caller in 12/12.

   I think that part of the v2 was better in v1. I.e. maybe split them
   out, but to the extent that it needs special explanation we could
   have just done it in one go with some explanation..

 * I suggested just squashing what's now the v2's 08-11/12 into the
   respective commits that represented the last API user, or if they're
   worth splitting out do split-out with that last API user converted
   (and also removing the run-commit.h flags that went unused then, if
   applicable).

Anyway, LGTM, and the stuff that was odd in the end state (e.g. 02/12)
is now fixed. Thanks both!

https://lore.kernel.org/git/Y11%2F2hyApN5NLruq@nand.local/T/#md2b7af02b1af3=
4fa118779d3e1f4444604f95cb9
