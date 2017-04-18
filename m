Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E251FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 17:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756570AbdDRRQv (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 13:16:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:35425 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753865AbdDRRQt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 13:16:49 -0400
Received: (qmail 27805 invoked by uid 109); 18 Apr 2017 17:16:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 17:16:49 +0000
Received: (qmail 14112 invoked by uid 111); 18 Apr 2017 17:17:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 13:17:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Apr 2017 13:16:46 -0400
Date:   Tue, 18 Apr 2017 13:16:46 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "mfick@codeaurora.org" <mfick@codeaurora.org>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: [PATCH] repack: respect gc.pid lock
Message-ID: <20170418171646.5a5mjhd4qjr6ot7d@sigill.intra.peff.net>
References: <20170413202712.22192-1-dturner@twosigma.com>
 <20170414193341.itr3ybiiu2brt63b@sigill.intra.peff.net>
 <c6dd37238f154ccea56dda9b43f3277a@exmbdft7.ad.twosigma.com>
 <20170418034157.oi6hkg5obnca5zsa@sigill.intra.peff.net>
 <d5c43adf0b074c6ebe43439bc3fc7539@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5c43adf0b074c6ebe43439bc3fc7539@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 05:08:14PM +0000, David Turner wrote:

> On 64-bit systems, I think core.packedGitLimit doesn't make a 
> lot of sense. There is plenty of address space.  Why not use it?

That's my gut feeling, too. I'd have a slight worry that the OS's paging
behavior may respond differently if we have more memory mapped. But
that's not based on numbers, just a fear of the unknown. :)

If we have infinite windows anyway, I suspect we could just mmap entire
packfiles and forget about all the window complexity in the first place.
Although IIRC some operating systems take a long time to set up large
mmaps, and we may only need a small part of a large pack.

> I'll ask our git server administrator to adjust core.packedGitLimit
> and turn repacks back on to see if that fixes the issue.

Thanks. Let us know if you get any results, either way.

-Peff
