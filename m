From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn and repository hierarchy?
Date: Wed, 4 Mar 2009 20:27:52 +0100
Message-ID: <20090304192752.GC11278@raven.wolf.lan>
References: <20090224223412.GA4573@raven.wolf.lan> <49A50EB2.80300@drmicha.warpmail.net> <20090227171248.GB14187@raven.wolf.lan> <49A826C8.1060300@drmicha.warpmail.net> <20090227220512.GC14187@raven.wolf.lan> <49A97B7A.8010005@drmicha.warpmail.net> <20090303185108.GA11278@raven.wolf.lan> <eaa105840903031135o4cf72ed0oe3fffed69cb7ce03@mail.gmail.com> <20090303223600.GB11278@raven.wolf.lan> <eaa105840903031618s5e0b6f24j64aade8d752fb11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 20:32:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lewp7-0003MW-PH
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 20:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434AbZCDTak convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 14:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755217AbZCDTak
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 14:30:40 -0500
Received: from quechua.inka.de ([193.197.184.2]:60024 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755169AbZCDTaj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 14:30:39 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Lewnc-0004bn-FP; Wed, 04 Mar 2009 20:30:36 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 5FD622C91E; Wed,  4 Mar 2009 20:27:52 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <eaa105840903031618s5e0b6f24j64aade8d752fb11@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112237>

On Tue, Mar 03, 2009 at 07:18:04PM -0500, Peter Harris wrote:
> On Tue, Mar 3, 2009 at 5:36 PM, Josef Wolf wrote:
> >
> > I'd rather not let every clone talk to subversion for several reaso=
ns.
> > One of them is that it is very inconvenient (e.g. the password has =
to
> > be entered several times for every commit).
>=20
> Sounds like subversion isn't properly caching your credentials, or
> your admin is paranoid and turned off the svn credential cache. I
> can't remember the last time I had to enter a password.

What credential cache are you talking about?  I don't know of any
worth to be mentioned.  If you talk about "store-passwords=3Dyes" in
subversion's config or about the .netrc file that has to be used for
git, you might be interested to read
http://curl.haxx.se/docs/adv_20090303.html
If you know about another method, please tell me.

BTW: The paranoid admin is myself.   ;-)
BTW1: I know there's the possibility of client certificates.  But AFAIK=
,
      there's no equivalent to ssh-agent, so it's pointless.

> Of course, git-svn-repo can't cache credentials, since it has to
> impersonate different users. You are impersonating different users so
> that the svn author field is correct, aren't you? But that shouldn't
> be a problem for userN working on cloneN.

Ah, that would have been one of my next questions (I don't like to star=
t
new threads as long as old threads are on-going ;-)
Within svn, the author field seems to be correct (at least, it is
identical to those of the commits that were done directly to svn)
But when the commits come back to git, it is set to
"jw <jw@041dc122-08ea-11de-a769-bddc3e64b585>" with the host-part being
the uuid of the svn-repo.

Any ideas how to fix that?

Oh, and what happens if svn's rev-properties (commit log, author, date.=
=2E.)
are changed?

> > =A0After all, the whole point
> > for having git-svn-repos is for the clone to avoid working directly
> > against the subversion repos. =A0If every clone works against subve=
rsion
> > anyway, I can get rid of git-svn-repos as well.
>=20
> From my perspective, the main advantage of git-svn-repos is the inita=
l
> clone. Subversion is way too slow to clone an entire project's histor=
y
> (days, vs minutes for git). Subsequent 'git pull --rebase's are faste=
r
> than 'git svn rebase's, too, although not by the same ratio (except
> for large subtree moves, which really are that much faster).

Of course, initial clone is an argument.  But you do this exactly once
per clone.  And you can do that unattended over the weekend.

In contrast, working directly against an svn repository is _very_
tedious.  With a dozen commits pending, you have to enter your password
about 30..50 times in "git svn dcommit".  While you can run the initial
clone unattended over the weekend, there's currently no (sensible) way=20
to avoid this massive interactive password hammering.  And you have to
do that on every dcommit.

> > On Tue, Mar 03, 2009 at 02:35:28PM -0500, Peter Harris wrote:
> >> Also, this line says "rebase my changes onto those of ../clone$clo=
ne",
> >> which isn't what you want. It will end up rebasing svn commits tha=
t
> >> the client didn't have on top of the client's commits, and will br=
eak
> >> git-svn's index. Don't use --rebase here.
> >
> > Hmm, I must have misunderstood Michael, then. =A0Wasn't he suggesti=
ng
> > to rebase here? =A0Here's the citation:
> >
> > |> =A0 (cd git-svn-repos; git pull ../clone1) =A0# if this line is =
executed,
> > |
> > |That's the problem. This creates a merge after which you 1-2-3-4 a=
nd
> > |1-2'-3'-4' plus the merge of 4 and 4'.
> > |
> > |Instead, use git pull --rebase here. You don't want merges in the =
branch
> > |from which you dcommit.
>=20
> I think he meant to say "git pull ../cloneN && git rebase trunk".

Did you mean "git pull ../cloneN && git rebase master"?  There's no
trunk in git, AFAIK?

So here's my current idea about the work flow.  At the end of this mail=
,
I've attached the whole test-script again.  But this time, I have
extracted the main tasks
  1. work on some clones
  2. move commits from clone to subversion
  3. move commits received from subversion to clone
to make them more self-contained.  Ideally, those three tasks would
be packed into shell functions or something...


  # 1. work on some clones
  #
  cd clone$clone
  git checkout master
  git pull --rebase                     # need rebase?
  git checkout -b topic-branch
  for commit in 1 2 3; do
    echo change $clone $commit >>test
    git commit -a -m "commit $clone $commit"
  done



  # 2. move commits from clone to subversion
  #
  cd git-svn-repos
  git svn rebase
  git pull ../clone$clone topic-branch   # need rebase?

  # Check for conflict and pretend we have resolved it
  grep change test >test.resolved
  if diff test test.resolved ; then
    rm test.resolved
  else
    mv test.resolved test
    git add test
    git commit -m "merge"
  fi

  git svn dcommit



  # 3. move commits received from subversion to clone
  #
  cd clone$clone
  git checkout master
  git pull                               # need rebase?
  git branch -D topic-branch



This work flow seems to generate a proper result and a sensible history=
=2E
But I am still not sure about when (and how) I have to rebase.  I have
marked the lines in question with "#need rebase?".


#! /bin/sh

(
  set -x

  # create test directory
  #
  TESTDIR=3D`mktemp --tmpdir=3D. git-svn-hierarchy-test-XXXXXXXX`
  rm -rf $TESTDIR
  mkdir -p $TESTDIR
  cd $TESTDIR

  SUBVERSION_REPOS=3Dfile://`pwd`/subversion-repos

  # create subversion repos with some history
  #
  svnadmin create subversion-repos
  svn -m "create standard layout" mkdir \
      $SUBVERSION_REPOS/trunk \
      $SUBVERSION_REPOS/branches \
      $SUBVERSION_REPOS/tags
  svn co $SUBVERSION_REPOS/trunk subversion-wc
  echo change1 >>subversion-wc/test
  svn add subversion-wc/test
  svn ci -m "commit 0" subversion-wc

  # create git-svn-repos
  #
  git svn init --stdlayout $SUBVERSION_REPOS git-svn-repos
  (cd git-svn-repos; git svn fetch)

  # create some clones
  #
  git clone git-svn-repos clone1
  git clone git-svn-repos clone2
  git clone git-svn-repos clone3

  for round in 1 2 3; do
    for clone in 1 2 3; do

     # work on clone
     #
     (
       cd clone$clone
       git checkout master
       git pull --rebase
       git checkout -b topic-branch
       for commit in 1 2 3; do
         echo change $round $clone $commit >>test
         git commit -a -m "commit $round $clone $commit"
       done
     )

     # move commits from clone to subversion
     #
     (
       cd git-svn-repos
       git svn rebase
       git pull ../clone$clone topic-branch
       grep change test >test.resolved

       # Check for conflict and pretend we have resolved it
       if diff test test.resolved ; then
         rm test.resolved
       else
         mv test.resolved test
         git add test
         git commit -m "merge"
       fi

       git svn dcommit
     )

     # move commits from subversion to clone
     (
       cd clone$clone
       git checkout master
       git pull
       git branch -D topic-branch
     )
    done

    # commit from svn
    #
    (
      cd subversion-wc
      svn up
      echo change $round s >>test
      svn ci -m "commit $round s"
    )

  done
)
