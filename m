Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF58C636D4
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 11:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjBALf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 06:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjBALf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 06:35:56 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69AF3431C
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 03:35:54 -0800 (PST)
Received: (qmail 31495 invoked by uid 109); 1 Feb 2023 11:35:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 11:35:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19317 invoked by uid 111); 1 Feb 2023 11:35:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 06:35:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 06:35:53 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>
Subject: [PATCH 0/4] t/lib-httpd ssl fixes
Message-ID: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While chasing down a possible HTTP/2 problem in our test suite (which
turns out not to be a Git bug, I think), I tried running the tests with
LIB_HTTPD_SSL=1, as TLS affects HTTP/2 upgrade.

Sadly, apache would not start at all with our ssl config. It looks like
this has probably been broken for many years, depending on your apache
and openssl versions.

The final two patches here fix ssl problems I found. The first two
patches drop support for older apache. This yields some minor cleanups,
and makes the ssl fixes slightly easier. I've cc'd Todd as the last
person to express support for Apache 2.2, in 2017. I'm hoping even
CentOS has moved on by now, but we'll see. :)

  [1/4]: t/lib-httpd: bump required apache version to 2.2
  [2/4]: t/lib-httpd: bump required apache version to 2.4
  [3/4]: t/lib-httpd: drop SSLMutex config
  [4/4]: t/lib-httpd: increase ssl key size to 2048 bits

 t/lib-httpd.sh          | 11 +++++++----
 t/lib-httpd/apache.conf | 31 ++++---------------------------
 t/lib-httpd/ssl.cnf     |  2 +-
 3 files changed, 12 insertions(+), 32 deletions(-)

-Peff
