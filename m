From: Johan Herland <johan@herland.net>
Subject: Re: Coping commits from one branch to another
Date: Tue, 22 Jan 2008 17:07:59 +0100
Message-ID: <200801221708.03399.johan@herland.net>
References: <8e04b5820801220745m3736686exf631f31c9e6d785a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart171579154.9xh4bmeMCN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 17:08:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHLg1-00046S-Jv
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 17:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbYAVQIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 11:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbYAVQIJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 11:08:09 -0500
Received: from sam.opera.com ([213.236.208.81]:39070 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbYAVQII (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 11:08:08 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m0MG83j8023804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Jan 2008 16:08:03 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <8e04b5820801220745m3736686exf631f31c9e6d785a@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.91.1/5520/Tue Jan 22 13:09:49 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71460>

--nextPart171579154.9xh4bmeMCN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 22 January 2008, Ciprian Dorin Craciun wrote:
>     Hello all!
>=20
>     My question is how can I use git-rebase -- or a similar command --
> to actually copy the commits from one branch to another.
>=20
>     For example I have cloned the linux kernel repository and I have
> the following branches:
>     -- v2.6.22-stable
>     -- v2.6.23-local
>     -- v2.6.23-stable
>     -- v2.6.23-local
>=20
>     The difference between v2.6.x-stable and v2.6.x-local are just a
> few minor patches (which are not in the default kernel tree) and some
> script files added to make the compilation and deployment easier for
> my setup. Thus v2.6.x-local is an ancestor of v2.6.x-stable. Now when
> v2.6.24 will arrive I would like to "copy" the commits from
> v2.6.23-local to v2.6.24-local.
>=20
>     One solution would be to use:
>     git rebase --onto v2.6.24-local v2.6.23-stable v2.6.23-local
>=20
>     But this will not copy the commits, but actually move them. (And I
> do not see anything about this case in the git rebase documentation,
> or pointers to other commands similar to rebase.)
>=20
>     So how should this be done?

Actually, you're pretty much on the right track, already. git-rebase does=20
in fact _copy_ the commits onto the target branch. It's just that it also=20
moves the ref (i.e. branch name) along, so that the old commits are no=20
longer reachable. Consider the following:

	git checkout -b v2.6.24-local_new v2.6.23-local
	git rebase --onto v2.6.24-local v2.6.23-stable

This checks out a new branch (v2.6.24-local_new) that initially points at=20
the same commit as v2.6.23-local. We then rebase all the commits between=20
v2.6.23-stable and v2.6.24-local_new (which is the same as v2.6.23-local)=20
on top of the existing v2.6.24-local branch. v2.6.24-local_new will move=20
along and point to the last commit _after_ rebase, but you haven't moved=20
v2.6.23-local in the process, so it still points to the corresponding last=
=20
commit _before_ rebase.


Have fun!

=2E..Johan


=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart171579154.9xh4bmeMCN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBHlhTjBHj4kl4fT1wRAkwuAJ9cr749QTk8Wq6RmjL/RurArIiazwCgnKMb
LHYVMossn8qTh5QFrpLAvKw=
=PTKV
-----END PGP SIGNATURE-----

--nextPart171579154.9xh4bmeMCN--
