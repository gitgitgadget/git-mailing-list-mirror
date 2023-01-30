Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D555C54EAA
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 11:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbjA3LIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 06:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjA3LIg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 06:08:36 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BC87689
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 03:08:35 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id gr7so6012885ejb.5
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 03:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G8x4bC0Gj2zZwJghO/Eb2QwtadPZ89qhP/PMcmpyoyQ=;
        b=jMd6oRTY0T1xAgBcp8avBkmEld5nnGYCjpIR0VogKy24L/8jHZoaweW812CnGAndmY
         USaD5WelXzRlEsSeUcGhVVVo1tAHhfQEbuv1WHg4ErlVkc1noQzizz8Zh8gKYAF9+JLs
         mw4xdAA/KZmCI9POf37ebWIBLCC1KjMwLZg4NrNV/JGRC9ISO1UUZ6Ffu4tX0FmIIJP4
         71FFVaAVQjYL82HD09qHo+2c/OLd1eUwYSh5l9+BTNlC/oFWc0gd+0AR9yho5Xo7L1W2
         Co1gqd4Lq41PtN0tt4a9MkAZay5vdPimFOJekZT1ehe3ow7pZc+pZ2Z2nhcdlEnsEAbH
         CulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8x4bC0Gj2zZwJghO/Eb2QwtadPZ89qhP/PMcmpyoyQ=;
        b=gMjqjxzMXY5rr8go2hfsKh4IZOqftzDC3MvqqWnBiM6XfnyUBSFDBOFhmbCbZO5fDg
         s88lKUiIxpvrs/nuKt3ZHeih3TehcL7vlipUG4r0b/Zla6bbp5SLAhSVeMg8XQIss6Uu
         jETeB83aJu2FrYnPNAMBLqzKhpl2GAgIkJK1uNHr1fmwkWX6CiZB85vf/KPIK4HgXbOd
         EE9KxN6tmzoh5/6V28WT+XOu4kTsLn7rlI5FXHi/7XrMIoacTGw+doWSFOda2xVz21PT
         X0avr6QKV3RD+klE6H0D4QoAIF36+sSF6L/q4IiRxOZ6HxNK6Fr3UtzZSxY+j8tjn6u0
         sCgg==
X-Gm-Message-State: AO0yUKVEB/zzA2oVkJ83p6eKphox5iT28BnrcU+yq5f/VYySSw3TfHjG
        7Pc0QDO7wYgKIpyvINSmlYA=
X-Google-Smtp-Source: AK7set/jxVWasQosUVjr7+yFqKSwCr+fSjWmDRcWs5lTfTOSx+EaDzJ5NGUp4iT8y+g6lQ2BzCAzRQ==
X-Received: by 2002:a17:907:c245:b0:886:50d:be8d with SMTP id tj5-20020a170907c24500b00886050dbe8dmr6785488ejc.13.1675076913510;
        Mon, 30 Jan 2023 03:08:33 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709067e5600b0087276f66c6asm6669610ejr.115.2023.01.30.03.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 03:08:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pMS1Y-001k6r-0P;
        Mon, 30 Jan 2023 12:08:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mathias Krause <minipli@grsecurity.net>, git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
        allocation fails
Date:   Mon, 30 Jan 2023 11:56:42 +0100
References: <20221216121557.30714-1-minipli@grsecurity.net>
        <20230127154952.485913-1-minipli@grsecurity.net>
        <xmqqbkmk9bsn.fsf@gitster.g> <xmqq1qnfancf.fsf@gitster.g>
        <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
        <xmqqk0156z55.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqk0156z55.fsf@gitster.g>
Message-ID: <230130.867cx4s2j4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 29 2023, Junio C Hamano wrote:

> Mathias Krause <minipli@grsecurity.net> writes:
>
>> ... While we might be able to compile the pattern and run it in
>> interpreter mode, it'll likely have a *much* higher runtime.
>> ...
>> So this grep run eat up ~9.5 *hours* of CPU time. Do we really want to
>> fall back to something like this for the pathological cases? ...Yeah, I
>> don't think so either.
>
> You may not, but I do not agree with you at all.  The code should
> not outsmart the user in such a case.

It's the falling back in the nominal case that would be outsmarting the
user.

If I compile libpcre2 with JIT support I'm expecting Git to use that,
and not fall back in those cases where the JIT engine would give up.

> Even if the pattern the user came up with is impossible to grok for
> a working JIT compiler, and it might be hard to grok for the
> interpreter, what is the next step you recommend the user if you
> refuse to fall back on the interprete?  "Rewrite it to please the
> JIT compiler"?

I'd argue that it's pretty much impossible to unintentionally write such
pathological patterns, the edge cases where e.g. the JIT would run out
of resources v.s. the normal engine are a non-issue for any "normal"
use.

Pathological regexes are pretty much only interesting to anyone in the
context of DoS attacks where they're being used to cause intentional
slowdowns.

Here we're discussing an orthagonal case where the "JIT fails", but
rather than some pathological pattern it's because SELinux has made it
not work at runtime, and we're trying to tease the two cases apart.

> If that is the best pattern the user can produce to solve the
> problem at hand, being able to give the user an answer in 9 hours is
> much better than not being able to give anything at all.

Speed is a feature in itself, and in a lot of cases (e.g. user-supplied
patterns vulnerable to a DoS attack) continuing on the slow path is much
worse.

Even just using my terminal for ad-hoc "git grep", I'd *much* rather get
an early error about the pattern exceeding JIT resources than continuing
on the fallback path.

If I had somehow written one by accident (and this is stretching
credulity) you can usually apply some minor tweaks to the pattern, and
then execute it in seconds instead of minutes/hours.

> Maybe after waiting for 5 minutes, the user gets bored and ^C, or
> without killing it, open another terminal and try a different
> patern, and in 9 hours, perhaps comes up with an equivalent (or
> different but close enough) pattern that happens to run much faster,
> at which time the user may kill the original one.  In any of these
> cases, by refusing to run, the code is not doing any service to the
> user.

I don't think this is plausible at all per the above, and that we
shouldn't harm realistic use-cases to satisfy hypothetical ones.
