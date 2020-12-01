Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41357C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 18:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D13208C3
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 18:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="B0g9NUKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbgLAS2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 13:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgLAS2P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 13:28:15 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89B6C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 10:27:29 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id b10so1663345pfo.4
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 10:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lvpMUdPKFa7WYHIAbjoeqdpjJlKqeoOajEDo8BqpKYQ=;
        b=B0g9NUKq+TI23mehXvf/Sr0mNff68GOYe4gaKz9j7o1KYcSUqF/hGluuY2hSkScH+h
         6blFMgK3IwGvP9JvTKShzld59J8DpsOhhyGIVgXTMY0dpr6FQ0jB78FWKZAghueLT9as
         I0YwhSe1S7fyJDW/lV7joqpaVAUNvMbWq8RTkntN3ibQGkVv15PB7XIYlYMlj7jVFSfo
         8vRRSmRuLmjYVVMdgVSBkkaX3ZkY9DsF/+mJwilC4ZpX84Y0u/gFiqNlv0tmYxSIqAB1
         KYfD37YHvDGP8yPP4pNNQ2Bs82jtYk5+r+JVq1sD6yJ8pbkqctQ4UyKXy+Zk7OUmQ1uB
         4EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lvpMUdPKFa7WYHIAbjoeqdpjJlKqeoOajEDo8BqpKYQ=;
        b=dBxzyT/a/SYpivxR37ns1XWPq36ILz8XrERmoCkSrfBrpVwzjv/7ThRcwld2+YebOd
         OH3HmK2Ot1SclhU7EncMoLyAJdcX6mmBROY92fEpdHhNUVBTd7X+5yySSREfkY3Ao8Cp
         SbLzk8LyJFJD0lagl+wJxuUn+RNStcAJi5z/Xu0DDjQhuD/6xft0OqOAeiUCAyEs3QZ+
         2kjq6jLA3N7ck9bL22bGS/C9pNiPJq0pIdknY+6eURIVofi5ZyzMdMyZMHzVtpHV2S2a
         PS+j4rTiqz7VV+qJjmZO751BvTw6Ih40Wr3pysUedHxbElrFTC6SwEI6fnrha4d3OB/v
         OXCg==
X-Gm-Message-State: AOAM532pM/GYUTS/6VMeEmdxRYQtH0g810OU/mfJ4fXlOagKlfp6d0Qf
        sOpYdYlgdqcHcWHhr+IWDOBM+w==
X-Google-Smtp-Source: ABdhPJzm6OmkxQjXES2Um2laFYZZ2opykX8Do7tI6wNeAQ89z68rHZRnH/lC84pIidwQKQ3y9dC/oQ==
X-Received: by 2002:aa7:9244:0:b029:19a:b335:754b with SMTP id 4-20020aa792440000b029019ab335754bmr3643258pfp.29.1606847249191;
        Tue, 01 Dec 2020 10:27:29 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q13sm401801pjq.15.2020.12.01.10.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 10:27:28 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:27:26 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] handling 4GB .idx files
Message-ID: <X8aLDlzcNCwP699c@nand.local>
References: <20201113050631.GA744608@coredump.intra.peff.net>
 <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
 <20201116041051.GA883199@coredump.intra.peff.net>
 <1403797985.37893.1606777048311@ox.hosteurope.de>
 <X8YnsGsUl53OKFno@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8YnsGsUl53OKFno@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 06:23:28AM -0500, Jeff King wrote:
> I'm not sure if EXPENSIVE is the right ballpark, or if we'd want a
> VERY_EXPENSIVE. On my machine, the whole test suite for v2.29.0 takes 64
> seconds to run, and setting GIT_TEST_LONG=1 bumps that to 103s. It got a
> bit worse since then, as t7900 adds an EXPENSIVE test that takes ~200s
> (it's not strictly additive, since we can work in parallel on other
> tests for the first bit, but still, yuck).
>
> So we're looking at 2-3x to run the expensive tests now. This new one
> would be 20x or more. I'm not sure if anybody would care or not (i.e.,
> whether anyone actually runs the whole suite with this flag). I thought
> we did for some CI job, but it looks like it's just the one-off in
> t5608.

I had written something similar yesterday before mutt crashed and I
decided to stop work for the day.

I have a sense that probably very few people actually run GIT_TEST_LONG
regularly, and that that group may vanish entirely if we added a test
which increased the runtime of the suite by 20x in this mode.

I have mixed feelings about VERY_EXPENSIVE. On one hand, having this
test checked in so that we can quickly refer back to it in the case of a
regression is useful. On the other hand, what is it worth to have this
in-tree if nobody ever runs it? I'm speculating about whether or not
people would run this, of course.

My hunch is that anybody who is interested enough to fix regressions in
this area would be able to refer back to the list archive to dig up this
thread and recover the script.

I don't feel strongly, really, but just noting some light objections to
checking this test into the suite.

Thanks,
Taylor
