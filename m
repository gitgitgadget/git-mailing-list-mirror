From: Max Horn <max@quendi.de>
Subject: Re: What's cooking in git.git (Feb 2014, #06; Wed, 19)
Date: Thu, 20 Feb 2014 19:39:14 +0100
Message-ID: <BCF58F31-7130-4F4B-BE53-D917C4D50D96@quendi.de>
References: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_C2BD2A2C-6CFD-4A5C-B11E-8E0BBF1AB16F"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 20:05:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGYw7-0003ep-TA
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 20:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431AbaBTTF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 14:05:28 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:40489 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754700AbaBTTF1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Feb 2014 14:05:27 -0500
X-Greylist: delayed 1571 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Feb 2014 14:05:26 EST
Received: from vpn-1-allg-03.hrz.uni-giessen.de ([134.176.250.3]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WGYWf-0005pa-FV; Thu, 20 Feb 2014 19:39:13 +0100
In-Reply-To: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1392923127;9ce0b41f;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242440>


--Apple-Mail=_C2BD2A2C-6CFD-4A5C-B11E-8E0BBF1AB16F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 19.02.2014, at 22:41, Junio C Hamano <gitster@pobox.com> wrote:

> * fc/transport-helper-fixes (2013-12-09) 6 commits
> - remote-bzr: support the new 'force' option
> - test-hg.sh: tests are now expected to pass
> - transport-helper: check for 'forced update' message
> - transport-helper: add 'force' to 'export' helpers
> - transport-helper: don't update refs in dry-run
> - transport-helper: mismerge fix
>=20
> Updates transport-helper, fast-import and fast-export to allow the
> ref mapping and ref deletion in a way similar to the natively
> supported transports.
>=20
> Reported to break t5541, and has been stalled for a while without
> fixes.
>=20
> Will discard.

Since I somewhat care about transport-helpers, I had a closer look at =
this failure. Torsten already narrowed it down to f9e3c6bebb89de12 =
(transport-helper: check for 'forced update' message).

Looking at that commit, the problem is the new line

   (*ref)->forced_update =3D forced;

which is supposed to set forced_update to 1 in certain cases; but the =
code which sets "forced =3D 1" ever triggered (at least in my limited =
tests). Worse, it seems forced_update can be set to 1 before we ever get =
there, and in these casss, we end up reseting forced_update from 1 back =
to 0. This triggers the test failure.

So a simple fix for the test failure is to drop that patch. Another =
would be to change the assignment to

   (*ref)->forced_update |=3D forced;

But I haven't spent enough time to look at the patch to determine if one =
of these two possible changes is correct. All I can say is that dropping =
that single commit fixes the test failure for me and seems to cause now =
new failures.


Cheers,
Max

--Apple-Mail=_C2BD2A2C-6CFD-4A5C-B11E-8E0BBF1AB16F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlMGS9YACgkQIpJVslrhe1nwpwD+JOCUxnGdy950QTlL1LK0BDok
1HSwH0cWsgzPsJb+T1AA/2ROaId8/CRsACrVPbXwIyDmgPwodOdFlr3FKT79q+C+
=9qC9
-----END PGP SIGNATURE-----

--Apple-Mail=_C2BD2A2C-6CFD-4A5C-B11E-8E0BBF1AB16F--
