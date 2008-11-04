From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git send-email: allow any rev-list option as an   argument.
Date: Tue, 04 Nov 2008 09:19:31 +0100
Message-ID: <20081104081931.GA3788@artemis.corp>
References: <1225450632-7230-3-git-send-email-madcoder@debian.org> <1225471925-2750-1-git-send-email-madcoder@debian.org> <20081102043523.GE5261@coredump.intra.peff.net> <20081102093907.GF4066@artemis> <20081102180220.GA5726@sigio.intra.peff.net> <20081103091513.GC13930@artemis.corp> <7vej1sti78.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="UlVJffcvxoiEqYs2";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 09:20:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxH9h-0003w8-Mn
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 09:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbYKDITg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 03:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbYKDITf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 03:19:35 -0500
Received: from pan.madism.org ([88.191.52.104]:45828 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484AbYKDITe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 03:19:34 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 388673BEA8;
	Tue,  4 Nov 2008 09:19:33 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B0AE5110A3F; Tue,  4 Nov 2008 09:19:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vej1sti78.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100053>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2008 at 01:04:27AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > As a summary, I'd say that I like both (1) and (3) because those are
> > handy, short, and either completely or mostly backward compatible. My
> > way would be to go down (1) and add a alias.s-e =3D !git send-email -F =
in
> > my .gitconfig.
> >
> > What do you think ?
>=20
> I wonder if we can do this even without an explicit -F.
>=20
> What command line arguments does send-email take, and what options would
> we want to give the underlying format-patch?  Can't you sift them without
> ambiguity?
>=20
> The current syntax is:
>=20
>     git send-email <flags>... <file|dir>...
>=20
> I am wondering if we can just extend it to:
>=20
>     git send-email <flags>... <<file|dir>...|rev>
>=20
> E.g. we should be able to parse this out:
>=20
>     git send-email --to git@vger.kernel.org -M --suppress-cc=3Dall origin
>=20
> and notice "--to git@vger.kernel.org" and "--suppress-cc" are for
> send-email, guess "-M" (or anything that is outside the current
> send-email's vocabulary) is meant for format-patch, and if there is no
> file or directory called "origin" then decide that the user wants to run
> format-patch, and act as a front-end as if the user did:
>=20
> 	git format-patch -o tmp.$$ -M origin &&
>         ... perhaps do your --annotate and --compose here by launching
>         ... the editor...
>         git send-email --to git@vger.kernel.org --suppress-cc=3Dall tmp.$=
$ &&
> 	rm -fr tmp.$$
>=20
> If you happen to have a file or a directory called origin, it would be
> safer for users if the command errored out asking for disambiguation.  The
> user can either say "./origin" or "origin^0" to disambiguate between them.

Oh right you can disambiguate references using ^0 so maybe my proposal
works after all, though it has to check for each file name if it's not a
reference _also_. I like it. I will rework my patch series now then,
since most of the discussed points of them have been addressed in the
thread.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkQBZIACgkQvGr7W6HudhzpzQCfb5NeS1oODPSvxNURFXi5vpc3
8U0AoJS4JFJ1ZdxRiSUTIEn4Hip11ndw
=YBMS
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
