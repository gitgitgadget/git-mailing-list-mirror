Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39E29211B3
	for <e@80x24.org>; Tue, 11 Dec 2018 10:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeLKKSH (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:18:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:37892 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726137AbeLKKSG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:18:06 -0500
Received: (qmail 13458 invoked by uid 109); 11 Dec 2018 10:18:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 10:18:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3788 invoked by uid 111); 11 Dec 2018 10:17:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 05:17:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 05:17:42 -0500
Date:   Tue, 11 Dec 2018 05:17:42 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     george.w.king@gmail.com, git <git@vger.kernel.org>
Subject: Re: Difficulty with parsing colorized diff output
Message-ID: <20181211101742.GE31588@sigill.intra.peff.net>
References: <799879BD-A2F0-487C-AA05-8054AC62C5BD@gmail.com>
 <20181208071634.GA18272@sigill.intra.peff.net>
 <CAGZ79kbd=2_eHdbVYwmNoAYupwnP3YDn6nT0m=v1CL0AkWXk=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbd=2_eHdbVYwmNoAYupwnP3YDn6nT0m=v1CL0AkWXk=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 07:26:46PM -0800, Stefan Beller wrote:

> > Context lines do have both. It's just that the default color for context
> > lines is empty. ;)
> 
> The content itself can contain color codes.
> 
> Instead of unconditionally resetting each line, we could parse each
> content line to determine if we actually have to reset the colors.

Good point. I don't recall that being the motivation back when this
behavior started, but it's a nice side effect (and the more recent line
you mentioned in emit_line_0 certainly is doing it intentionally).

That doesn't cover _other_ terminal codes, which could also make for
confusing output, but I do think color codes are somewhat special. We
generally send patches through "less -R", which will pass through the
colors but show escaped versions of other codes.

> Another idea would be to allow Git to output its output
> as if it was run through test_decode_color, slightly related:
> https://public-inbox.org/git/20180804015317.182683-8-sbeller@google.com/
> i.e. we'd markup the output instead of coloring it.

Yeah, I think in the most general form, the problem is that colorizing
(including whitespace highlighting) loses information within a single
line. It would be nice to have a machine-readable format that represents
all the various annotations (like whitespace and coloring moved bits)
that Git computes.

-Peff
