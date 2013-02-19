From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/githooks: Explain pre-rebase parameters
Date: Tue, 19 Feb 2013 11:08:29 -0800
Message-ID: <7vk3q45dg2.fsf@alter.siamese.dyndns.org>
References: <c19c03f51d71a58fa3795f665fe4a4c0461fa58f.1361271116.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Feb 19 20:09:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7sYl-0004Kb-32
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 20:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934212Ab3BSTIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 14:08:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61746 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933446Ab3BSTIb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 14:08:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E732A629;
	Tue, 19 Feb 2013 14:08:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Niu1NTtEFFUbYBlrTO3Tfv/MTM8=; b=SO/133
	40/wCZlD0GEUmxOzg5Q/xvwoGKPwJAWAHjsmc8VEkG/FRw+4oqr0LieyvThRAvL3
	EqyZe6t06Z8z1C783wv4+auhd5aY+NYdaTjn3vzXK+wMhGd/WXMywI07gSK/TJgi
	NY8lCdFWIlCGzjNeAyh9a0slinvzuLTDUfV54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VOkxwxtqY2MbIenG+5J0qwTGWZ+Iu9k0
	PAUUmDMrMIglStxuIOi7jngbx3FwMPyKOrRpXDpR1H+FIObWTZE6DlUNT/6wYRga
	VZd5LpqpZx1MBvJZsLpVmjtp9Cb6+hL9eZ8kl3b9PCCUPIJbuU1qd8Amz7DesSB+
	34cfD0t0GHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 433B8A628;
	Tue, 19 Feb 2013 14:08:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABE97A625; Tue, 19 Feb 2013
 14:08:30 -0500 (EST)
In-Reply-To: <c19c03f51d71a58fa3795f665fe4a4c0461fa58f.1361271116.git.wking@tremily.us>
 (W. Trevor King's message of "Tue, 19 Feb 2013 06:03:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFA8BBF6-7AC7-11E2-A799-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216649>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> Descriptions borrowed from templates/hooks--pre-rebase.sample.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
> I'm not 100% convinced about this, because the git-rebase.sh uses:
>
>   "$GIT_DIR/hooks/pre-rebase" ${1+"$@"}
>
> I haven't been able to find documentation for the ${1+"$@"} syntax.
> Is it in POSIX?  It's not in the Bash manual:
>
>   $ man bash | grep '\${.*[+]'
>               (${BASH_SOURCE[$i+1]})  where  ${FUNCNAME[$i]}  was  called  (or
>               ${BASH_SOURCE[$i+1]}.
>               ${BASH_SOURCE[$i+1]}  at  line  number  ${BASH_LINENO[$i]}.  The
>        ${parameter:+word}
>
> In my local tests, it seems equivalent to "$@".
>
> Also, it appears that the `git-rebase--*.sh` handlers don't use the
> pre-rebase hook.  Is this intentional?

The codeflow of git-rebase front-end, when you start rebasing, will
call run_pre_rebase_hook before calling run_specific_rebase.  It
will be redundant for handlers to then call it again, no?

In "rebase --continue" and later steps, you would not want to see
the hook trigger.

>  Documentation/githooks.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index b9003fe..bc837c6 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -140,9 +140,10 @@ the outcome of 'git commit'.
>  pre-rebase
>  ~~~~~~~~~~
>  
> -This hook is called by 'git rebase' and can be used to prevent a branch
> -from getting rebased.
> -
> +This hook is called by 'git rebase' and can be used to prevent a
> +branch from getting rebased.  The hook takes two parameters: the
> +upstream the series was forked from and the branch being rebased.  The
> +second parameter will be empty when rebasing the current branch.

Technically this is incorrect.

We call it with one or two parameters, and sometimes the second
parameter is _missing_, which is different from calling with an
empty string.  For a script written in some scripting languages like
shell and perl, the distinction may not matter (i.e. $2 and $ARGV[1]
will be an empty string when stringified) but not all (accessing
sys.argv[2] may give you an IndexError in Python).
