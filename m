From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix git-completion.bash for use in zsh
Date: Wed, 21 Mar 2012 10:05:59 -0700
Message-ID: <7vaa393mvc.fsf@alter.siamese.dyndns.org>
References: <1332327960-5208-1-git-send-email-dev@randomguy3.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Alex Merry <dev@randomguy3.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 21 18:06:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAOzC-0003B2-5B
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 18:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab2CURGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 13:06:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754703Ab2CURGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 13:06:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1FB06BA7;
	Wed, 21 Mar 2012 13:06:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EpZ7XNsAuHYcOtTXv7slJgmOpWI=; b=u6hL3C
	uJ1qsi+6JhEiGC2vG8/LWpc53jImCQ4RY3oL0hIcswo+bgndFrB9ZMwt4BZhCbpZ
	TRiYDtKyTa9dyb7iTq4hsi+MX34NGEThZK3WirUAudpn/puEcwmsOwPiYbWmy7aB
	lX7rHJB7hm6rlX+OkMG/csHs+clia5yadSz0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BKOQzdQKJBOhHe1Fd/pJIGkMfYcnrnGq
	S8y0efY80rQTSUUNJGDNN2l2f5DCi3J3WwNazz8qvpxYBV+7cl88ajZvMW4ZAuG/
	w3O5l74+AJE6FaiwXvscIJMxFDezYN1KDCjksPnQB6SsXOWwTkiVT8Z188kP/MIt
	7b2PXDBFDPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88C116BA4;
	Wed, 21 Mar 2012 13:06:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCA656BA2; Wed, 21 Mar 2012
 13:06:00 -0400 (EDT)
In-Reply-To: <1332327960-5208-1-git-send-email-dev@randomguy3.me.uk> (Alex
 Merry's message of "Wed, 21 Mar 2012 11:06:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22606BD4-7378-11E1-BC07-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193588>

Alex Merry <dev@randomguy3.me.uk> writes:

> zsh treats
>   local some_var=()
> as a function declaration, rather than an array declaration (although
> its documentation does not suggest that this should be the case).
>
> With zsh 4.3.15 on Fedora Core 15, this causes
>   __git_ps1 " (%s)"
> to produce the message
>   local:2: command not found: svn_url_pattern
> when GIT_PS1_SHOWUPSTREAM="auto", due to the line
>   local svn_remote=() svn_url_pattern count n

Thanks, will queue.  Felipe, comments?

> Simply doing
>   local some_var
>   some_var=()
> fixes the issue.
>
> Signed-off-by: Alex Merry <dev@randomguy3.me.uk>
> ---
>
> Here it is again, with a better commit message, and no whitespace issues (hopefully).
>
>
>  contrib/completion/git-completion.bash |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0acbdda..092a34f 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -94,8 +94,9 @@ __gitdir ()
>  __git_ps1_show_upstream ()
>  {
>  	local key value
> -	local svn_remote=() svn_url_pattern count n
> +	local svn_remote svn_url_pattern count n
>  	local upstream=git legacy="" verbose=""
> +	svn_remote=()
>  
>  	# get some config options from git-config
>  	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
