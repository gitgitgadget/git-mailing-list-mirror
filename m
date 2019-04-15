Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA17820248
	for <e@80x24.org>; Mon, 15 Apr 2019 21:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfDOVhB (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 17:37:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:59150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728074AbfDOVhB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 17:37:01 -0400
Received: (qmail 1693 invoked by uid 109); 15 Apr 2019 21:37:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Apr 2019 21:37:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6254 invoked by uid 111); 15 Apr 2019 21:37:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Apr 2019 17:37:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2019 17:36:59 -0400
Date:   Mon, 15 Apr 2019 17:36:59 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
Message-ID: <20190415213659.GC28128@sigill.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
 <20190413015102.GC2040@sigill.intra.peff.net>
 <20190413221646.GL12419@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190413221646.GL12419@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 13, 2019 at 10:16:46PM +0000, brian m. carlson wrote:

> > The alternative is that we could use a special token like ":zlib" or
> > something to indicate that the internal implementation should be used
> > (and then tweak the baked-in default, too). That might be less
> > surprising for users, but most people would still get the benefit since
> > they'd be using the default config.
> 
> I agree that a special value (or NULL, if that's possible) would be
> nicer here. That way, if someone does specify a custom gzip, we honor
> it, and it serves to document the code better. For example, if someone
> symlinked pigz to gzip and used "gzip -cn", then they might not get the
> parallelization benefits they expected.

Thanks for spelling that out. I had a vague feeling somebody might be
surprised, but I didn't know if people actually did stuff like
symlinking pigz to gzip (though it makes perfect sense to do so).

> I'm fine overall with the idea of bringing the compression into the
> binary using zlib, provided that we preserve the "-n" behavior
> (producing reproducible archives).

I just assumed that gzwrite() would have the "-n" behavior, but it's
definitely worth double-checking.

-Peff
