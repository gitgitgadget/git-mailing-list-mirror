Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92146C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 04:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiKCEna (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 00:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiKCEnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 00:43:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49D52616
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 21:43:23 -0700 (PDT)
Received: (qmail 12859 invoked by uid 109); 3 Nov 2022 04:43:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Nov 2022 04:43:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14224 invoked by uid 111); 3 Nov 2022 04:43:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Nov 2022 00:43:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Nov 2022 00:43:22 -0400
From:   Jeff King <peff@peff.net>
To:     Evan Benn <evanbenn@google.com>
Cc:     git@vger.kernel.org
Subject: Re: bug: git format prints no final newline
Message-ID: <Y2NG6u1TVdDBZAZE@coredump.intra.peff.net>
References: <CAKz_xw2X+eapmASqG7V=RXehh7=LN24m+MJPn-wx80oZAZHBnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKz_xw2X+eapmASqG7V=RXehh7=LN24m+MJPn-wx80oZAZHBnQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2022 at 02:14:37PM +1100, Evan Benn wrote:

> This command omits the final newline:
> 
> git log --format=format:"%H"

This is the intended behavior. See the section on "tformat:" in "git
help log", and the discussion of "terminator" vs "separator" semantics.

The "separator" semantics are helpful for most multiline formats (where
your separator is probably a blank line, and you don't want an extra one
at the end). Terminator is more useful for one-line outputs.

I think one could argue that the terminator one is what most people want
and would be a better default, but "format" is the way it is for
historical compatibility. If you use the do-what-I-mean form of:

  git log --format=%H

then it defaults to tformat (notice no "format:" or "tformat:" keyword;
we infer from the presence of "%H" in the name that it's a custom
format, and that is what defaults to tformat).

-Peff
