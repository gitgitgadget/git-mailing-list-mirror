From: Andre Noll <maan@systemlinux.org>
Subject: Re: git-daemon problem
Date: Thu, 13 Jul 2006 13:42:21 +0200
Message-ID: <20060713114221.GU11245@skl-net.de>
References: <E1G0QeX-0003hG-0I@moooo.ath.cx> <7vlkqz1lja.fsf@assigned-by-dhcp.cox.net> <E1G0kNV-0006LK-QW@moooo.ath.cx> <7vveq2ukho.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZVTVymsHR1TEBjP"
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 13:42:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0zai-0005As-ID
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 13:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWGMLmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 07:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWGMLmc
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 07:42:32 -0400
Received: from systemlinux.org ([83.151.29.59]:17643 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1751323AbWGMLmc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 07:42:32 -0400
Received: from maan by m18s25.vlinux.de with local (Exim 3.36 #1 (Debian))
	id 1G0zaH-0002Hz-00; Thu, 13 Jul 2006 13:42:21 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vveq2ukho.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23825>


--4ZVTVymsHR1TEBjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22:44, Junio C Hamano wrote:

> The only "right" solution I could think of is to properly
> daemonize git-daemon when not running under --inetd mode.  Close
> and open /dev/null the low three fds, and dissociate the process
> from the controlling terminal (did I forget anything else --
> perhaps chdir("/") at the top?).  And we keep the current
> behaviour of assuming the sane set of low three fds when a new
> option --debug is given to help people look at its stderr.  The
> tentative patch to upload-pack would become moot at that point.
>=20
> Hmm?

A common solution for this problem is=20

	while (1) {
		int     fd;

		fd =3D open("/dev/null", O_RDWR);
		if (fd < 0)
			exit(EX_OSERR);
		if (fd > 2) {
			close(fd);
			break;
		}
	}

See

	http://rechner.lst.de/~okir/blackhats/node41.html

Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--4ZVTVymsHR1TEBjP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEtjGdWto1QDEAkw8RApu5AKCROeTS6w/ONuPbnaC50x/KO36nxgCfcIY5
q0uW3gNoYY10wCQ+WqN/QpU=
=kOZd
-----END PGP SIGNATURE-----

--4ZVTVymsHR1TEBjP--
