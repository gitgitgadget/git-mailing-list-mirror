From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: cg-push protocol proposal
Date: Thu, 02 Jun 2005 08:54:42 -0400
Message-ID: <1117716883.32257.42.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-pv+Eqkb8oWhL0Sz2+xlF";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
X-From: git-owner@vger.kernel.org Thu Jun 02 14:53:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdpAq-0007ub-4a
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 14:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVFBMyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 08:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVFBMyt
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 08:54:49 -0400
Received: from mail.timesys.com ([65.117.135.102]:44045 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261403AbVFBMyo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 08:54:44 -0400
Received: from jmcmullan by owa.timesys.com; 02 Jun 2005 08:54:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
Date: Thu, 2 Jun 2005 08:47:55 -0400
Message-ID: <1117716883.32257.42.camel@jmcmullan.timesys>
X-Mailer: Evolution 2.0.4-3mdk 
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: cg-push protocol proposal
thread-index: AcVncUvbPR9io0AUTSq361tHLvmnIw==
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-pv+Eqkb8oWhL0Sz2+xlF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'd like to propose the following protocol for 'pushes'. Assume that a
'git-daemon' is the 'server', and is talking on stdin/stdout.

Each command is an ascii string, followed by a LF (\n)

Request current head ID:

	  head <head-name>\n

	Responses:

	  head <head-name> <sha1>\n

	  error <head-name> <hex-code> <error-string>\n

Request a SHA1 blob from the server

	  send <sha1>\n

	Responses:

	  send <sha1> <hex-size>\n<bytes...>

	  error <sha1> <hex-code> <error-string>\n


Update head ID to a SHA1 (the SHA1 may already be in the server's DB)

	  head <head-name> <old-sha1> <sha1>\n

1)	Response if <head-name> is now <sha1>:

	  head <head-name> <sha1>\n

	Response if error, or head locked by someone else updating:

	  error <head-name> <hex-code> <error-string>\n

	Response if <sha1> is not in the database:

	  send <sha1>\n		- Server needs the blob

2)	Client response if 'send' is returned:
=20
	  send <sha1> <hex-size>\n<bytes...>

3)	Response if more objects are needed=20
          (ie you sent a commit or tree object)

	  send <new-sha1>\n	- Server needs blob

	  Remember the SHA1 you sent, 'call' step 2) with new-sha1=20
	  Goto 3)

	Response if send succeeded:

	  exists <sha1>\n

	Response if send failed:

	  error <sha1> <hex-code> <error-string>\n

TODO: Tags
=09


--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-pv+Eqkb8oWhL0Sz2+xlF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCnwGS8/0vJ5szK6kRArNaAJoDTzr6kd3109Nm9FCMprhPjZ2AgwCg09Bx
AMSE6RsU7vIyrmchiyMD1d0=
=WUYt
-----END PGP SIGNATURE-----

--=-pv+Eqkb8oWhL0Sz2+xlF--
