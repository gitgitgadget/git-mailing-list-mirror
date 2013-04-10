From: "W. Trevor King" <wking@tremily.us>
Subject: Re: regression:
 "96b9e0e3 config: treat user and xdg config permission problems as errors"
 busted git-daemon
Date: Wed, 10 Apr 2013 09:56:05 -0400
Message-ID: <20130410135605.GB4694@odin.tremily.us>
References: <1365572015.4658.51.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=GID0FwUMdk1T2AWN
Cc: git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Mike Galbraith <bitbucket@online.de>
X-From: git-owner@vger.kernel.org Thu Apr 11 02:46:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ5fA-0006h6-J4
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 02:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935269Ab3DKAqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 20:46:48 -0400
Received: from vms173007pub.verizon.net ([206.46.173.7]:47425 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934600Ab3DKAqr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 20:46:47 -0400
X-Greylist: delayed 3605 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Apr 2013 20:46:47 EDT
Received: from odin.tremily.us ([unknown] [72.68.100.81])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ML200LP0CPTZU30@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 10 Apr 2013 18:46:42 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 8699794D16C; Wed,
 10 Apr 2013 09:56:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1365602165; bh=yaXjuMADI6iLC5wULFKWA9EEW211yII9K8SqfLv+fns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a7X+6T5sQ1J6fN77isU3HYQ9xhphHaBsUOcBrS/m3iolO0T31i7rtOFiRq2phES0n
 xwtxAU/DR7mDbbie54Y6yPQxsOswhL/jXptYk752JvJGXBLAnhle6Ub7So1FECcuqL
 T17SGOFULRYsWm4Wqbg8fS0dEzL8LCTBDzkOm6Gc=
Content-disposition: inline
In-reply-to: <1365572015.4658.51.camel@marge.simpson.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220799>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2013 at 07:33:35AM +0200, Mike Galbraith wrote:
> /usr/lib/git/git-daemon --syslog --detach --reuseaddr --user=3Dgit --grou=
p=3Ddaemon --pid-file=3D/var/run/git-daemon.pid --export-all --user-path --=
enable=3Dreceive-pack
>=20
> Try to pull as root or normal user results in:
>=20
> [pid 26786] access("/root/.config/git/config", R_OK) =3D -1 EACCES (Permi=
ssion denied)
> [pid 26786] write(2, "fatal: unable to access '/root/."..., 70) =3D 70
> [pid 26785] <... read resumed> "fatal: unable to access '/root/."..., 409=
6) =3D 70
> [pid 26786] exit_group(128)
>=20
> Bisection fingered this commit, though it looks like it's really due to
> not forgetting who it was at birth.  It's not root, so has no business
> rummaging around in /root.  It used to not care, but this commit made
> "go away" while looking for non-existent config file terminal.

I ran into this too, although I'm running git-daemon via spawn-fcgi.
In order to convince newer Gits that you know what you're doing, you
just need to set HOME to somewhere Git can look.  For example:

  HOME=3D/ /usr/lib/git/git-daemon =E2=80=A6

should work.  On Gentoo, I added the following to
/etc/conf.d/spawn-fcgi.fcgiwrap:

  ALLOWED_ENV=3D"PATH HOME"
  HOME=3D/

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRZW90AAoJEEUbTsx0l5OMxrcQAJatAwwwVmDrsAWcgP/X0aJR
2X0b+SakfpyShYYN9jO6PpJX5tTBFcZfh4hnOdp7l55LfoDTsorHgYpEfWydZiIk
MJGE72h5LByUeaeIE5i912/+OzXD5qokpCDxLmAJkSvWxLvWJBNpN7gktrmnhp3n
qQ8JNdIAo95sO8kgQbEe7kMXcaBRA9YDL64QtHPQbSP6cWSHITDmj/gi+UBnA8nW
xbo1kCZIJQmDM7XyskLvSBgHUNCwKLxgaq65WL1ROgjKOlQVPjPcesR+MXytid1/
SeBbeuQ1bwqf48g7lhKhMeXwcvYMH9puDqn5HrYJYRM0zO7iYgW+OnAm4pf6Y+X0
icYCxd7uwtqruxPpJICM2vf5sAAs78e+FdOwDGWFT08WYMDo1Taf6SWXnoemE5yd
Gn+d+RpRmNmE3yeo2MzzgADJhRgGRH+xd7uBrS/TEhnzt9mLFu8xh39FLdLalzMB
Z3sGzOz8/gVn2IZ2Z9jC95BloOW+tnIGLwyGQu5kzsNNoqjzvzlb0r6R5iQki3XY
hN9xmtnMfFJXBZQ7rLD+uUbB4IjL3YL4jwOsCwVZsN+pdqy3jMJwC7nSXYvY8USL
y9Jm0qqcW+Vky1hS05BH+dkqEn8GmHpe98SH3wYDLjLz5eI6TOEQprlrDFSeYg++
VigByUH1o548rs108myT
=Y0KM
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
