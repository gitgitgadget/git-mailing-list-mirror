Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4E7C433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512126146D
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhA1GMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:12:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:41610 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhA1GMv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:12:51 -0500
Received: (qmail 9607 invoked by uid 109); 28 Jan 2021 06:12:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 06:12:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25226 invoked by uid 111); 28 Jan 2021 06:12:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 01:12:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 01:12:09 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] convert hash_pos() to oid_pos()
Message-ID: <YBJVuckmbGriVa//@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I started this series in early December, after getting annoyed that we
still have a function called sha1_pos(). But before I got a chance to
polish it, it became hash_pos(). That removed most of my annoyance,
though I do still like the type-safety that using object_id brings.

And of course there were some interesting cleanups along the way. So I
decided to rebase and send it anyway. I think one could argue that
hash_pos() is a better interface because a caller _could_ use it without
an object_id.  But in practice we do not seem to do so (the one
exception is rerere, but I ended up refactoring that away anyway).

So here it is. Possibly code churn, possibly cleanup. Opinions welcome. :)

  [1/6]: commit_graft_pos(): take an oid instead of a bare hash
  [2/6]: rerere: check dirname format while iterating rr_cache directory
  [3/6]: rerere: tighten rr-cache dirname check
  [4/6]: rerere: use strmap to store rerere directories
  [5/6]: hash_pos(): convert to oid_pos()
  [6/6]: oid_pos(): access table through const pointers

 builtin/name-rev.c  | 10 +++---
 commit-graph.c      | 30 +++++++++---------
 commit.c            | 18 +++++------
 commit.h            |  2 +-
 hash-lookup.c       | 18 +++++------
 hash-lookup.h       | 10 +++---
 oid-array.c         |  8 ++---
 pack-bitmap-write.c |  8 ++---
 rerere.c            | 75 ++++++++++++++++++++-------------------------
 shallow.c           |  2 +-
 10 files changed, 87 insertions(+), 94 deletions(-)

-Peff
