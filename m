From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC] log(n)-transmissions common commit handshake
Date: Thu, 18 Sep 2008 10:18:18 +0200
Message-ID: <200809181018.52811.trast@student.ethz.ch>
References: <200809180100.32626.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8487783.o6CD4nvESd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 10:20:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgEkX-0007dI-HK
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 10:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYIRIS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 04:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbYIRIS4
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 04:18:56 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:34006 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333AbYIRISy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 04:18:54 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Sep 2008 10:18:52 +0200
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Sep 2008 10:18:52 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200809180100.32626.trast@student.ethz.ch>
X-OriginalArrivalTime: 18 Sep 2008 08:18:52.0620 (UTC) FILETIME=[2F82D8C0:01C91967]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96181>

--nextPart8487783.o6CD4nvESd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I wrote:
> * Impact/clever use of refs
>=20
>   For some reason, current git sends all refs to the server, even if
>   the server should already know about lots of them.  For example, in
>   git.git, emitting v1.6.0.2 covers almost all tags in the repository
>   by simple ancestor scanning.
>=20
>   Is there a reason for this behaviour?  Otherwise it would be better
>   to emit them in date order and intelligently handle commons.  (In
>   fact this does not depend on the discussed change.)

As an addendum, I think the following would be a good way to cleverly
use refs to reduce work:

Cache a "reduced" DAG which just maps the ref'd commit relationships,
i.e., shows the reachability of refs only.  This needs to be written
out to disk between invocations.

At the start of the protocol, the server announces all its refs.  We
can use the reduced DAG to infer the minimal set of ref heads we need
to announce to have the server know all common ones.  We can also mark
all the other refs as "common but not announced yet", so that the
backwards marking and searching routines know to stop there.

This should reduce the number of refs listed back to the server to
only a handful, and at the same time, stop the client from searching
backwards through _all_ history (which can take a bit of time, and is
one of the weaknesses of my proposal) in most cases.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart8487783.o6CD4nvESd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjSDuwACgkQqUud07tmzP1f6QCgkTYq6tqUwG+qmGt07GUbnN7G
cDYAoIV6lihai1dIKsRtYkFA3/ay14Jx
=ptHv
-----END PGP SIGNATURE-----

--nextPart8487783.o6CD4nvESd--
