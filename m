Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4098C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 22:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhLTWHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 17:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhLTWHK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 17:07:10 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD964C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 14:07:09 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z29so43997095edl.7
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 14:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZpYQ8vNtSfw2nmwFdP/1baUJMPLThdPjQviWjZw6zyE=;
        b=ODM5c7KVITeC/Rj4qiUGmnj+vVvvy4IKf87F8yQqHtXgn+eUP6D1GomfLZOIMGWfRZ
         8lGxH2rsFgQ/WjEMnPnBCFQUHdxw7JnNqzxLfGPBFA/BBVFqc3NjhWiJXLn1474bYhMi
         +k6DZUUEEIA6W2a2hVKt2TienNnAe+ALTwvqXhPIEFrKxVLmhS4EFQPH67enk1+jRUDV
         GFMDSxU+R5/HTBAiSmDXSIdQdwtQUT2VbQxBencWMP2M+v2RN2ZBNHs7xKiYXuSdPSeM
         PyFNaIJpNLLO2jVyrDDytUKfGPI8a+te+3LREMsypYRA+DGRwlgLVG0qCWfYam9fAlQ3
         lm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZpYQ8vNtSfw2nmwFdP/1baUJMPLThdPjQviWjZw6zyE=;
        b=rVlpuEgmaqD4kX3ojgj6mzfD80Y+mKvOuH8vF1tqBZKJXbex1VRH8PfXXarKZz3U2u
         70pRSCU4XAfc0HOUTHTboSVEPVkWOTV6+b6+sF7uModzx5JRtSGLXHfn3pmBruT1nFgR
         DVZFVaI9TBy8Uxfms752sjsajkncbMr/TFm2qwoJ8lC4dTRnFebuPr3MXDSCS1BhHiF0
         CKlwzsnt/Jq05TR9lLjGIHG1WwYZ32sTfAYGko9S9X8Xx7yk4jZ1U5mqEnHpZMg8RBVJ
         FigxAHb0ZnXhispdEWCWxQ+52rdgcm36hjr6sDmZfhJOBgNVkCXLpzT4ND3v18tk/IjZ
         1pLg==
X-Gm-Message-State: AOAM530TpjzeoXDjEYpnrq8W36ci8sHAdiRdeU7am43qmFCnfmBVMAao
        J39BSnu6tCIXr6CPggVhijQ=
X-Google-Smtp-Source: ABdhPJwF3RDLJcQavfxr8hy/m3aDGo+ldvzmvK38oYsALaM9wrUrglYRleilljql3LN2YPtPzOdq1A==
X-Received: by 2002:a50:9dc1:: with SMTP id l1mr145841edk.231.1640038028401;
        Mon, 20 Dec 2021 14:07:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 12sm5704827eja.187.2021.12.20.14.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 14:07:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzQoF-000ZTC-5n;
        Mon, 20 Dec 2021 23:07:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel?= =?utf-8?Q?=C3=B3n?= 
        <carenas@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] grep/pcre2: factor out literal variable
Date:   Mon, 20 Dec 2021 23:03:55 +0100
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
 <ba503995-866d-fc80-4e38-b4dfd0e5c5bc@web.de>
 <211219.86o85cwfje.gmgdl@evledraar.gmail.com> <xmqqr1a7uhgk.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr1a7uhgk.fsf@gitster.g>
Message-ID: <211220.865yrjszg4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I think for this and 1/2 it would be really nice to pick up a version of
>> Hamza's CI changes:
>> https://lore.kernel.org/git/20211118084143.279174-2-someguy@effective-li=
ght.com/
>
> Are there so many incompatible versions of pcre2 library whose usage
> are subtly different that we need to protect ourselves with multiple
> variants in CI from breakages?
>
> I doubt pcre2 library was _that_ bad.

It's really not, but:

 * We have an optional >=3D10.34 feature we use (albeit trivial)
 * We have an optional >=3D10.36 feature we use (major, and directly relate=
d)
 * We might be targeting JIT or not, and the error handling isn't the same =
(known PCRE caveat)
 * We might be targeting a PCRE that knows about Unicode, or not
 * We use it in a mode where we might feed UTF-8 invalid data into the UTF-=
8 mode

Any update to the relevant code really needs to test the combination of
those, so it's a perfect target for CI to make that less tedious.

> Adding a special task that builds with the minimum version we
> support may not be too bad, but the library should be stable enough
> to allow us to declare it sufficient to test the most common version
> with the most common build options in our ordinary build job(s).

That's a nice idea, but not the reality of the situation. Unless we're
willing to bump the version requirement & insist on JIT && Unicode
support before using it.

The CI itself should be realtively cheap, and just runs the few tests
that would spot any breakages with the above.
