Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C83C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 22:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCA964D7F
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 22:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhA0WMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 17:12:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:41268 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234153AbhA0WMT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 17:12:19 -0500
Received: (qmail 6771 invoked by uid 109); 27 Jan 2021 22:11:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Jan 2021 22:11:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20234 invoked by uid 111); 27 Jan 2021 22:11:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Jan 2021 17:11:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Jan 2021 17:11:36 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/2] rev-list --disk-usage
Message-ID: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series teaches rev-list to compute the on-disk size used by a set
of objects. You can do the same thing with cat-file, but this is much
faster (see the timings in the second commit).

We've been running it for about 5 years at GitHub. I hesitated sending
it upstream because it's a bit weird and special-purpose. But it does
come in handy for debugging, analyzing repos, etc. So maybe others will
find it useful.

The first patch is just a test-script enhancement to let test_commit
avoid creating tags. During some recent refactoring, we actually broke
the --disk-usage feature but the test script didn't catch it because the
tags were being picked up by "--all". Since this is at least the third
time I've run into that in our test suite, I thought I'd make it a
little more convenient to avoid. :)

  [1/2]: t: add --no-tag option to test_commit
  [2/2]: rev-list: add --disk-usage option for calculating disk usage

 Documentation/rev-list-options.txt |  9 ++++++
 builtin/rev-list.c                 | 49 ++++++++++++++++++++++++++++
 pack-bitmap.c                      | 50 +++++++++++++++++++++++++++++
 pack-bitmap.h                      |  2 ++
 t/t4208-log-magic-pathspec.sh      |  9 ++----
 t/t6114-rev-list-du.sh             | 51 ++++++++++++++++++++++++++++++
 t/test-lib-functions.sh            |  9 +++++-
 7 files changed, 171 insertions(+), 8 deletions(-)
 create mode 100755 t/t6114-rev-list-du.sh

-Peff
