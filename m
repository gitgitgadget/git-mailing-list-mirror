Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1FE208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 17:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757473AbdHYRlv (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 13:41:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:49348 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1757454AbdHYRlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 13:41:50 -0400
Received: (qmail 1636 invoked by uid 109); 25 Aug 2017 17:41:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Aug 2017 17:41:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20206 invoked by uid 111); 25 Aug 2017 17:42:18 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Aug 2017 13:42:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Aug 2017 10:41:46 -0700
Date:   Fri, 25 Aug 2017 10:41:46 -0700
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [RFC 0/7] transitioning to protocol v2
Message-ID: <20170825174145.x6oa7btkpy5yii54@sigill.intra.peff.net>
References: <20170824225328.8174-1-bmwill@google.com>
 <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
 <20170825173550.GJ13924@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170825173550.GJ13924@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 10:35:50AM -0700, Jonathan Nieder wrote:

> > Sadly, while splitting these things apart makes the protocol
> > conceptually cleaner, I'm not sure if we can consider them separately
> > and avoid adding an extra round-trip to the protocol.
> 
> How about the idea of using this mechanism to implement a protocol
> "v1"?
> 
> The reply would be the same as today, except that it has a "protocol
> v1" pkt-line at the beginning.  So this doesn't change the number of
> round-trips --- it just validates the protocol migration approach.

I'm not that worried about validating the ideas here to shoe-horn a
version field. I'm worried about what "step 2" is going to look like,
and whether "we shoe-horned a version field" can be extended to "we
shoe-horned arbitrary data".

Maybe those are the same thing, and validating the first validates the
second. But I don't think it's a foregone conclusion.

> > Current git.git servers, I assume?. How much do we want to care about
> > alternate implementations? I would not be surprised if other git://
> > implementations are more picky about cruft after the virtual-host field
> > (though I double-checked GitHub's implementation at least, and it is
> > fine).
> 
> FWIW JGit copes fine with this.

Thanks for checking.

> > I don't think libgit2 implements the server side. That leaves probably
> > JGit, Microsoft's VSTS (which I think is custom), and whatever Atlassian
> > and GitLab use.
> 
> I'd be happy if someone tests the patches against those. :)

Me too. I don't have an easy setup for the last 3.

> >                        Or alternatively, I guess make this optional to
> > start with, and let early adopters turn it on and complain to their server
> > vendors for a while before flipping the default to on.
> 
> Can we do that by making it a patch / letting it cook for a while in
> 'next'? :)

If people actually ran 'next', that would help. I was hoping that we
could get it out to the masses behind a feature flag, and dangle it in
front of them with "this will improve fetch performance if you turn it
on". But that carrot implies going all the way through the follow-on
steps of designing the performance-improving v2 extensions and getting
them implemented on the server side.

-Peff
