Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705431F4DD
	for <e@80x24.org>; Wed, 30 Aug 2017 03:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbdH3DGQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 23:06:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:52496 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751875AbdH3DGP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 23:06:15 -0400
Received: (qmail 26427 invoked by uid 109); 30 Aug 2017 03:06:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 03:06:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15532 invoked by uid 111); 30 Aug 2017 03:06:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 23:06:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Aug 2017 23:06:13 -0400
Date:   Tue, 29 Aug 2017 23:06:13 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [RFC 0/7] transitioning to protocol v2
Message-ID: <20170830030612.qjss3ygouardxi6k@sigill.intra.peff.net>
References: <20170824225328.8174-1-bmwill@google.com>
 <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
 <20170825173550.GJ13924@aiede.mtv.corp.google.com>
 <2ff0ead4-e13a-220e-f858-36ab206c1485@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ff0ead4-e13a-220e-f858-36ab206c1485@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 04:08:25PM -0400, Jeff Hostetler wrote:

> I just wanted to jump in here and say I've done some initial
> testing of this against VSTS and so far it seems fine.  And yes,
> we have a custom git server.

Great, thank you for checking.

> VSTS doesn't support the "git://" protocol, so the double-null trick
> isn't an issue for us.  But "https://" worked just fine.  I'm still
> asking around internally whether we support passing SSH environment
> variables.

The key thing for ssh is not whether you support passing environment
variables. It's whether you quietly ignore unknown variables rather than
cutting off the connection.

To support the v2 protocol you'd need to pass the new variables, but
you'd also need to modify your server to actually do something useful
with them anyway. At this point we're mostly concerned with whether we
can safely pass the variables to current implementations unconditionally
and get a reasonable outcome.

To be honest, I'm not all that worried about VSTS either way. It's a
centralized service which will likely get v2 extensions implemented in a
timely manner (once they exist). I'm much more concerned about
shrink-wrap implementations deployed in the wild, which may hang around
without being upgraded for years. If v2-aware clients send requests that
cause those old implementations to choke, users won't be happy.

-Peff
