Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC5FC433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 18:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ2Sak (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 14:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ2Sai (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 14:30:38 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7095B31DF5
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:30:37 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d123so2267422iof.7
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yDdr6ADTMrrzFnOJmINAJdOc0pmQ0RGoJfHo3kPpFIU=;
        b=W9RmDXZrvkj+lsICrmxi8F7t/vX/8zMPsTfbKQv6D61wKJXwCFKTrURYf7XwYWfBC7
         g5TnGDg+JH1WJi7pj8i4sJKrYdO23jASk34xFtz74owHv5eQJ6MPB9mXByRvcnav2SQh
         nfyfUbP87FCJHmlELTHtrIhIGnrHJsPnFvHXXqCeg75AhA7KkO72u1g9vSuMHcVZVCJN
         da9/H+R3HAUgRu2p7RJt62gEhxje4/wuzqJIgxmF+K7MJEfQpekDO1uuefSQyT1ZA4I6
         SPZhVhViENciL5dd65s1FbBfca8JP7hMjk1aq8GnFvRvSuy1b9K5hCgbLLfMo8qoj35m
         v1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDdr6ADTMrrzFnOJmINAJdOc0pmQ0RGoJfHo3kPpFIU=;
        b=FJQ8S0Vr/i7kYtcRj/dZ7gEYmpOXmVNa+FvqsUTO5C+kk2Czm4mpvh0DpU+IS/MYzN
         6PqfNLQqL9355OwPhN9yf4DwmMjmlgzjFnudZlGmThz2+v7eqmVGQazkhvruJ6S5LJP9
         vDrjiY9qV1RP1nYE3DoGWfWHvr9lDEEIcyRfisiU58vJJr0st+hp1KREpqyb8zZGBL5A
         0ymZLAV/hDfwnzTWNMCm0W6rKtkk6fpYx7r0eVVhwV3WUez2FccnHDFa4yrua+GvFSs/
         1LQJ/opdGCircx9pVUw+z8019an6zjOawXopZEuyAOlS+1slfUC3jJ4u83EgNvrjxe37
         Lh8Q==
X-Gm-Message-State: ACrzQf1nl0alOwRvFFEpiXUI8tpAwAkwOHTNboY6dv9DRlKSrrD4dlXa
        5eGIU+nyzB1uXq88uyb2WM6CHg==
X-Google-Smtp-Source: AMsMyM5wVP2MDked2MSJRivUDMZ3Br0olA40cKi/yOp9exNM8uot2ENbhNelv9H2v9TuPDmCeXw1fg==
X-Received: by 2002:a05:6638:4803:b0:363:c2ad:878 with SMTP id cp3-20020a056638480300b00363c2ad0878mr2790515jab.230.1667068236828;
        Sat, 29 Oct 2022 11:30:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cx4-20020a056638490400b0035678e2e175sm843709jab.50.2022.10.29.11.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 11:30:36 -0700 (PDT)
Date:   Sat, 29 Oct 2022 14:30:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] use child_process member "args" instead of string
 array variable
Message-ID: <Y11xS9Epq2rHiVkH@nand.local>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <0e889c96-6004-96e4-9505-19ce1e7f9900@web.de>
 <221027.86zgdh9cqg.gmgdl@evledraar.gmail.com>
 <6c30a1f6-8d89-31b9-faf8-c695c46173cd@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c30a1f6-8d89-31b9-faf8-c695c46173cd@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 04:23:31PM +0200, René Scharfe wrote:
> > A lot of your 3-lines would be 1 lines if we just had e.g. (untested,
> > and could be a function not a macro, but you get the idea):
> >
> > 	#define run_command_git_simple(__VA_ARGS__) \
> > 		struct child_process cmd = CHILD_PROCESS_INIT; \
> > 		cmd.git_cmd = 1; \
> > 		strvec_pushl(&cmd.args, __VA_ARGS__); \
> > 		run_command(&cmd);
> >
> > But maybe nobody except me thinks that's worthwhile...
>
> I have similar temptations; you could see that in my scratch patch
> https://lore.kernel.org/git/9d924a5d-5c72-fbe6-270c-a8f6c5fc5850@web.de/
> which added run_git_or_die() in builtin/gc.c.  Why, oh why?  Perhaps
> because taking a blank form (CHILD_PROCESS_INIT), ticking boxes
> (.git_cmd = 1), filling out text fields (strvec_push(...)) and
> submitting it (run_command()) feels tedious and bureaucratic, Java-esque
> even.  And some patterns appear again and again.
>
> How bad is that?  Is it bad at all?  I think overall we should try to
> reduce the number of external calls and make those we have to do
> self-documenting and leak-free.  A bit of tedium is OK; this API should
> be used rarely and sparingly.  Still I get the urge to search for
> patterns and define shortcuts when I see all those similar calls..
>
> run_command_git_simple as defined above wouldn't compile, but I get it.
> Reducing the number of lines feels good, but it also makes the code less
> flexible -- adding a conditional parameter requires converting back to
> run_command().

For what it's worth, I agree. I don't think there are or should be any
hard and fast rules about when extracting a pattern like this into a
function or macro is right. But here it feels wrong and
counterproductive to the goal of this series.

My main gripe with it is that it seems to be overfit to these small
handful of calls, and that changing it in the future would require us to
go and update existing callers to accommodate new functionality in other
callers.

So I'd prefer to see it left alone.

Thanks,
Taylor
