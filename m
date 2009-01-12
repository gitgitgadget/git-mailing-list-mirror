From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/4] refactor the --color-words to make it more hackable
Date: Mon, 12 Jan 2009 07:25:28 +0100
Message-ID: <200901120725.39463.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <200901112253.27165.trast@student.ethz.ch> <alpine.DEB.1.00.0901112351050.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2559241.A9gmaUcI3k";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 12 07:26:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMGG8-00009C-Aa
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 07:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbZALGZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 01:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZALGZY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 01:25:24 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:14211 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbZALGZY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 01:25:24 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Jan 2009 07:25:22 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Jan 2009 07:25:22 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901112351050.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 12 Jan 2009 06:25:22.0429 (UTC) FILETIME=[8C3D2AD0:01C9747E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105296>

--nextPart2559241.A9gmaUcI3k
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> On Sun, 11 Jan 2009, Thomas Rast wrote:
> >  However, the final result segfaults and/or prints garbage (on=20
> > apparently every commit except very small changes) when using the regex=
=20
> > '\S+', which IMHO should give exactly the same result as not using a=20
> > regex at all.
>=20
> No, it should not.  The correct regex is '^\S+'.
>=20
> As it happens, your regex matches _anything_ + non-whitespace.

It definitely doesn't(*).

Given ' word rest', '^\S+' would not match at all, and '\S+' would
match 'word'.  No space there.  However, at a cursory glance your
patch seems to ignore the rm_so member of match[0], so it'll never
know the difference.

While it might arguably make sense to enforce that only isspace()
characters are whitespace and !isspace() is at least part of _some_
(possibly one-character) word, I do not think it is a good idea to
require the anchoring of the user.  If we need it, we must anchor the
match ourselves.

> Unfortunately, this includes a newline which utterly confuses the
> diff,=20

I do agree that matching a newline as part of a word is bad because we
need it for its diff separator semantics.  Consider passing
REG_NEWLINE to regcomp() to reduce the risk of matching newlines via
things like [^\[:space:]].



(*) Well, modulo Junio's objection in the other thread that \S is
actually a PCRE extension.  Substitute [^[:space:]] if your local
flavour doesn't understand it.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch




--nextPart2559241.A9gmaUcI3k
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklq4mMACgkQqUud07tmzP1r9QCfUnhtG/QBo649av0shcoqGd5U
TXcAniueuND3hu7rww4n1DpRl9FNadYe
=Uh84
-----END PGP SIGNATURE-----

--nextPart2559241.A9gmaUcI3k--
