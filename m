From: "Stefan (metze) Metzmacher" <metze@samba.org>
Subject: git fetch-pack can't fetch refs/stash
Date: Thu, 29 Apr 2010 12:24:51 +0200
Message-ID: <4BD95E73.6040709@samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2CCC0FE877D673F3DA86CB7E"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 06:00:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O83sY-0000SK-Io
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 06:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341Ab0EADnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 23:43:18 -0400
Received: from mo-p05-fb.rzone.de ([81.169.146.183]:50441 "EHLO
	mo-p05-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061Ab0EADnS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 23:43:18 -0400
X-Greylist: delayed 28804 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Apr 2010 23:43:17 EDT
Received: from mo-p05-ob.rzone.de (fruni-mo-p05-ob.mail [192.168.63.151])
	by scum-fb-07.store (RZmta 23.1) with ESMTP id G04690m3T970HU
	for <git@vger.kernel.org>; Thu, 29 Apr 2010 13:42:40 +0200 (MEST)
X-RZG-AUTH: :IWkQb0WIdvqIIwNfJfyiKBgoQwjwNKmLapmn/F6ALVwAJybeifhgoaZxMGw53LM=
X-RZG-CLASS-ID: mo05
Received: from [172.30.252.2]
	(xdsl-195-14-204-133.netcologne.de [195.14.204.133])
	by post.strato.de (fruni mo48) (RZmta 23.0)
	with ESMTP id R01029m3T9i0Ok for <git@vger.kernel.org>;
	Thu, 29 Apr 2010 12:25:04 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
X-Enigmail-Version: 0.95.7
OpenPGP: id=0E53083F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146075>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2CCC0FE877D673F3DA86CB7E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I tried to fetch refs/stash from my repository (for backup),
however 'git fetch myremote +refs/stash:refs/remotes/myremote/stash'
just fails with $? =3D 1 (without any output).

That's confusing because 'git ls-remote myremote' shows refs/stash.

After some debugging I found the reason for the problem.

'git fetch-pack /path/to/myremote refs/stash' also just returns
$? =3D 1.

filter_refs() skips 'refs/stash', because check_ref_format()
returns CHECK_REF_FORMAT_ONELEVEL.

Is that a bug or a feature?

The easiest fix would be to allow CHECK_REF_FORMAT_ONELEVEL to pass in
the same way as CHECK_REF_FORMAT_OK. But I'm not sure if that would
have other side effects.

For now I work around it by doing:
'mkdir stash.d; cd stash.d; ln -s ../stash .'
and use
git fetch myremote +refs/stash.d/stash:refs/remotes/myremote/stash

metze


--------------enig2CCC0FE877D673F3DA86CB7E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkvZXnYACgkQm70gjA5TCD9SDwCfRKL8yiA5LHVDz0Wl1wUyPWNd
6LUAoJxCm11+ZVCU8OMd3CUttVsuYm0P
=f81t
-----END PGP SIGNATURE-----

--------------enig2CCC0FE877D673F3DA86CB7E--
