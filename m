Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8EB202AA
	for <e@80x24.org>; Sun,  3 Mar 2019 17:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfCCRI1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:08:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:36586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726416AbfCCRI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:08:27 -0500
Received: (qmail 13380 invoked by uid 109); 3 Mar 2019 17:08:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 Mar 2019 17:08:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16421 invoked by uid 111); 3 Mar 2019 17:08:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Mar 2019 12:08:43 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Mar 2019 12:08:25 -0500
Date:   Sun, 3 Mar 2019 12:08:25 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
Message-ID: <20190303170824.GB23811@sigill.intra.peff.net>
References: <pull.130.git.gitgitgadget@gmail.com>
 <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
 <20190301213619.GA1518@sigill.intra.peff.net>
 <20190301215414.GB1518@sigill.intra.peff.net>
 <20190301220112.GA14966@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903022053290.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903022053290.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 02, 2019 at 08:54:55PM +0100, Johannes Schindelin wrote:

> On Fri, 1 Mar 2019, Jeff King wrote:
> 
> > On Fri, Mar 01, 2019 at 04:54:15PM -0500, Jeff King wrote:
> > 
> > > The one thing we do lose, though, is make's parallelization. It would
> > > probably be possible to actually shove this into a sub-make which
> > > defined the hdr-check rules, but I don't know how complicated that would
> > > become.
> > 
> > This seems to work, though it's kind of horrid.
> > 
> > It costs at least one extra process to run "make hdr-check", and
> > probably more for things like $(GIT_VERSION) that the Makefile include
> > likely triggers. But when you're not running hdr-check (which is the
> > norm), it's zero-cost.
> 
> If we want to go that route (and I am not saying we should), we could
> easily just add another target (say, `check-headers`) that requires a list
> of headers to check to be passed in via a Makefile variable that is
> defined via the command-line.

Yeah, that was actually going to be my initial attempt before I tried
the "include" shortcut. :) I'd worry slightly about things like
command-line limits, but maybe our list isn't big enough to justify
that.

-Peff
