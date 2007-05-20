From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Smart fetch via HTTP?
Date: Sun, 20 May 2007 12:30:10 +0200
Message-ID: <20070520103010.GA27087@efreet.light.src>
References: <20070515201006.GD3653@efreet.light.src> <20070517124006.GO4489@pasky.or.cz> <vpqlkfnipjl.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org> <20070518190159.GS24644@ca-server1.us.oracle.com> <alpine.LFD.0.98.0705181312060.3890@woody.linux-foundation.org> <20070518215607.GT24644@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Sun May 20 12:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpigJ-0006IR-Ql
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbXETKa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755865AbXETKa0
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:30:26 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:1343 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755568AbXETKa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 06:30:26 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.403878;
	Sun, 20 May 2007 12:30:10 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hpify-0007Ci-P8; Sun, 20 May 2007 12:30:10 +0200
Content-Disposition: inline
In-Reply-To: <20070518215607.GT24644@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47819>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2007 at 14:56:07 -0700, Joel Becker wrote:
> On Fri, May 18, 2007 at 01:13:36PM -0700, Linus Torvalds wrote:
> > If it's _just_ the initial GET/CONNECT strings, yeah, we could probably=
=20
> > easily make the git-daemon just ignore them. That shouldn't be a proble=
m.
> >=20
> > But if there's anything *else* required, it gets uglier much more quick=
ly.
>=20
> 	With CONNECT, there isn't anything.  That is, your
> GIT_PROXY_COMMAND handles talking to the proxy, then gives git itself a
> raw data pipe.  My proxy allows CONNECT to 9418, and that's how I use it
> today.

Yes. Connect is easy. However many companies only allow CONNECT to 443
(not that it's much more secure than allowing it anywhere, but at least it
has to block CONNECT to 25 to block sending spam).

> 	If you tried to make POST work (It'd be POST, not GET, as you
> need to connect up the sending side), either apache would have to front
> it for us, or "git-daemon --http" would have to accept the HTTP headers
> on before the input, and output a proper HTTP response before sending
> output.  Seeing the headers would allow for us to vhost, even.
> 	Hmm, but the proxy may not allow two-way communication.  Does
> the git protocol have more than one round-trip?  That is:
>=20
> Client:
>     POST http://server.git.host:80/projects/thisproject HTTP/1.1
>     Host: server.git.host
>=20
>     fetch-pack <sha1>
>     EOF
>=20
> Server:
>     200 OK HTTP/1.1
>    =20
>     <data>
>     EOF
>=20
> should work, I'd think.

Well, that does not require git at all -- apache can handle this all right.
But it's not network-efficient. To be network-efficient, it is necessary to
negotiate the list of objects that need to be send. And that requires more
than one round-trip. Additionally, the current git protocol is streaming --
the client sends data without waiting for the server. So it would require
slightly different protocol over HTTP.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUCMyRel1vVwhjGURAicDAJ9+cQWsBDzRw/ARKoDfWuHJFuoU5gCg52Cx
Aj12w5YPHsJ71XxtYYzkBiU=
=8aY3
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
