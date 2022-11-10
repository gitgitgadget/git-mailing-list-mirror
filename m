Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416BEC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 21:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiKJVlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 16:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKJVlv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 16:41:51 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35731ECC
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 13:41:50 -0800 (PST)
Received: (qmail 25574 invoked by uid 109); 10 Nov 2022 21:41:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Nov 2022 21:41:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29983 invoked by uid 111); 10 Nov 2022 21:41:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Nov 2022 16:41:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Nov 2022 16:41:49 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael McClimon <michael@mcclimon.org>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] Git.pm: add semicolon after catch statement
Message-ID: <Y21wHWXyO/J+Jn9O@coredump.intra.peff.net>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221016212236.12453-2-michael@mcclimon.org>
 <Y0yRStZ6gM+H8/Bf@coredump.intra.peff.net>
 <Y0y7UdLf3qd7RgVQ@newk>
 <Y02SHlW1rNQdfCHI@coredump.intra.peff.net>
 <28orrrr1-444q-6595-po76-3nr67r1pp4p0@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28orrrr1-444q-6595-po76-3nr67r1pp4p0@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 04:10:22PM +0100, Johannes Schindelin wrote:

> Hi Peff,
> 
> On Mon, 17 Oct 2022, Jeff King wrote:
> 
> > [... talking about safe.directory ...]
> >
> > But curiously this still does not pass after your patch, because we seem
> > to actually open the repository! I think this is because the C code
> > allows an explicit GIT_DIR to override the safe-directory checks.
> 
> Yes, I remember that this was something we discussed at some length during
> the embargo: what to do with the explicitly-specified `GIT_DIR` when
> verifying the ownership, and my recollection is that we asserted that
> setting `GIT_DIR` qualifies for "they know what they're doing" (in
> particular when it is done in a script, not interactively).

Thanks for confirming. I'm not sure if you read the rest of the thread,
but the bug turned out to be in Git.pm, which sets GIT_DIR without
knowing what it's doing. :)

We ended up with 20da61f25f (Git.pm: trust rev-parse to find bare
repositories, 2022-10-22) as the fix.

-Peff
