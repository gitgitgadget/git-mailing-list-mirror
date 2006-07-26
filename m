From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: Moving a directory into another fails
Date: Thu, 27 Jul 2006 00:34:59 +0200
Message-ID: <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 00:51:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5sDq-0005QY-8n
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 00:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWGZWvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 18:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWGZWvT
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 18:51:19 -0400
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:50700 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1751817AbWGZWvS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 18:51:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id C609041A0;
	Thu, 27 Jul 2006 00:51:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cik-SC8e1wel; Thu, 27 Jul 2006 00:50:14 +0200 (CEST)
Received: by vsectoor.geht-ab-wie-schnitzel.de (Postfix, from userid 1000)
	id 7B4C63E5B; Thu, 27 Jul 2006 00:34:59 +0200 (CEST)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24258>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2006 at 11:00:48AM -0400, Jon Smirl wrote:
> I cloned a git project. Then in the original I did mkdir for a new
> directory and use git mv to move an existing directory into it. I then
> used cg diff to generate a patch for the move.
>=20
> When I use cg patch to apply this patch to the cloned tree it fails.
> This seems to be a problem in the git code, not cg.  It is not picking
> up the creation of the new intervening subdirectory correctly.
>=20
> I just synced and this does not work in the current code.

I tried to reproduce your scenario and before that I setup a test
repository.=20

(1) mkdir git_test
(2) cd git_test
(3) git init-db
(4) vim test.txt=20
# fill in some bogus text
(5) mkdir testing
(6) cd testing
(7) vim test1.txt
# again, fill in some bogus text
(8) cd ..
(9) cg add test.txt testing/test1.txt
(10) cg commit -C=20
# just give a fancy commit message...
(11) cd ..
(12) mkdir bare_git
(13) cd bare_git
(14) mkdir git_test.git
(15) GIT_DIR=3Dgit_test.git git init-db=20
(16) cd ../git_test
(17) git push ../bare_git/git_test.git --all
(18) cd ../
(19) git clone bare_git/git_test.git git_test2
(20) cd git_test
(21) mkdir blah_test
(22) git mv testing/ blah_test/
(23) cg diff > ../mkdir_patch.diff
(24) cd ..
(25) cd git_test2/
(26) cg patch < ../mkdir_patch.diff

=66rom the last one (26) i get=20

patching file blah_test/testing/test1.txt
patching file testing/test1.txt
touch: cannot touch `testing/test1.txt': No such file or directory
Adding file blah_test/testing/test1.txt
Removing file testing/test1.txt

but the result is correct. There is no testing-directory in here
anymore, and inside blah_test, there is my testing dir with the file
test1.txt in it...

did I miss something?

I use cogito-0.17.3 with git version 1.4.1
(obviously without that recently rewritten git-mv...)

Nicolas

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEx+4TSlT0CowElk8RAvEoAKCyuGhkTSFRL3ttjZD1sepCN8fmbQCgkqWm
eYp0n5/JQc9wmCJVh0+4xyY=
=F2gt
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
