From: Petr Baudis <pasky@suse.cz>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Fri, 23 Sep 2005 11:10:12 +0200
Message-ID: <20050923091012.GA10255@pasky.or.cz>
References: <E1EIVsD-0001Hu-9m@jdl.com> <20050922191058.GM21019@pasky.or.cz> <34462.10.10.10.28.1127417134.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 11:12:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIjZS-0001AP-B1
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 11:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVIWJKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 05:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVIWJKP
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 05:10:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:686 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750835AbVIWJKO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 05:10:14 -0400
Received: (qmail 24431 invoked by uid 2001); 23 Sep 2005 11:10:12 +0200
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <34462.10.10.10.28.1127417134.squirrel@linux1>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9168>

Dear diary, on Thu, Sep 22, 2005 at 09:25:34PM CEST, I got a letter
where Sean <seanlkml@sympatico.ca> told me that...
> On Thu, September 22, 2005 3:10 pm, Petr Baudis said:
> 
> > FWIW, with Cogito, interrupted or failed fetch can be safely rerun, no
> > extra recovery procedure is required. It *seems* that this holds for
> > git-fetch as well.
> 
> Petr,
> 
> Why doesn't cogito just use the git fetch/pull commands?   Why does it
> need anything special?   It seems like cogito is doing more than just
> being an ease-of-use layer above git.

As Junio already explained, Cogito had those commands earlier - so the
main reason was simply that I didn't manage to do it yet. It is not so
easy to keep up with the latest GIT stuff _and_ enhance Cogito at the
same time, so I simply didn't get to really consider that yet. :-)

That said, this is a non-comprehensive list of the factors in my
consideration:

Pros (not so much of them, but they are big):
	* Already supports alternates and remotes
	* Do it once, stop caring :-) - only single instance of the code
	  does the stuff (this is obviously the motivation)

Cons:
	* cg-fetch can do with symlinked object database
	* cg-fetch will hardlink if possible when fetching locally
	* cg-fetch will fetch the tags if possible
		(this is actually a bit controversial - we should have
		the private/public tags distinction, that's another
		thing I simply didn't get to yet)
	* cg-fetch has cute progress info
		(perhaps git-fetch output could be just fed to that)
	* cg-fetch won't do useless fetches when we are already
	  up-to-date
	* I'm not sure if I could call git-fetch to do the initial
	  fetch during clone
	* The amount of work to initially convert it might be comparable
	  with implementing the current new stuff
	* I really dislike the git-fetch coding style
		This is not that I'd like to force my coding style
		customs on anyone and Junio might well feel the same
		about Cogito's code, but I would have to support and
		fix bugs in git-fetch if I used it.
	* I'm obviously not too happy to throw away the rather big
	  amount of code I spent a lot of time on and which is already
	  pretty well debugged and tuned, I think (that's not to say
	  that git-fetch is buggy... ;-)

The cons may seem mostly minor stuff which is quite fixable, and that's
right, it's just show that there is plenty of stuff to do before
git-fetch will be superset of cg-fetch. Now because of the coding style,
I might as well just implement the alternates and remotes stuff to
cg-fetch, which would be less work and less painful for me in the short
term.

I'll convert cg-object-id to use git-rev-parse after the release so that
you can't say I'm an old-fashioned freak refusing to use any of the new
GIT stuff. :^)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
