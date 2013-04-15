From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] branch: colour upstream branches
Date: Sun, 14 Apr 2013 19:55:18 -0700
Message-ID: <7vwqs433l5.fsf@alter.siamese.dyndns.org>
References: <1365993469-6874-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 04:55:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URZZm-0007Py-QZ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 04:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901Ab3DOCzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 22:55:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56358 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab3DOCzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 22:55:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F62BF574;
	Mon, 15 Apr 2013 02:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xPw97dFrv4aAM7b2qjqYGKfSVuY=; b=GMuPBs
	Ubpp8ZDJAU/23hwvns/My2yMmgP4W4pzbUYi863rDwCyYXNgXsTfPqX0MiHnLiM5
	Q25DHCIMoN660e39j26P3DQfn4q/TErYAuS2QLpRGk5xfMDCgxX/tJlps5Ul7AGv
	MmeWrRx8NqN1Ackd5RtBaLO0iZmmZ1qGI2IZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ydvSUotQ8zpiW6wWWSuftHQP/MFhj/4M
	urpWYjP29qwOvYf/PvJOeAj7D0BNryuRo+g1r8YRVLjwnLZsfU958Fzemanz56U0
	TCOROCei//coBpBenA0yonhtCYQ715jLewAGIq8YHVJE4xsU4dc7/R+evbNZseM2
	6CcBwPCekL8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 750CDF573;
	Mon, 15 Apr 2013 02:55:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F8B0F571; Mon, 15 Apr 2013
 02:55:20 +0000 (UTC)
In-Reply-To: <1365993469-6874-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 14 Apr 2013 21:37:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E928831E-A577-11E2-9DE3-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221188>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Otherwise when using 'git branch -vv' it's hard to see them among so
> much output.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> This time with strbuf.
>
>  Documentation/config.txt |  3 ++-
>  builtin/branch.c         | 38 ++++++++++++++++++++++++++++++--------
>  2 files changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index bc750d5..302533f 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -794,7 +794,8 @@ color.branch::
>  color.branch.<slot>::
>  	Use customized color for branch coloration. `<slot>` is one of
>  	`current` (the current branch), `local` (a local branch),
> -	`remote` (a remote-tracking branch in refs/remotes/), `plain` (other
> +	`remote` (a remote-tracking branch in refs/remotes/),
> +	`upstream` (upstream tracking branch), `plain` (other
>  	refs).
>  +
>  The value for these configuration variables is a list of colors (at most
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 00d17d2..26e9322 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -40,13 +40,15 @@ static char branch_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_RED,		/* REMOTE */
>  	GIT_COLOR_NORMAL,	/* LOCAL */
>  	GIT_COLOR_GREEN,	/* CURRENT */
> +	GIT_COLOR_BLUE,		/* UPSTREAM */
>  };
>  enum color_branch {
>  	BRANCH_COLOR_RESET = 0,
>  	BRANCH_COLOR_PLAIN = 1,
>  	BRANCH_COLOR_REMOTE = 2,
>  	BRANCH_COLOR_LOCAL = 3,
> -	BRANCH_COLOR_CURRENT = 4
> +	BRANCH_COLOR_CURRENT = 4,
> +	BRANCH_COLOR_UPSTREAM = 5,
>  };

We had to fix these "trailing comma in enums" to help other peoples'
compilers a few times.  Yes, they happily take the trailing comma at
the end of array values above.  Don't complain to me ;-)

> @@ -417,36 +421,54 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
>  	int ours, theirs;
>  	char *ref = NULL;
>  	struct branch *branch = branch_get(branch_name);
> +	struct strbuf fancy;
> +
> +	strbuf_init(&fancy, 0);
>  
>  	if (!stat_tracking_info(branch, &ours, &theirs)) {
>  		if (branch && branch->merge && branch->merge[0]->dst &&
> -		    show_upstream_ref)
> -			strbuf_addf(stat, "[%s] ",
> -			    shorten_unambiguous_ref(branch->merge[0]->dst, 0));
> +		    show_upstream_ref) {
> +			ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
> +			if (want_color(branch_use_color))
> +				strbuf_addf(stat, "[%s%s%s] ",
> +						branch_get_color(BRANCH_COLOR_UPSTREAM),
> +						ref, branch_get_color(BRANCH_COLOR_RESET));
> +			else
> +				strbuf_addf(stat, "[%s] ", ref);
> +		}
>  		return;
>  	}
>  
> -	if (show_upstream_ref)
> +	if (show_upstream_ref) {
>  		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
> +		if (want_color(branch_use_color))
> +			strbuf_addf(&fancy, "%s%s%s",
> +					branch_get_color(BRANCH_COLOR_UPSTREAM),
> +					ref, branch_get_color(BRANCH_COLOR_RESET));
> +		else
> +			strbuf_addstr(&fancy, ref);
> +	}
> +
>  	if (!ours) {
>  		if (ref)
> -			strbuf_addf(stat, _("[%s: behind %d]"), ref, theirs);
> +			strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);
>  		else
>  			strbuf_addf(stat, _("[behind %d]"), theirs);
>  
>  	} else if (!theirs) {
>  		if (ref)
> -			strbuf_addf(stat, _("[%s: ahead %d]"), ref, ours);
> +			strbuf_addf(stat, _("[%s: ahead %d]"), fancy.buf, ours);
>  		else
>  			strbuf_addf(stat, _("[ahead %d]"), ours);
>  	} else {
>  		if (ref)
>  			strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
> -				    ref, ours, theirs);
> +				    fancy.buf, ours, theirs);
>  		else
>  			strbuf_addf(stat, _("[ahead %d, behind %d]"),
>  				    ours, theirs);
>  	}
> +	strbuf_release(&fancy);
>  	strbuf_addch(stat, ' ');
>  	free(ref);
>  }

Fairly straight-forward and looks good.
