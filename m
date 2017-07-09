Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33EAA20357
	for <e@80x24.org>; Sun,  9 Jul 2017 11:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbdGILAU (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 07:00:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:34774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751786AbdGILAT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 07:00:19 -0400
Received: (qmail 6297 invoked by uid 109); 9 Jul 2017 11:00:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 11:00:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 348 invoked by uid 111); 9 Jul 2017 11:00:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 07:00:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jul 2017 07:00:17 -0400
Date:   Sun, 9 Jul 2017 07:00:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: add slash once in
 for_each_file_in_obj_subdir()
Message-ID: <20170709110016.nusy62u2morqvwmm@sigill.intra.peff.net>
References: <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 08, 2017 at 10:59:06AM +0200, René Scharfe wrote:

> Add the slash between loose object subdirectory and file name just once
> outside the loop instead of overwriting it with each readdir call.
> Redefine baselen as the length with that slash, and add dirlen for the
> length without it.  The result is slightly less wasteful and can use the
> the cheaper strbuf_addstr instead of strbuf_addf without losing clarity.

This patch looks correct to me.

I'm a little lukewarm on it overall, though. I'd be shocked if the
efficiency change is measurable. What I really care about is whether the
result is easier to read or not.

On the plus side, this moves an invariant out of the loop. On the minus
side, it has to introduce an extra variable for "length we add on to"
versus "dir length to pass to the subdir_cb". That's not rocket science,
but it does slightly complicate things (though I note we already have
"origlen", so this is bumping us from 2 to 3 length variables, not 1 to
2).

So I dunno. It's fine with me if we take it, and fine if we leave it.

-Peff
