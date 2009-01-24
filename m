From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sat, 24 Jan 2009 23:47:20 +0100
Message-ID: <200901242347.23187.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901242056070.14855@racer>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart14020543.1GEsHnkxYr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>,
	spearce@spearce.org,
	=?utf-8?q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 23:48:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQrIz-0000Qx-G0
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 23:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbZAXWrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 17:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbZAXWrK
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 17:47:10 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:11737 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbZAXWrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 17:47:09 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 24 Jan 2009 23:47:07 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 24 Jan 2009 23:47:07 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0901242056070.14855@racer>
X-OriginalArrivalTime: 24 Jan 2009 22:47:07.0744 (UTC) FILETIME=[AF7FEE00:01C97E75]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107014>

--nextPart14020543.1GEsHnkxYr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> Worse, the whole concept of "pick <merge-sha1>" just does not fly well.
[...]
> - merge $sha1 [$sha1...] was $sha1 "Merge ..."
>=20
> 	will merge the given list of commits into the current HEAD, for=20
> 	the user's reference and to keep up-to-date what was rewritten,=20
> 	the original merge is shown after the keyword "was" (which is not=20
> 	a valid SHA-1, luckily)

I really like the underlying idea.  I'm not even sure if the current
semantics are well-defined in all cases; an explicit merge command at
least makes it very clear what is going on.

However, I think the syntax as proposed above is a bit confusing in
the usual two-parent merge.  I couldn't tell whether

  merge A was B

was intended to be read as "the merge of A into the current branch" or
"the merge with sha1 A" right away, and I doubt I'll be able to tell
without looking in the (rare) cases I have to invoke rebase -i -p.

I can't really come up with a better replacement for 'was', so how
about

  merge A  # was B "Merge..."

which would make it more clear that the "was B..." has no effect
whatsoever on the merge's semantics.

> A - B - - - E=20
>   \       /
>     C - D
>=20
> could yield this TODO script:
>=20
> 	pick A
> 	pick C
> 	pick D
> 	goto A'
> 	pick B
> 	merge D' was E

I kind of wonder if it would be possible to decorate the TODO with
'git log --graph' output, to make it easier to follow the history as
it is built.  Perhaps something like

  *   pick A
  |\
  * | pick B
      goto A'
  | * pick C
  | * pick D
  |/
      goto B'
  *   merge D'  # was E

Well, maybe it's not such a good idea after all.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart14020543.1GEsHnkxYr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl7mnsACgkQqUud07tmzP28igCeNrXabQy0s1Fkzg5bju+pYC19
/H8Ani+FYtKKrGpO3DE8iFGY4+RyDq5j
=v//n
-----END PGP SIGNATURE-----

--nextPart14020543.1GEsHnkxYr--
