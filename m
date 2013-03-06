From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] wt-status: split wt_status_state parsing function
 out
Date: Wed, 06 Mar 2013 10:48:41 -0800
Message-ID: <7v4ngoqs8m.fsf@alter.siamese.dyndns.org>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
 <1362572482-20570-1-git-send-email-pclouds@gmail.com>
 <1362572482-20570-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 19:49:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDJOr-0003Gl-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 19:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951Ab3CFSss convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 13:48:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638Ab3CFSsr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Mar 2013 13:48:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F64EA491;
	Wed,  6 Mar 2013 13:48:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=h66HdT7MyjHz
	QLnVLcM2GqJnR6U=; b=XQNd0jako0ni3qXQNSbjEdO9uG8bWqBQTXuJno/hpMCT
	Ro0ygac6E9Ugd/NzjpjwVCfVU50ePsX/E71g3CEZcgBn3Yi7iubvdbiVzV1wUIlM
	ILafofvBq9sesaU7HSjGoGoDHh7CHEYib98KzA4xy/v5cojC7/dBgMt5SHiOc2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fRLX1r
	kp7zGbHSuwqMUIxBYt2POZnrzhoGPAXU4uplVlI7aBaKSHqnUX0rbF+r6EDFv0Ub
	ZxYLgkrQnNHpfa4Efsl6X3WkQiQRbsoxoNaYrBWAqxfxSsHMsY9u64saPr6tiVBv
	qFmHF4QvcDHI5EiSugefk/HGh3xem28Keu5b0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03AACA490;
	Wed,  6 Mar 2013 13:48:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D907A48D; Wed,  6 Mar 2013
 13:48:43 -0500 (EST)
In-Reply-To: <1362572482-20570-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 6 Mar
 2013 19:21:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78283BD0-868E-11E2-91FC-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217536>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  wt-status.c | 52 +++++++++++++++++++++++++++++++--------------------=
-
>  wt-status.h |  5 +++--
>  2 files changed, 34 insertions(+), 23 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index ef405d0..183aafe 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -970,7 +970,7 @@ static void show_bisect_in_progress(struct wt_sta=
tus *s,
>   * Extract branch information from rebase/bisect
>   */
>  static void read_and_strip_branch(struct strbuf *sb,
> -				  const char **branch,
> +				  char **branch,
>  				  const char *path)
>  {
>  	unsigned char sha1[20];
> @@ -994,52 +994,62 @@ static void read_and_strip_branch(struct strbuf=
 *sb,
>  		strbuf_addstr(sb, abbrev);
>  		*branch =3D sb->buf;
>  	} else if (!strcmp(sb->buf, "detached HEAD")) /* rebase */
> -		;
> +		*branch =3D NULL;
>  	else			/* bisect */
>  		*branch =3D sb->buf;
> +	if (*branch)
> +		*branch =3D xstrdup(*branch);
>  }

The reason why the original print_state() kept two strbufs in it was
because its use of the return value (in *branch) from this function
was private and it did not want to have to strdup anything.

With this change, I suspect that it is much saner to make this
function *not* take any external strbuf as input, because you are
always returning a piece of memory that belongs to the caller, or a
NULL.

In other words, with the new world order, wouldn't a saner function
signature be:

	static const char *read_and_strip_branch(const char **path);

after this patch?

Also I notice that the error-return cases of this function may be
wrong even before your patch.  Shouldn't it be doing *branch =3D NULL
(and 'return NULL' after the suggested change)?
