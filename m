Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A07C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 19:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9692961037
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 19:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbhHYTGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 15:06:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:59302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241036AbhHYTGI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 15:06:08 -0400
Received: (qmail 31225 invoked by uid 109); 25 Aug 2021 19:05:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Aug 2021 19:05:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10791 invoked by uid 111); 25 Aug 2021 19:05:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Aug 2021 15:05:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Aug 2021 15:05:20 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git pull' complains that a locally resurrected directory would
 be overwritten by merge when no pulled changes are affecting that directory
Message-ID: <YSaUcDQ+MIUdw6Ji@coredump.intra.peff.net>
References: <01514401-78f6-3fdc-aa74-c519fb6ab427@rawbw.com>
 <YSWXSWiDWNU93lhC@coredump.intra.peff.net>
 <CABPp-BEMXW3EOdT4jt1g63uPyZ5YuKUPfBE9BL=E66QcT5uXXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEMXW3EOdT4jt1g63uPyZ5YuKUPfBE9BL=E66QcT5uXXA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 08:42:09AM -0700, Elijah Newren wrote:

> > Is it possible to give us a more complete example, including:
> >
> >   - a url for the repository
> >   - the commit at HEAD when you ran "git checkout"
> >   - the {hash} commit from which you rescued the files
> >   - the state of the remote branch (i.e., what we attempted to merge
> >     with "git pull")
> >
> > ?
> 
> The `git checkout {hash}~1 -- math/polymake` is enough to highlight
> that Yuri doesn't just have local changes (which the merge machinery
> should allow if the incoming changes don't touch the same files), but
> local *staged* changes.  As per the merge manpage:
> 
> """
> To avoid recording unrelated changes in the merge commit, git pull and
> git merge will also abort if there are any changes registered in the
> index relative to the HEAD commit.
> """

Doh, you're right. I did a simple reproduction test, but in my example,
the merge was a fast-forward, which we do allow. Picking a branch more
carefully using:

  git for-each-ref --no-contains HEAD --no-merged HEAD refs/remotes/origin

shows the error. Sorry for the confusion.

-Peff
