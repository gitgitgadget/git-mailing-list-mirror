From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Sun, 4 May 2008 14:52:58 +0200
Message-ID: <20080504125258.GA3399@alea.gnuu.de>
References: <7v63u05khw.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness> <7v1w4o3zle.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300938190.17469@eeepc-johanness> <7vr6cn1yzk.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804301253520.2136@eeepc-johanness> <7vy76tyhfd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805031340550.30431@racer> <7vtzhfuxfd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805041032070.30431@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 04 15:09:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsdxw-0006Zk-Mx
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 15:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYEDNIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 09:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbYEDNIa
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 09:08:30 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1562 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbYEDNI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 09:08:29 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 7CB7848804E; Sun,  4 May 2008 15:08:27 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jsdi7-00089T-50; Sun, 04 May 2008 14:52:59 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jsdi6-0002dc-JM; Sun, 04 May 2008 14:52:58 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805041032070.30431@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81174>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Johannes Schindelin schrieb am Sun 04. May, 10:38 (+0100):
> 	pick 1234567 Clean up rebase -i -p
> 	tag cleanup
> 	...
> 	merge 2345678 cleanup master
>=20
> Yes, you read that correctly, I think that allowing plain ref names is=20
> very valuable.  AFAICT my original implementation allows that (dunno abou=
t=20
> the current code).

Your code is still used and you can do things like:

merge abc --strategy=3DYOUR_STRATEGY master 022ef38 my_tag

And I think it's really easy to do a git-describe for each ref that is not
marked of reset and merge commands

=46rom fec670a4dc6fdf484a197687db5fbd0a4f668449 Mon Sep 17 00:00:00 2001
=46rom: =3D?utf-8?q?J=3DC3=3DB6rg=3D20Sommer?=3D <joerg@alea.gnuu.de>
Date: Sun, 4 May 2008 14:52:01 +0200
Subject: [PATCH] Use names instead of sha1 ID for reset and merge if possib=
le
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

Sometimes it's much more helpful to see the name of a branch or a tag as
the argument of a merge or reset command.

Signed-off-by: J=F6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2a01182..2bd858c 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -493,6 +493,10 @@ create_extended_todo_list () {
 			if tmp=3D$(get_value_from_list $args "$commit_mark_list")
 			then
 				args=3D":$tmp"
+			elif tmp=3D$(git describe --all --exact-match $args \
+				2>/dev/null)
+			then
+				args=3D"$tmp"
 			fi
 			;;
 		merge)
@@ -503,6 +507,10 @@ create_extended_todo_list () {
 					"$commit_mark_list")
 				then
 					new_args=3D"$new_args :$tmp"
+				elif tmp=3D$(git describe --all --exact-match \
+					$i 2>/dev/null)
+				then
+					new_args=3D"$new_args $tmp"
 				else
 					new_args=3D"$new_args $i"
 				fi
--=20
1.5.5.1

Bye, J=F6rg.
--=20
Diskutiere nie mit einem Idioten:
Sie ziehen Dich auf ihr Niveau herab und schlagen Dich dann mit
Erfahrung.

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIHbGqwe0mZwH1VIARAjdwAKC4dO/DmwoVqIo1FinmWBRlVgNkjACfbCdq
lg3wQn7fW0ZPkI5MwUDp8hs=
=nVAY
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
