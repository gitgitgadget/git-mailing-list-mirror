Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47EE91F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeHNVCV (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:02:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:54926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725915AbeHNVCV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:02:21 -0400
Received: (qmail 31777 invoked by uid 109); 14 Aug 2018 18:14:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 18:14:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24368 invoked by uid 111); 14 Aug 2018 18:14:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 14:14:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 14:13:59 -0400
Date:   Tue, 14 Aug 2018 14:13:59 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: [PATCH 0/4] finishing touches on jk/for-each-object-iteration
Message-ID: <20180814181358.GA26391@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
 <20180813184506.18232-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180813184506.18232-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 11:45:06AM -0700, Jonathan Tan wrote:

> >   [1/7]: for_each_*_object: store flag definitions in a single location
> >   [2/7]: for_each_*_object: take flag arguments as enum
> >   [3/7]: for_each_*_object: give more comprehensive docstrings
> >   [4/7]: for_each_packed_object: support iterating in pack-order
> >   [5/7]: t1006: test cat-file --batch-all-objects with duplicates
> >   [6/7]: cat-file: rename batch_{loose,packed}_object callbacks
> >   [7/7]: cat-file: support "unordered" output for --batch-all-objects
> 
> Thanks for laying all the patches out so cleanly! All of them are:
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
> 
> Normally I would re-explain the patches to demonstrate that I understand
> them, but in this case, I think they are simple enough - patches 1, 2,
> 3, and 6 are refactorings that I agree with, patch 5 just makes a test
> more comprehensive, and patches 4 and 7 do what their commit messages
> say.
> 
> Stefan brought up the concern that cache.h is increasing in size, but I
> agree with the patch as written that it's probably best that we
> centralize all the flags somewhere, and we can deal with the location in
> a future patch.

Thanks for the review. Here are a few patches on top to deal with the
cache.h thing, as well as some optimizations that came out of discussing
oidset in another thread (I left out for now the "big" optimization of
moving oidset to a different data structure; that's complicated enough
to be dealt with on its own, I think).

The first patch here could arguably be squashed into the final patch of
the original series, but I'm OK with it either way.

  [1/4]: cat-file: use oidset check-and-insert
  [2/4]: cat-file: split batch "buf" into two variables
  [3/4]: cat-file: use a single strbuf for all output
  [4/4]: for_each_*_object: move declarations to object-store.h

 builtin/cat-file.c     | 43 +++++++++++---------
 builtin/prune-packed.c |  1 +
 cache.h                | 75 -----------------------------------
 object-store.h         | 90 ++++++++++++++++++++++++++++++++++++++++++
 packfile.h             | 20 ----------
 5 files changed, 116 insertions(+), 113 deletions(-)

-Peff
