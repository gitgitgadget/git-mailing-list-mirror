Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8320520958
	for <e@80x24.org>; Tue, 21 Mar 2017 01:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756226AbdCUBSp (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:18:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:48301 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755478AbdCUBSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 21:18:44 -0400
Received: (qmail 9944 invoked by uid 109); 21 Mar 2017 01:18:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 01:18:43 +0000
Received: (qmail 9803 invoked by uid 111); 21 Mar 2017 01:18:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 21:18:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 21:18:38 -0400
Date:   Mon, 20 Mar 2017 21:18:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] prefix_filename cleanups
Message-ID: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed a spot in builtin/bundle.c that would benefit from using
prefix_filename(). But when I tried to use it, I noticed its interface
was a little error-prone (because it returns a static buffer). And
indeed, a little digging found a bug in hash-object related to this.

So here's the fix for the hash-object bug, some cleanups to make such
bugs less likely, and then finally the bundle conversion. The bundle
thing does fix some minor bugs. It _could_ come before the cleanups if
we wanted to float the fixes to the top, but the function is much more
pleasant to call after the cleanups. :)

  [1/6]: hash-object: fix buffer reuse with --path in a subdirectory
  [2/6]: prefix_filename: move docstring to header file
  [3/6]: prefix_filename: drop length parameter
  [4/6]: prefix_filename: return newly allocated string
  [5/6]: prefix_filename: simplify windows #ifdef
  [6/6]: bundle: use prefix_filename with bundle path

 abspath.c              | 30 +++++++++++-------------------
 apply.c                | 11 ++++++-----
 builtin/bundle.c       |  8 +-------
 builtin/config.c       |  4 +---
 builtin/hash-object.c  | 10 +++++-----
 builtin/log.c          |  3 +--
 builtin/mailinfo.c     | 11 ++---------
 builtin/merge-file.c   | 18 +++++++++++-------
 builtin/rev-parse.c    |  6 +++---
 builtin/worktree.c     |  5 +++--
 cache.h                | 14 +++++++++++++-
 diff-no-index.c        |  7 +++----
 diff.c                 |  6 +++---
 parse-options.c        |  2 +-
 setup.c                | 11 ++++++++---
 t/t1007-hash-object.sh | 10 ++++++++++
 worktree.c             |  5 ++++-
 17 files changed, 86 insertions(+), 75 deletions(-)

-Peff
