From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-request-pull: add --stat option
Date: Thu, 24 Apr 2014 10:46:25 -0700
Message-ID: <xmqqbnvqwrgu.fsf@gitster.dls.corp.google.com>
References: <1398331763-601-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
X-From: git-owner@vger.kernel.org Thu Apr 24 19:46:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdNjI-0001gm-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 19:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758136AbaDXRqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 13:46:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbaDXRqa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 13:46:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E2087F3B9;
	Thu, 24 Apr 2014 13:46:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nVrjD9YjgZmeCR+KWn3zqY3PSOU=; b=NL1jSO
	MBTDc89r0O2/6FOJ7d2gat3Jyn+ca33DkXaeUbxvL+gU5/fztnwjmOmGFm8kpJiZ
	ghOZxBC84dH3apfoffQv+JUkRi3LJM2F+EuD9PmXPUMmPvAmC0GdvaMPv/VdXTPp
	z+/m7+n/893ajuu4VSeWQ6kuYpu5+KPACeEts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JQKOeuQ+xAbgwGkyU9z97xjGQkU0UkOT
	kSWl+hMUmHgl5YK3u6mr2bKHVb6XqP+2qHYYAFqofh+XI8gq/60K+An5+0WVt0SQ
	WrRsvVVg4z8qyGYSOURj2n4mgiFi/vg6JtAInlgErwi5P/O/Z8ysMsQz7apXGSIU
	lLID+U8XVXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8D4C7F3B8;
	Thu, 24 Apr 2014 13:46:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12EF87F3A7;
	Thu, 24 Apr 2014 13:46:27 -0400 (EDT)
In-Reply-To: <1398331763-601-1-git-send-email-jslaby@suse.cz> (Jiri Slaby's
	message of "Thu, 24 Apr 2014 11:29:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5CC4D318-CBD8-11E3-B588-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246981>

Jiri Slaby <jslaby@suse.cz> writes:

> Which is passed on to git diff. I very need this option instead of
> changing the terminal size.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---

Interesting.  I wonder if that suggests perhaps the default may be
better if it were --stat=80 regardless of your terminal width.

Oh, wait.  That is the default we use when the output is not
connected to the terminal.

Initially, I thought that the motivation behind this is that you got
complaint from the recipient of your request that was generated to
fit the width of _your_ taste (which is a lot wider than the
standard 80) because you run the command in a wide terminal.  But
that does not sound like it, as sending out a request would go more
like:

    $ git request-pull ... >request.txt
    $ edit request.txt
    $ mua send request.txt

and you would be getting 80-column output in that workflow.

What are you using the output of the script for, and why do you
"very need this instead of changing the terminal size"?

I am puzzled.

Perhaps is it the case that "--stat" output with full width of the
terminal does *not* suit _your_ taste (not just the recipient's),
and that is not limited to the request-pull output, but shared
across "log -p --stat", "diff --stat", and friends?  I wonder if it
would be a better solution for you and those in the same situation
to set diff.statgraphwidth or something so that all these output are
limited to a reasonable width, if that is the case?

Perhaps that diff.statgraphwidth that only specifies the graph part
is too unwieldy and having a diff.statwidth or something that allows
you to customize that "80 or terminal width" in a more direct way is
needed?

Regardless, having a way to pass thru an option, like this patch
does, is independently a good thing, I would tend to think.  But "I
need it instead of changing the terminal size" does not look like a
sufficient and readable justification that describes why.

>  git-request-pull.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index 5c1599752314..a23f03fddec0 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -13,6 +13,7 @@ OPTIONS_STUCKLONG=
>  OPTIONS_SPEC='git request-pull [options] start url [end]
>  --
>  p    show patch text as well
> +stat= specify stat output (see man git-diff for details)
>  '
>  
>  . git-sh-setup
> @@ -21,11 +22,16 @@ GIT_PAGER=
>  export GIT_PAGER
>  
>  patch=
> +stat=--stat
>  while	case "$#" in 0) break ;; esac
>  do
>  	case "$1" in
>  	-p)
>  		patch=-p ;;
> +	--stat)
> +		stat="$1=$2"
> +		shift
> +		;;

If somebody did not want to give diffstat output for whatever
reason, wouldn't it be natural to want to say

	request-pull --stat= ...other options...

rather than having to say it with an explicit empty string, i.e.


	request-pull --stat "" ...other options...

In other words, I think the patch should also add

	--stat=*)
        	stat="$1"
		;;

>  	--)
>  		shift; break ;;
>  	-*)
> @@ -152,6 +158,6 @@ then
>  fi &&
>  
>  git shortlog ^$baserev $headrev &&
> -git diff -M --stat --summary $patch $merge_base..$headrev || status=1
> +git diff -M $stat --summary $patch $merge_base..$headrev || status=1

This would not let the command notice a user error on the command
line of request-pull, e.g.

	request-pull --stat='30 bar baz' ...other options...

because it will end up passing "--stat=30", "bar" and "baz" as
separate options to it, no?

	diff -M ${stat+="$stat"} ...

perhaps?

>  
>  exit $status
