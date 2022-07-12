Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67050C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 09:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbiGLJ3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 05:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiGLJ3o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 05:29:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC52F8CC8D
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 02:29:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w12so8594155edd.13
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Bfzi3uhD9N6meuMqTv656Vnm29y4118hhdTn8rVQ+LM=;
        b=gDI+7bDPhuD39jU4QZ/QTGCVWQXrljb+libQRsalEshYLK3v0ctkZDrv02+aaEezS4
         NwWldcvRXIRafW9bBmoz9psO4ZDi7FgXe7sdhupCAi8Ygev1zP9qEj6O7hO2Lib5HmMJ
         RvFm4fg7XNDuNcpoqEabRECruPNfcT1R0WL3ar/TFJOCZEqZAtPc8IeMAEBnIDNM1qwQ
         5HoFcqUlAitfUZ3kKAt9kPPTf7khdsNEmLXzaa8bbCWmS2GBjqrHuQrhR/tK97RIS8I+
         LswF25oT/CMve1/Q3vfo7aVjqng2YUKn8vlJllc8hsd2zFLNHrjtWN1dWnA4Dmm+piHK
         xs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Bfzi3uhD9N6meuMqTv656Vnm29y4118hhdTn8rVQ+LM=;
        b=cXysOr9BMhIAq4ix/P6DvLziDCIVaD8YoRDF23K4LjdFIB0ykIokGALK33YMP7pS6V
         Kn5RZJTD77fUuHGfVGCoEn7OZHi3i++4GGc/Vr44KIcB1qmf/XOrvhHF1qvpFLMGrxxH
         BX0YXxu6HPOcLp2yKlCfnOJ3C+quCpz9e0OuyI78r4Rwg7KyXG4Sn0KcFhNVjBSzLstV
         9fbcZnl8m7brhLyLyZJScOMrhY58HYImNl4bMepZZ3qighFcsc3pqD4uR2iwRIRWMe3G
         9A0TSKDgO1UFi4GnGrGLc9aN80fT5AVsotCvvaZAWDbyHlvmJ50oKg6V+p+Z3ml1sqcR
         2Acg==
X-Gm-Message-State: AJIora+O+7Zc3g/dW9GgdUdLw4pmFjRg3fA2ci8wIJYlHBQlKWYaX+eu
        dVTh6PsHBrRU4hxJT5x7acctQpo4EApEOQ==
X-Google-Smtp-Source: AGRyM1sO07blWtWbIQBbwYBFWNA1GEVOmkdICrzEHknhcFvwuAgE1sBQTqu6koAyTl2DMGSPG8DOxg==
X-Received: by 2002:a05:6402:3707:b0:437:61f9:57a9 with SMTP id ek7-20020a056402370700b0043761f957a9mr30153676edb.1.1657618181322;
        Tue, 12 Jul 2022 02:29:41 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a15-20020a170906190f00b006f3ef214ddesm3573729eje.68.2022.07.12.02.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 02:29:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBCD5-001Dlc-82;
        Tue, 12 Jul 2022 11:29:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] unpack-objects: fix compilation warning/error due to
 missing braces
Date:   Tue, 12 Jul 2022 11:16:10 +0200
References: <20220710081135.74964-1-sunshine@sunshineco.com>
 <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
 <CAPig+cQJWgerk08j=1b=aWRZsKBu3BnEACQuiqktU4BwzM-xaA@mail.gmail.com>
 <xmqq7d4kp8l6.fsf@gitster.g>
 <CAPig+cQMJcUc4gpRDpR=Q8M44rTjUA7SWgXNmzrnDH7V12z0dQ@mail.gmail.com>
 <220712.86lesy6cri.gmgdl@evledraar.gmail.com>
 <CAPig+cSgNB=SzAZLhXvteSYmy0HvJh+qWHMYyBxcX_EA9__u4A@mail.gmail.com>
 <Ys0hhYjPExuNWynE@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Ys0hhYjPExuNWynE@coredump.intra.peff.net>
Message-ID: <220712.864jzm65mk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 12 2022, Jeff King wrote:

> On Tue, Jul 12, 2022 at 03:13:50AM -0400, Eric Sunshine wrote:
>
>> > Since this is only a warning, and only a practical issue with -Werror I
>> > wonder if a config.mak.dev change wouldn't be better, i.e. to provide a
>> > -Wno-missing-braces for this older clang version.
>> 
>> I'm in favor of this. It would, of course, require extra
>> special-casing for Apple's clang for which the version number bears no
>> resemblance to reality since Apple invents their own version numbers.

FWIW I was imagining just providing that -Wno-* on clang versions <= 11,
not special-casing Apple's in particular.

If you want to make it more strict you can always compare against the
uname, at this point in config.mak.dev we've already sourced
config.mak.uname, so you can guard this with "ifeq ($(uname_S),Darwin)".

Of course that doesn't tell you if it's Apple's clang, just "a clang on
Apple", but it should be close enough not to matter...

> I got PTSD reading that thread again, but in case anybody wants to dig
> into this, I think there are some hints from the last time we discussed
> this (starting at the end of this message and the subthread):
>
>   https://lore.kernel.org/git/YQ2LdvwEnZN9LUQn@coredump.intra.peff.net/

Oh yes, the config.mak.dev horror show :)

I have a local patches that carry forward the idea I had in that thread,
i.e. to drop all this version detection insanity and just compile a C
program to detect the compiler.

It takes a bit of doing in the Makefile, but I think the end result is
lovely compared to the status quo. We just do:

	$ head -n 2 config.mak.dev
	include .build/probe/compiler.mak
	include .build/probe/config-mak-dev.mak
	[The rest is all using existing defined variables, no shell magic]

Which is just made with a Makefile by piping this sort of thing to those
.build files:
	
	$ ./.build/probe/config-mak-dev 
	PROBE_COMPILER_NEEDS_std-eq-gnu99 = 1
	PROBE_COMPILER_HAS_Wtautological-constant-out-of-range-compare = 1
	PROBE_COMPILER_HAS_Wextra = 1
	PROBE_COMPILER_HAS_Wpedantic = 1

Which in turn is generated with stand-alone C programs in probe/, which
don't need any of the rest of git:
	
	$ cat probe/config-mak-dev.c
	
	#ifdef PROBE_STANDALONE
	#include <stdlib.h>
	#else
	#include "git-compat-util.h"
	#endif
	
	#include "probe/compiler.h"
	#ifdef __GLIBC__
	#include <gnu/libc-version.h>
	#endif
	
	int probe_config_mak_dev(probe_info_fn_t fn, void *util)
	{
	#ifdef __clang__
	#if __clang_major__ >= 7
		fn(util, "NEEDS_std-eq-gnu99", "1");
	#endif
	#ifndef __has_warning
	#error "Clang version too old to support __has_warning!"
	#endif
	#if __has_warning("-Wtautological-constant-out-of-range-compare")
		fn(util, "HAS_Wtautological-constant-out-of-range-compare", "1");
	#endif
	#if __has_warning("-Wextra")
		fn(util, "HAS_Wextra", "1");
	#endif
	#if __has_warning("-Wpedantic")
		fn(util, "HAS_Wpedantic", "1");
	#endif /* __clang__ */
	
	#elif defined(__GNUC__)
	#if __GNUC__ == 4
		fn(util, "NEEDS_Wno-uninitialized", "1");
	#endif
	#if __GNUC__ >= 5
		fn(util, "HAS_Wpedantic", "1");
	#if __GNUC__ >= 6
		fn(util, "NEEDS_std-eq-gnu99", "1");
		fn(util, "HAS_Wextra", "1");
	#if __GNUC__ >= 10
		fn(util, "HAS_Wno-pedantic-ms-format", "1");
	#endif /* >= 10 */
	#endif /* >= 6 */
	#endif /* >= 5 */
	
	#elif defined(__IBMC__)
	
	#else
		return -1;
	#endif
		return 0;
	}
	
	#ifdef PROBE_STANDALONE
	#include <stdio.h>
	#include "probe/print.h"
	
	int main(void)
	{
		struct probe_print_data data = {
			.prefix = "PROBE_COMPILER_",
		};
	
		if (probe_config_mak_dev(probe_print, &data) < 0)
			fprintf(stderr, "warning: unable to detect compiler type and version\n");
		return 0;
	}
	#endif

The compilation is then triggered by the include in config.mak.dev,
which has a corresponding rule that creates the C program, then the
generated *.mak, so once we do it once we're only ever including an
already generated text file.

It takes a bit of doing in the Makfile, since we need to e.g. declare
that "artifacts-tar", "check-docs" etc. don't want to build this C
program to "configure bootstrap" even if under DEVELOPER=1, i.e. we need
to know which target(s) we'll run to compile C code.

But that has the bonus benefit of making those faster, as now we'll
e.g. $(shell detect-compiler), generate the version info etc., only to
run "$(MAKE) -C Documentation/ ..." or whatever.

I can clean it up for submission if there's interest.
