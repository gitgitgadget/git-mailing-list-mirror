From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/5] parse-options: Allow PARSE_OPT_NOARG in integer
 arguments
Date: Fri, 20 Aug 2010 12:49:51 -0700
Message-ID: <7vlj81awtc.fsf@alter.siamese.dyndns.org>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
 <1282331702-5115-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 21:50:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmXbe-0007HU-Dw
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 21:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609Ab0HTTuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 15:50:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab0HTTuU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 15:50:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59D7FCF3B4;
	Fri, 20 Aug 2010 15:50:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I8UNdpDCRzWnFYpnLuEDlI1OYLQ=; b=GA7cYk
	owHlu4QNYL95nVTTiGib3zJ5s2MJX0ucSiIUVTgjbJKsNY5D+w+oelalsYhTgo3L
	LEHRLk+Tb7g4HJlrcIxAhBkPzk1mqvti0+lkiwcS2W+8qzfmow8YGIn3N2+CwOXM
	xdDvifRCds2kpL2BaPQYmjE2eotvVNmvHgTcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kwDzhQekK3+Oj+HOkUKRDciWaNYd4X26
	yiSUyExyjqzXa/OAiCdKAfZ8gdgE47mRdMSJcqR/VH9GArfZnVeTfuk1npOOlAy0
	7Z93B84AMRaHf1iKqeyRNb6qefMwlkMYCdjLmzjFK4kZa8DUm1KkHxFQsR6xbBUX
	K00Ao5vvkyM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C82C0CF3AF;
	Fri, 20 Aug 2010 15:50:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F487CF3AA; Fri, 20 Aug
 2010 15:49:53 -0400 (EDT)
In-Reply-To: <1282331702-5115-2-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Sat\, 21 Aug 2010 00\:44\:58 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2441148C-AC94-11DF-A543-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154076>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> When the option parser encounters an OPTION_INTEGER argument,
> PARSE_OPT_NOARG should imply that the default value should be used.

Sorry but why?

Doesn't NOARG mean "Do not take an argument, if you give me an argument
that is an error"?

I would understand if this were OPT_OPTARG, though.

Confused...

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Cc: Jakub Narebski <jnareb@gmail.com>
> ---
>  parse-options.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index e0c3641..7ec9886 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -138,6 +138,9 @@ static int get_value(struct parse_opt_ctx_t *p,
>  			*(int *)opt->value = 0;
>  			return 0;
>  		}
> +		if (opt->flags & PARSE_OPT_NOARG)
> +			*(int *)opt->value = opt->defval;
> +			return 0;
>  		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
>  			*(int *)opt->value = opt->defval;
>  			return 0;
> -- 
> 1.7.2.2.409.gdbb11.dirty
