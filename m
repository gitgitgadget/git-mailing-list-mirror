Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C0EC54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 19:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjAPTvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjAPTvN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 14:51:13 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360272A994
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 11:51:12 -0800 (PST)
Received: (qmail 15991 invoked by uid 109); 16 Jan 2023 19:51:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Jan 2023 19:51:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 652 invoked by uid 111); 16 Jan 2023 19:51:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Jan 2023 14:51:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Jan 2023 14:51:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: unleak "-v <num>"
Message-ID: <Y8WqruNU5Z6ewJte@coredump.intra.peff.net>
References: <xmqqv8l8gr6s.fsf@gitster.g>
 <Y8WJnGHs5nM5GwBM@coredump.intra.peff.net>
 <xmqqpmbecoom.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmbecoom.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2023 at 10:35:53AM -0800, Junio C Hamano wrote:

> > The word "unleak" in the subject made me think about UNLEAK(), so this
> > is a small tangent. This is exactly the kind of case that I designed
> > UNLEAK() for, because the solution really is "while you are assigning to
> > X, also keep a copy of the pointer in Y to be freed later".
> 
> Yup.  I was originally planning to use UNLEAK(), but it felt ugly to
> UNLEAK(rev.subject_prefix), as it stores borrowed pointer sometimes
> and owned pointer some other times, which is the exact reason why I
> started looking for a clean way to plug this leak.  So I ended up
> with declaring that the member should only store a borrowed pointer.

That's actually one of the nice things about UNLEAK(). It is OK to
over-mark something that may or may not be allocated.

> The first sentence needs to be rephrased, as it does not make much
> sense to have something usually be X and always be X at the same
> time (I'd just remove "always" from there).

Yep, agreed.

-Peff
