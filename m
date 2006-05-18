From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Fwd: [OT] Re: Git via a proxy server?
Date: Thu, 18 May 2006 10:31:32 +0200
Message-ID: <20060518083132.GG23642@lug-owl.de>
References: <446B00CE.9000609@vmware.com> <20060518034428.42456.qmail@web32002.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vj77qGokqwYdeLil"
Cc: Petr Vandrovec <petr@vmware.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 10:31:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgduz-0007We-8V
	for gcvg-git@gmane.org; Thu, 18 May 2006 10:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWERIbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 04:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWERIbe
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 04:31:34 -0400
Received: from lug-owl.de ([195.71.106.12]:2260 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751096AbWERIbe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 04:31:34 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 02A72F003E; Thu, 18 May 2006 10:31:33 +0200 (CEST)
To: Sam Song <samlinuxkernel@yahoo.com>
Mail-Followup-To: Sam Song <samlinuxkernel@yahoo.com>,
	Petr Vandrovec <petr@vmware.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060518034428.42456.qmail@web32002.mail.mud.yahoo.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20274>


--vj77qGokqwYdeLil
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 20:44:28 -0700, Sam Song <samlinuxkernel@yahoo.com> wrot=
e:
> Petr Vandrovec <petr@vmware.com> wrote:
> > Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> > > Well, install some package to have `socket'
> > > available? Debian calls
> > > the packet `socket', too, so I guess Fedora may
> > > have something similar.
> >=20
> > Surprisingly they do not...  You should be able to
> > replace 'socket' with=20
> > 'netcat' - and I believe that netcat/nc package is
> > available for Fedora.  For=20
> > this purpose they have same command line & behavior.
>=20
> Ummm, I am trying on that. nc is avaiable for Fedora.
> But what could be the replacement for CONNECT in
> Fedora? :-)

Erm, you haven't understood what you're doing there, have you?

With the GIT_PROXY_COMMAND helper, you're expected to create a clean
tunnel which in turn git can use to transfer its data.

You've only got some limited internet connectivity via a HTTP proxy
available, so you need to use this. This means:

  * The proxy administrator needs to allos outgoing connections for
    the CONNECT method with git's TCP port.
  * You need to have some minimalistic program to initially speak HTTP
    with the proxy and later on just stream the raw git protocol
    through the link.
  * You may or may not need to strip anything that came into the git
    stream by accident because you tunnled it through a HTTP proxy. A
    reply message from the proxy server is an example for this.

So this little script (using "CONNECT" and netcat or socket) does the
first part: it talks in the language HTTP with the proxy server. It
may be enough to just use CONNECT, but you may need to speak some more
lines, eg. for proxy authorization.

The first `cat' in there is just for pushing the git protocol though the
HTTP proxy connection later on (hopefully after the proxy was made to
accept the the CONNECT request.)  Once the proxy accepted it, it'll
send you a HTTP/200 message (or something like that) and an empty
line. This is what the two reads are for; the next `cat' simply again
transfers all the rest (the git protocol).

To draw the line, there's not _one_ solution to HTTP proxy tunneling,
there are many, and you'll need to design one that fits your network.
It should be quite simple, given that you've got nice tools like
`strace' and `tcpdump', which will help you to understand how the
proxy reacts and so on.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--vj77qGokqwYdeLil
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEbDDkHb1edYOZ4bsRAo6XAJ40CQUYeLZBPxrIAu4fVYYWjXPu1wCfbibn
QOOo0c0hBxwB7256I+kZK+s=
=WvS3
-----END PGP SIGNATURE-----

--vj77qGokqwYdeLil--
