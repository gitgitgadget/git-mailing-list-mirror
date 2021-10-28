Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D731C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 14:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870ED60F9B
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 14:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhJ1Okh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 10:40:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:48782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231324AbhJ1Oke (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 10:40:34 -0400
Received: (qmail 16668 invoked by uid 109); 28 Oct 2021 14:38:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Oct 2021 14:38:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4603 invoked by uid 111); 28 Oct 2021 14:36:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Oct 2021 10:36:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Oct 2021 10:36:51 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] allow disabling fsync everywhere
Message-ID: <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
References: <20211028002102.19384-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211028002102.19384-1-e@80x24.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 12:21:02AM +0000, Eric Wong wrote:

> "core.fsync" and the "GIT_FSYNC" environment variable now exist
> for disabling fsync() even on packfiles and other critical data.
> 
> Running "make test -j8 NO_SVN_TESTS=1" on a noisy 8-core system
> on an HDD, adding "GIT_FSYNC=0" to the invocation brings my test
> runtime from ~4 minutes down to ~3 minutes.
> 
> SVN interopability tests are minimally affected since SVN will
> still use fsync in various places.
> 
> This will also be useful for 3rd-party tools which create
> throwaway git repositories of temporary data.

Do you mostly just care about the tests, or is the third-party tool
support important to you? I ask because most of us switched to running
the tests with --root=/some/tmpfs long ago to achieve the same speedup.

-Peff
