From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 0/8] Support coverage testing with GCC/gcov
Date: Thu, 19 Feb 2009 15:11:57 +0100
Message-ID: <200902191512.16755.trast@student.ethz.ch>
References: <7v7i3nqk0x.fsf@gitster.siamese.dyndns.org> <cover.1235041345.git.trast@student.ethz.ch> <alpine.DEB.1.00.0902191227260.6223@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11031674.3zMZXH2fL1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 15:14:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La9f3-0001nk-Hv
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 15:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036AbZBSOM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 09:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbZBSOM3
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 09:12:29 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:55055 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559AbZBSOM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 09:12:28 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 15:12:26 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 15:12:26 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0902191227260.6223@intel-tinevez-2-302>
X-OriginalArrivalTime: 19 Feb 2009 14:12:26.0430 (UTC) FILETIME=[178ADDE0:01C9929C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110703>

--nextPart11031674.3zMZXH2fL1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> On Thu, 19 Feb 2009, Thomas Rast wrote:
> > I noticed two small things that I'd like to fix before this goes
> > 'next', so here they are:
> >=20
> > * [1/8] Support coverage testing with GCC/gcov
> >=20
> >   Changed it so the compilation (but not the testing) uses the same -j
> >   flags as the caller, so that compilation can be done in parallel.
> >   (It's rather minor compared to the slow testing with optimizations
> >   turned off, but still.)
>=20
> I strongly disagree that it is minor.  _Especially_ since the tests are=20
> slow, -j makes a huge difference.
>=20
> And also without making the tests slower, -j makes a dramatic difference=
=20
> here:
>=20
> 	$ /usr/bin/time make -j50 test

That's not the point.

I agree that for the test suite, -j makes a huge impact, since it
takes so long.  But even though the docs claim it should be possible,
I've been getting "random" test failures when compiled with coverage
support, that went away with -j1.  So the tests still run with -j1, as
with the first version of the series.

However, the first version used a single make invocation for the'all'
and 'test' targets, which of course also means that the _compilation_
('all') happens with -j1.  That's not necessary as far as I can see,
and I split them into separate commands in v2, where 'all' doesn't
pass a -j option any more (so that the caller's choice remains in
effect).

What I meant by the above remark is that the maybe 30 seconds you gain
by compiling in parallel are a very minor gain when compared to the
enormous running time of the _sequential_ test suite _without
optimizations_, which feels like 15-20min here, I haven't even timed
it.  (I always mount t/ on a tmpfs which does away with the fsync()
bottleneck and lets me do ordinary test runs, with NO_SVN_TESTS, in
under 3min.)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart11031674.3zMZXH2fL1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmdaMAACgkQqUud07tmzP0rdQCgnh9T8uYnLT4aQzF5b/aohmVo
QzgAnjsr1eckXe/iyEZOi/3A1nukT1Q/
=I/5Z
-----END PGP SIGNATURE-----

--nextPart11031674.3zMZXH2fL1--
