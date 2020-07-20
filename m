Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE592C433E0
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA61C22482
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgGTRN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:13:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:33490 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbgGTRN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 13:13:57 -0400
Received: (qmail 23363 invoked by uid 109); 20 Jul 2020 17:13:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Jul 2020 17:13:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14430 invoked by uid 111); 20 Jul 2020 17:13:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Jul 2020 13:13:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Jul 2020 13:13:56 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Martian Chronicles <martian.chronicles@yandex.ru>,
        git <git@vger.kernel.org>
Subject: Re: BUG: Cannot use bright colors
Message-ID: <20200720171356.GA2045458@coredump.intra.peff.net>
References: <6244191595262309@mail.yandex.ru>
 <20200720165535.GI11341@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200720165535.GI11341@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 20, 2020 at 06:55:35PM +0200, SZEDER Gábor wrote:

> On Mon, Jul 20, 2020 at 07:29:52PM +0300, Martian Chronicles wrote:
> > Cannot configure git to use brightred, neither on Windows nor on Ubuntu. 
> > 
> > Steps to reproduce: 
> > 
> > 1. Create ~/.gitconfig with the two lines (or add to them to this file, if it exists):
> > 
> > [color.status]
> >         untracked = brightred
> > 
> > 2. run `git status` from a directory with untracked files
> > 
> > Expected: output in brightred
> > Actual on Linux:
> > error: invalid color value: brightred fatal: bad config variable 'color.status.untracked' in file '/home/<username>/.gitconfig' at line 2 
> > 
> > Actual on windows:
> >  brightred=normal=white.
> 
> Bright colors are supported since v2.26.0.  What Git version did you
> try?

It sounds like two different versions. :) If Git isn't complaining about
the color name on Windows, then it's probably sending out the correct
ANSI codes.  But whether those do anything you can see depends on your
terminal emulator. I don't know what options there are on Windows.

For the Windows console, there's an extra stdio layer that handles these
ANSI codes. It looks like compat/mingw.c's set_attr() would need to be
updated, but from reading it, I'm not sure it would even support these
extra colors. Probably "bold red" is the best you could do.

-Peff
