Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0092F2031F
	for <e@80x24.org>; Thu,  9 Mar 2017 13:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754816AbdCIN1e (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 08:27:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:41248 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754811AbdCIN1b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 08:27:31 -0500
Received: (qmail 19428 invoked by uid 109); 9 Mar 2017 13:27:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 13:27:30 +0000
Received: (qmail 1131 invoked by uid 111); 9 Mar 2017 13:27:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 08:27:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 08:27:28 -0500
Date:   Thu, 9 Mar 2017 08:27:28 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/4] fix object flag pollution in "tag --contains"
Message-ID: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
References: <20170308202025.17900-1-avarab@gmail.com>
 <20170309100910.z4h7bwqzxw2xynyu@sigill.intra.peff.net>
 <CACBZZX53rMiB5-cA_7-SeU2Dt7d_Cr7_GgyC0rjQQPPf4qyCqw@mail.gmail.com>
 <20170309104657.7pwreyozxo2tdhk4@sigill.intra.peff.net>
 <CACBZZX5i+8bQLhLB4DnUAaUw1vA_KQjhtNBvm7drLepPAFFbAQ@mail.gmail.com>
 <20170309125132.tubwxtneffok4nrc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170309125132.tubwxtneffok4nrc@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2017 at 07:51:32AM -0500, Jeff King wrote:

> Looking at this, I'm pretty sure that using "--contains" with "--merged"
> has similar problems, as they both use the UNINTERESTING bit. So even
> without your patch, there is a lurking bug.

I wasn't able to come up with a simple case that actually demonstrates
the bug. But I feel like it has to be triggerable with the right
sequence of history.

Even without that, though, I feel like moving away from this flag usage
is a good cleanup. Here's a cleaned-up series. What do you think of
building your patch on top?

We can do it the other way around if you prefer.

  [1/4]: ref-filter: move ref_cbdata definition into ref-filter.c
  [2/4]: ref-filter: use contains_result enum consistently
  [3/4]: ref-filter: die on parse_commit errors
  [4/4]: ref-filter: use separate cache for contains_tag_algo

 ref-filter.c | 70 ++++++++++++++++++++++++++++++++++++++----------------------
 ref-filter.h |  5 -----
 2 files changed, 44 insertions(+), 31 deletions(-)

-Peff
