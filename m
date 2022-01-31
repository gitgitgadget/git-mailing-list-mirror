Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE30C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 21:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379423AbiAaVCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiAaVCG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 16:02:06 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C284C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:02:06 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id n10so29366399edv.2
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=cJTdgune4iekUfD+HUMg8H3eqN/HTgrzJCm65/CcmHQ=;
        b=fwcfTmvJ2AcQTYJi4C7kaoFCP+h9HrnjrnlIJacdMX7fiqnNctfSDn1Tpo5IJyvPv/
         g5m+YS+xWkR1Y4ZN9cqNq3N+Ma47m3ac6PfhyNW2hBWFcHrEhIDwb/E9lbWHdAN3EPei
         v5ls2LnK08CzEJ/R3K9HLqsId9reSGfkwDGoPWsGC9fWRF1A4dKt4KEjxESdMvs2+mWc
         qa+iFJjqVDKFf12fvDRnvvQwu6K3zOVbUgtbV439GaOQ5YqWEAp0mMk293ZmcxzpvyLf
         +SSwqG5+DdAwEbk2fcwUtAvy/37FIZaxX0G/EMPecHzV8UQUwFEmirHdZBjmsb9DGw6k
         oJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=cJTdgune4iekUfD+HUMg8H3eqN/HTgrzJCm65/CcmHQ=;
        b=z1AQ+3pFdpbAWq+aj7RZWzxelpxI3MJMQYMmEp4hadMOS3zwUxmikNAlInf6V9QdcJ
         JoadkPgmXf6cijz6WwHmvbOOBZEz6CKiKO4ptim3eAFjlvxKn3n820Hh1NkO116eqeiS
         Un38a8SUp33LcMQpfjZNGt7xrHoZKtRwdQ4HaUZjrmf4uV3Lm0f613xLo70U0eAMBKG0
         PX5mNEHwT0tyJXb5ZVioWBOGtcDrPHYtiu4nXcG/XCIAgD7n08QBSwpYbFVDCGYdYHKm
         NjaB4EX9dNTmdhplXpqEhxETPU5gfYHtwkJmVKVud4ODqbJtCJ64W9XiE170TiT6t3lc
         2PTQ==
X-Gm-Message-State: AOAM5337rjQDNHb6j1HPX4XHz8LIiURAOHvU/IJKgbDg75figFk+dFzw
        Pj7hfTcbR33ihVoCQusPa+w=
X-Google-Smtp-Source: ABdhPJx3BzVY6xrk5wMX8DF4xoNzZnVWVzxmJ3FlFyqrGjjRPodn0DajtmrdrQSN+y/imRJYq2+nwA==
X-Received: by 2002:a05:6402:1705:: with SMTP id y5mr22181411edu.200.1643662924599;
        Mon, 31 Jan 2022 13:02:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d26sm18298704edy.92.2022.01.31.13.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:02:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nEdoJ-003s9o-I7;
        Mon, 31 Jan 2022 22:02:03 +0100
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
Date:   Mon, 31 Jan 2022 22:01:12 +0100
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
 <20220129172542.GB2581@szeder.dev>
 <dca59178-6e9b-315b-06ee-8e3201aa391c@web.de>
 <20220130090422.GA4769@szeder.dev>
 <b74f781c-548b-5254-d3d1-fc1873c70e10@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <b74f781c-548b-5254-d3d1-fc1873c70e10@web.de>
Message-ID: <220131.868ruvbovo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 30 2022, Ren=C3=A9 Scharfe wrote:

> Am 30.01.22 um 10:04 schrieb SZEDER G=C3=A1bor:
>> On Sun, Jan 30, 2022 at 08:55:02AM +0100, Ren=C3=A9 Scharfe wrote:
>>> e0c6029 (Fix inifinite loop when a single byte newline is searched in
>>> JIT., 2020-05-29) [1] sounds like it might have fixed it.  It's part of
>>> version 10.36.
>>
>> I saw this hang on two Ubuntu 20.04 based boxes, which predate that
>> fix you mention only by a month or two, and apparently the almost two
>> years since then was not enough for this fix to trickle down into
>> updated 20.04 pcre packages, because:
>>
>>> Do you still get the error when you disable JIT, i.e. when you use the
>>> pattern "(*NO_JIT)^\s" instead?
>>
>> No, with this pattern it works as expected.
>>
>> So is there a more convenient way to disable PCRE JIT in Git?  FWIW,
>> (non-git) 'grep -P' works with the same patterns.
>
> I don't know a better way.  We could do it automatically, though:
>
> --- >8 ---
> Subject: [PATCH] grep: disable JIT on PCRE2 before 10.36 to avoid endless=
 loop
>
> Commit e0c6029 (Fix inifinite loop when a single byte newline is
> searched in JIT., 2020-05-29) of PCRE2 adds the following point to its
> ChangeLog for version 10.36:
>
>   2. Fix inifinite loop when a single byte newline is searched in JIT when
>   invalid utf8 mode is enabled.
>
> Avoid that bug on older versions (which are still reportedly found in
> the wild) by disabling the JIT when handling UTF-8.
>
> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Not sure how to test it.  Killing git grep after a second or so seems a
> bit clumsy.  timeout(1) from GNU coreutils at least allows doing that
> from the shell, but it's not a standard tool.  Perhaps we need a new
> test helper for that purpose?
>
>  grep.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/grep.c b/grep.c
> index 7bb0360869..16629a2301 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -406,6 +406,14 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  	}
>
>  	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
> +#ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
> +	/*
> +	 * Work around the bug fixed by e0c6029 (Fix inifinite loop when a

Better to quote this as PhilipHazel/pcre2@e0c6029 or something, i.e. to
indicate that it's not git.git's commit.

> +	 * single byte newline is searched in JIT., 2020-05-29).
> +	 */
> +	if (options & PCRE2_MATCH_INVALID_UTF)
> +		p->pcre2_jit_on =3D 0;

It seems rather heavy-hande, but I can't think of a better way to deal
with this, i.e. if we selectively use JIT on older versions, surely we
run into the match-bytes-but-want-chars bug you were fixing.

> +#endif
>  	if (p->pcre2_jit_on) {
>  		jitret =3D pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
>  		if (jitret)

