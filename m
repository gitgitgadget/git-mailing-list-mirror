From: esr@thyrsus.com (Eric S. Raymond)
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 15:52:52 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20070714195252.GB11010@thyrsus.com>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk> <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com> <4699034A.9090603@alum.mit.edu>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, dev <dev@cvs2svn.tigris.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Jul 14 21:53:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9ngQ-0001H2-8j
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 21:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764532AbXGNTxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 15:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763170AbXGNTxK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 15:53:10 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:45238
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764765AbXGNTxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 15:53:09 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 840F33C0663; Sat, 14 Jul 2007 15:52:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4699034A.9090603@alum.mit.edu>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52501>

Michael Haggerty <mhagger@alum.mit.edu>:
> Martin Langhoff wrote:
> > On 7/14/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> >> Incidentally, now that cvs2svn 2.0.0 is nearly out, I am thinking about
> >> what it would take to write some other back ends for cvs2svn--turning
> >> it, essentially, into cvs2xxx.  Most of the work that cvs2svn does is
> >> inferring the most plausible history of the repository from CVS's
> >> sketchy, incomplete, idiomatic, and often corrupt data.  This work
> >> should also be useful for a cvs2git or cvs2hg or cvs2baz or ...
> > 
> > Great to hear that. I'm game if we can do something in this direction
> > - surely we can make it talk to fastimport ;-)
> 
> We added some hooks to cvs2svn 2.0 to start working in this direction.

Excuse me, I missed Michael's Haggerty's original post. But as it
happens I've been doing quite a lot of work with VCSes and migration
tools recently and I have some opinions and experience that I think are
relevant.

In slightly more detail: I just finished forward-porting sccs2rcs to
Python, I've been moving some Subversion-hosted stuff to Mercurial,
and I've been thinking about writing a simple rcs2svn because the last
time I tried using cvs2svn on a large RCS history (the Jargon File, as
it happens, a couple years back) it did a very poor job of coalescing
related commits without the CVS metadata.  I'm going to hope 2.0.0 has
fixed that; I'll experiment and see.

Also, I'm in the process of rewriting Emacs VC mode and testing it
with three different VCSes. One consequence is that the Subversion
support in Emacs is going to cease sucking badly in the very near
future -- the VC-mode rewrite is giving VC mode the ability to make
atomic fileset commits if the underlying VCS will support them.  I'm
putting the finishing touches on that code today, as it happens.

Another consequence is that Mercurial and git support will get really
good, oh, about ten minutes after the new Subversion backend lands.
The blocker on all three was the same weakness in the engine of VC
mode, for whicch I was (alas) responsible as its original author and
*which I have now fixed*.

So, I hear about plans to make cvs2svn generate something other than
Subversion, and here's my instant reaction:

	    	       	   DON'T DO IT!

This is not because I think Subversion is some kind of final answer to the
VCS problem.  Fame from it -- I'm moving towards Mercurial.  No, the
real reason I think this would be a waste of time is subtler than that.

Subversion, by design, is very good at capturing the metadata from
SCCS and RCS and the various CVS variants floating around.  In fact,
lifting from those into Subversion is basically lossless - the real
problems are that (a) as Michael notes, the data you're losslessly
lifting is scratchy, and (b) as I've noted, you have to use heuristics
to coalesce file histories into changesets and those don't always make
the links they should.

That being the case, two-step conversion with tools that import CVS to
SVN and export from SVN to whatever actually works extremely well.
I'm speaking from direct recent experience here, not just theory. In
fact, it works so well well that I'm convinced a tool for direct
conversion from CVS to the third-generation systems would be misplaced
effort.  

I'd much rather see the effort go into improving import to Subversion
from CVS and older, cruftier systems.  Subversion is like the Heinlein quote
about low Earth orbit being halfway to anywhere -- once your code and 
metadata are there, export to advanced alien VCSes is easy.  So, Michael;
I know it's nice to think about building space probes that can go direct 
to the aliens -- but please concentrate on building a better heavy-lift 
vehicle, because low earth orbit is the hard part.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
