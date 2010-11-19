From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] push to mirrior interferes with parallel operations
Date: Fri, 19 Nov 2010 16:51:43 -0500
Message-ID: <20101119215143.GA19644@sigill.intra.peff.net>
References: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
 <20101118175007.GA26505@sigill.intra.peff.net>
 <20101118184241.GN3693@efreet.light.src>
 <20101118190414.GA30438@sigill.intra.peff.net>
 <m2ipzt14rh.fsf@igel.home>
 <20101119194628.GA15466@sigill.intra.peff.net>
 <m28w0p1071.fsf@igel.home>
 <20101119212118.GA19425@sigill.intra.peff.net>
 <m24obd0zpp.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 22:52:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJYsq-00069J-0a
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 22:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab0KSVvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 16:51:50 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34948 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757248Ab0KSVvt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 16:51:49 -0500
Received: (qmail 29105 invoked by uid 111); 19 Nov 2010 21:51:46 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 19 Nov 2010 21:51:46 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Nov 2010 16:51:43 -0500
Content-Disposition: inline
In-Reply-To: <m24obd0zpp.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161793>

On Fri, Nov 19, 2010 at 10:29:22PM +0100, Andreas Schwab wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Nov 19, 2010 at 10:18:58PM +0100, Andreas Schwab wrote:
> >
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > On Fri, Nov 19, 2010 at 08:40:18PM +0100, Andreas Schwab wrote:
> >> >
> >> >> Jeff King <peff@peff.net> writes:
> >> >> 
> >> >> > it really only makes sense to push from a non-bare repo,
> >> >> 
> >> >> Why?  The repo could itself be a mirror.
> >> >
> >> > Why do you have a working directory if you are going to have a refspec
> >> > that overwrites HEAD behind your back (which, IIRC, git will simply barf
> >> > on, so all of your fetches will fail)?
> >> 
> >> I don't understand that question.  There is no working directory in a
> >> bare repo.
> >
> > Now I'm confused. I thought we were talking about non-bare repos. Can
> > you clarify your question?
> 
> You claim that pushing from a bare repo does not make sense, and I
> question that (I do that all the time).

It's hard to tell because you trimmed all of the context from my
statement, but:

  1. We are talking specifically about pushing to remotes configured
     using remote.*.mirror, and created via "git remote add --mirror".

  2. I think you are reading what I quoted as the converse of what I
     meant. You are saying "if bare, pushing does not make sense". But
     what I meant there was "if non-bare, only pushing makes sense".
     Which is why my initial response to you was so confused.

     That being said, the immediately following statement you didn't
     quote was "[only makes sense...] to fetch into a bare repo". Which
     is what you are saying, and I do think is oversimplistic. But...

  3. Much of the rest of my email goes on to explain a case where that
     simple rule is not true, and discusses the implications.

So yes. You can push from a bare repo, I agree. I think we need "git
remote add --mirror={fetch,push}" in order to handle all cases. But what
should "git remote --mirror" do? Be disallowed? Be a synonym for
--mirror=fetch (as it is now)? Guess based on bare/non-bare status?

-Peff
