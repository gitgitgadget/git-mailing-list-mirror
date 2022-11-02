Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4755EC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 17:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiKBRVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiKBRVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 13:21:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412DA248D2
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 10:21:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z18so22534814edb.9
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 10:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DxsvRJQP3/ZhiUCbQxdUQ5bFDEoz9NJMg1uFcwhirO4=;
        b=T2gmoQTrHaEgkjqwJYVh7pDOCikD4EZ65dHcX34sn/F4Kbi2g8AqBlRRvGnE3iSv++
         EydFIrJP5Qvt35LWwM5khw9OxaPZ/4MaE9DHMzKoVZwifzeAk4G3e6wveLUERWbONUNb
         I2KM0VI+Us1MBwHt8C9p6P/JLXNCuHZHw5mn7MUfAPSj1+5wkd036Bv8M83qfHoKrJT6
         Anu9dQ9/g51n/iOIWoh8BgysjVRNLQP5up5cYSjwBEag261KjsFfypZUQJuWmkDhCGFt
         pykXJb5Wz82KEeAEUQKon93ovp7EtiP9JF+RKwMTXIXr+Rsc2gbJ+FjY21W2eRhxIY67
         ekNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxsvRJQP3/ZhiUCbQxdUQ5bFDEoz9NJMg1uFcwhirO4=;
        b=e1N/T3jBj6zYJ3ztKLhVNoY7D4VjNSgA5/70QMdtQXVqtdvvDzflUxddP9pa86Mbg5
         FQRUcP3gn4cs8vcaU3XXNXMu62ABldWk4ict+iOukGiBjJ7kkdMjz2uzEWNn9mguIled
         qkd/9J/e2+UBVlYVNtFUWLeO8WYXFaXbFKPWIsNxAkAjBVgqb1MSpnsx23kxy9W0fWB9
         wwhHpXpB2kDYDm1zDrWbY/BgqXDavX6W/SG/bM9aNAGBBOCeEE6FZ60GnRjMGdqo8OMa
         zY2RK19AN8TrxlebJCnSVrOpjgpLCKT6nhKeSVmV3RGrDsO3E03WXPpkH7YjvKLHMci2
         fVng==
X-Gm-Message-State: ACrzQf15JMQXgXJ89o0a7ye/Vk2EVmV4Xv/MyleEZg5eBb0MJPvioEA4
        c5Fm14aHzQqNXDTDzhKYOTnp7MqfCwv2SA==
X-Google-Smtp-Source: AMsMyM7SxWjISCKhzaL8ofPucSaSWWNKsir/i0s+MBf+fNxcrGv7F2l7l6yAK9W/uzX06YwBc3YCPw==
X-Received: by 2002:a05:6402:428d:b0:460:b26c:82a5 with SMTP id g13-20020a056402428d00b00460b26c82a5mr26554460edc.66.1667409693636;
        Wed, 02 Nov 2022 10:21:33 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ce24-20020a170906b25800b007a7f9b6318asm5670421ejb.50.2022.11.02.10.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:21:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqHQi-00BttF-1c;
        Wed, 02 Nov 2022 18:21:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/misc-hook-submodule-run-command (was: What's cooking in
 git.git (Oct 2022, #09; Mon, 31))
Date:   Wed, 02 Nov 2022 18:13:51 +0100
References: <Y19dnb2M+yObnftj@nand.local>
 <221101.86iljz5z7l.gmgdl@evledraar.gmail.com>
 <Y2BlK5uhCy77Ot4Z@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2BlK5uhCy77Ot4Z@nand.local>
Message-ID: <221102.86h6zh2rxf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Taylor Blau wrote:

> On Tue, Nov 01, 2022 at 12:46:57AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Mon, Oct 31 2022, Taylor Blau wrote:
>>
>> > * ab/misc-hook-submodule-run-command (2022-10-31) 3 commits
>> >  - run-command tests: test stdout of run_command_parallel()
>> >  - submodule tests: reset "trace.out" between "grep" invocations
>> >  - hook tests: fix redirection logic error in 96e7225b310
>> >
>> >  Various test updates.
>> >
>> >  Waiting for review.
>> >  source: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
>>
>> I think per
>> https://lore.kernel.org/git/221031.86tu3k6u2d.gmgdl@evledraar.gmail.com/
>> &
>> https://lore.kernel.org/git/221031.86pme86tcg.gmgdl@evledraar.gmail.com/
>> that this is ready to advance.
>
> Yeah, I agree. I was mistaken that GIT_TRACE truncated its output when
> redirected to a file, but it appends. So, the series looks fine to me.
>
> I would still like to hear from Emily, but otherwise I don't have a
> problem starting to merge this down.

(Just looking at what I can & can't unblock)

In case that's a "let's hear from the author" (understandable) then this
is entirely my work, even if it's her in the "author" header.

Her last version of tha commit was[1], but this entire test is from
my[2] re-roll of that topic[3].

1. https://lore.kernel.org/git/20210527000856.695702-8-emilyshaffer@google.=
com/
2. https://lore.kernel.org/git/patch-03.31-1ad4e69f7da-20210528T110515Z-ava=
rab@gmail.com/
3. https://lore.kernel.org/git/cover-00.31-00000000000-20210528T110515Z-ava=
rab@gmail.com/
