Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B39C1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 14:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbfILODe (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 10:03:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:47864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731816AbfILODe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 10:03:34 -0400
Received: (qmail 13560 invoked by uid 109); 12 Sep 2019 14:03:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Sep 2019 14:03:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7999 invoked by uid 111); 12 Sep 2019 14:05:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2019 10:05:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Sep 2019 10:03:33 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] upload-pack: disable commit graph more gently for
 shallow traversal
Message-ID: <20190912140332.GD23031@sigill.intra.peff.net>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <20190912001846.GA31370@sigill.intra.peff.net>
 <20190912020848.GB76228@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912020848.GB76228@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 11, 2019 at 10:08:48PM -0400, Taylor Blau wrote:

> > The test suite passes with my patch both with and without
> > GIT_TEST_COMMIT_GRAPH=1. But to my surprise, it also passes if I delete
> > the close_commit_graph() line added by 829a321569!
> >
> > So it's not clear to me whether this whole thing is truly unnecessary
> > (and Stolee was just being overly cautious because the code is related
> > to shallow-ness, even though it is OK doing a true-parent traversal
> > itself), or if we just don't have good test coverage for the case that
> > requires it.
> >
> > If it _is_ necessary, I'm a little worried there are other problems
> > lurking. The whole issue is that we've seen and parsed some commits
> > before we get to this shallow deepen-since code-path. So just disabling
> > commit-graphs isn't enough. Even without them, we might have parsed some
> > commits the old-fashioned way and filled in their parent pointers. Is
> > that a problem?
> 
> I am, too, but I don't think we should hold this patch up which is
> obviously improving the situation in the meantime while we figure that
> out.

Yeah, I'd agree here, unless we determine quickly that we do need the
bigger fix, and somebody with a bit more knowledge of this shallow code
offers a fix. I believe my patch is a strict improvement, and puts the
commit-graph code path on par with the regular one.

-Peff
