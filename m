Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4DAC433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B6A60EE2
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhJKQVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:21:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:37024 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231607AbhJKQUX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 12:20:23 -0400
Received: (qmail 29140 invoked by uid 109); 11 Oct 2021 16:18:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Oct 2021 16:18:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19719 invoked by uid 111); 11 Oct 2021 16:18:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Oct 2021 12:18:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Oct 2021 12:18:22 -0400
From:   Jeff King <peff@peff.net>
To:     ToddAndMargo <ToddAndMargo@zoho.com>
Cc:     git@vger.kernel.org
Subject: Re: I just want the revision
Message-ID: <YWRjztTfBNvKbsWR@coredump.intra.peff.net>
References: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 10, 2021 at 07:37:12PM -0700, ToddAndMargo wrote:

> I am trying to write a script to tell me the latest revision
> showing on
> 
> https://gitlab.freedesktop.org/spice/win32/spice-nsis/-/tree/master
> 
> which is 'virtio-win: rebase on 0.164", but I can only see this
> from a web browser, as the page is dynamic.
> 
> I do have access to the git link on that page:
> 
> https://gitlab.freedesktop.org/spice/win32/spice-nsis.git
> 
> Does git (or some other) have a way of telling me
> JUST the revision without having to download the turkey?

I'd probably use an API provided by the hosting service in this case, as
Christian recommended, since it will be the most efficient route. But
just for the sake of completeness, if you wanted to limit yourself only
to Git commands, you could make a partial shallow clone of a single
branch like this:

  git clone --bare --depth 1 --filter=tree:0 \
	https://gitlab.freedesktop.org/spice/win32/spice-nsis.git
  cd spice-nsis.git
  git log -1 --format=%s

That should fetch only a single object. You only get the HEAD branch
because --depth implies --single-branch. You can use "clone -b" to get a
different branch if you want.

-Peff
