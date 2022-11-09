Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A600FC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 00:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiKJAFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 19:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKJAFc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 19:05:32 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605FE12D27
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 16:05:31 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id y14so998054ejd.9
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 16:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TOC7bDA+m3gA4MHLahmApRJATpeeZjfycfYS2Hwqlto=;
        b=OlV0EgK/54BrU/OYQBj5fgGezsLITPVbZDtbBl2yUGnaBpLG0Xxm330DkTrDx6StyV
         UZHg5GYCao6dkiIu9fs2IcYXBc/DBMmCmVO+g5T30KiMq4mU8Pc19wTJO+DkTh/OZplb
         bHA25JGW4AadnuKrnWHCzEcwqOqyaXCyAaP+scMHhMEFDLdBQnlWAbyWgXg8ab7jOK9/
         FKRvGbHsYcrg4Iu4H7gxAxyqfqFql5Prgz+2kXBMX9fjmNRiTWyUt7q2329FNW9HvhoI
         xJO80zVaFrt2CIU1Xq+h2huAP6Ja16NPkZp8draigegZaH1VjRGhULw3yI7mV33D7jtq
         S/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TOC7bDA+m3gA4MHLahmApRJATpeeZjfycfYS2Hwqlto=;
        b=RhLZBc0DBpETFBP15/eJIPESrZsM1CukModNkmXS1AnxRIrj0597VxKGE0kgGy1tdu
         yLrkWVEqEf8uc1nougynYQewBCwQjLrYB16I9bSYJyn4iQw88CPjIBi/uUphHIpOLkve
         Etdjg/H1qAz95/r/YI+S5T06Kte3hCMkiLaz192CKPzB6A2rr/HyL88YqfHDwylqwnBv
         qUkb9xiWV1EClchO69+Ce0mXrFxeEZJZWDPhOEJJWOv2hTSYe+cjdcmnWFzPRIWMlDe9
         7kEpsdxtY6+U5E05KTVIqU0HEnGWPYsEtzKs4SOn1/9zeCZs/8VOtQdaA/n+6o9qDmFs
         Hmgw==
X-Gm-Message-State: ACrzQf3ENSEmHa1Lytk/hpsAWMJdvOZF8ZUEJZxbg3ivVgXtUtNj6fP3
        /AFU6WhyPmyuVJ2mxhW2hzTwBfgj8fXuHQ==
X-Google-Smtp-Source: AMsMyM6/V9owNT9dQTKb4Gj8MJE00RNGXpzNCmN9/JLRNZf8aE23x+koMMpx3SKfZovYS6HQipB8Og==
X-Received: by 2002:a17:907:168e:b0:7a1:6786:f16 with SMTP id hc14-20020a170907168e00b007a167860f16mr58757123ejc.590.1668038729826;
        Wed, 09 Nov 2022 16:05:29 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id s18-20020aa7c552000000b00461c1804cdasm7657334edr.3.2022.11.09.16.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:05:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osv4T-001CmV-07;
        Thu, 10 Nov 2022 01:05:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7610: fix flaky timeout issue, don't clone from
 example.com
Date:   Thu, 10 Nov 2022 00:55:30 +0100
References: <patch-1.1-83eca7b5a7c-20221105T115420Z-avarab@gmail.com>
 <Y2wuEDGMRg99Ifef@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2wuEDGMRg99Ifef@nand.local>
Message-ID: <221110.864jv7ptbq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 09 2022, Taylor Blau wrote:

> On Sat, Nov 05, 2022 at 12:54:21PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> The behavior of "-N" here might be surprising to some, since it's
>> explained as "[if you use -N we] don=E2=80=99t fetch new objects from the
>> remote site". But (perhaps counter-intuitively) it's only talking
>> about if it needs to do so via "git fetch". In this case we'll end up
>> spawning a "git clone", as we have no submodule set up.
>
> Makes sense, though I'm not sure I agree this is worth patching as I
> currently understand it.
>
> If I run t7610 today with '--run=3D2-' (IOW, skipping the setup test), I
> am definitely going to get failures. And I don't think we should have
> every subsequent test depend on having run anything containing "setup"
> before it. That is, it is not surprising that we will see some test
> failures when carving up and running portions of the test instead of the
> whole file.
>
> I don't think this is substantively any different than that. Whether we
> don't complete the "setup" test because we had some leak (and ran the
> test suite with the appropriate LSan options), or because we neglected
> to run it at all, I don't think there is a significant difference.
>
> Either way, the end-state of the test repository isn't guaranteed to
> match the intent of the "setup" test.
>
> If this is the only such problem in-tree, sure, I think it's fine to
> patch. But I would wager that there are *many* more than just this one
> lurking, and patching all of them would be less straightforward than
> this one.
>
> So... I don't know. I'm certainly leaning negative on this patch, but if
> you have some compelling reason that I'm missing, I'm all-ears.

I agree with that in general, but the expected failure case for all
those other things that are broken with the missing setup is just that
we'll predictably error out immediately.

Whereas in this case we'll end up hanging on a connect() to some box
that IANA's maintaining for the example.com landing page, and after we
reach the connect() timeout we move onto the next failing test, which
will do that again. The test takes a long time to finally report an
overall failure.

I think that's worth fixing in general, aside from the leak
detection. I.e. yes in general we aren't good about running tests 3..9
successfully if the 2nd test fails.

But we generally just fail some or all of 3..9 pretty fast, and don't
start taking 20 minutes to run the test, when it took 10s before (or
whatever).



