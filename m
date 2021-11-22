Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6553FC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhKVSaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:30:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:36528 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhKVSaI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:30:08 -0500
Received: (qmail 21957 invoked by uid 109); 22 Nov 2021 18:27:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 18:27:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23379 invoked by uid 111); 22 Nov 2021 18:27:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 13:27:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 13:26:59 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Enzo Matsumiya <ematsumiya@suse.de>, git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Message-ID: <YZvg8xnt0KrjqSgq@coredump.intra.peff.net>
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
 <xmqqfsrplz3z.fsf@gitster.g>
 <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
 <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com>
 <20211122164635.6zrqjqow4xa7idnn@cyberdelia>
 <211122.861r38yuun.gmgdl@evledraar.gmail.com>
 <xmqqfsrogjf0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfsrogjf0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 10:00:19AM -0800, Junio C Hamano wrote:

> > Presumably we can invoke N git <something>, where those <something> have
> > different pager.<something> config...
> 
> A tangent, but pager.<cmd> should be renamed/transitioned to
> pager.<cmd>.program, I would think.  Not that we allow characters
> that are unsafe in the configuration variable names (like dot ".")
> in the names of Git subcommands right now, but any name that is
> taken from an unbounded set should not appear anywhere but the
> second level of a three-level configuration variable name.

It does come up even now for custom commands or aliases. Here's an old
discussion of somebody with an underscore:

  https://lore.kernel.org/git/20150206124528.GA18859@inner.h.apk.li/

It would also allow other per-pager settings, though I don't off-hand
remember any that would be useful. Splitting "enabled" from "command"
would be nice, but not that important. Per-pager color.pager settings
would potentially be useful, but it's a pretty obscure feature in the
first place.

I'm definitely in favor of this in the long term, but I don't think
there's any urgency in attaching it to the current discussion (that lack
of urgency is why it has gone un-implemented for the past 6 years).

-Peff
