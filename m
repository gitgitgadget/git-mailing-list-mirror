Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D997BC6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 01:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIMBeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 21:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIMBeW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 21:34:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF4D5FBB
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 18:34:20 -0700 (PDT)
Received: (qmail 29768 invoked by uid 109); 13 Sep 2022 01:34:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Sep 2022 01:34:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20156 invoked by uid 111); 13 Sep 2022 01:34:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Sep 2022 21:34:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Sep 2022 21:34:19 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] chainlint: colorize problem annotations and test
 delimiters
Message-ID: <Yx/eG5xJonNh7Dsz@coredump.intra.peff.net>
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
 <Yx/LpUglpjY5ZNas@coredump.intra.peff.net>
 <CAPig+cRTatQRS2MyOTfmz56UKqtz_x_Gk6j=rnYR-jTkM-CDdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRTatQRS2MyOTfmz56UKqtz_x_Gk6j=rnYR-jTkM-CDdQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2022 at 08:30:02PM -0400, Eric Sunshine wrote:

> This is indeed a lot of new processes, but this color interrogation is
> done lazily, only if a problem is detected, so it should be zero-cost
> in the (hopefully) normal case of a lint-clean script.
> 
> I had the exact same thought about the cost being paid by test-lib.sh
> making all those `tput` invocations.

Ah, right, that's even better.

I wondered if we could use the same trick in test-lib.sh, but it does
color some output even on success. But on further thought, the reason
that I couldn't measure any impact of tput in my other message may have
just been because I was running under "prove". So there's no tty and
thus no coloring in the first place. Not to mention that I am using
--verbose-log, which also suppresses color.

So I suspect there is really nothing to speed up at all. Most cases
running all of the tests will end up turning off color anyway. And if
they are not, they are probably bottle-necked on the terminal speed. ;)

-Peff
