From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Fri, 1 May 2009 00:28:09 +0200
Message-ID: <20090430222808.GH15420@raven.wolf.lan>
References: <20090427201251.GC15420@raven.wolf.lan> <32541b130904281353k572fed5la468de65f73ccd19@mail.gmail.com> <20090428223728.GE15420@raven.wolf.lan> <32541b130904282019n4b930f80g1ed22b2dde22510a@mail.gmail.com> <20090429160129.GF15420@raven.wolf.lan> <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com> <20090429223747.GG15420@raven.wolf.lan> <32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 00:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzen4-0004kJ-JX
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 00:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763517AbZD3WbR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 18:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763502AbZD3WbR
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 18:31:17 -0400
Received: from quechua.inka.de ([193.197.184.2]:44479 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763499AbZD3WbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 18:31:14 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Lzemd-0007Uh-W4; Fri, 01 May 2009 00:31:12 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 1FCD92CC97; Fri,  1 May 2009 00:28:09 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118048>

On Wed, Apr 29, 2009 at 10:07:31PM -0400, Avery Pennarun wrote:
> On Wed, Apr 29, 2009 at 6:37 PM, Josef Wolf <jw@raven.inka.de> wrote:
> > On Wed, Apr 29, 2009 at 02:13:29PM -0400, Avery Pennarun wrote:
> >> So you're saying that from now on, *all* changes from *both* branc=
hes
> >> need to be integrated in both directions?
> >
> > Exactly. =A0Those three commands:
> >
> > =A0git diff first-svn =A0 =A0 =A0 =A0second-svn =A0# this should be=
 the "private" diff
> > =A0git diff first-svn/trunk =A0first-svn =A0 # what my cherry-picki=
ng has changed
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0# (and waits for push) in first-svn
> > =A0git diff second-svn/trunk second-svn =A0# what my cherry-picking=
 has changed
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0# (and waits for push) in second-svn
> >
> > show me _exactly_ what I want them to be. =A0The manual synchroniza=
tions
> > which were done in the past are resolved now. =A0But I can't find t=
he way
> > how to put the result of this cherry-picking back into the svn repo=
sitories
>=20
> Okay, I think perhaps you're missing something that took me a long
> time to figure out about git-svn, but once I understood it, my life
> went a lot more smoothly.
>=20
> Basically, 'git svn fetch' updates just a *remote* branch.  (Remote
> branches are in .git/refs/remotes/* and you can't change them
> yourself, because you can't attach your HEAD to them.  If you try to
> check them out, you get the latest revision in that branch, but your
> HEAD becomes detached.)
>=20
> I'm not actually sure which of the above branches you're referring to
> is remote and which is local.  Let's guess that first-svn/trunk is
> remote, and first-svn is a local copy of it, onto which you
> cherry-picked some extra patches.

Yeah, your guess is correct:

  first-svn/trunk   remote branch of the fist svn repos
  second-svn/trunk  remote branch of the second svn repos
  first-svn         local branch where first-svn/trunk is to be tracked
  second-svn        local branch where second-svn/trunk is to be tracke=
d

> What I'm suggesting is that you think of your local branch (first-svn
> in this case, I guess) as *not* an svn branch at all.  You never do
> any git-svn operations directly on this branch.  In fact, rename it t=
o
> master so you aren't tempted to get yourself into trouble.

I see.  But currently, I have _two_ local branches and not only one, as
you suggested in your last post.

> Now, you've merged from first-svn/trunk and cherry-picked some extra
> stuff onto this branch, right?  Good.  Now you want to *merge* this
> branch into first-svn/trunk, producing just *one* new commit, and
> dcommit that into svn.
>=20
>    git checkout first-svn/trunk
>       # detaches the HEAD
>    git merge master
>       # produces a merge commit on the detached HEAD
>    git svn dcommit
>       # produces a *different* commit object on the first-svn/trunk b=
ranch
>       # ...and moves HEAD to it.
>=20
> The newly-produced commit tells git that first-svn/trunk is now
> up-to-date with master.  Note that the interim merge commit (produced
> by 'git merge') is never shared with *anyone*, so it's perfectly okay
> that we replace it with the next command.

=46inally, this seems to work.  Luckily, I've done the cherry-picking
not directly, but instead wrote a perl-script with instructions which
commits to pick and how to resolve the conflicts for specific commits.
I use copies of the repositories for this, so I can re-play the scenari=
o
until the result fits the expectations.

With your explanation, I finally arrived at the _first_ work flow
that is able to push the results of the cherry-picking back to the
svn repositories.  Having the branches described above, it goes
like this:

  # first, retrieve what is available
  #
  git svn fetch first-svn
  git svn fetch second-svn

  # cherry-pick from second-svn to first-svn
  #
  git svn checkout first-svn
  git cherry-pick sha1-from-second-svn # repeat as needed
  git checkout first-svn/trunk
  git merge --no-ff first-svn
  git diff first-svn/trunk first-svn >changes.diff
  git svn dcommit

  # now do the same the other way around
  #
  git svn checkout second-svn
  git cherry-pick sha1-from-first-svn # repeat as needed
  git checkout second-svn/trunk
  git merge --no-ff second-svn
  git diff second-svn/trunk second-svn >changes.diff
  git svn dcommit

But I am still somewhat confused:

  git log -1 first-svn/trunk

says "Merge branch first-svn into HEAD".  But this does not reflect
what I've actually done: I've picked _from_ second-svn and committed
that _to_ first-svn.

> What you probably thought you should do, given that the existing
> git-svn documentation says to do it, is more like this:
>=20
>    # WRONG
>    git checkout first-svn
>    git cherry-pick some stuff
>    git merge [perhaps -s ours] second-svn/trunk
>    git svn dcommit

Almost... In addition, I was trying to "git svn rebase" before the
dcommit

> But the above will *change* every single commit you put on first-svn,
> because dcommit needs to *regenerate* all the commits after putting
> them into svn and getting them back again.  This is essentially a
> rebase, and disrupts any merges you might have made from this branch
> to another one.  Next time you merge, you'll get a zillion conflicts.
>=20
> > Ah! =A0I thought I _have_ to "git svn rebase" before I dcommit, lik=
e I need
> > to "svn update" before I can do "svn commit".
>=20
> This is true and yet not true.  The reason I don't have to ever use
> 'git svn rebase' is that 'git svn fetch' updates my first-svn/trunk
> branch, and then I quickly do a merge-then-dcommit on that branch.  I=
f
> I was to do a 'git svn rebase' first, nothing would happen, because
> svn doesn't change.
>=20
> This is important, since 'git svn dcommit' actually *does* do a 'git
> svn rebase' for you automatically, trying to be helpful.

What would happen if somebody else creates a new commit just after I
"git svn fetch" but before I dcommit?  Guess, svn will not accept this
commit, because it is based on an outdated revision.  How would I
get out from this situation?

> >> In general, 'git svn rebase' should be avoided for all the same
> >> reasons that 'git rebase' should be avoided. =A0They're both great=
 when
> >> used carefully, but they shouldn't be your main day-to-day activit=
y.
> >
> > Unfortunately, all the howto's I could find recommend exactly that:
> > git-svn-rebase for getting commits from svn and dcommit for sending
> > commits to svn.
>=20
> Yeah, they're trying to keep things simple, at the cost of preventing
> you from doing anything complicated.  I'm not smart enough to do both=
,
> so I'm just making things complicated for you here ;)

At least I could finally submit the cherries to the svn repositories.
That's a big step forward, although I still don't fully understand all
the details.

> As it happens, I wrote the git-svn chapter for the
> very-nearly-available new O'Reilly book "Version Control with Git."  =
I
> gave the complicated solution there too.

Interesting.  Do you have any information when it will be available?

> I'm eagerly awaiting the
> giant flames from people who actually wrote git-svn (and its
> documentation) and therefore are highly qualified to disagree with me=
=2E
>=20
> >> =A0 - 1 remote branch: git-svn-1
> >> =A0 - 1 remote branch: git-svn-2
> >> =A0 - 1 local branch: master
> >
> > I will try this one. =A0But this will take a while, since my
> > cherry-picking was done criss-cross. =A0Thus, I need to "rebase"
> > the cherries now to get them onto a single branch. =A0Is there
> > a simple way to do that or do I have to redo the cherry-picking fro=
m
> > scratch?
>=20
> No no!  Stop rebasing!
>=20
> You have a branch that looks the way you want, right?

Ummm, no.. I have _two_ branches:

  first-svn:  contains the cherries that I picked from second-svn. This
              branch looks the way first-svn/trunk should be
  second-svn: contains the cherries that I picked from first-svn. This
              looks the way second-svn/trunk should be

Don't I need to rebase at least one of them if I want to "merge" those
two branches into a single one?

I have a hard time to adopt my mental model to the one-branch method fo=
r
some reason.  OTOH, I can easily understand the multiple-branch method:
for every remote branch, I have a local branch on which I collect the
commits that should go to this remote.

> That means
> you're 99% of the way there.  You just have to convince git that this
> branch and the svn branch are related to each other in the way they
> actually are.
>=20
> To do that, you just need to do is make a single merge commit on your
> svn remote branch that looks the way you want and merges from your
> existing branch, then do a single 'git svn dcommit'.  Here's one way
> (assuming you want to make svn look like your new local branch):
>=20
>    git checkout my-local-branch
>    git merge -s ours svn-branch
>    git checkout svn-branch
>    git merge --no-ff my-local-branch
>    git svn dcommit
>=20
> (If the occasionally-suggested '-s theirs' merge strategy existed, yo=
u
> could just do the last three steps using git merge -s theirs.)
>=20
> >> >> As long as you "git config merge.summary true" (to make the mer=
ge
> >> >> commit list all the commits it's merging)
> >>
> >> When you *merge* (as opposed to rebase or cherry-pick) into an svn
> >> branch, you only create a *single* svn commit that contains *all* =
the
> >> changes. =A0The above config setting just makes the merge commit c=
ontain
> >> a list of all the commits it contains.
> >
> > But git will not use this information in any way, AFAIK. =A0So this=
 information
> > is only for the person who will do the next merge?
>=20
> In fact, it *only* affects the svn log.  Otherwise svn log ends up
> with a useless commit that says "Merged from commit (giant hex
> string)", and you can't actually do anything with the giant hex strin=
g
> because svn doesn't know what it is.

OK.  I just noticed the list is limited to 22 entries.  Can this be
configured somehow to contain the complete list?

> > The people are not uncooperative. =A0It is just that there's no way=
 to
> > completely separate the public and private content.
>=20
> There is, if you're willing to do it.  The usual way is two have two
> branches: public and private.

Well, my plan was to have one (generic) public repository that contains
templates instead of the localized information.  Separating the
repositories is a security measure here.

Whether separate repositories or only different branches, conflicts
_are_ to be expected in this area. =20

> Whenever you make a change that you want to be public, you commit it
> on the public branch, then merge (git merge or svn merge, it doesn't
> matter) from public to private.  If you want to make a private change=
,
> you just commit it directly to private.
>=20
> This way, you will always have the two sets of changes isolated, you
> never have to cherry-pick anything, and "git diff public private" is
> always a sensible thing to do.

Yeah, I see.  OTOH, I'd rather avoid doing two steps in one go.
Currently, I have a hard time to get _one_ branch in sync.  I'll come
back to the multiple-branch-thing as soon as I have mastered the
one-branch-thing ;-)

> (In fact, when I do this, I often don't share the private branch with
> anyone at all, which means it's safe to rebase.  That means I can kee=
p
> a clean set of patches against the public branch, and sort and
> rearrange or share them whenever I feel like it.  This is useful in
> some cases.  Rebasing isn't *always* bad :))
>=20
> >> If you're using cherry-pick for everything, there's no reason to u=
se
> >> tricks like 'merge -s ours'. =A0Just leave out the merging entirel=
y and
> >> don't pretend that what you're doing is merging; it isn't. =A0(You=
 still
> >> don't need 'git svn rebase' for anything. =A0Just checkout the bra=
nch
> >> you want to change, cherry-pick stuff into it, and 'git svn dcommi=
t'
> >> if appropriate.)
> >
> > But then I have to do the book-keeping (what was already picked in =
which
> > direction) by myself?
>=20
> On branch b, 'git merge x' will always merge all the changes from the
> most recent merge of x into b (which might be a "-s ours" merge if yo=
u
> want), up to the tip of x.  So if you don't commit any *new* private
> stuff to x, you can use merge.  If you're intermixing the changes,
> you'll need to use cherry-pick.  git won't attempt to track the
> cherry-picks for you (like eg. svnmerge will).
