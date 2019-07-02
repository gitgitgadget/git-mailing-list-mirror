Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6021F461
	for <e@80x24.org>; Tue,  2 Jul 2019 05:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfGBFWq (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 01:22:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:57040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725789AbfGBFWq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 01:22:46 -0400
Received: (qmail 30637 invoked by uid 109); 2 Jul 2019 05:22:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Jul 2019 05:22:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11820 invoked by uid 111); 2 Jul 2019 05:23:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Jul 2019 01:23:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jul 2019 01:22:44 -0400
Date:   Tue, 2 Jul 2019 01:22:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] test-lib: introduce test_commit_bulk
Message-ID: <20190702052243.GB16344@sigill.intra.peff.net>
References: <20190628093751.GA3569@sigill.intra.peff.net>
 <20190629045322.GA8155@sigill.intra.peff.net>
 <xmqq36jp5qzm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36jp5qzm.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 01, 2019 at 03:28:45PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   - replace eval formatting magic with "%s" printf formatters (safer and
> >     gets rid of quoting issues in the callers).
> 
> This one actually made me think twice about safety, as we'd be using
> end-user supplied formatting string without any inspection.  I think
> it is fine as it is merely a test helper.

Yeah, and most shells do something sensible with nonsense formats.
E.g., "%s %s" will yield an empty string for the second one in both dash
and bash (and that's what POSIX says, though I'd be happy with any
implementation that avoids segfaulting).

> If somebody is later making it into a test-tool function, I expect
> that our interpolation engine, not the bare sprintf(), would be used
> there, and it would hopefully also be safe?

Yes, that was exactly my plan. It would also let you mention the number
more than once in the format, though I doubt any callers would care
about that feature.

I also think more potential callers could be converted if the refname
was formatted, too (e.g., some of them seem to write to branch-1,
branch-2, etc). I drew the line there, but anybody is welcome to explore
it further.

-Peff
