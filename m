From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: Git does not handle changing inode numbers well
Date: Wed, 8 Aug 2012 20:07:48 +0200
Message-ID: <20120808180748.GS21274@login.drsnuggles.stderr.nl>
References: <20120808152230.GQ21274@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bGopQmzlzQgFk3Fg"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 20:07:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzAfm-0002uq-7u
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 20:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514Ab2HHSHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 14:07:53 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:44501 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030507Ab2HHSHw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 14:07:52 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1SzAfc-0002o7-At
	for git@vger.kernel.org; Wed, 08 Aug 2012 20:07:49 +0200
Received: (nullmailer pid 10792 invoked by uid 1000);
	Wed, 08 Aug 2012 18:07:48 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20120808152230.GQ21274@login.drsnuggles.stderr.nl>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203106>


--bGopQmzlzQgFk3Fg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> So, let's see if I can fix my filesystem now ;-)
For anyone interested: turns out passing -o noforget makes fuse keep a
persistent path -> inode mapping (at the cost of memory usage, of
course).

However, it also turns out that fuse wasn't my problem: It was the aufs
mount that was overlayed over my fuse mount (this was on a Debian live
system), which sets the noxino option that prevents aufs from keeping
persistent inode numbers.

To get git status working as expected, I had to both remove noxino from
the aufs mount and add noforget to the underlying fuse mount.

Gr.

Matthijs

--bGopQmzlzQgFk3Fg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlAiqvQACgkQz0nQ5oovr7zbxQCghgakErd0K7sxoRvuYvuaKlPr
HhwAnRvYTS+4pw0pA4fNzrluG0NFZr3c
=/y0f
-----END PGP SIGNATURE-----

--bGopQmzlzQgFk3Fg--
