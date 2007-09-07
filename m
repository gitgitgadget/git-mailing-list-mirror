From: Keith Packard <keithp@keithp.com>
Subject: Re: rebase from ambiguous ref discards changes
Date: Thu, 06 Sep 2007 19:58:18 -0700
Message-ID: <1189133898.30308.58.camel@koto.keithp.com>
References: <1189115308.30308.9.camel@koto.keithp.com>
	 <7vsl5r8jer.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Hs2CDgjTCinNKN3opgbP"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 04:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITU3c-0000b2-Ao
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 04:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbXIGC6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 22:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbXIGC6u
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 22:58:50 -0400
Received: from home.keithp.com ([63.227.221.253]:4995 "EHLO keithp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932632AbXIGC6t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 22:58:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 6FA931141EA;
	Thu,  6 Sep 2007 19:58:48 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IaRxesWYPNM5; Thu,  6 Sep 2007 19:58:45 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 7DC3E1141E6; Thu,  6 Sep 2007 19:58:45 -0700 (PDT)
Received: from koto.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 6F48E1141E0;
	Thu,  6 Sep 2007 19:58:45 -0700 (PDT)
Received: by koto.keithp.com (Postfix, from userid 1488)
	id B6D2A63454B; Thu,  6 Sep 2007 19:58:20 -0700 (PDT)
In-Reply-To: <7vsl5r8jer.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57966>


--=-Hs2CDgjTCinNKN3opgbP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-09-06 at 16:26 -0700, Junio C Hamano wrote:

> We haven't touched this area for a long time (like "v1.3.0" or
> "since March 2006").  I wish you told us about this earlier.

I would have were I certain that it wasn't user-error last time. I took
a few minutes this time to verify precisely what I saw and reproduce it.

> I'd like to reproduce this, but I need to be sure what your
> "ambiguous" situation is really like.  What ambiguous "master"s
> do you have?  IOW, what does:
>=20
> 	git show-ref | grep master

$ git show-ref | grep master
286f5df0b62f571cbb4dbf120679d3af029b8775 refs/heads/master
1feb733eb8b09a8b07b7a6987add5149c53b0157 refs/heads/master-guitar
d957c6b8e1dde8e11c1db3431e0ff58c5d984880 refs/heads/master-i830
0fd3ba0518b3cde9ca0e4e2fc1854c00d8a43d5c refs/remotes/kyle/master
e25f8e145f4f73b62c32389b922291fd561af9d2 refs/remotes/origin/lg3d-master
286f5df0b62f571cbb4dbf120679d3af029b8775 refs/remotes/origin/master
e25f8e145f4f73b62c32389b922291fd561af9d2 refs/remotes/otc/lg3d-master
6781575f734f05547d7d5ceef4116fc157bba44d refs/remotes/otc/master

so, nothing obviously amiss here.

> Perhaps you have ".git/master" by mistake?

oops.

$ find .git -name master
.git/master
.git/refs/heads/master
.git/refs/remotes/kyle/master
.git/refs/remotes/origin/master
.git/refs/remotes/otc/master
.git/logs/refs/heads/master
.git/logs/refs/remotes/fdo/master
.git/logs/refs/remotes/kyle/master
.git/logs/refs/remotes/origin/master
.git/logs/refs/remotes/otc/master

So, I think that explains where the ambiguous master came from.  Seems
like rebase should be able to bail out before breaking things though.

--=20
keith.packard@intel.com

--=-Hs2CDgjTCinNKN3opgbP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4L5KQp8BWwlsTdMRAlFuAKDoCFGdwxWKKvW46m5cY9H4m0lFHwCgw+tm
KmfuVSh1Jm/M6jaHtsvQq+E=
=ys/4
-----END PGP SIGNATURE-----

--=-Hs2CDgjTCinNKN3opgbP--
