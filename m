From: Eric Wong <normalperson@yhbt.net>
Subject: Re: .gitignore and svn:ignore [WAS: git-svn and submodules]
Date: Tue, 16 Oct 2007 00:58:27 -0700
Message-ID: <20071016075827.GB32348@soma>
References: <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr> <20071015144513.GB7351@diana.vm.bytemark.co.uk> <20071015151405.GA1655@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:58:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhhK9-0000Sr-3f
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 09:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765378AbXJPH63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 03:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764815AbXJPH63
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 03:58:29 -0400
Received: from hand.yhbt.net ([66.150.188.102]:46400 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755510AbXJPH62 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 03:58:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 6C4917DC0FE;
	Tue, 16 Oct 2007 00:58:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071015151405.GA1655@pe.Belkin>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61109>

Chris Shoemaker <c.shoemaker@cox.net> wrote:
> On Mon, Oct 15, 2007 at 04:45:13PM +0200, Karl Hasselstr=F6m wrote:
> > On 2007-10-15 09:07:21 +0200, Benoit SIGOURE wrote:
> >=20
> > >   - git svn create-ignore (to create one .gitignore per directory
> > > from the svn:ignore properties. This has the disadvantage of
> > > committing the .gitignore during the next dcommit,
> >=20
> > I built ignore support for git-svnignore a long time ago. It conver=
ts
> > the per-directory svn:ignore to per-directory .gitignore at commit
> > import time, which is very handy:
> >=20
> > -I <ignorefile_name>::
> >         Import the svn:ignore directory property to files with this
> >         name in each directory. (The Subversion and GIT ignore
> >         syntaxes are similar enough that using the Subversion patte=
rns
> >         directly with "-I .gitignore" will almost always just work.=
)
> >=20
> > The only downside with that is that svn ignore patterns are
> > non-recursive, while git ignore patterns are recursive. This could =
be
> > solved by prefixing them with a "/".
>=20
> Has anyone put any thought into mapping the other direction?=20
> i.e. .gitignore  ->  svn:ignore

If we support .gitignore <-> svn:ignore in git-svn; bidirectional,
transparent mapping is the only way I want to go.


This means that *all* .gitignore files will be translated to svn:ignore
files and vice versa; and the .gitignore files will be NOT be committed
to SVN itself, but present in the git-svn created mirrors.  Recursive
=2Egitignore definitions will be mapped to svn:ignore recursively on th=
e
client side; and non-recursive ones will only map to one directory.

Sound good?

I may be sleepy at the moment, but the thought of implementing this is
sounding complicated now...


One goal of git-svn is that other users shouldn't be able to tell if a
user is using git-svn or plain svn; even.


But back to submodules, I plan on mapping svn:externals <=3D> .gitmodul=
es
files in a similar fashion.  .gitmodule files will never be seen by SVN
users, period.

That being said, the first step to submodule/externals support in
git-svn will be to allow /any/ git repository to use a submodule that
points to SVN; and then git-submodule will invoke git-svn if it
sees such a submodule.

Yes, I have a plan, sort of...

Since externals/submodules don't operate recursively in either
system like .gitignore; supporting svn:externals <=3D> submodules
will be much easier and done first[1] :)


[1] - I've personally rarely bothered with putting svn:ignores in the
repository and have been very much spoiled by .git/info/exclude;
whereas externals support I have semi-immediate use for.

--=20
Eric Wong
