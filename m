Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC13F207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947591AbdDTVH6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:07:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:37251 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947573AbdDTVH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:07:56 -0400
Received: (qmail 1947 invoked by uid 109); 20 Apr 2017 21:07:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 21:07:56 +0000
Received: (qmail 9609 invoked by uid 111); 20 Apr 2017 21:08:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 17:08:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:07:54 -0400
Date:   Thu, 20 Apr 2017 17:07:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] removing more calls to git_path()
Message-ID: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the discussion about the git_path()-related bug in:

  http://public-inbox.org/git/20170329080820.8084-1-chriscool@tuxfamily.org/

I looked over some of the calls. When I introduced git_pathdup() a few
years ago I converted most of the dangerous git_path() calls. But there
were still some left, and of course new ones have been added. This patch
cleans up some of the low-hanging fruit.

There's probably more that could be done, but this is just what I
happened to produce when looking through some of the cases the other
day. I don't think any of these is fixing a triggerable bug; they can
all be considered cleanup.

  [1/6]: bisect: add git_path_bisect_terms helper
  [2/6]: branch: add edit_description() helper
  [3/6]: use git_path_* helper functions
  [4/6]: replace xstrdup(git_path(...)) with git_pathdup(...)
  [5/6]: replace strbuf_addstr(git_path()) with git_path_buf()
  [6/6]: am: drop "dir" parameter from am_state_init

 bisect.c           |  3 ++-
 builtin/am.c       | 10 ++++------
 builtin/branch.c   |  6 +++---
 builtin/commit.c   |  6 +++---
 builtin/config.c   |  5 +++--
 builtin/pull.c     |  4 ++--
 builtin/worktree.c |  6 ++----
 fast-import.c      |  2 +-
 notes-merge.c      |  4 ++--
 sequencer.c        | 12 ++++++------
 10 files changed, 28 insertions(+), 30 deletions(-)

