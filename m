Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837C6C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629506105A
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhERG2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 02:28:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:57334 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234413AbhERG2F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 02:28:05 -0400
Received: (qmail 10534 invoked by uid 109); 18 May 2021 06:26:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 06:26:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5051 invoked by uid 111); 18 May 2021 06:26:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 02:26:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 02:26:47 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Humphreys <behumphreys@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christopher Schenk <christopher@cschenk.net>,
        git@vger.kernel.org
Subject: [PATCH 0/2] fix v2.32.0-rc0 bug with Negotiate / HTTP_NOAUTH
Message-ID: <YKNeJ+NKUbD5ixA9@coredump.intra.peff.net>
References: <YKMvePOPqjwiXeQ+@C02WD045HTDG>
 <YKNVop80H8xSTCjz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKNVop80H8xSTCjz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 01:50:27AM -0400, Jeff King wrote:

> So perhaps somebody can come up with something clever, but I suspect we
> may need to just revert this for the v2.32 release, and re-break the
> case that 1b0d9545bb8 was trying to solve.
> 
> We probably should beef up the tests around http's credential-rejection,
> too, to catch this regression.

Here are some patches. The first one adds the tests, and I think is an
obvious improvement.

The second one does the revert. I'd be quite happy if somebody wants to
figure out how to fix it in a way that addresses the original problem,
and then we can replace that. But in the meantime, I think it makes
sense to prepare the revert, as we wouldn't want to release v2.32.0 with
the bug.

  [1/2]: t5551: test http interaction with credential helpers
  [2/2]: Revert "remote-curl: fall back to basic auth if Negotiate fails"

 http.c                      | 15 +++++++-------
 t/t5551-http-fetch-smart.sh | 41 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 8 deletions(-)

-Peff
