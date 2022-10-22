Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E683C38A2D
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 00:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJVAMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJVAMb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 20:12:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF38B2A17F6
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:12:29 -0700 (PDT)
Received: (qmail 15154 invoked by uid 109); 22 Oct 2022 00:12:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 00:12:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18821 invoked by uid 111); 22 Oct 2022 00:12:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 20:12:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 20:12:28 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>
Subject: Re: [PATCH 3/4] repack: use tempfiles for signal cleanup
Message-ID: <Y1M1bFNV8DybuJtt@coredump.intra.peff.net>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
 <Y1MTJz3wy5xDEPEH@coredump.intra.peff.net>
 <xmqqmt9oizcq.fsf@gitster.g>
 <Y1MqPjnYoWcOgXo6@coredump.intra.peff.net>
 <Y1MvGIVz9bTTsS25@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1MvGIVz9bTTsS25@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 07:45:28PM -0400, Taylor Blau wrote:

> TBH, I've always found fname_old to be a confusing name. It's not really
> "old", in fact we just had pack-objects write that file ;-). It really
> does pertain to the tempfile, and I think using get_tempfile_path() when
> we have a tempfile to rename is sensible.

I don't love it either, but I've kept it in what I'm preparing, just
because we need _some_ variable to avoid writing:

  get_tempfile_path(data->tempfiles[ext])

over and over. And using the same one keeps the diff minimal. If it's
too terrible we can rename it on top. :)

> I think that your proposed error message is good, too, and doubly so
> since it lets us get rid of fname_old entirely. Yay :-).

Thanks. I'm preparing something along those lines.

-Peff
