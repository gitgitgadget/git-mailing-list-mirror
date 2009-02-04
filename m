From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: retrospective move
Date: Wed, 4 Feb 2009 13:33:38 +0100
Message-ID: <200902041333.40776.trast@student.ethz.ch>
References: <21826423.post@talk.nabble.com> <200902041017.47564.trast@student.ethz.ch> <adf1fd3d0902040231h2fb6f199oee143e36a7501a2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3089923.KFsOVQloF8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: jemmyw <jeremy@boost.co.nz>, git@vger.kernel.org
To: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 13:36:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUgyW-0007L4-Jc
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 13:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbZBDMeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 07:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752698AbZBDMeA
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 07:34:00 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16561 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656AbZBDMd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 07:33:59 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Feb 2009 13:33:57 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Feb 2009 13:33:57 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <adf1fd3d0902040231h2fb6f199oee143e36a7501a2a@mail.gmail.com>
X-OriginalArrivalTime: 04 Feb 2009 12:33:57.0636 (UTC) FILETIME=[D96E3440:01C986C4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108346>

--nextPart3089923.KFsOVQloF8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Santi B=E9jar wrote:
> 2009/2/4 Thomas Rast <trast@student.ethz.ch>:
> > jemmyw wrote:
> >>
> >> Hi. Awhile ago I copied some files in my local repo then commited. In =
another
> >> commit I deleted the original files, so essentially I did a mv that git
> >> doesn't know about. Now I'm trying to merge from another branch where
> >> changes have happened to the files in their original locations, and it=
's
> >> making the merge somewhat difficult. Is there a way to ease this?
> >
> > Git never "knows" about a move, it only detects them after the fact.
> > A corollary of this is that 'git mv a b' is more or less the same as
> > 'cp a b; git rm a; git add b'.
> >
> > Now since you have a copy followed by a removal in two separate
> > commits, the merge logic won't treat this as a rename.
>=20
> I don't think it holds. Git only sees the endpoints and the bases, it
> does not matter if the "move" was actually two commits. Maybe they
> have changed dramatically and git is not able to detect the rename (or
> the files are small). Another possible cause could be that you have a
> lot of renames (see config merge.renamelimit).

Hmm, you're right.  I stand corrected.

Here's a sequence of commands that makes a test case:

  git init
  seq 1 10 > A
  git add A
  git commit -m initial
  seq 11 15 >> A
  git commit -m second A
  seq 16 20 >> A
  git commit -m third
  git checkout -b side HEAD~2
  cp A B
  git add B
  git commit -m copy
  seq 3 10 > B               # <--
  git commit -m edit B
  git rm A
  git commit -m delete

Then running

  git merge master

goes through cleanly, but changing the line indicated above to 'seq 5
10' makes it less similar, falling through the detection and causing a
conflict.  The minimum required similarity for merges does not seem to
be configurable unfortunately.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3089923.KFsOVQloF8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmJiyQACgkQqUud07tmzP0XagCfZ5xOx02WVNTeDfLfh2onkBOJ
+PcAmwUfd0sfihNs7IxLRK8SW0wccTC8
=wA4U
-----END PGP SIGNATURE-----

--nextPart3089923.KFsOVQloF8--
