Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB78C433FE
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 20:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJWU4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Oct 2022 16:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJWU4J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2022 16:56:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AAF48A35
        for <git@vger.kernel.org>; Sun, 23 Oct 2022 13:56:03 -0700 (PDT)
Received: (qmail 31171 invoked by uid 109); 23 Oct 2022 20:56:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 23 Oct 2022 20:56:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26078 invoked by uid 111); 23 Oct 2022 20:56:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Oct 2022 16:56:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Oct 2022 16:55:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/5] repack: use tempfiles for signal cleanup
Message-ID: <Y1WqX7YRrSpkmyxH@coredump.intra.peff.net>
References: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
 <Y1M3oie5dPrRaOni@coredump.intra.peff.net>
 <Y1RUI8ny2mexxwKm@coredump.intra.peff.net>
 <xmqqtu3vflau.fsf@gitster.g>
 <Y1VzPY4zQyZbVAsm@coredump.intra.peff.net>
 <xmqqlep6fm5h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlep6fm5h.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2022 at 11:08:26AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here's a patch on top of of jk/repack-tempfile-cleanup that adjusts the
> > test (and should make the immediate racy CI pain go away). It gives some
> > explanation why the third option isn't as interesting as you'd think. If
> > somebody later wants to add such a "pack-objects died" error, we can
> > adjust sigpipe handling there.
> 
> An extremely simplified alternative would be just to say !  instead
> of test_must_fail, which essentially is ok=anycrash ;-)

I would have been tempted to do that if we hadn't already added
ok=sigpipe long ago. :)

> I did try the same exact patch before going to bed last night but
> t7700 somehow failed some other steps in my local tests and I gave
> up digging further X-<.  One step at a time...

Hopefully not my bits. :) FWIW, the tips of "master", "next", and "seen"
all pass just fine for me (minus this race on seen).

-Peff
