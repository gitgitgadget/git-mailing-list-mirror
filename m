From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH 1/8] fetch.c: Remove useless lookup_object_type() call in process()
Date: Thu, 22 Sep 2005 12:50:09 +0400
Message-ID: <20050922085009.GC20944@master.mivlgu.local>
References: <20050921161829.GA20944@master.mivlgu.local> <20050921161855.896F1E010FC@center4.mivlgu.local> <7v3bnyurw6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 10:52:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIMmd-0005Fu-CV
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 10:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbVIVIuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 04:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVIVIuU
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 04:50:20 -0400
Received: from mivlgu.ru ([81.18.140.87]:9446 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751453AbVIVIuT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 04:50:19 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id F052C180110; Thu, 22 Sep 2005 12:50:09 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bnyurw6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9096>


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2005 at 12:45:13PM -0700, Junio C Hamano wrote:
> Sergey Vlasov <vsu@altlinux.ru> writes:
>=20
> > In all places where process() is called except the one in pull() (which
> > is executed only once) the pointer to the object is already available,
> > so pass it as the argument to process() instead of sha1 and avoid an
> > unneeded call to lookup_object_type().
>=20
> Agreed, except we probably would want to pass the expected type
> to process() so that we can make sure the object is of that type,
> perhaps?

This is not needed - all parse_*_buffer() functions, which fill in
pointers to referenced objects, specify required types themselves by
using lookup_commit(), lookup_tree(), etc.; even parse_tag_buffer()
uses lookup_object_type().

The only way to get a "struct object" with an unspecified type is by
calling lookup_unknown_object() (or lookup_object_type() with NULL
type) - grep shows than nothing in GIT does this, except the pull()
function in fetch.c (which obviously does not know type of the object
to be fetched in advance).

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDMnBBW82GfkQfsqIRAstFAJwK6aXCrIU2GTIUNxF2R7YvyZgnOACgjALX
68OITJNC1DOTmDQ7hMOvKyA=
=Jr4y
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
