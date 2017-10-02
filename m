Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5676D20281
	for <e@80x24.org>; Mon,  2 Oct 2017 19:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbdJBTXa (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 15:23:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:58050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751291AbdJBTX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 15:23:29 -0400
Received: (qmail 10677 invoked by uid 109); 2 Oct 2017 19:23:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 19:23:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31827 invoked by uid 111); 2 Oct 2017 19:24:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 15:24:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 15:23:27 -0400
Date:   Mon, 2 Oct 2017 15:23:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: avoid NULL pointer arithmetic
Message-ID: <20171002192327.xyynkh47r2kgir7f@sigill.intra.peff.net>
References: <99e56671-bdf9-a59f-ae7b-758f1b7a8f14@web.de>
 <20171002050810.ryj4nv3nwqp7gb7p@sigill.intra.peff.net>
 <32a8b949-638a-1784-7fba-948ae32206fc@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32a8b949-638a-1784-7fba-948ae32206fc@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 03:06:57PM +0200, René Scharfe wrote:

> >> Avoid the ASan error by casting the results of the lookup functions to
> >> struct object pointers.  That works fine with NULL pointers as well.  We
> >> already rely on the object member being first in all object types in
> >> other places in the code.
> > 
> > Out of curiosity, did you have to do anything to coax this out of ASan
> > (e.g., a specific version)?  I've been running it pretty regularly and
> > didn't see this one (I did switch from clang to gcc a month or two ago,
> > but this code is pretty old, I think).
> 
> I did "make -j4 SANITIZE=undefined,address BLK_SHA1=1 test" with
> clang version 4.0.1-1 (tags/RELEASE_401/final), and t1450-fsck.sh failed.

Interesting. I can trigger it with the same setup, but not if:

  1. I use gcc instead of clang.

  2. If I only use one of UBSan and ASan. It's the combination that
     triggers it.

-Peff
