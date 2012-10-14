From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v5 02/12] ctype: support iscntrl, ispunct, isxdigit and
 isprint
Date: Sun, 14 Oct 2012 14:59:41 +0200
Message-ID: <507AB73D.8010406@lsrfire.ath.cx>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com> <1350182110-25936-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 15:00:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNNnY-0002U3-3u
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 15:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab2JNM7v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 08:59:51 -0400
Received: from plane.gmane.org ([80.91.229.3]:52544 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119Ab2JNM7u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 08:59:50 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TNNnP-0002Nk-AE
	for git@vger.kernel.org; Sun, 14 Oct 2012 14:59:55 +0200
Received: from p4ffdaf97.dip.t-dialin.net ([79.253.175.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 14:59:55 +0200
Received: from rene.scharfe by p4ffdaf97.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 14:59:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p4ffdaf97.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121005 Thunderbird/16.0
In-Reply-To: <1350182110-25936-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207661>

Am 14.10.2012 04:35, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>   ctype.c           | 18 ++++++++++++++++++
>   git-compat-util.h | 13 +++++++++++++
>   2 files changed, 31 insertions(+)
>
> diff --git a/ctype.c b/ctype.c
> index faeaf34..b4bf48a 100644
> --- a/ctype.c
> +++ b/ctype.c
> @@ -26,6 +26,24 @@ const unsigned char sane_ctype[256] =3D {
>   	/* Nothing in the 128.. range */
>   };
>
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

Shouldn't [ace] (65, 67, 69) and [ACE] (97, 99, 101) be xdigits as well=
?

But how about using the existing hexval_table instead, like this:

	#define isxdigit(x) (hexval_table[(x)] !=3D -1)

With that, couldn't you squeeze the other two classes into the existing=
=20
sane_type?

By the way, I'm working on a patch series for implementing a lot more=20
character classes with table lookups.  It grew out of a desire to make=20
bad_ref_char() faster but perhaps got a bit out of hand by now; it's at=
=20
24 patches and still not finished.  I'm curious how long we have until=20
it escapes. ;-)

>  #define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REG=
EX_SPECIAL)
> +#define iscntrl(x) sane_istest2(x, GIT_CNTRL)
> +#define ispunct(x) sane_istest2(x, GIT_PUNCT)
> +#define isxdigit(x) sane_istest2(x, GIT_XDIGIT)
> +#define isprint(x) (isalnum(x) || isspace(x) || ispunct(x))

If a single table is used, you can do with a single table lookup by=20
adding the bits for the component classes, like isalnum and=20
is_regex_special do.

Ren=C3=A9
