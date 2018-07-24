Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AAC11F597
	for <e@80x24.org>; Tue, 24 Jul 2018 09:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeGXK3E (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 06:29:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:57144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388236AbeGXK3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 06:29:03 -0400
Received: (qmail 7508 invoked by uid 109); 24 Jul 2018 09:23:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 09:23:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25520 invoked by uid 111); 24 Jul 2018 09:23:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 05:23:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 05:23:30 -0400
Date:   Tue, 24 Jul 2018 05:23:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] fail compilation with strcpy
Message-ID: <20180724092329.GA24250@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719203259.GA7869@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 04:32:59PM -0400, Jeff King wrote:

> This is a patch series to address the discussion in the thread at:
> 
>   https://public-inbox.org/git/20180713204350.GA16999@sigill.intra.peff.net/
> 
> Basically, the question was: can we declare strcpy banned and have a
> linter save us the trouble of finding it in review. The answer is yes,
> the compiler is good at that. ;)

Here's a v2 that I think addresses the comments on the earlier series.
Thanks everybody for your review.

Changes here include:

 - drop the mention in CodingGuidelines. That list is already long, and
   we don't need to to waste mental effort on things that will be
   enforced automatically

 - we now #undef all macros before defining them to avoid redefinition
   warnings

 - the first patch now covers _just_ strcpy(), and each function gets
   its own patch with an explanation (and suggested alternatives). My
   thought is that these should be easy to dig up via blame, "log -S",
   or "log --grep". Though another option would be comments in banned.h.

 - added strcat and vsprintf to the banned list

 - tweaked the first patch's commit message for clarity and to address
   points raised in discussion

As before, this needs to go on top of 022d2ac1f3 (which I hope should
hit master soon anyway).

  [1/4]: automatically ban strcpy()
  [2/4]: banned.h: mark strcat() as banned
  [3/4]: banned.h: mark sprintf() as banned
  [4/4]: banned.h: mark strncpy() as banned

 banned.h          | 30 ++++++++++++++++++++++++++++++
 git-compat-util.h |  6 ++++++
 2 files changed, 36 insertions(+)
 create mode 100644 banned.h

-Peff
