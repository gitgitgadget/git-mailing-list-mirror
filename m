Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189B7208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 19:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbdHJTDw (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 15:03:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:34966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752728AbdHJTDw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 15:03:52 -0400
Received: (qmail 22698 invoked by uid 109); 10 Aug 2017 19:03:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 19:03:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8230 invoked by uid 111); 10 Aug 2017 19:04:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 15:04:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 15:03:49 -0400
Date:   Thu, 10 Aug 2017 15:03:49 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Kevin Willford <kcwillford@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] cache-tree: remove use of strbuf_addf in update_one
Message-ID: <20170810190349.jxlp6i7c6q5hpari@sigill.intra.peff.net>
References: <20170810184723.12424-1-kewillf@microsoft.com>
 <CAGZ79kaB7w+OD_8LOgqHjBJ8gCtXUGWPj7Cw8bWXEEQweqMaFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaB7w+OD_8LOgqHjBJ8gCtXUGWPj7Cw8bWXEEQweqMaFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 11:58:34AM -0700, Stefan Beller wrote:

> On Thu, Aug 10, 2017 at 11:47 AM, Kevin Willford <kcwillford@gmail.com> wrote:
> > String formatting can be a performance issue when there are
> > hundreds of thousands of trees.
> 
> When changing this for the sake of performance, could you give
> an example (which kind of repository you need for this to become
> a bottleneck? I presume the large Windows repo? Or can I
> reproduce it with a small repo such as linux.git or even git.git?)
> and some numbers how this improves the performance?

I was about to say the same thing. Normally I don't mind a small
optimization without numbers if the result is obviously an improvement.

But in this case the result is a lot less readable, and it's not
entirely clear to me that it would always be an improvement (we now
always run 3 strbuf calls instead of one, and have to check the length
for each one).

What I'm wondering specifically is if vsnprintf() on Kevin's platform
(which I'll assume is Windows) is slow, and we would do better to
replace it with a faster compat/ routine.

-Peff
