From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/5] Make xstrndup common
Date: Sun, 29 Apr 2007 13:29:51 -0700
Message-ID: <4635003F.7080408@freedesktop.org>
References: Pine.LNX.4.64.0704281303371.28708@iabervon.org <46339819.8030007@freedesktop.org> <Pine.LNX.4.64.0704291416370.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF5FC4C6632333F632E59D787"
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 22:30:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiG2E-0003AP-Ui
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 22:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031384AbXD2U3z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 16:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031395AbXD2U3z
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 16:29:55 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:48390 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031384AbXD2U3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 16:29:53 -0400
Received: (qmail 16261 invoked from network); 29 Apr 2007 20:29:52 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <barkalow@iabervon.org>; 29 Apr 2007 20:29:52 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <Pine.LNX.4.64.0704291416370.28708@iabervon.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45835>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF5FC4C6632333F632E59D787
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Daniel Barkalow wrote:
> On Sat, 28 Apr 2007, Josh Triplett wrote:
>> Daniel Barkalow wrote:
>>> It was implemented in commit.c; move it with the other x memory funct=
ions.
>> [...]
>>> +static inline char *xstrndup(const char *str, int len)
>>> +{
>>> +	char *ret =3D xmalloc(len + 1);
>>> +	memcpy(ret, str, len);
>>> +	ret[len] =3D '\0';
>>> +	return ret;
>>> +}
>>> +
>> I don't know if it matters, but this definition of xstrndup, like the =
version
>> in commit.c, doesn't match the definition of strndup.  strndup duplica=
tes a
>> string, copying up to n characters or the length of the string.  This =
xstrndup
>> always copies n characters, reading past the end of the string if it d=
oesn't
>> have at least n characters.
>=20
> Good catch. Replacing the memcpy with strncpy solves this, right?=20
> (Potentially allocating a bit of extra memory if someone is actually us=
ing=20
> it on too short a string for some reason, of course).

That would work, but it seems bad to allocate excess memory.  How about j=
ust
using strlen and setting len to that if shorter, before doing the xmalloc=
 and
memcpy?  Yes, that makes two passes over the string, but I don't see any =
way
around that.

I just checked the glibc source for strndup, and it does exactly the same=

thing, except that it uses the glibc-specific function strnlen rather tha=
n
using strlen and figuring out the smaller of the two lengths.  That proba=
bly
increases efficiency if we have a string longer than, but we can't portab=
ly
use strnlen, so we'd have to check for it; doesn't seem worth the trouble=
=2E

- Josh Triplett


--------------enigF5FC4C6632333F632E59D787
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGNQA/GJuZRtD+evsRAqIHAKCDeyh72Smc53YlnugOicRJz4CsMwCfY0ZD
BkogJwbCgHcTUbIzDEOrX0A=
=SXp6
-----END PGP SIGNATURE-----

--------------enigF5FC4C6632333F632E59D787--
