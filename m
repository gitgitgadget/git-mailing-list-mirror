From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] parse-options: make OPT_NUMBER's argh explicit
Date: Wed, 03 Jun 2009 12:18:34 +0200
Message-ID: <4A264DFA.3090309@lsrfire.ath.cx>
References: <1244015367-16998-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 12:18:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBnYY-0000yp-0D
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 12:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbZFCKSl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2009 06:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbZFCKSk
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 06:18:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:34362 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbZFCKSk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 06:18:40 -0400
Received: from [10.0.1.101] (p57B7CBE0.dip.t-dialin.net [87.183.203.224])
	by india601.server4you.de (Postfix) with ESMTPSA id 934512F8042;
	Wed,  3 Jun 2009 12:18:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1244015367-16998-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120595>

Stephen Boyd schrieb:
> OPTION_NUMBER hard codes its argh member to be "n", but the decision =
is
> hidden deep in usage_with_options_internal(). Make "n" the default ar=
gh
> for the OPT_NUMBER macro while leaving it undecided for the OPTION_NU=
MBER
> enum.
>=20
> This make it less surprising to users that argh is "n" when using the
> OPT_NUMBER macro.
>=20
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>  builtin-tag.c   |    4 ++--
>  parse-options.c |   11 ++---------
>  parse-options.h |    2 +-
>  3 files changed, 5 insertions(+), 12 deletions(-)
>=20
> diff --git a/builtin-tag.c b/builtin-tag.c
> index dc3db62..080e04a 100644
> --- a/builtin-tag.c
> +++ b/builtin-tag.c
> @@ -376,8 +376,8 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
>  	struct commit_list *with_commit =3D NULL;
>  	struct option options[] =3D {
>  		OPT_BOOLEAN('l', NULL, &list, "list tag names"),
> -		{ OPTION_INTEGER, 'n', NULL, &lines, NULL,
> -				"print n lines of each tag message",
> +		{ OPTION_INTEGER, 'n', NULL, &lines, "n",
> +				"print <n> lines of each tag message",
>  				PARSE_OPT_OPTARG, NULL, 1 },
>  		OPT_BOOLEAN('d', NULL, &delete, "delete tags"),
>  		OPT_BOOLEAN('v', NULL, &verify, "verify tags"),
> diff --git a/parse-options.c b/parse-options.c
> index b85cab2..48ba62b 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -503,19 +503,12 @@ int usage_with_options_internal(const char * co=
nst *usagestr,
>  		switch (opts->type) {
>  		case OPTION_ARGUMENT:
>  			break;
> -		case OPTION_INTEGER:
> -			if (opts->flags & PARSE_OPT_OPTARG)
> -				if (opts->long_name)
> -					pos +=3D fprintf(stderr, "[=3D<n>]");
> -				else
> -					pos +=3D fprintf(stderr, "[<n>]");
> -			else
> -				pos +=3D fprintf(stderr, " <n>");
> -			break;
>  		case OPTION_CALLBACK:
>  			if (opts->flags & PARSE_OPT_NOARG)
>  				break;
>  			/* FALLTHROUGH */
> +		case OPTION_INTEGER:
> +			/* FALLTHROUGH */
>  		case OPTION_FILENAME:
>  			/* FALLTHROUGH */
>  		case OPTION_STRING:
> diff --git a/parse-options.h b/parse-options.h
> index b374ade..b141ae6 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -108,7 +108,7 @@ struct option {
>  #define OPT_BOOLEAN(s, l, v, h)     { OPTION_BOOLEAN, (s), (l), (v),=
 NULL, (h) }
>  #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v),=
 NULL, (h), 0, NULL, (i) }
>  #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v),=
 NULL, (h), 0, NULL, (p) }
> -#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v),=
 NULL, (h) }
> +#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v),=
 "n", (h) }
>  #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v),=
 (a), (h) }
>  #define OPT_DATE(s, l, v, h) \
>  	{ OPTION_CALLBACK, (s), (l), (v), "time",(h), 0, \

Nice code reduction.  s/NUMBER/INTEGER/ in the commit message?

By the way, can the switch be replaced by a simple check for
PARSE_OPT_NOARG now?

Ren=E9
