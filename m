From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4] Add utf8_fprintf helper which returns correct columns
Date: Fri, 08 Feb 2013 07:03:46 +0100
Message-ID: <51149542.8060307@web.de>
References: <7va9rho350.fsf@alter.siamese.dyndns.org> <4ea03e99bad13e2910b137fd3991951244fa23f1.1360289411.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.co>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 07:06:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3h6N-0006B3-PL
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 07:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759941Ab3BHGFy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2013 01:05:54 -0500
Received: from mout.web.de ([212.227.17.12]:59370 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752562Ab3BHGFv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 01:05:51 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0Lheqz-1UhRfm3RtB-00mtdy; Fri, 08 Feb 2013 07:03:48 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <4ea03e99bad13e2910b137fd3991951244fa23f1.1360289411.git.worldhello.net@gmail.com>
X-Provags-ID: V02:K0:ebM0/7eR5Fb+ppP9IXlrcDHBj8ys+yXi7NrNSgXls/x
 DcKYFyrtyFCKl9GfjxU6Vlg3pvtCQDapTOHZ0z/Of5Ta8itwGu
 +CTiDQDo/4MOeAB/jIrYZNVsjT8awpd7RR/qQdl936kNCyZ2V+
 Z3jWM4dU5/JS8viXgS4j1Brbuuxb0VqKGZCVBbOnpIxtcs1pmI
 a5MFgfEHxZ2y77BMRMRHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215753>

On 08.02.13 03:10, Jiang Xin wrote:
> Since command usages can be translated, they may not align well espec=
ially
> when they are translated to CJK. A wrapper utf8_fprintf can help to r=
eturn
> the correct columns required.
>=20
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  parse-options.c |  5 +++--
>  utf8.c          | 22 ++++++++++++++++++++++
>  utf8.h          |  1 +
>  3 files changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/parse-options.c b/parse-options.c
> index 67e98..a6ce9e 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -3,6 +3,7 @@
>  #include "cache.h"
>  #include "commit.h"
>  #include "color.h"
> +#include "utf8.h"
> =20
>  static int parse_options_usage(struct parse_opt_ctx_t *ctx,
>  			       const char * const *usagestr,
> @@ -482,7 +483,7 @@ static int usage_argh(const struct option *opts, =
=46ILE *outfile)
>  			s =3D literal ? "[%s]" : "[<%s>]";
>  	else
>  		s =3D literal ? " %s" : " <%s>";
> -	return fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
> +	return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _("...=
"));
>  }
> =20
>  #define USAGE_OPTS_WIDTH 24
> @@ -541,7 +542,7 @@ static int usage_with_options_internal(struct par=
se_opt_ctx_t *ctx,
>  		if (opts->long_name)
>  			pos +=3D fprintf(outfile, "--%s", opts->long_name);
>  		if (opts->type =3D=3D OPTION_NUMBER)
> -			pos +=3D fprintf(outfile, "-NUM");
> +			pos +=3D utf8_fprintf(outfile, _("-NUM"));
> =20
>  		if ((opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
>  		    !(opts->flags & PARSE_OPT_NOARG))
> diff --git a/utf8.c b/utf8.c
> index a4ee6..05925 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -430,6 +430,28 @@ int same_encoding(const char *src, const char *d=
st)
>  }
> =20
>  /*
> + * Wrapper for fprintf and returns the total number of columns requi=
red
> + * for the printed string, assuming that the string is utf8.
> + */
> +int utf8_fprintf(FILE *stream, const char *format, ...)
> +{
> +	struct strbuf buf =3D STRBUF_INIT;
> +	va_list arg;
> +	int columns;
> +
> +	va_start (arg, format);
> +	strbuf_vaddf(&buf, format, arg);
> +	va_end (arg);
> +
> +	columns =3D fputs(buf.buf, stream);
> +	/* If no error occurs, returns columns really required with utf8_st=
rwidth. */
> +	if (0 <=3D columns)
> +		columns =3D utf8_strwidth(buf.buf);
> +	strbuf_release(&buf);
> +	return columns;
> +}
> +

I don't think we handle the return code from fputs() correctly.

Please dee below for specifications on fprintf(),
something like the following could do:
=20
int utf8_fprintf(FILE *stream, const char *format, ...)
{
	struct strbuf buf =3D STRBUF_INIT;
	va_list arg;
	int columns =3D 0;

	va_start (arg, format);
	strbuf_vaddf(&buf, format, arg);
	va_end (arg);

	if (EOF !=3D fputs(buf.buf, stream))
		columns =3D utf8_strwidth(buf.buf);
	strbuf_release(&buf);
	return columns;
}

And as a side note: would fprintf_strwidth() be a better name?


Linux:
RETURN VALUE
       fputc(), putc() and  putchar()  return  the  character  written =
 as  an
       unsigned char cast to an int or EOF on error.

       puts()  and  fputs()  return a nonnegative number on success, or=
 EOF on
       error.

Mac OS:
COMPATIBILITY
     fputs() now returns a non-negative number (as opposed to 0) on suc=
cessful
     completion.  As a result, many tests (e.g., "fputs() =3D=3D 0", "f=
puts() !=3D
     0") do not give the desired result.  Use "fputs() !=3D EOF" or "fp=
uts() =3D=3D
     EOF" to determine success or failure.

Posix:
RETURN VALUE
       Upon successful completion, fputs() shall return a non-negative =
number.
       Otherwise, it shall return EOF, set an error indicator for the  =
stream,
       and set errno to indicate the error.
