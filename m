Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7F01F404
	for <e@80x24.org>; Thu,  1 Mar 2018 04:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965849AbeCAE0X (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 23:26:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:42222 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965813AbeCAE0W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 23:26:22 -0500
Received: (qmail 8541 invoked by uid 109); 1 Mar 2018 04:26:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Mar 2018 04:26:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12083 invoked by uid 111); 1 Mar 2018 04:27:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Feb 2018 23:27:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Feb 2018 23:26:20 -0500
Date:   Wed, 28 Feb 2018 23:26:20 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Sergey Organov <sorganov@gmail.com>,
        igor.d.djordjevic@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: The case for two trees in a commit ("How to make rebase less
 modal")
Message-ID: <20180301042620.GA21310@sigill.intra.peff.net>
References: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 03:30:27PM -0800, Stefan Beller wrote:

> During the rebase there might be a hard to resolve conflict, which
> you may not want to resolve right now, but defer to later.  Deferring a
> conflict is currently impossible, because precisely one tree is recorded.
> 
> If we had multiple trees possible in a commit, then all these large scale
> operations would stop being modal and you could just record the unresolved
> merge conflict instead; to come back later and fix it up later.
> 
> I'd be advocating for having multiple trees in a commit
> possible locally; it might be a bad idea to publish such trees.
> 
> Opinions or other use cases?

What benefit does it have over adding a new header "unresolved-tree" or
similar? I do not think you are getting any backwards compatibility
here. For instance, "prune" will not traverse it with existing versions
of git, nor "pack-objects" include it in a pack (I didn't actually test
it, so I could be wrong; but those are all based around parse_commit,
which should look at only the first tree).

-Peff
