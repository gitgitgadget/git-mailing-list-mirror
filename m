From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/25] fetch-pack: use a common function for verbose printing
Date: Thu, 04 Feb 2016 16:02:22 -0800
Message-ID: <xmqqlh70dnxt.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 01:02:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTr3-0000BZ-EH
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 01:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244AbcBEAC0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 19:02:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50952 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755869AbcBEACZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 19:02:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E958428CB;
	Thu,  4 Feb 2016 19:02:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=a2cTuOsW/FaE
	D216cdJuQ9moqFM=; b=LXHAFGhG+XlPZzv11M8azbyDZEHKahvyxVmjlGlW5wa5
	A8kD/cfp0ofIlOKYM7SSxZosfFy3bb6YwT+toeWOvum83H9mkHZinyEt/TKtySWI
	TSXD3xRh2zn+dgTk/ZZ+7+Qf2OBO1j7VzOSnQ7CAY/76IxiZr1kN/gcvJTHjLrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XD6Uni
	BB+F7SkgwzPpO3oYpTlxv6QTXUuhRB9mr6245LcTjxE3c6RXr74y8f9QiDchV6FO
	InYROZoZywF+aatz9VmGxnKMLbOQEfl8h4RgcVqwzW/7gjLmy9T6X4Z3AkSUzOu0
	YB92DXEcLnQcUkRhuVz2Ydn0jtplItxgegU7s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 75EFA428CA;
	Thu,  4 Feb 2016 19:02:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EB3AF428C8;
	Thu,  4 Feb 2016 19:02:23 -0500 (EST)
In-Reply-To: <1454576641-29615-13-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:48 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC097116-CB9B-11E5-BF13-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285527>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This reduces the number of "if (verbose)" which makes it a bit easier
> to read imo. It also makes it easier to redirect all these printouts,
> to a file for example.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

>  fetch-pack.c | 88 +++++++++++++++++++++++++++++---------------------=
----------
>  1 file changed, 42 insertions(+), 46 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 01e34b6..16917f9 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -50,6 +50,21 @@ static int non_common_revs, multi_ack, use_sideban=
d;
>  #define ALLOW_REACHABLE_SHA1	02
>  static unsigned int allow_unadvertised_object_request;
> =20
> +__attribute__((format (printf, 2, 3)))
> +static inline void print_verbose(const struct fetch_pack_args *args,
> +				 const char *fmt, ...)
> +{
> +	va_list params;
> +
> +	if (!args->verbose)
> +		return;
> +
> +	va_start(params, fmt);
> +	vfprintf(stderr, fmt, params);
> +	va_end(params);
> +	fputc('\n', stderr);
> +}

This does "print if told to be verbose".  Sounds more like 'tracef',
'reportf', 'debugf', etc.

I am debating myself if it is a good idea to omit the final "\n" on
the calling side and add one unconditionally here, but the benefit
of brevity on the many callsites outweigh the reduced flexibility, I
guess.

Thanks.
