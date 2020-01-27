Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75850C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480EF24679
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgA0XPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:15:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:45812 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725955AbgA0XPB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 18:15:01 -0500
Received: (qmail 4710 invoked by uid 109); 27 Jan 2020 23:15:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Jan 2020 23:15:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2067 invoked by uid 111); 27 Jan 2020 23:22:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jan 2020 18:22:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jan 2020 18:14:59 -0500
From:   Jeff King <peff@peff.net>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: clarify "explicitly given" in push.default
Message-ID: <20200127231459.GD19360@coredump.intra.peff.net>
References: <ed9a0485-1e6c-79ae-6a59-655105203728@googlemail.com>
 <20200125003836.GA568952@coredump.intra.peff.net>
 <b4c31e50-6da5-7699-1069-d94091f768bd@googlemail.com>
 <20200125200554.GC5519@coredump.intra.peff.net>
 <d8007df9-002b-6db1-4769-d6bf8c338cdf@googlemail.com>
 <dfcf0201-b634-2274-f041-a6ec4491825a@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfcf0201-b634-2274-f041-a6ec4491825a@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 08:48:01PM +0100, Bert Wesarg wrote:

> > > There's another way of doing this, which is when you have a "triangular"
> > > flow: you might pull changes from origin/master into your local branch
> > > X, but then push them elsewhere. Usually this would be pushing to a
> > > branch named X on a different remote than origin (e.g., your public fork
> > > of upstream on a server). And for that you can set branch.X.pushRemote.
> 
> … it does not play well if you have have both flows in one repository.
> And I do have both flows. I track the upstream 'master' in the local
> branch 'Y' and I have also a branch 'X' which is based on 'Y' but
> should be pushed to a different remote as branch 'Y'. I have
> configured 'branch.X.pushRemote = triangular' but with 'push.default'
> set to 'upstream' I get this when:
> 
>     $ git push triangular
>     fatal: You are pushing to remote 'triangular', which is not the upstream of
>     your current branch 'X', without telling me what to push
>     to update which remote branch.
> 
> In this simple case, without a renaming, I would expect that 'git
> push' just works. May be just fallback to 'simple' if 'upstream' does
> not resolve to a fully qualified push?

I thought the point of "simple" was to be even more restrictive than
"upstream".

At any rate, your setup is sufficiently complicated that I think you'd
be better off adding a branch.X.pushRef feature (essentially a refspec
to be used just on branch X, though since the source side is implied,
it's really just a destination ref).

-Peff
