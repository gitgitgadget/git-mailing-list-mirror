Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8DECCA488
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiFHA1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457175AbiFGXV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:21:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD293E2E90
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 14:25:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bg6so17904538ejb.0
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=F23PxGxlIiVaxoSnfPUqGWQHe1ZZW6/lNT6fiwj+Wak=;
        b=FiaZek2plekyQkytyZvv4FE+6BUJwpNak5Hm4zApLERgMbZ69lYQDoAUBVpE4xkGQw
         5ccS5PskcLdTmk8gnvYPH2buEWNKEl691qtHp0KaVXVqlC++f1a/WsgMaMD3ncEHGsNM
         y7/XiDpLjBXWJhXBcjuBwR37Ya0fypkG+DG+k8q7/VsbDoX/P/cKdNDek2HFHaRxkmk+
         XFvIxkhuJokmPf+ig7xBEhA2e5SqXUaGJ1KcHoipd5XXgDRMc6ZKY/JgrUqDgB7J3PlV
         G/wxYW2ZopMFNXKcK10MgrqcV+KkGSWpgfdRmIVAgOYTQZD8eEhzkx6evSxDZTRKY8aF
         tvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=F23PxGxlIiVaxoSnfPUqGWQHe1ZZW6/lNT6fiwj+Wak=;
        b=IkuZPSpLBenN+R1y4zxJ65Vcg9QK67n3uBakIYwpsgKAoFSg1hF86cPH18KTLPHZWU
         PB9eADitEL8s8cAfZuTSWXWJFIOJSzYKf/o3yLvpp5LlebOIE0jBgpqePlIqcoPmnkpm
         KMvuV37F3bMaXho/NnowM1x2uU7hiTMzPWQK/pS6TMdS5I86FF09JjKoL4jrz+s0vxzp
         5m1yJArPuZd/ko5SVRzkLiW1UDdHWc4pzPbEuLYWWT/V9gaQZ5ZPXw7N6n7KjzeDpb5k
         bSDydZ/iuqk02tcChiyrugAE3isfDra38DhjgGpjC/9v0aQa+7kOzqQfVhjjz3fpcwwV
         Zv1g==
X-Gm-Message-State: AOAM530YRfAt/7NH8SiPR3+kOByU+mQx3ePrNAMPBnpH2ISRdroEMY6+
        7worixAeTFzuelOHj057EXyOmsM+rd4pXg==
X-Google-Smtp-Source: ABdhPJxjyhTdCfAtHc4J3LjLFyNUPp3nD6/wF2sHe/F5MC9gjASTzBX9LlrZ40ITPlSKip/s4tGO6A==
X-Received: by 2002:a17:907:8a17:b0:711:e3fe:7767 with SMTP id sc23-20020a1709078a1700b00711e3fe7767mr3795206ejc.380.1654637142490;
        Tue, 07 Jun 2022 14:25:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906124400b007105a157706sm5246431eja.82.2022.06.07.14.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:25:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nyghn-002fSb-Nh;
        Tue, 07 Jun 2022 23:25:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 1/6] common-main.o: move non-trace2 exit() behavior
 out of trace2.c
Date:   Tue, 07 Jun 2022 23:12:17 +0200
References: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
 <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
 <patch-v3-1.6-9c4f8d840e9-20220602T122106Z-avarab@gmail.com>
 <Yp+wjCPhqieTku3X@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yp+wjCPhqieTku3X@google.com>
Message-ID: <220607.8635ggupws.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 07 2022, Josh Steadmon wrote:

> On 2022.06.02 14:25, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change the exit() wrapper added in ee4512ed481 (trace2: create new
>> combined trace facility, 2019-02-22) so that we'll split up the trace2
>> logging concerns from wanting to wrap the "exit()" function itself for
>> other purposes.
>>=20
>> This makes more sense structurally, as we won't seem to conflate
>> non-trace2 behavior with the trace2 code. I'd previously added an
>> explanation for this in 368b5843158 (common-main.c: call exit(), don't
>> return, 2021-12-07), that comment is being adjusted here.
>>=20
>> Now the only thing we'll do if we're not using trace2 is to truncate
>> the "code" argument to the lowest 8 bits.
>>=20
>> We only need to do that truncation on non-POSIX systems, but in
>> ee4512ed481 that "if defined(__MINGW32__)" code added in
>> 47e3de0e796 (MinGW: truncate exit()'s argument to lowest 8 bits,
>> 2009-07-05) was made to run everywhere. It might be good for clarify
>> to narrow that down by an "ifdef" again, but I'm not certain that in
>> the interim we haven't had some other non-POSIX systems rely the
>> behavior. On a POSIX system taking the lowest 8 bits is implicit, see
>> exit(3)[1] and wait(2)[2]. Let's leave a comment about that instead.
>>=20
>> 1. https://man7.org/linux/man-pages/man3/exit.3.html
>> 2. https://man7.org/linux/man-pages/man2/wait.2.html
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  common-main.c     | 20 ++++++++++++++++----
>>  git-compat-util.h |  4 ++--
>>  trace2.c          |  8 ++------
>>  trace2.h          |  8 +-------
>>  4 files changed, 21 insertions(+), 19 deletions(-)
>
> Just realized that this unexpectedly breaks the fuzzer builds:
>
> $ git checkout ab/bug-if-bug
> $ make CC=3Dclang CXX=3Dclang++ \
>    CFLAGS=3D"-fsanitize=3Dfuzzer-no-link,address" \
>    LIB_FUZZING_ENGINE=3D"-fsanitize=3Dfuzzer" \
>    fuzz-all
>
> [...]
>     LINK fuzz-pack-headers
>     LINK fuzz-pack-idx
> /usr/bin/ld: archive.o: in function `parse_archive_args':
> archive.c:(.text.parse_archive_args[parse_archive_args]+0x2cb8): undefine=
d reference to `common_exit'
> [...]

Hrm, that's a pain, sorry about that.

> The issue is that we don't link the fuzzers against common-main.o
> because the fuzzing engine provides its own main(). Would it be too much
> of a pain to move this out to a new common-exit.c file?

I could do that, I actually did that in a WIP copy, but figured it was
too much boilerplate to pass the list.

But why it is that we can't just link to common-main.o? Yeah the linker
error, but we already depend on modern clang here, so can't we just use
-Wl,--allow-multiple-definition?

This works for me with my local clang & GNU ld:=20

    make CC=3Dclang CXX=3Dclang++ \
	CFLAGS=3D"-fsanitize=3Dfuzzer-no-link,address" \
        FUZZ_CXXFLAGS=3D"-fsanitize=3Dfuzzer-no-link,address -Wl,--allow-mu=
ltiple-definition" \
	LIB_FUZZING_ENGINE=3D"common-main.o -fsanitize=3Dfuzzer" fuzz-all

It seems to me that the $(FUZZ_PROGRAMS) rule is mostly trying to work
around that by size, i.e. re-declaring most of $(OBJECTS).

But maybe it's a no-go for some reason, maybe due to OSX ld?

