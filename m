Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EF3C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 15:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiIHPcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiIHPb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 11:31:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89F95FCD
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 08:31:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r18so11684011eja.11
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=ThXbZ7EryX4iaEJeXfsrViPA8606IEQPNqpkPYErS7M=;
        b=P+WXaiGsiQjXKx2qSFokLWIwaIprkYZ8o2JnmUTm+Hf/4+RMgiRv0keIp9T4XWGHSf
         /4AwGjaR2i1y9UEddXn7Y3858ly9MGSDbVIO4GHWkq/24aLkV7ti738AGiyX2eSwW2bK
         JklkdQyyJJkJzP2gTEVMdz2Wm0YehkIovBPA5OMTfBHbOXV9BnRrAqYqJt86cvS0qvtO
         ZnPqjs8yGt/eEDelruju4pggWZpCEAJyGDxJiU8OiLnPJhJQDRaahBN3Ksyi4O8k/eAP
         3ygckp5KnGQr6f1fpd0KOc6eKha8vu5fpqxDv2MIYVZlmwjHIdQhg8Dt0B0zBzoZbUTO
         qWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ThXbZ7EryX4iaEJeXfsrViPA8606IEQPNqpkPYErS7M=;
        b=1O91zcXPvycxzgq/Gwr/w1YGGAqITt617jDwEpmlJWb+rjCm9IoSEnSi+LrgKe90cG
         FE3mhmbbCfibx/PvNcR1hBThzcWiM7f8iH7EP/Y2pRjHZVHsQlf8oYx0qwfbUHeZOvef
         I9yftnR7PWwxsTtiMpf9TKXUx4jHwDUNMVpVJ3DbT4cmNjje+LHibJ6mShl9BRCP6TBt
         fq6jgtoq+35a58XWSEA+oqK+4eNL2vX5I58v5ltB351f8WB33JCf4MPnnJOf/fVdjZ/Y
         p/mGRuz3tttL3gaytuX7YBqyQ+9EByj+D3mgbWOA7uqUKYkXlB4JKcG48hutRoa3DLMB
         hupw==
X-Gm-Message-State: ACgBeo3nXmTPRymSGtgiqpmJUTsvrtGhg/UdjD4E6s8bIxWUVteamMMs
        qRJeUnCeWLBrCw16xFT6ZSLelUY2MY0=
X-Google-Smtp-Source: AA6agR5o+JLaJ4iFslsSDiqwl9QXJL8OY5INQ8iRp3HVsPfG13YXjZQ8gx3ADXG1LJ/j7LlI8ZgHtg==
X-Received: by 2002:a17:907:75ca:b0:779:bf7:9bd9 with SMTP id jl10-20020a17090775ca00b007790bf79bd9mr670746ejc.79.1662651117058;
        Thu, 08 Sep 2022 08:31:57 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id la11-20020a170907780b00b0073d645e6dd8sm1335681ejc.223.2022.09.08.08.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:31:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oWJVS-001cg2-3B;
        Thu, 08 Sep 2022 17:31:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests: replace mingw_test_cmp with a helper in C
Date:   Thu, 08 Sep 2022 17:26:41 +0200
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
 <xmqqwnbv7trp.fsf@gitster.g> <354qp59q-r4r3-1971-5o09-71q224911orp@tzk.qr>
 <b21d2b60-428f-58ec-28b6-3c617b9f2e45@web.de> <xmqq7d2fywvr.fsf@gitster.g>
 <2d839209-21e2-b05c-125b-57a9c1dad1ea@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <2d839209-21e2-b05c-125b-57a9c1dad1ea@web.de>
Message-ID: <220908.861qsllw5x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 08 2022, Ren=C3=A9 Scharfe wrote:

> Am 07.09.22 um 18:25 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>>>> But otherwise the idea is sound.  We compare them line by line,
>>>>> using strbuf_getline() to ignore differences in CRLF and LF that
>>>>> originates at 4d715ac0 (Windows: a test_cmp that is agnostic to
>>>>> random LF <> CRLF conversions, 2013-10-26).  Only when we find the
>>>>> input different, we use "git diff --no-index" to make the difference
>>>>> (and unfortunately more, as it does not ignore CRLF <> LF
>>>>> differences) visible.
>>>
>>> Why not use "git diff --no-index --ignore-cr-at-eol"?  Do you even need
>>> to wrap it?
>>
>> Hmph.  That surely sounds sensible if it works, and I offhand do not
>> see why it shouldn't work.
>
> Using git diff in test_cmp and using test_cmp to check if git diff works
> would become a cyclical dependency.  Only doing that on one platform
> limits the potential blind spot to platform-specific bugs, though.
> Enough to go wrapper-less?  Not sure.

I don't see how being wrapper-less is less of a "cyclical dependency"
than using "git diff" directly.

If we are to postulate some bug where "git diff" thwarts us for the use
of "test_cmp" it's going to be *very* broken.

I don't see how such a "git diff" would pass the rest of the test suite
(some of which involves comparing its exact output), but still be
functional enough to work as a GIT_TEST_CMP.

Even one where it just returns 0 unconditionally wouldn't pass, as we
rely on "! test_cmp" in some cases.

And any such breakage we imagine might just as well affect a wrapper for
it, and I'd think that would be the more likely of two unlikely
possibilities, as that wrapper would only be used for the test suite,
whereas "git diff" is more widely tested.

In any case, as long as we preserve the ability to set a
GIT_TEST_CMP=3Dcmp we can sanity check any such wrapper or dogfodding of
"git diff" with an external program.

Needing to deal just with "git diff" and "cmp" would be a step forward,
as we'd be able to drop the current shellscript "mingw" wrapper, as well
as the special support for a "diff" that doesn't understand "-u".
