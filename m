Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9220C1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbfHZSVg (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:21:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:56154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730248AbfHZSVg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:21:36 -0400
Received: (qmail 6457 invoked by uid 109); 26 Aug 2019 18:21:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Aug 2019 18:21:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22384 invoked by uid 111); 26 Aug 2019 18:22:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Aug 2019 14:22:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Aug 2019 14:21:35 -0400
From:   Jeff King <peff@peff.net>
To:     randall.s.becker@rogers.com
Cc:     'Bryan Turner' <bturner@atlassian.com>,
        'Git Users' <git@vger.kernel.org>
Subject: Re: [Question] clone performance
Message-ID: <20190826182134.GA23399@sigill.intra.peff.net>
References: <005f01d55a1f$88e2ab20$9aa80160$@rogers.com>
 <CAGyf7-HyJGVX51YMH0uqah4dkwkwfs6pLR5eSVBCeRQ1Ou=ZjQ@mail.gmail.com>
 <006001d55c18$e6def6c0$b49ce440$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <006001d55c18$e6def6c0$b49ce440$@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 10:16:48AM -0400, randall.s.becker@rogers.com wrote:

> On August 24, 2019 5:00 PM, Bryan Turner wrote:
> > On Fri, Aug 23, 2019 at 6:59 PM <randall.s.becker@rogers.com> wrote:
> > >
> > > Hi All,
> > >
> > > I'm trying to answer a question for a customer on clone performance.
> > > They are doing at least 2-3 clones a day, of repositories with about
> > > 2500 files and 10Gb of content. This is stressing the file system.
> > 
> > Can you go into a bit more detail about what "stress" means? Using too
> > much disk space? Too many IOPS reading/packing? Since you specifically
> > called out the filesystem, does that mean the CPU/memory usage is
> > acceptable?
> 
> The upstream is BitBucket, which does a gc frequently. I'm not sure
> any of this is relating to the pack structure. Git is spending most of
> its time writing the large number of large files into the working
> directory - it is stress mostly the disk, with a bit on the CPU
> (neither is acceptable to the customer). I am really unsure there is
> any way to make things better. The core issue is that the customer
> insists on doing a clone for every feature branch instead of using
> pull/checkout. I have been unable to change their mind - to this point
> anyway.

Yeah, at the point of checkout there's basically no impact from anything
the server is doing or has done (technically it could make things worse
for you by returning a pack with absurdly long delta chains or
something, but that would be CPU and not disk stress).

I doubt there's much to optimize in Git here. It's literally just
writing files to disk as quickly as it can, and it sounds like disk
performance is your bottleneck.

-Peff
