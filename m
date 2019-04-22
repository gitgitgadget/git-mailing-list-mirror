Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF771F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 21:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfDVVtD (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 17:49:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:37316 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726638AbfDVVtD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 17:49:03 -0400
Received: (qmail 7304 invoked by uid 109); 22 Apr 2019 21:49:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 21:49:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3186 invoked by uid 111); 22 Apr 2019 21:49:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 17:49:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 17:49:01 -0400
Date:   Mon, 22 Apr 2019 17:49:01 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
Message-ID: <20190422214901.GA14528@sigill.intra.peff.net>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1555487380.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 17, 2019 at 12:58:31AM -0700, Denton Liu wrote:

> Thanks for the feedback.  I couldn't find a tool that could selectively
> fix indentation on patches so I went through and manually realigned the
> parameter lists wherever the tools mangled the alignment. I guess this
> also implies that one pair of (tired) human eyes has manually inspected
> the machine-generated diff.
> 
> Hopefully, patch 3/4 won't be as onerous to review as it was to write ;)

Thanks. I looked over these manually and didn't find any problems (which
isn't to say there aren't any, but now at least two sets of tired eyes
looked at them :) ).

This kind of cleanup is painful, but at least it should be done with
after this, so I'm in favor of moving it forward. Two minor notes,
though:

>  compat/mingw.c                    |   2 +-
>  compat/mingw.h                    |   6 +-
>  compat/nedmalloc/malloc.c.h       |   6 +-
>  compat/obstack.h                  |  14 +-
>  compat/poll/poll.h                |   2 +-
>  compat/regex/regex.h              |  66 ++---
>  compat/win32/pthread.h            |   8 +-

We sometimes avoid touching compat/ code for style issues because it's
copied from elsewhere. And diverging from upstream is more evil than a
pure style issue. So potentially we could drop these hunks (though I
think maybe mingw is our own thing?).

>  contrib/coccinelle/noextern.cocci |   6 +

I have mixed feelings on this cocci script. I'm happy to _see_ it, as
it's important to show how the transformation was done. But for most of
the other scripts, we expect programmers to introduce new cases that
need converting, and we'd like to catch those automatically. Here I find
it reasonably unlikely for a lot of "extern" to slip in, with the
exception of some topics in flight.

And these coccinelle scripts are kind of expensive to run. So I wonder
if the tradeoff is worth it here (perhaps it is now, as we catch those
topics in flight, it might be worth dropping this one in a few months).

At any rate, thanks for doing all of this tedious work. :)

-Peff
