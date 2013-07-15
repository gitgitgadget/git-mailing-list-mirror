From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] diff: allow --patch to override -s/--no-patch
Date: Mon, 15 Jul 2013 08:02:14 -0700
Message-ID: <7v61wbeuix.fsf@alter.siamese.dyndns.org>
References: <vpqa9lof2e4.fsf@anie.imag.fr>
	<1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr>
	<1373893639-13413-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, stefanbeller@googlemail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 15 17:02:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UykIE-0003S3-Df
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 17:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451Ab3GOPCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 11:02:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088Ab3GOPCV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 11:02:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15A3230A3A;
	Mon, 15 Jul 2013 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Af57L/g+9a1FWB0pDs6rtyy/VJQ=; b=P3MnLE
	gTWwgLZH+kASW6WUIK+csy/3OtdCkNAoXxDsJJTe+OHEDZ2d+n6K8ieUpw5UxwAV
	8/AWzCKGEOZWL+q4K9sWshWmHZqDdiFVj7YYtcvSo9u/pJ1A5W2cgxXx+k+IoYVP
	HIgNpvtciTeewBD22hg7BLAkJNaeDL5ZyDqxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=joh8VD24gcgyFfrcHG3kaFtwOs0M+oyP
	aLjkdVQvNYFsdbEYDrX+J7jSQKgloxkXrRUrA0XV+LHaUOyKrapdDIxitZu7n2xm
	cWZ9kk9f1mcEBPwsGO9qTgWDi4Ej5KrM5fnxRXNwD8T1XgQSAGYa/y29CkLTCoxw
	do/QxZ/g0P0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E03FD30A27;
	Mon, 15 Jul 2013 15:02:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DD1830A1C;
	Mon, 15 Jul 2013 15:02:20 +0000 (UTC)
In-Reply-To: <1373893639-13413-3-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 15 Jul 2013 15:07:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C0E8BEE-ED5F-11E2-87EC-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230474>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  diff.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 6bd821d..66a6877 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3515,9 +3515,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  	int argcount;
>  
>  	/* Output format options */
> -	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch"))
> +	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch")) {
> +		options->output_format &= ~DIFF_FORMAT_NO_OUTPUT;
>  		options->output_format |= DIFF_FORMAT_PATCH;
> -	else if (opt_arg(arg, 'U', "unified", &options->context))
> +	} else if (opt_arg(arg, 'U', "unified", &options->context))
>  		options->output_format |= DIFF_FORMAT_PATCH;
>  	else if (!strcmp(arg, "--raw"))
>  		options->output_format |= DIFF_FORMAT_RAW;

I am wondering if the difference after this patch between "-p" and
"-U8" is deliberate, or just an accident coming from the way the
original was written in ee1e5412 (git diff: support "-U" and
"--unified" options properly, 2006-05-13).

If the original were written in this way:

	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch") ||
            opt_arg(arg, 'U', "unified", &options->context))
  		options->output_format |= DIFF_FORMAT_PATCH;

I suspect you would have given the additional

		options->output_format &= ~DIFF_FORMAT_NO_OUTPUT;

to the whole thing, without singling out "-U8".  Or am I missing
some good reason why "--no-patch -U8" should not produce a patch,
while "--no-patch -p" and "-U8" should both should?
