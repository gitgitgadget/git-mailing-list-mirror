From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] i18n: format_tracking_info "Your branch is behind"
 message
Date: Wed, 01 Feb 2012 17:50:29 -0800
Message-ID: <7vr4yeypei.fsf@alter.siamese.dyndns.org>
References: <1328146639-87863-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 02:50:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rslor-0002rd-TP
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 02:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab2BBBuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 20:50:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238Ab2BBBub (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 20:50:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B00F6A16;
	Wed,  1 Feb 2012 20:50:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nE5oBEeSvVFMsqUzsfCJfeOSGDA=; b=sWiF73
	EiO00Z4YoL59mI9o+XxPfKgZm1nM7gjLIeFq/CazIa8J9uAyvSqooQi3tEtkf1q3
	htBHA4uqZcPQKbiesU38FIuyvsSkCJvAHpS1wETN9SVnlTka747WrnmZcGGfbpnS
	45vo9FChvPWPiAZzbnm/YJlmNdmHEAMzPdOQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SLkVYhYo84+yyCBOh0mk/+dQnnGURRx7
	HwtQzSg/LzcDclmDbVmYkjc1PluzRPUI6MOpFJ9YGSnnWXzJf/8UJTc8ufUpzTu7
	jo3aZ+C1fdVZSQuQwo6w2J5ef/B+vWxbbr7waP29o5DJk1Kr5mR1sx0bq5LMhK46
	onrrZan0v9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 227536A15;
	Wed,  1 Feb 2012 20:50:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77B1C6A14; Wed,  1 Feb 2012
 20:50:30 -0500 (EST)
In-Reply-To: <1328146639-87863-1-git-send-email-worldhello.net@gmail.com>
 (Jiang Xin's message of "Thu, 2 Feb 2012 09:37:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 498C59A6-4D40-11E1-B862-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189573>

Jiang Xin <worldhello.net@gmail.com> writes:

> Function format_tracking_info in remote.c is called by
> wt_status_print_tracking in wt-status.c, which will print
> branch tracking message in git-status. git-checkout also
> show these messages through it's report_tracking function.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  remote.c |   48 +++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 37 insertions(+), 11 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 73a38..45ac1 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1572,19 +1572,45 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
>  	base = branch->merge[0]->dst;
>  	base = shorten_unambiguous_ref(base, 0);
>  	if (!num_theirs)
> -		strbuf_addf(sb, "Your branch is ahead of '%s' "
> -			    "by %d commit%s.\n",
> -			    base, num_ours, (num_ours == 1) ? "" : "s");
> +		strbuf_addf(sb,
> +			Q_(
> +			/* The singular version */
> +			"Your branch is ahead of '%s' by %d commit.\n",
> +			/* The plural version */
> +			"Your branch is ahead of '%s' by %d commits.\n",
> +			/* Give ngettext() the count */
> +			num_ours),
> +			base,
> +			num_ours);

It may be just me, but I think

		strbuf_addf(sb,
			Q_("Your branch is ahead of '%s' by %d commit.\n",
			   "Your branch is ahead of '%s' by %d commits.\n",
			   num_ours),
                        base, num_ours);

would be far easier to read than these repetitive comments.

It allows you to see it more clearly that the two strings and one variable
are given to Q_(), and the last two, base and num_ours, are the values to
be formatted by whatever the format string Q_() would choose.

When the strings are longer, an extra indent would probably help, e.g.

		strbuf_addf(sb,
			Q_("Your branch is behind '%s' by %d commit, "
				"and can be fast-forwarded.\n",
			   "Your branch is behind '%s' by %d commits, "
				"and can be fast-forwarded.\n",
			   num_theirs),
			base, num_theirs);
