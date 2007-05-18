From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 19:51:55 +0200
Message-ID: <20070518175155.GB3327@efreet.light.src>
References: <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com> <Pine.LNX.4.64.0705161232120.6410@racer.site> <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com> <Pine.LNX.4.64.0705170152470.6410@racer.site> <20070517010335.GU3141@spearce.org> <alpine.LFD.0.99.0705162309310.24220@xanadu.home> <Pine.LNX.4.64.0705171143350.6410@racer.site> <alpine.LFD.0.99.0705170954200.24220@xanadu.home> <20070517200431.GA3079@efreet.light.src> <Pine.LNX.4.64.0705180958390.6410@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 18 19:52:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp6cq-00080a-II
	for gcvg-git@gmane.org; Fri, 18 May 2007 19:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbXERRwQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 13:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbXERRwQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 13:52:16 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:2108 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754259AbXERRwP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 13:52:15 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.372511;
	Fri, 18 May 2007 19:51:55 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hp6cN-00012q-PX; Fri, 18 May 2007 19:51:55 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705180958390.6410@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47623>


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2007 at 10:01:52 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 17 May 2007, Jan Hudec wrote:
>=20
> > On Thu, May 17, 2007 at 10:41:37 -0400, Nicolas Pitre wrote:
> >
> > > And if you have 1) the permission and 2) the CPU power to execute suc=
h=20
> > > a cgi on the server and obviously 3) the knowledge to set it up=20
> > > properly, then why aren't you running the Git daemon in the first=20
> > > place?  After all, they both boil down to running git-pack-objects an=
d=20
> > > sending out the result.  I don't think such a solution really buys=20
> > > much.
> >=20
> > Yes, it does. I had 2 accounts where I could run CGI, but not separate=
=20
> > server, at university while I studied and now I can get the same on=20
> > friend's server. Neither of them would probably be ok for serving large=
r=20
> > busy git repository, but something smaller accessed by several people i=
s=20
> > OK. I think this is quite common for university students.
>=20
> 1) This has nothing to do with the way the repo is served, but how much=
=20
> you advertise it. The load will not be lower, just because you use a CGI=
=20
> script.

That won't. But that was never the purpose of "smart cgi". The purpose was =
to
minimize the bandwidth usage (and connectivity is still not so cheap that
you'd not care) while still working over http either because the users need
to access it from behind firewall or because administrator is not willing to
set up git-daemon for you, while CGI you can run yourself.

> 2) you say yourself that git-daemon would have less impact on the load:

NO, I didn't -- at least not in the paragraph below.

In the below paragraph I said, that *network* use will never be as good with
*dumb* solution, as it can be with smart solution, no matter whether it is
over special protocol or HTTP.

---

Of course it would be less efficient in both CPU and network load, because
there is the overhead of the web server and overhead of the http headers.

Actually I like the ranges solution. If accompanied with repack stategy that
does not pack everything together, but instead creates packs of limited
number of objects -- so that the indices don't exceed configurable size, say
64kB -- could not so much less efficient for the network and have the
advantage of working without ability to execute CGI.

> > > [...]
> > >
> > > Et voil=C3=A0.  Oh, and of course update your local refs from the=20
> > > remote's.
> > >=20
> > > Actually there is nothing really complex in the above operations. And=
=20
> > > with this the server side remains really simple with no special setup=
=20
> > > nor extra load beyond the simple serving of file content.
> >=20
> > On the other hand the amount of data transfered is larger, than with th=
e=20
> > git server approach, because at least the indices have to be transfered=
=20
> > in entirety.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGTee7Rel1vVwhjGURApLZAJ921IPfciA6GOs1HFMOp4KXtunv0gCfXEX4
80zSYxAplmjKWBydrj5J8pM=
=s8cB
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
