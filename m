From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Tue, 11 Mar 2014 02:00:04 +0000
Message-ID: <20140311020003.GE4271@vauxhall.crustytoothpaste.net>
References: <20140308183501.GH18371@serenity.lan>
 <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
 <20140311015603.GA12180@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Guillaume Gelin <contact@ramnes.eu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 03:00:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNBzP-0006Ss-8Z
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 03:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbaCKCAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 22:00:12 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:52497 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752842AbaCKCAL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 22:00:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:7922:e1f9:69f1:ac6c])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0301828074;
	Tue, 11 Mar 2014 02:00:09 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Guillaume Gelin <contact@ramnes.eu>
Content-Disposition: inline
In-Reply-To: <20140311015603.GA12180@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.13-1-amd64)
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243834>


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2014 at 09:56:03PM -0400, Jeff King wrote:
> On Sat, Mar 08, 2014 at 07:21:39PM +0000, brian m. carlson wrote:
>=20
> > We shrink the source and destination arrays, but not the modes or
> > submodule_gitfile arrays, resulting in potentially mismatched data.  Sh=
rink
> > all the arrays at the same time to prevent this.
> >=20
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  builtin/mv.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/builtin/mv.c b/builtin/mv.c
> > index f99c91e..b20cd95 100644
> > --- a/builtin/mv.c
> > +++ b/builtin/mv.c
> > @@ -230,6 +230,11 @@ int cmd_mv(int argc, const char **argv, const char=
 *prefix)
> >  					memmove(destination + i,
> >  						destination + i + 1,
> >  						(argc - i) * sizeof(char *));
> > +					memmove(modes + i, modes + i + 1,
> > +						(argc - i) * sizeof(char *));
> > +					memmove(submodule_gitfile + i,
> > +						submodule_gitfile + i + 1,
> > +						(argc - i) * sizeof(char *));
>=20
> I haven't looked that closely, but would it be crazy to suggest that
> these arrays all be squashed into one array-of-struct? It would be less
> error prone and perhaps more readable.

I was thinking of doing exactly that, but the way internal_copy_pathspec
is written, I'd need to use offsetof to have it write to the right
structure members.  That's a bit more gross than I wanted, but I'll
probably implement it at some point during the upcoming week.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTHm4jAAoJEL9TXYEfUvaL/XcP/RXYnHiFws/PPrPJaC6TKc2E
aAvzeyQQl51NJjykZSA2Nx3vOXY/LAEiqKiCxVAPX4KBDVIKTSR0GF8L3uKrTiYO
wp25At4NmuUhcwY9WNz9WXgZ/EkjcJgFTdLUFICQAHpSYLjvvgd/+MMTdTU3EHlR
lqhSvmTuxTQ4cm5UFVaedxAMfDjhYGMtBquI/MGJOYyw1+EUVUj1ugi7i3e5Tugd
W42He+tywMNtcQpAOg/f2WSBXGJebgjCEF2v0AjTTQAskZk+eEh5Xv26MKjfZfdd
O6eNLYzdUkSA4X7nPB107A9VzHD9g5Imuub+yqyRmC3Moa0JsQs2ZyUG7gc50HAn
6paTqdk4OvPoPre/Ge/0aR96YjLbpqeHqVrZexSbIi0lbDQhBa7OkEMFaOF9bJmE
TsB4NrUtn5j2HB/jRtMo7dClzbRndtQZAeuxSXxKSGBupJ6oRNlt4fQPjOoTp4uZ
a9Yp9w+rc9krRHOh1fxdtiXHVt/3tvz/fiU7N+3Kp2/qcNFYaA7W8PXlv/nLgETz
Deamlfnrr1hRiWZBPYett5wPWWHo66DAveMsGPsveVo0dtBUd9OhZHUzJLBkck1D
y3TDIUk1NQ4oLn+GsmtdNkkeZoK1briXaxMLzymnmPUW0N3vm1mg/kWMlC5omdrt
moS1RBi/x3YcB8unAWjR
=1VWH
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
