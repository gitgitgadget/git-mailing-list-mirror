From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH 1/1] Teach for-each-ref about a little language called Tcl.
Date: Sun, 28 Jan 2007 12:49:09 +0300
Message-ID: <20070128094909.GA3740@procyon.home>
References: <20070128073913.GA9915@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 10:50:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB6g8-0006RL-Fg
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 10:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbXA1JuS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 04:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbXA1JuS
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 04:50:18 -0500
Received: from master.altlinux.org ([62.118.250.235]:3198 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932493AbXA1JuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 04:50:16 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id 50437E34C6; Sun, 28 Jan 2007 12:50:15 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <20070128073913.GA9915@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38028>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2007 at 02:39:13AM -0500, Shawn O. Pearce wrote:
> Love it or hate it, some people actually still program in Tcl.  Some
> of those programs are meant for interfacing with Git.  Programs such as
> gitk and git-gui.  It may be useful to have Tcl-safe output available
> from for-each-ref, just like shell, Perl and Python already enjoy.
>=20
> Thanks to Sergey Vlasov for pointing out the horrible flaws in the
> first version of this patch, and steering me in the right direction
> for Tcl value quoting.
[...]
> +void tcl_quote_print(FILE *stream, const char *src)
> +{
> +	char c;
> +
> +	fputc('"', stream);
> +	while ((c =3D *src++)) {
> +		switch (c) {
> +		case '[':
> +		case ']':
> +		case '$':
> +		case '\\':
> +		case '"':
> +			fputc('\\', stream);
> +		default:
> +			fputc(c, stream);
> +			break;
> +		case '\f':
> +			fputs("\\f", stream);
> +			break;
> +		case '\r':
> +			fputs("\\r", stream);
> +			break;
> +		case '\n':
> +			fputs("\\n", stream);
> +			break;
> +		case '\t':
> +			fputs("\\t", stream);
> +			break;
> +		case '\v':
> +			fputs("\\v", stream);
> +			break;
> +		}
> +	}
> +	fputc('"', stream);
> +}

This is better; however, wrapping this format inside { ... } (which
you may want to do in the template for some uses) won't work if the
string contains unmatched braces.  Quoting '{' and '}' characters with
backslashes should fix this.

BTW, escaping newline characters as done here is not strictly required
for a double-quoted string, but is very useful, because you may read
the output line by line with "gets" and get fields from each line with
"lindex"; without this escaping you will need to read the whole output
before trying to parse it as a single huge list.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFvHGVW82GfkQfsqIRAt0BAJ9KL9b6qsaIqzC13FWPqFaFLZonawCeLFNl
htoUp0YgePxeOuH8vdiJEuQ=
=Ya9I
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
