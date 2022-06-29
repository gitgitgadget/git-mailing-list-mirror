Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F09EC43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 10:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiF2Kdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 06:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiF2Kdb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 06:33:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6A037012
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 03:33:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q6so31583596eji.13
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 03:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LnAMzmMOnD2gs2GA3kfcnUN0Oh7zCU1CzMVekgA/Tes=;
        b=XnuAIIVEcFFE1OG77eY5VSeQIKP5wD/AONBZ8fcuLD4PN99Y6m0ga4u9N4v1PoYbQA
         5cjuhoc6AhxxL+O0nSJbHZndMpTmjqXCBSSZ8njbv6nkK92tIzbKM6KBtFioQA01DFK4
         kTtyi6uwh4F6uGygCd7i4VXsgKOJkAoVWjXPlY/SLd0sYO/+yHAPreYYcuRVJyiw9QB2
         bBLshyaFdtjeBsmTlCqfpS+U/CDhLm2y7x1z2yMoJB3FoI/1LEAkd04NQg2B8g7bhtXx
         OequfY+yoUEctW4H5NitYkjGhjzhq5xlfWHQsyE4H0MkbOkvTgoabbE/2dOXfLCpL5Yc
         IZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LnAMzmMOnD2gs2GA3kfcnUN0Oh7zCU1CzMVekgA/Tes=;
        b=Ul9pyZ4EA/4iKQPcgHMIuYUrMaB9fDs2OMKKYJCqoQZyl5dimJQ7SkgzkUBDuAgZW7
         uaGKD+aweexNVdBYI8AIGbXBX8Mu4LQ1JbQgI79lUMlbD+hxcUw4DCqg3cXBE1Ld7Wlk
         z2ilLCjUtYVy1EWE1YZv7YkTK/YVHlwGzW4wfcJmbKfpGjCzzhmW+kqPtmcrj9FF+hOh
         46LnPb0+9e/x1rDTL9JGKalhCSRrGMs8jjmjPcGQr8IIIjxlmaQwtGEpT61hPFkcouHu
         NZH/+8y529XzRc0TGN+ZMK25nf3nZ2HOXpbZE5FxYKt/WXS/FdKfd+ox+HDqtq+Ztxqe
         Pc7w==
X-Gm-Message-State: AJIora9DlB44jDNwiJvuoMo5Anz6oB9bgNXBTBnIHSPmbkHG6nAUXCMq
        Pkz/Thrcwnr2qTJURgPLKB8r3Rpn20c=
X-Google-Smtp-Source: AGRyM1vSS5xJa1Vvlp6PomXR76lsqPDPhT7gUhFgSZ/ZUFecGjuWsO2UpvQkhpAf9YL+dW3aMQ4uCg==
X-Received: by 2002:a17:906:970e:b0:726:3b59:3eae with SMTP id k14-20020a170906970e00b007263b593eaemr2722109ejx.702.1656498807386;
        Wed, 29 Jun 2022 03:33:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm9656693edv.36.2022.06.29.03.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 03:33:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6V0f-001tpm-Ip;
        Wed, 29 Jun 2022 12:33:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christoph Reiter <reiter.christoph@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] add --interactive: allow `update` to stage deleted files
Date:   Wed, 29 Jun 2022 12:22:07 +0200
References: <pull.1273.git.1656454964378.gitgitgadget@gmail.com>
 <xmqqr138h0wn.fsf@gitster.g> <YruJ06odaXmTOyjM@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YruJ06odaXmTOyjM@nand.local>
Message-ID: <220629.867d4zg3nu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 28 2022, Taylor Blau wrote:

> On Tue, Jun 28, 2022 at 03:35:20PM -0700, Junio C Hamano wrote:
>> The fix looks quite straight-forward.  It is somewhat disappointing
>> that it was caught after this loooong time, but as they say, better
>> late than never.
>
> I had the same thought, but I think that it points to something I've
> suspected privately for a while which is that we don't actually get many
> users to opt-in to features early when they are hidden behind a
> configuration.
>
> I had hoped that things like feature.experimental would cause more users
> to try features that weren't quite ready for prime-time more often, and
> that we'd get more and better feedback as a result.
>
> But I think that this proves that is generally not so. I think we
> should probably err on the side of enabling new features by default so
> long as there is sufficiently low risk, rather than hide them behind
> config. Or at least, not hide them behind a config variable for so long
> (though I am guilty of this myself with the pack.writeReverseIndex,
> which I have been meaning to flip the default on for a little while
> now).

I think we could get quite far by piggy-backing on the advice we emit
when you haven't set user.{email,name}, or otherwise find some minimally
annoying way to ask users to opt-in.

But while an opt-out being the default isn't quite the same as just
changing the code (as you can still toggle it off without downgrading),
that also has the disadvantage that we'd be more conservative about
adding such features, which is partially why we have feature.* in the
first place.

The X-Y problem of how we get early code to users who'd be able to tell
us that it breaks has been discussed several times, and all the
solutions are trade-offs.

One thing I thought of now but I don't think has been brought up before:
I wonder if doing "more stable" (or "LTS"?) releases would be a good
compromise between "early bird" and long-term stability, where we'd just
make every Nth release (say those divisible by 5) have
feature.experimental=false.

But any such scheme also quickly runs into the problem that we're just
not adding a lot of these, and for e.g. the built-in conversion we might
do the whole feature cycle in 3-4 releases, so such "stable" releases
would force us to keep the code around longer.

