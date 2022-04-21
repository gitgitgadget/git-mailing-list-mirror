Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD07AC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391538AbiDUSvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391539AbiDUSvp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:51:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114934C403
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:48:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i27so11816720ejd.9
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/WgeJsDJleHQgBavny4F5HW1EDltOxXH7HSrEMluL+I=;
        b=Fb+g6errurIgqIAF8/UFOYMECZT32HKFheQUWSyCMES2XvEBLu81D5mXJ3mafFZrX0
         VSylRb3Nu1Fb5VgcctsGVNe5S4CxKMLqjLKDbfiuKfX/cCzAz+7Q6HFLKgRIhhmPzK80
         rnHLxYDZiMnxH9JY2JXxB3Gr5nZKXN2p2J5LKuH8qgLnj6/+SiN4vv3SXi6MXuR6uVVW
         CrbH/s58khoqEFfivQ4lDA8BNNWc/W/jNWJ7eU8bSYUrjJA+38SkK2+ZD7M2+XIhXO6w
         aPXxALFa1Zh3VB6DTFyewsJP0t2QdNlYyZULoJa9Og0zP/PE8wX2uiCS2usmNk936txy
         zPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/WgeJsDJleHQgBavny4F5HW1EDltOxXH7HSrEMluL+I=;
        b=5vZPV/p8cxUMibv9jBiHy3U7RWeY3+DXwy7oBtjgQ0D9bkOJPhp+CcnhZqMlDImIjN
         tSxA/Vg+/ykDYYDsqH8OBnKPsnX4eF7Z6t13Vd8oqupXNlTw7t/GHW1k1HvfV1/sKYXO
         Id3X0FWcSNlZ0S+r7UKNZb1eTJelYbI5HMQqpblxUcL5/E6hfhyEKK3yGqhGaOG3e0J5
         T+FUDmwYYBmNDGbc6XorSK0IRY/W729aSEIIbQbhcWOvIZNn4ruJ9OebylUIiRWN5NhF
         9JLT5JKBpCflvbg0Fbl3oyr4M/ijdtVXUkI3sWbNEawZhSHP9ejS5xNfzmtcZZfuZLlq
         O7tw==
X-Gm-Message-State: AOAM531iikJRdikiUHcrPbOFnyQ1O220V+Q6cP/H/DveG3lUxRYck2mm
        VT/TWURU6PhvEqyWiloqU1w=
X-Google-Smtp-Source: ABdhPJxKdjaHKqVSjoW8Etc1sDnYJ+WoHUitqtd7l4ksy6HyBZ9MQsf0o9mfitDMniEUIQuUzD3K0g==
X-Received: by 2002:a17:907:3e9f:b0:6ef:d830:b2cd with SMTP id hs31-20020a1709073e9f00b006efd830b2cdmr842728ejc.34.1650566933365;
        Thu, 21 Apr 2022 11:48:53 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm8108801ejd.133.2022.04.21.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:48:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhbrI-0088iw-8H;
        Thu, 21 Apr 2022 20:48:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: ab/ci-setup-simplify (was Re: What's cooking in git.git (Apr
 2022, #05; Mon, 18))
Date:   Thu, 21 Apr 2022 20:36:55 +0200
References: <xmqqbkwyz78z.fsf@gitster.g>
 <1157a463-f6c6-1df5-59cd-419d73eed1df@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <1157a463-f6c6-1df5-59cd-419d73eed1df@gmail.com>
Message-ID: <220421.86fsm66zmz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 19 2022, Phillip Wood wrote:

>> * ab/ci-setup-simplify (2022-04-14) 29 commits
>> [...]
>>   Will merge to 'next'?
>>   source: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
>
> I haven't had time to read all 31 patches from v4 in detail but I have
> looked at the results in seen.
>
> Looking at seen:ci/install-dependencies.sh the shebang has been
> changed to "#!/bin/sh" but it contains
> "BREW_PACKAGE=${CC_PACKAGE/-/@}" which is a bashism.
>
> Looking at seen:.github/workflows/main.yaml to skip running the tests
> one has to set "skip-tests: no" which is utterly confusing.
>
> From what I saw scanning the patches there seemed to be a lot of
> churn, both of existing code and code that gets added and then
> moved/refactored within the series.
>
> Looking at the output of a recent ci run of seen the steps to prepare
> the environment before building and testing print all the environment 
> variables rather than just the ones being set for that step which
> seems to go against the aim of "CI: narrow down variable definitions
> in --build and --test". (Also the "SKIP" prefix in the output lacks a
> ":")

Thanks. Those were all helpful. I replied to these in a re-roll CL at:
https://lore.kernel.org/git/cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com/

> Dscho raised concerns that this removes any support for azure
> pipelines which he uses when preparing security patches.

In the v1 discussion of my series ~2 months ago I asked him how he'd
prefer to proceed with that:
https://lore.kernel.org/git/220222.86y2236ndp.gmgdl@evledraar.gmail.com/

There wasn't any reply to that for about a month so I submitted the v2,
noting that we might want to do something different there:
https://lore.kernel.org/git/cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com/

And then as a follow-up to that v2 there was a follow-up discussion
ending (from my side) here:
https://lore.kernel.org/git/220406.86bkxeecoi.gmgdl@evledraar.gmail.com/

So, in brief summary I'm still happy to accommodate any such use-case.
But I don't think it's OK to say that code we don't even use in-tree in
area X must be kept as-is, to the point where it blocks forward progress
for things that are used in-tree.

To be clear: I'm not saying that's Johannes's position, it may or may
not be: The point is that he hasn't replied to
https://lore.kernel.org/git/220222.86y2236ndp.gmgdl@evledraar.gmail.com/
or any relevant follow-up discussions. So I don't know what he's
expecting there, or if it can be reasonably accommodated in making
changes to ci/* which by their nature must decide to
support/keep/fork/remove some of that code.

> I think splitting out the build and test steps is a good idea but I'm
> less convinced by some of the other changes.

What other changes are you referring to here?
