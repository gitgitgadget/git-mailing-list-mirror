From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v3] am: invoke perl's strftime in C locale
Date: Sun, 20 Jan 2013 00:28:53 +0400
Message-ID: <20130119202853.GD1652@altlinux.org>
References: <20130114205933.GA25947@altlinux.org> <20130115155953.GB21815@sigill.intra.peff.net> <CALWbr2w+q5=Z8__g+J_s2NtTMgziHrntFqsi8vCJyvfO2qi81A@mail.gmail.com> <20130115165058.GA29301@sigill.intra.peff.net> <20130115174015.GA7471@altlinux.org> <20130115190517.GB7963@altlinux.org> <7vehhiqlcx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Cc: Jeff King <peff@peff.net>, Antoine Pelisse <apelisse@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 21:29:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twf2W-0001uA-1O
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 21:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab3ASU2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 15:28:55 -0500
Received: from vint.altlinux.org ([194.107.17.35]:41516 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab3ASU2y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 15:28:54 -0500
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 3F682226C0BA;
	Sat, 19 Jan 2013 20:28:53 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 2E4D7519000D; Sun, 20 Jan 2013 00:28:53 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <7vehhiqlcx.fsf@alter.siamese.dyndns.org>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213986>


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2013 at 12:36:46PM -0800, Junio C Hamano wrote:
> "Dmitry V. Levin" <ldv@altlinux.org> writes:
>=20
> > This fixes "hg" patch format support for locales other than C and en_*.
> > Before the change, git-am was making "Date:" line from hg changeset
> > metadata according to the current locale, and this line was rejected
> > later with "invalid date format" diagnostics because localized date
> > strings are not supported.
> >
> > Reported-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >
> >  v3: alternative implementation using setlocale(LC_TIME, "C")
> >
> >  git-am.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/git-am.sh b/git-am.sh
> > index c682d34..8677d8c 100755
> > --- a/git-am.sh
> > +++ b/git-am.sh
> > @@ -334,7 +334,8 @@ split_patches () {
> >  			# Since we cannot guarantee that the commit message is in
> >  			# git-friendly format, we put no Subject: line and just consume
> >  			# all of the message as the body
> > -			perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject =3D 0 }
> > +			perl -M'POSIX qw(strftime :locale_h)' -ne '
> > +				BEGIN { setlocale(LC_TIME, "C"); $subject =3D 0 }
>=20
> I still haven't convinced myself that this is an improvement over
> the simple "LC_ALL=3DC LANG=3DC perl ..." approach.

Personally I prefer 2nd edition that is simpler and does the right thing
(not that LC_ALL=3DC is necessary and sufficient, you neither need to add
things like LANG=3DC nor can relax it to LC_TIME=3DC).


--=20
ldv

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlD7AgUACgkQfKvmrJ41Nh5WIgCgnzaWJQq9j0X7p8Ijhulm7PnB
4z4AnR51jNPxpCgG0noFL+ByCNm4N+6H
=Q5tz
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
