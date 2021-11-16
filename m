Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DED8C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 13:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6403160EE0
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 13:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbhKPNF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 08:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhKPNF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 08:05:27 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFCDC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 05:02:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y12so30992586eda.12
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 05:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=QGl/LZSm3dgzJKDakG5lJVHZoXqM91MZUMJwjawbfUQ=;
        b=b0yNiFhJQDMfGMxwQWQkyWHQpvj3RbVFhEpqFJc1I45MNuVYUM+fXskUn4RkLCz8CV
         oX+i37MbdLAyOf5TUiGfVGtBZ7XCsiWdAlhspk0WGSs8p308gWDPbZuhXsIFLjovudvh
         WLFegGo+YgM6zNDpPhRwMIHNGNsQ4nzHHqkTVMMCK1QPf265vW3HPsIA8lql/ZYx8c3T
         L3eISPpc+oVej9IsRmuulJj2qR2EjkWO/ThHB2hZEe+21xBQyQMaoRzJKqOnHUa80Ajb
         0EwzMs19NdlS/Sw8d0fz4VhP2/DOwvDo3Al4Wq4AnT/i8IrO70CDmK7gec4BflN8BvkD
         k0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=QGl/LZSm3dgzJKDakG5lJVHZoXqM91MZUMJwjawbfUQ=;
        b=honRX1dugwTnOqavmaYVSgWNd6XvTSHRKIIwLHdRYOqBzOppgwEqS+CkiTw8wQcn9q
         3lXDtsXNglGnTrw9Uyb2X+OUEXCxecOKFnx7LKzlVmCHIQRAf9ePKw9JG1FilQvC8jls
         IkphzPFWY6TLJLP5k6USo7JI/8adEI2slO644pMriHvf3OgkhX2NvIxzRwFypbIERiFB
         sn1JkSi2DPH4pdiNM/kyFiFQrXQ3pCMcKz+0Hf5I807AsL9o8ix5wg4G6RDnL/180zL2
         cM5rg0UhOxDsNMzvXpJYuBCGKKMmt8s/lJO4TygCj4Y9YbfriUPU8jItOS6QPSeOtvAx
         0v/w==
X-Gm-Message-State: AOAM533mJCP/ssarqKX537g4IvlDG58y5nSQASY0GtYaj90sEkNOFCFt
        79zZ+Bokz+C2RHOK6v8Lc6s=
X-Google-Smtp-Source: ABdhPJxiOc4gOrnw13tnqo2IcRodEgvuEQXVU+6IXSwc+JYmfNpAStiOJ9E3rFrp0sgOWEGvEJwjcA==
X-Received: by 2002:a17:907:8a24:: with SMTP id sc36mr9375007ejc.530.1637067748961;
        Tue, 16 Nov 2021 05:02:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hw8sm8316561ejc.58.2021.11.16.05.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 05:02:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmy6V-001Plc-8D;
        Tue, 16 Nov 2021 14:02:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99 support
Date:   Tue, 16 Nov 2021 13:54:27 +0100
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-2-sandals@crustytoothpaste.net>
 <YZOh370ZMMqSADUE@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YZOh370ZMMqSADUE@coredump.intra.peff.net>
Message-ID: <211116.86pmr0p82k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Jeff King wrote:

> On Tue, Nov 16, 2021 at 02:12:41AM +0000, brian m. carlson wrote:
[...]
>> diff --git a/Makefile b/Makefile
>> index 12be39ac49..893d533d22 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1204,7 +1204,7 @@ endif
>>  # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
>>  # tweaked by config.* below as well as the command-line, both of
>>  # which'll override these defaults.
>> -CFLAGS = -g -O2 -Wall
>> +CFLAGS = -g -O2 -Wall -std=gnu99
>>  LDFLAGS =
>>  CC_LD_DYNPATH = -Wl,-rpath,
>>  BASIC_CFLAGS = -I.
>
> Do most compilers understand -std=gnu99? It seems like we're breaking
> the out-of-the-box build for everything that isn't gcc or clang.
>
> I understand that older versions of gcc (prior to 5.1.0, from my
> digging) default to gnu89, and so they would be broken _without_ this.
> So it is a tradeoff one way or the other. But somehow this seems
> backwards to me. We should assume that modern compilers support C99 out
> of the box, and put the burden on older ones to trigger C99 support in
> whatever non-portable way they need.
>
> I also checked clang, and it looks like it has defaulted to gnu11 since
> clang-7 (I'm not sure about clang-6; its documentation wasn't clear).

Yes, this seems like something we'd really want to feed to
"detect-compiler" after extracting it out of config.mak.dev.

And as you note it's not only that older or non-gcc non-clang compilers
may not understand this at all, but are we getting worse behavior on
modern versions of those two because they're forced into some 20 year
old C99 standard mode, instead of the current preferred default?

If we do go for this there's also the additional breakage I mentioned
upthread of th [1], and which I think I wasn't clear enough about. I.e. if we do:

    CFLAGS = -O2 -g -std=whatever

And then in config.mak.uname do e.g.:

    CFLAGS = -g -O0 -Winline

We'll override the -std=whatever, but just wanted to overrride the -O2.

This came up in another context recently (Carlo had series to hack in
this area), but I think we shouldn't add anything new to CFLAGS. Let's
instead add a new variable like BASIC_CFLAGS, so in this case
CFLAGS_C_STANDARD or whatever, and then later in the file:

    -ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
    +ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_C_STANDARD)

But IMO this whole thing of trying to make this work on every compiler
etc. just isn't worth it.

Let's just start using C99 features, and if anyone's compiler breaks on
something like CentOS 6 document that they'll need to tweak a flag
somewhere. We already know that works for all the other C99 features we
have, there seems to just be this one exception of the ancient GCC
version in this particular case.

1. https://lore.kernel.org/git/YZG9wF56unj7eYhl@camp.crustytoothpaste.net/
