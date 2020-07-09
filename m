Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC9AC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 20:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7DD520720
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 20:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgGIUdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:33:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:53506 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgGIUdh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 16:33:37 -0400
Received: (qmail 5763 invoked by uid 109); 9 Jul 2020 20:33:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jul 2020 20:33:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24917 invoked by uid 111); 9 Jul 2020 20:33:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jul 2020 16:33:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Jul 2020 16:33:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 0/4] deterministic commit timestamps in tests
Message-ID: <20200709203336.GA2748777@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most tests use test_tick or test_commit to get deterministic timestamps
in commits. Some don't because they don't care about the timestamps. But
they can still be annoying to debug, since the output changes from run
to run.

This series sets a default timestamp for those scripts, in a way that
doesn't interfere with anybody using test_tick. The change is in the
final commit. The others are preparatory to deal with fallout in the
test suite. Normally fallout would give me pause about whether this is a
good idea, but a) there's not much of it and b) I think it helped shake
out questionable assumptions in those tests.

This a replacement for the patches being discussed in:

  https://lore.kernel.org/git/pull.816.git.git.1594149804313.gitgitgadget@gmail.com/

It looks like Junio already picked up one of the fixes as
jk/t6000-timestamp-fix. The first patch here is identical (so we can
either drop that branch, or drop the first patch from this series and
apply on top).

  [1/4]: t6000: use test_tick consistently
  [2/4]: t9700: loosen ident timezone regex
  [3/4]: t5539: make timestamp requirements more explicit
  [4/4]: test-lib: set deterministic default author/committer date

 t/t5539-fetch-http-shallow.sh | 4 +++-
 t/t6000-rev-list-misc.sh      | 7 +++++--
 t/t9700/test.pl               | 6 +++---
 t/test-lib.sh                 | 3 +++
 4 files changed, 14 insertions(+), 6 deletions(-)

-Peff
