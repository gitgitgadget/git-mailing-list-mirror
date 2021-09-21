Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C753C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10EDD6023D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhIUQgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhIUQgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:36:49 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9406FC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:35:20 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id v16so23454454ilg.3
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NC3xZGFLrG/kLxSzKZmkkrvTCHY+YCp/L7pe3qwaahs=;
        b=6cGBLGOoel0nwcl9j8NEqrpS2mjrdu734Uef+cF6VoAEB6vHca0kfqZEw0iKzS9h7d
         vXfnlI6UPbNCeV/kGW+joA15DZ947ouVSrZsT5uDkCydzZxZ8rIJC06VBFymZV5lBf+J
         NEmllRT652rxkHWRcHowmo5bZypIn/RlNyK1OZKrZrDFv5oguQzwp5bow3WkEoZLugzD
         nWWa1PnEZ8PSrcZ6u0c/yxQKUY0Bod2ZKTC0LOYyZhpy4c35eqg94hqM1f8AlUMyvvZy
         Iw60WClWZrTt01HqEety1ef2WfOfQuhXRN/jjqs1JTGhTKj02nchDJFsBfta6XQeVT3n
         TQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NC3xZGFLrG/kLxSzKZmkkrvTCHY+YCp/L7pe3qwaahs=;
        b=SzjvQ1p+MqPpKy0qlCy+IrH6zPrPOo96FfhLG/ZtT5doKrRTpWjuhfmbU7woq9X9VX
         sJ+duBPJklAc0MPdBkBCg3xoSseFOwyQ29eKJdm/g3VyBN2Mmdg4YQ64T9aXP/tN0g43
         V3iuVNu/8XNYRPoe0ktt2lbKPQ3IpHfl0Wz4CZN1grrcnRwWHZtMrJAWJoEaHaStlm75
         Puk91PoYwREYIMwXAFUyb685T3Os0kTRAH1fu9CyQPsP0uF6t2znRJbGJgD1bmfGM1nS
         kUyYPn3FsBB6QKmAZHMXGCz7waT2ZkMYMfJrBr39bWKdBuh2saiCk9DQ+fc4y6bQlSgz
         jXrA==
X-Gm-Message-State: AOAM531HOT3mFCsgDkn/JTIgFvRltImG78HgBdfybHbXMIjaF2n27qLk
        O+C5sCz2gRwdbQ7mRVR1fBvbMQ==
X-Google-Smtp-Source: ABdhPJwamWIyG07hjCUutQ5J+vLiWrZAVWdXukmXMP8mRuy1dKrbWwka3QxYqBqWginYXfC2c1EMMQ==
X-Received: by 2002:a92:c98d:: with SMTP id y13mr22616274iln.157.1632242119436;
        Tue, 21 Sep 2021 09:35:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c5sm2006048iob.17.2021.09.21.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:35:19 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:35:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, calbabreaker@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] sparse-checkout: fix OOM error with mixed patterns
Message-ID: <YUoJxgiWcl/Wcqce@nand.local>
References: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
 <d90937b9ac9aaa6170f56d18ddb7a327b2af27d6.1632160658.git.gitgitgadget@gmail.com>
 <YUjRziaIoVtJWGsS@nand.local>
 <6d565e1d-a31f-7cf0-9c10-a01a87fead41@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d565e1d-a31f-7cf0-9c10-a01a87fead41@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 09:06:59AM -0400, Derrick Stolee wrote:
> > If we are preparing to make it so that we do not blindly copy patterns
> > from a sparse checkout without cone mode enabled, then wouldn't this new
> > case be a BUG()?
> >
> > Of course, users could still tweak the contents of their sparse-checkout
> > file as they wish, but I'd expect that we'd catch those cases, too
> > (i.e., by validating the contents of the existing sparse-checkout before
> > calling this function).
>
> If I was more confident that we were catching absolutely every possible
> case of non-cone mode patterns in our parsing logic, then I suppose a BUG()
> could apply here. At minimum, at this point in time (before fixing the gap
> in parsing in patch 3) the test below would not even work with test_must_fail,
> since the exit code would be unexpected.

Right, but it could be a test_must_fail after the second patch, no?

Not calling BUG() is fine with me if you think there may be other cases
we haven't discovered. But we should have some way to discover them
instead if a user can generate them organically. Maybe a warning()?

> >> +	git -C bad-patterns sparse-checkout add dir
> >> +'
> >> +
> >
> > In other series I've suggested a cosmetic change to move all of these to
> > a sub-shell that begins with "cd bad-patterns &&", but obviously that is
> > a relatively unimportant suggestion.
>
> The only defense I have for not using a subshell and 'cd' is that later
> I can use an "expect" file in my current directory without it being "in"
> the repository. It doesn't really matter for this example, but it has in
> the past, causing me to do this by habit. A tab is smaller than the string
> " -C bad-patterns", so it's probably worth changing.

Yeah. I admit to hardly caring about this (subshell vs. '-C
bad-patterns') at all. Either is completely fine with me.

Thanks,
Taylor
