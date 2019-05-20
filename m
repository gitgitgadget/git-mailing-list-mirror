Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560E71F461
	for <e@80x24.org>; Mon, 20 May 2019 12:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbfETMGi (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 08:06:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:33792 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730534AbfETMGi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 08:06:38 -0400
Received: (qmail 23122 invoked by uid 109); 20 May 2019 12:06:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 May 2019 12:06:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3540 invoked by uid 111); 20 May 2019 12:07:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 May 2019 08:07:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2019 08:06:36 -0400
Date:   Mon, 20 May 2019 08:06:36 -0400
From:   Jeff King <peff@peff.net>
To:     Alejandro Sanchez <asanchez1987@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 0/4] fix BUG() with "git am -i --resolved"
Message-ID: <20190520120636.GA12634@sigill.intra.peff.net>
References: <CAA4phoGrA=AsBFHkqZ54=6ev5BH+F7rLd0Hcr-t2kF_YFNrs2g@mail.gmail.com>
 <20190520100211.GA26426@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190520100211.GA26426@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 06:02:11AM -0400, Jeff King wrote:

> I haven't tried to reproduce yet. Is the repository (and patch) that you
> used to demonstrate this publicly available? Or alternatively, is it
> possible to show a backtrace from the coredump?

Never mind. It reproduces quite easily, because AFAICT "am -i
--resolved" has been totally broken since it was converted to C (in
2015!). I guess it does not have many users. :)

> If my blind guess is right, then something like this probably fixes it:

This is indeed the problem. Here are some patches. The actual fix is
what I showed already. The other three are just making it possible to
cover this with the test suite (until now, we had no coverage of "am
--interactive" at all).

  [1/4]: am: simplify prompt response handling
  [2/4]: am: read interactive input from stdin
  [3/4]: am: drop tty requirement for --interactive
  [4/4]: am: fix --interactive HEAD tree resolution

 builtin/am.c              | 30 +++++++++++++++---------
 t/t4257-am-interactive.sh | 49 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 11 deletions(-)
 create mode 100755 t/t4257-am-interactive.sh

-Peff
