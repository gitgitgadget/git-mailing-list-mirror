From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: extra headers in commit objects
Date: Wed, 03 Feb 2010 21:58:22 +0100
Message-ID: <1265230702.7429.54.camel@ganieda>
References: <20100203174041.GC14799@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-6Lxazg/X9qYqURBdkFsQ"
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 22:07:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcmRV-0005M9-44
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 22:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903Ab0BCVHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 16:07:16 -0500
Received: from gwenhwyvar.vernstok.nl ([92.243.4.181]:45789 "EHLO
	gwenhwyvar.vernstok.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab0BCVHO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 16:07:14 -0500
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2010 16:07:13 EST
Received: from ganieda (localhost [127.0.0.1])
	by gwenhwyvar.vernstok.nl (Postfix) with ESMTP id 4B7DB267CC;
	Wed,  3 Feb 2010 20:58:26 +0000 (UTC)
Received: by ganieda (Postfix, from userid 1000)
	id A3F7B5F175; Wed,  3 Feb 2010 21:58:24 +0100 (CET)
In-Reply-To: <20100203174041.GC14799@spearce.org>
X-Mailer: Evolution 2.28.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138899>


--=-6Lxazg/X9qYqURBdkFsQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Wed, 2010-02-03 at 09:40 -0800, Shawn O. Pearce wrote:
> Am I correct that core C developers are still under the opinion
> that extra headers in a commit object aren't encouraged?
>=20
> That is, we shouldn't see something like this made-up example:
>=20
>   $ git cat-file commit HEAD
>   tree e0fb24d872e2daa1507ea5879e1cdce5c0da9902
>   parent ec0865178ad6d8dab9ccd82b07bc3f3dae20542a
>   parent 89d61592bddda4dfcb90314be9e06479f712bb7f
>   author Junio C Hamano <gitster@pobox.com> 1265176189 -0800
>   committer Junio C Hamano <gitster@pobox.com> 1265176189 -0800
>   bug 18389
>   url http://example.com/some/mailing/list/post
>   message-id <gitster-182819131@gitster.computer>
>=20
>   Merge git://repo.or.cz/git-gui into next
>=20
> (Sorry Junio for picking on your latest next merge...)

> Today I came across this "bug fix" [1,2] in Dulwich, which is
> claiming to be a pure-Python implementation of Git.
>=20
> [1] http://git.samba.org/?p=3Djelmer/dulwich.git;a=3Dcommit;h=3Dbc8d73f11=
46afba8828a7dadbb4320f592cddcab
> [2] http://git.samba.org/?p=3Djelmer/dulwich.git;a=3Dcommitdiff;h=3Dbc8d7=
3f1146afba8828a7dadbb4320f592cddcab;hp=3D4e50426fb72e6c9259feecbba5bfcf053a=
f62335
>=20
> I haven't spoken with Jelmer Vernooij directly about it, but after
> some indirect email through a 3rd party, it seems he might be under
> the impression that this really is a bug in Dulwich, because "other
> git implementations do it".
If you have concerns like this in the future, please don't hesitate to
contact me directly. I don't follow the git list because it's a
high-volume list where pretty much all traffic is irrelevant to me. The
only reason I became aware of this thread was because Sverre CC'ed me.

> Uhm.
Originally I was under the impression that custom headers would break
(by reading the C Git source code) and so Dulwich made that assumption,
but after hearing from several people (among whom Scott, see his reply)
at Linux.Conf.Au that custom headers could be added and were ignored by
C git I made this change.

Since Dulwich would blow up when it encountered custom headers that
might be set by other Git implements and since (as I understand) C git
ignores unknown headers, I called this a bug fix. This change made it
possible to deal with custom headers whenever they would appear *and*
allowed users of the Dulwich API to set custom headers.=20

(FWIW I haven't actually seen anybody setting custom headers)

If this is indeed a misunderstanding, I'll happily make this
datastructure with custom headers read-only.

[...]
> Yes, there are many other Git implementations.  But I thought nearly
> all of them were toys, and none of them were even close to serving
> the kind of production volume that JGit serves, and JGit isn't even
> considered a production library by most.  Yet JGit always tries to
> conform to whatever standard is set by the C implementation.
So does Dulwich. I've fixed issues in the compatibility with C Git when
I've noticed them or have been made aware of them. Any incompatibilities
are the result of ignorance on my part rather than malicious intent.

[...]

> We're starting to see a fork in the basic protocols happen.  Hell,
> Dulwich 0.4.1 isn't even capable of speaking over the network to
> C Git, but it does talk to itself, so its valid, right?  :-(
I've been using Dulwich's client to talk to C Git servers for ages and
haven't seen issues. I would appreciate hearing about
incompatibilities.=20

If you're talking about the server side - we know it's broken, at least
dul-daemon. Nobody (except for API changes) has really cared about it
since John Carr originally hacked it up. I'd be surprised if it even
works with the Dulwich client.

Cheers,

Jelmer

--=-6Lxazg/X9qYqURBdkFsQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJLaeNXAAoJEACAbyvXKaRX41gP/AlPYz8fq+FD4PXe2Z1NVyWy
ttxeLd/sx4CL9dFqW1MustYuCCBGCST6Mte9Frg1oFoMXvWmWkQ70l9rQpM6Eo3b
8GPDdUgsoqA6ahGfSxjnz4y0zuJ/WmEwAtcJFhtHqOUNyJN7XjIuv1HXmHDRheSG
sC+D980DHI8ZZsuJ+lZ0VUSh7TWUrx5zrAV/vxB23RN2/3sci1183OaaZ7EoWPQp
p/iFcfc7/F6d1IWJTdjWLAr5K+HhbYrJWUMXdvdMDBQQhPRSmkTyGCPUZH7Uc7BH
Nq+ci4eoupu1/8p5xxWjUCbFazcBkyD2brPQDMbMcYd7qop1fryR+9T9B1sBB9QW
FQbEOU8gwn1/wfgSyoPXa0VU33EDtQmz5rVtl1tmOlPKThRn7Di0hCX/ZsQmVTjB
J6fv8kXNjjuOgMZ5NKJTuH57cx0cosrkT5UKUr6kNIabsX/EQS2+pDfwjkR7HUmZ
dj06d1EzDpoDV8gPlGdDVTlXwKP5lrSC8zzdLmFlqIVhSPqHiZ4jZsM4yC2AgXaD
k/e31iFLhvIuNtPymfq0tP5iK9VE5RIqMQdZPvVKTt2p7aXOJ0B0RDLsGSruONBw
k32YWLTA6G50GwLG7Gpgwm9RSRKAxtXYbjpb5SSBWAMP8UqpuZUH6dCfjGvtVszQ
bmrL05uBsbMx2kRdrLNv
=CYkT
-----END PGP SIGNATURE-----

--=-6Lxazg/X9qYqURBdkFsQ--
