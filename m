From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 5/6] builtin-commit: resurrect behavior for multiple -m  options
Date: Sun, 11 Nov 2007 20:42:28 +0100
Message-ID: <20071111194228.GC13200@artemis.corp>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site> <Pine.LNX.4.64.0711111736310.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="8X7/QrJGcKSMr1RN";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:42:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIhk-0000zl-6E
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429AbXKKTmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 14:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756783AbXKKTmc
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:42:32 -0500
Received: from pan.madism.org ([88.191.52.104]:34799 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756429AbXKKTma (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:42:30 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 17B4829981;
	Sun, 11 Nov 2007 20:42:29 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id A575131706C; Sun, 11 Nov 2007 20:42:28 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711111736310.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64498>


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 11, 2007 at 05:36:39PM +0000, Johannes Schindelin wrote:
>=20
> When more than one -m option is given, the message does not replace
> the previous, but is appended.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin-commit.c |   26 ++++++++++++++++++++------
>  1 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 66d7e5e..069d180 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -30,13 +30,27 @@ static char *use_message_buffer;
>  static const char commit_editmsg[] =3D "COMMIT_EDITMSG";
>  static struct lock_file lock_file;
> =20
> -static char *logfile, *force_author, *message, *template_file;
> +static char *logfile, *force_author, *template_file;
>  static char *edit_message, *use_message;
>  static int all, edit_flag, also, interactive, only, amend, signoff;
>  static int quiet, verbose, untracked_files, no_verify;
> =20
>  static int no_edit, initial_commit, in_merge;
>  const char *only_include_assumed;
> +struct strbuf message;

  Unless I'm mistaken `static` keywords are missign for`message` and
`only_include_assumed`.

  And you _have_ to initialize message with STRBUF_INIT (remember of the
slop).

> +static int opt_parse_m(const struct option *opt, const char *arg, int un=
set)
> +{
> +	struct strbuf *buf =3D opt->value;
> +	if (unset)
> +		strbuf_setlen(buf, 0);
> +	else {
> +		strbuf_addstr(buf, arg);
> +		strbuf_addch(buf, '\n');
> +		strbuf_addch(buf, '\n');
> +	}
> +	return 0;
> +}

  I believe such a callback could live in parse-options.[hc]. The need
to aggregate all string arguments into a strbuf looks generic enough to
me. Why are you adding two '\n' btw ? Isn't one enough ?

  Oh and last nitpicking, strbuf_addstr(buf, "\n\n"); is more efficient
than the two addchar (the strlen it generates is inlined).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHN1skvGr7W6HudhwRAnymAJ9o40dJCLJdUl6Rt5tfUCIaJVnDXwCaA8eb
NsTMf2y2z+L1Rpznu+/zmGQ=
=/er5
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
