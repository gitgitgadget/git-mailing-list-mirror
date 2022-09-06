Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E378ECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 20:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiIFU7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiIFU7F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 16:59:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733BA9D8CB
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 13:59:01 -0700 (PDT)
Received: (qmail 19320 invoked by uid 109); 6 Sep 2022 20:59:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Sep 2022 20:59:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5733 invoked by uid 111); 6 Sep 2022 20:59:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Sep 2022 16:59:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Sep 2022 16:58:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] bug with rev-list --verify-objects and commit-graph
Message-ID: <Yxe0k++LA/UfFLF/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While looking at something unrelated, I noticed that "git rev-list
--verify-objects" will not actually notice corruptions of commits that
are found in a commit graph. This fixes it.

The first one is a cleanup that is not strictly related, but is needed
for the tests in the second to work reliably (and is a good idea
anyway).

The second is the fix. I don't think it's super-important, as we do not
use --verify-objects for anything, since d21c463d55 (fetch/receive:
remove over-pessimistic connectivity check, 2012-03-15). And it's not
even documented, so perhaps we should just consider getting rid of it.
But in the meantime, it was easy enough to correct.

  [1/2]: lookup_commit_in_graph(): use prepare_commit_graph() to check for graph
  [2/2]: rev-list: disable commit graph with --verify-objects

 commit-graph.c  |  2 +-
 revision.c      |  1 +
 t/t1450-fsck.sh | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

-Peff
