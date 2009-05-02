From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Sat, 2 May 2009 23:58:52 +0200
Message-ID: <20090502215852.GJ15420@raven.wolf.lan>
References: <20090428223728.GE15420@raven.wolf.lan> <32541b130904282019n4b930f80g1ed22b2dde22510a@mail.gmail.com> <20090429160129.GF15420@raven.wolf.lan> <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com> <20090429223747.GG15420@raven.wolf.lan> <32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com> <20090430222808.GH15420@raven.wolf.lan> <32541b130904301559w329bdd4bo6f2736a505b7235f@mail.gmail.com> <20090501142811.GI15420@raven.wolf.lan> <32541b130905011217x7f339d41x696fedee7298e3a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 00:03:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0NIo-00011A-0o
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 00:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285AbZEBWDO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2009 18:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756358AbZEBWDO
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 18:03:14 -0400
Received: from quechua.inka.de ([193.197.184.2]:37977 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754895AbZEBWDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 18:03:13 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1M0NIZ-0006SR-H6; Sun, 03 May 2009 00:03:08 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 41C5F2CCA5; Sat,  2 May 2009 23:58:52 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130905011217x7f339d41x696fedee7298e3a4@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118146>

On Fri, May 01, 2009 at 03:17:14PM -0400, Avery Pennarun wrote:
> On Fri, May 1, 2009 at 10:28 AM, Josef Wolf <jw@raven.inka.de> wrote:
> > On Thu, Apr 30, 2009 at 06:59:50PM -0400, Avery Pennarun wrote:
> >> "git log -1 first-svn" would give you the first cherry-pick. =A0Bu=
t
> >> remember, it's a completely different branch.
> >
> > I can see why this happens, but I still find it confusing. =A0Maybe=
 I
> > should help with the -m option?
>=20
> I don't know what -m does.  Maybe try looking at the graph with gitk;
> that might give some clues.

Option -m lets me set the log message explicitly :)

> >> Okay, if you want to end up with two different remote branches, it
> >> makes sense to have two different local branches.
> >
> > Well, I _have_ two different remotes because I have two svn reposit=
ories.
>=20
> Right.  I was just wondering whether you wanted the two branches'
> contents to be *different* or identical.  I guess different.

They have to stay different, because they are localized.

> > Then I have to keep both local branches. =A0But I still wonder why =
you
> > suggested to go with _one_ local branch.
>=20
> For my own purposes, I try not to create a 1:1 mapping between local
> branches and remote branches; this just ends up being confusing,
> because I can have commits in my local branch that aren't in the
> remote one, and vice versa.  So it's not very useful to create a loca=
l
> branch *just* because I have a corresponding remote branch.
>=20
> In your case, you might want to have just a single local branch for
> your "public" stuff.  You would then merge changes from the two svn
> remote branches into your local branch, and you'd also merge from you=
r
> local branch into your remote branches (using a disconnected HEAD and
> svn dcommit).

But I am working not only on the "public" stuff.  Additionally, I am
working on _multiple_ localized stuff.  Thus, I have multiple remote
repositories.

Somehow, I still can't get it work.  This is what I do:

  # create the repos
  #
  git svn init --stdlayout file:///var/tmp/builds/git-sync/svn/svn-1
  git config merge.stat true

  # add configuration for svn-1 repos
  #
  git config svn-remote.svn-1.url      file:///var/tmp/builds/git-sync/=
svn/svn-1
  git config svn-remote.svn-1.fetch    trunk:refs/remotes/svn-1/trunk
  git config svn-remote.svn-1.branches branches/*:refs/remotes/svn-1/*
  git config svn-remote.svn-1.tags   tags/*:refs/remotes/svn-1/tags/*

  # add configuration for svn-2 repos
  #
  git config svn-remote.svn-2.url      file:///var/tmp/builds/git-sync/=
svn/svn-2
  git config svn-remote.svn-2.fetch    trunk:refs/remotes/svn-2/trunk
  git config svn-remote.svn-2.branches branches/*:refs/remotes/svn-2/*
  git config svn-remote.svn-2.tags   tags/*:refs/remotes/svn-2/tags/*

  # fetch the commits from svn repositories
  #
  git svn fetch -R svn-1
  git svn fetch -R svn-2

  # create local tracking branches
  #
  git checkout -b svn-1 svn-1/trunk
  git checkout -b svn-2 svn-2/trunk

  # just to see what we've done
  #
  git tag svn-1-orig svn-1
  git tag svn-2-orig svn-2

  # move stuff from svn-2 to svn-1
  #
  git svn fetch svn-2
  git checkout svn-1
  git cherry-pick 05b964
  [  continue cherry-picking ]
  git merge --no-ff -s ours svn-1

  # check what I have done
  #
  git diff svn-1-orig svn-1/trunk # shows what I expect

  # move the result to svn-1
  #
  git checkout svn-1/trunk
  git merge --no-ff svn-1
  git svn dcommit

  # move stuff from svn-1 to svn-2
  #
  git svn fetch svn-1
  git checkout svn-2
  git cherry-pick -n c9dae
  [ continue cherry-picking ]
  git merge --no-ff -s ours svn-2

  # check what I have done
  #
  git diff svn-2-orig svn-2/trunk # shows what I expect

  # move the result to svn-2
  #
  git checkout svn-2/trunk
  git merge --no-ff svn-2
  git svn dcommit

At this point, we should be synchronized.

  git checkout svn-2/trunk
  git svn fetch svn-1
  git merge --no-ff svn-1

BOOM.  Although no new commits were fetched, we get a lot of conflicts
here.  So git is not fully aware about the fact that we are synchronize=
d.
