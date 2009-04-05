From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 13:43:25 -0700
Message-ID: <20090405204325.GA31344@curie-int>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:49:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZE1-0006FR-0h
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758183AbZDEUnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 16:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758118AbZDEUnc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:43:32 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:59741 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754581AbZDEUnc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 16:43:32 -0400
Received: (qmail 13278 invoked from network); 5 Apr 2009 20:43:28 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 05 Apr 2009 20:43:28 +0000
Received: (qmail 31396 invoked by uid 10000); 5 Apr 2009 13:43:25 -0700
Content-Disposition: inline
In-Reply-To: <20090405190213.GA12929@vidovic>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115706>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2009 at 09:02:13PM +0200, Nicolas Sebrecht wrote:
> > Before I answer the rest of your post, I'd like to note that the matter
> > of which choice between single-repo, repo-per-package, repo-per-category
> > has been flogged to death within Gentoo.
> >=20
> > I did not come to the Git mailing list to rehash those choices. I came
> > here to find a solution to the performance problem.
> I understand. I know two ways to resolve this:
> - by resolving the performance problem itself,
> - by changing the workflow to something more accurate and more suitable
>   against the facts.
>=20
> My point is that going from a centralized to a decentralized SCM
> involves breacking strongly how developers and maintainers work. What
> you're currently suggesting is a way to work with Git in a centralized
> way. This sucks. To get the things right with Git I would avoid shared
> and global repositories. Gnome is doing it this way:
> http://gitorious.org/projects/gnome-svn-hooks/repos/mainline/trees/master
The entire matter of splitting the repository comes down to what should
be considered an atomic unit. For GNOME, KDE and all of the other large
Git consumers that I'm aware of, there atomic units are individual
packages - specifically because they make sense to be consumed without
having all the rest of the packages. For the gentoo tree, it is an
atomic unit in itself. Changes to the profiles/ directory (for package
masks, USE keys are frequently related and need to be always committed
and received atomically with changes to one or more packages.

> >          The GSoC 2009 ideas contain a potential project for caching the
> > generated packs, which, while having value in itself, could be partially
> > avoided by sending suitable pre-built packs (if they exist) without any
> > repacking.
> Right. It could be an option to wait and see if the GSoC gives
> something.
How hard is it to just look at the git-upload-pack code and make it
realize that it doesn't need to repack at all for this case.

> > A quick bit of stats run show that while some developers only touch a
> > few packages, there are at least 200 developers that have done a major
> > change to 100 or more packages.
> That's a point that has to be reconsidered. Not the fact that at least
> 200 developers work on over 100 packages (this is really not an issue)=B9
> but the fact that they do that directly on the main repo/server. The
> good way to achieve this is to send his work to the maintainer=B2. The ma=
in
> issue is a better code reviewing.
This has been shot down by our developer base. One of the grounds is
that there is no developer with sufficient time to take a merge-master
role on a regular basis like that.

> 1. Some or all repo-per-category can be tracked with a simple script.
> 2. Maintainers could be - or not be - the same developers as today.
> Adding a layer of maintainers in charge of EAPI review (for example) up
> to the packages-maintainers could help in fixing a lot of portage issues
> and would avoid "simple developers" to do crap on the main repo(s) that
> users download.
You imply that there is a problem in that field already, which I
disagree with.

> > > One repo per category could be a good compromise assuming one seperate
> > > branch per package, then.
> > Other downsides to repo-per-category and repo-per-package:
> Let's forget a repo-per-package.
One downside unique to repo-per-category is that when a package moves
cross-category, you end up with it consuming space in packs on both
sides.

> > - Raises difficulty in adding a new package/category.=20
> >   You cannot just do 'mkdir && vi ... && git add && git commit' anymore.
> Right, but categories are not evolving that much.
There's demand to evolve them, but bulk package moves are painful with
CVS, so it's been waiting for Git.

> A repo-per-category local workflow would be:
> [...]
> $ git checkout package_one
> $ tree -a
> |-- .git
> |   |-- [...]
> |   [...]
> `-- package_one
>     |-- ChangeLog
>     |-- Manifest
>     |-- metadata.xml
>     |-- package_one-0.4.ebuild
>     `-- package_one-0.5.ebuild
Umm, why does package_two not exist in the other branch?
If package_one depends on package_two, and you're in for a world of fail
the moment it you changes branches here.

> > - Does NOT present a good base for anybody wanting to branch the entire
> >   tree themselves.
> Scriptable.
You dropped my cvsserver list item.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknZF+0ACgkQPpIsIjIzwizCGgCg7SMSYbA7saZhZKj66FCVyPh0
Rt8AoOj925m8S3xBapfnnx0WQEq6MbIN
=zr+k
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
