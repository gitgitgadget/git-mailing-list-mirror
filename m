From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] am: invoke perl's strftime in C locale
Date: Tue, 15 Jan 2013 21:40:16 +0400
Message-ID: <20130115174015.GA7471@altlinux.org>
References: <20130114205933.GA25947@altlinux.org> <20130115155953.GB21815@sigill.intra.peff.net> <CALWbr2w+q5=Z8__g+J_s2NtTMgziHrntFqsi8vCJyvfO2qi81A@mail.gmail.com> <20130115165058.GA29301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 15 18:40:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvAV9-0004OR-AZ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 18:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756626Ab3AORkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 12:40:20 -0500
Received: from vint.altlinux.org ([194.107.17.35]:41004 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab3AORkR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 12:40:17 -0500
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 2A4023F80240;
	Tue, 15 Jan 2013 17:40:16 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 11B24519000D; Tue, 15 Jan 2013 21:40:16 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <20130115165058.GA29301@sigill.intra.peff.net>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213654>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2013 at 08:50:59AM -0800, Jeff King wrote:
> On Tue, Jan 15, 2013 at 05:42:12PM +0100, Antoine Pelisse wrote:
>=20
> > > This puts all of perl into the C locale, which would mean error messa=
ges
> > > from perl would be in English rather than the user's language. It
> > > probably isn't a big deal, because that snippet of perl is short and =
not
> > > likely to produce problems, but I wonder how hard it would be to set =
the
> > > locale just for the strftime call.
> >=20
> > Maybe just setting LC_TIME to C would do ...
>=20
> Yeah, that is a nice simple solution. Dmitry, does just setting LC_TIME
> fix the problem for you?

Just setting LC_TIME environment variable instead of LC_ALL would end up
with unreliable solution because LC_ALL has the highest priority.

If keeping error messages from perl has the utmost importance, it could be
achieved by
-			perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject =3D 0 }
+			perl -M'POSIX qw(strftime :locale_h)' -ne '
+				BEGIN { setlocale(LC_TIME, "C"); $subject =3D 0 }
but the little perl helper script we are talking about hardly worths so
much efforts.


--=20
ldv

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlD1lH8ACgkQfKvmrJ41Nh6zkgCfQcXzo7oabgSdcIlpBqwkdb1H
wgEAn12PYmFQZEDs8pOdCpRac6e7VUDt
=5B/K
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
