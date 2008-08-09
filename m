From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Sat, 9 Aug 2008 11:25:42 +0200
Message-ID: <200808091125.48897.trast@student.ethz.ch>
References: <200808080148.27384.trast@student.ethz.ch> <alpine.DEB.1.00.0808090212060.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7viqub9dzi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2507986.pTBfuuCl3n";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Jan Wielemaker <J.Wielemaker@uva.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 11:26:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRkik-0006T2-4H
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 11:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbYHIJZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 05:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753675AbYHIJZl
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 05:25:41 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:28863 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbYHIJZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 05:25:40 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 9 Aug 2008 11:25:39 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 9 Aug 2008 11:25:38 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7viqub9dzi.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 09 Aug 2008 09:25:38.0681 (UTC) FILETIME=[E2C93E90:01C8FA01]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91757>

--nextPart2507986.pTBfuuCl3n
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> >> (a) Both A and D bring the same subdirectory contents.  'rev-list
> >>     --parents -- $subdir' drops one side of the merge during pruning. =
It=20
> >>     does not look past the merge to see whether the contents were=20
> >>     arrived at via different changesets.  Thus the history becomes
> >>=20
> >>       A' -- C'
> >>=20
> >>       D'
> >>=20
> >>     and even that only if D was reachable by a different ref,
> >>     otherwise D' is simply dropped.
> >
> > And this is what I call wrong.  Simply dropping one side of the equatio=
n=20
> > is not what I call "sane".
> >
> > If you drop information, you are disagreeing with "content is king".

I wonder why I have to be the devil's advocate here.

Let me emphasise: _This is how filter-branch currently works._  It is
not some obscure feature coming with my patch.  The user _asks_ for
this simplification by using --subdirectory-filter.  It is also
_happening long before branch rewriting_, and we are discussing a
patch to said branch rewriting.

Junio has a point:

> I think the aggressive merge simplification that gives "one simplest
> explanation for the contents of the paths specified" is a wrong mode of
> operation to use when you are filtering branches.  It might be a good
> thing to support as an option, but I agree with you that it should not be
> the default.
>=20
> Perhaps --full-history is needed to the rev-list call (and the recent

But --full-history cannot solve this problem; it would entirely defeat
the point of --subdirectory-filter.  (I haven't looked into what
=2D-simplify-merges does yet.)

The only thing my patch changes is the behaviour with branches _that
the user asked us to rewrite to the subdirectory history_ but that
don't point to a precise commit that survived the simplification.  Why
would rewriting the branch pointer approriately be bad when the user
specifically asked for it?

And your _existing_ branch rewriting code had the same thing in mind:
move back to an ancestor that roughly fits the ticket.  You just
missed the problem with 'rev-list ^master ancestor' that has a high
chance to break the mechanism with --all.

And broke in Jan's case, which is why we're having this discussion,
remember?

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart2507986.pTBfuuCl3n
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkidYpwACgkQqUud07tmzP1FbwCfSdxCN18n9fQFe6g6e7V9LKaF
uXYAn37k5vCSIdVTz+4B7/JANQd0mqIy
=x14y
-----END PGP SIGNATURE-----

--nextPart2507986.pTBfuuCl3n--
