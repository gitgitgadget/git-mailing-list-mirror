Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BACEC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 12:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbiANMFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 07:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiANMFL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 07:05:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37031C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 04:05:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c71so34175886edf.6
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 04:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wH82IW6QL8xRV/B6a/PlS4SVOUptWW5ChKM29G2dR38=;
        b=EwrVQuku/klmuSCxqPWUTv/h4YNxevY9r6nLr5O5/ommE/92gU2X1ZbX9Yx0nL3fHG
         D+coJOlIA09/kNVE3wHZe7aQqs/Q5NJBwjG06W0IxWkMkWr4Cn7kspqvD6jiUnkH5+hf
         /ZO/DOp582gLxTXXd3eaIhyvNjozraVHk1DkhcWtT9K01pIkEA2J1xthYS3GZ9o4uDye
         KLjXHjDi2+FysDP66rg8NBkE0pyhno37prb+uZCpf0p7wln8ov0IQhb+uy9tiBUXw+bL
         PHesYgKUXyGalfZD4kmD1WjYAWAZ/PGOWfKLT2PGBAxrjcRWag7/djfc3jj/BWI55kxw
         9jqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wH82IW6QL8xRV/B6a/PlS4SVOUptWW5ChKM29G2dR38=;
        b=6jRkY3NOzvU0PKN9UUNks/urU1UwI8J/ZP9kmig11+uxoGAjrnRWygkYzDqR/pWVmq
         HT1eijyeyLdGAwBy5z14jehKV2wfLDHdHArgpvrScb1xfYaT3whOEBzYZr/KA+u4z9Ft
         uQLYxMgvpIWpM/9OZi54uKkbHqWf+QTn+/azJY9mNeRECsFoQARtFVru9m/qo1tuVDUv
         0wVi9AGr60dSJ+29/1VM1odQmIwc7I/s7/uTn6JfiWiGX+8VSmXHdL9I1flFG7gHiXUl
         7sXfYnx9iSOEel58tjEqz5wEoVb2CySlItwLondyJNkgj5hGYMxVvJHor0RUaTYvJ8RA
         y5Iw==
X-Gm-Message-State: AOAM5316cFueOs/MqPeM2LgBLuht6wID0WAh8sF3WNkNCfMlbTafmvhk
        VNMcNCZfwXzT1JR/XuG6jeE=
X-Google-Smtp-Source: ABdhPJwlCzaRbi4QPKCgDaufFr3UwsDlzlPV3TIvsKICzutLSIaxLJ1vNk5MTrJycv9x/XL5Nz2pZQ==
X-Received: by 2002:a17:906:4790:: with SMTP id cw16mr7044660ejc.701.1642161909609;
        Fri, 14 Jan 2022 04:05:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d14sm2313746edu.57.2022.01.14.04.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 04:05:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8LKJ-0015JS-2u;
        Fri, 14 Jan 2022 13:05:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression (was: [PATCH] config.mak.dev:
 specify -std=gnu99 for gcc/clang)
Date:   Fri, 14 Jan 2022 13:01:06 +0100
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <xmqqlf0w5bbc.fsf@gitster.g> <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
 <xmqq4k7j68eg.fsf@gitster.g> <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
 <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
 <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
 <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
 <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
Message-ID: <220114.86a6fytte9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-01-13 at 10:45:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> [I'm aware that Jeff probably won't read this in his sabbatical, just
>> replying to the relevant thread]
>>=20
>> Something neither of us considered at the time, but which is pretty
>> obvious in retrospect, is that this new -std=3Dgnu99 dosen't only apply =
to
>> our own code, but any system and library includes that we need.
>>=20
>> Thus e.g. FreeBSD 13.0 which previously was happy to compile under
>> DEVELOPER=3D1 will now die because its core libraries use C11-specific
>> code:
>>=20=20=20=20=20
>>     archive.c:337:35: error: '_Generic' is a C11 extension [-Werror,-Wc1=
1-extensions]
>>                     strbuf_addstr(&path_in_archive, basename(path));
>>                                                     ^
>>     /usr/include/libgen.h:61:21: note: expanded from macro 'basename'
>>     #define basename(x)     __generic(x, const char *, __old_basename, b=
asename)(x)
>>                             ^
>>     /usr/include/sys/cdefs.h:325:2: note: expanded from macro '__generic'
>>             _Generic(expr, t: yes, default: no)
>>             ^
>
> I think we had this discussion about FreeBSD before and that's why I
> specifically dropped that option from the main makefile.  We can either
> drop that patch, or we can set it to -std=3Dgnu11 and tell folks setting
> DEVELOPER to use a system released in the last five years.  I think we
> can be a little stricter with what we require in the case of DEVELOPER
> than we might be otherwise.

I guess, yeah.

As a practical matter the changes in this cycle have made DEVELOPER=3D1
much more fragile as a cross-platform facility. I test on various
platforms/OS's (across the GCC farm), and before this cycle only AIX and
Solaris were something I had to pay special attention to.

Now we've got things like this breaking (by default) non-obscure things
like FreeBSD.

Of course I can manually set -Wall etc. which is what I previously got
out of this, but before e.g. pedantic was opt-in, now an effective
C-version-a-pedantic is the default, and doesn't have a tweaking knob at
all.

Anyway, we'll see how much of a hassle it is, and it's not too painful
for me right now, so I don't think anything needs to be done in the RC
period.

But I wonder if the X-Y problem we're trying to solve is making sure we
don't move past C99 unintentionally whether this wouldn't be better
solved by dropping this -std=3Dgnu99 approach in the Makefile, and instead
just do that in one of the CI jobs (whose OS includes would be known to
be C99-OK).

