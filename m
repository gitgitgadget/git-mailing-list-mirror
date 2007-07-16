From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 19:41:38 +0200
Message-ID: <20070716174138.GC22998@lug-owl.de>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <11846075213759-git-send-email-sithglan@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:41:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAUZr-0003hw-1t
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbXGPRlk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbXGPRlk
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:41:40 -0400
Received: from lug-owl.de ([195.71.106.12]:44909 "EHLO lug-owl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbXGPRlj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 13:41:39 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 788A9F005B; Mon, 16 Jul 2007 19:41:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11846075213759-git-send-email-sithglan@stud.uni-erlangen.de>
X-Operating-System: Linux mail 2.6.18-4-686 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52695>


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-07-16 19:38:41 +0200, Thomas Glanzmann <sithglan@stud.uni-erla=
ngen.de> wrote:
> Calling unlink on a directory on a Solaris UFS filesystem as root makes it
> inconsistent. Thanks to Johannes Sixt for the obvious fix.
>=20
> Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
> ---
>  entry.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/entry.c b/entry.c
> index 82bf725..907293f 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -6,18 +6,18 @@ static void create_directories(const char *path, const =
struct checkout *state)
>  	int len =3D strlen(path);
>  	char *buf =3D xmalloc(len + 1);
>  	const char *slash =3D path;
> +        struct stat st;

Whitespace damage.

>  	while ((slash =3D strchr(slash+1, '/')) !=3D NULL) {
>  		len =3D slash - path;
>  		memcpy(buf, path, len);
>  		buf[len] =3D 0;
> +                if (!stat(buf, &st) && S_ISDIR(st.st_mode))
> +                        continue; /* ok */

Dito.

>  		if (mkdir(buf, 0777)) {
>  			if (errno =3D=3D EEXIST) {
> -				struct stat st;
>  				if (len > state->base_dir_len && state->force && !unlink(buf) && !mk=
dir(buf, 0777))
>  					continue;
> -				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
> -					continue; /* ok */
>  			}
>  			die("cannot create directory at %s", buf);
>  		}

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:         "really soon now":      an unspecified period of time=
, likly to
the second  :                                 be greater than any reasonabl=
e definition
                                              of "soon".

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGm63SHb1edYOZ4bsRAsOFAJ9nxL32XUONFlh8uIUO6pcXH/+55wCghKsJ
myTbvU10msCYbyoKHm2LnnU=
=0wui
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
