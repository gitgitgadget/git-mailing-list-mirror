From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] cherry-pick, revert: add the --gpg-sign option
Date: Sun, 3 Nov 2013 18:48:30 +0000
Message-ID: <20131103184830.GB183446@vauxhall.crustytoothpaste.net>
References: <20131103175015.GA183446@vauxhall.crustytoothpaste.net>
 <1383504375-22743-1-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Sun Nov 03 19:48:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd2jC-00042S-RL
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 19:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab3KCSsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 13:48:37 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33539 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754057Ab3KCSsg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Nov 2013 13:48:36 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:b0ef:4a47:7a46:7dd2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 400682807A;
	Sun,  3 Nov 2013 18:48:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1383504375-22743-1-git-send-email-boklm@mars-attacks.org>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237274>


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2013 at 07:46:15PM +0100, Nicolas Vigier wrote:
> diff --git a/sequencer.c b/sequencer.c
> index 06e52b4c83ff..2048cd81b3b2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -392,11 +392,18 @@ static int run_git_commit(const char *defmsg, struc=
t replay_opts *opts,
>  {
>  	struct argv_array array;
>  	int rc;
> +	char *gpg_sign;
> =20
>  	argv_array_init(&array);
>  	argv_array_push(&array, "commit");
>  	argv_array_push(&array, "-n");
> =20
> +	if (opts->gpg_sign) {
> +		gpg_sign =3D xmalloc(3 + strlen(opts->gpg_sign));
> +		sprintf(gpg_sign, "-S%s", opts->gpg_sign);
> +		argv_array_push(&array, gpg_sign);
> +		free(gpg_sign);
> +	}
>  	if (opts->signoff)
>  		argv_array_push(&array, "-s");
>  	if (!opts->edit) {
> @@ -808,6 +815,8 @@ static int populate_opts_cb(const char *key, const ch=
ar *value, void *data)
>  		opts->mainline =3D git_config_int(key, value);
>  	else if (!strcmp(key, "options.strategy"))
>  		git_config_string(&opts->strategy, key, value);
> +	else if (!strcmp(key, "options.gpg-sign"))
> +		git_config_string(&opts->gpg_sign, key, value);
>  	else if (!strcmp(key, "options.strategy-option")) {
>  		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
>  		opts->xopts[opts->xopts_nr++] =3D xstrdup(value);
> @@ -981,6 +990,8 @@ static void save_opts(struct replay_opts *opts)
>  	}
>  	if (opts->strategy)
>  		git_config_set_in_file(opts_file, "options.strategy", opts->strategy);
> +	if (opts->gpg_sign)
> +		git_config_set_in_file(opts_file, "options.gpg-sign", opts->gpg_sign);
>  	if (opts->xopts) {
>  		int i;
>  		for (i =3D 0; i < opts->xopts_nr; i++)

Looks much better.  That's essentially what I did when I was patching
that particular area.  Thanks for posting this patch set; it's something
I've wanted for a while, but never got around to actually doing myself.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSdpp9AAoJEL9TXYEfUvaLKZAP/ii4FU445hv0Q6Kw1lcTXpsW
3hy2WRZc8swhuj/sVCfNrpT5gY4xgulSK2iP04IatfyrMY97WmQWkSMX/uPiDcW+
DtK3aq8Rl0kJaeP6tXo7TEhNL8Ts4FmcPKyv4U8NEBG7cLuVJT9qhfLUBxzfUoSx
0UT+kYO/wb5g1nFemP7WeabF7B5i7M/hYbWGOgMmL4/wGgKLCxEs4ZFjqFNhOZWb
3ahjl/CAN1RBenewlkTdSMHr0uIrqQvtK7kze0w+T8LcWO/0/2M+kv1arehp4jr6
b6Wuf+PI+5IuLRMJpZlgvE3GE/bBE6H2Ka6JU+XKMjDUQgqqF8QR33gm1YejIDXP
pNfNmZi0ahRuQha3FYdCNfOMwFDyP6Kkbt6tvG++rD9MjdsdGJPax14qcHJv37l+
khxPb4o/e5Ffc3qaCIwVLp6FpXROZ9bW+HeetHQfTIPfk8ZGdoTWP4ndJYgBshpF
Vl9eYLKATRkKLkd5ioK8ieU4Hlh/giZK3A+xt7mNerxcfL2waeM7K5yaxf1rn36i
BaO2nYc3arh8Ybl/+aPTX2/fKI+UHujsmXFtouvHU8SR4d5jJv/pL7cYx+BuUza3
n/0Anio6RNOpsjB9gPbVr8O3KnoRuLeukRz/Pp/HwKo7/dNJIfYhEX8HmDX6cLYS
AYcY57CH8d0SbL5tsetj
=nxHl
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
