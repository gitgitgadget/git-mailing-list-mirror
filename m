Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B5D1F488
	for <e@80x24.org>; Tue,  7 May 2019 07:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEGHdY (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 03:33:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:49874 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726085AbfEGHdY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 03:33:24 -0400
Received: (qmail 18361 invoked by uid 109); 7 May 2019 07:33:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 07:33:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8958 invoked by uid 111); 7 May 2019 07:34:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 07 May 2019 03:34:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2019 03:33:22 -0400
Date:   Tue, 7 May 2019 03:33:22 -0400
From:   Jeff King <peff@peff.net>
To:     opal hart <opal@wowana.me>
Cc:     git@vger.kernel.org
Subject: Re: Cannot access git-scm.com with Tor
Message-ID: <20190507073322.GD28060@sigill.intra.peff.net>
References: <20190507070028.54c291af@clamav.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190507070028.54c291af@clamav.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 07:00:28AM +0000, opal hart wrote:

> I assume this community is at least slightly familiar with Tor and its
> usefulness, so I'll cut to the chase. The Git website git-scm.com is
> behind Cloudflare, which is currently configured to block suspicious
> requests which unfortunately include Tor users. It would be greatly
> appreciated to lower Cloudflare security settings to allow Tor users.
> If the additional traffic really becomes an issue (I see the website
> uses RoR backend [1]) then consider caching pages if that isn't already
> done.

The "security settings" toggle for the site on Cloudflare is already set
to "low", and there are no other restrictions. Is it actually blocking?
Or is it asking for a CAPTCHA?

I can drop it to "essentially off". I don't think the site is very high
risk.  The site is _basically_[1] serving up static content (which isn't
to say there couldn't be some attack against the rails infrastructure,
but it's not like people are logging in, or that there's any non-public
data on the site).

Using Cloudflare or some other caching layer is a necessity. We serve
about 50-60GB of traffic daily, over 98% of which is cached. The load
was quite high when the caching was all done at the Rails layer (though
I wouldn't rule out that there are ways to configure Rails to make this
more optimal; none of the people active in maintaining the site is
particularly knowledgeable there).

-Peff

[1] It actually could be a static site entirely; there was some push in
    that direction a while ago, but there's a lot of tedious work that
    never got finished. Of course, we'd still need a caching layer.
