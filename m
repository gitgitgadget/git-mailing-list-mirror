From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add grep.fullName config variable
Date: Mon, 17 Mar 2014 15:21:41 -0700
Message-ID: <xmqq7g7sbh56.fsf@gitster.dls.corp.google.com>
References: <874n2w3abu.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 23:22:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPfvM-0004G2-4Q
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 23:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbaCQWWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 18:22:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbaCQWWT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 18:22:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCBDD760DF;
	Mon, 17 Mar 2014 18:22:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rdSR08XhtcePPsw2MmSyEf6hcf8=; b=ZSgM7m
	sAbtKs7uOA75dIDKXqEemI3EaTBPM10zWBvL53Wj/iasew65as4BF/P84SaNL4oP
	7o0jjFYE3Zs6gmCbawJLBNc5qb98ARIrtXuMS/OETg3QqcmMzC3TSwgmB5DBrQsc
	qBWBA2MbpPClNtngxMQois2lFHHuNb52yPTvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xGJ7kqiL0LsXK5Lywr0N/YGi7MSUyb4K
	x4EsyLz1wUslsh/GHBse0kXptGQSM/pljTfDtIDa/iSC1mGtxi2mbP60vgynkhZH
	0/OM3rHHeqjhwWGxlCsnYd8xaH+GnvcVIOra434vZR1ze7cS8b5DEL3MKCigH6zx
	a0XEn1S/hg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A772B760DD;
	Mon, 17 Mar 2014 18:22:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E6D676088;
	Mon, 17 Mar 2014 18:21:54 -0400 (EDT)
In-Reply-To: <874n2w3abu.fsf@igel.home> (Andreas Schwab's message of "Mon, 17
	Mar 2014 20:16:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8B8C7E7C-AE22-11E3-8B78-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244301>

Andreas Schwab <schwab@linux-m68k.org> writes:

> This configuration variable sets the default for the --full-name option.
>
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---

Would this change break Porcelains (e.g. Emacs modes) and force them
to be updated to explicitly pass --no-full-name to unbreak them?

>  Documentation/git-grep.txt | 3 +++
>  grep.c                     | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index f837334..31811f1 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -53,6 +53,9 @@ grep.extendedRegexp::
>  	option is ignored when the 'grep.patternType' option is set to a value
>  	other than 'default'.
>  
> +grep.fullName::
> +	If set to true, enable '--full-name' option by default.
> +
>  
>  OPTIONS
>  -------
> diff --git a/grep.c b/grep.c
> index c668034..ece04bf 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -86,6 +86,11 @@ int grep_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "grep.fullname")) {
> +		opt->relative = !git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "color.grep"))
>  		opt->color = git_config_colorbool(var, value);
>  	else if (!strcmp(var, "color.grep.context"))
> -- 
> 1.9.0
