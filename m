From: Theodore Tso <tytso@mit.edu>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Tue, 30 Jan 2007 20:55:55 -0500
Message-ID: <20070131015555.GA1944@thunk.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <20070130165548.GF25950@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Coleman <tutufan@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 02:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC4i4-00037c-Pg
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 02:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbXAaB4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 20:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbXAaB4I
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 20:56:08 -0500
Received: from thunk.org ([69.25.196.29]:50607 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932113AbXAaB4H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 20:56:07 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HC4mW-0003nA-Hn; Tue, 30 Jan 2007 21:01:04 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HC4hX-0004Xu-Az; Tue, 30 Jan 2007 20:55:55 -0500
Content-Disposition: inline
In-Reply-To: <20070130165548.GF25950@spearce.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38222>

On Tue, Jan 30, 2007 at 11:55:48AM -0500, Shawn O. Pearce wrote:
> I think hg modifies files as it goes, which could cause some issues
> when a writer is aborted.  I'm sure they have thought about the
> problem and tried to make it safe, but there isn't anything safer
> than just leaving the damn thing alone.  :)

To be fair hg modifies files using O_APPEND only.  That isn't quite as
safe as "only creating new files", but it is relatively safe.

One other interesting point which came as a surprise to me is the size
of the repositories.  It used to be that git was much more inefficient
at storing files that Mercurial.  However, what pack files, and
deltas, I'm pleased to say a mercurial repository with all of
e2fsprogs' history is 20 megs, while a git repository with the same
history is 11 megs.   

(BTW, I've been doing some hacking of Stelian Pop's hg2git.py in my
spare time.  Most of the changes are e2fsprogs specific, but if anyone
else is hacking on it, I'd love to compare notes.  I have some vague
thoughts about making hg2git to be bidirectional, but I probably won't
have time to implement it.)

> Yes.  By a huge margin.  Git's *fast*.  Ignore anything from a year
> or two ago.

I'd go even further.  You probably want to use the latest git 1.5.0 rc
release, or final, since it has been a lot uf usability and
documentation improvements over previous git releases.

> > 4.  What is git's index good for?  I find that I like the idea of it,
> > but I'm not sure I could justify it's presence to someone else, as
> > opposed to having it hidden in the way that hg's dircache (?) is.  Can
> > anyone think of a good scenario where it's a pretty obvious benefit?

In git 1.5.0 it's a lot easier for users to not have to worry about
the index if they don't want to.  It's not quite so much in the user's
face, although there is still improvement to be had, especially in the
git documentation.  There is a git user's manual being prepared (that
I think will be in 1.5.0, hopefully) that is much better than "man git".

> This really helps during a merge.  Only the stuff which Git could
> not merge for you is seen as different between the index and the
> working directory; all of the stuff that Git merged for you is
> already staged in the index.  So you can focus on the conflicts,
> and stage their resolutions into the index as you go.  This makes
> it easier to work through larger merges where more than 1 or 2
> files contains conflicts.

The flip side of this is that mercurial as much better integration
with graphical merge tools, which git doesn't have by default (yet).

> > 8.  It feels like hg is not really comfortable with parallel
> > development over time on different heads within a single repo.
> > Rather, it seems that multiple repos are supposed to be used for this.
> > Does this lead to any problems?  For example, is it harder or
> > different to merge two heads if they're in different repo than if
> > they're in the same repo?

hg has only recently added support for development on different heads
within the same repo.  So it's just more immature there.  Presumably
over time it will get better.  Most poeple who use use hg don't use a
lot of different branches, for things like topic branches, for
example.  If you prefer to use that style of interaction, git is going
to be a much better choice for you.

Regards,

							- Ted
