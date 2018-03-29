Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D881F424
	for <e@80x24.org>; Thu, 29 Mar 2018 22:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbeC2WR2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 18:17:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:48128 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750735AbeC2WR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 18:17:27 -0400
Received: (qmail 31220 invoked by uid 109); 29 Mar 2018 22:17:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 22:17:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23138 invoked by uid 111); 29 Mar 2018 22:18:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 18:18:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 18:17:25 -0400
Date:   Thu, 29 Mar 2018 18:17:25 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC/PATCH] upload-pack: disable object filtering when disabled
 by config
Message-ID: <20180329221725.GM2939@sigill.intra.peff.net>
References: <20180328203303.GA260688@aiede.svl.corp.google.com>
 <20180329215502.GK2939@sigill.intra.peff.net>
 <20180329220257.GA209272@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180329220257.GA209272@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 03:03:54PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Wed, Mar 28, 2018 at 01:33:03PM -0700, Jonathan Nieder wrote:
> 
> >> When upload-pack gained partial clone support (v2.17.0-rc0~132^2~12,
> >> 2017-12-08), it was guarded by the uploadpack.allowFilter config item
> >> to allow server operators to control when they start supporting it.
> >>
> >> That config item didn't go far enough, though: it controls whether the
> >> 'filter' capability is advertised, but if a (custom) client ignores
> >> the capability advertisement and passes a filter specification anyway,
> >> the server would handle that despite allowFilter being false.
> [...]
> > Great catch. If I understand correctly, this is an issue in the 2.17.0
> > release candidates. Is this worth delaying the release?
> 
> Yes, IMHO this is a release blocker.  (To put it another way, if this is
> going to delay the release, then we need to revert that patch.)

I think I'd agree on it being a release blocker. Given that your fix is
really a one-liner (3 of the lines are just changing the variable name,
which I agree with), I'd be fine with applying it on top rather than
reverting the original, even if it means delaying the release slightly.
It seems like about the same amount of risk to me.

(Sometimes it's actually _less_ risky to apply the one-liner fix,
because reverting a large feature can have unintended interactions with
other features that were built in the meantime.  Looking at the original
patch, though, I doubt that is the case here, hence my "about the same
amount of risk").

-Peff
