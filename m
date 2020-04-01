Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD7C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7B020772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 09:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgDAJw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:52:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:58014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725860AbgDAJw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 05:52:56 -0400
Received: (qmail 1065 invoked by uid 109); 1 Apr 2020 09:52:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Apr 2020 09:52:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6500 invoked by uid 111); 1 Apr 2020 10:03:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2020 06:03:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Apr 2020 05:52:55 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Fix -Wmaybe-uninitialized warnings under -O0
Message-ID: <20200401095255.GA60227@coredump.intra.peff.net>
References: <33984eeaabbfbcfd4b9d3903549d8b7d6c4ced7e.1585726172.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33984eeaabbfbcfd4b9d3903549d8b7d6c4ced7e.1585726172.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 01, 2020 at 03:30:16AM -0400, Denton Liu wrote:

> When compiling Git under -O0, gcc (Arch Linux 9.3.0-1) 9.3.0 produces
> many -Wmaybe-uninitialized warnings. These are false positives since
> when Git is compiled under -O2, gcc is smart enough to see that the
> code paths that use these variables all initialise them beforehand.
> Nonetheless, these warnings block the compilation process when
> DEVELOPER=1 is enabled (which enables -Werror).
> 
> Fix these warnings by initializing these variables with dummy values (0,
> -1 or NULL as appropriate).

Hmph. I almost always compile with -O0 and have been using gcc 9.3.0
since it was packaged for Debian a few weeks ago, but I don't see any of
these warnings.

The current version in Debian unstable is 9.3.0-8, which picks up some
extra patches from the upstream gcc-9 branch. But even if I download a
snapshot of the original 9.3.0 release, it builds fine.

So why does your version behave differently? And if this is a temporary
state for a buggy version of gcc (that may be fixed in the next point
release), is it worth changing our source code to appease it?

-Peff
