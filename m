Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318B0C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9FA20719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCZIFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:05:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:51834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726138AbgCZIFm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:05:42 -0400
Received: (qmail 627 invoked by uid 109); 26 Mar 2020 08:05:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 08:05:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12007 invoked by uid 111); 26 Mar 2020 08:15:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 04:15:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 04:05:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] use `curl-config --cflags`
Message-ID: <20200326080540.GA2200522@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was recently testing Git's behavior with respect to various versions
of libcurl. So I built a one-off libcurl and installed it in /tmp/foo,
but was surprised that:

  make CURL_CONFIG=/tmp/foo/bin/curl-config

didn't work, since we do run "$(CURL_CONFIG) --libs". This fixes it,
along with a minor optimization to the existing "--libs" call.

  [1/2]: Makefile: avoid running curl-config multiple times
  [2/2]: Makefile: use curl-config --cflags

 Makefile | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-Peff
