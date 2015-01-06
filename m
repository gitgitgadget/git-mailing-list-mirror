From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-prompt.sh: Option to hide prompt for ignored pwd
Date: Tue, 06 Jan 2015 15:31:10 -0800
Message-ID: <xmqqwq4zmqpt.fsf@gitster.dls.corp.google.com>
References: <543ED906.403@bbn.com>
	<1420441418-12511-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j6t@kdbg.org, jess.austin@gmail.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 00:32:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8daq-0006qI-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 00:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbAFXbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 18:31:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751070AbbAFXbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 18:31:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09BA92D85C;
	Tue,  6 Jan 2015 18:31:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NgYyjuJnlBSpjEsW5UW0SNWuVGw=; b=QD5931
	FfF5qW6IPlTych+SHAYBZ/UhTV6tcn5Mxti8baKnO5U7fYcWeBBMar7pl4BrEByb
	zLlwo4Wgifg0OglEritcSXP4SIw0/16GpCEqNJ0CLp0EkG+BKgt+yyApCGf1RxEL
	eHLVdav9To9ZtsRPVwoIkhxANxXAwrv3xIZK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nSqX0mQf07ynu4G8ojFz+NB0WVhjloen
	Y2Ek8RvxB8v+yGzU1moYFEdX26lthlr0HCQn1tGqMoSpvwPSngeLvsbwK1Mwtvs5
	+zHK4Nn3umSCkP6/3El6IQ0c3s5XT0qwix4rBAKv6LV6LdO40qXClyBABQv072g5
	02nuQWJg/A4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 008B62D85B;
	Tue,  6 Jan 2015 18:31:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B8322D85A;
	Tue,  6 Jan 2015 18:31:11 -0500 (EST)
In-Reply-To: <1420441418-12511-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Mon, 5 Jan 2015 02:03:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1934EE14-95FC-11E4-A6B9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262112>

Richard Hansen <rhansen@bbn.com> writes:

> This is the patch from:
>
>   http://article.gmane.org/gmane.comp.version-control.git/258313
>
> modified to include the changes I suggested in:
>
>   http://article.gmane.org/gmane.comp.version-control.git/258355
>
> I never heard back regarding my suggested changes.  The feature was so
> close to ready and I thought it would be a shame for the feature to
> silently die, so I'm submitting a re-roll with my suggested changes on
> behalf of the original author.

> +# If you would like __git_ps1 to do nothing in the case when the current
> +# directory is set up to be ignored by git, then set
> +# GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
> +# repository level by setting bash.hideIfPwdIgnored to "false".

Perhaps nobody had much interest in the original or the update.
Occassionally resending with improvements like this is a good way to
show it to more people who may have missed it the last time to
solicit comments and supports.

I am personally not very interested, as you and the original made it
sound as if this is primarily for those who keep track of $HOME/.dot
files in $HOME/.git, which is one of the ways I would never use Git.

But I do not have to be the target of each and every new feature ;-).

>  # check whether printf supports -v
>  __git_printf_supports_v=
> @@ -369,6 +374,17 @@ __git_ps1 ()
>  	local inside_gitdir="${repo_info##*$'\n'}"
>  	local g="${repo_info%$'\n'*}"
>  
> +	if [ "true" = "$inside_worktree" ] &&
> +	   [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED}" ] &&

Many existing checks on variables are written this way with the
"subsitutute with default value" syntax

        if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&

to make sure that people with non-standard settings to report
references to unset variables as errors will not have to suffer.
Don't you need to do something similar here?

> +	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
> +	   git check-ignore -q .
> +	then
> +		if [ $pcmode = yes ]; then
> +			PS1="$ps1pc_start$ps1pc_end"
> +		fi
> +		return

There are already two places where "under pcmode, we need to set PS1
to this empty thing" is known, and this patch adds yet another.
Would it be sensible to refactor that into a helper function, or
open coding them this way is necessary for performance or some other
reasons?

> +	fi
> +
>  	local r=""
>  	local b=""
>  	local step=""
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 9150984..37953c8 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -35,6 +35,8 @@ test_expect_success 'setup for prompt tests' '
>  	git commit -m "another b2" file &&
>  	echo 000 >file &&
>  	git commit -m "yet another b2" file &&
> +	mkdir ignored_dir &&
> +	echo "ignored_dir/" >> .gitignore &&

Drop the SP after (but not before) redirection operator >>.
