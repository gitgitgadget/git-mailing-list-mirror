Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917522076B
	for <e@80x24.org>; Thu,  3 Nov 2016 00:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750976AbcKCAIm (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 20:08:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:37793 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750798AbcKCAIm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 20:08:42 -0400
Received: (qmail 29739 invoked by uid 109); 3 Nov 2016 00:08:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 00:08:41 +0000
Received: (qmail 8084 invoked by uid 111); 3 Nov 2016 00:09:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 20:09:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 20:08:39 -0400
Date:   Wed, 2 Nov 2016 20:08:39 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103000839.fwmqqggvmhzo7zmx@sigill.intra.peff.net>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161102230538.jx3jwa4hqgrrltno@sigill.intra.peff.net>
 <20161102233304.GB183367@google.com>
 <20161102234613.GD183367@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102234613.GD183367@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2016 at 04:46:13PM -0700, Brandon Williams wrote:

> > > I thought at first we'd have to deal with leaking "v", but "get_value"
> > > is the "raw" version that gives you the uninterpreted value. I think
> > > that means it may give you NULL, though if we see an implicit bool like:
> > > 
> > >   [core]
> > >   allowProtocol
> > > 
> > > That's nonsense, of course, but we would still segfault. I
> > > think the easiest way to test is:
> > > 
> > >   git -c core.allowProtocol fetch
> > > 
> > > which seems to segfault for me with this patch.
> > 
> > what is the desired behavior when a user provides a config in a way that
> > isn't intended?
> 
> oh...I can just drop in git_config_get_string_const() instead.

Yes, it will call git_config_string(), which will make sure there's an
actual value and die otherwise. But note that it also duplicates the
string, so you'd have to deal with freeing it.

-Peff
