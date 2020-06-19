Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC79C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03C12083B
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbgFSNfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:35:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:37184 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732611AbgFSNfG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 09:35:06 -0400
Received: (qmail 2778 invoked by uid 109); 19 Jun 2020 13:35:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Jun 2020 13:35:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14720 invoked by uid 111); 19 Jun 2020 13:35:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jun 2020 09:35:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Jun 2020 09:35:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: plug minor memory leak after using
 is_descendant_of()
Message-ID: <20200619133504.GC2540897@coredump.intra.peff.net>
References: <52a584ee-ce2f-4416-3e3c-97ff15b5c346@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52a584ee-ce2f-4416-3e3c-97ff15b5c346@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 03:14:19PM +0200, René Scharfe wrote:

> cmd_pull() builds a commit_list to pass a single potential ancestor to
> is_descendant_of().  The latter leaves the list intact.  Release the
> allocated memory after the call.
> 
> Leaking in cmd_*() isn't a big deal, but sets a bad example for other
> users of is_descendant_of().

This also looks good to me.

> ---
> Patch generated with -U15 for easier review; only the pre-context is
> interesting, though.  --function-context would add even more noise.
> A --block-context option might be nice (include surrounding lines up to
> and including the previous and next lines with lower indentation). :)
> Or perhaps it's a sign that the function should be split up..

I wondered how:

  git -c diff.cpp.funcname='.*{' show --function-context

but think it always goes to the "^}" line, which is more than we want
(plus the start of the block is in the hunk header, which makes the
indentation look funky).

-Peff
