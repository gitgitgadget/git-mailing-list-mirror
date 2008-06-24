From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 6/7] parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.
Date: Tue, 24 Jun 2008 12:03:13 +0200
Message-ID: <20080624100313.GC24357@artemis.madism.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <1214298732-6247-1-git-send-email-madcoder@debian.org> <1214298732-6247-2-git-send-email-madcoder@debian.org> <1214298732-6247-3-git-send-email-madcoder@debian.org> <1214298732-6247-4-git-send-email-madcoder@debian.org> <1214298732-6247-5-git-send-email-madcoder@debian.org> <1214298732-6247-6-git-send-email-madcoder@debian.org> <1214298732-6247-7-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="CblX+4bnyfN0pR09";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 12:04:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB5Np-0006jv-MW
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 12:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbYFXKDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 06:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbYFXKDU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 06:03:20 -0400
Received: from pan.madism.org ([88.191.52.104]:36323 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883AbYFXKDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 06:03:19 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 1EDB938121;
	Tue, 24 Jun 2008 12:03:14 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3234034850C; Tue, 24 Jun 2008 12:03:13 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, torvalds@linux-foundation.org,
	gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de
Content-Disposition: inline
In-Reply-To: <1214298732-6247-7-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86029>


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 09:12:11AM +0000, Pierre Habouzit wrote:
> This way, argv[0] isn't clobbered, to the cost of maybe not having a
> resulting NULL terminated argv array.
>=20
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  parse-options.c |    7 ++++---
>  parse-options.h |    2 ++
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/parse-options.c b/parse-options.c
> index ee82cf3..a6b5e04 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -246,7 +246,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
>  	memset(ctx, 0, sizeof(*ctx));
>  	ctx->argc =3D argc - 1;
>  	ctx->argv =3D argv + 1;
> -	ctx->out  =3D argv;
> +	ctx->out  =3D argv + ((flags & PARSE_OPT_KEEP_ARGV0) !=3D 0);
>  	ctx->flags =3D flags;
>  	strbuf_init(&ctx->buf, 0);
>  }
> @@ -327,10 +327,11 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
> =20
>  int parse_options_end(struct parse_opt_ctx_t *ctx)
>  {
> +	int res =3D ctx->cpidx + ctx->argc;
>  	memmove(ctx->out + ctx->cpidx, ctx->argv, ctx->argc * sizeof(*ctx->out)=
);
> -	ctx->out[ctx->cpidx + ctx->argc] =3D NULL;
> +	ctx->out[res] =3D NULL;
>  	strbuf_release(&ctx->buf);
> -	return ctx->cpidx + ctx->argc;
> +	return res + ((ctx->flags & PARSE_OPT_KEEP_ARGV0) !=3D 0);
>  }
> =20
>  int parse_options(int argc, const char **argv, const struct option *opti=
ons,
> diff --git a/parse-options.h b/parse-options.h
> index 14447d5..6745c7d 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -22,6 +22,8 @@ enum parse_opt_type {
>  enum parse_opt_flags {
>  	PARSE_OPT_KEEP_DASHDASH =3D 1,
>  	PARSE_OPT_STOP_AT_NON_OPTION =3D 2,
> +	/* using that option, the filtered argv may not be NULL terminated */

  This comment is bogus and shall be stripped, I forgot to=E2=80=A6
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhgxmEACgkQvGr7W6HudhwTFwCfV3hDEu8zMLcgLypV+1fbxgkH
ga8AoIm15kr1AeIY6aac3h4ikk7q84ML
=/jvi
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
