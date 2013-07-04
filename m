From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] send-email: provide port separately from hostname
Date: Thu, 4 Jul 2013 23:11:00 +0000
Message-ID: <20130704231059.GT862789@vauxhall.crustytoothpaste.net>
References: <1372975492-981035-1-git-send-email-sandals@crustytoothpaste.net>
 <CALkWK0mJAx+-iZ0e+jRQE14Vve=ea=fbzgmNEjUh5ANpDCriCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kD0q5DIPXzY/lIlp"
Cc: git@vger.kernel.org, gitster@pobox.com, krzysiek@podlesie.net
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 01:18:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UusnH-0003RI-3a
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 01:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab3GDXSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 19:18:13 -0400
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:45786
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753122Ab3GDXSM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jul 2013 19:18:12 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jul 2013 19:18:12 EDT
Received: from omta13.westchester.pa.mail.comcast.net ([76.96.62.52])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id wP9Y1l00517dt5G5BPB5sy; Thu, 04 Jul 2013 23:11:05 +0000
Received: from castro.crustytoothpaste.net ([173.11.243.49])
	by omta13.westchester.pa.mail.comcast.net with comcast
	id wPB31l01514fh3h3ZPB4HL; Thu, 04 Jul 2013 23:11:05 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 426D228057;
	Thu,  4 Jul 2013 23:11:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALkWK0mJAx+-iZ0e+jRQE14Vve=ea=fbzgmNEjUh5ANpDCriCA@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1372979465;
	bh=RhhYpWHB7QF4b2ygpkP7xk72RMv8xb9YMDe09Mt0+vw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=RiEH8ft49R3GBiXxdMg3BzsFIaiKbnmDSp2ikl8yldmBsn3ZCcF7/YqvE9qGs2qTv
	 MX2PCk2fmcfdaImu0TTbgq71lxqO7H9a9DHFliOcTjS/Jiu5RncJxK5O5TKhqdglMM
	 emsArnxVPdVOEjwrlHlmMP15dhTPUnmU6rjvmDXQ8VO3FmBPaY82Cq8fYQk0dZu3dg
	 c0n9bLr4/enjbw1BPhTXoIrU5bMl2qtuTZ2Q9LOefqYVW/dKTKEtYL/Q+m1L6qOCGZ
	 FCpYiFqzkr5KPrm4eXP98LPJc6IdUK4y5KdyZU5Zp9hWYpfV0zaPhPPz/wsRUcZ6fC
	 TUbJo7mirMauQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229623>


--kD0q5DIPXzY/lIlp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2013 at 04:12:19AM +0530, Ramkumar Ramachandra wrote:
> Hm, so the problem occurs when you give smtp_host_string() to
> Net::SMTP->new() as the first argument.

Yes.  I created a test program, and Net::SMTP was fine as long as I used
Port, but failed when I included the port in the hostname string.
Arguably this is a bug in Net::SMTP.

> So if smtp_host_string() returns a hostname without a port, then
> Net::SMTP->new() will connect to port 25 by default?

Correct.  Port 25 is the default for Net::SMTP, so there's no change in
behavior.

> I need to be in a (firewalled?) network that uses Kerberos to
> reproduce this, right?  Even if I can't reproduce it, the change seems
> to be fine.

You need to have access to a mail server that will only relay when
authenticated, and only accepts GSSAPI.  My personal server accepts
GSSAPI always and PLAIN only when TLS is enabled, so I just turned off
TLS temporarily to test.

As for Kerberos, yes, you'd need to have it set up to reproduce this.

> While we're on the subject, do you know how to get rid of this huge
> ugly warning I get everytime I send emails?
>=20
> *******************************************************************
>  Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
>  is deprecated! Please set SSL_verify_mode to SSL_VERIFY_PEER
>  together with SSL_ca_file|SSL_ca_path for verification.
>  If you really don't want to verify the certificate and keep the
>  connection open to Man-In-The-Middle attacks please set
>  SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
> *******************************************************************
>   at /home/artagnon/src/git/git-send-email line 1200.

You need to explicitly specify an SSL_verify_mode argument to start_SSL.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--kD0q5DIPXzY/lIlp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJR1gEDAAoJEL9TXYEfUvaLqwAP/An6QJnAuNQ+5XZKk0NKN6IU
Qo5+0gedTbIA9al3gCpfTjbuF8rUfJVFfXuKeMbGGTIIJlIQrIbS7cDlcboWATOw
ndQXyDo2kkQOBbtrsSetvPRC1/17TpzQPiVlR6SrEteJhqdYi9KoC5cVKbDbQTnu
iTx8SRfL2JUU2vq81HfL8bAPMfVhu0Mk4DpCieTL+rXFBd48GRIBiva37xJWOBCh
HtzQ7qPgzop+8IhpNJ0hzXWZzRw/wBGg4f8X92+M11qW/yaTIRqlK+otLdC+PRfk
nRnLQcmtEuUhkPprHcAkovf7cZku1qsh9DHCD4ZawYzLOVyT0ZmOPvwXYd7K31nM
f2QAAJyRp83jL+nSju++rhJNEBMJDz+Qi6DEZ8nGHbKNuok8DlXd/5/u2A7W+fh3
6X2xRQ3Jru420GWDqg7RKhkBIQTQxXEDIvDAufRJmMiQLuKaw3DEPgRBbHm5OTZp
IwxLnluNVP7SUubdK/TotXTOUveoN9RusSUpHHNJrsPNpoPvrlQuRT9elHJOhrXK
f66aMoE322vsxzuEpVPePG5oQgTup/srCnUsmS/I/tWRGTleqxgMZkS5BUItQg0m
yevMMt+NhB/mfGOAm4EBUpYJTyDtDVCoj1DYFOH3tAPwal2WNAusKhrXgZ4WoTCM
6HCOTiG/SOL4W0kKzd3j
=F/6Z
-----END PGP SIGNATURE-----

--kD0q5DIPXzY/lIlp--
