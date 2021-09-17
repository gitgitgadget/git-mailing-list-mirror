Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16CEC433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BD36121F
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242098AbhIQVsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 17:48:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:50234 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhIQVsl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 17:48:41 -0400
Received: (qmail 13591 invoked by uid 109); 17 Sep 2021 21:47:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Sep 2021 21:47:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22844 invoked by uid 111); 17 Sep 2021 21:47:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Sep 2021 17:47:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Sep 2021 17:47:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>, gitmailinglist.bentolor@xoxy.net,
        git@vger.kernel.org
Subject: Re: Should `@` be really a valid git tag name?
Message-ID: <YUUM5VqTEtjhnfjj@coredump.intra.peff.net>
References: <0c68d628-e093-1cbd-e3bd-38a827545418@gmx.net>
 <CAPUEspjbiNtffXatzNUUFYyZKRjcqetOTVqQX+MgZf_AJq9hnA@mail.gmail.com>
 <xmqq4kaihqjj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kaihqjj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 01:53:52PM -0700, Junio C Hamano wrote:

> Carlo Arenas <carenas@gmail.com> writes:
> 
> > On Fri, Sep 17, 2021 at 7:12 AM <gitmailinglist.bentolor@xoxy.net> wrote:
> >>
> >> A SO commenter pointed out, that git-check-ref-format forbids @ and
> >> maybe I should report this as a potential bug. Is it?
> >
> > a reference that is named "@" only is invalid, but refs/tags/@ is not.
> 
> ;-)  
> 
> "git check-ref-format master ; echo $?" would show that any single
> level name is "forbidden", so probably the SO commenter (whatever
> that is) was confused---it is not about @ at all.
> 
> In any case, a tag whose name is @ may be another source of
> confusion in the modern world, after we added @ as a synonym to
> HEAD.  I do not know, for example, offhand which between the HEAD or
> that tag "git show @" would choose.  It makes sense to avoid it.

In the past when we've had confusing names (like refs/heads/HEAD), we
continue to allow them at the plumbing level (to retain backwards
compatibility), but flag them at the porcelain level to prevent users
shooting themselves in the foot. This seems like a good candidate for
that (for both git-branch and git-tag).

-Peff
