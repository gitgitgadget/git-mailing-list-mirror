From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs and unnamed branches
Date: Fri, 16 Jun 2006 22:30:46 -0700
Message-ID: <1150522246.6983.52.camel@neko.keithp.com>
References: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
	 <1150496362.6983.34.camel@neko.keithp.com>
	 <9e4733910606162002x508ec6ccjbc36e4220ca44fd6@mail.gmail.com>
	 <1150513943.29738.15.camel@dv>
	 <9e4733910606162031o69df27fdje50c88949ed990b5@mail.gmail.com>
	 <1150517336.9144.8.camel@dv>
	 <9e4733910606162115g2165212bgf32a2e328cce751a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xDd9Gk+zY8GOQBxMgUOz"
Cc: keithp@keithp.com, Pavel Roskin <proski@gnu.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 07:31:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrTP1-0006Es-N1
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 07:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWFQFbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 01:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWFQFbV
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 01:31:21 -0400
Received: from home.keithp.com ([63.227.221.253]:44045 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750856AbWFQFbU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 01:31:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 0320913001F;
	Fri, 16 Jun 2006 22:31:19 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 03977-06; Fri, 16 Jun 2006 22:31:18 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 9628D13001E; Fri, 16 Jun 2006 22:31:18 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 4662214001;
	Fri, 16 Jun 2006 22:31:18 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id D30F76AC09F; Fri, 16 Jun 2006 22:30:47 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606162115g2165212bgf32a2e328cce751a@mail.gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22002>


--=-xDd9Gk+zY8GOQBxMgUOz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-06-17 at 00:15 -0400, Jon Smirl wrote:

> >>But the real problem is why does it think the branches are in a loop?

I haven't figured it out yet either; mine didn't detect the loop though,
it just ended up spinning in the tsort code, unable to compute a valid
order to execute branches in. Something funky must be up with the
mozilla branches.

What this code does is find an order that will 'work' when computing
branch contents. The requirement is that the 'parent' branch be computed
before any 'child' branches.=20

It does this with a nice quadratic algorithm, building a list of 'ready'
branches who have no 'unready' dependencies in any of the incoming file
objects. If there are conflicts where one incoming file shows branch 'B'
as the parent of branch 'A' while another shows branch 'A' as the parent
of branch 'B', the sorting cannot succeed.

Ideally, I'd figure out a way to eliminate the parent/child relationship
and just treat the branches as peers with a common ancestor. I haven't
figure out how to manage that yet; attempting to find the precise
divergence point where the child forks from the parent remains
complicated, it seems like trying to do that without a strong
parent/child relationship would be even more error prone.

Better error messsages here would clearly help discover which branches
were in conflict, and show the files causing problems.

--=20
keith.packard@intel.com

--=-xDd9Gk+zY8GOQBxMgUOz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEk5OGQp8BWwlsTdMRAuyZAKC3URBHR/SWgG7azMqKe3efGNxNZwCdFAVA
GEIKF8z/MtdbBnKRMDneSH8=
=ShEA
-----END PGP SIGNATURE-----

--=-xDd9Gk+zY8GOQBxMgUOz--
