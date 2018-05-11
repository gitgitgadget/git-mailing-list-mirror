Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D59F1F406
	for <e@80x24.org>; Fri, 11 May 2018 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeEKSAd (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 14:00:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:36350 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751052AbeEKSAc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 14:00:32 -0400
Received: (qmail 16592 invoked by uid 109); 11 May 2018 18:00:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 May 2018 18:00:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7831 invoked by uid 111); 11 May 2018 18:00:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 May 2018 14:00:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2018 14:00:30 -0400
Date:   Fri, 11 May 2018 14:00:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] a few mark_parents_uninteresting cleanups
Message-ID: <20180511180029.GA11290@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the discussion from February:

  https://public-inbox.org/git/1519522496-73090-1-git-send-email-dstolee@microsoft.com/

There I theorized that some of these extra has_object_file() checks were
unnecessary. After poking around a bit, I've convinced myself that this
is the case, so here are some patches.

After Stolee's fix in ebbed3ba04 (revision.c: reduce object database
queries, 2018-02-24), I doubt this will provide any noticeable speedup.
IMHO the value is just in simplifying the logic.

The first two patches are the actual has_object_file simplifications.
The second two are an attempt to fix some head-scratching I had while
reading mark_parents_uninteresting(). I hope the result is easier to
follow, but I may have just shuffled one confusion for another. :)

  [1/4]: mark_tree_contents_uninteresting(): drop missing object check
  [2/4]: mark_parents_uninteresting(): drop missing object check
  [3/4]: mark_parents_uninteresting(): replace list with stack
  [4/4]: mark_parents_uninteresting(): avoid most allocation

 revision.c | 90 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

-Peff
