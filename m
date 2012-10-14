From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/12] ctype: support iscntrl, ispunct, isxdigit and
 isprint
Date: Sat, 13 Oct 2012 22:02:07 -0700
Message-ID: <7va9vp1wa8.fsf@alter.siamese.dyndns.org>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
 <1350182110-25936-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 07:02:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNGLH-0001NB-6y
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab2JNFCM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 01:02:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60002 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395Ab2JNFCK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:02:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C61D36372;
	Sun, 14 Oct 2012 01:02:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IzUGZvxsQWrD
	TTJpz7obHu9r5Zg=; b=EbesR6D2Qm8lsXgaiU6vp664kmumOg5koCmjZYqpV5Vb
	1eGNVI/Gv8Jj5nfRmUTHO0v2tdHYibtSFuOB9z7ntOR+0pkgsWWLNE1KBVpPe385
	ZYWlK7tO9EaYmtkwo85Cvo5iTPTOrz6XvOzMV9oW739OaWhuOEgGBbEmJe8kX84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VDIz7E
	0af4M+lmTRxRYxjmjCqlC7vt1mo44tgTI8f2QtqcqeHDeQ6Oi10YzqHK/vEo8E3f
	ETTmlBAu/IEEvn6nG2lj2Ue946B2/S8KBXw0hafawojhvPODKu/JD1/pT1z+/hIA
	ttSyTHEsDI4W5iQUoBtZtuehnZ2IAvPNhMycg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B50626371;
	Sun, 14 Oct 2012 01:02:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E338E6370; Sun, 14 Oct 2012
 01:02:08 -0400 (EDT)
In-Reply-To: <1350182110-25936-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 14 Oct
 2012 09:35:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E7CF0D4-15BC-11E2-8E2A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207612>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

The description to justify why it is ctype2[] seems to have been
lost.  Intended?

>  ctype.c           | 18 ++++++++++++++++++
>  git-compat-util.h | 13 +++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/ctype.c b/ctype.c
> index faeaf34..b4bf48a 100644
> --- a/ctype.c
> +++ b/ctype.c
> @@ -26,6 +26,24 @@ const unsigned char sane_ctype[256] =3D {
>  	/* Nothing in the 128.. range */
>  };
> =20
> +enum {
> +	CN =3D GIT_CNTRL,
> +	PU =3D GIT_PUNCT,
> +	XD =3D GIT_XDIGIT,
> +};
> +
> +const unsigned char sane_ctype2[256] =3D {
> +	CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, /* =
   0..15 */
> +	CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, /* =
  16..31 */
> +	0,  PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, /* =
  32..47 */
> +	XD, XD, XD, XD, XD, XD, XD, XD, XD, XD, PU, PU, PU, PU, PU, PU, /* =
  48..63 */
> +	PU, 0,	XD, 0,	XD, 0,	XD, 0,	0,  0,	0,  0,	0,  0,	0,  0,	/*   64..79=
 */
> +	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  PU, PU, PU, PU, PU, /* =
  80..95 */
> +	PU, 0,	XD, 0,	XD, 0,	XD, 0,	0,  0,	0,  0,	0,  0,	0,  0,	/*  96..111=
 */
> +	0,  0,	0,  0,	0,  0,	0,  0,	0,  0,	0,  PU, PU, PU, PU, CN, /* 112..=
127 */
> +	/* Nothing in the 128.. range */
> +};
> +
>  /* For case-insensitive kwset */
>  const char tolower_trans_tbl[256] =3D {
>  	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f8b859c..ea11694 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -510,14 +510,23 @@ extern const char tolower_trans_tbl[256];
>  #undef isupper
>  #undef tolower
>  #undef toupper
> +#undef iscntrl
> +#undef ispunct
> +#undef isxdigit
> +#undef isprint
>  extern const unsigned char sane_ctype[256];
> +extern const unsigned char sane_ctype2[256];
>  #define GIT_SPACE 0x01
>  #define GIT_DIGIT 0x02
>  #define GIT_ALPHA 0x04
>  #define GIT_GLOB_SPECIAL 0x08
>  #define GIT_REGEX_SPECIAL 0x10
>  #define GIT_PATHSPEC_MAGIC 0x20
> +#define GIT_CNTRL 0x01
> +#define GIT_PUNCT 0x02
> +#define GIT_XDIGIT 0x04
>  #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask=
)) !=3D 0)
> +#define sane_istest2(x,mask) ((sane_ctype2[(unsigned char)(x)] & (ma=
sk)) !=3D 0)
>  #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
>  #define isspace(x) sane_istest(x,GIT_SPACE)
>  #define isdigit(x) sane_istest(x,GIT_DIGIT)
> @@ -527,6 +536,10 @@ extern const unsigned char sane_ctype[256];
>  #define isupper(x) sane_iscase(x, 0)
>  #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
>  #define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REG=
EX_SPECIAL)
> +#define iscntrl(x) sane_istest2(x, GIT_CNTRL)
> +#define ispunct(x) sane_istest2(x, GIT_PUNCT)
> +#define isxdigit(x) sane_istest2(x, GIT_XDIGIT)
> +#define isprint(x) (isalnum(x) || isspace(x) || ispunct(x))
>  #define tolower(x) sane_case((unsigned char)(x), 0x20)
>  #define toupper(x) sane_case((unsigned char)(x), 0)
>  #define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
