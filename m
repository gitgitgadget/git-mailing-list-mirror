Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90411F404
	for <e@80x24.org>; Thu, 16 Aug 2018 17:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbeHPUsF (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 16:48:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:57850 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727973AbeHPUsF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 16:48:05 -0400
Received: (qmail 10692 invoked by uid 109); 16 Aug 2018 17:48:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Aug 2018 17:48:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17897 invoked by uid 111); 16 Aug 2018 17:48:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 Aug 2018 13:48:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2018 13:48:11 -0400
Date:   Thu, 16 Aug 2018 13:48:11 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, jrnieder@gmail.com
Subject: Re: [PATCHv4 0/6] Add missing includes and forward declares
Message-ID: <20180816174810.GD882@sigill.intra.peff.net>
References: <https://public-inbox.org/git/20180813171749.10481-1-newren@gmail.com/>
 <20180815175410.5726-1-newren@gmail.com>
 <b8553a50-6b97-2b45-2f7b-cfe2576548cb@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8553a50-6b97-2b45-2f7b-cfe2576548cb@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 01:19:17AM +0100, Ramsay Jones wrote:

> As a quick ("just before bedtime") exercise, I tried adding
> a Makefile target to perform a similar check. The result is
> given below, but I haven't had time to look too closely at
> the results:

The resulting patch doesn't look too horrible, and I think it would be
great to automate this, even if people don't always run it by default.

The flip side is the "do all files include git-compat-util.h first" test
I mentioned elsewhere (and which resulted in the test-tool.h patch).
That could be automated, too. I did it like:

  {
    echo '#undef int'
    cat git-compat-util.h
  } >tmp
  mv tmp git-compat-util.h
  make CFLAGS=-Dint=foo

That's obviously pretty nasty, but if we were willing to carry:

  #ifdef UNDO_TRICKY_LINT_HACK
  #undef int
  #endif

in git-compat-util.h, it could be driven from the Makefile. Maybe
worth-while to couple with this.

-Peff
