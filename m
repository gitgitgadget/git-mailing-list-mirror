From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/5] blame: introduce $ as "end of file" in -L syntax
Date: Thu, 28 Feb 2013 09:18:40 -0800
Message-ID: <7vk3psicgf.fsf@alter.siamese.dyndns.org>
References: <cover.1362069310.git.trast@student.ethz.ch>
 <7973d90cfcd86a3c15776b8718ad6bd84ee7b4ac.1362069310.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 28 18:19:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB78O-0000rC-AE
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 18:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759569Ab3B1RSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 12:18:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755524Ab3B1RSn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 12:18:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D674BD2C;
	Thu, 28 Feb 2013 12:18:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EVD56BhdUQE5RcImeg5XLvarXUk=; b=d8acem
	9YEZQD26E6sCaxS2rRrrlzXISbD+ui1KtmEvIHKj5RHIRXfI9NBZ+lPbr//ay+Vr
	bSSZGxzAEiAtvSOk6QuwiQsxkPfaMqym1qbHkxmCoAvqQLrt6ScUhCGdgg+A369J
	3u1DudSvsNH/n6tfTc4VF67k8k5H6RXKxxJgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NPhxHu2L1K1/fd3Mmsrtzba8HJbaT4Yg
	lwgw8Fe3p4ojDP69qh3fOojXKN2qKqcljtrnCOAjOmygYXFV23Q5KiNWrx1kkDP0
	J6VyRQycZLU8REIktlh5Xgqrqc6IZtYFvhftq4eQIOf0iGi2o5ygUKQh4w4fTpx3
	CRzQ8AyB9Gw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D54EBD2B;
	Thu, 28 Feb 2013 12:18:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E48F8BD29; Thu, 28 Feb 2013
 12:18:41 -0500 (EST)
In-Reply-To: <7973d90cfcd86a3c15776b8718ad6bd84ee7b4ac.1362069310.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 28 Feb 2013 17:38:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E62A2DC8-81CA-11E2-B937-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217244>

Thomas Rast <trast@student.ethz.ch> writes:

> To save the user a lookup of the last line number, introduce $ as a
> shorthand for the last line.  This is mostly useful to spell "until
> the end of the file" as '-L<begin>,$'.

Doesn't "-L <begin>" or "-L <begin>," do that already?  If it were
to introduce "-L $-4," or "-L$-4,+2", I would understand why the
addition may be useful, but otherwise I do not think it adds much
value.

>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  Documentation/line-range-format.txt | 6 ++++++
>  line-log.c                          | 8 ++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
> index 265bc23..9ce0688 100644
> --- a/Documentation/line-range-format.txt
> +++ b/Documentation/line-range-format.txt
> @@ -16,3 +16,9 @@ starting at the line given by <start>.
>  This is only valid for <end> and will specify a number
>  of lines before or after the line given by <start>.
>  +
> +
> +- `$`
> ++
> +A literal dollar sign can be used as a shorthand for the last line in
> +the file.
> ++
> diff --git a/line-log.c b/line-log.c
> index a24a86b..b167b00 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -15,6 +15,14 @@ const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
>  	regmatch_t match[1];
>  
>  	/*
> +	 * $ is a synonym for "the end of the file".
> +	 */
> +	if (spec[0] == '$') {
> +		*ret = lines;
> +		return spec + 1;
> +	}
> +
> +	/*
>  	 * Allow "-L <something>,+20" to mean starting at <something>
>  	 * for 20 lines, or "-L <something>,-5" for 5 lines ending at
>  	 * <something>.
