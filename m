Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14A2C4743C
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E17C611C1
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhFVADN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFVADM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 20:03:12 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129FFC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:00:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m17so6271979plx.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dDZCMwInq3jZCyiYHDgmf2qDkkMxR3o7cK/zLxtQVTE=;
        b=RUvPKPQ3ASku6F6tqs2j3RpQPPM0AYYSOa+26fMvjfjaj1bd314BCVSRGZvORC8+FP
         sq13vu3jm4qddktNSQYzgL/E5gQ/5QdE5eAOkymnt20rWVIfSRJOrW1ECb9BcNqxa29h
         WsbHHoRAddHtzLnIN1awAjP+W6fElUB0Zia3BAmIjua5b24BGe1KRMyY2eoo0kbmQPNB
         R4u9kFx8zYtYodxCE/1pvNyZBjPK2s8iwVDJavGeS6TgOJ35tjD/Kw7maRCyKOAHssVE
         yhTPjQIi3bRKgLt96MOVvMg5xBolKXUZPj6NvOa+RhZ3oW2vgybzRM2tz/srnyPH3ZhV
         Cllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dDZCMwInq3jZCyiYHDgmf2qDkkMxR3o7cK/zLxtQVTE=;
        b=iHiFLBXw49PumO38qUx5N+FJoDlE42hRyj/8YVmwlJsjzH0t3HTF4iqqkwv6u2JUn7
         I62dcx/NuhxRAArFMv4lms4687NXwti/eY1mewSZwNFasyG9gn7ARFhgNkHAwlpWIQls
         W5VrY/42E9cir7pSNwW2YfUd4uhuXGdvTk4cUZuGM0uUgtQR/5rF/ZI7LFgXsUIBgeN5
         GmSHi+q069fCQUjPxatx9zngAin0SFekOoxOeJG0pgAkAg+16Vp3QMq4It9yZALU/8od
         kNZjGiZnitSwg5Bl8SgfRIO+e/g4r0JLs4wkhrxWRHm8EhMT/8v28GZ1if7ArvLy3Fc8
         gTBA==
X-Gm-Message-State: AOAM530ZCCySy5kPjLUbXhwWBbML+QqTWQAwS3s27cUUyjtP1z8HMNy1
        CA4xMoA2TtrVoXRDbGgxk48x5g==
X-Google-Smtp-Source: ABdhPJz7ZWj2ZmYgK28tm9eRmAklpabvA6e3o+HrjRCEhOk6PnfCHoe1xZqDKaCSKTM+x+aMkLejMg==
X-Received: by 2002:a17:902:bd8e:b029:11d:b246:c59a with SMTP id q14-20020a170902bd8eb029011db246c59amr20253039pls.58.1624320056181;
        Mon, 21 Jun 2021 17:00:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ae2b:30fa:ce1c:ca3b])
        by smtp.gmail.com with ESMTPSA id 189sm15984533pfu.84.2021.06.21.17.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:00:55 -0700 (PDT)
Date:   Mon, 21 Jun 2021 17:00:49 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 01/30] hook: add 'run' subcommand
Message-ID: <YNEoMZ1QhZwmS0v2@google.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <patch-01.30-447d349c738-20210614T101920Z-avarab@gmail.com>
 <YMfLO9CT+iIDR3OA@google.com>
 <87lf7bzbrk.fsf@evledraar.gmail.com>
 <YM0alLP5U81D+ZI0@google.com>
 <87im2848pn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im2848pn.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 09:30:59PM +0200, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Jun 18 2021, Emily Shaffer wrote:
> Yes, 30-some patches that both refactor and introduce new behavior are
> harder to reason about.
> 
> I've also had suggestions about the end-state, but I think whatever we
> arrive at doing the scaffolding first without behavior changes makes
> sense.
> 
> > I don't dislike the reorganization, but I do still wonder whether it's
> > a setback to the progress the original series had made. I guess it is
> > hard to know - I had thought the original series was pretty much ready
> > to go in, therefore making "what if we ordered it this way" moot. But it
> > seems that you disagree.
> 
> I'm still not sure if I disagree, well, I'm 95% sure I disagree with
> some of the end-state, but you never replied to my questions about that:
> https://lore.kernel.org/git/87mtv8fww3.fsf@evledaraar.gmail.com/ &
> https://lore.kernel.org/git/87lf80l1m6.fsf@evledraar.gmail.com/; So I
> don't know for sure, maybe there's things I missed there.
> 
> I think since Junio picked up the "base" version of this and it looks
> like we're going that way first that's not something we need to discuss
> now if you'd like to punt it, but I'd really like to get that cleared up
> post-base topic.
> 
> In brief summary:
> 
> I'm 100% with you on hooks being driven by config, that they aren't is
> in hindsight a historical wart. Ditto the parallel execution etc. (which
> I'd suggested in an earlier iteration). That's all great.
> 
> Where you lose me is the need for having "git hook" be an administrative
> interface for it, particularly (as noted in the linked E-Mail) since the
> need for that over simply using "git config", or a trivial "git config"
> wrapper seems to be fallout from other arbitrary design choices.
> 
> I.e. that all the config for a hook needing to be discovered by a
> two-pass iteration over the config space (or keeping state), as opposed
> to a "hookcfg.<name>.*" (or whatever) prefix.
> 
> Maybe that makes sense in the eventual end-state, your series has the
> equivalent of "WIP, more will be added later" around that "git hook"
> command; but not having the full overview of that I think we can make
> simpler inroads into getting us all of the practical featureset we want,
> without regretting our choices in command & config interfaces later.
> 
> > Anyway, I do hear also that you don't have interest in driving this
> > subset to completion, and that's fine. Correct me if I'm wrong.
> 
> I submitted a v3 of this (which I forgot to label as such in the
> subject) at
> https://lore.kernel.org/git/cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com/;
> given the timing our E-Mails may have crossed.
> 
> But no, I will drive this subset to completion. What I meant with the
> "run with it" comment and the earlier reply on v1 of my "base" version
> here: https://lore.kernel.org/git/87y2bs7gyc.fsf@evledraar.gmail.com/
> 
> ... is that I'd be happier if I managed to just convince you that the
> more piecemeal approach is better, and something you'd want to pick up &
> drive going forward.
> 
> I.e. it's still >95% your code, just re-arranged and split into subsets
> of your patches. I really did not mean to "steal" it, it's just
> something I hacked up one day to see if the more incremental approach
> I'd been suggesting (and felt you were either ignoring or were too busy
> to address) was something that could work.

Ok. Thanks for clarifying.

Yes, I do like this direction, and I'm pleased you were able to chop it
up in a way where partial submission made sense - I struggled with that,
myself. Yes, I am excited that you want to drive this series :) :) and
will be happy to rebase on top of it.

I'll have a look at the range-diff for v3 this week. Thanks.

 - Emily
