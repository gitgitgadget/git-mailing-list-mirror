From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove redundant assignments
Date: Sun, 27 Nov 2011 00:26:45 -0800
Message-ID: <7vfwhavum2.fsf@alter.siamese.dyndns.org>
References: <1322381142-20645-1-git-send-email-jstepien@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan =?utf-8?B?U3TEmXBpZcWE?= <jstepien@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Nov 27 09:27:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUa4z-0002LU-Vd
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 09:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab1K0I0v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Nov 2011 03:26:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510Ab1K0I0u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2011 03:26:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67B8533F7;
	Sun, 27 Nov 2011 03:26:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2vIiCmepvbh9
	4634oseVmmA+AgU=; b=XEpxEKphnDk6Al/SwIbEGnEOaWvdEpCn0KblT/LcUhJR
	NK1tngE0+QdpMpYtNxSOsm0SgwhZX6CdjocM7inyQRuP/KCnH3wIrE6m5zqu4fWr
	E/SMIjBW1NQ3O7Ce0BZOM7Wff3QHOhCGDDHne477bCTohFIj8eCwaJyj5oxeI94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VUyH4A
	I5Wkln8q+9v5Z3VSZUmqH0ij8+IRZXg6P8E/lcKqCqutPVdSXSHc3oqgIIhlJtpz
	spC6+qcFJbdAgdwuTXQ1TdO8M9+KRiEawzaSVaWV3A8V06sqRPI2dkhcXeczAXNw
	05L4gq8f72zm2ri+xmDK2MEiRbyx+bRALv2o8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EDE033F6;
	Sun, 27 Nov 2011 03:26:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F4C833F5; Sun, 27 Nov 2011
 03:26:47 -0500 (EST)
In-Reply-To: <1322381142-20645-1-git-send-email-jstepien@users.sourceforge.net> ("Jan
 =?utf-8?B?U3TEmXBpZcWEIidz?= message of "Sun, 27 Nov 2011 09:05:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C0244F6-18D1-11E1-AA76-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185969>

Jan St=C4=99pie=C5=84  <jstepien@users.sourceforge.net> writes:

> There were two redundant variable assignments in transport.c and
> wt-status.c. Removing them hasn't introduced any compiler warnings or
> regressions.

It may not have added any warnings for _you_.

These "type a =3D a;" initializations (they are not even assignments an=
d
would not result in any code in the output for sane compilers) are idio=
ms
to squelch "unused" warnings from versions of compiler whose data flow
analysis is less than perfect by telling them that the author of the
section of the code knows what s/he is doing.

At least, that is why these pseudo initializations were added in these
codepaths. I personally feel that they should be made into useless but
real assignments (which may result in a useless assignment emited in th=
e
resulting object code) rather than removing like your patch did which
unfortunately forces people with imperfect compilers to live with the
warnings, if one finds them ugly.

> Signed-off-by: Jan St=C4=99pie=C5=84 <jstepien@users.sourceforge.net>
> ---
>  transport.c |    2 +-
>  wt-status.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index 51814b5..5143718 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -105,7 +105,7 @@ static void insert_packed_refs(const char *packed=
_refs, struct ref **list)
>  		return;
> =20
>  	for (;;) {
> -		int cmp =3D cmp, len;
> +		int cmp, len;
> =20
>  		if (!fgets(buffer, sizeof(buffer), f)) {
>  			fclose(f);
> diff --git a/wt-status.c b/wt-status.c
> index 70fdb76..35f61f4 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -229,7 +229,7 @@ static void wt_status_print_change_data(struct wt=
_status *s,
>  {
>  	struct wt_status_change_data *d =3D it->util;
>  	const char *c =3D color(change_type, s);
> -	int status =3D status;
> +	int status;
>  	char *one_name;
>  	char *two_name;
>  	const char *one, *two;
