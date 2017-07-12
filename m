Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2286A202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 18:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbdGLSdo (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 14:33:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:38248 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752354AbdGLSdn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 14:33:43 -0400
Received: (qmail 4402 invoked by uid 109); 12 Jul 2017 18:33:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 18:33:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25902 invoked by uid 111); 12 Jul 2017 18:33:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 14:33:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jul 2017 14:33:40 -0400
Date:   Wed, 12 Jul 2017 14:33:40 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH 0/3] Convert grep to recurse in-process
Message-ID: <20170712183340.ry2bgv73wz2ownkj@sigill.intra.peff.net>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170712074220.565z3gahruqb2e7q@sigill.intra.peff.net>
 <20170712180603.GE65927@google.com>
 <20170712181717.uj7paoz5btfv7ocz@sigill.intra.peff.net>
 <20170712182447.GF93855@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170712182447.GF93855@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 11:24:47AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Wed, Jul 12, 2017 at 11:06:03AM -0700, Brandon Williams wrote:
> 
> >> Each 'struct repository' does have its own config so we could
> >> potentially want a config in a submodule to override some config in the
> >> superproject.  Though for right now it may be simpler to not worry about
> >> doing this overriding, mostly because you would only want to allow
> >> overriding of some configuration and not all configuration.  One example
> >> would be the number of threads allowed in grep,
> [...]
> > I think that's probably one of the more complicated cases, and I don't
> > think it really needs to be done on day one.
> 
> That's fair.  Could you give an example of a simpler case?

I think core.quotepath that I gave is one example that I'd expect to
work differently than it does in 'next'. Though I really think that's a
fairly uninteresting one, as it's extremely unlikely to be set on a
per-repo basis.

Something like color.grep.* is in the same boat (I think it ought to
respect submodule config, but I'd be surprised if anybody cares).

I know those are kind of lame examples, and if they remain broken
forever, I don't know if anybody would care. I'm more concerned about us
missing a case that causes a regression (and unlike some regressions,
where you say "oops, a bug" and fix it, I'd worry that we'll have made a
big jump to an in-process model, and the only fixes are "implement a
complete split-config solution" or "revert back to multiple processes").

I do agree that not having concrete examples makes it harder to reason
about the desired semantics.

-Peff
