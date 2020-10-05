Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A2DC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175D72078D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJEIaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:30:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:49390 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgJEIaG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:30:06 -0400
Received: (qmail 31227 invoked by uid 109); 5 Oct 2020 08:30:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 08:30:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17345 invoked by uid 111); 5 Oct 2020 08:30:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 04:30:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 04:30:04 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/7] t7450: test verify_path() handling of gitmodules
Message-ID: <20201005083004.GC2862927@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005072015.GD2291074@coredump.intra.peff.net>
 <20201005075311.GG1166820@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005075311.GG1166820@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 12:53:11AM -0700, Jonathan Nieder wrote:

> > @@ -155,8 +155,14 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
> >  		{
> >  			printf "100644 blob $content\t$tricky\n" &&
> >  			printf "120000 blob $target\t.gitmodules\n"
> > -		} >bad-tree &&
> > -		tree=$(git mktree <bad-tree) &&
> > +		} >bad-tree
> > +	) &&
> > +	tree=$(git -C symlink mktree <symlink/bad-tree)
> > +'
> 
> This is super nitpicky, but: test scripts can be hard to maintain when
> there's this kind of state carried from assertion to assertion without
> it being made obvious.
> 
> Can this include "setup" or "set up" in the name to do that?  E.g.
> 
> 	test_expect_success 'set up repo with symlinked .gitmodules file' '
> 		...
> 	'

Hmph. I specifically _tried_ to do that by breaking it into a separate
test with the name "create" in it, which I thought was one of the
code-words for "I'm doing stuff that will be used in another test". But
I guess there's no official rule on that. I dug up:

  https://lore.kernel.org/git/20130826173501.GS4110@google.com/

but I guess I mis-remembered "create" being present there.

-Peff
