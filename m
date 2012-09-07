From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] advice: extract function to print messages with
 prefix
Date: Fri, 07 Sep 2012 12:32:37 -0700
Message-ID: <7v1uidy6ga.fsf@alter.siamese.dyndns.org>
References: <7vhar9ybgk.fsf@alter.siamese.dyndns.org>
 <1347044705-17268-1-git-send-email-ralf.thielow@gmail.com>
 <1347044705-17268-2-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worldhello.net@gmail.com, pclouds@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 21:32:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA4IK-0004Ec-Az
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 21:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab2IGTcl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 15:32:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024Ab2IGTck convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2012 15:32:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E1F183BF;
	Fri,  7 Sep 2012 15:32:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TBmJFrZ/GWMs
	/KRbduTjdMlNyPg=; b=PKIqSLZbK/mvhHHsnSGTck4pl1Xk+/9/hIkakDORqRTT
	spYMeumKuwmGQDIeHRJbZiXDswH3ZKUZWIJq5F+DjfdU66mOExaSuppd2xOziI6p
	6XJDVj6peu4iMPYQzSAJpJKcziALfmS33pzSLrRwlhXO6RS8ZlatovQGbCbxrTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wpstgK
	Ei5Bp18M0tznWJYW3T21tNr254dOClO89G6pp506H+dIgsQ8Uwq7FXc1DmBHQ5jS
	reRzvVEOtsQn7v1iDw6zZ0g5SmgfZzLJdRa0sjUdGRR/W0VUYioH9cImJNhtUUdt
	S5hwbHR6K2TrXuNB9vDNLfWv4zc/f59JqaWNQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B70183BE;
	Fri,  7 Sep 2012 15:32:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7AEA83BC; Fri,  7 Sep 2012
 15:32:38 -0400 (EDT)
In-Reply-To: <1347044705-17268-2-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Fri, 7 Sep 2012 21:05:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8AE9274-F922-11E1-BE16-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204992>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Extract a function that allows to print messages
> with a prefix.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  advice.c | 14 ++++++++++----
>  advice.h |  1 +
>  2 Dateien ge=C3=A4ndert, 11 Zeilen hinzugef=C3=BCgt(+), 4 Zeilen ent=
fernt(-)
>
> diff --git a/advice.c b/advice.c
> index edfbd4a..e73d53b 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -25,25 +25,31 @@ static struct {
>  	{ "detachedhead", &advice_detached_head },
>  };
> =20
> -void advise(const char *advice, ...)
> +void print_with_prefix(const char *prefix, const char *msg, ...)
>  {
>  	struct strbuf buf =3D STRBUF_INIT;
>  	va_list params;
>  	const char *cp, *np;
> =20
> -	va_start(params, advice);
> -	strbuf_vaddf(&buf, advice, params);
> +	va_start(params, msg);
> +	strbuf_vaddf(&buf, msg, params);
>  	va_end(params);
> =20
>  	for (cp =3D buf.buf; *cp; cp =3D np) {
>  		np =3D strchrnul(cp, '\n');
> -		fprintf(stderr,	_("hint: %.*s\n"), (int)(np - cp), cp);
> +		fprintf(stderr,	 "%s %.*s\n", prefix, (int)(np - cp), cp);

Hrm, naively, printf("%s: %.*s\n", _("hint"), ...) might look more
natural, but I vaguely recall that the current code places _()
around the entire "hint: %.*s\n" on purpose.  IIRC, it was to allow
translations that flow from RTL e.g. ".siht od t'nod :tnih".

Doesn't this patch break it?
