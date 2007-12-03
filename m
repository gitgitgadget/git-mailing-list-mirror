From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] xdiff-interface.c (buffer_is_binary): Remove buffer size limitation
Date: Tue, 4 Dec 2007 00:50:07 +0300
Message-ID: <20071203215007.GA14697@basalt.office.altlinux.org>
References: <20071201160113.GA20849@nomad.office.altlinux.org> <7vlk8e42qb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 22:50:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzJBP-0004gd-Oo
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 22:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbXLCVuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 16:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbXLCVuL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 16:50:11 -0500
Received: from vhq.altlinux.org ([194.107.17.3]:33458 "EHLO
	sendmail.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXLCVuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 16:50:09 -0500
Received: from basalt.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by sendmail.altlinux.org (Postfix) with ESMTP id 209182350024;
	Tue,  4 Dec 2007 00:50:07 +0300 (MSK)
Received: by basalt.office.altlinux.org (Postfix, from userid 501)
	id 0FB52B0D91; Tue,  4 Dec 2007 00:50:07 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <7vlk8e42qb.fsf@gitster.siamese.dyndns.org>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66964>


--O5XBE6gyVG5Rl6Rj
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 01, 2007 at 11:46:52AM -0800, Junio C Hamano wrote:
> On Sat, Dec 01, 2007 at 07:01:13PM +0300, Dmitry V. Levin wrote:
>=20
> > When checking buffer for NUL byte, do not limit size of buffer we check.
> > Otherwise we break git-rebase: git-format-patch may generate output whi=
ch
> > git-mailinfo cannot handle properly.
>=20
> I think this is tackling a valid problem but it is a wrong solution.
> The change penalizes text changes which is the majority, just in case
> there is an unusual change that has an embedded NUL far into the file
> (iow, exception).

Penalizes?
Average file size in the linux-2.6.23.9 kernel tree is 10944 bytes,
FIRST_FEW_BYTES limit is 8000 bytes.
Well, I prefer slightly penalized but working properly git-rebase.
Attached test case demonstrates how current git-rebase can just run
successfully but produce a wrong result.

P.S. The real life example where you can hit this git-rebase problem is
GNU .info files.


--=20
ldv

--YZ5djTAD1cGYuMQK
Content-Type: application/x-sh
Content-Disposition: attachment; filename="t3408-rebase-binary-correctness.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Atest_description=3D'rebase binary correctness test'=0A=0A. .=
/test-lib.sh=0A=0Ayes 1234567 |head -n 2000 >text=0Acp text bin && printf '=
binary\0data\n' >>bin=0A=0Atest_expect_success setup '=0A=0A	cat text >file=
 &&=0A	git add file &&=0A	git commit -m"text" &&=0A=0A	git branch bin &&=0A=
=0A	echo side >side &&=0A	git add side &&=0A	git commit -m"side" &&=0A=0A	g=
it checkout bin &&=0A	cat bin >file &&=0A	git commit -a -m"bin"=0A'=0A=0Ate=
st_expect_success rebase '=0A=0A	git rebase master &&=0A	cmp file bin=0A'=
=0A=0Atest_done=0A
--YZ5djTAD1cGYuMQK--

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHVHoOfKvmrJ41Nh4RAqc+AKDJDx8M7dQYh9bn1PHJgNxO7zZy2ACfflrb
6+wjZfOmnohPNGzdi0cShoM=
=tVB2
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
