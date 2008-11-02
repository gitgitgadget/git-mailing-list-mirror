From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Sun, 2 Nov 2008 00:18:33 -0400
Message-ID: <20081102041832.GB5261@coredump.intra.peff.net>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net> <1225435238.20883.18.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <samv@vilain.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Nov 02 05:19:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwURK-0006jx-H2
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 05:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbYKBESg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 00:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbYKBESg
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 00:18:36 -0400
Received: from peff.net ([208.65.91.99]:4445 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbYKBESf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 00:18:35 -0400
Received: (qmail 22403 invoked by uid 111); 2 Nov 2008 04:18:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Nov 2008 00:18:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Nov 2008 00:18:33 -0400
Content-Disposition: inline
In-Reply-To: <1225435238.20883.18.camel@maia.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99807>

On Thu, Oct 30, 2008 at 11:40:38PM -0700, Sam Vilain wrote:

> > I notice the commit template message getting longer and longer. Maybe it
> > is time for status.verbosetemplate (which could default to true, I just
> > want to be able to turn it off).
> Right.  We'll have to work through that when we look at how 'git status'
> output is displayed.  There may be some people who parse the existing
> output, but they should get to read the release notes about the proper
> ways to do that.  I think the whole output could do with a shake-up.

Maybe I am wrong, but I thought at some point we decided that parsing
the output of "git status" was insane and wrong, since it's porcelain.
OTOH, it is also an easy way for editors to see what is happening in a
commit whose message you are editing (and to do, for example, syntax
highlighting on it). So it may be that it is getting parsed anyway.

> [moving content from HEAD or index to working tree]
> I still think it's OK to use 'git revert-files' for this; it just seems
> so long.  Switches could specify where to and from.

Yeah, revert-files is pretty painful to type. And I'm not looking
forward to fielding UI questions about "why isn't it just revert?" :)

Somebody suggested "clobber", which I think is a bit _too_ intense.

I guess something like "retrieve" is too ambiguous. You really need
something that implies movement of content, and something that implies
the working directory. "Checkout" is actually not a bad name; if only we
had "git switch" instead of "git checkout" for switching branches, it
would be perfect.

So I am a bit stumped. Maybe "clobber" is not so bad. ;)

> Again interesting, you could look at the stash as a whole bunch of
> staged commits yet to happen.  Of course, adding a file when the version
> in HEAD doesn't match the version in the base of the stash is a bit
> insane, so should probably be an error.
> 
> I'll have a ponder over this and whether there is a simple word for this
> all.

Whether or not we come up with a simple word, I think it makes sense to
expose this through "git stash -i" (since, after all, we are just
putting stuff into an index there).

> You're right with all that.  I don't think that it is necessarily wrong
> to have two ways to get at functionality, depending on whether you start
> with the noun or the verb first; so long as it doesn't introduce
> confusion.  And if anything, I think --switch is wrong; --checkout is
> probably more consistent.

Agreed on --checkout. I think your "noun or verb" comment hits the nail
right on the head. I wonder if there are other places where
functionality can be exposed in either direction (I think we already
have some in "git fetch <remote>" versus "git remote update").

> > There was a thread between me and Junio some months ago that touched on
> > this. I don't remember all of the arguments, but it was resolved to keep
> > the current behavior. Any proposal along these lines should at least
> > revisit and respond to those arguments.
> 
> Right.  So, before round 2, I'll read and attempt to summarise that
> thread - assuming I can find it!  :)

I think it was "Minor annoyance with git push" from this past February.
Quite a long thread, but there is some in this subthread:

http://thread.gmane.org/gmane.comp.version-control.git/73038/focus=73208

> Another command people often want is 'git info' to tell them stuff like
> they might get from 'git status' or 'git remote' but without all the
> file details...

Yeah, I don't know if you have followed the other threads in the past
month or so, but I think there is some desire for a "new" status with
a nicer format.

And I think it might be nice to structure it as a long list of things it
_can_ report on, and then let you tweak those with command-line options
and config settings. E.g., I might set info.currentbranch, info.staged,
and info.untracked because that is what _I_ like to see to get a sense
of what is happening in the repo.

And I will get around to designing that after I clear the other 100
things off my todo list. ;)

> > > +  * 'git tag -l' should show more information
> > I remember somebody talking about this, but not the details. Which
> > information?
> Oh, good point.  Basically the same stuff that 'git branch -v' shows; in
> any case, its behaviour should be relatively consistent compared to 'git
> branch'.

OK, that makes sense to me. I think of "git tag -l" as plumbing-ish,
though, so we might be breaking people's scripts (yes, I know the "real"
plumbing for this is for-each-ref, but it really is a pain to parse the
tags out of that versus "for i in `git tag -l`").

-Peff
