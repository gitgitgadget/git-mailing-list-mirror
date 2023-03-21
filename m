Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C76C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjCUSmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCUSmS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:42:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E931E1F7
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:42:12 -0700 (PDT)
Received: (qmail 28632 invoked by uid 109); 21 Mar 2023 18:42:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 18:42:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2936 invoked by uid 111); 21 Mar 2023 18:42:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 14:42:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 14:42:10 -0400
From:   Jeff King <peff@peff.net>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: .gitconfig: -c core.pager='less -+F -+X' status
Message-ID: <20230321184210.GM3119834@coredump.intra.peff.net>
References: <92e2b9d2-e259-6bba-7080-28a01c0d323c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92e2b9d2-e259-6bba-7080-28a01c0d323c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2023 at 03:24:53PM +0100, Alejandro Colomar wrote:

> Hi,
> 
> I wrote recently some aliases to not clutter my screen when I want to
> check something quick:
> 
> $ head -n4 ~/.gitconfig 
> [alias]
> 	df = -c core.pager='less -+F -+X' diff
> 	sw = -c core.pager='less -+F -+X' show
> 	st = -c core.pager='less -+F -+X' status
> 
> Now, `git df` and `git sw` work as expected: they open a less window,
> and it's later closed with `q`, with no traces in my screen except for
> the command itself.  
> 
> However, `git st` doesn't seem to work.  It prints everything to screen,
> and then exits.

git-status doesn't invoke the pager by default:

  $ git -c core.pager='echo foo' log
  foo

  $ git -c core.pager='echo foo' status
  On branch [...etc]

You can configure it to do so:

  git config --global pager.status true

Or if you just want it to happen in your alias, try:

  [alias]
      st = -p -c core.pager='less -+F -+X' status

-Peff
