From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] push: Provide situational hints for non-fast-forward
 errors
Date: Mon, 19 Mar 2012 11:58:02 -0700
Message-ID: <7vbonsbepx.fsf@alter.siamese.dyndns.org>
References: <20120319074944.GA18489@democracyinaction.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, zbyszek@in.waw.pl,
	Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com, drizzd@aon.at
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 19:58:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9hmX-0004m4-7n
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 19:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032495Ab2CSS6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 14:58:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032445Ab2CSS6G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 14:58:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB3187ACB;
	Mon, 19 Mar 2012 14:58:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xT5Xn+C+CCWINjNb+DueE9U5c40=; b=KPld0I
	mh+JlcIL+ZWMQAE+h0cIa3LnVDNSWCYwiVj0FpaLELMBHoT47yHv7G2OU0uXD6sN
	aJArhX3pnUSiuec7QrzAymVecwNtVo/uRnRpaPb5Ei8t0NcyNJNZG2h7Rgczphkz
	Ij5JwsAS9eFMHf7T0KCBTVYXYKxvWxbl0Z2eA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ckAOcKJ31koIKxlS0LGgYtTYY3os4PIq
	r6Jd3UEd2GFGgLF7jBJoFKpG7dn2Xu+s8jvYbY8J/N2Uk7DMDVkSgTdk36XEMMM3
	A+X7120726vL8TAJecbwZ2RNHHIcstbmpPl1dnxF0O5JxYSqfmuo5g7nzuDMukap
	4WqFuOujI9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C01057ACA;
	Mon, 19 Mar 2012 14:58:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FB977AC8; Mon, 19 Mar 2012
 14:58:04 -0400 (EDT)
In-Reply-To: <20120319074944.GA18489@democracyinaction.org> (Christopher
 Tiwald's message of "Mon, 19 Mar 2012 03:49:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7505F932-71F5-11E1-9A65-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193448>

Christopher Tiwald <christiwald@gmail.com> writes:

> Pushing a non-fast-forward update to a remote repository will result in
> an error, but the hint text doesn't provide the correct resolution in
> every case. Give better resolution advice in three push scenarios:
>
> 1) If you push a non-fast-forward update to your current branch, you
> should merge remote changes with 'git pull' before pushing again.

I have always found "update *to* your current branch" very strange
phrasing (the earlier one said "to HEAD", but it amounts to the same
thing).  You do not push *to* your branch.  You push your branch to
somewhere else (namely, remote).  I would understand if it said "If your
push of your current branch triggers a non-ff error, ...", though.

> 	  non-ff errors on other branches, but not current

I think the change in this patch comes from a realization that a blanket
"Here is all you need to know for any and all non-ff error cases" is not
very useful, and it feels like it is going backwards to squash the "non-ff
but not the current" into one category.

The user may have been using the matching default, gets the use-upstream
advice and realizes that she is trying to push branches other than what
she wanted to push, and may say "git push $there master" to push only that
branch out.  Then she thinks she learned enough to squelch the message in
$HOME/.gitconfig.

She may have another project with remote.$there.push set to push more than
one branches out (say, master and next), and while on 'master', may hit
another "non-ff on other" instance, because her 'next' was stale.

She never gets a chance to see the other checkout-pull-push message, does
she?

>  There is one aspect about this patch about which I'm unsure: What to
>  do with users who've set "advice.pushNonFastForward = false" already.

The change in this patch is merely clarifying what pushNonFastForward
advise has already taught them ("Non-ff was rejected; the manual will tell
you what you wanted to do") by dividing them into three categories and
giving different advices to these categories.  As the user says he
understood what he is doing, I think squelching all of them is a sane
choice.

> +static const char message_advice_pull_before_push[] =
> +	N_("Updates were rejected because the tip of your current branch is behind\n"
> +	   "its remote counterpart. Merge the remote changes (e.g. 'git pull')\n"
> +	   "before pushing again.\n"
> +	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
> +
> +static const char message_advice_use_upstream[] =
> +	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
> +	   "counterpart. If you did not intend to push that branch, you may want to\n"
> +	   "specify branches to push or set the 'push.default' configuration\n"
> +	   "variable to 'current' or 'upstream' to push only the current branch.");
> +
> +static const char message_advice_checkout_pull_push[] =
> +	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
> +	   "counterpart. Check out this branch and merge the remote changes\n"
> +	   "(e.g. 'git pull') before pushing again.\n"
> +	   "See the 'Note about fast-forwards' in 'git push --help' for details.");

In any case, the updated messages read much better than the current non-ff
one (or the previous round for that matter).
