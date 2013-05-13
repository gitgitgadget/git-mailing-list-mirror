From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] prompt: introduce GIT_PS1_STATESEPARATOR
Date: Mon, 13 May 2013 08:10:10 -0700
Message-ID: <7vli7ioqzx.fsf@alter.siamese.dyndns.org>
References: <1368452958-31090-1-git-send-email-artagnon@gmail.com>
	<1368452958-31090-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 17:10:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbuOL-0003XZ-0G
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 17:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab3EMPKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 11:10:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42515 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab3EMPKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 11:10:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70EAD1E3EE;
	Mon, 13 May 2013 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=42gV6/DoUQnsRgUGMg84UzPLtNE=; b=Zu3oc7
	JGpS7yTp+QhwosatgJTsYL2sRnYNWdM+82U3w8if31dN3RQNAIij5QYUOKWpQJQZ
	xEO/6jY0Cez+AsBQi+wm3mIGJkuZeGLR4d0zQTHi3kP3RnMqZqCF0BZlVl/r99yH
	nsoJIX9hg9J4G5Usl15LSjW0X3Icst/ZKSXME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Egn1aLQYJsx98Ib3WExbT0L3W17/NQKi
	pjF8+RVYpTD4XacTf/Wa4Uvyha63Rf9odDAga12SkLxpjoksLRGLTEP8fzH05O+c
	T+TsjjiaZL0zZatoiKsHBWa2XKk8p6YncS7krRtgtELZzsE+OFnMyt3Mi7OxWsb3
	BxsOXEP0jic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65E571E3EB;
	Mon, 13 May 2013 15:10:12 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C97D71E3EA;
	Mon, 13 May 2013 15:10:11 +0000 (UTC)
In-Reply-To: <1368452958-31090-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 13 May 2013 19:19:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35328606-BBDF-11E2-9AD5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224168>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> A typical prompt looks like:
>
>     artagnon|master *=:~/src/git$
>                    ^
>                    why do we have this space?
>
> Nobody has branch names that end with +, *, =, < or > anyway, so it
> doesn't serve the purpose of disambiguation.
>
> Make this separator configurable via GIT_PS1_STATESEPARATOR.  This means
> that you can set it to "" and get this prompt:
>
>     artagnon|master*=:~/src/git$
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index eaf5c36..5d8b745 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -359,6 +359,11 @@ __git_ps1 ()
>  			fi
>  		fi
>  
> +		local z=" "
> +		if [ -n "${GIT_PS1_STATESEPARATOR+set}" ]; then
> +			z="${GIT_PS1_STATESEPARATOR}"
> +		fi

It is simpler to use 'default values', no?

	local z=${GIT_PS1_STATESEPARATOR-" "}

> @@ -384,7 +389,7 @@ __git_ps1 ()
>  				gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
>  
>  				if [ -n "$w$i$s$u$r$p" ]; then
> -					gitstring="$gitstring "
> +					gitstring="$gitstring$z"

Perhaps not even a nit, but you do not have to concatenate when $z
is set to empty, so it may be worth doing

    if [ -n "$w$i$s$u$r$p" ] && [ -n "$z" ]; then
	gitstring="$gitstring$z"
    fi
