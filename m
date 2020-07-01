Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52119C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 15:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEE82077D
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 15:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbgGAPh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:37:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:47328 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731399AbgGAPh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 11:37:27 -0400
Received: (qmail 24614 invoked by uid 109); 1 Jul 2020 15:37:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2020 15:37:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6092 invoked by uid 111); 1 Jul 2020 15:37:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2020 11:37:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Jul 2020 11:37:26 -0400
From:   Jeff King <peff@peff.net>
To:     Fabio Frumento <frumento.fabio@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Built Git 2.27.0 from sources on macOS Catalina fails on "make
 profile"
Message-ID: <20200701153726.GC6726@coredump.intra.peff.net>
References: <618374D7-60E1-4942-B29F-4F2EA261996F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <618374D7-60E1-4942-B29F-4F2EA261996F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 01, 2020 at 03:17:05PM +0200, Fabio Frumento wrote:

> now I'm struggling during the ```make profile``` step
> [...]
> I'm a little surprised as presumed, since 2.27.0 is an official
> release, all the tests should pass without any issue.

They generally do (not just for releases but for every commit that hits
master). However, we've sometimes seen weird test failures from "make
profile" (which in my experience isn't all that well maintained).

That said, "make profile" passes for me on v2.27.0, on Linux.  It's
possible that a test is racy (the profiler often slows things down,
exacerbating races), but I can't seem to get t0410 to fail with our
usual stress-test to find races.

If you don't care about profile-optimized builds, then I'd suggest
skipping "make profile".

If you want to look further into the test failure, probably it would
help to re-run the test with more verbose settings. E.g.:

  [wait for this to fail, which would leave the problematic version of
   git in the build directory]
  $ make profile
  $ cd t
  $ ./t0410-partial-clone.sh -v -i -x

then we could see what's failing.

> How to file a bug to the Git developers?

I think you just did.

-Peff
