Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D095DC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 17:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89F560EE2
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 17:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhG3Rpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhG3Rpv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 13:45:51 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CC6C061765
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 10:45:45 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 190so10167874qkk.12
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tsBosJ/+P29PhVPerzq8RpzjfYD4A6oyS7tqay8F6Ss=;
        b=V7YWNvs04U2yBX7QBSCyoCpPb5ej01kv8YJMD4vKi9rF3cGt0pkLcCEtn5xeObxwMa
         yLzwhRSn0hl4BDqhpVOCUrj6jMpKZtBP1IuYQtMMi/BtNlBZAbefE8wTxBAJG4hFzjmy
         mhcPB3Mi0mADQyVx+5+cu3DotCUXZEr/W5/0+wfuB0/g6tiRTYEfMMCXh8LLfb6s2K1y
         XZiFT+H7C5mcmnBzI/9maK4l5cvsJMat+8LjsjGeMi2+1Qo0xTihHhbKaTdGHbgCS1cX
         TOPPpVbjAQiSHL/qdi+jYOd+GEcDFKHvdbppNEU+cnP1C52DD1Iae7PS1gCI3cvAwm4F
         hMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tsBosJ/+P29PhVPerzq8RpzjfYD4A6oyS7tqay8F6Ss=;
        b=E4b5PHI7BwsEJKNdyWCAflXmF5iZoo+e/pTlvhaYgkyTT0B04NSKvIYGfWosT1/JkO
         tmlbnhDXSqLKxsHqg0WmvICdrv985uuafHgutmPMoBSZw4XGLWaokJaHvOg5ekj/BCWz
         2UncBDizyCxSiKxvrdux3Ln/aZQA03ml/zQ6dZk/eXrbdoxQTbIjffWQ46qh0Co44EMG
         Ij8cHO69zOYqOVwYlFK252PoqWFqIxi4n4Z3sqUsdH7nCBwKmDYx9Tx7a/tlRRwqyoyn
         eJOo9yHx4cc1S/dh5IMnIWIcEY8/AQD888ezSqa92oN7cggi3wvKDBvRrvawwXLAF218
         o0Pw==
X-Gm-Message-State: AOAM530q8iuZF7NgB/F7K8nvgvNW3+hpH9b027OPPIBuyx2LFzniiIUu
        LDOyPMQq8bkEKHO0T9nYMMY=
X-Google-Smtp-Source: ABdhPJzeRpYhBOQNKtIsAe4ViCSI6ICs5tAEVb6ZxTWFnmWJVbSfNiw4Q90ldinYkfvYOaM15+0p2g==
X-Received: by 2002:a05:620a:7d3:: with SMTP id 19mr3375602qkb.351.1627667143198;
        Fri, 30 Jul 2021 10:45:43 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id x14sm888850qtv.17.2021.07.30.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 10:45:42 -0700 (PDT)
Date:   Fri, 30 Jul 2021 13:45:41 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/1] Improve automatic setup of tracking for new branches
Message-ID: <YQQ6xSlX+0LvBBWX@erythro.dev.benboeckel.internal>
References: <20210728135041.501850-1-mathstuf@gmail.com>
 <20210729020125.746206-1-mathstuf@gmail.com>
 <9b8b3a12-6801-1c5d-9cfb-c87b51cd9548@gmail.com>
 <YQQFWtKo8b1WJIGe@erythro.dev.benboeckel.internal>
 <7b50ebc6-7b28-412d-b124-9bd54750c922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b50ebc6-7b28-412d-b124-9bd54750c922@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 30, 2021 at 12:01:36 -0400, Philippe Blain wrote:
> Hi again,
> 
> Le 2021-07-30 à 09:57, Ben Boeckel a écrit :
> > On Fri, Jul 30, 2021 at 09:35:39 -0400, Philippe Blain wrote:
> >> Le 2021-07-28 à 22:01, Ben Boeckel a écrit :
> >>
> >> Small nit: usually when sending a second version of a patch, you would use
> >> the '-v2' argument to 'git format-patch' so that the patch and cover letter
> >> is prefixed [PATCH v2].
> > 
> > Yes, I realized that I had forgotten the `--reroll-count=` argument when
> > making this patch (I suppose a way to store the Cc list for a topic
> > somewhere would be nice so I didn't lean so heavily on shell history
> > would help this).
> 
> There is 'format.cc', but it's not branch-specific, so you would have to
> use one worktree per branch with extension.worktreeConfig...

I suppose a `branch.<name>.cc` configuration might be in order :) .
Though at that point, `branch.<name>.rerollCount` and
`branch.<name>.sendEmailTo` also make sense…

More brainstorming below too.

> > FWIW, my main gripe with the email-based workflow is the lack of
> > coordinated metadata (LWN has numerous comments by me about my views if
> > you're curious, but I should really formalize them into blog posts). But
> > when in Rome :) .
> 
> I agree. I almost always use Gitgitgadget [1], which keeps track of the CC list for
> me, of updating the re-roll count, of adding the in-reply-to header such that subsequent
> versions of the series are sent as a response to the cover letter of the previous version,
> generating a range-diff against the previous version,
> commenting on the PR when the series is mentioned in "What's cooking", etc.

That's nifty. I guess since I started here, things are a bit messy for
this patch though?

> Some things it does not support are: sending a patch as a response to some random
> mail on the list, which is sometimes useful, reading the commit notes to generate
> in-patch commentaries [2], customizing the diff generated by 'format-patch'.
> Other things are listed at [3].
> 
> Recently I've even been using only the terminal with Gitgitgadget:
> I use 'git branch --edit-description'
> to write my cover letter, and then use the 'gh' GitHub CLI to open my PR:

I think having `branch.<name>.coverLetter` and/or
`branch.coverLetterDirectory` (defaulting to reading `<name>` or
`<name>.txt`) to store the cover letter contents would be nice. I know
I've blown away enough `0000-*.patch` edits with an ill-timed `git
format-patch` before…

Forges could use this to hook in with their push options[1] through
their wrappers or other tools.

--Ben

[1]https://docs.gitlab.com/ee/user/project/push_options.html#push-options-for-merge-requests
