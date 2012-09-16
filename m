From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] rebase -i: Teach "--edit-todo" action
Date: Sat, 15 Sep 2012 23:54:59 -0700
Message-ID: <7v1ui2zccc.fsf@alter.siamese.dyndns.org>
References: <CADgNjambUXj+WEFg=OWvtDQ1EKFhavwbjMbTVaP69rhh5DrphA@mail.gmail.com>
 <1347739709-15289-1-git-send-email-andrew.kw.w@gmail.com>
 <1347739709-15289-3-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 08:55:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD8lB-0000Ju-DX
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 08:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544Ab2IPGzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 02:55:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845Ab2IPGzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 02:55:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2CC46694;
	Sun, 16 Sep 2012 02:55:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1TZP5VI9rsB2jL5tSCnaxMFhvO0=; b=ShDqIS
	DsMkHUDR2BXpUhbvN61f9cnrteTb59rLKsEMGaDdptWLYQaK73lbYs7ZuXvswTsw
	zfJjQ6KgcfL65nrqj6FannJLgCdyPkaNjoX3oMIY7Q7nJtRpmzQvvbJgsBNUx4OZ
	V4Vi1WrWImIZW8ZDpeDwwEBI5ccH8srKjromA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F/QW8sQ/I5e9XX+UaXbIOMxxn+Pqi5tc
	RO+bi4htTo3zW3eSADcSNpq6hrIGhGg8Dc5pKb6loh5bwqvWLLtHRuRuUviuI7H2
	AvvMgZJDMvDGHl4iuqyI4oAWCpz32Hr2kDOlmGOszII0ZruNG/pxgBNmK99O++8R
	/Yfz/ZaeOFg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFE156693;
	Sun, 16 Sep 2012 02:55:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4742668E; Sun, 16 Sep 2012
 02:55:00 -0400 (EDT)
In-Reply-To: <1347739709-15289-3-git-send-email-andrew.kw.w@gmail.com>
 (Andrew Wong's message of "Sat, 15 Sep 2012 16:08:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F3BE82C-FFCB-11E1-8907-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205597>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> This allows users to edit the todo file while they're stopped in the
> middle of an interactive rebase. When this action is executed, all
> comments from the original todo file are stripped, and new help messages
> are appended to the end.
>
> Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
> ---
>  Documentation/git-rebase.txt |  5 ++++-
>  git-rebase--interactive.sh   | 16 ++++++++++++++++
>  git-rebase.sh                | 14 ++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index fd535b0..da067ec 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  	[<upstream>] [<branch>]
>  'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
>  	--root [<branch>]
> -'git rebase' --continue | --skip | --abort
> +'git rebase' --continue | --skip | --abort | --edit-todo
>  
>  DESCRIPTION
>  -----------
> @@ -245,6 +245,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>  --skip::
>  	Restart the rebasing process by skipping the current patch.
>  
> +--edit-todo::
> +	Edit the todo list during an interactive rebase.
> +
>  -m::
>  --merge::
>  	Use merging strategies to rebase.  When the recursive (default) merge
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 4d57e50..ca55fac 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -792,6 +792,22 @@ skip)
>  
>  	do_rest
>  	;;
> +edit-todo)
> +	sed -i '/^#/d' "$todo"
> +	append_todo_help

I do not think the "sed -i" in-place edit is portable.  AFAIK, it is
not even in POSIX.1

In any case, what information are you discarding and then replacing
with the standard boilerplate?

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 15da926..e660203 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -38,6 +38,7 @@ C=!                passed to 'git apply'
>  continue!          continue
>  abort!             abort and check out the original branch
>  skip!              skip current patch and continue
> +edit-todo!         edit the todo list during an interactive rebase
>  "
>  . git-sh-setup
>  . git-sh-i18n
> @@ -194,6 +195,10 @@ do
>  		test $total_argc -eq 2 || usage
>  		action=${1##--}
>  		;;
> +	--edit-todo)
> +		test $total_argc -eq 2 || usage
> +		action=${1##--}
> +		;;
>  	--onto)
>  		test 2 -le "$#" || usage
>  		onto="$2"
> @@ -306,6 +311,12 @@ then
>  	fi
>  fi
>  
> +if test "$action" = "edit-todo" &&
> +	test "$type" != "interactive"

I do not see a need to split this short expression into two lines.
