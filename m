From: Martin Uecker <muecker@gmx.de>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree performance problems)
Date: Wed, 20 Apr 2005 15:24:47 +0200
Message-ID: <20050420132446.GA10126@macavity>
References: <200504191250.10286.mason@suse.com> <200504191708.23536.mason@suse.com> <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org> <200504192049.21947.mason@suse.com> <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <42660708.60109@zytor.com> <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org> <2cfc403205042005116484231c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
X-From: git-owner@vger.kernel.org Wed Apr 20 15:23:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOF9m-0002Ek-3j
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 15:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVDTN0Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 09:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVDTN0Y
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 09:26:24 -0400
Received: from dialin-145-254-146-086.arcor-ip.net ([145.254.146.86]:50304
	"EHLO macavity") by vger.kernel.org with ESMTP id S261619AbVDTN0P
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 09:26:15 -0400
Received: from martin by macavity with local (Exim 4.34)
	id 1DOFCB-0002mM-1M
	for git@vger.kernel.org; Wed, 20 Apr 2005 15:24:47 +0200
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Martin Uecker <muecker@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2cfc403205042005116484231c@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2005 at 10:11:10PM +1000, Jon Seymour wrote:
> On 4/20/05, Linus Torvalds <torvalds@osdl.org> wrote:
> >=20
> >=20
> > I converted my git archives (kernel and git itself) to do the SHA1 hash
> > _before_ the compression phase.
> >=20
>=20
> Linus,
> =20
>  Am I correct to understand that with this change, all the objects in
> the database are still being compressed (so no net performance benefit
> now), but by doing the SHA1 calculations before compression you are
> keeping open the possibility that at some point in the future you may
> use a different compression technique (including none at all) for some
> or all of the objects?

The main point is not about trying different compression
techniques but that you don't need to compress at all just
to calculate the hash of some data. (to know if it is
unchanged for example)

There are still some other design decisions I am worried
about:

The storage method of the database of a collection of
files in the underlying file system. Because of the
random nature of the hashes this leads to a horrible
amount of seeking for all operations which walk the
logical structure of some tree stored in the database.

Why not store all objects linearized in one or more
flat file?


The other thing I don't like is the use of a sha1
for a complete file. Switching to some kind of hash
tree would allow to introduce chunks later. This has
two advantages:

It would allow git to scale to repositories of large
binary files. And it would allow to build a very cool
content transport algorithm for those repositories.
This algorithm could combine all the advantages of
bittorrent and rsync (without the cpu load).


And it would allow trivial merging of patches which
apply to different chunks of a file in exact the same
way as merging changesets which apply to different
files in a tree.


Martin

--=20
One night, when little Giana from Milano was fast asleep,
she had a strange dream.


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCZlgeYDJInvULMKYRAi4wAJ9IIP4OTkb1XlBGvc9mt/fGxLFRWQCfTyaT
KHOoR0sMLc79myGyELHiIXM=
=ZjMt
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
