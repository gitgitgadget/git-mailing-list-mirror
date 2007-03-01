From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: How to effectively undo a part of a commit
Date: Thu, 01 Mar 2007 17:51:58 +0100
Message-ID: <45E704AE.6000904@fs.ei.tum.de>
References: <17895.72.525085.734138@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAEEA66D0646720F85840E682"
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 17:52:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMoWI-0002bz-Cm
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 17:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965384AbXCAQwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 11:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965382AbXCAQwI
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 11:52:08 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:36092 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965389AbXCAQwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 11:52:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 4819D2856D;
	Thu,  1 Mar 2007 17:52:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DsrLUhiM+EUi; Thu,  1 Mar 2007 17:52:02 +0100 (CET)
Received: from [62.216.208.146] (ppp-62-216-208-146.dynamic.mnet-online.de [62.216.208.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id E2B402856C;
	Thu,  1 Mar 2007 17:52:01 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <17895.72.525085.734138@lisa.zopyra.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41105>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAEEA66D0646720F85840E682
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Bill Lear wrote:
> So, starting with F, he applies delta 1 to get F2.
> Then, he applies delta 2 to get F3.

And delta 2 reverts delta 1 again, right?

> He says that using cvs he would do something like this:
>=20
> % cvs update -j F1 -j F2
>=20
> To apply delta 1 to F3.

try git-cherry-pick -n F2.

> We tried using git to get the delta 1 as a patch --- that went fine.
> Then we used git-apply to apply the patch, but it refused, and it was
> obvious that the line numbers of the patch no longer corresponded to
> the line numbers in the file in his working tree.

patches don't care about line numbers (at least not so much).  you probab=
ly have overlapping changes, so apply can't work without generating a col=
lision.  try git-apply --reject and then merge the .rej file.

> Is there a way in git to do this, or is this an inherently unworkable
> problem, as for some reason, I suspect?

there are plenty of ways.  i think you could also do something like this =
(untested):

git checkout F3
git branch fixF3 F1
git reset --soft fixF3
git commit
git checkout F2
git cherry-pick fixF3

which first transplants F3 back on F1, removing the delta which reverted =
F2.  then, having a nice patch now, applies it onto F2.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigAEEA66D0646720F85840E682
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5wSxr5S+dk6z85oRAtbaAJ0bFDI9BCp3t9Zus7tXF6cTMdxMNwCgrTvD
BAQ9m87wP3Uxtyhmith+/aw=
=HAt2
-----END PGP SIGNATURE-----

--------------enigAEEA66D0646720F85840E682--
