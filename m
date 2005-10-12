From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Add '--create-index' to git-unpack-objects
Date: Wed, 12 Oct 2005 18:55:48 +0400
Message-ID: <20051012145548.GA2539@master.mivlgu.local>
References: <Pine.LNX.4.63.0510121301340.30679@wbgn013.biozentrum.uni-wuerzburg.de> <20051012173426.56fd5c1c.vsu@altlinux.ru> <Pine.LNX.4.63.0510121612340.6307@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 12 16:58:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPi1q-0005zS-DQ
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 16:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVJLOzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 10:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVJLOzu
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 10:55:50 -0400
Received: from mivlgu.ru ([81.18.140.87]:58753 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S964799AbVJLOzu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 10:55:50 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id 581B918010F; Wed, 12 Oct 2005 18:55:48 +0400 (MSD)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510121612340.6307@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10032>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2005 at 04:25:22PM +0200, Johannes Schindelin wrote:
> On Wed, 12 Oct 2005, Sergey Vlasov wrote:
> > Saving unpacked objects in memory would obviously be unacceptable.
>=20
> Actually, this is what git-unpack-objects does. All unresolved deltas are=
=20
> stored in a linked list, and handled later.

Yes, this may be a problem if the pack is large and contains many
deltas.  But these stored deltas are thrown away immediately when the
base object is found; if you want to implement a streaming reindex,
you will need to store them until you reach the end of pack (or write
those objects to some temporary files).

> Of course, it would be nicer to use a seekable file if you have one. But=
=20
> then, I am not at all sure that base objects should be allowed to come=20
> later in the file: since the delta chains must not be cyclic, the objects
> can be sorted. Thus, it could be guaranteed that the base objects are=20
> already unpacked when unpacking the derived object.

Hmm, pack-objects.c:write_one() does exactly the opposite - it writes
the base object _after_ writing out the delta (but it does not ensure
that ordering completely, so references to base objects can be
pointing in both directions).  Why?

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDTSP0W82GfkQfsqIRAms5AJ91GSQoGHY3IpF5EhEESwGlvM9KhgCbBjwf
uf8p5vOTUarJWh76awZ0610=
=9OeS
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
