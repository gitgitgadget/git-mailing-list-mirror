From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a manual page for git-stash
Date: Sat, 30 Jun 2007 18:56:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706301853400.4438@racer.site>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site>
 <200706300539.l5U5dHLh003989@mi1.bluebottle.com> <Pine.LNX.4.64.0706301644190.4438@racer.site>
 <7vps3dcp76.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 19:56:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4hB6-0002sr-Ie
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 19:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbXF3R4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 13:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbXF3R4J
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 13:56:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:38661 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752297AbXF3R4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 13:56:07 -0400
Received: (qmail invoked by alias); 30 Jun 2007 17:56:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 30 Jun 2007 19:56:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SE7tfWGaSq3tORR4t4AJCTrRb4xO8zSd+9TwIHe
	ba3CeYiTJmGE1f
X-X-Sender: gene099@racer.site
In-Reply-To: <7vps3dcp76.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51235>

Hi,

On Sat, 30 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +DESCRIPTION
> > +-----------
> > +Use 'git stash' when you want to record the current state of the
> > +working directory and the index, but want to go back to a clean
> > +working directory.
> > +
> > +For example, if you have to pull, but are in the middle of some
> > +interesting work, not yet ready to be committed, use git-stash.
> > +
> > +The default operation (when called without options), is to save
> > +the changes away.
> > +
> > +
> > +OPTIONS
> > +-------
> > +clear::
> > +	Undo _all_ stashes (dangerous!).
> > +
> > +list [<stashname>]::
> > +	List all stashed states.
> > +
> 
> I suspect that is not what the implementation intends to do.
> "list -n 4", "list --since=1.hour" would make sense, but "list
> stash@{12}" would probably not.

Okay, I misunderstood the _intention_ of the code, then.

> > +show [<stashname>]::
> > +	Show a combined diff of the stashed working directory, index and
> > +	HEAD.
> 
> Is that what it does?  I had an impression that "show stash@{2}"
> shows a regular diff between the base and the stashed working
> tree state.

Ah, you're completely right! Somehow my tired eyes read what I expected to 
find there.

> > +apply [<stashname>]::
> > +	Try to apply the stashed changes to the current HEAD. You need
> > +	a clean working directory for that, i.e. you must not have changes
> > +	relative to HEAD in your working directory or index.
> 
> The implementation appears to apply on a clean index without
> restriction to where the HEAD is.  I hinted that that behaviour
> is fine in my previous message, but on the other hand haven't
> convinced myself enough to say that it would not confuse end
> users.  Maybe insisting on not just clean index but no changes
> from the HEAD would reduce confusion?  I dunno.

I am sure confused why the index state is stashed away when it is not 
used...

> > +<stashname>::
> > +	A name of a stashed state. Typically something like 'stash@{2}'
> > +	or 'stash@{2.days.ago}'.
> 
> Probably this should be defined in DESCRIPTION, along with the
> definition of what a stash is ("records the difference between
> the HEAD when the stash was created and the working tree state
> in such a way that it can be applied to a different state
> later").

Okay.

> > +DISCUSSION
> > +----------
> > +
> > +The state is saved as three commits:
> > +
> > +- HEAD,
> > +- a commit which contains the state of the index, which has HEAD as a
> > +  parent, and
> > +- a commit which contains the state of the working directory (only the
> > +  tracked files, though), which has both HEAD and the second commit
> > +  as parents.
> > +
> > +The third commit holds the complete information of the stash, and is
> > +stored as the ref 'refs/stash'.
> > +
> > +Since that commit does not have any reference to other stashed states,
> > +the stash listing relies on the reflog of 'refs/stash'. Therefore,
> > +the stashed states are garbage collected like all the other reflogs.
> 
> Nit; s/the other reflogs/the other reflog entries/

Okay.

> > +Author
> > +------
> > +Written by Johannes E. Schindelin <johannes.schindelin@gmx.de>
> 
> You wrote that ;-)?

No. ;-)

Hey, be nice. It's a new role for me, usually others document what _I_ 
wrote, not vice versa :-)

Ciao,
Dscho
