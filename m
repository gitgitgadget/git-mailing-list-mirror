From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 09:55:51 +0200
Message-ID: <20091017075551.GA5474@atjola.homenet>
References: <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Oct 17 09:56:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mz491-0008QL-Pg
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 09:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbZJQHz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 03:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbZJQHzz
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 03:55:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:40138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752109AbZJQHzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 03:55:54 -0400
Received: (qmail invoked by alias); 17 Oct 2009 07:55:56 -0000
Received: from i59F5487B.versanet.de (EHLO atjola.homenet) [89.245.72.123]
  by mail.gmx.net (mp025) with SMTP; 17 Oct 2009 09:55:56 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+pq7gZ2zKpI5RpSBI6g6y3v9iyjVUGmqvnXCcziM
	tFhTdJte7fnisv
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130549>

On 2009.10.16 18:31:23 +0100, Julian Phillips wrote:
> On Fri, 16 Oct 2009, Bj?rn Steinbrink wrote:
> >On 2009.10.16 13:15:35 +0100, Julian Phillips wrote:
> >>How about:
> >>
> >>$ git checkout origin/master
> >>$ git fetch
> >>Refusing to fetch, as it would update a checkedout branch
> >>"git fetch -f" will force the update, but you will need to run "git
> >>reset --hard HEAD" to update your checkout to match.
> >
> >That would redefine -f (currently means "allow non-fast-forward
> >updates"), the flag that allows the checked out branch head to be
> >updated is -u, --update-head-ok, and is for internal use only.
> >
> >And suggesting "reset --hard" seems wrong, that just kills any
> >uncommitted changes.
>=20
> Ok, so the commands were wrong.  Not important.
>=20
> It was the approach that I was trying to suggest rather than the
> actual commands.  The point I was trying to make was how, as a user,
> I would be happy to git behave.

Your approach explicitly included "mess up the index/worktree state",
otherwise, "git fetch" would not have to tell the user that he has to d=
o
a "git reset --hard HEAD". I honestly can't believe that you would be
happy with git messing up your work.

> So, I try to run fetch, git says "ooh, now that would be dangerous -
> you can force it happen by running "git foo", but you will then be
> in situation X, which you can then recover from by running "git
> bar", though you may need to run "git stash" to save any edits you
> have made" or something similar.

But why make "git fetch" with non-"obscure" refspecs dangerous to begin
with? If we detach but keep some extra information, there's no need to
make "git fetch" dangerous, _and_ we can still provide a command that
just fetches the most recent version of the "checked out" remote
tracking branch and checks that out. May it be another mode of operatio=
n
for "git pull" or some "git up" command or whatever.

> >And such uncommitted changes would be lost in the big "undo the fetc=
h
> >update" diff. So you'd have to do:
> >git reset --soft HEAD@{1}
> >git checkout --merge HEAD@{1}
> >
> >to keep them, while updating to the new state of the remote tracking
> >branch. Not quite intuitive, is it?
>=20
> I don't care what git has to do, I'm talking about the user
> experience - if we have to write some new code to support it, that
> really isn't a terribly hard thing to do.  UIs should be driven down
> from the user interaction not up from the implementation.

Those commands are those that git would have to show to you, instead of
"git reset --hard HEAD", i.e. they're what you, as the user, have to do=
=2E
And while "git reset --hard HEAD" might be remotely understandable to
the user, that command sequence is very unlikely to be understood by
most. And providing a command that does just this sequence is insane,
it's just a bandaid for git doing crap to your worktree/index state. So
let's better not start with git doing that crap at all.

My current "idea" (I don't think I'll have time to implement that any
time soon) is:

Keep some extra information in HEAD (or somewhere else) when HEAD is
detached about the ref that HEAD is "weakly" bound to. For example, "gi=
t
checkout origin/master" might create a weak binding to
refs/remotes/origin/master (for other [corner] cases, see the other
mail I wrote, in which I outlined some cases I considered interesting).

"git update" can use the branch.<name>.{remote,merge} setup, or
alternatively the "weak binding" information, to fetch from the right
remote, and checks whether a fast-forward of HEAD to the according
upstream branch head is possible. If so, it does a "git checkout --merg=
e
<upstream>" (possibly leaving conflicts for the uncommitted changes,
just like "svn update"). If a fast-forward is not possible, it
complains, telling the user that he needs to use "git merge/rebase/pull=
"
instead, and might want to create a branch head, in case of a detached
HEAD.

If there's also going to be a rule that forbids commits on some kind of
detached HEAD, than the command could also tell the user (when a
fast-forward is not possible) that upstream possibly rewrote history,
and that the user might want to use "git checkout --merge <upstream>"
(or maybe "git update -f"?) to just go to the new upstream version (not
sure if that hint should be shown in addition to or instead of the "git
merge/rebase/pull" hint).

Bj=F6rn
