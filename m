Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA74EB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 08:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346204AbjFQIHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 04:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjFQIHM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 04:07:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6591999
        for <git@vger.kernel.org>; Sat, 17 Jun 2023 01:07:10 -0700 (PDT)
Received: (qmail 23880 invoked by uid 109); 17 Jun 2023 08:07:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jun 2023 08:07:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7954 invoked by uid 111); 17 Jun 2023 08:07:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Jun 2023 04:07:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Jun 2023 04:07:05 -0400
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] http: handle both "h2" and "h2h3" in curl info lines
Message-ID: <20230617080705.GA2151825@coredump.intra.peff.net>
References: <kl6lilbnrrl1.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20230617044232.GC562686@coredump.intra.peff.net>
 <20230617051559.GD562686@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230617051559.GD562686@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2023 at 01:15:59AM -0400, Jeff King wrote:

> Ah, I see. It looks like it depends on which version of curl is using.
> Perhaps the macOS image in CI has been updated (or maybe the new version
> just became available via brew or something). I was able to replicate on
> my Linux system by building and linking against curl 8.1.0, and the
> patch above (modulo some missing parentheses) fixes it.

Oh, and just to solve this one remaining riddle: it was indeed a change
in the images. If you click through to the log of the failing osx-clang
job in your first link, then expand "Set up job" and then "Runner
image", you'll see that it was using:

  https://github.com/actions/runner-images/blob/macOS-12/20230612.1/images/macos/macos-12-Readme.md

which mentions curl 8.1.2. Whereas on your other link (where the jobs
did not fail), it was last month's:

  https://github.com/actions/runner-images/blob/macOS-12/20230516.1/images/macos/macos-12-Readme.md

which has curl 8.0.1. So presumably every CI run from here forward will
fail unless we patch it.

-Peff
