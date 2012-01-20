From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Rebase and incrementing version numbers
Date: Fri, 20 Jan 2012 16:53:47 +0100
Message-ID: <1327074827.31804.21.camel@centaur.lab.cmartin.tk>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
	 <CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
	 <1327000803.5947.59.camel@centaur.lab.cmartin.tk>
	 <CADo4Y9iJyirdkEr1GCg9BD5rwX9=1uKptqHsiWB0_MiDKb_wUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-mXnQz1irTqRuk5BqdRzI"
Cc: git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Fri Jan 20 16:53:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoGmp-0005Jm-HY
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 16:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab2ATPxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 10:53:49 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:56966 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753381Ab2ATPxr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 10:53:47 -0500
Received: from [192.168.1.17] (brln-4db9ca9c.pool.mediaWays.net [77.185.202.156])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id B6C20461C3;
	Fri, 20 Jan 2012 16:53:43 +0100 (CET)
In-Reply-To: <CADo4Y9iJyirdkEr1GCg9BD5rwX9=1uKptqHsiWB0_MiDKb_wUA@mail.gmail.com>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188883>


--=-mXnQz1irTqRuk5BqdRzI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-01-19 at 15:02 -0500, Michael Nahas wrote:
> I'm guessing here, but I believe the "version number" is used to make
> a directory on the production machine.  Thus, older versions of the
> javascript are available on the production machines under their older
> version number.  If there's an issue in production with the new
> version, code can be redirected to use the older version that is still
> in its directory.
>=20
> So it probably looks like:
> /100/js/<files>
> /101/js/<files>
> /103/js/<files>
> /104/js/<files>
>=20
> If something goes wrong with version 104, the admin can just tell the
> machine to use version 103 instead of 104.

So your team has developed a VCS to run on top of the VCS you're using.
This is a bit disconcerting. What's the point of svn if you're tracking
the versions manually? Rolling back changes is one of the things that
svn is there to help you with. There is no need for an extra layer.
Separating production-ready changes with experimental changes is what
branches are for.

=46rom the way you explain the development/deployment cycle, it doesn't
sound like any of the changes you dcommit should increase the version
number except for the last one. If you increase the version number three
times in one dcommit but you introduced the bug in the first of those,
now you have to manually go back and try each version, which seems
contrary to what the point of the scheme is.

   cmn

>=20
> You're right that incrementing this version number is probably not an
> issue for SVN users because they put N features in a single commit and
> they update the version number once.   With git, a user can put N
> features in N commits and changing the version number really belongs
> in each commit.  This makes rebasing suck.
>=20
>=20
> On Thu, Jan 19, 2012 at 2:20 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.de> =
wrote:
> > On Thu, 2012-01-19 at 12:20 -0500, Michael Nahas wrote:
> >> I'm at a new job and using Git-SVN at a place that is accustomed to SV=
N.
> >>
> >> The problem I'm running into is that whenever I change a file in a
> >> directory, I have to bump up the version number in the configuration
> >> file.  The larger version value in the config file causes my changes
> >> to be loaded over the old ones.
> >
> > Is this a deployment script that does this? Why can't it look at whethe=
r
> > files have changed? If a feature isn't ready for production, why is it
> > in a branch that gets deployed?
> >
> >>
> >> Most of my commits are edits to a file like "foo.js" and an increment
> >> to the version number in "config".  Ideally, each of my features
> >> should live in a single commit and I should be able to make a sequence
> >> of them, each time incrementing the version number in config.
> >>
> >
> > So if you've changed the file but don't increase the config file's
> > version, it means that the change isn't ready for production? If that's
> > the case, you've just implemented branches, poorly.
> >
> > Contrary to what apparently many people think, subversion does support
> > branches. Get your team to use them.
> >
> >> The problem I'm running into starts with me editing version=3D100.  I
> >> create new commits where I set the version to 101, 102, 103, 104.
> >> When I go to push ("git svn dcommit"), my coworkers have incremented
> >> the version to 103.  So, I rebase my changes, and get conflicts every
> >> time because of the version number!
> >
> > This sounds like a race condition that the svn users might be avoiding
> > by committing everything immediately. Sounds like a buggy development
> > process.
> >
> >>
> >> Is there a good way to avoid these conflicts?  Is there a hook I can
> >> write?  Is there a change to this process that would work smoother
> >> with Git and its distributed development?  It's okay if the version
> >> number skips numbers (e.g., jumps from 100 to 104), as long as it
> >> increases.
> >
> > You could write a merge driver that detects this situation and writes i=
n
> > a higher number, but it's all working around the fact that it's a race
> > condition.
> >
> >   cmn
>=20



--=-mXnQz1irTqRuk5BqdRzI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPGY4LAAoJEHKRP1jG7ZzTQlIH/R0plA59jtDHyTIdJltTahp6
JdhLfc4she7tSPncaM+m4CIL0yFNJ9hbeZgdr6+0Y/qWcwDIeD+nUzMosVUA7JiW
hHHaMcQTsmomulFG4E/b5lLgayj3xgJrWeDipvY8B7tE2x20wO7KWfD5Qd+C1cgD
LNEwtLJz48H28tpHAVmqBuYdoGBxmjy5T8g9btuuwsODuLAWUDSCzdM6abnWrlFm
rbqtXC6iTnExJ2B68PTLd6mVQKer3xasRkcrNPk316EI3uSTtQp26jK+mdXW5R6E
balj4rY/Rfjpoi+TiSw3LFvRxgnyC+GfCvevNpWx7PPhgUZi1COCgCKbHjsYFp0=
=RSTj
-----END PGP SIGNATURE-----

--=-mXnQz1irTqRuk5BqdRzI--
