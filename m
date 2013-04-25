From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] bash-prompt.sh: Show where rebase is at when interrupted by a merge conflict
Date: Thu, 25 Apr 2013 10:05:12 -0700
Message-ID: <7vk3nq4k3b.fsf@alter.siamese.dyndns.org>
References: <1366882134-12026-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com, szeder@ira.uka.de
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 19:05:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVPbn-0007iJ-JD
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 19:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757511Ab3DYRFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 13:05:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756436Ab3DYRFP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 13:05:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDE9A17146;
	Thu, 25 Apr 2013 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L/Eh7WgrIKU/Y4EsYpus3u5tm3g=; b=FSiOlR
	3PkxfhJMvLIaJjJdKnU2V97P8eW5a36eWVKvmKWjL38sln+EdRTZep3l3GnYOnoX
	uRmsGkHnrGUzR6KwpdmOyPYSk7eQwkoX19FdJi/plQJ5Etu51RST3RX0ra5yar6Z
	ZH6N0NMn3EPxqFCcv9neV74ekKxd2ksVobIdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q8GGmY6YjGWfdqQCujjdmkdOxXPHITCw
	t03UEU4UXn937T9fz4exRCOSFVWLR6nmPK/HzUw/NZxjqTGEBDPnc0kOEWsany+E
	Z9CB2affuxmrG6rlSvrR6rguLCHAFOytXCKSlPAdrMAdYQuQdxGe3eP1iZMK7dQp
	gvnXkgYWIuk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3A7117145;
	Thu, 25 Apr 2013 17:05:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0864C17143;
	Thu, 25 Apr 2013 17:05:13 +0000 (UTC)
In-Reply-To: <1366882134-12026-1-git-send-email-zoltan.klinger@gmail.com>
	(Zoltan Klinger's message of "Thu, 25 Apr 2013 19:28:54 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BC0F614-ADCA-11E2-A806-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222396>

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

> When a rebase is interrupted by a merge conflict it could be useful to

The command also stops when told to stop with "amend", etc. no?  I
would phrase this way "When a rebase stops (e.g. interrupted ...),
it could be useful...".

> This information can be already obtained from the following files which are
> being generated during the rebase:
>     GIT_DIR/.git/rebase-merge/msgnum (git-rebase--merge.sh)
>     GIT_DIR/.git/rebase-merge/end    (git-rebase--merge.sh)
>     GIT_DIR/.git/rebase-apply/next   (git-am.sh)
>     GIT_DIR/.git/rebase-apply/last   (git-am.sh)

Here, I would add:

	But "git rebase -i" did not leave enough clues.

> 1) Modify git-rebase--interactive.sh to also create
>       GIT_DIR/.git/rebase-merge/msgnum
>       GIT_DIR/.git/rebase-merge/end
>    files for the number of commits so far applied and the total number of
>    commits to be applied.
> 2) Modify git-prompt.sh to read and display info from the above files

Missing full-stop at the end.

> 3) Update test t9903-bash-prompt.sh to reflect changes introduced by
>    this patch.
>
> Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
> ---

Thanks.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 048a140..f76ff8f 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -57,6 +57,9 @@ rewritten="$state_dir"/rewritten
>  
>  dropped="$state_dir"/dropped
>  
> +end="$state_dir"/end
> +msgnum="$state_dir"/msgnum
> +
>  # A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
>  # GIT_AUTHOR_DATE that will be used for the commit that is currently
>  # being rebased.
> @@ -109,7 +112,9 @@ mark_action_done () {
>  	sed -e 1d < "$todo" >> "$todo".new
>  	mv -f "$todo".new "$todo"
>  	new_count=$(git stripspace --strip-comments <"$done" | wc -l)
> +	echo $new_count > $msgnum
>  	total=$(($new_count + $(git stripspace --strip-comments <"$todo" | wc -l)))
> +	echo $total > $end

Write them like this:

	echo foo >"$variable"

Having no SP between redirection operator and redirection target is
merely a style thing [*1*].  Having an unnecessary dq around a
variable name that is used as redirection target is to work around a
bug in certain versions of bash that issues useless warnings.

I'll locally squeeze the above suggestions in and queue the result.
Please check what will appear on 'pu' by the end of day.

Thanks.


[Footnote]

*1* But a style request is not optional ;-)
