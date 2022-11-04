Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAEAC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 08:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKDI5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 04:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiKDI5F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 04:57:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64B828720
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 01:57:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y14so11509539ejd.9
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 01:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=So9DiouScP5Rmog91yL4QtgvnubcX5E0J0xqiF20nZA=;
        b=VXf4Mh2upecOrwSdst9pc5lnggDIQEtjT2Hb02sVaLUCmJ18PJ5ptYZ5dBmpP3rhKi
         8bmNll7kkazjOQHuiFXtQeA7jGb/k/sB2LMqEF1dBfCQvi59g4Wof1/tcDCay31Nu6To
         eMLo0oy7/1egGgVfSZ2/da+bVoVsXfH4JUzA9Pk1MbueORjE69bEecZGbWOmGbzBjWgM
         9zdnbD1zb5gpmfH+f4r5so9wZB4z0TAcEXQyUexJFIcA0SlzqCU7UssW6zC6LW9RxJed
         bMu+0nWGKISZe0u49BrWKsBklZzuMbVrFbhbzh5laWx6xg3FZmk9L1H9RkprZLcCP4AB
         b41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So9DiouScP5Rmog91yL4QtgvnubcX5E0J0xqiF20nZA=;
        b=mDJqLC318s24ugE3IZYlyfpnPKBIiK2GCVKsI32T5YQXYhmfr6mrvOrfN/pkOiaydi
         nAdIjzI39Sw4Ee3zT4UbceeY5Lx2JgRYk92zDpQb3o/hXIRYFD51fivOx/RK86RbfDU7
         JPrRz8RcYJ5gXXg+/+WfQIcGV9Kx+PeJzLIkxCykGE0BPEinVlex7M8f6zpOmcUevZPO
         6mUtbjtJduUeS9AjXb8ELifERXE9PpHsRDjty5PgZwl+Ue2DaYEQiWLziCMQDDGR8FMC
         UTQmVJhZeLKuc/vkcX9LwSTg0m2He2Z5HQ6nZJXN8N2MuWpSUWshQ9wpotAfQcwaUPbt
         BsHg==
X-Gm-Message-State: ACrzQf033VgE8muJQDWK5q1QsprS8nMEQjyWSyjOaR2TwgMBkdMTj1sY
        B/eJSeF07zkcg2nc0+Rmn451Qvu4sbpksA==
X-Google-Smtp-Source: AMsMyM6bog6FEePfjyTn2x7DkyW9SWFjSRNeIUkAYMeL59TggqHXJ5Yt/QIfD2RZgZFrZ9eMidEeNw==
X-Received: by 2002:a17:907:75e4:b0:7ae:2336:9d17 with SMTP id jz4-20020a17090775e400b007ae23369d17mr5946892ejc.7.1667552222180;
        Fri, 04 Nov 2022 01:57:02 -0700 (PDT)
Received: from gmgdl (j84064.upc-j.chello.nl. [24.132.84.64])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906539100b007ae1e528390sm1498919ejo.163.2022.11.04.01.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 01:57:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqsVZ-00DDxp-0l;
        Fri, 04 Nov 2022 09:57:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rudy Rigot <rudy.rigot@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] status: long status advice adapted to recent
 capabilities
Date:   Fri, 04 Nov 2022 09:52:59 +0100
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
 <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
 <8abc5272-4e01-e793-5155-ea116e9ad4fd@jeffhostetler.com>
 <Y2MEXyhh2cJ14ba9@nand.local>
 <CANaDLWK6-KkfKP0mipuWccfQFacDWsLHFNjS7ogL_xWvvmrCfQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CANaDLWK6-KkfKP0mipuWccfQFacDWsLHFNjS7ogL_xWvvmrCfQ@mail.gmail.com>
Message-ID: <221104.867d0byu5e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Rudy Rigot wrote:

>> looking up an unknown configuration variable with 'man
>> git-config' is easy enough.
>
> I'm not strongly opinionated, but I believe the initial idea behind
> redirecting them to the doc was because Git now comes with more
> configuration abilities to improve performance of git status, that may
> be more or less relevant depending on use cases, so there
> isn't really a single git-config key for them to look up any more. Their
> ideal solution could be core.untrackedCache=true, core.fsmonitor=true,
> advice.statusUoption=false, status.showUntrackedFiles=false, or even
> some combinations of those can be relevant.
>
> From there, the goal I believe we were going for with this new doc
> section is to let users know what configs exist for their git status
> slowness pains and why, so they can then go look those configs up for
> more details, which I agree would indeed be easy from there.
>
> Again, I'm not strongly opinionated, and I hope I accurately represented
> the inital thinking on this idea.
>
> One slightly stronger opinion I have, is that if the advice message
> was just
>
>> It took %.2f seconds to enumerate untracked files.
>
> and nothing else, I can definitely see a strong UX downside of not
> giving a hint of next steps for users. Basically, "you have a problem,
> and we're not helping you resolve it". Were you thinking more of
> something like this?
>
>> It took %.2f seconds to enumerate untracked files.
>> Please look up the core.untrackedCache, core.fsmonitor
>> advice.statusUoption, and status.showUntrackedFiles configs
>> for potential solutions.
>
> I'd say that's probably somewhat cryptic and a bit verbose (which is
> what we were trying to avoid by telling them to go see the doc), but
> we wouldn't be leaving the user stranded, so I can see how that would
> work out ok.
>
> I'm very interested in what you think.

On the topic in general: I think it's probably a good thing to show the
advice, but I just want to point out that it's not without cost.

Right now we're showing users a pretty basic command they can try, but
now we're showing them other stuff that needs more complex setup.

For some they're probably way better off, e.g. the untracked cache is
pretty much an unambiguous win (we should probably turn it on on
default, but we'd need to check on-the-fly if the FS supports it
properly).

But for e.g. fsmonitor the user may spend a lot of time fiddling with
it, only to find it doesn't help their use-case much, if it all.

Should we still point out these possibilities? Probably, but just say'n.

One thing that I find glaringly omitted, which since you're working on
this you might consider adding: Suggest to just try running the exact
same command again, maybe it was just the FS cache.

I.e. we're suggesting all this advanced stuff, but by far the biggest
difference is made on e.g. a modern *nix box (particularly Linux) by
just having all the repo's assets in the FS cache.





