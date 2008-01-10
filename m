From: Pierre Habouzit <madcoder@artemis.madism.org>
Subject: Re: [PATCH] bundle, fast-import: detect write failure
Date: Thu, 10 Jan 2008 17:25:26 +0100
Message-ID: <20080110162526.GB27808@artemis.madism.org>
References: <874pdmhxha.fsf@rho.meyering.net> <alpine.LSU.1.00.0801101204120.31053@racer.site> <87myrdhnn5.fsf@rho.meyering.net> <alpine.LSU.1.00.0801101234580.31053@racer.site> <87hchlhm3k.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oLBj+sq0vYjzfsbl";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 17:26:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD0EC-0006hv-Dv
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 17:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238AbYAJQZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 11:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756182AbYAJQZa
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 11:25:30 -0500
Received: from pan.madism.org ([88.191.52.104]:51291 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504AbYAJQZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 11:25:29 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1A00F2E4DD;
	Thu, 10 Jan 2008 17:25:28 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id ECD2E145FE6; Thu, 10 Jan 2008 17:25:26 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@artemis.madism.org>,
	Jim Meyering <jim@meyering.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87hchlhm3k.fsf@rho.meyering.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70075>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2008 at 01:00:15PM +0000, Jim Meyering wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Are you aware what this code does?  It writes a ".keep" file.  Whose
> > purpose is to _exist_, and whose purpose is fulfilled, even if the write
> > or the push-back did not succeed.
>=20
> Hi,
>=20
> I do see what you mean.
>=20
> If the write is not necessary, then perhaps you would prefer a comment
> documenting that failures of the write and following close are ignorable.
> And add a '(void)' stmt prefix, to tell compilers that ignoring the
> return value is deliberate.

  Note that (void) isn't enough with the most recent gcc flavours, which
is a pain. I do use:

#define IGNORE(expr)  do { if (expr) (void)0; } while (0)

for that purpose in my code. I know IGNORE isn't a brilliant name, but
it's modeled after the ocaml function doing the same thing.

> However, even if it's not technically required to fail at that point,
> if it were my choice, I'd prefer to know when a .keep file whose
> contents are unimportant just happens to reside on a bad spot on my
> disk.  I/O errors should never be ignored.

  Actually I think .keep files are empty, so the write() should not be
there in the first place, and we should only check for close() right ?
not that it matters that much.

> > I could not care less what the manual says.  What is important is if the
> > defensive programming is done mindlessly, and therefore can fail so not
> > gracefully.
>=20
> On the other hand, if that write failure is truly ignorable,
> a mindless minimalist :-) might argue that it's best just to
> omit the syscall.

  And leak a file descriptor :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHhkb2vGr7W6HudhwRAv6UAKCcYLGOiJkWEBQ0uMNAc9uTLP8y/QCeP9ne
cInWNOI+6mswA6runBF/aqc=
=X4HF
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
