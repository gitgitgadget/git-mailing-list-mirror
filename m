Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8D91FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 04:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbcLAEDf (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 23:03:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:49526 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbcLAEDe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 23:03:34 -0500
Received: (qmail 14045 invoked by uid 109); 1 Dec 2016 04:02:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 04:02:37 +0000
Received: (qmail 28933 invoked by uid 111); 1 Dec 2016 04:03:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 23:03:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 23:02:34 -0500
Date:   Wed, 30 Nov 2016 23:02:34 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
Message-ID: <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net>
References: <4ddad7ea-5ac8-20b2-da9e-5843c486878a@ramsayjones.plus.com>
 <alpine.DEB.2.20.1611301204020.117539@virtualbox>
 <29abc89b-9ca5-930f-8e90-ca446ac2b96a@ramsayjones.plus.com>
 <xmqqtwaod7ly.fsf@gitster.mtv.corp.google.com>
 <20161130212510.ihcmvig7jq44p3nx@sigill.intra.peff.net>
 <3e6a6685-19ec-4536-4a5f-3a56e30fb530@ramsayjones.plus.com>
 <20161130231848.v5ge6otytim2t6d2@sigill.intra.peff.net>
 <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com>
 <59da5383-16a0-b327-75a8-b4c4ad7bd479@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59da5383-16a0-b327-75a8-b4c4ad7bd479@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 01:18:35AM +0000, Ramsay Jones wrote:

> >> I forgot, we ended up reversing course later and silencing them:
> >>
> >>   http://public-inbox.org/git/20140505052117.GC6569@sigill.intra.peff.net/
> >>
> >> By the rationale of that conversation, we should be doing:
> >>
> >>   warning("%s", "");
> >>
> >> here.
> > 
> > I forgot too.  Thanks for digging up that thread.
> 
> Yes, I blamed wt-status.c:227 and came up with commit 7d7d68022
> as well.
> 
> So, by the same rationale, we should remove -Wno-format-zero-length
> from DEVELOPER_CFLAGS. yes?

I don't have a preference on which direction we go, but yes, right now
we are in an awkward middle ground. We should do one of:

  1. Drop -Wno-format-zero-length from DEVELOPER_CFLAGS and make sure
     future patches to do not violate it.

  2. Declare warning("") as OK.

I still think the warning is silly, but (1) has value in that it
produces the least surprise and annoyance to various people building
Git.

-Peff
