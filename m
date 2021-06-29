Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5C6C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 22:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E937A61D7B
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 22:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhF2WNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 18:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbhF2WNg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 18:13:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89B3C061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 15:11:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hq39so539409ejc.5
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=79zAFFOSp8SOv8lGhQvZXjYicLOEy06aIWQYDkV8ldQ=;
        b=LHrjNdrtfIjJm5NjnCCc5R4MIDdvSgEEtxBU5Nb91ZHEVhOhYBUWWEzeZA6MnPAi2F
         D8YudnoXWL/0De5ikOwyCbgVyk+hUNcCotFZfODBg/V/MSJwVNqFvboKkGLniFC/ni0X
         GrBk9PfvzBjnBVFsrOQ09V4lVP7AwSIjx7SIAoxN8tjDQGABxqIYutFYS+5OWLkFgCii
         vx8R6Bhpn3u8sn91R2n/tqtx8gYvigEBJb+wzU+c0+1oV/szKeU76Xfgwxcp4JBdseMA
         Dq38pcx2W5Vbkq3Imn4QaKBgMHaICaHx6eBdJ9GklcydZWJ0aJOPvHnHULbPxhPBwJAf
         aavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=79zAFFOSp8SOv8lGhQvZXjYicLOEy06aIWQYDkV8ldQ=;
        b=mDkPEBfNhv5YMefJWD2iV4X78+FZBueuEfVEg2Cva0BqPcsRcXZieWheKZ/v9xgzFp
         jDfYf3F42YN3gwTc3bbcyUHr/g9bJzBqprxVUtVPHFIPul0VSxoYEvvNZCxPmeQ1IpGL
         pUF+dlNWJIwPy7skt3Hb2E6DDO1pBcxpWPc4JsGTZw3kRVKYQy5LGsY3Uh098j3h2jc/
         S4fFXLqGti3Rz/Gy5B772m6Jd70Skga8hk2HNujyZnQoVYKfvh0xz3xVnbrchl3Dk0UE
         V8nipcPHGKoFuDUX9uGFSTpxpoCVE5vs5KozCf27+NKjoTSRi4/08TXRZrUJDxR6v8jQ
         Nuew==
X-Gm-Message-State: AOAM532gzB84hkTZwQobEhPeSsIETAMvYAkZTuRllw4dawjgeM0jkfU/
        a4YVBEct0l26uG4DGi2gsuw=
X-Google-Smtp-Source: ABdhPJwvXsOVm8oSjm2JnKQQ5DOTNuud5T8gGyzQQ6pc13cuTMGnbbUoNrzMZdr247pfsycRM1Hvig==
X-Received: by 2002:a17:906:5d06:: with SMTP id g6mr32545776ejt.342.1625004667165;
        Tue, 29 Jun 2021 15:11:07 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ay17sm2440396ejb.80.2021.06.29.15.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 15:11:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] hook-list.h: add a generated list of hooks, like
 config-list.h
Date:   Wed, 30 Jun 2021 00:09:26 +0200
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210629T183325Z-avarab@gmail.com>
 <patch-3.3-ba7f01f4f6-20210629T183325Z-avarab@gmail.com>
 <76bd9738-65e8-3696-7934-8090b5912427@web.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <76bd9738-65e8-3696-7934-8090b5912427@web.de>
Message-ID: <87fsx0fhjb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 29 2021, Ren=C3=A9 Scharfe wrote:

> Am 29.06.21 um 20:54 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Make githooks(5) the source of truth for what hooks git supports, and
>> die hooks we don't know about in find_hook(). This ensures that the
>> documentation and the C code's idea about existing hooks doesn't
>> diverge.
>>
>> We still have Perl and Python code running its own hooks, but that'll
>> be addressed by Emily Shaffer's upcoming "git hook run" command.
>>
>> This resolves a long-standing TODO item in bugreport.c of there being
>> no centralized listing of hooks, and fixes a bug with the bugreport
>> listing only knowing about 1/4 of the p4 hooks. It didn't know about
>> the recent "reference-transaction" hook either.
>>
>> I have not been able to directly test the CMake change being made
>> here. Since 4c2c38e800 (ci: modification of main.yml to use cmake for
>> vs-build job, 2020-06-26) some of the Windows CI has a hard dependency
>> on CMake, this change works there, and is to my eyes an obviously
>> correct use of a pattern established in previous CMake changes,
>> namely:
>>
>>  - 061c2240b1 (Introduce CMake support for configuring Git,
>>     2020-06-12)
>>  - 709df95b78 (help: move list_config_help to builtin/help,
>>     2020-04-16)
>>  - 976aaedca0 (msvc: add a Makefile target to pre-generate the Visual
>>    Studio solution, 2019-07-29)
>>
>> The LC_ALL=3DC is needed because at least in my locale the dash ("-") is
>> ignored for the purposes of sorting, which results in a different
>> order. I'm not aware of anything in git that has a hard dependency on
>> the order, but e.g. the bugreport output would end up using whatever
>> locale was in effect when git was compiled.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>
> Please remove my sign-off line.  The code looks OK, but there are
> basically only trivial traces of my suggestion left.  That's fine, but
> it makes my sign-off unnecessary, and I cannot certify the origin of the
> rest of the patch.  You could turn it into a Helped-by or
> Contributions-by if you like.

Isn't that what the SOB is for though? I.e. a copyright audit trail, I
wouldn't have come up with that sed code myself, it's copied & adjusted
from your version.

I can re-roll with a Helped-by if you/Junio think that's appropriate, I
just thought this was /the/ use-case for SOB.
