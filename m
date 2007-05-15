From: Jan Hudec <bulb@ucw.cz>
Subject: Smart fetch via HTTP?
Date: Tue, 15 May 2007 22:10:06 +0200
Message-ID: <20070515201006.GD3653@efreet.light.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 22:10:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho3Lt-0004xR-Cl
	for gcvg-git@gmane.org; Tue, 15 May 2007 22:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352AbXEOUK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 16:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbXEOUK2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 16:10:28 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:49379 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754352AbXEOUK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 16:10:27 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id B3EA35744A
	for <git@vger.kernel.org>; Tue, 15 May 2007 22:10:26 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Ho3LX-0001ol-9Q
	for git@vger.kernel.org; Tue, 15 May 2007 22:10:11 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47372>


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Did anyone already think about fetching over HTTP working similarly to the
native git protocol?

That is rather than reading the raw content of the repository, there would =
be
a CGI script (could be integrated to gitweb), that would negotiate what the
client needs and then generate and send a single pack with it.

Mercurial and bzr both have this option. It would IMO have three benefits:
 - Fast access for people behind paranoid firewalls, that only let http and
   https (you can tunel anything through, but only to port 443) through.
 - Can be run on shared machine. If you have web space on machine shared
   by many people, you can set up your own gitweb, but cannot/are not allow=
ed
   to start your own network server for git native protocol.
 - Less things to set up. If you are setting up gitweb anyway, you'd not ne=
ed
   to set up additional thing for providing fetch access.

Than a question is how to implement it. The current protocol is stateful on
both sides, but the stateless nature of HTTP more or less requires the
protocol to be stateless on the server.

I think it would be possible to use basically the same protocol as now, but
make it stateless for server. That is server first sends it's heads and than
client repeatedly sends all it's wants and some haves until the server acks
all of them and sends the pack.

Alternatively I am thinking about using Bloom filters (somebody came with
such idea on the bzr list when I still followed it). It might be useful, as
over HTTP we need to send as many haves as possible in one go.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGShOeRel1vVwhjGURApAkAJ42OBt0Lj+q8jr1/xqPWMGYCb22LQCg0uE9
7kKvFUYjelKRe0cMZhgerwY=
=hDuY
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
