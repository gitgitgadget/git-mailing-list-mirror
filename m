Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F793C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 20:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiG2UlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 16:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiG2UlV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 16:41:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6559554AE5
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 13:41:20 -0700 (PDT)
Received: (qmail 22449 invoked by uid 109); 29 Jul 2022 20:41:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jul 2022 20:41:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29043 invoked by uid 111); 29 Jul 2022 20:41:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 16:41:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 16:41:18 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Grunenko <grunenko.serg@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] "git log" command wraps lines not correctly while terminal
 width changed
Message-ID: <YuRF7rSskqT2YkMs@coredump.intra.peff.net>
References: <CAFRNrRYs5tkTq_Dz3qX+jZ_PJLdUwT4NgabavYeHsGOEtMTq5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFRNrRYs5tkTq_Dz3qX+jZ_PJLdUwT4NgabavYeHsGOEtMTq5w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 06:35:20PM +0400, Sergey Grunenko wrote:

> Hi, developers. I met some small bug in console report of "git log" command

I don't think this is a bug in git, because git isn't actually doing any
wrapping.

> How to reproduce:
> 1. Open terminal
> 2. go to existing repository with some branches
> 3. Change terminal width to 50 characters (or less, to be sure, that
> first line wraps)
> 4. process command "git log --graph" and be sure, that a few lines is wrapping

In your example here, any line breaking is not done by "git log", but
either by the pager ("less", by default) or by the terminal.

> 5. Increase terminal width until line breaks stop
> 6. Lines wrapping is changing and is correct

OK, so it sounds like you're probably seeing "less" get told by the
terminal that the window size has changed, and it adapts.

> 7. Click <up> <down> buttons or rotate mouse scroll to scroll text two
> screens next and back
> Incorrect behavior:
> 8. You'll see that the wrapping behavior is like terminal width didn't changed.
> 9. But if you touch the terminal width again, wrapping will be correct
> Awaited behavior:
> 8a. Lines wrapping is like terminal has changed value

The mouse scroll wheel is presumably telling the terminal to move
through its back-scroll. How it handles re-rendering of content that's
only in the back-scroll is up to it, and totally outside the control of
either git or the pager. It behaves as your 8a for me, using urxvt on
Linux. You probably need to file a report with the provider of your
terminal emulator.

-Peff
