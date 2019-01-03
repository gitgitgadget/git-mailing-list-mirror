Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A1F1F803
	for <e@80x24.org>; Thu,  3 Jan 2019 04:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfACEtn (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 23:49:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:53388 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726666AbfACEtn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 23:49:43 -0500
Received: (qmail 18215 invoked by uid 109); 3 Jan 2019 04:49:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 04:49:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7413 invoked by uid 111); 3 Jan 2019 04:49:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 02 Jan 2019 23:49:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jan 2019 23:49:41 -0500
Date:   Wed, 2 Jan 2019 23:49:41 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] banned.h: mark strncat() as banned
Message-ID: <20190103044941.GA20047@sigill.intra.peff.net>
References: <20190102093846.6664-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190102093846.6664-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 02, 2019 at 09:38:46AM +0000, Eric Wong wrote:

> strncat() has the same quadratic behavior as strcat() and is
> difficult-to-read and bug-prone.  While it hasn't yet been a
> problem in git iself, strncat() found it's way into 'master'
> of cgit and caused segfaults on my system.

I'm in favor of this.

It doesn't have the "oops, I didn't NUL-terminate for you" problem that
strncpy() has. But it actually has the opposite problem! It will always
place a NUL, and you have to feed it sizeof(dst)-1 to avoid an overflow.

So I think it's important for safety (though I'd be fine banning it on
the quadratic grounds alone ;) ).

-Peff
