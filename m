From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Fri, 1 May 2009 16:28:11 +0200
Message-ID: <20090501142811.GI15420@raven.wolf.lan>
References: <20090427201251.GC15420@raven.wolf.lan> <32541b130904281353k572fed5la468de65f73ccd19@mail.gmail.com> <20090428223728.GE15420@raven.wolf.lan> <32541b130904282019n4b930f80g1ed22b2dde22510a@mail.gmail.com> <20090429160129.GF15420@raven.wolf.lan> <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com> <20090429223747.GG15420@raven.wolf.lan> <32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com> <20090430222808.GH15420@raven.wolf.lan> <32541b130904301559w329bdd4bo6f2736a505b7235f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 16:31:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LztmH-0002EM-RC
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 16:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760955AbZEAOa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2009 10:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbZEAOa6
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 10:30:58 -0400
Received: from quechua.inka.de ([193.197.184.2]:37366 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759738AbZEAOa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 10:30:57 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LztlQ-0007Y2-6J; Fri, 01 May 2009 16:30:56 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 2DE422CCA0; Fri,  1 May 2009 16:28:11 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130904301559w329bdd4bo6f2736a505b7235f@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118079>

On Thu, Apr 30, 2009 at 06:59:50PM -0400, Avery Pennarun wrote:
> On Thu, Apr 30, 2009 at 6:28 PM, Josef Wolf <jw@raven.inka.de> wrote:
> > =A0# cherry-pick from second-svn to first-svn
> > =A0#
> > =A0git svn checkout first-svn
> > =A0git cherry-pick sha1-from-second-svn # repeat as needed
> > =A0git checkout first-svn/trunk
> > =A0git merge --no-ff first-svn
> > =A0git diff first-svn/trunk first-svn >changes.diff
> > =A0git svn dcommit
> [...]
> > But I am still somewhat confused:
> >
> > =A0git log -1 first-svn/trunk
> >
> > says "Merge branch first-svn into HEAD". =A0But this does not refle=
ct
> > what I've actually done: I've picked _from_ second-svn and committe=
d
> > that _to_ first-svn.
>=20
> The most recent commit to first-svn/trunk was "git merge --no-ff
> first-svn", which creates the merge commit you're seeing here.  (HEAD
> =3D=3D first-svn/trunk).  So this sounds right to me.
>=20
> "git log -1 first-svn" would give you the first cherry-pick.  But
> remember, it's a completely different branch.

I can see why this happens, but I still find it confusing.  Maybe I
should help with the -m option?

> >> What you probably thought you should do, given that the existing
> >> git-svn documentation says to do it, is more like this:
> >>
> >> =A0 =A0# WRONG
> >> =A0 =A0git checkout first-svn
> >> =A0 =A0git cherry-pick some stuff
> >> =A0 =A0git merge [perhaps -s ours] second-svn/trunk
> >> =A0 =A0git svn dcommit
> >
> > Almost... In addition, I was trying to "git svn rebase" before the
> > dcommit
>=20
> 'git svn dcommit' implies 'git svn rebase' first anyway, so it's the =
same.
>=20
> > What would happen if somebody else creates a new commit just after =
I
> > "git svn fetch" but before I dcommit? =A0Guess, svn will not accept=
 this
> > commit, because it is based on an outdated revision. =A0How would I
> > get out from this situation?
>=20
> AFAIK, it will attempt to do "git svn rebase" first, and if that
> succeeds, it will do the commit.
>=20
> In such a case, the rebase should be okay, because it's only changing
> commits (in fact, just one commit: the merge commit) that don't exist
> on any other branch.  Thus it won't mangle any other merges.

Yeah, that's the simple case.  But what if the rebase don't succeed?

> > Ummm, no.. I have _two_ branches:
> >
> > =A0first-svn: =A0contains the cherries that I picked from second-sv=
n. This
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0branch looks the way first-svn/trunk sho=
uld be
> > =A0second-svn: contains the cherries that I picked from first-svn. =
This
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0looks the way second-svn/trunk should be
>=20
> Okay, if you want to end up with two different remote branches, it
> makes sense to have two different local branches.

Well, I _have_ two different remotes because I have two svn repositorie=
s.

> > Don't I need to rebase at least one of them if I want to "merge" th=
ose
> > two branches into a single one?
>=20
> I don't think so.  If you merge them together, what do you *want* it
> to look like?  And what do you want to do with that branch afterwards=
?
>  It's hard for me to guess, but it seems unlikely that rebasing thing=
s
> will get you there.

Then I have to keep both local branches.  But I still wonder why you
suggested to go with _one_ local branch.

> If what you want is "one central branch that currently looks like
> first-svn/trunk or second-svn/trunk or maybe something else, but we'l=
l
> be merging future changes to first-svn and second-svn into it in the
> future", then you would do:
>=20
>    git checkout -b one-true-branch
>    ...make it look however you want...
>    # now mark it as up-to-date with svn, but don't change anything
>    git merge -s ours first-svn/trunk
>    git merge -s ours second-svn/trunk
>=20
> And then in the future, whenever first-svn/trunk or second-svn/trunk
> change, you would do:
>=20
>    git merge first-svn/trunk
>    git merge second-svn/trunk
>=20
> etc.

I guess that might be interesting for the generic branch, where all the
localizations are replaced by templates.
