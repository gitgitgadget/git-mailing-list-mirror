Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EAAC64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 16:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB9E21D7F
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 16:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbgLBQay (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 11:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgLBQax (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 11:30:53 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D333FC061A4E
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 08:30:26 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t3so1372166pgi.11
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 08:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u158R9XcVKN5N0YEvs9WPbxhu1XA8vCjHcLYavJbldo=;
        b=RMthrv8znBa4+5Dm8kJIfBL0/jcL/2sMij8Nqx2fJWbhCOgO17grW/GsHFyf4Ul6ne
         e66yaxVDs+jg70C5ATv8AQ6gJ4BULiWBb9h9E10uWKU7BTdrY1wCJdv4aUDXPROJynKw
         0Ndlig6FnyRmSGBHqHz2/fKwR3MWHnFPCSFhEDM3ANgrIaB3oW5dqSVaLRxuRfRGtsSa
         ZM4s1IzEy1R9zAtLca5OJ3laz/FeCAM8TXi4W5S4UcolR+2J//H0d3kl0IYwZ6BhgBE6
         vKRexIS8JUZnBrJTI9fJGjUYHM8xz8eebz3gQPTQGPDbR+2dx2YKHXfGOJzhck8oItw1
         7z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u158R9XcVKN5N0YEvs9WPbxhu1XA8vCjHcLYavJbldo=;
        b=c2aNwNn4w4ZXW1D+8iXh4BhbGqHJgdlf5r3VzHYMl6zhICmFFnDnxH1moDcAeXAr8B
         GaZ8poJjgrD52xjJ2SqGGy4MT8qKLoQ1YXFdWRHRcqatomu22w2FU9t1zQ3wmnziTQqX
         OJT6HZI8XNIhW6AsgYzhldgT0vX8ktpVEJkSmGySbpSHXsFqgyvicxwAfsW1xgbFLJcT
         wCAO+qNBSMPBe1K1A7sKY07LsIopDZuGrro1XV4e5PUkGKn5fDzm8YLBr126/zje0Ma3
         Ur6+E5UXmXXZviDPKOweWwLPCbC7ipssQbfIbQvQ7T2mL/UjSiPb0mVsRepVKyKLolNc
         HxJw==
X-Gm-Message-State: AOAM530Y9DAnHz+M4iP7dJmOJMnQEWr7CQBPig48sYSoqUis+Stp46Tq
        pMiFx1nJ5umRBYqNtgWJ1omDzw==
X-Google-Smtp-Source: ABdhPJx8KdJXDsc17cQPCYRFpNSaPcIqGMy7mhFWg9ACAFWD1hH5xvWpMMn2Fafx/pV5LQCyWHafew==
X-Received: by 2002:a63:4905:: with SMTP id w5mr602523pga.124.1606926626359;
        Wed, 02 Dec 2020 08:30:26 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w35sm186457pjj.57.2020.12.02.08.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 08:30:25 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:30:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, dstolee@microsoft.com,
        gitster@pobox.com, peff@peff.net, martin.agren@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 23/24] pack-bitmap-write: relax unique rewalk condition
Message-ID: <X8fBHz2A82hxUzV8@nand.local>
References: <1da4fa0fb85fe848aa86987e767b33d296f8f878.1605649533.git.me@ttaylorr.com>
 <20201202074439.3478090-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202074439.3478090-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 11:44:39PM -0800, Jonathan Tan wrote:
> Do you have numbers of how large the commit bitmasks are?

No, I didn't measure the size of the commit bitmasks directly, but they
are captured in the peak heap measurements that I took below.

> > In an effort to discover a happy medium, this change reduces the walk
> > for intermediate commits to only the first-parent history. This focuses
> > the walk on how the histories converge, which still has significant
> > reduction in repeat object walks. It is still possible to create
> > quadratic behavior in this version, but it is probably less likely in
> > realistic data shapes.
>
> Would this work? I agree that the width of the commit bitmasks would go
> down (and there would also be fewer commit bitmasks generated, further
> increasing the memory savings). But intuitively, if there is a commit
> that is selected and only accessible through non-1st-parent links, then
> any bitmaps generated for it cannot be contributed to its descendants
> (since there was no descendant-to-ancestor walk that could reach it in
> order to form the reverse edge).

s/bitmaps/bitmasks. We'll select commits independent of their first
parent histories, and so in the situation that you're describing, if C
reaches A only through non-1st-parent history, then A's bitmask will not
contain the bits from C.

But when generating the reachability bitmap for C, we'll still find that
we've generated a bitmap for A, and we can copy its bits directly. If
this differs from an ancestor P that _is_ in the first-parent history,
then P pushed its bits to C before calling fill_bitmap_commit() through
the reverse edges.

> > Here is some data taken on a fresh clone of the kernel:
> >
> >              |   runtime (sec)    |   peak heap (GB)   |
> >              |                    |                    |
> >              |   from  |   with   |   from  |   with   |
> >              | scratch | existing | scratch | existing |
> >   -----------+---------+----------+---------+-----------
> >     original |  64.044 |   83.241 |   2.088 |    2.194 |
> >   last patch |  44.811 |   27.828 |   2.289 |    2.358 |
> >   this patch | 100.641 |   35.560 |   2.152 |    2.224 |
>
> Hmm...the jump from 44 to 100 seems rather large.

Indeed. It's ameliorated a little bit in the later patches. We are
over-walking some objects (as in we are walking them multiple times),
but the return we get is reducing the peak heap usage from what it was
in the last patch.

In the "unfathomably large" category, this makes things tractable.

Thanks,
Taylor
