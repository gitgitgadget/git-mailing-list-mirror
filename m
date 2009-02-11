From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/RFH] Fun things with git-notes, or: patch tracking backwards
Date: Wed, 11 Feb 2009 23:52:36 +0100
Message-ID: <200902112352.40955.trast@student.ethz.ch>
References: <200902091508.11460.trast@student.ethz.ch> <200902110012.34717.trast@student.ethz.ch> <7vprhpkgzk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6467838.eaqHMBBOr9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 23:54:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXNyC-0004y3-1r
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 23:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbZBKWwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 17:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbZBKWwt
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 17:52:49 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:59018 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754137AbZBKWwt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 17:52:49 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Feb 2009 23:52:46 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Feb 2009 23:52:46 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <7vprhpkgzk.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 11 Feb 2009 22:52:46.0385 (UTC) FILETIME=[74C7F210:01C98C9B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109541>

--nextPart6467838.eaqHMBBOr9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > Right now it's just the patch-id.  Maybe filtering (author,subject)
> > and then picking the one that is the most similar could work.
>=20
> Yeah, I actually was thinking about matching the (date, author) tuple and
> nothing else, as it is unlikely you would have dups.

Thanks, good idea.  I changed the code to parse the required data, and
we're now up to 1502 annotations.

Unfortunately I noticed there's a bug in the mail input stage:
Python's mailbox module assumes any '^From ' line starts a new mail,
while gmane apparently uses a slightly different format based on the
double newlines too (and they always have the same 'From
news@gmane.org Tue Mar 04 03:33:20 2003' separator too), and doesn't
quote '^From ' in the bodies.  So any mail containing such body lines
got chopped down in the middle, and any patches contained in them
won't apply because of the missing headers.

A quick perl run shows that there are 26 mails affected among the
89000+ mails that I've (again) imported.  The fix should be easy, but
I'm already short on sleep.

> I find the "Extra-Notes:" tag a bit too loud, but I am probably a minority
> who thinks everything but the Message-ID can be dropped, so please don't
> take it as a feature request ;-)

I refactored the final formatting stage a bit to let it do several
notes trees, and you can now take your pick:

  git://repo.or.cz/trackgit.git notes/full
  git://repo.or.cz/trackgit.git notes/terse

The latter only has 'Message-Id' and 'Archived-At'.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart6467838.eaqHMBBOr9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmTVrgACgkQqUud07tmzP3nQQCgorm+bDtHby10Z0ExN/j3lS3Z
0hsAnAwdIG6JcBA+PT2KvV39pzz1vZdO
=6nWJ
-----END PGP SIGNATURE-----

--nextPart6467838.eaqHMBBOr9--
