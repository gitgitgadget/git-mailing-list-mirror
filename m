From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add a simple option parser.
Date: Sat, 13 Oct 2007 16:58:09 +0200
Message-ID: <20071013145809.GG7110@artemis.corp>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <1192282153-26684-2-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0710131519510.25221@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sw7tCqrGA+HQ0/zt";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 13 16:58:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgiRh-0003q0-CU
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 16:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763444AbXJMO6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 10:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760450AbXJMO6Q
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 10:58:16 -0400
Received: from pan.madism.org ([88.191.52.104]:45390 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762423AbXJMO6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 10:58:13 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 82355951;
	Sat, 13 Oct 2007 16:58:10 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id AE3F039E015; Sat, 13 Oct 2007 16:58:09 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710131519510.25221@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2007 at 02:39:10PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Sat, 13 Oct 2007, Pierre Habouzit wrote:
>=20
> > Aggregation of single switches is allowed:
> >   -rC0 is the same as -r -C 0 (supposing that -C wants an arg).
>=20
> I'd be more interested in "-rC 0" working...  Is that supported, too?

  yes it is.

> > +static inline const char *get_arg(struct optparse_t *p)
> > +{
> > +	if (p->opt) {
> > +		const char *res =3D p->opt;
> > +		p->opt =3D NULL;
> > +		return res;
> > +	}
> > +	p->argc--;
> > +	return *++p->argv;
> > +}
>=20
> This is only used once; I wonder if it is really that more readable havin=
g=20
> this as a function in its own right.

  it's used twice, and it makes the code more readable I believe.

> > +static inline const char *skippfx(const char *str, const char *prefix)
>=20
> Personally, I do not like abbreviations like that.  They do not save that=
=20
> much screen estate (skip_prefix is only 4 characters longer, but much mor=
e=20
> readable).  Same goes for "cnt" later.

  Ack I'll fix that.

> > +static int parse_long_opt(struct optparse_t *p, const char *arg,
> > +                          struct option *options, int count)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < count; i++) {
> > +		const char *rest;
> > +		int flags =3D 0;
> > +	=09
> > +		if (!options[i].long_name)
> > +			continue;
> > +
> > +		rest =3D skippfx(arg, options[i].long_name);
> > +		if (!rest && !strncmp(arg, "no-", 3)) {
> > +			rest =3D skippfx(arg + 3, options[i].long_name);
> > +			flags |=3D OPT_SHORT;
> > +		}
>=20
> Would this not be more intuitive as
>=20
> 		if (!prefixcmp(arg, "no-")) {
> 			arg +=3D 3;
> 			flags |=3D OPT_UNSET;
> 		}
> 		rest =3D skip_prefix(arg, options[i].long_name);

  Yes, that can be done indeed, but the point is, we have sometimes
option whose long-name is "no-foo" (because it's what makes sense) but I
can rework that.

> Hm?  (Note that I say UNSET, not SHORT... ;-)

  fsck, good catch.

> > +		if (!rest)
> > +			continue;
> > +		if (*rest) {
> > +			if (*rest !=3D '=3D')
> > +				continue;
>=20
> Is this really no error?  For example, "git log=20
> --decorate-walls-and-roofs" would not fail...

  it would be an error, it will yield a "option not found".

> > +int parse_options(int argc, const char **argv,
> > +                  struct option *options, int count,
> > +				  const char * const usagestr[], int flags)
>=20
> Please indent by the same amount.

  oops, stupid space vs. tab thing.

> > +		if (arg[1] !=3D '-') {
> > +			optp.opt =3D arg + 1;
> > +			do {
> > +				if (*optp.opt =3D=3D 'h')
> > +					make_usage(usagestr, options, count);
>=20
> How about calling this "usage_with_options()"?  With that name I expected=
=20
> make_usage() to return a strbuf.

  will do.

> > +		if (!arg[2]) { /* "--" */
> > +			if (!(flags & OPT_COPY_DASHDASH))
> > +				optp.argc--, optp.argv++;
>=20
> I would prefer this as=20
>=20
> 			if (!(flags & OPT_COPY_DASHDASH)) {
> 				optp.argc--;
> 				optp.argv++;
> 			}
>=20
> While I'm at it: could you use "args" instead of "optp"?  It is misleadin=
g=20
> both in that it not only contains options (but other arguments, too) as i=
n=20
> that it is not a pointer (the trailing "p" is used as an indicator of tha=
t=20
> very often, including git's source code).

  okay.

> In the same vein, OPT_COPY_DASHDASH should be named=20
> PARSE_OPT_KEEP_DASHDASH.

  okay.

>=20
> > +		if (opts->short_name) {
> > +			strbuf_addf(&sb, "-%c", opts->short_name);
> > +		}
> > +		if (opts->long_name) {
> > +			strbuf_addf(&sb, opts->short_name ? ", --%s" : "--%s",
> > +						opts->long_name);
> > +		}
>=20
> Please lose the curly brackets.
>=20
> > +		if (sb.len - pos <=3D USAGE_OPTS_WIDTH) {
> > +			int pad =3D USAGE_OPTS_WIDTH - (sb.len - pos) + USAGE_GAP;
> > +			strbuf_addf(&sb, "%*s%s\n", pad, "", opts->help);
> > +		} else {
> > +			strbuf_addf(&sb, "\n%*s%s\n", USAGE_OPTS_WIDTH + USAGE_GAP, "",
> > +						opts->help);
> > +		}
>=20
> Same here.  (And I'd also make sure that the lines are not that long.)

  okay.

>=20
> > diff --git a/parse-options.h b/parse-options.h
> > new file mode 100644
> > index 0000000..4b33d17
> > --- /dev/null
> > +++ b/parse-options.h
> > @@ -0,0 +1,37 @@
> > +#ifndef PARSE_OPTIONS_H
> > +#define PARSE_OPTIONS_H
> > +
> > +enum option_type {
> > +	OPTION_BOOLEAN,
>=20
> I know that I proposed "BOOLEAN", but actually, you use it more like an=
=20
> "INCREMENTAL", right?

  yes, I don't like _BOOLEAN either, I would have prefered _FLAG or sth
like that. INCREMENTAL is just too long.

> Other than that: I like it very much.

:P

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEN0BvGr7W6HudhwRAj5KAKCTzTJpzzRka9seg2gSJghOCc5i2ACgk/S9
xWLj0OTdkAKm7nsWwm8s/nE=
=8zeg
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--
