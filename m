Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D82320FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 06:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbcGAGmu (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 02:42:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:38777 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752593AbcGAGm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 02:42:28 -0400
Received: (qmail 25722 invoked by uid 102); 1 Jul 2016 06:42:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:42:29 -0400
Received: (qmail 13939 invoked by uid 107); 1 Jul 2016 06:42:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:42:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 02:42:24 -0400
Date:	Fri, 1 Jul 2016 02:42:24 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFD] Place to document magic pathspecs like ":/" and pathspec
 handling
Message-ID: <20160701064224.GD5358@sigill.intra.peff.net>
References: <577425EF.6030900@gmail.com>
 <CAPc5daVqjhWrJjNX6monHdMTRwimbjz==j9B2FS-nXNCqPDCYQ@mail.gmail.com>
 <57743BFB.9040709@gmail.com>
 <xmqqy45n1y8a.fsf@gitster.mtv.corp.google.com>
 <5774E992.7070905@gmail.com>
 <CACsJy8AES0iu341DU6FDYZq6fmssbD3QSZaiwi9BntTnMQS5Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AES0iu341DU6FDYZq6fmssbD3QSZaiwi9BntTnMQS5Gw@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 05:14:15PM +0200, Duy Nguyen wrote:

> > So we could describe how Git handles pathspecs and pathspec magic
> > in the new manual page named gitpathspec(7), or gitpaths(7). The
> > former has the advantage of the name being identical to the entry
> > in gitglossary(7). The latter has the probable advantage of being
> > easier for the Git novice to find,
> 
> git-pathspec(7) is a great idea. It bugs me that all the pathspec
> details are hidden in that glossary file (though I didn't know it was
> also available via "git help glossary", which probably just reinforces
> its invisibility). The closet place I could think of was git(1) but
> that page is already very long.
> 
> > and that it could be used to
> > gather various ways to generate list of files in Git (files in
> > the working area, files in the staging area aka the index, files
> > in the revision / tree object, changed files, etc.);
> 
> You mean the list of commands in this man page? OK. Another thing we
> could do is the reverse direction, add gitpathspec(7) as a reference
> to all commands that may need it.

I'll second (third?) this. Some of our manpages are quite unwieldy, and
I don't think we are doing any favors to users when we auto-include the
same content in multiple places. I think we should instead be splitting
concepts into their own pages and referring to them. That helps users
build the mental model ("aha, pathspecs; I read that concept page and
know how those work!" instead of "here's 3 pages of description on how
git-diff handles paths. Is it identical to the 3 pages in git-log?").

I suspect some things like diff options could benefit from a similar
split.

> >  Sidenote: I wonder if people (especially novices) have problem
> >  finding relevant documentation, and if adding something like
> >  "git apropos <topic>" command ("apropos", or "man -k"), or
> >  add the '--apropos' option to "git help" would be useful...
> >  and if it would be easy to create.
> 
> I have that problem sometimes and I don't think I can call myself a
> noob anymore. I usually need to do some grepping. So yeah "git
> apropos" would be great.

I think better searching would help a lot if we split things into more
pages (right now, a legitimate technique is "man git-foo", using search
in the pager, and wading through all of the false positives. That sucks,
but at least you can find what you want _eventually_).

I'm not sure if "man -k" is all that great, though, for two reasons:

  1. AFAIK there isn't an easy way to restrict it only to git manpages
     (try "man -k git"; oh, hello "isxdigit(3posix)").

  2. It only searches the title lines. So it's great for finding the
     pathspec page, but you could probably already do that by guessing
     it's called "git help pathspecs". But if you're looking for
     discussion of a particular diff option, say, it would be nice to be
     able to search for all mentions of "--word-diff-regex", or
     something.

     There is "man -K", but it kind of sucks (it seems to just dump you
     in any manpage that matches, in a list).

I don't think those are problems that _git_ should necessarily be
solving, though. It's a general problem for manpages. And there may be
better "man" implementations than I'm used to (or even options or
configuration I don't know about).

-Peff
