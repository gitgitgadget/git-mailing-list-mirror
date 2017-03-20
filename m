Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465D220958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932645AbdCTSmE (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:42:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:47934 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756078AbdCTSmB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:42:01 -0400
Received: (qmail 15733 invoked by uid 109); 20 Mar 2017 18:42:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 18:42:00 +0000
Received: (qmail 4634 invoked by uid 111); 20 Mar 2017 18:42:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 14:42:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 14:41:56 -0400
Date:   Mon, 20 Mar 2017 14:41:56 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] "git stash -- path" reports wrong unstaged changes
Message-ID: <20170320184156.sji45up2aba7z3ws@sigill.intra.peff.net>
References: <20170317145039.dmcb3qyqbzfvtmgz@sigill.intra.peff.net>
 <20170318183658.GC27158@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170318183658.GC27158@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 06:36:58PM +0000, Thomas Gummerer wrote:

> > +			if test -z "$GIT_QUIET" && ! git diff-files --quiet
> > +			then
> > +				say "$(gettext "Unstaged changes after reset:")"
> > +				git diff-files --name-status
> > +			fi
> >  		else
> >  			git reset --hard ${GIT_QUIET:+-q}
> >  		fi
> 
> This would mean the user gets something like in your case above:
> 
>     Unstaged changes after reset:
>      M	two
> 
> As a user that doesn't know the internal implementation of push_stash,
> this would make me wonder why git stash would mention a file that is
> not provided as pathspec, but not the one that was provided in the
> pathspec argument.

That's a good point. I was going for consistency with the non-pathspec
case, but of course it wouldn't mention any files in the first place,
because it's just done a complete "git reset --hard".

> I think one option would be to to just keep quiet about the exact
> changes that git stash push makes, similar to what we do in the
> --include-untracked and in the -p case.  The other option would be to
> find the files that are affected and print them, but that would
> probably be a bit too noisy especially in cases such as
> git stash push -- docs/*.

Yeah, that's the right thing. I was just trying to be too clever above.

-Peff
