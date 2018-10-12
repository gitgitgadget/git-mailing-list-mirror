Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2E51F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 18:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeJMCTm (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 22:19:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:39138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726199AbeJMCTm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 22:19:42 -0400
Received: (qmail 31372 invoked by uid 109); 12 Oct 2018 18:45:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Oct 2018 18:45:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13127 invoked by uid 111); 12 Oct 2018 18:45:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Oct 2018 14:45:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2018 14:45:49 -0400
Date:   Fri, 12 Oct 2018 14:45:49 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config.mak.dev: add -Wformat
Message-ID: <20181012184549.GC4917@sigill.intra.peff.net>
References: <20181012184037.15076-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181012184037.15076-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 12, 2018 at 07:40:37PM +0100, Thomas Gummerer wrote:

> 801fa63a90 ("config.mak.dev: add -Wformat-security", 2018-09-08) added
> the -Wformat-security to the flags set in config.mak.dev.  In the gcc
> man page this is documented as:
> 
>          If -Wformat is specified, also warn about uses of format
>          functions that represent possible security problems.  [...]
> 
> That commit did however not add the -Wformat flag, and -Wformat is not
> specified anywhere else by default, so the added -Wformat-security had
> no effect.  Newer versions of gcc (gcc 8.2.1 in this particular case)
> warn about this and thus compilation fails with this option set.
> 
> Fix that, and make -Wformat-security actually useful by adding the
> -Wformat flag as well.  git compiles cleanly with both these flags
> applied.

-Wformat is part of -Wall, which we already turn on by default (even for
non-developer builds).

So I don't think we need to do anything more, though I'm puzzled that
you saw a failure. Do you set CFLAGS explicitly in your config.mak to
something that doesn't include -Wall?

I'm not opposed to making config.mak.dev a bit more redundant to handle
this case, but we'd probably want to include all of -Wall, since it
contains many other warnings we'd want to make sure are enabled.

-Peff
