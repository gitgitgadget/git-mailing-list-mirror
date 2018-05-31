Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8021F42D
	for <e@80x24.org>; Thu, 31 May 2018 22:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeEaWjE (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 18:39:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:58482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750868AbeEaWjE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 18:39:04 -0400
Received: (qmail 23711 invoked by uid 109); 31 May 2018 22:39:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 22:39:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18331 invoked by uid 111); 31 May 2018 22:39:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 18:39:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 18:39:01 -0400
Date:   Thu, 31 May 2018 18:39:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] index-pack out-of-repo fixups
Message-ID: <20180531223901.GA18999@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coverity reported that the recently-added call to add_packed_git() in
index-pack.c actually does nothing. It's right, and it turns out this is
a minor bug in the .gitmodules fsck patches in v2.17.1. I say minor
because it errs on the side of complaining too much (so it's not a
security problem) and it comes up only in what I can imagine is a pretty
obscure case.

The second patch here fixes that. But while looking into it, I notice a
much older breakage in running "index-pack --strict" outside of a
repository entirely. That's fixed by the first patch.

  [1/2]: prepare_commit_graft: treat non-repository as a noop
  [2/2]: index-pack: handle --strict checks of non-repo packs

 builtin/index-pack.c       |  8 ++++++--
 commit.c                   |  3 +++
 t/t5300-pack-object.sh     |  6 ++++++
 t/t7415-submodule-names.sh | 10 ++++++++++
 4 files changed, 25 insertions(+), 2 deletions(-)

-Peff
