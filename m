Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D1D1F62D
	for <e@80x24.org>; Thu,  5 Jul 2018 20:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeGEUCI (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 16:02:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:49716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754070AbeGEUCH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 16:02:07 -0400
Received: (qmail 13154 invoked by uid 109); 5 Jul 2018 20:02:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Jul 2018 20:02:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17971 invoked by uid 111); 5 Jul 2018 20:02:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Jul 2018 16:02:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jul 2018 16:02:05 -0400
Date:   Thu, 5 Jul 2018 16:02:05 -0400
From:   Jeff King <peff@peff.net>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/config: work around an unsized array forward
 declaration
Message-ID: <20180705200205.GA29861@sigill.intra.peff.net>
References: <20180705183445.30901-1-dev+git@drbeat.li>
 <20180705193807.GA4826@sigill.intra.peff.net>
 <phlsmp$mot$1@blaine.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <phlsmp$mot$1@blaine.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 05, 2018 at 09:50:53PM +0200, Beat Bolli wrote:

> > Your patch is obviously correct, but I think here there might be an even
> > simpler solution: just bump option_parse_type() below the declaration,
> > since it's the only one that needs it. That hunk is bigger, but the
> > overall diff is simpler, and we don't need to carry that extra wrapper
> > function.
> 
> That was dscho's first try in the GitHub issue. It doesn't compile
> because the OPT_CALLBACK* macros in the builtin_config_options
> declaration inserts a pointer to option_parse_type into the array items.
> We need at least one forward declaration, and my patch seemed the least
> intrusive.

Ah, right, so it actually is mutually recursive.  Forward-declaring
option_parse_type() would fix it, along with the reordering. I'm
ambivalent between the available options, then; we might as well go with
what you posted, then, since it's already done. :)

-Peff
