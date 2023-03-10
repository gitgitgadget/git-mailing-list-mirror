Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0222DC6FD1E
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 09:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCJJys (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 04:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjCJJyr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 04:54:47 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AD656530
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 01:54:46 -0800 (PST)
Received: (qmail 19454 invoked by uid 109); 10 Mar 2023 09:54:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Mar 2023 09:54:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10641 invoked by uid 111); 10 Mar 2023 09:54:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Mar 2023 04:54:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Mar 2023 04:54:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Better suggestions when git-am(1) fails
Message-ID: <ZAr+ZF0kCMEdaDo2@coredump.intra.peff.net>
References: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
 <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net>
 <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
 <xmqqr0tx8ubw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0tx8ubw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 01:53:55PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So here's a patch series which I think should help with the sending
> > side. Most of it is just filling in gaps in the code and tests for
> > current features. Patch 4 is the actual change. Patch 5 adds an
> > equivalent option just for format-patch. I'm not convinced anybody
> > really wants it (which is why I split it out), but it's probably worth
> > doing just in case.
> >
> >   [1/5]: diff: factor out src/dst prefix setup
> >   [2/5]: t4013: add tests for diff prefix options
> >   [3/5]: diff: add --default-prefix option
> >   [4/5]: format-patch: do not respect diff.noprefix
> >   [5/5]: format-patch: add format.noprefix option
> 
> I've reviewed these five changes, and while I am not 100% sold to
> the idea that we should force our -p1 worldview to those who choose
> to use diff.noprefix for whatever reason, I think these patches
> describe what they want to do and implement it in a very readable
> way.
> 
> Thanks.  Queued.

Thanks for looking at them. Let's see if we get any other comments on
the direction, and then I may re-roll. Even if we don't do 4 or 5, I
think the extra tests are worth adding. Either way I'd probably drop 3
(in favor of --src-prefix) and squash its tests into 2. Patch 1 isn't
worthwhile if we don't do 3-5, since we wouldn't be adding any new
callers of the helpers.

If we do proceed, I'd suggest trying to cook in 'next' for a long time
to get comment. Though I think both you and I are pessimistic that we
get a wide variety of user testing that way.

-Peff
