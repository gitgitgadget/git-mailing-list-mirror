From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list: accept --format without argument
Date: Wed, 28 Jul 2010 09:04:43 -0700
Message-ID: <7vlj8v7ftw.fsf@alter.siamese.dyndns.org>
References: <1280310120-16852-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 28 18:04:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe97p-0007YC-NL
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 18:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab0G1QEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 12:04:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab0G1QEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 12:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16E0AC8BC1;
	Wed, 28 Jul 2010 12:04:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AJ3tXs1OkHCaQQVpL/rLW60EWbw=; b=QEIYiE
	9+0NDvMSV8iMdWKv9MbSqMSEGWvUAhFb1ro52QBJzoHWqpkOA6NQaUkGBtqetjEN
	qGtXXtJjKkRbH+JqE7zVLA8EJbfh2CWlIK2FHND87BZxXraKv4FBpgeGi9lAkgpk
	5cE8LryoC5qn5mK6UOnKcgSqR/KYJsIZdNYyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=llEturpe7coQjRgeGgwkADdZkd0n5apo
	yosLyN7W8iUzh2FFzPxkPhlWT95111rfLE2EH9Fgnw2aCDgESoT1DE4BlasSuFRC
	ChI63mlkSpfdGTKVq1Ae/AALtr7Xnlq4E4e/vmjawo37pvjAOYPvMHTfqu8/f4RX
	jboa02lgSqw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2A35C8BBF;
	Wed, 28 Jul 2010 12:04:47 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31DF9C8BB8; Wed, 28 Jul
 2010 12:04:45 -0400 (EDT)
In-Reply-To: <1280310120-16852-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Wed\, 28 Jul 2010 11\:42\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D87D212E-9A61-11DF-936C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152096>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The documentation says the syntax is --format[='<format>'], match it in
> the implementation.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Not that it's terribly usefull, but better be consistant ...

Hmm, I do not care too deeply either way as I do not expect anybody sane
to have used, nor learn from this patch and start using, --format without
any formatting specification, but it somehow feels that this patch takes
consistency the wrong way.

>  revision.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 33fa0b5..4b64757 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1300,10 +1300,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->combine_merges = 1;
>  	} else if (!strcmp(arg, "-v")) {
>  		revs->verbose_header = 1;
> -	} else if (!strcmp(arg, "--pretty")) {
> +	} else if (!strcmp(arg, "--pretty") || !strcmp(arg, "--format")) {
>  		revs->verbose_header = 1;
>  		revs->pretty_given = 1;
> -		get_commit_format(arg+8, revs);
> +		get_commit_format("", revs);
>  	} else if (!prefixcmp(arg, "--pretty=") || !prefixcmp(arg, "--format=")) {
>  		/*
>  		 * Detached form ("--pretty X" as opposed to "--pretty=X")
> -- 
> 1.7.2.25.g9ebe3
