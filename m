Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776EB1F461
	for <e@80x24.org>; Sat, 29 Jun 2019 00:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfF2Aa7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 20:30:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:54758 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726643AbfF2Aa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 20:30:59 -0400
Received: (qmail 16122 invoked by uid 109); 29 Jun 2019 00:30:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Jun 2019 00:30:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22170 invoked by uid 111); 29 Jun 2019 00:31:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 20:31:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 20:30:57 -0400
Date:   Fri, 28 Jun 2019 20:30:57 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] easy bulk commit creation in tests
Message-ID: <20190629003057.GB3094@sigill.intra.peff.net>
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
 <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
 <20190628064103.GA19777@sigill.intra.peff.net>
 <20190628093751.GA3569@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1906281452251.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1906281452251.44@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 02:53:26PM +0200, Johannes Schindelin wrote:

> > > It would be nice if we had a "test_commits_bulk" that used fast-import
> > > to create larger numbers of commits.
> >
> > So here's a patch to do that.
> 
> I like the direction, especially because it would make it super easy to go
> one step further that would probably make a huge difference on Windows: to
> move `test_commit_bulk` to `test-tool commit-bulk`.

I actually considered going directly there, but I don't think it would
make a big difference. In the biggest case we dropped 900 processes to
4. If we really want to drop that to 1, we can:

  - use a temp-file to avoid the left-hand-pipe subshell

  - add a feature to fast-import to say "build on top of ref X", instead
    of using to use rev-parse to manually generates a "reset" line
    (maybe this is even possible already; I searched for it, but not
    very hard).

  - add a feature to fast-import to have it check out the result of HEAD
    if it was updated

The first one seems like an easy and obvious win that I'll explore. The
second one would be useful in general, I think, but I don't plan on
digging into it (unless somebody shows up with an easy existing way to
do it).

The third one is a little less elegant to me, because there are a lot of
questions about how to checkout (e.g., with "-f", what happens to
deleted files, etc).

-Peff
