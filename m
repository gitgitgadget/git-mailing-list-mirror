Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF924C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35E42073F
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfK0Q3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:29:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:34068 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726514AbfK0Q3b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 11:29:31 -0500
Received: (qmail 12445 invoked by uid 109); 27 Nov 2019 16:29:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 16:29:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11291 invoked by uid 111); 27 Nov 2019 16:33:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 11:33:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 11:29:30 -0500
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] drop non-reentrant time usage
Message-ID: <20191127162930.GC30581@sigill.intra.peff.net>
References: <cover.1574867409.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1574867409.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 10:13:16PM +0700, Doan Tran Cong Danh wrote:

> gmtime/localtime is considered unsafe in multithread environment.
> 
> git was started as single-thread application, but we have some
> multi-thread code, right now.
> 
> replace all usage of gmtime/localtime by their respective reentrant ones.

I think this is a good change.

A minor point, but I think it may be simpler if the first four were just
a single patch. There's no rationale given at all in the 3rd and 4th
ones. Which is because you already explained it in patch 1, but that
won't help somebody who digs up the commit via "git blame".

So I think they either ought to be one patch, or they should repeat the
rationale (I'd probably go with the first, but I could live with the
second).

> On Windows, we may be taxed, since gmtime_r and localtime_r is our compat
> functions, because we memcpy from returned data of gmtime/localtime.
> 
> To address that, I made patch #5 and included it together with this series.
> I'm not sure how much portable it is.
> It seems to run fine with my Windows 7 x86 and Windows 10 x64 VM, (inside
> git-sdk for Windows, if it matters).
> I'm Cc-ing j6t and Dscho on that patch to get their opinions.

That makes sense from my reading of gmtime_s(), but there may be
something more subtle going on with compatibility, so I'll leave that to
the experts.

-Peff
