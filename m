Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BCFC4332F
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 18:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiK1SPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 13:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiK1SOo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 13:14:44 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB025317CB
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 09:57:11 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id td2so13740350ejc.5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 09:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fD9blRAaTHjin4Seec+Ag1Z4AId1hLGfILKrqucTJTM=;
        b=f47nJrfO6MojzLj30SWL/NRqvyXyiVb5PCoV/zyiAKWvKd83XoJzt2c495G4G79yjs
         xZm25aYu6IFUoZ/rZosyjkwHVEjN1QbfrRkzqF2Q9NTwgrJjTXkhZcIqPSUl65NUyakO
         p+X+ryav0MiwMY9qj/On+6xC9XDo9yZen89UmxRbQWyuyv96N8a1ciYJt4QZiKYYOLJ4
         x+vF6YsplPQsF2mxyH1JCEC/v2VzAFU1i91pRMmJ1QWSzptmkHjdfzLgJNCQnQPh9IWk
         rbvHLbaOoN4/57AALRvnuLPBV2h0Sl+n8jhCfR7UWVpwckhFLtGC5B4YKFJQg/89P4BJ
         Z2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fD9blRAaTHjin4Seec+Ag1Z4AId1hLGfILKrqucTJTM=;
        b=vxZE69kWQCymui5Q/DzjHyBRxyq1+wltxUanHU/4PA1WbsUxkll4RNBO1dmq+i/rho
         /GYHtaiX+9owqHygCSMuvfNChlmcVPX8FOoPJoop5H/fSuoGORz1o+5qX+FBzLmUUDLs
         LlOUTsmFINt/Y66vH6ILLFdIWjU7pqHuVJRWSNkCs7Ctxc/UYt/fjRC/FEX7EU9gz0av
         WQ3b4RQbKrAokjvX4viaGZDKKpt4/RLTCJq2AcD3iFJr3XELkHozeTX83PArgcsoBpV/
         P3Bkg1QUcKbsFM6w0jIC5OkpIQAbHqLIMEAPNHhhPJSfgGYVNAHMYYQcbx64B0JUXaGD
         6FTQ==
X-Gm-Message-State: ANoB5pmmKp5tl/BacERfCZAA4CdyEIjLSe4VTxM++xogClEod8uUWrPg
        ZUHmUJ4i+Kpjmp1BFDIpGN4=
X-Google-Smtp-Source: AA0mqf6CdEz1yfUppG02d4TPwB/q7rDPa4MaRYwooAek2o01IWZcTXTWsjjcVeKlERfE8qMjUfMfLQ==
X-Received: by 2002:a17:906:444b:b0:7ad:dd43:5d53 with SMTP id i11-20020a170906444b00b007addd435d53mr26654678ejp.376.1669658230055;
        Mon, 28 Nov 2022 09:57:10 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f24-20020a17090631d800b007ae693cd265sm5185140ejf.150.2022.11.28.09.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:57:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oziNP-001D94-2d;
        Mon, 28 Nov 2022 18:57:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        "Randall S . Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH] trace2 tests: guard pthread test with "PTHREAD"
Date:   Mon, 28 Nov 2022 18:50:19 +0100
References: <patch-1.1-f7f21c94a6c-20221124T214813Z-avarab@gmail.com>
 <xmqqilj3edtr.fsf@gitster.g> <221125.867czjo3ud.gmgdl@evledraar.gmail.com>
 <6c725ed6-4d74-c260-98fb-dc965b4647ee@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <6c725ed6-4d74-c260-98fb-dc965b4647ee@jeffhostetler.com>
Message-ID: <221128.86wn7fj72k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Jeff Hostetler wrote:

> On 11/25/22 3:05 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> [...]
>> That was my thought as well, but these tests are specifically testing
>> how it interacts with threading. The counter mechanism works in general
>> without threading.
>> The test descriptions don't help, and should really say that they're
>> to
>> do with threading in particular, but I wanted to keep this as small as
>> possible for rc[12] and the final, so I didn't fix that while-at-it.
>
> There is large comment block above `have_timer_event()` and
> `have_counter_event()` in t0211 that explained the purpose of the
> test1 and test2 tests for each.  Would it help if that text were moved
> down before each of the individual tests rather than where it is now?

You did ask :)

I think that better than a comment is to have the test description
itself reflect the nature & purpose of the test.

Now the two are:

	test_expect_success 'global counter test/test1' '
	test_expect_success PTHREAD 'global counter test/test2' '

So at least the PTHREAD shows that it's something to do with threading,
but if it fails with that prereq passed you'll need to consult the
source to see what "test2" is supposed to do. Better would be to just
skip the comment & work "single threaded" and "multi-threaded" etc. into
the test name itself.

Ditto symbol names "ut_200counter" and "ut_201counter", again, a comment
somewhere in t/helper/test-trace2.c notes that they're single- and
multi-threaded, respectively, but why not skip that and make the symbol
names self-descriptive?
