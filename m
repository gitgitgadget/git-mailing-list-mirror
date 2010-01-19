From: Joey Hess <joey@kitenet.net>
Subject: bug: git-bundle create foo --stdin -> segfault
Date: Mon, 18 Jan 2010 19:26:42 -0500
Message-ID: <20100119002641.GA31434@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Cc: 554682@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 01:27:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX1wh-0000XM-0U
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 01:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab0ASA0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 19:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123Ab0ASA0y
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 19:26:54 -0500
Received: from wren.kitenet.net ([80.68.85.49]:37398 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422Ab0ASA0y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 19:26:54 -0500
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id BFE5D118FD7;
	Mon, 18 Jan 2010 19:26:51 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 78226A8366; Mon, 18 Jan 2010 19:26:42 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137414>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

joey@gnu:~/tmp/new>echo master | git bundle create ../my.bundle --stdin
zsh: segmentation fault  git bundle create ../my.bundle --stdin

I noticed that git bundle --stdin actually attempts to read from stdin
past EOF. You can see this if you manually type into its stdin.

% git-bundle create ../bundle --stdin
master
^D
master
^D
fatal: Refusing to create empty bundle.

The first stdin read is done by the internal call to rev-list --stdin.
The second stdin read is done by the call to setup_revisions(),
which has its own handler for --stdin.

Bug seen with git version 1.6.5.7 / 1.6.6.243.gff6d2

I also tried going back to 22568f0a336ac37ae7329c917857b455839d1d09, but
still see a bug with Adam Brewster's initial code to add --stdin to
git-bundle. That code still tries to read stdin twice. If it sees
"master" both times, it does create a bundle.

--=20
see shy jo

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBS1T8PskQ2SIlEuPHAQjywA//fNNAJh4Hh2D6VtjlJdyfJFuUTae0uAXz
eOmBud5e1btkjcOiT8hTMMTX5V3waxYiHAmadZD1N/qZ/PJHIDgweZLOW0ULvx96
hSahoCB1MoEPDCZi09N8MBo1ZJzAnHadkChrccR/xkwsD8MNGMSMeXYQlhYzfFiE
SzG+0VsZoSUcaLR9/ibL6Kbch26Wa8Aive57z0CZiB9gaLoSQo9VuLgdw0PDsJJP
CD0GLDslsMG/2avj+H9JC+zIHeY/r6sS8WpDPhQ/nXvNOIKZSHFQggLUr8NMAUFX
eZdFJhctSL0rqHwSP+PKJ21Y4EqZ03SBtGQfEpWQGBWVEFu/iopXcgX3ENFYmcSZ
tN0aRd6cSAqXFoYhtu9Zo/XZ6lM7xNayhaKfqgLtcKio6IMFZ8Nj0rvYZY2jP7Cv
OcyCYeNwduIiDWi3alYWxfBEHFDQE+eNcm+gIlWeEmxwgPI+QttDpDTwxuy+/HRf
2AyTiBZaomIgg9uppc+yHRNYtpPE/+FpeosWas6wf7IBfbIOonSQj3nRhyhVhEG7
+tznAJ2z59IX/wcqKRB8saByYLfAa8/IinGK7VX0lcnp5xhdOlrYOzXkhS3GvrgB
F/N1FrEUMed4tsdMpfSYd3/4mxHIPqU9Ig0fjDkb9ncsJjVtp6352ut9pAf8ffA2
mMV81ZGxRCE=
=pnfr
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
