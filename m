From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git show and the --quiet option
Date: Mon, 30 May 2011 11:32:59 +0200
Message-ID: <20110530093259.GA2990@bee.lab.cmartin.tk>
References: <4DE12888.1040506@isy.liu.se>
 <20110528172611.GB28708@centaur.lab.cmartin.tk>
 <7vhb8eprcb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Cc: Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 11:33:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQyqT-0000Sw-Aa
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 11:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab1E3JdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 05:33:03 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:34479 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636Ab1E3JdC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 05:33:02 -0400
Received: from bee.lab.cmartin.tk (z39c5.pia.fu-berlin.de [87.77.57.197])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id A8574461D9;
	Mon, 30 May 2011 11:32:33 +0200 (CEST)
Received: (nullmailer pid 9252 invoked by uid 1000);
	Mon, 30 May 2011 09:32:59 -0000
Content-Disposition: inline
In-Reply-To: <7vhb8eprcb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174734>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 28, 2011 at 12:17:40PM -0700, Junio C Hamano wrote:
> Carlos Mart=EDn Nieto <cmn@elego.de> writes:
>=20
> >> 1c40c36b ("log: convert to parse-options").  Was this intentional?
> >
> > Very much so.
> >> ...
> > The long answer is that the log family (and git-format-patch, which
> > is where this started) never actually accepted --quiet, so it would
> > get passed down to the diff machinery. This (for complicated reasons
> > I'm not sure I comletely understand, but that have to do with the
> > internal handling of 'quiet' as 'quick') caused every second commit
> > not to show.
>=20
> Yes, "git format-patch" that gives empty patch for every other commit
> would have been incorrect, but "--quiet" to squelch patch output,
> especially in the context of "show" whose default is to show patch, is
> something people would naturally expect, even though admittedly it was
> doing so by accident.
>=20
> How does this patch look?
>=20
> It does not fix "git show master~10 master^..master", but instead of just
> hijacking and ignoring the --quiet option like your patch did, it actually
> flips the option the user wanted to affect from the command line.

It's fine if that's what we want to do. The reason I blocked --quiet
instead of converting it to -s is because it seemed less surprising
than passing --quiet and still getting output (if I pass --quiet, I'd
expect the application to really be quiet), which doesn't happen in
the commands that accept --quiet on purpose. Then again, the log
family doesn't make any sense without any output, so if you argue that
way, --quiet means "quieter", which makes the interface less
consistent, but I don't feel that strongly about it

So sure, if you think it helps, apply it.=20

>=20
>  builtin/log.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/builtin/log.c b/builtin/log.c
> index 27849dc..224b167 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -107,6 +107,8 @@ static void cmd_log_init_finish(int argc, const char =
**argv, const char *prefix,
>  			     PARSE_OPT_KEEP_DASHDASH);
> =20
>  	argc =3D setup_revisions(argc, argv, rev, opt);
> +	if (quiet)
> +		rev->diffopt.output_format |=3D DIFF_FORMAT_NO_OUTPUT;
> =20
>  	/* Any arguments at this point are not recognized */
>  	if (argc > 1)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN42RLAAoJEHKRP1jG7ZzT5KIIAJG4/+QxJwauZFdH/YQkBvk/
SPr4/k+vpOdp+JHN8nxL2h+pXPoUzp0N34D3CJXLJ41fwSApNxdAePUK2VWdqsSI
e8I7ymtfls56cRPJVAlOkWcocZ4R051f1QWXyQt1cNnK6ss5XxeC0ecq4yN3Hqj3
lrwmjKxyIGM+BU7a5QfTvWu+0Qi/MSzanff3QkdNc9OcCfqhUSJkg1FWeJry0do9
amdWKvK0H/0Rsic71MhDGIXJRulqQUuUvTQAc5J5xcp9x0f0xWb59X+wyvm1wON+
/iQZImVPt60/fL5q42ue8hjeBjn8+KFv1ET2GBqFPPOrbvJXbT9DdLeAprOh0Po=
=RUbp
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
