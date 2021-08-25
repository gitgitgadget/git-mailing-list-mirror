Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7642C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 01:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969D86121E
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 01:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbhHYBF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 21:05:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:58392 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236720AbhHYBF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 21:05:59 -0400
Received: (qmail 21220 invoked by uid 109); 25 Aug 2021 01:05:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Aug 2021 01:05:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4077 invoked by uid 111); 25 Aug 2021 01:05:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Aug 2021 21:05:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Aug 2021 21:05:13 -0400
From:   Jeff King <peff@peff.net>
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git pull' complains that a locally resurrected directory would
 be overwritten by merge when no pulled changes are affecting that directory
Message-ID: <YSWXSWiDWNU93lhC@coredump.intra.peff.net>
References: <01514401-78f6-3fdc-aa74-c519fb6ab427@rawbw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01514401-78f6-3fdc-aa74-c519fb6ab427@rawbw.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 09:41:49AM -0700, Yuri wrote:

> In the FreeBSD ports repository I resurrected the directory (that was
> removed a long time ago) with the command:
> 
> > $ git checkout {hash}~1 -- math/polymake
> 
> 
> I made local changes to this directory and called 'git add math/polymake'.
> 
> Then 'git pull' complained:
> 
> > $ git pull
> > error: Your local changes to the following files would be overwritten by
> merge:
> >   math/polymake/Makefile math/polymake/distinfo
> math/polymake/files/patch-Makefile
> math/polymake/files/patch-support_install.pl math/polymake/pkg-descr
> math/polymake/pkg-plist
> 
> 
> No incoming changes affect math/polymake. Nobody has created this directory
> simultaneously with me. There is no intersection with incoming changes.
> 
> 
> Why does 'git pull' complain then?

It's hard to say without seeing a full example. The merge machinery is
supposed to handle this situation (and indeed, in a simple reproduction
example it does). So presumably it thinks the other side may have
touched those files for some reason. Perhaps it's confused by rename
detection?

Is it possible to give us a more complete example, including:

  - a url for the repository
  - the commit at HEAD when you ran "git checkout"
  - the {hash} commit from which you rescued the files
  - the state of the remote branch (i.e., what we attempted to merge
    with "git pull")

?

-Peff
