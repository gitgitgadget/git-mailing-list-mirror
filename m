Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10C3220372
	for <e@80x24.org>; Fri, 13 Oct 2017 00:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755460AbdJMAVB (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 20:21:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:51668 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753898AbdJMAVA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 20:21:00 -0400
Received: (qmail 11742 invoked by uid 109); 13 Oct 2017 00:21:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 00:21:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22048 invoked by uid 111); 13 Oct 2017 00:21:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 20:21:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 20:20:57 -0400
Date:   Thu, 12 Oct 2017 20:20:57 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, orgads@gmail.com
Subject: Re: [PATCH] diff.c: increment buffer pointer in all code path
Message-ID: <20171013002057.froqi54olmhmah6b@sigill.intra.peff.net>
References: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
 <20171012233322.31203-1-sbeller@google.com>
 <20171013001837.43nx5paeqisbrflq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013001837.43nx5paeqisbrflq@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 08:18:37PM -0400, Jeff King wrote:

> Fix this by entering the conditional only when we actually
> see whitespace. We can apply this also to the
> IGNORE_WHITESPACE change. That code path isn't buggy
> (because it falls through to returning the next
> non-whitespace byte), but it makes the logic more clear if
> we only bother to look at whitespace flags after seeing that
> the next byte is whitespace.

I think there actually _is_ a bug in that code path, but it's unrelated
to this one. If you have whitespace at the end of the buffer, then we'd
advance *cp until it matches *endp, and then return whatever is at *endp
(which is nonsense, or probably a NUL) rather than returning "-1".

I'm out of time for tonight and not familiar enough with the color-moved
code to come up with a reasonable test case quickly, but maybe you can
see if that can trigger bad behavior?

-Peff
