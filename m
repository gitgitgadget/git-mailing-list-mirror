Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8198C433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiBLUs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:48:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiBLUs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:48:56 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E05606E5
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:48:52 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cf2so21314992edb.9
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NKhV39bWYSZt0ws1C8Na+lHv+7axTtvxOsM/FWfVbcI=;
        b=T6yldQ93MtC6EElYUGF0biEpTlsitXdS12GdH2JxLbz0UYMM2ut/rxw8F3XisGKFTI
         apUZpA4Jx3kxyxpnur1HEOB1kqYiCgev/71366hdEGtwDY0v4tWM1PZPmQm1jl22qfh9
         qN+AR4N7nkKKzMC3rbzgoCFnqOzebwlMhFgqXCu6zVVFlP/+3uBqJSMIMYZCV5QrUo6J
         upFcRkmtuMXiOhtvdE+x3bc9Ie3vT82Eaf0W3WKLkGbHmRIWCaNp617FPRwijhUcwGwd
         ZxN1YlS7FO9gHp+V1d06rptYWdNyhyETOgDKhPUaZVLMgiT7NOD58pgznp+zSVxA14bL
         4EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NKhV39bWYSZt0ws1C8Na+lHv+7axTtvxOsM/FWfVbcI=;
        b=7XDdcUGFWd3UKKO3bFD8yKFyJNn7v5s82lc5ALzmy0PgASDfuhHpIYzbl6byrCVNZO
         4+mCgUgWSznZIaBXzKlFA0XPHvfrXE2CeH9/UQXUOcOqBC7WTZGwtJKXJi0M6qCK5XKB
         6Mg32qTydAzz25vdZfiywhZSUKeRmFEDTjYHvOjwpld3pqeTgnMBHWp9ZN3FEVzhmPQE
         n48GQfuAqz1VgAsU9pSBIEWeponm4LPiS41BYToeSxFt8WJKa/0y6URr5tB5nd4mNYmB
         vnjt+sRXDu+CsGcuh+ATKWiDS3wx4rRPXtBWR49XeNheRYpyMIywhdK7iBCLetuHbaaB
         g0UQ==
X-Gm-Message-State: AOAM530p8HKCRGjpm7ILgFi0jRxS/zthXINJKMTRcDXj9iBNcoG+NM0s
        duP2QscDPb1Wu5gJz5rm9UY=
X-Google-Smtp-Source: ABdhPJw0xk8hf8E4ZJly+v2z5GqLC5efa8ssBD8Nc50YnMjwcIZZq7CQmJeVWWC4/mU3CDgmrZzECQ==
X-Received: by 2002:a50:bf4f:: with SMTP id g15mr8160661edk.362.1644698930611;
        Sat, 12 Feb 2022 12:48:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h26sm9146524eje.146.2022.02.12.12.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:48:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nIzK5-000Ulm-2e;
        Sat, 12 Feb 2022 21:48:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [v2.35.0 regression] some PCRE hangs under UTF-8 locale (was:
 [PATCH 1/2] grep/pcre2: use PCRE2_UTF even with ASCII patterns)
Date:   Sat, 12 Feb 2022 21:46:33 +0100
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
 <20220129172542.GB2581@szeder.dev>
 <dca59178-6e9b-315b-06ee-8e3201aa391c@web.de>
 <20220130090422.GA4769@szeder.dev>
 <b74f781c-548b-5254-d3d1-fc1873c70e10@web.de>
 <220131.868ruvbovo.gmgdl@evledraar.gmail.com>
 <1425e548-c1bb-3cff-d75d-c3760abb6129@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <1425e548-c1bb-3cff-d75d-c3760abb6129@web.de>
Message-ID: <220212.86zgmvx13i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 05 2022, Ren=C3=A9 Scharfe wrote:

> Am 31.01.22 um 22:01 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Sun, Jan 30 2022, Ren=C3=A9 Scharfe wrote:
>>
>>> Am 30.01.22 um 10:04 schrieb SZEDER G=C3=A1bor:
>>>> On Sun, Jan 30, 2022 at 08:55:02AM +0100, Ren=C3=A9 Scharfe wrote:
>>>>> e0c6029 (Fix inifinite loop when a single byte newline is searched in
>>>>> JIT., 2020-05-29) [1] sounds like it might have fixed it.  It's part =
of
>>>>> version 10.36.
>>>>
>>>> I saw this hang on two Ubuntu 20.04 based boxes, which predate that
>>>> fix you mention only by a month or two, and apparently the almost two
>>>> years since then was not enough for this fix to trickle down into
>>>> updated 20.04 pcre packages, because:
>>>>
>>>>> Do you still get the error when you disable JIT, i.e. when you use the
>>>>> pattern "(*NO_JIT)^\s" instead?
>>>>
>>>> No, with this pattern it works as expected.
>>>>
>>>> So is there a more convenient way to disable PCRE JIT in Git?  FWIW,
>>>> (non-git) 'grep -P' works with the same patterns.
>>>
>>> I don't know a better way.  We could do it automatically, though:
>>>
>>> --- >8 ---
>>> Subject: [PATCH] grep: disable JIT on PCRE2 before 10.36 to avoid endle=
ss loop
>>>
>>> Commit e0c6029 (Fix inifinite loop when a single byte newline is
>>> searched in JIT., 2020-05-29) of PCRE2 adds the following point to its
>>> ChangeLog for version 10.36:
>>>
>>>   2. Fix inifinite loop when a single byte newline is searched in JIT w=
hen
>>>   invalid utf8 mode is enabled.
>>>
>>> Avoid that bug on older versions (which are still reportedly found in
>>> the wild) by disabling the JIT when handling UTF-8.
>>>
>>> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>> ---
>>> Not sure how to test it.  Killing git grep after a second or so seems a
>>> bit clumsy.  timeout(1) from GNU coreutils at least allows doing that
>>> from the shell, but it's not a standard tool.  Perhaps we need a new
>>> test helper for that purpose?
>
> https://mywiki.wooledge.org/BashFAQ/068 offers a Perl-based Shell
> function or aborting a program if it takes too long:
>
>    doalarm() { perl -e 'alarm shift; exec @ARGV' -- "$@"; }
>
> It doesn't waste time when the program finishes faster and seems to work
> fine with git grep.
>
> I can't actually test the effectiveness of the patch because PCRE2's
> JIT doesn't work on my development machine at all (Apple M1), as I just
> discovered. :-/  While we know that disabling JIT helps, we didn't
> actually determine, yet, if e0c6029 (Fix inifinite loop when a single
> byte newline is searched in JIT., 2020-05-29) really fixes the "^\s"
> bug.
>
> So I have to abandon this patch, unfortunately.  Any volunteer to pick
> it up?

We can test it in CI, and have a proposed patch from Hamza Mahfooz to do
so. See
https://lore.kernel.org/git/211220.865yrjszg4.gmgdl@evledraar.gmail.com/

There's been some minor changes to the main.yml since then, but I think
you should be able to just pick that patch up, adjust it, apply whatever
changes you want to test on top, and push it to github.

