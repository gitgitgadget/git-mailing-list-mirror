From: Keith Packard <keithp@keithp.com>
Subject: Re: Fix branch ancestry calculation
Date: Fri, 24 Mar 2006 08:38:58 -0800
Message-ID: <1143218338.6850.68.camel@neko.keithp.com>
References: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org>
	 <44240619.20103@dm.cobite.com>
	 <Pine.LNX.4.64.0603240739360.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QqxpXGymvMXrAwTr3IK8"
Cc: keithp@keithp.com, David Mansfield <centos@dm.cobite.com>,
	David Mansfield <cvsps@dm.cobite.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 24 17:39:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMpJx-00076a-Ut
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 17:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWCXQjZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 11:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWCXQjY
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 11:39:24 -0500
Received: from home.keithp.com ([63.227.221.253]:13324 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750926AbWCXQjY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 11:39:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id DB81A130020;
	Fri, 24 Mar 2006 08:39:21 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 20300-04-8; Fri, 24 Mar 2006 08:39:21 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id 6C43013001F; Fri, 24 Mar 2006 08:39:21 -0800 (PST)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 65BE514002;
	Fri, 24 Mar 2006 08:39:21 -0800 (PST)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id B19C06AC1E0; Fri, 24 Mar 2006 08:38:59 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603240739360.26286@g5.osdl.org>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17925>


--=-QqxpXGymvMXrAwTr3IK8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-03-24 at 07:46 -0800, Linus Torvalds wrote:
>=20
> On Fri, 24 Mar 2006, David Mansfield wrote:
> >=20
> > Anyway, I'd like to nail down some of the other nagging ancestry/branch=
 point
> > problems if possible.
>=20
> What I considered doing was to just ignore the branch ancestry that cvsps=
=20
> gives us, and instead use whatever branch that is closest (ie generates=20
> the minimal diff). That's really wrong too (the data just _has_ to be in=20
> CVS somehow), but I just don't know how CVS handles branches, and it's ho=
w=20
> we'd have to do merges if we were to ever support them (since afaik, the=20
> merge-back information simply doesn't exists in CVS).

cvsps is more of a problem than cvs itself. Per-file branch information
is readily available in the ,v files; each version has a list of
branches from that version, and there are even tags marking the names of
them. One issue that I've discovered is when files have differing branch
structure in the same repository. That happens when a branch is created
while files are checked out on different branches.  I'm not quite sure
what to do in this case; I've been trying several approaches and none
seem optimal. One remaining plan is to just attach such branches by
date, but that assumes that the first commit along a branch occurs
shortly after the branch is created (which isn't required).

Of course, this branch information is only created when a change is made
to the file along said branch, so most of the repository will lack
precise branch information for each branch. When you create a child
branch, the files with no commits in the parent branch will never get
branch information, so the child branch will be numbered as if it were a
branch off of the grandparent. Globally, it is possible to reconstruct
the entire branch structure.

> Suddenly it was a perfectly reasonable system: the fact that you can only=
=20
> merge once (between working tree and repo) is perfectly reasonable when=20
> there is only one branch and checking in requires you to have updated=20
> first. All the things I really hated about CVS just go away if you don't=20
> do any branches at all.

If you look at how deltas are stored in the file you get an even
stronger argument -- CVS has always advertised that it stores deltas
'backwards' so that the current version is first in the file. That's
true for the trunk, but for every other branch, you have to seek back
from the tip of the trunk to the branch point and then walk forwards to
the desired version along the branch.

--=20
keith.packard@intel.com

--=-QqxpXGymvMXrAwTr3IK8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEJCCiQp8BWwlsTdMRAoXQAKC0Y3bZtSlA0fdFhbNCWdKkgBsJFACgi4os
PoBRAS5R1DOkioLMkK1f1QY=
=+bjX
-----END PGP SIGNATURE-----

--=-QqxpXGymvMXrAwTr3IK8--
