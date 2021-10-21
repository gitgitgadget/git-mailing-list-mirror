Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92295C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E425613A0
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhJUQco (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:32:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:43790 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhJUQcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 12:32:43 -0400
Received: (qmail 16095 invoked by uid 109); 21 Oct 2021 16:30:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Oct 2021 16:30:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8400 invoked by uid 111); 21 Oct 2021 16:30:27 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Oct 2021 12:30:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Oct 2021 12:30:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] pkt-line.[ch]: dead code removal
Message-ID: <YXGVotqAxn859JZf@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20211014T201317Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.2-00000000000-20211014T201317Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 10:15:10PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Remove some dead code in pkt-line.[ch], perhaps someone has an
> objection to 2/2 as we could keep that function variant around "just
> in case", but it's trivial to use the underlying function (or re-add
> this utility), so shedding the unused code seems better.

These both look good to me.

It's perhaps a little weird to shed the now-always-NULL src arguments
from packet_read() in the second one, since the underlying function we
wrap still allows them.  But it does make the callers a little simpler,
and I think if we added any new callers that I'd much rather see them
use the struct-oriented packet_reader interface instead. Which is really
why it we can get rid of this function in the first place; it's old callers
are all using that interface.

In the long run, I'd be quite happy if could get rid of all of the
non-packet_reader calls entirely, but that's a much bigger topic. This
is a nice incremental step in that direction.

-Peff
