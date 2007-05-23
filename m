From: Timo Sirainen <tss@iki.fi>
Subject: Re: [PATCH 1/3] Added generic string handling code.
Date: Wed, 23 May 2007 13:49:46 +0300
Message-ID: <1179917386.32181.1643.camel@hurina>
References: <1179627869.32181.1284.camel@hurina>
	 <20070522134007.GK4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1qiQtJJv3aqwPBZwv+3o"
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 23 13:21:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqotr-0002e6-BT
	for gcvg-git@gmane.org; Wed, 23 May 2007 13:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509AbXEWLU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 07:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756441AbXEWLU6
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 07:20:58 -0400
Received: from dovecot.org ([82.118.211.50]:53337 "EHLO dovecot.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755885AbXEWLU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 07:20:58 -0400
X-Greylist: delayed 1868 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 May 2007 07:20:58 EDT
Received: from [192.168.10.2] (82-203-162-146.dsl.gohome.fi [82.203.162.146])
	by dovecot.org (Postfix) with ESMTP id 2617B1647218;
	Wed, 23 May 2007 13:49:47 +0300 (EEST)
In-Reply-To: <20070522134007.GK4489@pasky.or.cz>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48152>


--=-1qiQtJJv3aqwPBZwv+3o
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-22 at 15:40 +0200, Petr Baudis wrote:
> On Sun, May 20, 2007 at 04:24:29AM CEST, Timo Sirainen wrote:
> > diff --git a/str.c b/str.c
> > new file mode 100644
> > index 0000000..d46e7f4
> > --- /dev/null
> > +++ b/str.c
> > @@ -0,0 +1,40 @@
> > +#include "str.h"
> > +
> > +void _str_append(struct string *str, const char *cstr)
>=20
> _ is reserved namespace.

I remember __ is, but was _ too? A lot of programs are using that. :)

> > +{
> > +	unsigned int avail =3D str->size - str->len;
> > +	unsigned int len =3D strlen(cstr);
> > +
> > +	if (len >=3D avail) {
> > +		len =3D avail - 1;
> > +		str->overflowed =3D 1;
> > +	}
> > +	memcpy(str->buf + str->len, cstr, len);
> > +	str->len +=3D len;
> > +	str->buf[str->len] =3D '\0';
>=20
> You can copy len + 1 and avoid this assignment.

Not if the string overflowed.

> > +}
> > +
> > +void _str_printfa(struct string *str, const char *fmt, ...)
>=20
> printfA?

"append". I think I got it originally from glib:

/* These aliases are included for compatibility. */
#define g_string_sprintf g_string_printf
#define g_string_sprintfa g_string_append_printf

If there's a chance that this string handling code would get used, I
could write another patch with a bit clearer names and support for
dynamically growing strings too. Something like:

STATIC_STRING(name, 1234);
sstr_append(name, "hello"); // or static_str_append()?

struct string *dyn =3D str_new(1024); // initial length
str_append(dyn, "hello");


--=-1qiQtJJv3aqwPBZwv+3o
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGVBxKyUhSUUBViskRAmXlAKCTtqKLZr7z+dkllpAc5SX6khRyGACfVQp+
KYsKRFkzFuSloDn5pvodPK0=
=DzWY
-----END PGP SIGNATURE-----

--=-1qiQtJJv3aqwPBZwv+3o--
