From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: are hashes calculated from data
Date: Fri, 2 Apr 2010 08:10:16 +0200
Message-ID: <20100402061015.GC14999@m62s10.vlinux.de>
References: <g2veaacf13c1004011931w70695d1emdceeb977397aee0d@mail.gmail.com> <o2q32541b131004011950u6023ef29ocac1d80f2847ef6f@mail.gmail.com> <buozl1mbi0o.fsf@dhlpc061.dev.necel.com> <y2j32541b131004012148w283911f8pf04a21fc307f68ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>,
	Raymond Auge <raymond.auge@liferay.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 08:10:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxa5O-0008HJ-2a
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 08:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115Ab0DBGKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 02:10:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:53653 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757975Ab0DBGKW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 02:10:22 -0400
Received: (qmail invoked by alias); 02 Apr 2010 06:10:19 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp010) with SMTP; 02 Apr 2010 08:10:19 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+N4g9X5gKNhvUx73X+lSegisLvov/UoIVSiDdAB1
	9kb6rJ6jmyCBDg
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 86DB1D4002; Fri,  2 Apr 2010 08:10:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <y2j32541b131004012148w283911f8pf04a21fc307f68ed@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143777>

On Fri, Apr 02, 2010 at 12:48:44AM -0400, Avery Pennarun wrote:
> On Fri, Apr 2, 2010 at 12:22 AM, Miles Bader <miles@gnu.org> wrote:
> > Avery Pennarun <apenwarr@gmail.com> writes:
> >> At work, we have a cronjob that basically does most of these steps=
 for
> >> us. =A0Then there's a central git repo that corresponds to the svn=
 repo;
> >> people who want to use git can use that repo and not worry about
> >> git-svn.
> >
> > Do you happen to have the cron script available for perusal anywher=
e?
> >
> > I imagine many of the details would need to be changed for other
> > installations, but just looking at a working concrete example could=
 be
> > very helpful...
>=20
> Unfortunately the particular script we're using is about 99% local
> stuff and 1% useful stuff, so posting it won't really help.  The
> pseudocode is something like this:
>=20
>        # configure your git-svn so that all its branches are under re=
motes/svn/*
>        git fetch origin
>        git svn fetch --fetch-all
>        for each branch in remotes/svn/*
>            git checkout remotes/svn/$branch   # detaches HEAD
>            git merge --no-ff origin/$branch
>            git svn dcommit   # replaces merge commit
>            git checkout origin/$branch
>            git merge remotes/svn/$branch
>            git push origin HEAD:$branch
>        git push origin refs/remotes/svn/*:refs/heads/svn/*
>=20
> And then people who want to push into svn can push into the 'origin'
> repository, wherever that may be.  With some tweaking, you could make
> the git-svn repo and the origin repo the same.  It's a little annoyin=
g
> because git-svn absolutely insists on its branches being in
> refs/remotes/ somewhere, which means they don't normally get fetched
> when other people grab from your repo.
>=20
> Also consider setting [merge]summary=3Dtrue in your .gitconfig, so th=
at
> the svn commit will have *some* useful information about what got
> committed.
>=20

If I understand you correctly, this will commit only the the merge to s=
vn
and won't show all the commits the developer made (because of the --no-=
ff).
=46rom a SVN standpoint isn't it the same as doing the following?

	git checkout remotes/svn/$branch 	# to deatch the HEAD
	git merge --squash  origin/$branch
	git svn dcommit

I asked because in my workflow I can't to afford lossing the single com=
mits.

Peter
