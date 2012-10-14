From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 07/12] wildmatch: make wildmatch's return value
 compatible with fnmatch
Date: Sat, 13 Oct 2012 22:09:31 -0700
Message-ID: <7vwqytzlkk.fsf@alter.siamese.dyndns.org>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
 <1350182110-25936-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 07:09:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNGSP-0007Sa-W6
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498Ab2JNFJf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 01:09:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62143 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab2JNFJf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:09:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 774EF64DA;
	Sun, 14 Oct 2012 01:09:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qRBEpOnqTEAm
	CNXOFEAlzWwGNAk=; b=XFqmONVO9fDSxwlcaCAP30Xb3smk17owmnqRXYpxRRTH
	3cmOb1ua3ds1hU3bYM3PL+yJjS8K3/Hck/4FuZXO/h6aw5Jkr2+GkBBBoenvUthT
	ZF/ax97+dVsZPiPMaKeAw+aq4eTWVbNLT4vohF+pxmaK7vaGpImHp4qsYO4v1XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ae93j2
	mCzUxYPPfYa2m39Wzw/V0m9rNDtBhHL6LRqQyE9fb46l6CrTcmOiBJRmPm8ijvOo
	KINW4FVkDX2O7dWM6gkoFgNbftOrrpMb2gu5MdbZF2iJ4pD1IcIJgkxrUxv9h5wr
	urGH9i4QF7fR1KlfW4kPW4mhBopJwP+kVILik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B7BE64D8;
	Sun, 14 Oct 2012 01:09:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C8E864D7; Sun, 14 Oct 2012
 01:09:33 -0400 (EDT)
In-Reply-To: <1350182110-25936-8-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 14 Oct
 2012 09:35:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57705A72-15BD-11E2-9C4E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207614>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> wildmatch returns non-zero if matched, zero otherwise. This patch
> makes it return zero if matches, non-zero otherwise, like fnmatch().
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

OK, so ABORT cases where the patterns are either broken or impossible
to match are also taken as not-matching, which sounds like the right
thing to do.

>  test-wildmatch.c |  4 ++--
>  wildmatch.c      | 21 ++++++++++++---------
>  2 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/test-wildmatch.c b/test-wildmatch.c
> index ac56420..77014e9 100644
> --- a/test-wildmatch.c
> +++ b/test-wildmatch.c
> @@ -4,9 +4,9 @@
>  int main(int argc, char **argv)
>  {
>  	if (!strcmp(argv[1], "wildmatch"))
> -		return wildmatch(argv[3], argv[2]) ? 0 : 1;
> +		return !!wildmatch(argv[3], argv[2]);
>  	else if (!strcmp(argv[1], "iwildmatch"))
> -		return iwildmatch(argv[3], argv[2]) ? 0 : 1;
> +		return !!iwildmatch(argv[3], argv[2]);
>  	else if (!strcmp(argv[1], "fnmatch"))
>  		return !!fnmatch(argv[3], argv[2], FNM_PATHNAME);
>  	else
> diff --git a/wildmatch.c b/wildmatch.c
> index d0b906a..e3ac6cc 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -20,6 +20,9 @@ typedef unsigned char uchar;
> =20
>  #define FALSE 0
>  #define TRUE 1
> +
> +#define NOMATCH 1
> +#define MATCH 0
>  #define ABORT_ALL -1
>  #define ABORT_TO_STARSTAR -2
> =20
> @@ -78,12 +81,12 @@ static int dowild(const uchar *p, const uchar *te=
xt)
>  	    /* FALLTHROUGH */
>  	  default:
>  	    if (t_ch !=3D p_ch)
> -		return FALSE;
> +		return NOMATCH;
>  	    continue;
>  	  case '?':
>  	    /* Match anything but '/'. */
>  	    if (t_ch =3D=3D '/')
> -		return FALSE;
> +		return NOMATCH;
>  	    continue;
>  	  case '*':
>  	    if (*++p =3D=3D '*') {
> @@ -96,14 +99,14 @@ static int dowild(const uchar *p, const uchar *te=
xt)
>  		 * only if there are no more slash characters. */
>  		if (!special) {
>  			if (strchr((char*)text, '/') !=3D NULL)
> -			    return FALSE;
> +			    return NOMATCH;
>  		}
> -		return TRUE;
> +		return MATCH;
>  	    }
>  	    while (1) {
>  		if (t_ch =3D=3D '\0')
>  		    break;
> -		if ((matched =3D dowild(p, text)) !=3D FALSE) {
> +		if ((matched =3D dowild(p, text)) !=3D NOMATCH) {
>  		    if (!special || matched !=3D ABORT_TO_STARSTAR)
>  			return matched;
>  		} else if (!special && t_ch =3D=3D '/')
> @@ -202,18 +205,18 @@ static int dowild(const uchar *p, const uchar *=
text)
>  		    matched =3D TRUE;
>  	    } while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
>  	    if (matched =3D=3D special || t_ch =3D=3D '/')
> -		return FALSE;
> +		return NOMATCH;
>  	    continue;
>  	}
>      }
> =20
> -    return *text ? FALSE : TRUE;
> +    return *text ? NOMATCH : MATCH;
>  }
> =20
>  /* Match the "pattern" against the "text" string. */
>  int wildmatch(const char *pattern, const char *text)
>  {
> -    return dowild((const uchar*)pattern, (const uchar*)text) =3D=3D =
TRUE;
> +    return dowild((const uchar*)pattern, (const uchar*)text);
>  }
> =20
>  /* Match the "pattern" against the forced-to-lower-case "text" strin=
g. */
> @@ -221,7 +224,7 @@ int iwildmatch(const char *pattern, const char *t=
ext)
>  {
>      int ret;
>      force_lower_case =3D 1;
> -    ret =3D dowild((const uchar*)pattern, (const uchar*)text) =3D=3D=
 TRUE;
> +    ret =3D dowild((const uchar*)pattern, (const uchar*)text);
>      force_lower_case =3D 0;
>      return ret;
>  }
