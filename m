From: Jeff King <peff@peff.net>
Subject: Re: Git documentation consistency (was: "git merge" merges too
 much!)
Date: Wed, 2 Dec 2009 21:07:11 -0500
Message-ID: <20091203020711.GB12061@coredump.intra.peff.net>
References: <m1NEaLp-000kn1C@most.weird.com>
 <20091129051427.GA6104@coredump.intra.peff.net>
 <m1NFAji-000kn2C@most.weird.com>
 <20091202200904.GA7631@coredump.intra.peff.net>
 <m1NG0O6-000kmgC@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 03 03:07:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG16G-00029L-H5
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 03:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbZLCCHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 21:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752929AbZLCCHH
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 21:07:07 -0500
Received: from peff.net ([208.65.91.99]:50999 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbZLCCHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 21:07:06 -0500
Received: (qmail 29092 invoked by uid 107); 3 Dec 2009 02:11:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Dec 2009 21:11:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2009 21:07:11 -0500
Content-Disposition: inline
In-Reply-To: <m1NG0O6-000kmgC@most.weird.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134426>

On Wed, Dec 02, 2009 at 08:21:39PM -0500, Greg A. Woods wrote:

> > I find git is much simpler to use and understand if you start "at the
> > bottom" with the basic concepts (because for the most part, git is
> > really a set of tools for manipulating the few basic data structures).
> 
> I think that's the problem actually -- I don't really want to know too
> much about how it works under the hood (yet), I just want to use it in
> the most effective way for my purposes.
>
> There's lots of talk about using Git as the basis for a true high-level
> VCS and SCM system, yet it doesn't look to me that anyone has created
> such a VCS or SCMS using Git.

Sure, I can understand that. And I invite you (or anyone) to work on
such a VCS, and I am sure I am not alone on the list in sincerely hoping
you succeed and offering to help support however core git developers
can. But we have seen people try this in the past, and it never quite
seems to work.

All of the cogito people ended up migrating to git. I was one of them.
In my case, the git tools offered better access to the fundamental
operations, which is what I found interesting and powerful about it. I
suspect some others migrated for the same reasons, though perhaps many
did simply because cogito did not keep up with core git in terms of
features.

There is also "eg" these days, which attempts to do what you're saying.
I don't know how big a userbase it has; I've never been personally
interested in it.

> I think anyone who's been participating on this list for any significant
> amount of time is far too close to the subject to be able to serve as a
> candid independent technical editor who could really help clean things
> up and make the documentation much more consistent.  Obviously such an
> editor would also require the help of experts at all the details too. :-)

Sure, I think an outsider doing a really nice job of overhauling the
documentation would be nice. There are some git books, some by insiders,
and some not. For the same reason that you mention, it would hard for me
to assess their quality with too much objectivity. :)

My question was more of a "leaving aside overhauling the documentation,
did you see something obvious that we can fix right now" kind of thing.

> > $ ls -?
> > ls: invalid option -- '?'
> > Try `ls --help' for more information.
> 
> Please keep in mind all the world is not GNU:
> 
> 	$ ls -?
> 	ls: unknown option -- ?
> 	usage: ls [-AaBbCcdFfghikLlmnopqRrSsTtuWwx1] [file ...]

Right, but my point is unchanged. Neither ls actually _recognizes_
"-?". They do the same for "--bogosity".

> My point was that _most_ other Git sub-commands already do respond to
> "-?" sensibly with real, helpful, information; usually a summary of the
> command options and parameters.

Yes, for the same reason that "ls" does: they don't recognize it. But if
you are asking for "git log" to produce the short usage message, then
that is part of my issue (1) from the last message: "log" doesn't use
the same parseopt library as (most of) the rest of git[1].

Yes, it's inconsistent. Those inconsistencies were introduced over time
(before we had parseopt), and we are slowly fixing them over time.
Patches welcome. :)

[1] There are other inconsistencies because of this, too. You can't say
"git log -pz", but must say "git log -p -z".

> > $ git log -h
> > usage: git log [<options>] [<since>..<until>] [[--] <path>...]
> >    or: git show [options] <object>...
> 
> Indeed, so why the heck can't it do something similar with '-?'.  That's
> just sloppy programming, no?  Most other commands know '-?', and despite
> the silliness with GNU Ls, use of '-?' to request summary usage
> information is pretty much a de facto standard for unix commands.

Nothing "knows" -?, but it is true that the parseopt-ified commands
behave differently (and IMHO, better). You can call it sloppy, I guess;
it is really an artifact of commands being written and changing over
time. As I said, we are slowly converging on consistency.

And no, I don't want to get into a big debate over whether it is better
to plan your software up front, or to let it evolve over time. I have
opinions that do not necessarily line up with how git came into being,
but the end product is useful enough that I like to use it and hack on
it. :)

> (the whole "fatal: not a git repository" error for "git foo -[h?]"
> handling is also a rather silly one -- but I guess when something grows
> quickly and from many inputs there's not always time to keep some of
> these basic things clean and consistent)

The problem here is that there are two chunks of code: the "git"
wrapper, and the "log" command. The wrapper knows a few things about
each command like "does it need to be in a git repository?", and checks
that before we even look at the command-line options. There is an
explicit "check for --help" hack. Fixing that startup procedure to be
more sane would be possible, but there are a lot of hidden demons
lurking in changing the order of the startup sequence. Again, patches
welcome. :)

-Peff
