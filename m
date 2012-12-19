From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] wildmatch: make dowild() take arbitrary flags
Date: Wed, 19 Dec 2012 08:32:40 -0800
Message-ID: <7v4njiatp3.fsf@alter.siamese.dyndns.org>
References: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
 <1355922488-20976-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 17:33:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlMZq-0005ID-63
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 17:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875Ab2LSQcp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2012 11:32:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754317Ab2LSQcn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2012 11:32:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD5F1A6E0;
	Wed, 19 Dec 2012 11:32:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ytKGUKxWWOi8
	N1v5SqypRLzzHD0=; b=rqZcnZEIvB/ZBhvZc6/DMqjV8GNlB/nTGIPiUYW3X6qM
	mNcuXZkvogtTjOZpmNXH/o+bKhBQuJHMIusPzLQ+Ce4hTDG1xX6dPchLsftqEpAr
	n3g0I3pGTUAFvLvMxjJ6iiE74RgdSSO+wCKXIFltJE75EKEVPwW5sBLH++je53U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XpQvYa
	nLsNkFVJGJYWComFPNuhR1blg1gwUz3+RaZqAQAdY/9b/wDywtavnbLq/sU4X5Eq
	sbS7xD6CWdq9W/CQ2prNux2DvQIUzJhSf1sKCR89AtM+ueOZGNDdxw0tiFkrBSsY
	5kITk90TNhNAHStIyqu3/x7GpLAXMPWzoo2Ic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CABB5A6D6;
	Wed, 19 Dec 2012 11:32:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 384E8A6D3; Wed, 19 Dec 2012
 11:32:42 -0500 (EST)
In-Reply-To: <1355922488-20976-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 19 Dec
 2012 20:08:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5EC702A-49F9-11E2-9953-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211834>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  wildmatch.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/wildmatch.c b/wildmatch.c
> index 3972e26..9586ed9 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -55,7 +55,7 @@ typedef unsigned char uchar;
>  #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
> =20
>  /* Match pattern "p" against "text" */
> -static int dowild(const uchar *p, const uchar *text, int force_lower=
_case)
> +static int dowild(const uchar *p, const uchar *text, int flags)

It may be better to declare a bitset like this unsigned.

>  {
>  	uchar p_ch;
> =20
> @@ -64,9 +64,9 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
>  		uchar t_ch, prev_ch;
>  		if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
>  			return ABORT_ALL;
> -		if (force_lower_case && ISUPPER(t_ch))
> +		if (flags & FNM_CASEFOLD && ISUPPER(t_ch))

Please add parentheses around bitwise-AND that is used as a boolean,
i.e.

	if ((flags & FNM_CASEFOLD) && ISUPPER(t_ch))

Less chance of confusion.
