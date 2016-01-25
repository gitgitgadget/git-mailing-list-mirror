From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix up the arguments for git stash.
Date: Mon, 25 Jan 2016 15:21:27 -0800
Message-ID: <xmqqio2hdz48.fsf@gitster.mtv.corp.google.com>
References: <20160123012316.GA27965@wagland.net>
	<20160123013049.GB28197@wagland.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Wagland <paul@kungfoocoder.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 00:21:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNqRy-0000Kk-4g
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 00:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbcAYXVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 18:21:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753387AbcAYXV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 18:21:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CA1B2403E8;
	Mon, 25 Jan 2016 18:21:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WvJqT30sfVmMIXDUeL82GlLGEr4=; b=d/+1Dq
	FY0ZsE+jCG0a0e7vxG5QUbLEL0MI6V4HZHUNvBobsOTMUD5LKlXhxQd72Ew3fXFP
	4Prv3oq+3AijgHsUdEWJhgUVHwmrsd36tD50eWsd/UTakM7fFn/+UUOQVsqKmyGu
	efQMyWb74mHqfzkxnGSvxsyklbzDU3kJ3bbyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A4sB23svRMCcizLojsCjR8n7VgNvS+cV
	FAyOo7naZuSdL7FSihb6lhPkI3iB7CWqwNOgB4XT/iTPNESy3Ge2N5km2I3h7Ou6
	BuPXhKUaS/jwXG/RtU8r16nvzjlaTTzkjrhzWo01/40M7Oi+6Cg/2GtDA37OeyYn
	wq0Oe9kbi28=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C097F403E7;
	Mon, 25 Jan 2016 18:21:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 32E52403E6;
	Mon, 25 Jan 2016 18:21:28 -0500 (EST)
In-Reply-To: <20160123013049.GB28197@wagland.net> (Paul Wagland's message of
	"Sat, 23 Jan 2016 02:30:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C298C74-C3BA-11E5-8F3D-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284768>

Paul Wagland <paul@kungfoocoder.org> writes:

> Signed-off-by: Paul Wagland <paul@kungfoocoder.org>
> ---

This needs a better explanation than just "Fix up" in the title.
What is broken in the current behaviour and what is the more desired
behaviour?

Thanks.

>  contrib/completion/git-completion.bash | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 63754bc..043d5bb 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2382,7 +2382,7 @@ _git_show_branch ()
>  
>  _git_stash ()
>  {
> -	local save_opts='--keep-index --no-keep-index --quiet --patch'
> +	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
>  	local subcommands='save list show apply clear drop pop create branch'
>  	local subcommand="$(__git_find_on_cmdline "$subcommands")"
>  	if [ -z "$subcommand" ]; then
> @@ -2404,9 +2404,20 @@ _git_stash ()
>  		apply,--*|pop,--*)
>  			__gitcomp "--index --quiet"
>  			;;
> -		show,--*|drop,--*|branch,--*)
> +		drop,--*)
> +			__gitcomp "--quiet"
>  			;;
> -		show,*|apply,*|drop,*|pop,*|branch,*)
> +		show,--*|branch,--*)
> +			;;
> +		branch,*)
> +			if [ $cword -eq 3 ]; then
> +			__gitcomp_nl "$(__git_refs)";
> +			else
> +				__gitcomp_nl "$(git --git-dir="$(__gitdir)" stash list \
> +						| sed -n -e 's/:.*//p')"
> +			fi
> +			;;
> +		show,*|apply,*|drop,*|pop,*)
>  			__gitcomp_nl "$(git --git-dir="$(__gitdir)" stash list \
>  					| sed -n -e 's/:.*//p')"
>  			;;
