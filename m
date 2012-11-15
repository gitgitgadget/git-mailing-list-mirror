From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: add advice on how to push/pull to tracking
 branch
Date: Thu, 15 Nov 2012 09:53:41 -0800
Message-ID: <7vr4nu92hm.fsf@alter.siamese.dyndns.org>
References: <1352976300-20159-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Nov 15 18:54:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ3dX-0004Xp-2U
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 18:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768598Ab2KORxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 12:53:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768574Ab2KORxo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 12:53:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 889639A00;
	Thu, 15 Nov 2012 12:53:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gl6gwmrnqRy4nM9aR05NFxEjckQ=; b=VJ0Gy+
	QbEY/G2Y8H4QJ2UHMaCDjJdcb27ki6+v4VJ2y2nOBJ/NBvwAq/Ys6THeoXh6Txjr
	amHdjtlTNTGGoflgvZ7itfAX59rtpBb9UMNWa+fzI3tUxYy+rZugNu3jN3eIMuF3
	3xyfnR4DF1by7FM+xhZgglebgmgsuvMbffb6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U7v9XFavNypwDwyyfGHxX/CrnVgD8q7y
	mh3l7xLIFFHaFZt6P/gAQBdTdWSJPHumbcWlANmuCdYRruY1yVAgRIPgSo9lFvfd
	GNN8PKPIXhUA02s9H85vuZ9iSMT2BNqXS6pCUdiY3qYKz+0xA8DwnVa8THSpErt7
	/pv2zosPW5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 751C399FF;
	Thu, 15 Nov 2012 12:53:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBBA499FC; Thu, 15 Nov 2012
 12:53:42 -0500 (EST)
In-Reply-To: <1352976300-20159-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Thu, 15 Nov 2012 11:45:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 650617A4-2F4D-11E2-9B33-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209835>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> I thought this was obvious enough not to deserve an advice, but a
> colleague of mine had troubles with "commited but not pushed" changes.
> Maybe an additional advice would have helped. After all, it's an
> advice, and can be deactivated ...
>
>  remote.c                   | 13 ++++++++++---
>  t/t2020-checkout-detach.sh |  1 +
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 04fd9ea..9c19689 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1627,13 +1627,15 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
>  
>  	base = branch->merge[0]->dst;
>  	base = shorten_unambiguous_ref(base, 0);
> -	if (!num_theirs)
> +	if (!num_theirs) {
>  		strbuf_addf(sb,
>  			Q_("Your branch is ahead of '%s' by %d commit.\n",
>  			   "Your branch is ahead of '%s' by %d commits.\n",
>  			   num_ours),
>  			base, num_ours);
> -	else if (!num_ours)
> +		strbuf_addf(sb,
> +			_("  (use \"git push\" to publish your local commits)\n"));
> +	} else if (!num_ours) {

The message should make it clear that the two words in double quotes
only hint what command is used to "publish your local commits" and
not to be taken as literal "here is what you exactly would type",
but I do not think that is what I would get from this if I were a
total newbie who would need this advise.

It is even more true given that this is showing an arbitrary, and
more likely than not a non-current branch, especially with the
recent move from "matching" to "simple" where a naive use of "git
push" is to push the branch that is currently checked out and no
other branches.

	see 'git push --help' to learn how to publish your local commits

might be more appropriate.

> +		strbuf_addf(sb,
> +			_("  (use \"git pull\" to update your local branch)\n"));
> +	} else {

Likewise, and the non-currentness of the branch being described is
even worse in here, as unlike "git push" that can still be used to
push a non-current branch, "git pull" is never to be used to update
local branch that is not current, which means the advice must mention
"git checkout" somewhere.
