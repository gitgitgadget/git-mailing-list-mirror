From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] pull: trivial cleanup
Date: Fri, 30 Aug 2013 20:58:10 -0700
Message-ID: <xmqq38pqwlyl.fsf@gitster.dls.corp.google.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
	<1377899810-1818-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 05:58:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFcKS-0005eI-Ll
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 05:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab3HaD6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 23:58:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070Ab3HaD6O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 23:58:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5EA233D13;
	Sat, 31 Aug 2013 03:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P5gqwKotdClhWllHOX0foZNtZs8=; b=i1024q
	GTPik1l8juALfoU/XCbSlcD0dEVvVj1UfbZn41Rqu69qmyrmWsuqsawHuyh2F4lX
	0Ltg158NeM75alXVrFO6LKwoCAwWFqchbyz85C0sZJFZPapRk5wYJ5pemLGWTUxQ
	Dgs8DT3enkp3Lb4nrUUM/xD6mlZflGstcJ6IM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hXGhb1O2JOiLRJIaW6n3NoknrXa2II3J
	a/v6wlRprMSxse8Dr4f34Dv+tP8OFpS9EpzmZE1fJ1VF0rzKdmDsVlu+gn0nykMF
	jiVj32/HD1rKfsuQT2DWhZW5mF4zDeHPHyxW8AzEtdMInctKfzjO7EhJ6XKLBSo6
	LJ5JTWVWf/c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9F8233D12;
	Sat, 31 Aug 2013 03:58:13 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06ED933D10;
	Sat, 31 Aug 2013 03:58:12 +0000 (UTC)
In-Reply-To: <1377899810-1818-7-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 30 Aug 2013 16:56:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8EB6D20A-11F1-11E3-A62A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233498>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There's no need to remove 'refs/heads/' yet again.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-pull.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index f0df41c..3bdcbfd 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -166,7 +166,6 @@ error_on_no_merge_candidates () {
>  		op_prep=with
>  	fi
>  
> -	curr_branch=${curr_branch#refs/heads/}

The code assumes that at this point $curr_branch has the result of
git symbolic-ref -q HEAD it did at the beginning, before it entered
in the command line parsing loop.  But immediately after it, the
code sets up $curr_branch_short for the value this code computes.

>  	upstream=$(git config "branch.$curr_branch.merge")
>  	remote=$(git config "branch.$curr_branch.remote")

So it appears to me that the above two lines that are not updated
would introduce a regression.  Am I missing something trivial?

Puzzled.


> @@ -183,7 +182,7 @@ error_on_no_merge_candidates () {
>  		echo "You asked to pull from the remote '$1', but did not specify"
>  		echo "a branch. Because this is not the default configured remote"
>  		echo "for your current branch, you must specify a branch on the command line."
> -	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
> +	elif [ -z "$curr_branch_short" -o -z "$upstream" ]; then

If $curr_branch in the original code was (wasn't) an empty string,
then with the updated code that does not strip refs/heads/ from the
beginning of it after applying the first hunk of this patch, the
variable is (isn't) an empty string, respectively. So there is no
need for this hunk, I think.

>  		. git-parse-remote
>  		error_on_missing_default_upstream "pull" $op_type $op_prep \
>  			"git pull <remote> <branch>"
