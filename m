Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5FCC35241
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 05:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339422071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 05:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAYFfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 00:35:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:44384 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725781AbgAYFfn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 00:35:43 -0500
Received: (qmail 10917 invoked by uid 109); 25 Jan 2020 05:35:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 05:35:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13780 invoked by uid 111); 25 Jan 2020 05:42:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jan 2020 00:42:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Jan 2020 00:35:42 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] more clang/sanitizer fixes
Message-ID: <20200125053542.GA744596@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are some more sanitizer fixes, this time from trying with clang-11.
These should go on top of jk/asan-build-fix if you want to get a
successful run with "make CC=clang-11 SANITIZE=address,undefined test".

I don't think any of them is indicative of a current bug in practice,
but the UBSan stuff makes me worried that an aggressive compiler might
do the wrong thing in some case.

  [1/4]: merge-recursive: silence -Wxor-used-as-pow warning
  [2/4]: avoid computing zero offsets from NULL pointer
  [3/4]: xdiff: avoid computing non-zero offset from NULL pointer
  [4/4]: obstack: avoid computing offsets from NULL pointer

 compat/obstack.h  |  6 ++++--
 merge-recursive.c | 19 ++++++++++++++-----
 sequencer.c       |  6 +++---
 unpack-trees.c    |  2 +-
 xdiff-interface.c | 12 ++++++++----
 5 files changed, 30 insertions(+), 15 deletions(-)

-Peff
