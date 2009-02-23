From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git rebase aggravation
Date: Mon, 23 Feb 2009 10:34:04 +0100
Message-ID: <200902231034.08736.trast@student.ethz.ch>
References: <22155203.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3012645.1comeWTEIY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Myxz Ptlk <Adrian.Klingel@illumaware.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 10:35:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbXE6-0007XE-21
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 10:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbZBWJeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 04:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbZBWJeW
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 04:34:22 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16371 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbZBWJeV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 04:34:21 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Feb 2009 10:34:19 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Feb 2009 10:34:19 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <22155203.post@talk.nabble.com>
X-OriginalArrivalTime: 23 Feb 2009 09:34:19.0283 (UTC) FILETIME=[E6E14E30:01C99599]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111127>

--nextPart3012645.1comeWTEIY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Myxz Ptlk wrote:
> 1)  Rebase master into zoo.
>=20
> 2) Merge zoo into master.

You may want to consider a merge and topic branch based workflow.  man
gitworkflows has some pointers.

=46or the rest of the discussion let's assume that your history looks
like

  *---*---*---*  (master)
   \
    \
     o---o---o   (zoo =3D origin/zoo)

Since you have tracking branches, origin/zoo should be the same as
zoo.  (origin/master should exist too but isn't important for now.)

> But here is what happens.  I spend 3 hours inside "zoo" doing "git rebase
> master".  I go through all the hell of reconciling 6 months of developmen=
t.=20
> Then at the end, it just says that the commits now differ between local
> "zoo" and "origin/zoo".

Indeed, since you rewrote every commit on zoo, it now looks like

  *---*---*---*   (master)
  |            \                =20
  |             \               =20
  \              o'--o'--o'   (zoo)
   \
    o---o---o  (origin/zoo)

> So I figure, I will pull from "origin/zoo".  Naturally, that results in a
> conflicted merge, which I then clear up.  I commit the merge, then push
> everything back to the remote branch.

You're merging like this:

  *---*---*---*   (master)
  |            \                =20
  |             \               =20
  \              o'--o'--o'---M   (zoo)
   \                         /
    o---o---o---------------'
              (origin/zoo)


I think you can already see that you made a mess of history :-)

You should have forced the push instead.  But see "recovering from
upstream rebase" in man git-rebase for information on what happens to
everyone else's work that was based on zoo.

> My thinking is that if I were to attempt a new rebase of master, the
> beginning of what would be rebased would start from RIGHT NOW, instead of
> all the commits over the past 6 months.  To check this, I type:
>=20
> git rebase master
>=20
> from "zoo".  Lo and behold, it starts the whole process over again.  I "g=
it
> rebase --abort", but I am very, very confused.

Actually it's even worse: it should attempt to rebase _every_ commit
in master..zoo.  If master has progressed since your original
rebase+merge, this will be both the "o" and "o'" commits above.

(Except the ones that did not conflict at all, since they'll still be
the same.)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3012645.1comeWTEIY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmibZAACgkQqUud07tmzP3YbwCfeAiw9Ao/UBkuQkGFFBVk7Pvt
wpQAoKJ43slZhqn7vaAz3fp07otGOOvw
=kGWD
-----END PGP SIGNATURE-----

--nextPart3012645.1comeWTEIY--
