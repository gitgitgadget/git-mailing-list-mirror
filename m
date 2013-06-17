From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wt-status: give better advice when cherry-pick is in progress
Date: Mon, 17 Jun 2013 12:18:33 -0700
Message-ID: <7vppvkczqu.fsf@alter.siamese.dyndns.org>
References: <1371443306-3073-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lucien.Kong@ensimag.imag.fr
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 21:18:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoewr-0008Q3-QV
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 21:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536Ab3FQTSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 15:18:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48245 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab3FQTSg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 15:18:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7F1928A03;
	Mon, 17 Jun 2013 19:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oBMXSnmkvc/SitLhmN6sKgXji0E=; b=QVeh2e
	Vy9fRH9LsteN/taojgKLSnD1VvGR9ybCmHBXADzpZAhmzBF2LgZ9Ey2tVln4QmH3
	2ncJuAWaPziOoDmdYRN493GL3AnPYfqHBb0p6qAFodrD++H6QU6kaM9brZLQKMIN
	/iDATbA1gidOpGqfQWntpiB4y+i0pq6FKNDwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CLtsO//UwQEHjYzKGnunbxnelWF/nNAk
	uzZVY1RGbVzeKRPF9pGNDl0zmrcopGHsfaC48U2BGrkcRx38BIrGUdcYyWffjpoL
	h0gVw0iv8Qb6w1OmdDa+XFDpsRy+uJ7PeSqhya9lQu+rt1c4XxmMqmkvginAxQt9
	pfrmmN0tHBo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA49228A02;
	Mon, 17 Jun 2013 19:18:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EF0828A01;
	Mon, 17 Jun 2013 19:18:35 +0000 (UTC)
In-Reply-To: <1371443306-3073-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Mon, 17 Jun 2013 06:28:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4B50976-D782-11E2-AE09-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228100>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> When cherry-pick is in progress, 'git status' gives the advice to
> run "git commit" to finish the cherry-pick. However, this won't continue
> the sequencer.
> "git status" should give the advice of running "git cherry-pick --continue"
> or "git cherry-pick --abort".

Is the above _always_ the case, or does the updated advice message
only apply when you are cherry-picking a range of commits with "git
cherry-pick A..B"?  In other words, when "git cherry-pick $it" (a
single commit) stops, waiting for your help to resolve it, would
"git cherry-pick --continue" conclude it?

If that works then this definitely is a good change (the user only
needs to know "cherry-pick --continue").

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  t/t7512-status-help.sh | 6 ++++--
>  wt-status.c            | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index bf08d4e..4f09bec 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -632,7 +632,8 @@ test_expect_success 'status when cherry-picking before resolving conflicts' '
>  	cat >expected <<-\EOF &&
>  	# On branch cherry_branch
>  	# You are currently cherry-picking.
> -	#   (fix conflicts and run "git commit")
> +	#   (fix conflicts and run "git cherry-pick --continue")
> +	#   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
>  	#
>  	# Unmerged paths:
>  	#   (use "git add <file>..." to mark resolution)
> @@ -655,7 +656,8 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
>  	cat >expected <<-\EOF &&
>  	# On branch cherry_branch
>  	# You are currently cherry-picking.
> -	#   (all conflicts fixed: run "git commit")
> +	#   (all conflicts fixed: run "git cherry-pick --continue")
> +	#   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
>  	#
>  	# Changes to be committed:
>  	#
> diff --git a/wt-status.c b/wt-status.c
> index bf84a86..438a40d 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -955,10 +955,12 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
>  	if (advice_status_hints) {
>  		if (has_unmerged(s))
>  			status_printf_ln(s, color,
> -				_("  (fix conflicts and run \"git commit\")"));
> +				_("  (fix conflicts and run \"git cherry-pick --continue\")"));
>  		else
>  			status_printf_ln(s, color,
> -				_("  (all conflicts fixed: run \"git commit\")"));
> +				_("  (all conflicts fixed: run \"git cherry-pick --continue\")"));
> +		status_printf_ln(s, color,
> +			_("  (use \"git cherry-pick --abort\" to cancel the cherry-pick operation)"));
>  	}
>  	wt_status_print_trailer(s);
>  }
