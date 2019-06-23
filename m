Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7787A1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 02:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfFXCti (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 22:49:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:48192 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727093AbfFXCti (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 22:49:38 -0400
Received: (qmail 5113 invoked by uid 109); 23 Jun 2019 22:49:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 23 Jun 2019 22:49:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6226 invoked by uid 111); 23 Jun 2019 22:50:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 23 Jun 2019 18:50:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Jun 2019 18:49:35 -0400
Date:   Sun, 23 Jun 2019 18:49:35 -0400
From:   Jeff King <peff@peff.net>
To:     Pedro Larroy <pedro.larroy.lists@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git bisect should return 1 when the first bad commit is found
Message-ID: <20190623224935.GD1100@sigill.intra.peff.net>
References: <CAC_CU1iWBCTt5jLQ0Zp2HoyA0oFgG3shDB2rLfOsmC+x67NdAw@mail.gmail.com>
 <xmqq5zp9wdjb.fsf@gitster-ct.c.googlers.com>
 <CAC_CU1hHK5n4GcETbWFLBeqT_Y9LV6N32Rv0F0+OCXH2G0qg8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC_CU1hHK5n4GcETbWFLBeqT_Y9LV6N32Rv0F0+OCXH2G0qg8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 23, 2019 at 01:32:16PM -0700, Pedro Larroy wrote:

> Thanks for your answer.
> 
> I was expecting the HEAD to point to the first bad commit.
> 
> In mercurial, the exit status tells you information about the
> bisection process:  https://www.mercurial-scm.org/repo/hg/help/bisect
> 
> Sure one can parse stdout, it's just more tedious than just checking
> the return code and having the HEAD left to the original bad commit.

I think it might be nice for Git to write a well-known refname (like
BISECT_RESULT or similar) so that you can refer to that instead of
having to read stdout (whether by machine or by a user
cutting-and-pasting). And I cannot offhand think of a particular reason
why that could not just be HEAD (instead of something bisect-specific)
after the bisect finishes.

We do not promise any particular value in HEAD now. The only downside
would be the minor cost to checkout the working tree of the known-bad
commit if we are not already there.

-Peff
