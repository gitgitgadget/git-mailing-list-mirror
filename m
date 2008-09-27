From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: having to pull twice
Date: Sat, 27 Sep 2008 16:16:29 +0200
Message-ID: <200809271616.32082.trast@student.ethz.ch>
References: <fb6605670809241758r186eef51sc6ed6d334a64495d@mail.gmail.com> <200809250905.09646.trast@student.ethz.ch> <20080925232525.GP23137@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1570916.tXdLe5F6mi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Michael P. Soulier" <msoulier@digitaltorque.ca>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 17:54:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjc80-0001HL-PH
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 17:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbYI0Pw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 11:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbYI0Pw6
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 11:52:58 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:23895 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbYI0Pw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 11:52:57 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Sep 2008 17:52:55 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Sep 2008 17:52:55 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080925232525.GP23137@genesis.frugalware.org>
X-OriginalArrivalTime: 27 Sep 2008 15:52:55.0882 (UTC) FILETIME=[1B7A7AA0:01C920B9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96913>

--nextPart1570916.tXdLe5F6mi
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Miklos Vajna wrote:
> On Thu, Sep 25, 2008 at 09:05:02AM +0200, Thomas Rast <trast@student.ethz=
=2Ech> wrote:
> > On the other hand, as near as I can tell this is a regression in
> > builtin-merge.  Miklos, do you know if/how this can be fixed?
>=20
> I think Junio already fixed this in 446247d (merge: fix numerus bugs
> around "trivial merge" area, 2008-08-23), so 1.6.0.1 or 1.6.0.2 should
> not have this bug.
>=20
> Michael, could you please upgrade frm 1.6.0 and confirm your problem
> goes away?

That won't help.  I decided this was a good opportunity to learn about
'git bisect run', and bisected it to 1c7b76b (Build in merge,
2008-07-07).  This was with bad =3D 47a765d (pulled from Shawn's repo
this week) and good =3D v1.5.6.

In case you want to check my logic, the commands are below.

=2D Thomas


* Setup:

  mkdir $temp_repo
  cd $temp_repo
  git init
  echo foo > foo
  git add foo
  git commit -m initial
  echo a > foo
  git commit -m a foo
  git checkout -b side HEAD^
  echo b > foo
  git commit -m b foo
  git checkout master

* Bisection script:

=2D- 8< --
#!/bin/sh

rm -rf $temp_repo/{bin,libexec}
make -j3 prefix=3D$temp_repo install

PATH=3D$temp_repo/bin:$PATH
cd $temp_repo
touch foo
git merge side
test -f .git/MERGE_HEAD
s=3D$?
git reset --hard
if test $s !=3D 0; then
    echo did not work
    exit 1
else
    echo worked
    exit 0
fi
=2D- >8 --



--nextPart1570916.tXdLe5F6mi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjeQEAACgkQqUud07tmzP2t9QCghBXVy5avHzkl6VFjSlzoIoW6
hw4AnR8niEQTgPY3AojzmGblkEp9iOcz
=qNds
-----END PGP SIGNATURE-----

--nextPart1570916.tXdLe5F6mi--
