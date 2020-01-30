Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F028C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 09:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8E620702
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 09:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgA3Jv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:51:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:48312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726882AbgA3Jv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 04:51:56 -0500
Received: (qmail 25997 invoked by uid 109); 30 Jan 2020 09:51:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 09:51:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22573 invoked by uid 111); 30 Jan 2020 09:59:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 04:59:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 04:51:55 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] some minor memory allocation cleanups
Message-ID: <20200130095155.GA839988@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are a result of me poking at the results of:

  git grep 'x[mc]alloc.*[+*] '

looking for any buffer allocation computations that could overflow (and
hence under-allocate).

There are a few hits left after this in the commit-graph code. Those
will be dealt with in a separate series (coming soon!) since they have
other problems, as discussed in:

  https://lore.kernel.org/git/20191027042116.GA5801@sigill.intra.peff.net/

(those have to do with normalize_path_copy(), hence the only
semi-related documentation patch here).

  [1/3]: normalize_path_copy(): document "dst" size expectations
  [2/3]: walker_fetch(): avoid raw array length computation
  [3/3]: traverse_trees(): use stack array for name entries

 path.c      |  2 ++
 tree-walk.c | 13 ++++++++-----
 walker.c    |  4 +++-
 3 files changed, 13 insertions(+), 6 deletions(-)

-Peff
