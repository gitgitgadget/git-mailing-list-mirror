From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 1/3] wt-status: Make conflict hint message more consistent with other hints
Date: Wed, 26 Feb 2014 12:37:03 -0800
Message-ID: <xmqqmwhd391s.fsf@gitster.dls.corp.google.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-2-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:37:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIlEC-00018Y-0s
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbaBZUhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 15:37:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbaBZUhI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 15:37:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA1EE6DB99;
	Wed, 26 Feb 2014 15:37:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o8wu86pqcj5jkC6/orBkaFsgIjQ=; b=vW5vQa
	8TXsh39ZJ2ffE9yaAWk+8IMHYelPifp8wkZTTCUDRYPtGGBAnKcQz5BY0qRjWXD0
	FnZwzZ/h9/lMiUO9e0cB5XLCSZj8NOerwCDEjYF0qTXD8zvnLKqP43cEkwGJiqoX
	C4ycCam0LtHyRZCTl5d6ZfwPOG5QPUn2fDoKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PgzfrIt+/qMNcWr7ypXztTbeJe+tk5tU
	CSiLzXkw1f/rjQl0iOAxlvf29DaIfmcMtmAmYt853rwb80HzvMOA4sgel7ssOrAe
	4Tv9ExUWrKaAhrAUNWKCJPMZmLi8Kqy/PYRW52dXAEVR4+EnGGidvdUa+RAvUovC
	Jgy8IcUU5xc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2C006DB98;
	Wed, 26 Feb 2014 15:37:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 013CE6DB95;
	Wed, 26 Feb 2014 15:37:05 -0500 (EST)
In-Reply-To: <1393437985-31401-2-git-send-email-andrew.kw.w@gmail.com> (Andrew
	Wong's message of "Wed, 26 Feb 2014 13:06:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C17E4E04-9F25-11E3-A87E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242763>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
> ---
>  wt-status.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 4e55810..6e1ad7d 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -899,7 +899,7 @@ static void show_merge_in_progress(struct wt_status *s,
>  		status_printf_ln(s, color, _("You have unmerged paths."));
>  		if (s->hints)
>  			status_printf_ln(s, color,
> -				_("  (fix conflicts and run \"git commit\")"));
> +				_("  (fix conflicts, and use \"git commit\" to conclude the merge)"));
>  	} else {
>  		status_printf_ln(s, color,
>  			_("All conflicts fixed but you are still merging."));

I see that you are trying to match the phrasing used in the other
side of this if/else (which is outside the context of the posted
patch).  Over there we say "... to conclude merge" while the new
text says "... to conclude THE merge".  Don't we want to match them?

For those who did not look beyond the context of the patch text, as
I had to look these up to convince myself that the proposed change
is a good one.  This function is only called when we see MERGE_HEAD,
so "unmerged" here can come only from a failed merge, not other
mergy operations like am, cherry-pick, revert, etc. and telling the
user that 'commit' will conclude the merge will not be misleading
(unless you count "'git commit' will conclude a conflicted 'git pull'"
as misleading, and I of course do not).
