Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54E2C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 22:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B525D6194D
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 22:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFYWYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 18:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFYWYV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 18:24:21 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C347C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 15:21:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t9so9334696pgn.4
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9DEs8H8f9spz82fD1xq/Fz/0AYA5mf62VrukJqrYKBg=;
        b=ajAFdOdPE4tva5Ub8czCJz+Royb7W9X7GaLd9k/ycXiS90FQheNJvjrnInhdOXtYjf
         QzlKtiYtUIAbul6/6jaoH72ne079kl3LgDW4B/YGUbyC/bRF/tTRY/RcMMyCdoNnIUxq
         QxXTeXfA2jWQjxMJVHtUaPgjPKY0uo/w0e+5Uep+GXzxFevUwTbSZS0zYUfoLDDKlAc3
         JJB63YCY2l7ZAvtWkGHouJRbSZOuqI0LPPCfHSbzXtcj14CydNNCHehukLwNjb4A5v2A
         fgPE2SBy465p3K3ofQG0rX0DK0B3+wLIDWbdhwqrLN4RAqt59CtSwdigUrruSiCbeViL
         KqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9DEs8H8f9spz82fD1xq/Fz/0AYA5mf62VrukJqrYKBg=;
        b=gtz6kmDWBoOyJ+XUUtijKRchkZWE3Y9DqW1queyf+qm45wjoFQaG42ErE1j0zA/iPD
         1v7eH1QLrPFgmrcyvCGEOCAFopXAYzRUpYEtcbu9GinnRDUTttiNvjFZvTtCNe49pWPC
         aiFZC4PjVfrrlBg5zQx2JgbqOufBPRDmxIzAQg8NTpJRZmXIwEuBuY6fVxRbu26/aj1h
         NiMDpXLHBknewPC2o9zFOdudUcn/Q2DQQiCHNmFMEsNYVBDacVlfizifh4H7CVduYuao
         lkWVihnsnzHHs1Woq71qHJAPxRG3lwIeTPgaMlterqR8T4mS5Bs/QMe43LZ6rMtb2gww
         PkRw==
X-Gm-Message-State: AOAM531vysrwZmOU7pVT9La5J0lxVAI9Xz8z3g1NnuAx4hCWZKcAs4EM
        BYPli845fWmMWl1qN4co0/JA7A==
X-Google-Smtp-Source: ABdhPJwSKyAfendRJF6QGmB2LtwTKXfsGzQbHzi6BldCeIkaouctF/dDCwPjygOH13QnthpXq/50VQ==
X-Received: by 2002:aa7:8806:0:b029:302:f067:7b52 with SMTP id c6-20020aa788060000b0290302f0677b52mr12740559pfo.13.1624659718572;
        Fri, 25 Jun 2021 15:21:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:6dde:833a:183c:933b])
        by smtp.gmail.com with ESMTPSA id s63sm6254433pjj.35.2021.06.25.15.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 15:21:57 -0700 (PDT)
Date:   Fri, 25 Jun 2021 15:21:51 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2021, #06; Thu, 17)
Message-ID: <YNZW/zsk93Oi/8uY@google.com>
References: <xmqqr1h1mc81.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1h1mc81.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 11:55:26AM +0900, Junio C Hamano wrote:
> * es/trace2-log-parent-process-name (2021-06-09) 1 commit
>  - tr2: log parent process name
> 
>  trace2 logs learned to show parent process name to see in what
>  context Git was invoked.
> 
>  Will merge to 'next'?

I've still not seen much in the way of reviews on this series; mostly
Randall and I have been talking about ramifications for NonStop, but
those conversations haven't resulted in changes to the series itself.
I think it's fine to merge, but I wrote it, so you shouldn't trust my
opinion. :)

We've been running this series internally at Google, though, and it
looks like we do want to look up more ancestors than just the one
generation, after all. However, I'd prefer to send that as a follow-on
patch, compared stalling this topic further.

We do have some early insights from these, though. One interesting
observation is that it appears Git is more often invoked via some
wrapper than interactively; that's not too surprising given that we have
a lot of builders who perform Git operations.

Anyway, all this to say that we've found this trace useful at Google and
it's working well for us. Anybody interested in a speedy review would be
very welcome.

 - Emily
