Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C95BC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345390AbiARP1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiARP07 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:26:59 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC772C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:26:58 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id t24so81063899edi.8
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=93dCP5ENVTp01FD4UkAx+Lwzw359yRY+43LYkb56b4A=;
        b=eX+Nx83W7LTVt1CRRiLP4KJD5BIoeXnXbzXMzTHX18QV9XWQgWfzp5lM6HQ1VTJab5
         1GOj7WhAWIZNV+wVAyg58UOaXqxN5Q9ymxYkEPdYhZY6aKOwHH+Zyih/ms+6sTpPPcNt
         9PtAt7DVhvyFesVrkf4c4ucpxJXL8M7t10c2+UtkErfDztydxR5QZlGnvW4JlgXZIfCf
         yhRPV495tbvc4P06h+Mp5/WEUnCXJYn2Bnbb7aF1q2K+bTQVxquI8DVaaWfwfmR/rUnb
         pulNuSmmLf7r+nNdqq6jDMIpw1IL+vmoYgdAvT1QUDTZWgukAYXbM0D6nz0tR7J6znNt
         TJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=93dCP5ENVTp01FD4UkAx+Lwzw359yRY+43LYkb56b4A=;
        b=23S3u35DmLa6cKLU0scrcik9QwOajFGBowZiV5FvOa4FVZmTCC7UnsNPYPvi4Qdq8w
         7FCHWtDb/brFGtQgkpsR21IwLmHt+YVLawBv+pkhX6dk5xNZlut2WXmgvwxNcuKc9hIv
         I1fvzzvKDq7TY5uG8ME4JqwrhSAYL+wkSHgUSHXtX2MtLVQ+ASBVfX3siKuwnId8pGs+
         pPPEh2XzDmp9wg1DrucK1RA0Z+uxJbe/K7c+3UQ0Syu28lA3ntjQBlgAO4xZ0bMMHuql
         leEROTvW7k/KF2G737ZWu9zBIbcYT9wfNAtwPC7o4UIGP52021qUVisAGNZRV6L/WviT
         7FFw==
X-Gm-Message-State: AOAM531AaIdB7K+6OdD3WsLqcRbgzTLIuWWrSVtCTBP4e6AZTCQJ53ks
        QWc8YnV5pPPvf2t816zYTws=
X-Google-Smtp-Source: ABdhPJxO4VZGsSQ8m4OE8OfjWOm3kDWrAHloB3QjMxxKrye2ABiW/THZm7j2Z2KaEfMcBXCcH6GGnQ==
X-Received: by 2002:a17:906:5e4a:: with SMTP id b10mr240324eju.229.1642519617193;
        Tue, 18 Jan 2022 07:26:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qn25sm90977ejb.113.2022.01.18.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:26:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9qNr-001dPW-MH;
        Tue, 18 Jan 2022 16:26:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
Date:   Tue, 18 Jan 2022 16:17:02 +0100
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <xmqqlf0w5bbc.fsf@gitster.g>
        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
        <xmqq4k7j68eg.fsf@gitster.g>
        <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
        <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
        <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
        <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
        <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
        <xmqqilumayfh.fsf@gitster.g> <xmqqzgny7xo7.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201181308540.2121@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2201181308540.2121@tvgsbejvaqbjf.bet>
Message-ID: <220118.86iluhoyio.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Fri, 14 Jan 2022, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> >> I think we had this discussion about FreeBSD before and that's why I
>> >> specifically dropped that option from the main makefile.  We can either
>> >> drop that patch, or we can set it to -std=gnu11 and tell folks setting
>> >> DEVELOPER to use a system released in the last five years.  I think we
>> >> can be a little stricter with what we require in the case of DEVELOPER
>> >> than we might be otherwise.
>> >
>> > But that is not being stricter, but looser, no?  I thought that the
>> > point of -std=gnu99 was to allow us to use C99 features while catching
>> > use of language features newer than that, and use of -std=gnu11 will
>> > defeat half the point, wouldn't it?
>>
>> If FreeBSD (or any other platform) cannot do "reject features beyond
>> C99", I am perfectly OK to drop -std=gnu99 on such a place.
>>
>> DEVELOPER=YesPlease ought to be a collection of settings that helps
>> the developers the most.  So on platforms that *can* do "reject
>> features beyond C99", I prefer to have it enabled when
>> DEVELOPER=YesPlease is given.
>>
>> It seems that -std=gnu99 is only added conditionally even in today's
>> config.mak.dev, so it is fine if we dropped -std=gnu99 from there.
>> Which means that developers on FreeBSD cannot participate in vetting
>> use of features beyond C99, but there are developers on other
>> platforms who will, so it's not too bad, I would say.
>
> Plus, we have CI runs that do help us, thanks to setting `DEVELOPER=1`
> (see https://github.com/git/git/blob/v2.35.0-rc1/ci/lib.sh#L154).
>
>> As config.mak.dev is included after config.mak.uname, something like
>> this may be sufficient, perhaps?
>>
>>  config.mak.dev | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git i/config.mak.dev w/config.mak.dev
>> index d4afac6b51..3deb076d5e 100644
>> --- i/config.mak.dev
>> +++ w/config.mak.dev
>> @@ -20,9 +20,14 @@ endif
>>  endif
>>  endif
>>
>> +ifneq ($(uname_S),FreeBSD)
>>  ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang7,$(COMPILER_FEATURES))),)
>>  DEVELOPER_CFLAGS += -std=gnu99
>>  endif
>> +else
>> +# FreeBSD cannot limit to C99 because its system headers unconditionally
>> +# rely on C11 features.
>> +endif
>>
>>  DEVELOPER_CFLAGS += -Wdeclaration-after-statement
>>  DEVELOPER_CFLAGS += -Wformat-security
>>
>
> I applied this patch on top of the current tip of `seen`, opened a PR at
> https://github.com/gitgitgadget/git/pull/1116. The corresponding FreeBSD
> run is here: https://cirrus-ci.com/task/5867558132776960, and it
> succeeded.
>
> In addition, I concur that this is the best we can do, and I really would
> like to have that patch as soon as possible because it confuses new
> contributors when their PR builds fail out of no mistake of their own.

I just submitted a more narrow fix in the side-thread[1]. I've tested it
on the FreeBSD 13.0 box I have access to, but perhaps you'd like to test
it too?

> Please count this as a vote for including this patch in -rc2.

I'd like to have it too, but for context needing to add NO_UNCOMPRESS2=Y
(which Junio's punted on for the final[2]) is a much more widespread
issue of needing new post-install build tweaking than this issue that
only affects developer builds on FreeBSD.

What makes that FreeBSD run a part of the GGG CI? Another and more
narrow workaround for that in particular is to have whatever's driving
it add -Wno-c11-extensions to the CFLAGS.

1. https://lore.kernel.org/git/patch-1.1-06cc12be94d-20220118T151234Z-avarab@gmail.com/
2. https://lore.kernel.org/git/patch-1.1-9cea01a1395-20220117T170457Z-avarab@gmail.com/
