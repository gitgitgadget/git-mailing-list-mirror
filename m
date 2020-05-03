Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43160C28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B1B20721
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgECJkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 05:40:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:35034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727971AbgECJkH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 05:40:07 -0400
Received: (qmail 22110 invoked by uid 109); 3 May 2020 09:40:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 May 2020 09:40:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4890 invoked by uid 111); 3 May 2020 09:40:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 03 May 2020 05:40:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 3 May 2020 05:40:05 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: Re: [PATCH 7/7] commit-graph.c: introduce '--[no-]check-oids'
Message-ID: <20200503094005.GD170902@coredump.intra.peff.net>
References: <cover.1586836700.git.me@ttaylorr.com>
 <1ff42f4c3d568dd25889d2808cda3edf38a36cb9.1586836700.git.me@ttaylorr.com>
 <20200415042930.GA11703@syl.local>
 <20200415043137.GA12136@syl.local>
 <20200422105536.GB3063@szeder.dev>
 <20200422233930.GB19100@syl.local>
 <20200424105957.GB5925@szeder.dev>
 <20200501223848.GH41612@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501223848.GH41612@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 04:38:48PM -0600, Taylor Blau wrote:

> But, are there ever any callers that *wouldn't* want this behavior? As
> far as I can tell, probably not. We're only going to be permitting
> *more* inputs to 'git commit-graph write', and I seriously doubt that
> anybody is depending on the above behavior. (Of course, if that's not
> the case, I'd love for somebody to speak up here and we can continue
> the course on this patch).
> 
> So, I propose the following:
> 
>   * We drop the idea of '--[no-]{check,verify}-oids', and always
>     silently ignore non-commit inputs, retaining the existing behavior
>     of always complaining about things that aren't valid hex OIDs, such
>     as "HEAD".
> 
>   * We always error out on missing or corrupt commit OIDs, including
>     valid OIDs that don't resolve to any object, or resolve to a tag
>     that can't be fully peeled.
> 
> Does that seem reasonable?

FWIW, I think that is the best direction. If anybody is depending on the
"commit-graph write will complain about non-commits" behavior, they
could only be doing so for a few versions; prior to v2.24.0 we did not.

-Peff
