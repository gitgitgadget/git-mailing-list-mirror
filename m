Return-Path: <SRS0=89BL=BL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3496C433E0
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 01:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994142072A
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 01:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgHABop (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:44:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:44738 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgHABop (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 21:44:45 -0400
Received: (qmail 28282 invoked by uid 109); 1 Aug 2020 01:44:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Aug 2020 01:44:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3656 invoked by uid 111); 1 Aug 2020 01:44:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 21:44:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 21:44:43 -0400
From:   Jeff King <peff@peff.net>
To:     "Jason Pyeron" <jpyeron@pdinc.us>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: Re: I have gone and done a bad thing - malformed tree objects
Message-ID: <20200801014443.GA1464485@coredump.intra.peff.net>
References: <19ca801d66541$cf872af0$6e9580d0$@pdinc.us>
 <xmqqh7trb0sr.fsf@gitster.c.googlers.com>
 <19cab01d66544$ecb402d0$c61c0870$@pdinc.us>
 <xmqq8sf2b3be.fsf@gitster.c.googlers.com>
 <045701d6678f$1f03df20$5d0b9d60$@pdinc.us>
 <20200731231521.GB1461090@coredump.intra.peff.net>
 <046201d66796$fb575bd0$f2061370$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <046201d66796$fb575bd0$f2061370$@pdinc.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 08:01:58PM -0400, Jason Pyeron wrote:

> > That should be dropping everything that isn't reachable. I'd suggest to
> > expire reflogs, though it looks like you've also tried "git gc" with
> > reflog expiration. Does removing .git/logs entirely help?
> > 
> > If not, are you sure it isn't actually reachable from your history? What
> > does:
> > 
> >   git rev-list --all --objects | grep 00009623a06
> 
> $ git rev-list --all --objects | grep 00009623a06
> 00009623a06b8dea7c151542fc789539599c07d0 src/htdocs
> (it is still running...)
> 
> But that is an expected result, I will be back at work on Sunday.

So it sounds like it's still reachable, and you'd need to rewrite
history to get rid of it. Or is that object OK, and it's a containing
tree that mentions it with the wrong mode the problem? In that case,
same question: is the containing tree reachable?

-Peff
