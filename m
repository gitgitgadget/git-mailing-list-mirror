Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8540F203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934956AbcLMS46 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 13:56:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:55902 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932848AbcLMS45 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:56:57 -0500
Received: (qmail 24358 invoked by uid 109); 13 Dec 2016 18:56:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 18:56:56 +0000
Received: (qmail 17374 invoked by uid 111); 13 Dec 2016 18:57:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 13:57:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 13:56:53 -0500
Date:   Tue, 13 Dec 2016 13:56:53 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stephan Beyer <s-beyer@gmx.net>, Ariel <asgit@dsgml.com>,
        git@vger.kernel.org
Subject: Re: git add -p with new file
Message-ID: <20161213185653.ys3ig377zhmblncl@sigill.intra.peff.net>
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
 <20161209141129.r53b4rbtgd76fn2a@sigill.intra.peff.net>
 <alpine.DEB.2.11.1612091331170.13185@cherryberry.dsgml.com>
 <20161210085556.nwg3pbay367jqin5@sigill.intra.peff.net>
 <xmqq37hvphji.fsf@gitster.mtv.corp.google.com>
 <20161211130034.ygj5l2gbx33uknlk@sigill.intra.peff.net>
 <dc698b79-6311-a2a3-c564-a43ef071e62b@gmx.net>
 <20161213173341.wemlunlixdp6277h@sigill.intra.peff.net>
 <xmqq7f734qe0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f734qe0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 10:48:07AM -0800, Junio C Hamano wrote:

> > I think the problem is just that "add -p" does not give the whole story
> > of what you might want to do before making a commit.
> 
> The same is shared by "git diff [HEAD]", by the way.  It is beyond
> me why people use "add -p", not "git diff [HEAD]", for the final
> sanity check before committing.  
> 
> Perhaps the latter is not advertised well enough?  "add -p" does not
> even page so it is not very useful way to check what is being added
> if you are adding a new file (unless you are doing a toy example to
> add a 7-line file).

I use "add -p" routinely for my final add-and-sanity-check, and it is
certainly not because I don't know about "git diff". I think it's just
nice to break it into bite-size chunks and sort them into "yes, OK" or
"no, not yet" bins. The lack of paging isn't usually a problem, because
this "add -p" is useful precisely when you have a lot of little changes
spread across the code base.

I'd probably also run "git diff" if I wanted to look at something
bigger. And I routinely use "git status", too, to see the full state of
my tree.

To me they are all tools in the toolbox, and I can pick the one that
works best in any given situation, or that I just feel like using that
day.

> >> Hm, "interactive.showUntracked" is a confusing name because "git add -i"
> >> (interactive) already handles untracked files.
> >
> > Sure, that was just meant for illustration. I agree there's probably a
> > better name.
> 
> "interactive.*" is not a sensible hierarchy to use, because things
> other than "add" can go interactive.
> 
> addPatch.showUntracked?

Hmm, I wonder if interactive.diffFilter was mis-named then. The
description is written in such a way as to cover other possible
interactive commands showing a diff.

It might be possible to do the same here: come up with a general option
that _could_ cover new situations, but right now just applies here. Or
maybe it would be too confusing.

TBH, I wasn't all that concerned with the name yet. Whoever writes the
patch can figure it out, and _then_ we can all bikeshed it. :)

-Peff
