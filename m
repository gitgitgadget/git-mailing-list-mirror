Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D69C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 04:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBPEfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 23:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPEe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 23:34:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287C8222C6
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 20:34:58 -0800 (PST)
Received: (qmail 20778 invoked by uid 109); 16 Feb 2023 04:34:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Feb 2023 04:34:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22497 invoked by uid 111); 16 Feb 2023 04:34:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Feb 2023 23:34:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Feb 2023 23:34:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, rsbecker@nexbridge.com
Subject: Re: [PATCH] test-genzeros: avoid raw write(2)
Message-ID: <Y+2ycMAkVd8rh50q@coredump.intra.peff.net>
References: <000001d94165$3d1cf2f0$b756d8d0$@nexbridge.com>
 <Y+0eIlsIxRr+1RYp@coredump.intra.peff.net>
 <000801d9416e$4bf844b0$e3e8ce10$@nexbridge.com>
 <xmqqwn4iycbt.fsf@gitster.g>
 <Y+05tTHdj2Jzenge@coredump.intra.peff.net>
 <xmqqwn4itmb1.fsf@gitster.g>
 <xmqqo7putj1t.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7putj1t.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2023 at 06:56:14PM -0800, Junio C Hamano wrote:

> This test helper feeds 256kB of data at once to a single invocation
> of the write(2) system call, which may be too much for some
> platforms.
> 
> Call our xwrite() wrapper that knows to honor MAX_IO_SIZE limit and
> cope with short writes due to EINTR instead, and die a bit more
> loudly by calling die_errno() when xwrite() indicates an error.

Thanks, this looks good to me.

>     I ended up avoiding write_or_die() primarily because there is
>     nothing "Git" about this helper, which is a poor-man's emulation
>     of "dd if=/dev/zero".  It felt a bit too much to pull cache.h in
>     as dependency for it.

I don't find it any more "Git" than xwrite() or die_errno(), really, but
I am quite happy with what you have here.

-Peff
