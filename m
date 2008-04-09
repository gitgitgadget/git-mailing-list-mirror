From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Fwd: [Bug 163341] Re: git-svn gets wrong parent revision for
	tags
Date: Wed, 9 Apr 2008 10:03:33 +0200
Message-ID: <20080409080333.GA13892@atjola.homenet>
References: <20071117143713.8355.50653.malonedeb@potassium.ubuntu.com> <20080407195610.13681.39351.malone@potassium.ubuntu.com> <cd53a0140804080848r54bb1e6dq54b5cce62339d6d1@mail.gmail.com> <20080408171502.GA6163@atjola.homenet> <cd53a0140804081343l4b791dc3x5fa3fb294af71621@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Leonard <talex5@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 10:04:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjVI7-0000Jd-Bf
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 10:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbYDIIDi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2008 04:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbYDIIDi
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 04:03:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:48699 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752595AbYDIIDg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 04:03:36 -0400
Received: (qmail invoked by alias); 09 Apr 2008 08:03:34 -0000
Received: from i577BA362.versanet.de (EHLO atjola.local) [87.123.163.98]
  by mail.gmx.net (mp042) with SMTP; 09 Apr 2008 10:03:34 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/i5tQ6rWTitkrmUwYNkZGl08yXO8wseBhW4Y0uYN
	xU7lqq8mc1nhGb
Content-Disposition: inline
In-Reply-To: <cd53a0140804081343l4b791dc3x5fa3fb294af71621@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79085>

[Grmpf, the next time you drop from me Cc:, I'll not bother to
answer...]

On 2008.04.08 21:43:03 +0100, Thomas Leonard wrote:
> On 08/04/2008, Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> > On 2008.04.08 16:48:03 +0100, Thomas Leonard wrote:
> [...]
> >  > When converting a subversion repository to GIT using git-svn, th=
e tags
> >  > do not have the right parent. Each tag should be identical to a =
trunk
> >  > revision (which it was copied from), but because git-svn uses an
> >  > earlier revision as the parent it appears that the same work was
> >  > duplicated on two branches.
> [...]
> >  > git-svn clone https://zero-install.svn.sourceforge.net/svnroot/z=
ero-install
> >  > -T trunk/0publish -r1890:2072 -b releases/0publish
> >  >
> >  > The git branch comes from r1894, yet the svn log shows that in
> >  > includes files from r2070:
> >  >
> >  > $ svn log https://zero-install.svn.sourceforge.net/svnroot/zero-=
install
> >  > -r2071 -v
> >  > r2071 | tal197 | 2007-11-10 19:40:45 +0000 (Sat, 10 Nov 2007) | =
1 line
> >  > Changed paths:
> >  >    A /releases/0publish/0publish-0.12 (from /trunk/0publish:1968=
)
> >  >    R /releases/0publish/0publish-0.12/0publish (from
> >  > /trunk/0publish/0publish:2070)
> >  >    R /releases/0publish/0publish-0.12/0publish.xml (from
> >  > /trunk/0publish/0publish.xml:2070)
> >  >    R /releases/0publish/0publish-0.12/release.py (from
> >  > /trunk/0publish/release.py:2069)
> >
> > Well, SVN recorded useless, broken metadata.
>=20
> This is certainly true ;-)
>=20
> >  SVN itself believes that the branch was created from revision 1968=
=2E As
> >  that revision didn't introduce any changes to trunk/0publish, ther=
e's no
> >  commit for that revision in the git branch, so git-svn took the mo=
st
> >  recent one instead (1894).
>=20
> >  For the other three files, SVN reports that the files were replace=
d by
> >  versions from another branch. There's no immediate way to tell whe=
ther
> >  those replacements make the branch equal to the more recent versio=
n of
> >  trunk. So git-svn does it the safe way and reproduces what SVN tol=
d it
> >  to reproduce: A commit that creates a branch and changes some file=
s.
> >
> >  I guess sth. like this happened on the svn end:
> >  svn cp trunk/0publish releases/0publish (at rev. 1968)
> >  svn cp trunk/0publish/release.py releases/0publish (at rev. 2069)
> >  ...
> >  svn commit (whenever)
>=20
> The script that made the releases simply did this ("." is the working=
 copy):
>=20
> svn cp -m "Released $VERSION" . http://...
>=20
> Since each file in an svn working copy has its own revision (the last
> time it was changed), the branch ends up with multiple source
> revisions, even if the working copy is fully up-to-date and has no
> local changes.
>=20
> Example:
>=20
> cd /tmp
> svnadmin create test-repo
> svn mkdir file:///tmp/test-repo/trunk -m 'Setup'
> svn co file:///tmp/test-repo/trunk
> cd trunk
> touch foo bar
> svn add foo bar
> svn ci -m 'Start'
> echo hi > bar
> svn ci -m 'Update'
> svn cp . file:///tmp/test-repo/release -m 'Release'
> svn log -v file:///tmp/test-repo
>=20
> The log shows:
>=20
> ---------------------------------------------------------------------=
---
> r4 | talex | 2008-04-08 21:35:44 +0100 (Tue, 08 Apr 2008) | 1 line
> Changed paths:
>    A /release (from /trunk:1)
>    A /release/bar (from /trunk/bar:3)
>    A /release/foo (from /trunk/foo:2)
>=20
> Release

Change the "." to "file:///tmp/test-repo/trunk" in the svn cp command
and you get:
Changed paths:
   A /release (from /trunk:3)

Seems more useful. No idea why SVN decides to record crap when you use
".", even when your working copy is clean.

> So, I don't think the metadata is broken in this case. Maybe other
> people don't create branches like this, but it seemed like the obviou=
s
> way to do it at the time. Given this behaviour of svn, perhaps it
> would be better to take the highest version number as the branch
> point?

Uhm, and what happens then, when you actually _did_ just copy over a
few files, but not all of them? Right, you get a branch to start at a
later revision and see a bunch of reverts. Equally broken.

Bj=F6rn
