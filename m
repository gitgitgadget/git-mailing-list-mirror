Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9117820254
	for <e@80x24.org>; Tue, 28 Feb 2017 01:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbdB1BUU (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 20:20:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:35324 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbdB1BUS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 20:20:18 -0500
Received: (qmail 11606 invoked by uid 109); 28 Feb 2017 00:53:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 00:53:05 +0000
Received: (qmail 22024 invoked by uid 111); 28 Feb 2017 00:53:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 19:53:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 19:53:02 -0500
Date:   Mon, 27 Feb 2017 19:53:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [BUG] branch renamed to 'HEAD'
Message-ID: <20170228005302.k6fyfinaxyl3ti76@sigill.intra.peff.net>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
 <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
 <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net>
 <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
 <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net>
 <xmqq60jvnu9y.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xpVt6NtSajqMX8OQ_SKdC9tfHH40JgK=9DgBxo9nMaWLA@mail.gmail.com>
 <xmqqzih7kvbz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzih7kvbz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 04:33:36PM -0800, Junio C Hamano wrote:

> A flag to affect the behaviour (as opposed to &flag as a secondary
> return value, like Peff's patch does) can be made to work.  Perhaps
> a flag that says "keep the input as is if the result is not a local
> branch name" would pass an input "@" intact and that may be
> sufficient to allow "git branch -m @" to rename the current branch
> to "@" (I do not think it is a sensible rename, though ;-).  But
> probably some callers need to keep the original input and compare
> with the result to see if we expanded anything if we go that route.
> At that point, I am not sure if there are much differences in the
> ease of use between the two approaches.

I just went into more detail in my reply to Jacob, but I do think this
is a workable approach (and fortunately we seem to have banned bare "@"
as a name, along with anything containing "@{}", so I think we would end
up rejecting these nonsense names).

I'll see if I can work up a patch. We'll still need to pass the flag
around through the various functions, but at least it will be a flag and
not a confusing negated out-parameter.

-Peff
