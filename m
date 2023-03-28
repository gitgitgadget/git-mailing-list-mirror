Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64691C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjC1UUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC1UUq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:20:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1428D9
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:20:44 -0700 (PDT)
Received: (qmail 1862 invoked by uid 109); 28 Mar 2023 20:20:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:20:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1654 invoked by uid 111); 28 Mar 2023 20:20:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:20:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:20:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH 0/4] some chainlint fixes and performance improvements
Message-ID: <20230328202043.GA1241391@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are a few fixes for chainlint. The first patch should avoid the
confusion we discussed in the subthread at:

  https://lore.kernel.org/git/3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu/

and the relevant folks are cc'd. The rest are some old performance
improvement ideas I had for the internal chain-linter. I doubt they make
a huge difference overall, but they can be measured in certain cases.
The first one to me looks like an obvious win. The second one is
debatable, as it involves some hand-waving. The third one turned out not
to make anything faster, but makes the code a little simpler.

So I'm on the fence for patches 3 and 4 below, but the first two I think
are strict improvements.

  [1/4]: tests: run internal chain-linter under "make test"
  [2/4]: tests: replace chainlint subshell with a function
  [3/4]: tests: drop here-doc check from internal chain-linter
  [4/4]: tests: skip test_eval_ in internal chain-lint

 t/Makefile    |  2 +-
 t/test-lib.sh | 27 ++++++++++++++-------------
 2 files changed, 15 insertions(+), 14 deletions(-)

-Peff
