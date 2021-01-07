Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBDFC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F9E52333D
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbhAGJm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:42:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:48524 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbhAGJmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 04:42:25 -0500
Received: (qmail 16058 invoked by uid 109); 7 Jan 2021 09:41:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jan 2021 09:41:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26427 invoked by uid 111); 7 Jan 2021 09:41:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jan 2021 04:41:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jan 2021 04:41:43 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Harold Kim <h.kim@flatt.tech>
Subject: [PATCH 0/2] disallow newlines in git:// URLs
Message-ID: <X/bXV9dGFK2bxBV0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This addresses an issue brought up by Harold Kim on the security list.
In general, Git handles repo paths with newlines just fine, and this
even works over the git:// protocol. However, because of the sparseness
of that protocol, it's easy to craft a malicious URL that makes a valid
request for other protocols, like http (and submodules make it easy-ish
to convince somebody to clone your crafted URL).

Since it's unlikely that anybody is relying on having a newline in their
git:// repo in the first place, it's worth outlawing them to make it
less likely for a Git client to be used as a protocol redirect.

  [1/2]: git_connect_git(): forbid newlines in host and path
  [2/2]: fsck: reject .gitmodules git:// urls with newlines

 connect.c                     |  2 ++
 fsck.c                        |  2 +-
 t/t5570-git-daemon.sh         |  5 +++++
 t/t7416-submodule-dash-url.sh | 15 +++++++++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

-Peff
