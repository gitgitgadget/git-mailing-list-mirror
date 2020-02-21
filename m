Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2BFC35641
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 06:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA61720637
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 06:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgBUGAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:00:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:50116 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725973AbgBUGAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 01:00:30 -0500
Received: (qmail 15851 invoked by uid 109); 21 Feb 2020 06:00:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Feb 2020 06:00:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16406 invoked by uid 111); 21 Feb 2020 06:09:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2020 01:09:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Feb 2020 01:00:29 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
Message-ID: <20200221060029.GF1280313@coredump.intra.peff.net>
References: <xmqqftf49862.fsf@gitster-ct.c.googlers.com>
 <20200221013357.26795-1-matheus.bernardino@usp.br>
 <xmqqsgj47l0k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgj47l0k.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 06:05:15PM -0800, Junio C Hamano wrote:

> Matheus Tavares <matheus.bernardino@usp.br> writes:
> 
> >> > Another case that came to my mind is when the user runs `git describe
> >> > --abrev=0 HEAD` and v1.0-bob points to HEAD~. In this case, v1.0 will
> >> > be displayed without suffix,...
> >>
> >> In this case, v1.0-1- is followed by the full object name, I think.
> >
> > I might be doing something wrong, but this is how I tried to test this:...
> 
> I only tried the commit exactly at the tag "describe --abbrev=0 v1.0-bob^0";
> you're right---the "abbrev" option strips the suffix in a separate codepath.
> 
> > Then we cannot directly use the output. I think we can fix this forcing the long
> > output for this case as well, which can be done with:
> 
> Thanks for a quick fix on top.

This fix makes sense. There's already a bit of ambiguity with
--no-abbrev, as it would output v1.0-1-g1234abcd as just "v1.0". But it
probably is best to draw the line here and not introduce even more
ambiguity.

-Peff
