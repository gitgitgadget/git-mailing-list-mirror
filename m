From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH i18n 09/11] i18n: apply: update say_patch_name to give
 translators complete sentence
Date: Sun, 22 Apr 2012 18:42:25 +0200
Message-ID: <4F9434F1.9000900@in.waw.pl>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com> <1334580603-11577-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 18:42:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLzs1-0004GL-DP
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 18:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226Ab2DVQmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Apr 2012 12:42:37 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35348 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab2DVQmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 12:42:36 -0400
Received: from 213-238-114-173.adsl.inetia.pl ([213.238.114.173] helo=[192.168.2.4])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SLzrr-0002lw-PG; Sun, 22 Apr 2012 18:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <1334580603-11577-10-git-send-email-pclouds@gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196083>

On 04/16/2012 02:50 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
> ---
>  builtin/apply.c |   33 +++++++++++++++++++--------------
>  1 files changed, 19 insertions(+), 14 deletions(-)
>=20
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 6e9a02e..87922cf 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -335,22 +335,25 @@ static void clear_image(struct image *image)
>  	image->len =3D 0;
>  }
> =20
> -static void say_patch_name(FILE *output, const char *pre,
> -			   struct patch *patch, const char *post)
> +/* fmt must contain _one_ %s and no other substitution */
> +static void say_patch_name(FILE *output, struct patch *patch, const =
char *fmt)
>  {
> -	fputs(pre, output);
> +	struct strbuf sb =3D STRBUF_INIT;
> +
>  	if (patch->old_name && patch->new_name &&
>  	    strcmp(patch->old_name, patch->new_name)) {
> -		quote_c_style(patch->old_name, NULL, output, 0);
> -		fputs(" =3D> ", output);
> -		quote_c_style(patch->new_name, NULL, output, 0);
> +		quote_c_style(patch->old_name, &sb, NULL, 0);
> +		strbuf_addstr(&sb, " =3D> ");
> +		quote_c_style(patch->new_name, &sb, NULL, 0);
>  	} else {
>  		const char *n =3D patch->new_name;
>  		if (!n)
>  			n =3D patch->old_name;
> -		quote_c_style(n, NULL, output, 0);
> +		quote_c_style(n, &sb, NULL, 0);
>  	}
> -	fputs(post, output);
> +	fprintf(output, fmt, sb.buf);
> +	fprintf(output, "\n");
> +	strbuf_release(&sb);
>  }
> =20
>  #define CHUNKSIZE (8192)
> @@ -3165,8 +3168,8 @@ static int check_patch_list(struct patch *patch=
)
>  	prepare_fn_table(patch);
>  	while (patch) {
>  		if (apply_verbosely)
> -			say_patch_name(stderr,
> -				       "Checking patch ", patch, "...\n");
> +			say_patch_name(stderr, patch,
> +				       _("Checking patch %s..."));
>  		err |=3D check_patch(patch);
>  		patch =3D patch->next;
>  	}
> @@ -3530,6 +3533,7 @@ static int write_out_one_reject(struct patch *p=
atch)
>  	char namebuf[PATH_MAX];
>  	struct fragment *frag;
>  	int cnt =3D 0;
> +	struct strbuf sb =3D STRBUF_INIT;
> =20
>  	for (cnt =3D 0, frag =3D patch->fragments; frag; frag =3D frag->nex=
t) {
>  		if (!frag->rejected)
> @@ -3539,8 +3543,8 @@ static int write_out_one_reject(struct patch *p=
atch)
> =20
>  	if (!cnt) {
>  		if (apply_verbosely)
> -			say_patch_name(stderr,
> -				       "Applied patch ", patch, " cleanly.\n");
> +			say_patch_name(stderr, patch,
> +				       _("Applied patch %s cleanly."));
>  		return 0;
>  	}
> =20
> @@ -3551,8 +3555,9 @@ static int write_out_one_reject(struct patch *p=
atch)
>  		die(_("internal error"));
> =20
>  	/* Say this even without --verbose */
> -	say_patch_name(stderr, "Applying patch ", patch, " with");
> -	fprintf(stderr, " %d rejects...\n", cnt);
> +	strbuf_addf(&sb, _("Applying patch %%s with %d rejects..."), cnt);
Shouldn't this part be:
        strbuf_addf(&sb, Q_("Applying patch %%s with one reject...",
                            "Applying patch %%s with %d rejects...",
                            cnt), cnt);
?

-
Zbyszek
