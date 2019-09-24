Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D991F463
	for <e@80x24.org>; Tue, 24 Sep 2019 21:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbfIXVgk (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 17:36:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:58944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387616AbfIXVgk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 17:36:40 -0400
Received: (qmail 11500 invoked by uid 109); 24 Sep 2019 21:36:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Sep 2019 21:36:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12852 invoked by uid 111); 24 Sep 2019 21:39:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2019 17:39:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Sep 2019 17:36:38 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     qemu-devel@nongnu.org, berrange@redhat.com, stefanha@gmail.com,
        Greg Kurz <groug@kaod.org>, git@vger.kernel.org,
        antonios.motakis@huawei.com, dgilbert@redhat.com,
        Ian Kelling <iank@fsf.org>
Subject: Re: git format.from (was: 9p: Fix file ID collisions)
Message-ID: <20190924213638.GE20858@sigill.intra.peff.net>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <56046367.TiUlWITyhT@silver>
 <20190923222415.GA22495@sigill.intra.peff.net>
 <3312839.Zbq2WQg2AT@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3312839.Zbq2WQg2AT@silver>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 11:03:38AM +0200, Christian Schoenebeck wrote:

> > Yes, the resulting mail would be correct, in the sense that it could be
> > applied just fine by git-am. But I think it would be uglier. IOW, I
> > consider the presence of the in-body From to be a clue that something
> > interesting is going on (like forwarding somebody else's patch). So from
> > my perspective, it would just be useless noise. Other communities may
> > have different opinions, though (I think I have seen some kernel folks
> > always including all of the possible in-body headers, including Date).
> > But it seems like it makes sense to keep both possibilities.
> 
> Exactly, current git behaviour is solely "prettier" (at first thought only 
> though), but does not address anything useful in real life.

I wouldn't agree with that. By being pretty, it also is functionally
more useful (I can tell at a glance whether somebody is sending a patch
from another author).

> Current git behaviour does cause real life problems though: Many email lists 
> are munging emails of patch senders whose domain is configured for requiring 
> domain's emails being DKIM signed and/or being subject to SPF rules (a.k.a 
> DMARC). So original sender's From: header is then automatically replaced by an 
> alias (by e.g. mailman): https://en.wikipedia.org/wiki/DMARC#From:_rewriting
> 
> For instance the email header:
> 
> From: "Bob Bold" <bold@foo.com>
> 
> is automatically replaced by lists by something like
> 
> From: "Bob Bold via Somelist" <somelist@gnu.org>
> 
> And since git currently always drops the From: line from the email's body if
> sender == author, as a consequence maintainers applying patches from such 
> lists, always need to rewrite git history subsequently and have to replace 
> patch author's identity manually for each commit to have their correct, real 
> email address and real name in git history instead of something like
> "Bob Bold via Somelist" <somelist@gnu.org>
> 
> So what do you find "uglier"? I prefer key info not being lost as default 
> behaviour. :-)

Sure, for your list that munges From headers, always including an
in-body From is way better. But for those of us _not_ on such lists, I'd
much prefer not to force the in-body version on them.

-Peff
