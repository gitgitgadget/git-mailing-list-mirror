Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CE8C2BAEE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAFE20719
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgCXGGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:06:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:49062 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725869AbgCXGGi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 02:06:38 -0400
Received: (qmail 15144 invoked by uid 109); 24 Mar 2020 06:06:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Mar 2020 06:06:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21196 invoked by uid 111); 24 Mar 2020 06:16:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Mar 2020 02:16:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Mar 2020 02:06:37 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200324060637.GB610977@coredump.intra.peff.net>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <20200321172716.GA39461@syl.local>
 <20200322053635.GA578498@coredump.intra.peff.net>
 <20200322164531.GA55067@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322164531.GA55067@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 10:45:31AM -0600, Taylor Blau wrote:

> So, I'm not sure what was going on with my original measurements, other
> than that I took them around midnight, so the chance for error was
> probably high. I'll go with your measurements, since they are both
> closer to what we'd see in the real world, and actually representative
> of the change here.

I wondered if perhaps you had stray commit-graph files sitting around. I
don't think we'd look at them if they aren't mentioned in the
commit-graphs index, though. And anyway, feeding all of the packed
objects would mean those would all be parsed in the earlier stage, so
even if we _did_ have a bunch of stuff to merge, it would have been fast
even with the old code.

So...I dunno.

One other thing that's bitten me in the past is accidentally compiling
with the wrong optimization settings. I have my config.mak set up to
compile with -O0 by default (because it's faster and because I'm
frequently debugging anyway), and then I do a -O2 build for my daily
driver. But when performance testing, I sometimes accidentally compare
-O0 and -O2 builds to each other. That's all very specific to my
config.mak setup, but I know you've picked up some of it, so it's
possible you inherited that subtlety. :)

-Peff
