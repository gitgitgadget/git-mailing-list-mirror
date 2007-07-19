From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Thu, 19 Jul 2007 14:40:53 +0200
Message-ID: <20070719124053.GC999MdfPADPa@greensroom.kotnet.org>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707141140510.14781@racer.site>
 <20070715144435.GH999MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707160054340.14781@racer.site>
 <20070716200404.GT999MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707181205260.14781@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 19 14:41:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBVJa-0008Qg-Qo
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 14:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756486AbXGSMk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 08:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756554AbXGSMk4
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 08:40:56 -0400
Received: from smtp18.wxs.nl ([195.121.247.9]:34553 "EHLO smtp18.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755721AbXGSMkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 08:40:55 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp18.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JLF00GCYF857U@smtp18.wxs.nl> for git@vger.kernel.org; Thu,
 19 Jul 2007 14:40:54 +0200 (CEST)
Received: (qmail 22531 invoked by uid 500); Thu, 19 Jul 2007 12:40:53 +0000
In-reply-to: <Pine.LNX.4.64.0707181205260.14781@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52985>

On Wed, Jul 18, 2007 at 12:17:03PM +0100, Johannes Schindelin wrote:
> Okay.  For me it does not at all exclude that.  If I want to replace a 
> commit by no commit, I write a commit-filter which does not return 
> anything.  If I return more than one SHA1s, I damned well want all of 
> those be the replacement "commit".

So how about you telling me what it _means_ for one commit to
be replaced by more than one commit or at least giving me an
example?

> > - if the parents of a commit have been rewritten to one or more
> >   commits, then they are replaced by the new commits.
> 
> Yes, that is the primary use for the mapping.
> 
> >   If any parent has been pruned, then it is replaced by
> >   the result of applying this operation on _its_ parents.
> 
> Why?  This is overy complicated.  If a commit has been pruned, why does 
> the mapping not point to the _non-pruned_ parent?

It may not have any non-pruned parents and for the pruned ones, we
wouldn't want to lose the relation with the non-pruned ancestors.

> IOW if you have 
> something like this:
> 
> 	A - B - C - D - E - F
> 
> and all commits except A and F are pruned, the mapping for A, B, C, D and 
> E should _all_ point to the (possibly rewritten) A.

I'm not sure what you mean by "mapping" here, but the operation
described above would make all of B, C, D, E and F have (the
possibly rewritten) A as single parent (and parenthood was all
I was talking about above).

> > - a SHA1 of a commit that appears in a commit message is replaced
> >   by the rewritten commit iff it was rewritten to a single commit.
> >   That is, if the commit was pruned or rewritten (through a commit
> >   filter to more than one commit), then the SHA1 is left alone.
> 
> Both this behaviour and the one you described in your reply are wrong.

So tell me what you would do then and why that would make sense.

> > - the mapping available to filters
> >     * if the commit was pruned, an empty file is created
> >     * otherwise a file is created containing all rewritten SHA1s
> 
> As I stated above: it is utterly wrong to create an empty mapping for a 
> commit that was pruned.  It does not take long to think of an example:
> 
> 	A - B - C - D
> 
> Now, A and D get pruned.  Do you want the whole branch to vanish?  _Hell, 
> no_.

Define "vanish" and, again, tell me what you would do.

> You have to at least give the users a chance to grasp what they are doing.  
> And if that means to change the semantics to something saner, then so be 
> it.

Let's get things straight.  I've added the map files and the possibility
for a commit filter to return more than one commit because you asked me to.
I've tried to make sense of it, but if you think the behavior I defined
is not what it is supposed to be, then it is up to _you_ to tell me what
you think it should be instead of letting me guess.

I think I'll just remove the possibility for the commit filter to
return more than one SHA1 (or maybe even no SHA1s).
filter-branch doesn't seem to allow either of those either.

skimo
