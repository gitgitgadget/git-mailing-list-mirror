From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Fri, 11 Jan 2008 09:57:35 +0100
Message-ID: <20080111085735.GB20141@artemis.madism.org>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home> <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org> <alpine.LFD.1.00.0801101613050.3054@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="4SFOXa2GPu3tIq4H";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 09:58:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDFiZ-0003Qp-R3
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 09:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448AbYAKI5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 03:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758231AbYAKI5j
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 03:57:39 -0500
Received: from pan.madism.org ([88.191.52.104]:58130 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756887AbYAKI5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 03:57:38 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 88AE62E6E8;
	Fri, 11 Jan 2008 09:57:36 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id D63B21BA92; Fri, 11 Jan 2008 09:57:35 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801101613050.3054@xanadu.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70138>


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2008 at 09:30:59PM +0000, Nicolas Pitre wrote:
> On Thu, 10 Jan 2008, Linus Torvalds wrote:
>=20
> >=20
> >=20
> > On Thu, 10 Jan 2008, Nicolas Pitre wrote:
> > >=20
> > > Here's my rather surprising results:
> > >=20
> > > My kernel repo pack size without the patch:	184275401 bytes
> > > Same repo with the above patch applied:		205204930 bytes
> > >=20
> > > So it is only 11% larger.  I was expecting much more.
> >=20
> > It's probably worth doing those statistics on some other projects.
> >=20
> > Maybe the difference to other repositories isn't huge, and maybe the=20
> > kernel *is* a good test-case, but I just wouldn't take that for granted=
=2E=20
>=20
> Obviously.
>=20
> This was a really crud test, and my initial goal was to quickly dismiss=
=20
> Pierre's assertion.  Turns out that he wasn't that wrong after all,

  Well that wasn't a random assertion, I made it, because I assumed that
a delta is usually less than a few hundred bytes, and as compression is
applied only to the delta without context, you end up packing 500 bytes
per 500 bytes which will seldomly have excellent compression ratios.

> and=20
> if a significant increase in access speed by avoiding zlib for 82% of=20
> object accesses can also be demonstrated for the kernel, then we have an=
=20
> opportunity for some optimization tradeoff with no backward=20
> compatibility concerns.

  Well, one could use the fact that deltas are not packed to avoid
copying them around, and that will _necessarily_ become a gain (you can
read them where they have been mmapped for instance). The number that
were given for git annotate use a compression of `0' which doesn't use
that fact, and I wouldn't be surprised to see a noticeable gain if one
does that.

  And actually, maybe that it's not the deltas we should not pack, but
objects under a certain size (say 512 bytes e.g. ?), whichever type they
have, and to have the code exploit that fact for real, and avoid copies.
With this criterion, I expect the repository to not grow a lot larger
(I'd say quite less than the 10% you had, as even in the kernel, there
_are_ some larger deltas, and we definitely loose space for them, I'd
expect less than a 5% size variation), and I _think_ it's worth
investigating. At least I expect visible results on commands (like blame
of even log[0]) that go through a lot of small objects to see 10 to 20%
increase speed (backed up by some experience I have in avoiding copies
in not-so-similar cases though, so it may be less, and I'll stand
corrected -- and disappointed, a bit).

  [0] If I'm correct commit messages are "objects" on their own, and I
      don't expect them to be very often over 512 octets.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHhy9/vGr7W6HudhwRArLrAKCCstrZ62CSbRZQlHj9tW50cshNOgCeOfJT
WMBihdDb4WBkMLYy/b5qDKo=
=dTfy
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
