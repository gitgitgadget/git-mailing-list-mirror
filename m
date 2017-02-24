Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E410201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 21:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbdBXV2Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:28:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:33657 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbdBXV2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:28:15 -0500
Received: (qmail 14020 invoked by uid 109); 24 Feb 2017 21:26:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 21:26:20 +0000
Received: (qmail 28990 invoked by uid 111); 24 Feb 2017 21:26:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 16:26:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 16:26:18 -0500
Date:   Fri, 24 Feb 2017 16:26:18 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] parse_config_key: allow matching single-level config
Message-ID: <20170224212618.qwegffvga4p4n4o7@sigill.intra.peff.net>
References: <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
 <20170224210802.rpr5vdpqhsp3pt5v@sigill.intra.peff.net>
 <xmqqzihbz3nz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzihbz3nz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 01:20:48PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The parse_config_key() function was introduced to make it
> > easier to match "section.subsection.key" variables. It also
> > handles the simpler "section.key", and the caller is
> > responsible for distinguishing the two from its
> > out-parameters.
> >
> > Most callers who _only_ want "section.key" would just use a
> > strcmp(var, "section.key"), since there is no parsing
> > required. However, they may still use parse_config_key() if
> > their "section" variable isn't a constant (an example of
> > this is in parse_hide_refs_config).
> 
> Perhaps "only" at the end of the title?

Yeah, that would be an improvement.

> After grepping for call sites of this function, I think we can
> simplify quite a few instances of:
> 
> 	if (parse_config_key(...) || !name)
> 		return ...;

I think you figured this out from your other response, but no, those are
the opposite case (it tricked me at first, too).

-Peff
