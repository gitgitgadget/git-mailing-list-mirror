From: Jan Hudec <bulb@ucw.cz>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 16:13:28 +0200
Message-ID: <20061021141328.GE29843@artax.karlin.mff.cuni.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <20061017073839.3728d1e7.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 16:13:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbHbK-0005wa-8Q
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 16:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993085AbWJUONX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 10:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993086AbWJUONX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 10:13:23 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:1976 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S2993085AbWJUONW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 10:13:22 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 25978498D; Sat, 21 Oct 2006 16:13:28 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061017073839.3728d1e7.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29615>

On Tue, Oct 17, 2006 at 07:38:39AM -0400, Sean wrote:
> On Tue, 17 Oct 2006 13:19:08 +0200
> Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> 
> > 1) a working tree without any history information, pointing to some
> >    other location for the history itself (a la svn/CVS/...).
> >    (this is "light checkout")
> 
> Git can do this from a local repository, it just can't do it from
> a remote repo (at least over the git native protocol).  However,
> over gitweb you can grab and unpack a tarball from a remote repo.
> In practice this is probably enough support for such a feature.
> 
> > 2) a bound branch. It's not _very_ different from a normal branch, but
> >    mostly "commit" behaves differently:
> >    - it commits both on the local and the remote branch (equivalent to
> >      "commit" + "push", but in a transactional way).
> >    - it refuses to commit if you're out of date with the branch you're
> >      bound to.
> >    (this is "heavy checkout")
> 
> This doesn't sound right, at least in the spirit of git.  Git really
> wants to have a local commit which you may or may not push to a
> remote repo at a later time.  There is no upside to forcing it all to
> happen in one step, and a lot of downsides.  Gits focus is to support
> distributed offline development, not requiring a remote repo to be
> available at commit time.

While there is no upside to forcing it all to _always_ happen in one
step, there are good reasons to allow it in particular cases.

The most common is if you work on something from two different computers
(at home and at work or from desktop or notebook or similar cases) and
want to be sure you don't forget to synchronize your changes.

You can always unbind the branch or do a commit --local, which allows
doing a local commit anyway (eg. when disconnected) and then the next
commit will require a merge if the branches diverged.

> > In both cases, this has the side effect that you can't commit if the
> > "upstream" branch is read-only. That's not fundamental, but handy.
> 
> Again this seems really anti-git.  There is no reason for your local
> branch to be marked read only just because some upstream branch is
> so marked.

Again, it only is if you want, and opt for, making it so. Eg. people who
often have many terminals with different current directories may use it
to protect themselves from accidentaly running commands in the wrong
one. You don't have to use it if you don't want to.

> > I use it for example to have several "checkouts" of the same branch on
> > different machines. When I commit, bzr tells me "hey, boss, you're out
> > of date, why don't you update first" if I'm out of date. And if commit
> > succeeds, I'm sure it is already commited to the main branch. I'm sure
> > I won't pollute my history with merges which would only be the result
> > of forgetting to update.
> 
> This is exactly the same in Git.  You really only ever push upstream
> when your local changes fast forward the remote, (ie. you're up to date).
> Git will warn you if your changes don't fast forward the remote.

In bzr push and pull only work for the fast-forward case. They operate
on branches and actually apply the changes on the target. But that's a
different thing. Bound branches are mainly about not forgetting to
synchronize it.

> > The more fundamental thing I suppose is that it allows people to work
> > in a centralized way (checkout/commit/update/...), and Bazaar was
> > designed to allow several different workflows, including the
> > centralized one.
> 
> While Git really isn't meant to work in a centralized way there's nothing
> preventing such a work flow.  It just requires the use of some surrounding
> infrastructure.

Bzr is meant to be used in both ways, depending on user's choice.
Therefore it comes with that infrastructure and you can choose whether
you want to use it or not.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
