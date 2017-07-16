Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FAD820834
	for <e@80x24.org>; Sun, 16 Jul 2017 10:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdGPKKs (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 06:10:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:41928 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751048AbdGPKKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 06:10:47 -0400
Received: (qmail 23048 invoked by uid 109); 16 Jul 2017 10:10:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 10:10:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24431 invoked by uid 111); 16 Jul 2017 10:11:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 06:11:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2017 06:10:45 -0400
Date:   Sun, 16 Jul 2017 06:10:45 -0400
From:   Jeff King <peff@peff.net>
To:     Jan Danielsson <jan.m.danielsson@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Keeping a non-1:1 mirror in sync and keeping private branches
Message-ID: <20170716101045.aslfct7g5vqfqnhi@sigill.intra.peff.net>
References: <699d0274-285f-3d30-654d-d9ca59fe4dce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <699d0274-285f-3d30-654d-d9ca59fe4dce@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 02:59:23AM +0200, Jan Danielsson wrote:

>    This seems to accomplish everything I want except that the the "git
> push" deletes any branches I have created on my self-hosted
> repository.

A mirrored push is basically:

  - push all refs, i.e., a "+refs/*:refs/*" refspec

  - enable --prune, to delete any branches that don't exist on the local
    side

But you can do those two things separately if you like.  So your options
are either:

  1. Drop the pruning (in which case deleted branches from the sync may
     accumulate, but depending on the patterns that may or may not be a
     problem).

  2. Use two different namespaces for the synced branches and the
     private ones (e.g., refs/mirror/* in addition to your branches in
     refs/heads/*). The obvious downside is that anybody cloning your
     downstream mirror doesn't pick up refs/mirror unless they configure
     that refspec explicitly.

-Peff
