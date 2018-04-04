Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A721F404
	for <e@80x24.org>; Wed,  4 Apr 2018 18:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeDDS7x (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 14:59:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:53520 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751704AbeDDS7w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 14:59:52 -0400
Received: (qmail 17223 invoked by uid 109); 4 Apr 2018 18:59:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Apr 2018 18:59:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7090 invoked by uid 111); 4 Apr 2018 19:00:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 04 Apr 2018 15:00:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2018 14:59:50 -0400
Date:   Wed, 4 Apr 2018 14:59:50 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@gmail.com, larsxschneider@gmail.com,
        bmwill@google.com
Subject: Re: [PATCH 8/6] commit: use generation numbers for in_merge_bases()
Message-ID: <20180404185950.GF9055@sigill.intra.peff.net>
References: <20180403190500.GA10930@sigill.intra.peff.net>
 <20180404154554.140716-1-dstolee@microsoft.com>
 <20180404154554.140716-2-dstolee@microsoft.com>
 <14e4e1d3-5c77-dc7c-10d5-e9406b992f0e@gmail.com>
 <20180404182432.GB9055@sigill.intra.peff.net>
 <aa28c3e5-7645-ffe0-78a3-e3cbd2ea8cec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa28c3e5-7645-ffe0-78a3-e3cbd2ea8cec@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 02:53:45PM -0400, Derrick Stolee wrote:

> > I'd have to do some timings, but I suspect we may want to switch to the
> > "tag --contains" algorithm anyway. This still does N independent
> > merge-base operations, one per ref. So with enough refs, you're still
> > better off throwing it all into one big traversal.
> 
> ...and I suppose your timings are to find out if there are data shapes where
> the branch algorithm is faster. Perhaps that is impossible now that we have
> the generation number cutoff for the tag algorithm.

Well, I wanted to show the opposite: that the branch algorithm can still
perform quite poorly. :)

I think with generation numbers that the tag algorithm should always
perform better, since you can't walk past a merge base when using a
cutoff. But it could definitely perform worse in a case where you don't
have generation numbers.

> Patches 7 and 8 seem to me like simple changes with no downside UNLESS we
> are deciding instead to delete the code I'm changing.

Yeah, I think they are strict improvements modulo the inverted UNDEF
logic I mentioned.

-Peff
