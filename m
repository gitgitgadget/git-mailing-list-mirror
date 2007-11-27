From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 12:23:29 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711271155250.9605@xanadu.home>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
 <Pine.LNX.4.64.0711271109130.27959@racer.site>
 <alpine.LFD.0.99999.0711270917580.9605@xanadu.home>
 <20071127150829.GB3853@fieldses.org>
 <alpine.LFD.0.99999.0711271013310.9605@xanadu.home>
 <20071127153411.GA11731@fieldses.org>
 <alpine.LFD.0.99999.0711271047590.9605@xanadu.home>
 <20071127164243.GE11731@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-2022-JP?Q?=1B$B$i$$$7$J$J$3=1B=28J?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:23:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix4A4-0001hF-DT
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 18:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266AbXK0RXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 12:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757515AbXK0RXc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 12:23:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62881 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756932AbXK0RXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 12:23:31 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS600BQ7DN5X050@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Nov 2007 12:23:31 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071127164243.GE11731@fieldses.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66245>

On Tue, 27 Nov 2007, J. Bruce Fields wrote:

> On Tue, Nov 27, 2007 at 11:14:47AM -0500, Nicolas Pitre wrote:
> > On Tue, 27 Nov 2007, J. Bruce Fields wrote:
> > > No, their work isn't always based on origin/master@{1}.  Often they've
> > > got more than one project going.  If they try
> > > 
> > > 	git checkout project-1
> > > 	git pull -s rebase
> > > 	git checkout project-2
> > > 	git pull -s rebase
> > > 
> > > what's going to happen?  What if project-2 has been on the back burner
> > > for a few months and they're just getting around to rebasing it now?
> > 
> > I don't see the problem.  They'll just have a possibly harder rebase due 
> > to increased chances for conflicts than if they rebased more often, but 
> > that's to be expected even with a merge.
> 
> Well, fair enough.  It can be much worse than a merge, though--consider
> what happens when upstream drops a commit, or replaces a patch by
> another patch (or patches) that solves the problem in a different way.

That's the whole point for the need to rebase.  To others I'm currently 
upstream and I do the above all the time. So I don't see the issue.

> > > What if their various projects are based on different upstream branches,
> > > but the fetch done by git-pull updates them all at once?
> > >  What if they
> > > did a git fetch earlier just to peek at current development and are only
> > > now getting around to updating their own branches?
> > 
> > You are not _forced_ to use origin/master@{1} in that case -- I used 
> > that notation only to illustrate the concept in Git terms.  What I tell 
> > people to do is to tag their new base after the rebase is done, and to 
> > use that tag after the next fetch to rebase again.
> 
> That's fine, but it's not an automated process any more.

Indeed.  I never claimed it was automated, but I'm rather deploring it.

> > I honnestly don't use such a tag myself because I think I know what I'm 
> > doing when using Git, and therefore I know when origin/master@{1} refers 
> > to what I really want.  But the point is that either that usage of 
> > origin/master@{1}, or a dedicated tag, or whatever other means to 
> > retrieve the previous base, could be handled implicitly by the porcelain 
> > and the user wouldn't have to care as much.
> 
> OK, so you're imagining a version of "git pull -s rebase" that also
> allows specifying the previous base of your series?  What would the
> syntax be?  You could do something like stg does and keep extra
> information under .git that records the base of each "patch series".
> Then you have to figure out how to manage that information and how it
> should interact with the varoius branch management commands.

... which is IMHO the best reason to find a solution that doesn't need 
extra information to be kept.

> > Thinking about it, there should be a way to find the proper base even 
> > without explicitly recording it with a tag.  If it isn't 
> > origin/master@{1}, it has to be the first of origin/master@{n} for
> > n = [1, ...] reachable from the local work branch before rebasing.
> 
> That'll work in some cases.  You're almost using the reflog as another
> piece of history to find the "real" merge-base.

Sure.  Since it is there, why not use it?

> That's a little fragile, since reflogs aren't quite "real" history.  It
> doesn't work reliably in the "project that was put on the back burner"
> case (because the reflog entries may have expired).

Tough.

Maybe reflogs should always preserve a minimum of x entries by default 
even if they are older than the expiration threshold.

But practically speaking, if you've been sitting on your work for so 
long and you've pruned your reflog then you should always be able to 
look up your branch history and find the first commit which isn't yours, 
then use its ID explicitly. And if you forgot enough about that work of 
yours so not to be able to determine that base commit then I probably 
don't want to trust you anyway.  :-)

> It doesn't work if
> work is done in multiple repositories.

Hmmm... would have to think a bit more about that, but it never was a 
real issue to me so far.

> > > And I don't think any of those are crazy corner cases; I know at least
> > > that I do all of those things.
> > 
> > Sure.  In which case you certainly fall into the "know what you're 
> > doing" category too and certainly can find your way towards the proper 
> > base ref to use.
> 
> Beginners are will try those things too, so we'd have to explain the
> limitations up front.

Sure.  Yet a bunch of Git beginners are doing just well so far with the 
rather terse instructions I provided for manually rebasing their work 
when using my repo.  So that must not be that bad.

> > But again I think that can be automated.
> 
> I'd want to see the algorithm spelled out, and a very convincing
> description of exactly which cases it handles.
> 
> My other objection is that "rebase" just isn't a merge strategy.  I
> think of a merge strategy takes some HEADs in a produces a single merge
> commit that connects them.
> 
> If we really want a fetch+rebase script, OK, but call it something other
> than pull.

I absolutely agree. Anyway, the Git "pull" is my own most hated command. 
I always considered it has strange semantics hiding too much of what is 
actually going on, using an artificial concept probably borrowed from BK 
to justify its existence.  In all the tutorials for $job I've done so 
far, I simply never talk about pull nor clone, but rather about init, 
"git remote", fetch and merge, with explicit and meaningful branch 
names.  I think that basic commands, even if there is a bit more of 
them, make Git easier to learn and understand than talking about those 
magic meta commands hiding the truth away. But hey, this is only my own 
opinion, and after all I'm the one having to deal with those $job people 
in the end.


Nicolas
