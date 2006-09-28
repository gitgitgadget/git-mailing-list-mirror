From: Theodore Tso <tytso@mit.edu>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 09:17:10 -0400
Message-ID: <20060928131710.GE7469@thunk.org>
References: <7vzmck7pis.fsf@assigned-by-dhcp.cox.net> <20060928014811.19568.qmail@web51005.mail.yahoo.com> <20060927220404.8e216945.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthew L Foster <mfoster167@yahoo.com>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 15:18:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSvlX-0005VW-0T
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 15:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWI1NRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 09:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWI1NRR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 09:17:17 -0400
Received: from thunk.org ([69.25.196.29]:63212 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751870AbWI1NRQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 09:17:16 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1GSvne-0006Ho-Pk; Thu, 28 Sep 2006 09:19:39 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.60)
	(envelope-from <tytso@thunk.org>)
	id 1GSvlG-00012X-4o; Thu, 28 Sep 2006 09:17:10 -0400
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20060927220404.8e216945.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28001>

On Wed, Sep 27, 2006 at 10:04:04PM -0400, Sean wrote:

> > I actually understand that and agree. All I've been saying is it
> > (git or gitweb.cgi) should prefer the local timestamp rather than
> > any "remote" timestamps for no other reason than to minimize the
> > possibility of timestamps being grossly inaccurate.
> 
> But any local time stamp would be a _lie_.  The time stamp in the
> commit records when it was actually created.  And as Junio has
> pointed out, hundreds of commits will typically arrive in a repo at
> the exact same time.  Your suggestion would have them all showing
> the exact same time.  That's not helpful, and it loses important
> factual information.

There are two issues here.  Could a git tree record the local time
that each commit entered the repository?  Sure.  Someone who wanted to
hack up git so that it created a local db file associating the SHA
hash name of the commit with when it arrived in its local repository.
It would not be part of the "true" git repository information, and it
could be something which is optional in the sense that if the
information is lost, it's not the end of the world, vis-a-vis correct
git functioning.

The second question, though, is would it be *useful*?  Presumably this
would be an option, so the user could request to see the time when a
commit hit a particular repository, as well as when the commit was
first created --- or perhaps both.

The problem though is that this could easily get confusing, since it
adds a distinction (which repository am I talking to?) which normally
doesn't exist in git.  And it forces us to make explicit things that
normally are kept hidden --- such as whether or not Linus does his
work directly on the git tree which is exposed by master.kernel.org,
or whether he does the work on his own local tree, and then pushes the
changes to master.kernel.org.  

In git, we believe that all repositories are equal, and that any sense
that a particular repository is the "master" or the "mainline" is
strictly speaking, a matter of convention.  What Matthew I think is
asking for is direct support in git for that notion.

So it *could* be done, but whether or not it is a good idea or worth
the complexity is a different question.  One could imagine a
completely different protocol, which exported the contents of the
hypothetical db database described above.  So for maintainers that
were *important*, and who were willing to make this information
available, given a particular SHA hash of a commit, one could ask the
question, "when did this commit first eneter your repository"?

Matthew seems hung up on on desperately wanting to know this
information as it relates to a particular repository --- Linus's.
This is in fact different from when the commit hit the repository
which is master.kernel.org which is why the local commit times on
master.kernel.org wouldn't be useful.  

HOWEVER, if it was judged important enough, and worth the complexity
that it would add to git, the ability to track when a commit entered a
particular repository and the ability to export it via some kind of
web interface certainly be implemented.  Linus would then have to
decide whether this was information he felt like making available to
inquisitive seekers wanting to know this sort of info.

						- Ted
