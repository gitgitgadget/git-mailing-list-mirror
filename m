Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3E67207D6
	for <e@80x24.org>; Fri, 28 Apr 2017 01:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162766AbdD1BPE (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 21:15:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:41453 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161873AbdD1BPC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 21:15:02 -0400
Received: (qmail 8018 invoked by uid 109); 28 Apr 2017 01:15:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 01:15:01 +0000
Received: (qmail 16138 invoked by uid 111); 28 Apr 2017 01:15:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 21:15:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Apr 2017 21:14:59 -0400
Date:   Thu, 27 Apr 2017 21:14:59 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 35/53] Convert the verify_pack callback to struct
 object_id
Message-ID: <20170428011458.qcezjqonc2gqpthi@sigill.intra.peff.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
 <20170423213453.253425-36-sandals@crustytoothpaste.net>
 <20170427055209.ock533opgzans6ew@sigill.intra.peff.net>
 <20170428001754.7h7gblafh2faz4vf@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170428001754.7h7gblafh2faz4vf@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 12:17:54AM +0000, brian m. carlson wrote:

> > What's the gain in converting it here? I know we want to get rid of the
> > bare "20", but we could switch it out for GIT_SHA1_RAWSZ. I suspect you
> > prefer in the long run to get rid of even those GIT_SHA1_RAWSZ defines,
> > though.  Could we define a new struct csumfile_hash, csumfile_cmp, etc
> > (and arguably change the name of "struct sha1file" and friends).  They'd
> > be boring wrappers around sha1 now, but I think the endgame will involve
> > us being able to read multiple versions of packs, with distinct
> > checksum algorithms.
> 
> When I wrote this originally, the GIT_MAX_*SZ patch was in
> object-id-part9 and hadn't been merged yet.  And I think your concerns
> about this being kinda gross are legitimate.  I'll admit I had some
> hesitance about it at first.
> 
> So I'll reroll this leaving it as an unsigned char with GIT_MAX_RAWSZ.
> I feel confident that we're not going to pick a third, different
> algorithm for the pack checksum, so that will get us to the point that
> we have a big enough buffer, and we can incrementally improve on it
> later by using a different struct if we like.

OK, that seems like a good middle ground. We won't know what the end
result looks like until we get closer to it.

-Peff
