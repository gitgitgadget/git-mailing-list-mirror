From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Remove unneeded packs
Date: Sun, 13 Nov 2005 15:20:18 +0300
Message-ID: <20051113122017.GA9996@procyon.home>
References: <1131800663.29461.11.camel@blade> <4375EA80.7070405@op5.se> <1131802238.29461.18.camel@blade> <43766687.2000007@etek.chalmers.se> <7voe4pclwm.fsf@assigned-by-dhcp.cox.net> <43771C43.7000104@etek.chalmers.se> <20051113150051.4a10365d.vsu@altlinux.ru> <43772C96.9030805@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 13 13:21:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbGqk-0002U9-LH
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 13:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVKMMUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 07:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVKMMUg
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 07:20:36 -0500
Received: from master.altlinux.ru ([62.118.250.235]:17415 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932489AbVKMMUg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 07:20:36 -0500
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id 7688CE3644; Sun, 13 Nov 2005 15:20:30 +0300 (MSK)
Received: by procyon.home (Postfix, from userid 500)
	id 131A3E385D3; Sun, 13 Nov 2005 15:20:18 +0300 (MSK)
To: Lukas Sandstr?m <lukass@etek.chalmers.se>
Content-Disposition: inline
In-Reply-To: <43772C96.9030805@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11737>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 13, 2005 at 01:07:50PM +0100, Lukas Sandstr?m wrote:
> Sergey Vlasov wrote:
> > On Sun, 13 Nov 2005 11:58:11 +0100 Lukas Sandstr?m wrote:

> >>-if test "$remove_redandant" =3D t
> >>+if test "$all_into_one" =3D t
> >=20
> >=20
> > This should be
> >=20
> > if test "$all_into_one$remove_redandant" =3D tt
> >=20
> > (otherwise "git repack -a" becomes the same as "git repack -a -d").
> >=20
> >=20
>=20
> This was the behaviour before git-pack-redundant, I just restored it.

But the old code was:

if test "$remove_redandant" =3D t
then
	# We know $existing are all redandant only when
	# all-into-one is used.
	if test "$all_into_one" !=3D '' && test "$existing" !=3D ''
	then
		sync
		( cd "$PACKDIR" &&
		  for e in $existing
		  do
			case "$e" in
			./pack-$name.pack | ./pack-$name.idx) ;;
			*)	rm -f $e ;;
			esac
		  done
		)
	fi
fi

So without the -d option nothing was removed, even with -a.

(And test "$existing" !=3D '' might also be needed for some shells which
are confused by the empty list in the for statement.)

> Someone else gets to decide if git repack -a implies "remove all old pack=
s".

If there is a separate -d option for this, just using -a probably
should not remove anything.

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDdy+BW82GfkQfsqIRAqQIAJ93qEsA2Qfdb9jq1yv1CZfRKFsdBwCfQmCm
K5sjjnyuiWVeYakXEFRRT64=
=r0W1
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
