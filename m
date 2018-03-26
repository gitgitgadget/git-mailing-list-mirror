Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89281F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 07:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeCZHZI (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 03:25:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:42824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751134AbeCZHZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 03:25:07 -0400
Received: (qmail 3106 invoked by uid 109); 26 Mar 2018 07:25:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 07:25:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17331 invoked by uid 111); 26 Mar 2018 07:26:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 03:26:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 03:25:05 -0400
Date:   Mon, 26 Mar 2018 03:25:05 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local
 branch
Message-ID: <20180326072505.GA12436@sigill.intra.peff.net>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
 <20180325041056.GA22321@sigill.intra.peff.net>
 <CAPig+cRe9AmFv=GCxPOo5vcLGFuT1qdM60M4KV5P6UN+Ai-QoQ@mail.gmail.com>
 <20180325043337.GA32465@sigill.intra.peff.net>
 <CA+P7+xr2-OidiX9ve6GwOR4pSOe4Gn=A3Aow5L=oLZgZE+XqMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xr2-OidiX9ve6GwOR4pSOe4Gn=A3Aow5L=oLZgZE+XqMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 12:15:42AM -0700, Jacob Keller wrote:

> >   3. Drop "-l" (probably with a deprecation period); it seems unlikely
> >      to me that anybody uses it for branch creation, and this would at
> >      least reduce the confusion (then it would just be "so why don't we
> >      have -l" instead of "why is -l not what I expect").
> 
> Personally, I'd prefer this, because it's minimal effort on scripts
> part to fix themselves to use the long option name for reflog, and
> doesn't cause that much heart burn.
> 
> >
> >   4. Repurpose "-l" as a shortcut for --list (also after a deprecation
> >      period). This is slightly more dangerous in that it may confuse
> >      people using multiple versions of Git that cross the deprecation
> >      line. But that's kind of what the deprecation period is for...
> 
> I don't think this is particularly all that valuable, since we default
> to list mode so it only helps if you want to pass an argument to the
> list mode (since otherwise we'd create a branch). Maybe it could be
> useful, but if we did it, I'd do it as a sort of double deprecation
> period where we use one period to remove the -l functionality
> entirely, before adding anything back. I think the *gain* of having -l
> is not really worth it though.

OK, so here's some patches. We could do the first three now, wait a
while before the fourth, and then wait a while (or never) on the fifth.

  [1/5]: t3200: unset core.logallrefupdates when testing reflog creation
  [2/5]: t: switch "branch -l" to "branch --create-reflog"
  [3/5]: branch: deprecate "-l" option
  [4/5]: branch: drop deprecated "-l" option
  [5/5]: branch: make "-l" a synonym for "--list"

 Documentation/git-branch.txt |  3 ++-
 builtin/branch.c             |  4 ++--
 t/t1410-reflog.sh            |  4 ++--
 t/t3200-branch.sh            | 34 +++++++++++++++++-----------------
 4 files changed, 23 insertions(+), 22 deletions(-)

-Peff
