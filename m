From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt restriction.
Date: Mon, 17 Dec 2007 10:07:49 +0100
Message-ID: <20071217090749.GC7453@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <20071213102636.GD12398@artemis.madism.org> <7vd4t5eq52.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="pAwQNkOnpTn9IO2O";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 10:08:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4BxQ-0005oN-7S
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 10:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbXLQJHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 04:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbXLQJHw
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 04:07:52 -0500
Received: from pan.madism.org ([88.191.52.104]:44457 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830AbXLQJHv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 04:07:51 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 85A4930627;
	Mon, 17 Dec 2007 10:07:50 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id F17B76703; Mon, 17 Dec 2007 10:07:49 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd4t5eq52.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68525>


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 07:28:41AM +0000, Junio C Hamano wrote:
> The command freely used optional option-argments for its -l and -n option=
s.
> I think allowing "git tag -n xxx" without barfing was an error to begin w=
ith,
> but not supporting "git tag -l pattern" form is a serious regression.
>=20
> So this fixes the handling of -l to reinstate the original behaviour while
> detecting a user error "git tag -l pattern garbage", and adjusts tests th=
at
> use "-n param" form to use "-nparam".

> -	if (list)
> +	if (list) {
> +		/*
> +		 * This is unfortunate but requiring "git tag -lpattern" and not
> +		 * allowing "git tag -l pattern" is a serious regression.
> +		 */
> +		if (argc && list =3D=3D no_pattern) {
> +			list =3D argv[0];
> +			argc--;
> +		}
> +		if (argc)
> +			die("extra argument after -l[pattern]: %s", argv[0]);
>  		return list_tags(list =3D=3D no_pattern ? NULL : list, lines);
> +	}

  Okay this is kind of disgusting, and I'm absolutely not pleased with
it (I mean I'm not pleased that parse_opt forces us to write things like
that). This hack allows:

  git tag -l -n10 <pattern>

and will then attach the <pattern> to the '-l' switch, and I find it
nowhere near acceptable. I believe the fix is worse than the disease.
I'll try to think harder about what we can do about it. Though for now,
we will have to go for it for a while.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZjxlvGr7W6HudhwRAsl8AKCfquNE6kTwEuhhQZAiA35G+038yQCdGOPM
atLvSnp8ArMCb+rPiUIevmo=
=nWrL
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
