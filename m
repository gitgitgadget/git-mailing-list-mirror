Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A3BC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 10:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiAMKGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 05:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiAMKGU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 05:06:20 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0054C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 02:06:19 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u25so21147689edf.1
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 02:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=b2NPcaq6EBzkHlXpyBwJWgbNifLMnM4iuSFpSAA6UL4=;
        b=IDmx0b7y+sPTB9nFFW5KfdvrPv9eRPROryTsh3gfWEOmvvouzHgBi1Km+KLpwz9wzl
         leRwBnJRyP7rnYGKaKN6ZHIwteqLrIpcF7QGS/h/M1ipJOki0lzbNVzRoFyZTLy3bKWQ
         brSycm7WPs4n319vqmurbPjnL+dJc98cCz9ofor/lgiV0foZAt6hIMBfN+/TfxLeeCfz
         bgpMcaR5n831WyX0XLsjwNKuo8tglQuKO8SlCcCanWOM5bMlI1MDieaGg6IZL6YvPSqQ
         JVn5mGeYHRn2L1xmy0jSmjHifVYZQNYazhQM4bDFw03mthxdRcbFyLOWSwARN2G/E9bn
         zqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=b2NPcaq6EBzkHlXpyBwJWgbNifLMnM4iuSFpSAA6UL4=;
        b=T98Y1HMSbNyQ670AXLS5VcgRc9DzJqzu3guuqRMMM0EC6SYbWdfhPfaUU2CdtM7R4m
         CYlW6fjIzGeXGSNH7gMpUmt2AF2qcxmAlXyVoKCO38owWU1PbBXfyifflfGy1QykpIEm
         /JrHB5H3gcBcfq/8sCquX8rPeRynmSNcvGNt/yb4Vkjs0FgR24+s4TuOwli3BZABcJD2
         J40fX7Umlxc3/dsoTo8xXkLfVaXQ5XvZBt2tw1G8la7QtJXznMFpoYVHBqRC5gIk06jE
         vnJgtM66MvaOov2LWB66EO+7IYhsJPCI6uyoiexQq4X9Org1STKEj48VbfKHZtuqsOIU
         PCdg==
X-Gm-Message-State: AOAM530Gf1WjLbdXqBdN/oeG4Mlpr0RzyYg/iRrN2N5dDokgaXJs6G6r
        Vbu1/c4YQL3Tu1L+k3orjkoLj+hLT2H/qg==
X-Google-Smtp-Source: ABdhPJx+dcKAb6tLzI7MfeoRY+WuhZCQLr68qCdHWpMlh/qPi8I4Zz/uw9njs7oFoJrW4HA5QmcYfA==
X-Received: by 2002:aa7:cdd6:: with SMTP id h22mr1025173edw.244.1642068378183;
        Thu, 13 Jan 2022 02:06:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g20sm954269edw.7.2022.01.13.02.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 02:06:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7wzp-000qxj-5a;
        Thu, 13 Jan 2022 11:06:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Han-Wen Nienhuys <hanwen@google.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] reftable tests: avoid "int" overflow, use "uint64_t"
Date:   Thu, 13 Jan 2022 11:04:07 +0100
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com>
 <Yd3aZ5Q9Ph0H+Ijn@nand.local>
 <CAFQ2z_M0Fjjx8tAd_cXqk9K9q43hwienEy=UsLJi2aW8G3sEwA@mail.gmail.com>
 <Yd3dao5Qh5yl/cBs@nand.local>
 <45baffd7-c9f3-cc52-47b4-ea0fee0182a8@kdbg.org>
 <Yd3mCVLyxkVTNcS9@nand.local>
 <e8e2c37d-39f1-0ae4-7894-07e85628a757@kdbg.org>
 <xmqqh7a8vkuq.fsf@gitster.g> <Yd8m2YeDZrgSiFzJ@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <Yd8m2YeDZrgSiFzJ@nand.local>
Message-ID: <220113.867db4vtk6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 12 2022, Taylor Blau wrote:

> On Wed, Jan 12, 2022 at 11:02:05AM -0800, Junio C Hamano wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>> > Am 11.01.22 um 21:18 schrieb Taylor Blau:
>> >> On Tue, Jan 11, 2022 at 09:08:46PM +0100, Johannes Sixt wrote:
>> >>> Am 11.01.22 um 20:41 schrieb Taylor Blau:
>> >>>> On Tue, Jan 11, 2022 at 08:31:47PM +0100, Han-Wen Nienhuys wrote:
>> >>>>> On Tue, Jan 11, 2022 at 8:28 PM Taylor Blau <me@ttaylorr.com> wrote:
>> >>>>>> In any case, you're only setting the lower half of `min` high. Maybe:
>> >>>>>>
>> >>>>>>     uint64_t min = ~0ul;
>> >>>>>
>> >>>>> yeah, that works.
>> >>>>
>> >>>> I'm pretty sure this is OK on 32-bit systems, too, but confirmation from
>> >>>> somebody more confident than I in this area would be welcome :).
>> >>>
>> >>> It does not work on Windows: unsigned long is 32 bits wide. You have to
>> >>> make it
>> >>>
>> >>>    uint64_t min = ~(uint64_t)0;
>> >>
>> >> Perfect; this is exactly what I was looking for. Thanks!
>>
>> That sounds perfect.
>>
>> > Actually, on second thought, UINT64_MAX would be even better.
>>
>> I wouldn't introduce use of UINT64_MAX, which "git grep" does not
>> produce any hits for.
>
>> Unless it is very early in a development cycle, that is, in which
>> case we have enough time to help platforms that are not quite POSIX.
>
> Yep, I agree that avoiding introducing the first instance of UINT64_MAX
> in our tree is worth doing (probably in general, but certainly now that
> we're past even -rc0).
>
> Either `~(uint64_t)0` or `UINTMAX_MAX` would be fine with me.

The reason I left it at 0xffffffff is because the current test clearly
doesn't care about using the maximum width of the type, and I was just
trying to get rid of the associated compiler warning.

So I'll leave it to Han-Wen to comment on if the "max" being the maximum
of the type is actually important here.

As far as what we'd pick to get the maximum type value goes, we should
just prefer whatever we use for that already in that codebase, and we've
got this in a related file there:
    
    reftable/generic.c:     struct reftable_log_record log = {
    reftable/generic.c-             .refname = (char *)name,
    reftable/generic.c-             .update_index = ~((uint64_t)0),
    reftable/generic.c-     };

(Which is what Johannes Sixt independently suggested upthread in
<45baffd7-c9f3-cc52-47b4-ea0fee0182a8@kdbg.org>).
