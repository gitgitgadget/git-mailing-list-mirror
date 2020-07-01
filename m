Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A8FC433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BE0207FB
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbgGAQKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:10:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:47384 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731759AbgGAQKT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 12:10:19 -0400
Received: (qmail 24760 invoked by uid 109); 1 Jul 2020 16:10:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2020 16:10:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6512 invoked by uid 111); 1 Jul 2020 16:10:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2020 12:10:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Jul 2020 12:10:18 -0400
From:   Jeff King <peff@peff.net>
To:     Fabio Frumento <frumento.fabio@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Built Git 2.27.0 from sources on macOS Catalina fails on "make
 profile"
Message-ID: <20200701161018.GD6726@coredump.intra.peff.net>
References: <618374D7-60E1-4942-B29F-4F2EA261996F@gmail.com>
 <20200701153726.GC6726@coredump.intra.peff.net>
 <E9210645-66F4-4B76-BB26-C8282AE23B3D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E9210645-66F4-4B76-BB26-C8282AE23B3D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 01, 2020 at 06:00:49PM +0200, Fabio Frumento wrote:

> I get several messages like this
> 
> LLVM Profile Warning: Unable to track new values: Running out of static counters.  Consider using option -mllvm -vp-counters-per-site=<n> to allocate more value profile counters at compile time.

That could be related. I don't know enough about llvm's profiling to
say. If it's just a warning and not terminating the process, that might
be OK. But some of the tests check the stderr from Git. If the profiled
binaries are producing extra messages, that could cause a problem (and
it looks like t0410.15 that you posted does make sure stderr is empty,
so this seems a likely culprit).

> I’ve checked the scripts in the t folder, they use #!/bin/sh while
> I’m using zsh could  it be of some relevance? Which shell are they
> supposed to be run?

They're generally run with whatever $SHELL_PATH is set by the Makefile
knobs, which defaults to /bin/sh. The interactive shell you're using
shouldn't be relevant.

-Peff
