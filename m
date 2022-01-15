Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F900C433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 00:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiAOAuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiAOAuk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 19:50:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA76C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 16:50:39 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u21so39985998edd.5
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 16:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=XJeKo0VLvRR6YSpsYwmG+xx3aPUdWZjgtH7uWyRoz/I=;
        b=LqIWxqnPdOxo5fQoHcO+9gTZhu67QfGGIa66r5Y+x32vvYHSAKOLep1Wzv3BGfcbio
         9H+VsAzODZhcN3VAxymviPyyIgJmCEUbVTKS7ImQ+wD/y/oZKFDYRMJc0g0nFpTg/iCL
         j9xEFni5x4Be0bPe5gINBLrdQ/7U7vqH8jDkCwuAyTJuWesM4mLdSsdON48t5EBaCmhA
         2j6uHMPUt3tSklE7HacDZJmnQ6nunVMrzoCj5suXRfDNYEghnCO+gE95hNfbIX3nubVT
         xxJQk9iL88jdZCbjYmcDfjojbPiNzt5cuLFFi1cZG5j3nEZTmai+mzh710pTbSNTd0Gr
         HZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=XJeKo0VLvRR6YSpsYwmG+xx3aPUdWZjgtH7uWyRoz/I=;
        b=ukL5m6t0iOcIBP1AgoBOUNEVHajjlJqA6Wx7iLPDbrXmAEdIVW4eqfUI1bM5/zYeIt
         AElu0YC3Gbzi5zY9s3YHmP9mTVvy17n7x+w881ZpCIeTWBDCjqyadDATX7XVxmfww5Yt
         xtX+E4Vp5gTb1rmcpUEiItXVx8qBwRN47fzkPkIwovmtLxMnb008wGrY8dOa4PW6uNTF
         a5eups3xGDTjhfnth5UPK/GSUzIT6FpKuSDtAuIY4yXm+KIwsc+7i2l38czTQGdoJkAg
         TSUEbffyzy20y3PxWL9AjhMrndKlr+EDh491A2DT77LaOyW46NUI1TbztCVg59VndKBn
         MSSw==
X-Gm-Message-State: AOAM530Zrarzaz53Vy4C3DYO9AJQT6YP5qtnYhdHPZgFnsCnqUSzwILk
        5wOzJLgGlOuks7zUBBK00yI=
X-Google-Smtp-Source: ABdhPJxcELwlhXnnmz6iXzV+eG3yOahQ2zr+Ye+oXuMGh6Cn+NqWmjor0sCXju6y06ce+TBYtGUWAg==
X-Received: by 2002:aa7:cf8c:: with SMTP id z12mr3733616edx.93.1642207838400;
        Fri, 14 Jan 2022 16:50:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id kx8sm2168070ejc.126.2022.01.14.16.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 16:50:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8XHB-001ILf-DN;
        Sat, 15 Jan 2022 01:50:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
Date:   Sat, 15 Jan 2022 01:41:48 +0100
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
        <220115.86tue5rhlf.gmgdl@evledraar.gmail.com>
        <xmqqsftp7sca.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqsftp7sca.fsf@gitster.g>
Message-ID: <220115.86h7a5rfdu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Wasn't the initial goal here to check whether we'd accidentally include
>> C99? Just checking on GCC/Clang somewhere seems sufficient enough,
>
> What do you mean by "accidentally include"?
>
> The goal here is that developer build should give developer a set of
> options that help the most---"not going beyond C99" is something we
> want them to be checking, if able (and we have established that
> users on FreeBSD are not capable).

The reason we ended up with -std=3Dgnu99 is because of this thread where
Han-Wen accidentally used an unnamed structs/unions:
https://lore.kernel.org/git/xmqqlf0w5bbc.fsf@gitster.g/

He then pointed out that it would be nice if CI caught this, which would
have been sufficient:
https://lore.kernel.org/git/CAFQ2z_NuOy+-pfSoNAYjJhS9jZCYOfoFue10=3Dk=3DiyP=
VsPYrB3g@mail.gmail.com/

> Doesn't your "something like" limits the check to CI?  Developers
> with compilers that _can_ help ensuring that we do not go beyond C99
> should be able to do so by their local developer build.

Yes, I'm suggesting that what we're trying to catch here is rare enough
that that may be sufficient, and which would sidestep the issue of
wasting time on trying to make this portable everywhere.

The DEVELOPER=3D1 feature has recently gone from something I used on a
wide varity on of platforms and the worst I got was notices about
unknown -W flags in a couple of them, to something where recently due to
-fno-common and now more widely with -std=3Dgnu99 I've ended up having to
manually blacklist it on a few boxes where it Just Worked.

So maybe you think we absolutely need to spend the effort to run less
portable checks like that locally if at all possible, with all the
config.mak.uname etc. work that entails, if so OK.

I'm just suggesting that perhaps a more practical solution is to
side-step those portability issues by checking this in CI, which I think
would be Good Enough on this case.
