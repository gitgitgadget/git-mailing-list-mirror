Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9272C25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 06:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiHNGxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 02:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHNGw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 02:52:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D62043330
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 23:52:58 -0700 (PDT)
Received: (qmail 18589 invoked by uid 109); 14 Aug 2022 06:52:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 14 Aug 2022 06:52:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31632 invoked by uid 111); 14 Aug 2022 06:52:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 14 Aug 2022 02:52:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 14 Aug 2022 02:52:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: t7527 intermittent failure on macOS APFS and possible fix
Message-ID: <YvibyWKZD1+QVkXI@coredump.intra.peff.net>
References: <YvZbGAf+82WtNXcJ@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvZbGAf+82WtNXcJ@danh.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 12, 2022 at 08:52:24PM +0700, Đoàn Trần Công Danh wrote:

> Running t7527 on macOS with encrypted APFS filesystem.
> I observes intermittent failure, however, when I manually check the
> test cases, they're all passed.
> 
> I suspected fileystem caching issue.
> I added those sync-s into test steps and the test pass.
> I'm not sure if this is the intending "fix" for the tests
> since we're testing the fsmonitor with t7527.

I don't know anything about your problem area, but some tools in our
test suite that might help you get better results with an intermittent
problem (if you didn't already know about them):

  - add:

      GIT_TEST_OPTS = -x --verbose-log

    into config.mak. Then when a "make test" run fails, you can see the
    log in t/test-results/t7527-*.out.

  - try running:

      ./t7527-* --stress

    which will run a bunch of instances simultaneously, with the idea
    that the load will introduce timing issues that will trigger the
    bug. The failed instance will produce a detailed log on stdout.

That might help you get more output from the failing cases.

-Peff
