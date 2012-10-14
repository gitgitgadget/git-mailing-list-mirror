From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 04/12] wildmatch: remove unnecessary functions
Date: Sat, 13 Oct 2012 22:04:00 -0700
Message-ID: <7vr4p1zl2s.fsf@alter.siamese.dyndns.org>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
 <1350182110-25936-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 07:20:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNGcy-00005F-Rk
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab2JNFUR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 01:20:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395Ab2JNFUQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:20:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EAA16640;
	Sun, 14 Oct 2012 01:20:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=VYRDoOXyUjuOjg2JN/8Z3p0kH
	zk=; b=ZEOPYmvR+xvBCR4sPkO7qtSMHv51Ne7L4lJAP/KnVqHHHKXQwi0nSI6FW
	BkKRwlpgg6YP2r3LZoiof6sP//NggLjlpdrQMTT0+ml/lvFpptsbl7d9GlnxnULc
	KG6Yyljjx8AoM7UrH7lRuxgqnh7hOe+tZ6vsvToqblcAC61Is8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=SKu3rqrAHUTd+MX01y0
	43EoTAHzK1hHxGkb79be8I+ejUF/BO6KV5Qt6g5+arXAbIF6YUlkvYKsgHfImfAH
	tQDT7Cak5aN08/DCWthrBYbWIdY//xh149RsaZXOWcYW12YKCr5tEVSCaaMXtO4d
	Z5pui4PfX0Lckv13lf1X7qfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B9E5663F;
	Sun, 14 Oct 2012 01:20:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B9A9663B; Sun, 14 Oct 2012
 01:20:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5060486-15BE-11E2-A4A0-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207615>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

The comment-fix seems to be new but otherwise this is unchanged,
right?


>  wildmatch.c | 164 ++++----------------------------------------------=
----------
>  wildmatch.h |   2 -
>  2 files changed, 10 insertions(+), 156 deletions(-)
>
> diff --git a/wildmatch.c b/wildmatch.c
> index f3a1731..fae7397 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -53,33 +53,18 @@
>  #define ISUPPER(c) (ISASCII(c) && isupper(c))
>  #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
> =20
> -#ifdef WILD_TEST_ITERATIONS
> -int wildmatch_iteration_count;
> -#endif
> -
>  static int force_lower_case =3D 0;
> =20
> -/* Match pattern "p" against the a virtually-joined string consistin=
g
> - * of "text" and any strings in array "a". */
> -static int dowild(const uchar *p, const uchar *text, const uchar*con=
st *a)
> +/* Match pattern "p" against "text" */
> +static int dowild(const uchar *p, const uchar *text)
>  {
>      uchar p_ch;
> =20
> -#ifdef WILD_TEST_ITERATIONS
> -    wildmatch_iteration_count++;
> -#endif
> -
>      for ( ; (p_ch =3D *p) !=3D '\0'; text++, p++) {
>  	int matched, special;
>  	uchar t_ch, prev_ch;
> -	while ((t_ch =3D *text) =3D=3D '\0') {
> -	    if (*a =3D=3D NULL) {
> -		if (p_ch !=3D '*')
> -		    return ABORT_ALL;
> -		break;
> -	    }
> -	    text =3D *a++;
> -	}
> +	if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
> +		return ABORT_ALL;
>  	if (force_lower_case && ISUPPER(t_ch))
>  	    t_ch =3D tolower(t_ch);
>  	switch (p_ch) {
> @@ -107,21 +92,15 @@ static int dowild(const uchar *p, const uchar *t=
ext, const uchar*const *a)
>  		/* Trailing "**" matches everything.  Trailing "*" matches
>  		 * only if there are no more slash characters. */
>  		if (!special) {
> -		    do {
>  			if (strchr((char*)text, '/') !=3D NULL)
>  			    return FALSE;
> -		    } while ((text =3D *a++) !=3D NULL);
>  		}
>  		return TRUE;
>  	    }
>  	    while (1) {
> -		if (t_ch =3D=3D '\0') {
> -		    if ((text =3D *a++) =3D=3D NULL)
> -			break;
> -		    t_ch =3D *text;
> -		    continue;
> -		}
> -		if ((matched =3D dowild(p, text, a)) !=3D FALSE) {
> +		if (t_ch =3D=3D '\0')
> +		    break;
> +		if ((matched =3D dowild(p, text)) !=3D FALSE) {
>  		    if (!special || matched !=3D ABORT_TO_STARSTAR)
>  			return matched;
>  		} else if (!special && t_ch =3D=3D '/')
> @@ -225,144 +204,21 @@ static int dowild(const uchar *p, const uchar =
*text, const uchar*const *a)
>  	}
>      }
> =20
> -    do {
> -	if (*text)
> -	    return FALSE;
> -    } while ((text =3D *a++) !=3D NULL);
> -
> -    return TRUE;
> -}
> -
> -/* Match literal string "s" against the a virtually-joined string co=
nsisting
> - * of "text" and any strings in array "a". */
> -static int doliteral(const uchar *s, const uchar *text, const uchar*=
const *a)
> -{
> -    for ( ; *s !=3D '\0'; text++, s++) {
> -	while (*text =3D=3D '\0') {
> -	    if ((text =3D *a++) =3D=3D NULL)
> -		return FALSE;
> -	}
> -	if (*text !=3D *s)
> -	    return FALSE;
> -    }
> -
> -    do {
> -	if (*text)
> -	    return FALSE;
> -    } while ((text =3D *a++) !=3D NULL);
> -
> -    return TRUE;
> -}
> -
> -/* Return the last "count" path elements from the concatenated strin=
g.
> - * We return a string pointer to the start of the string, and update=
 the
> - * array pointer-pointer to point to any remaining string elements. =
*/
> -static const uchar *trailing_N_elements(const uchar*const **a_ptr, i=
nt count)
> -{
> -    const uchar*const *a =3D *a_ptr;
> -    const uchar*const *first_a =3D a;
> -
> -    while (*a)
> -	    a++;
> -
> -    while (a !=3D first_a) {
> -	const uchar *s =3D *--a;
> -	s +=3D strlen((char*)s);
> -	while (--s >=3D *a) {
> -	    if (*s =3D=3D '/' && !--count) {
> -		*a_ptr =3D a+1;
> -		return s+1;
> -	    }
> -	}
> -    }
> -
> -    if (count =3D=3D 1) {
> -	*a_ptr =3D a+1;
> -	return *a;
> -    }
> -
> -    return NULL;
> +    return *text ? FALSE : TRUE;
>  }
> =20
>  /* Match the "pattern" against the "text" string. */
>  int wildmatch(const char *pattern, const char *text)
>  {
> -    static const uchar *nomore[1]; /* A NULL pointer. */
> -#ifdef WILD_TEST_ITERATIONS
> -    wildmatch_iteration_count =3D 0;
> -#endif
> -    return dowild((const uchar*)pattern, (const uchar*)text, nomore)=
 =3D=3D TRUE;
> +    return dowild((const uchar*)pattern, (const uchar*)text) =3D=3D =
TRUE;
>  }
> =20
>  /* Match the "pattern" against the forced-to-lower-case "text" strin=
g. */
>  int iwildmatch(const char *pattern, const char *text)
>  {
> -    static const uchar *nomore[1]; /* A NULL pointer. */
>      int ret;
> -#ifdef WILD_TEST_ITERATIONS
> -    wildmatch_iteration_count =3D 0;
> -#endif
>      force_lower_case =3D 1;
> -    ret =3D dowild((const uchar*)pattern, (const uchar*)text, nomore=
) =3D=3D TRUE;
> +    ret =3D dowild((const uchar*)pattern, (const uchar*)text) =3D=3D=
 TRUE;
>      force_lower_case =3D 0;
>      return ret;
>  }
> -
> -/* Match pattern "p" against the a virtually-joined string consistin=
g
> - * of all the pointers in array "texts" (which has a NULL pointer at=
 the
> - * end).  The int "where" can be 0 (normal matching), > 0 (match onl=
y
> - * the trailing N slash-separated filename components of "texts"), o=
r < 0
> - * (match the "pattern" at the start or after any slash in "texts").=
 */
> -int wildmatch_array(const char *pattern, const char*const *texts, in=
t where)
> -{
> -    const uchar *p =3D (const uchar*)pattern;
> -    const uchar*const *a =3D (const uchar*const*)texts;
> -    const uchar *text;
> -    int matched;
> -
> -#ifdef WILD_TEST_ITERATIONS
> -    wildmatch_iteration_count =3D 0;
> -#endif
> -
> -    if (where > 0)
> -	text =3D trailing_N_elements(&a, where);
> -    else
> -	text =3D *a++;
> -    if (!text)
> -	return FALSE;
> -
> -    if ((matched =3D dowild(p, text, a)) !=3D TRUE && where < 0
> -     && matched !=3D ABORT_ALL) {
> -	while (1) {
> -	    if (*text =3D=3D '\0') {
> -		if ((text =3D (uchar*)*a++) =3D=3D NULL)
> -		    return FALSE;
> -		continue;
> -	    }
> -	    if (*text++ =3D=3D '/' && (matched =3D dowild(p, text, a)) !=3D=
 FALSE
> -	     && matched !=3D ABORT_TO_STARSTAR)
> -		break;
> -	}
> -    }
> -    return matched =3D=3D TRUE;
> -}
> -
> -/* Match literal string "s" against the a virtually-joined string co=
nsisting
> - * of all the pointers in array "texts" (which has a NULL pointer at=
 the
> - * end).  The int "where" can be 0 (normal matching), or > 0 (match
> - * only the trailing N slash-separated filename components of "texts=
"). */
> -int litmatch_array(const char *string, const char*const *texts, int =
where)
> -{
> -    const uchar *s =3D (const uchar*)string;
> -    const uchar*const *a =3D (const uchar* const*)texts;
> -    const uchar *text;
> -
> -    if (where > 0)
> -	text =3D trailing_N_elements(&a, where);
> -    else
> -	text =3D *a++;
> -    if (!text)
> -	return FALSE;
> -
> -    return doliteral(s, text, a) =3D=3D TRUE;
> -}
> diff --git a/wildmatch.h b/wildmatch.h
> index e7f1a35..562faa3 100644
> --- a/wildmatch.h
> +++ b/wildmatch.h
> @@ -2,5 +2,3 @@
> =20
>  int wildmatch(const char *pattern, const char *text);
>  int iwildmatch(const char *pattern, const char *text);
> -int wildmatch_array(const char *pattern, const char*const *texts, in=
t where);
> -int litmatch_array(const char *string, const char*const *texts, int =
where);
