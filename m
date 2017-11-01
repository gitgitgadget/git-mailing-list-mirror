Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B9A202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 21:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933414AbdKAVMC (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 17:12:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:43202 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933341AbdKAVMB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 17:12:01 -0400
Received: (qmail 27521 invoked by uid 109); 1 Nov 2017 21:12:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 21:12:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15477 invoked by uid 111); 1 Nov 2017 21:12:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 17:12:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Nov 2017 17:11:59 -0400
Date:   Wed, 1 Nov 2017 17:11:59 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2] grep: take the read-lock when adding a submodule
Message-ID: <20171101211159.qy2rnk7nmbaa4va3@sigill.intra.peff.net>
References: <CAN0heSpxJDxmSXu=P0stq+CsKVqjsvOnjDpOoMT9GdWxeZU2Pw@mail.gmail.com>
 <20171101204506.5481-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171101204506.5481-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 01, 2017 at 09:45:06PM +0100, Martin Ågren wrote:

> With --recurse-submodules, we add each submodule that we encounter to
> the list of alternate object databases. With threading, our changes to
> the list are not protected against races. Indeed, ThreadSanitizer
> reports a race when we call `add_to_alternates_memory()` around the same
> time that another thread is reading in the list through
> `read_sha1_file()`.
> 
> Take the grep read-lock while adding the submodule. The lock is used to
> serialize uses of non-thread-safe parts of Git's API, including
> `read_sha1_file()`.
> 
> Helped-by: Brandon Williams <bmwill@google.com>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>

This looks good to me.

-Peff
