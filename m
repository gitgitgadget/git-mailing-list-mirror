Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA85FC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 14:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5346115B
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 14:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhKROgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 09:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhKROgt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 09:36:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC62C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 06:33:49 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g14so27897179edb.8
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3vMILWyzTXXDTZjLXJYyNPmknfYOazTGu5fT6YtPDE0=;
        b=VrUnoCnXCtBwm90itgw0jJTd0i7x0lilOe8WjRlzvyN5hA3Mifs93NU+9y7hRXjIj1
         99SbukaHFkMehfExpbf+qw+AWkom31JDV9FAkw31Ag8zw6GfsPcTOokBnZgh/zb+tu0T
         y52L1YUeDTYyfdngPeKLTnNPX9CxnoWp4Cd1nF5VjN0Ugr6VXI0GzVBKXgpd1CeEV0NP
         Fo7U60fXTOgTSSzubezfWovq9PRlffVaXJUuPDknTfqf5aS37lWeWGGH5875RY1YieyB
         CPpDgV/iy7RXrz6W7BGaBpgvLcln0Kr+x+kFHLNN5VBr14wXCAvj4IFGWeKr1mSLIvFQ
         p1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3vMILWyzTXXDTZjLXJYyNPmknfYOazTGu5fT6YtPDE0=;
        b=hoz570KkU43IUn23R9I2bcnz1BITk7j5GcwHmghI3Y5KJA6qjXLamvhymIzuoQ3iLA
         +x8Ga++3iW6lBP7btCJQI9uKm4IzchIjXdjdjvKSS3V3CNGuwKyaDLEQUcBvA87rcFj6
         TBoolk2yhbJ/gS3xex/PyUXE4iGzcFIVXEtnCzQ2QcpV+Tq9dhNG+22kineIT47eDUzX
         augilAsyl2bX8kKnpQzr8KiLSX4n86DiuYjHuUyStQADUpcaWx51NBoXVGbHd387hFrc
         TuTUTGTQbkGMGw917pC/hLVxEVlzFzTJzo5ICAWbNPhi7bM0fdt4xlNV9T5cwSptJ4sK
         khfg==
X-Gm-Message-State: AOAM531SgFji9lAjFPsG9UOXmWnRqKs6lHmq7R9S0gt2xNqTk4HxLVsU
        u316+ZcTVGXfgvEW8Xsb0jB1cm6Ba+Q=
X-Google-Smtp-Source: ABdhPJyE2Hz89O2zWNOWhnm2/mjVX/mr5K4jUkzPns7l0as+eNZSlHeO3mf8wGdF8Nq3K5Is0dk0Tg==
X-Received: by 2002:a05:6402:34d6:: with SMTP id w22mr12035785edc.35.1637246027621;
        Thu, 18 Nov 2021 06:33:47 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w18sm7299edx.55.2021.11.18.06.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:33:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mniTy-000V2l-Ka;
        Thu, 18 Nov 2021 15:33:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v7 00/17] Upstreaming the Scalar command
Date:   Thu, 18 Nov 2021 15:11:00 +0100
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
 <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
Message-ID: <211118.86zgq14jp1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Johannes Schindelin via GitGitGadget wrote:

>  * To avoid mistaking the current patch series for being feature-complete
>    enough to unleash onto end users, I moved the Makefile rules to build
>    HTML/manual pages to a later patch series.
> [...]
>  * I added two patches that I had planned on keeping in an add-on patch
>    series for later, to build and test Scalar as part of the CI. I am still
>    not 100% certain that it is a good idea to do so already now, but let's
>    see what the reviewers have to say.

I don't expect given [1] that I'll get a reply to this, but as noted
there I've had outstanding reviews of this series (including proposed
patches) for weeks/months now that haven't been addressed, including the
patch-on-top I suggested in the previous round of discussion [2].

Looking at the new README.md it seems that the change of plan between
v6..v7 is that after insisting that this command must stay decoupled in
contrib/scalar/ and have its own build/test etc. infrastructure, the
end-goal now eventual full integration at the top-level.

Peeking a branch of yours[3] there's a change[4] in it that's much like
my [2], some of the hunks are even the same.

I'm quite happy with that end-state, but still don't understand why the
"scalar-extra-docs" and "run-scalar-functional-tests" (in your README.md
here) couldn't be squashed into this first step, as suggested in my [2].

The end-state is the same, but doing it that way avoids all this
path-based churn, setting up build systems that are then going away in
the short-to-medium term etc, as well as the new custom just-for-scalar
CI integration in this v7, you'd get that and more for free with my [2].

All of that is apparently to:

> [...]avoid mistaking the current patch series for being feature-complete
> enough to unleash onto end users[. ...]

Which is fair enough, but doesn't explain why this back-and-forth churn
is needed to reach an end-goal we apparently now almost entirely agree
on.

I.e. in my [2] it's built & tested by default, but not installed. So end
users aren't seeing it. The small bit of proposed in-advanced reference
to it in our documentation is there in [2], but that's trivially
tweaked, we could defer that too. No end-user would see any of it.

So who's being helped by these intermediate steps?

As far as I can tell based on your previous comments the perceived
necessity these intermediate steps comes from a narrow reading of
contrib/README,
i.e. that software in this sort of flux *MUST* live in contrib, even if
we've got plans & patches in-progress to move it out eventually.

Whereas I think we can just document that it's in flux, and skip the
intermediate churn to get to the agreed-upon end-state.

As before I'm happy to engage with you, but I must say at this point I'm
not getting my hopes up much.

Cheers.

1. https://lore.kernel.org/git/211110.86czn8hyis.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/
3. https://github.com/dscho/git/tree/vfs-with-scalar
4. https://github.com/dscho/git/commit/f9b8e5d5e7e
