Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2CD207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033298AbdDTUOu (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:14:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:37167 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033218AbdDTUOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:14:46 -0400
Received: (qmail 31098 invoked by uid 109); 20 Apr 2017 20:14:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 20:14:46 +0000
Received: (qmail 8643 invoked by uid 111); 20 Apr 2017 20:15:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 16:15:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 16:14:43 -0400
Date:   Thu, 20 Apr 2017 16:14:43 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "mfick@codeaurora.org" <mfick@codeaurora.org>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: [PATCH] repack: respect gc.pid lock
Message-ID: <20170420201443.ee4tgoymzpfvl4jq@sigill.intra.peff.net>
References: <20170413202712.22192-1-dturner@twosigma.com>
 <20170414193341.itr3ybiiu2brt63b@sigill.intra.peff.net>
 <c6dd37238f154ccea56dda9b43f3277a@exmbdft7.ad.twosigma.com>
 <20170418034157.oi6hkg5obnca5zsa@sigill.intra.peff.net>
 <2400e9cbfaff4838a8f3b23c4c2c5a22@exmbdft7.ad.twosigma.com>
 <20170418171930.zad5wrbu5rvdsmg5@sigill.intra.peff.net>
 <710ded65bb8843ab838d9c52cd796317@exmbdft7.ad.twosigma.com>
 <20170418175011.qx64luolrvqwwtpa@sigill.intra.peff.net>
 <7e31f4ed5c0f4c31b2870fb58cf7110e@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e31f4ed5c0f4c31b2870fb58cf7110e@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 08:10:24PM +0000, David Turner wrote:

> > Is "-a" or "-A" the key factor? Are there current callers who prefer the current
> > behavior of "possibly duplicate some work, but never report failure" versus "do
> > not duplicate work, but sometimes fail due to lock contention"?
> 
> One problem with failing is that it can leave a temp pack behind.

Yeah. IMHO we should probably treat failed object and pack writes as
normal tempfiles and remove them (but possibly respect a "debug mode"
that leaves them around). But that's another patch entirely.

> I think the correct fix is to change the default code.packedGitLimit on 64-bit 
> machines to 32 terabytes (2**45 bytes).  That's because on modern Intel 
> processors, there are 48 bits of address space actually available, but the kernel 
> is going to probably reserve a few bits.  My machine claims to have 2**46 bytes 
> of virtual address space available.  It's also several times bigger than any 
> repo that I know of or can easily imagine.
> 
> Does that seem reasonable to you?

Yes, it does.

-Peff
