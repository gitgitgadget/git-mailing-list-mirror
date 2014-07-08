From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC v2 01/19] rebase -i: Failed reword prints redundant error message
Date: Tue, 08 Jul 2014 13:31:13 -0700
Message-ID: <xmqqtx6r8uem.fsf@gitster.dls.corp.google.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<10d7fae199e4d8adec537aa377177de652badc07.1404323078.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 22:31:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4c30-0007i9-MC
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 22:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbaGHUb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 16:31:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60684 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbaGHUb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 16:31:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FE402637E;
	Tue,  8 Jul 2014 16:31:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MvM8jBEZVEBnR7Z0J0JJDHW/K/Y=; b=FLR2jq
	Wb9i4i2OFp87r9+uYPCzdkEg1//3fRnJPt+vACgDx/2s6WvQVSjR5oOUclEz0GWF
	nLm5EHHC0Wu6tdPIOvwXq+eSyxTpfnvwh5ldDmnb6nMziO9FQz5YJvYzNWJyudw7
	wmhP2HgHBKCuO6LcJR6nxhEmaafRlJiuyl/fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UChLm2jLM6UpC0SpYYHIN1cWCHs9X9rh
	XQXiu7qT79XJ4psmjo2+WaPgvgbMD6hMNlk8fDOodF6LODaOc0w72Rsn23JBZ/hT
	HMXu5HRxihZHL8lLaNHgdiUS6rVWVf/f9XX760gwDON4P7A1zqlRxndBJYSd3rAL
	7NzuwUSrFwY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BEC92637C;
	Tue,  8 Jul 2014 16:31:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6DD6626376;
	Tue,  8 Jul 2014 16:30:59 -0400 (EDT)
In-Reply-To: <10d7fae199e4d8adec537aa377177de652badc07.1404323078.git.bafain@gmail.com>
	(Fabian Ruch's message of "Wed, 2 Jul 2014 19:47:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5931CF6-06DE-11E4-BAA0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253044>

Fabian Ruch <bafain@gmail.com> writes:

> The to-do list command `reword` replays a commit like `pick` but lets
> the user also edit the commit's log message. If the edited log
> message is empty or is found ill-formatted by one of the commit
> hooks, git-rebase--interactive prints three error messages to the
> console.
>
>     1. The git-commit output, which contains all the output from hook
>        scripts.
>     2. A rebase diagnosis saying at which task on the to-do list it
>        got stuck.
>     3. Generic presumptions about what could have triggered the
>        error.
>
> The third message contains redundant information and does not add any
> enlightenment either, which makes the output unnecessarily longish
> and different from the other command's output. For instance, this is
> what the output looks like if the log message is empty (contains
> duplicate Signed-off-by lines).
>
>     (1.) Aborting commit due to empty commit message. (Duplicate Signed-off-by lines.)
>     (2.) Could not amend commit after successfully picking fa1afe1... Some change
>     (3.) This is most likely due to an empty commit message, or the pre-commit hook
>          failed. If the pre-commit hook failed, you may need to resolve the issue before
>          you are able to reword the commit.
>
> Discard the third message.
>
> It is true that a failed hook script might not output any diagnosis...

I think the message originally came from 0becb3e4 (rebase -i:
interrupt rebase when "commit --amend" failed during "reword",
2011-11-30); it seems that the primary point of the change was to
make sure it exits and the warning message may not have been well
thought out, but before discarding the result of somebody else's
work, it may not be a bad idea to ask just in case you may have
overlooked something (Andrew Wong Cc'ed).





> but then the generic message is not of much help either. Since this
> lack of information affects the built-in git commands for commit,
> merge and cherry-pick first, the solution would be to keep track of
> the failed hooks in their output so that the user knows which of her
> hooks require improvement.
>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  git-rebase--interactive.sh | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 7e1eda0..e733d7f 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -506,9 +506,6 @@ do_next () {
>  		do_pick $sha1 "$rest"
>  		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
>  			warn "Could not amend commit after successfully picking $sha1... $rest"
> -			warn "This is most likely due to an empty commit message, or the pre-commit hook"
> -			warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
> -			warn "you are able to reword the commit."
>  			exit_with_patch $sha1 1
>  		}
>  		record_in_rewritten $sha1
