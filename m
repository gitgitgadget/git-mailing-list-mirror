From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 23:16:49 +0100
Message-ID: <200902102316.56348.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <7vocxam96s.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902102210140.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1642482.JbxzQ4Svxm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 23:19:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX0wQ-0006SH-V7
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 23:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752AbZBJWRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 17:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbZBJWRG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 17:17:06 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:28059 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755771AbZBJWRF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 17:17:05 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 10 Feb 2009 23:17:02 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 10 Feb 2009 23:17:01 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0902102210140.10279@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 10 Feb 2009 22:17:01.0738 (UTC) FILETIME=[4C0F08A0:01C98BCD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109322>

--nextPart1642482.JbxzQ4Svxm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> Or we could use an on-disk hashmap.  Oh, wait...

While reading this thread, I sure wondered ... why don't we use the
one on-disk fast access structure we already have: the index?

Sure, one problem is that the index reading code is inherently written
for a single index state.  However, all notes consumers I can
currently think of (show, log, anything that displays commit messages)
do not have to access the "real" index.

We'd immediately get lots of tool support for free.  Presumably the
real index code has been optimized very well, so it should perform
well.  Perhaps there could even be some definition of a NOTES_HEAD
that tracks the current (albeit not checked out, that would be insane)
state.


On a tangent, I'd really like to see a feature that lets us have
several sets of notes (by whatever mechanism).  Displaying them as
"Notes from remotes/trast/mailnotes" or similar should be ok.  Given
that even before notes are in any release we already have at least two
projects working with mass annotations, it doesn't take much of a
crystal ball to see that the current one-note restriction will be a
limitation.

At a (*very*) cursory glance at read-cache.c, it seems that there is
even support for having several index structures in memory at once,
making this easy.  And it looks like reading the cache is more or less
memcpy() if xmmap() is fast (Windows would suffer once again).


Then again I joined this discussion very late so feel free to ignore
my ramblings.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1642482.JbxzQ4Svxm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmR/NgACgkQqUud07tmzP1OUACfdfVo1PU36xAlewarthuStL6Q
U6QAnjmCMaP4GYhula02F+gs+SF/DTdd
=45YN
-----END PGP SIGNATURE-----

--nextPart1642482.JbxzQ4Svxm--
