From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 10:24:47 +0200
Message-ID: <20080624082447.GB24357@artemis.madism.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <7vzlpbeksn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="K8nIJk4ghYZn606h";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 10:26:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB3qf-0006xl-11
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 10:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbYFXIYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 04:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758650AbYFXIYx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:24:53 -0400
Received: from pan.madism.org ([88.191.52.104]:39814 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759105AbYFXIYt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:24:49 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B6D4E38050;
	Tue, 24 Jun 2008 10:24:48 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 97D10351FE9; Tue, 24 Jun 2008 10:24:47 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vzlpbeksn.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86015>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 12:30:48AM +0000, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>=20
> > On Mon, 23 Jun 2008, Linus Torvalds wrote:
> >>=20
> >> Umm. Helloo, reality.. There are actually very few options that take a=
=20
> >> flag for their arguments. In particular, the option parsing we really=
=20
> >> _care_ about (revision parsing - see builtin-blame.c which is exactly=
=20
> >> where I wanted to convert things) very much DOES NOT.
> >
> > Actually, I guess "--default" does, but if you try to mix that up with =
(a)=20
> > a default head that starts with a dash and (b) git-blame, you're doing=
=20
> > something pretty odd.
> >
> > And yes, "-n" does too, but if you pass it negative numbers you get wha=
t=20
> > you deserve.
> >
> > The point being, we really _do_ have a real-life existing case for=20
> > PARSE_OPT_CONTINUE_ON_UNKNOWN, which is hard to handle any other way.=
=20
> > Currently you can literally do
> >
> > 	git blame --since=3DApril -b Makefile
> >
> > and while it's a totally made-up example, it's one I've picked to show=
=20
> > exactly what does *not* work with my patch that started this whole thre=
ad.
> >
> > And guess what you need to fix it?
> >
> > If you guessed PARSE_OPT_CONTINUE_ON_UNKNOWN, you win a prize.=20
>=20
> With this on top of Pierre's series, and adding PARSE_OPT_SKIP_UNKNOWN to
> the obvious place in your patch, "blame --since=3DApril -b Makefile" would
> work.
>=20
> -- >8 --
> Subject: [PATCH] parse-options: PARSE_OPT_SKIP_UNKNOWN
>=20
> ---
>  parse-options.c |   14 ++++++++++----
>  parse-options.h |    1 +
>  2 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/parse-options.c b/parse-options.c
> index 71a8056..9f1eb65 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -341,20 +341,26 @@ int parse_options(int argc, const char **argv, cons=
t struct option *options,
>  	struct parse_opt_ctx_t ctx;
> =20
>  	parse_options_start(&ctx, argc, argv, flags);
> +
> + again:
>  	switch (parse_options_step(&ctx, options, usagestr)) {
>  	case PARSE_OPT_HELP:
>  		exit(129);
>  	case PARSE_OPT_DONE:
>  		break;
>  	default: /* PARSE_OPT_UNKNOWN */
> -		if (ctx.argv[0][1] =3D=3D '-') {
> +		if (flags & PARSE_OPT_KEEP_UNKNOWN) {
> +			ctx.out[ctx.cpidx++] =3D ctx.argv[0];

  Actually this doesn't work because it may point into the strbuf that
will be invalidated later. Our sole option here is to leak some memory I
fear.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhgr08ACgkQvGr7W6HudhytdgCglwqHuhiNaEDl6FnXfDPSlmxB
/bwAoJgCpjzkwzHTx27BRAv8fusIP9N2
=ivGA
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
