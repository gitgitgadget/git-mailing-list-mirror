From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
	trees
Date: Sat, 14 Apr 2007 19:01:39 -0700
Message-ID: <20070415020139.GB2689@curie-int.orbis-terrarum.net>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <Pine.LNX.4.64.0704141019290.18655@racer.site> <20070415000330.GG3778@curie-int.orbis-terrarum.net> <Pine.LNX.4.63.0704141655390.31807@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 04:02:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hcu46-000658-Be
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 04:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbXDOCBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 22:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbXDOCBq
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 22:01:46 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:36788 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752029AbXDOCBp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 22:01:45 -0400
Received: (qmail 10165 invoked from network); 15 Apr 2007 02:01:44 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 15 Apr 2007 02:01:44 +0000
Received: (qmail 7484 invoked by uid 10000); 14 Apr 2007 19:01:39 -0700
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0704141655390.31807@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44482>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 14, 2007 at 05:02:47PM -0700, David Lang wrote:
> > - Shallow history checkouts are important to our low-bandwidth
> >  ebuild-tree developers (people in places with 33.6k modems, because
> >  the phone lines don't work well enough for 56k), or other high latency
> >  setups.
>  note that for people on low-bandwideth lines, makeing too shallow a chec=
kout=20
>  can actually end up costing more over time (they will have to pull full=
=20
>  revisions since they don't have the earlier versions to just pull a diff=
=20
>  against)
Yes, I'm aware that it may be more efficient over the long term for them
to pull given blocks, and I'm going to recommend that developers have a
full history anyway, but I suspect that they will still make heavy use
of shallow trees, esp. as some do throwaway trees often.
(This one is a moot point anyway, the shallow history support in Git is
pretty much done baring the bugs I posted about previously).

> > - Shallow tree (subtree) checkouts, for the developers that focus on
> >  specific portions of large modules and have no interest in the rest of
> >  the that tree. Eg. Releng does their work in gentoo/src/releng.
>  this could either be shallow tree or subproject, depending on how you en=
d up=20
>  orginizing things.
shallow tree, because we really do have people that check out arbitrary
sub-divisions (the web translation teams come to mind, they just have
checkouts of English and their own language), and going sub-project
would be insane for that.

> > - ACLs specific to subtree commits. Something similar to the cvs_acls.pl
> >  that FreeBSD uses would be great. Eg gentoo-x86/sec-policy/ is
> >  restricted to members of the security team (SELinux policies).
>  since git isn't designed with a single repository, it also doesn't need =
to=20
>  worry about acl's (in fact, i don't think it has the concept of permissi=
ons=20
>  at all). this is up to the people maintaining the 'master' repository to=
=20
>  pull from the right people
I should have mentioned that we aren't following the kernel model here.
All of the developers will have git+ssh access to the central tree, to
push their own changes to it. On a similar tangent, in some subtrees
(our documentation mainly) we have server-side validation tests before
the commit is accepted. The 'update' hook documentation suggests that
ACLs should be possible and implemented via that.

> > - CVS Keyword-like behavior, to specifically place the path and revision
> >  of certain files into the file directly, for ease of tracking when the
> >  file is removed from it's original surrounding. I know this one is
> >  going to draw some flack, but it's a very common practice for a user
> >  to copy a file out of the CVS tree, make some modifications, and then
> >  post the entire changed version up, esp. when the size of the changes
> >  exceeds the size of diff.
>  I'm not understanding why you need this. git tracks the file content, no=
t=20
>  the diffs betwen files. a developer does their work and git figures out =
when=20
>  you do a pull if it's better to send the file or a diff (and if you are=
=20
>  sending a diff, what you are doing the diff against, it may not be the f=
ile=20
>  that had that name before)
The tree that goes out to users is NOT git or CVS. What you point to
here is impossible unless we forced all of the users to migrate to git
(a truly herculean task if there was ever one).
It's a tarball or an rsync of an automatically managed CVS checkout.
(Tarballs go onto the release media, and are also widely used by those
that sneaker-net their trees to machines for security reasons).
Alternatively, the users browse the viewcvs, and pull something from the
Attic. Regardless of where they get the file from, the problem is that
the file doesn't contain any markers to help the developers merge it
back again.

A frequent occurrence of this is where the user takes rev X of a file
(because it was the latest one at the time), makes a local (non
version-controlled) copy, and submits it back our Bugzilla some months
down the line. Thanks to the $Header$ in the file he submits, we can
produce a diff against the original revision, and figure out how best to
merge it with the latest revision.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGIYeDPpIsIjIzwiwRApOEAKDsaOnRM+UiPfMAoiw5K+KUm/lR2gCdEFU9
CID4sV5xycoyo65tRGUlnI4=
=uOE2
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
