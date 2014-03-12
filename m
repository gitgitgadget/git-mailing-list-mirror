From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: add verbose mode for add/update
Date: Wed, 12 Mar 2014 13:19:59 -0700
Message-ID: <xmqqwqfzjhjk.fsf@gitster.dls.corp.google.com>
References: <1394654625-4586-1-git-send-email-orgads@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:20:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpdW-0005Gj-7S
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbaCLUUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 16:20:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbaCLUUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:20:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F757740FC;
	Wed, 12 Mar 2014 16:20:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qVLK0joHfW3UxGyV+lD4L83PkuI=; b=THvmGN
	YR8/WIBbIAY6G12drptjTg9evnD7hIxapqlljB3Ntyajg9ODqT726cWWV8U14sXl
	qc4UlQVVx8/+fuorPuv24fCDlKxx3y1KLnZhkO6JQjgOwQKb8dQhoVSW97Z7F/Tm
	dr6QWudJKTBbXKZScTZvMLtH+QmvAxYTlyGV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jv2VU7dImGr2v7V7qoCVci2O4th/T6FE
	wwyTQFhXr9sCP1WNvJkCsZxX8MK08U5fY8DTJK7+0835AluavY7X3eTwsk13pWMb
	XC1uCWnpFozLuBNXGnAgLMLYj4GzwnMCqfDTe3RotlL9+ULBY3ML+3UrQ+g7fekH
	uc5bXhEBo8g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A0D9740FB;
	Wed, 12 Mar 2014 16:20:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46636740E6;
	Wed, 12 Mar 2014 16:20:01 -0400 (EDT)
In-Reply-To: <1394654625-4586-1-git-send-email-orgads@gmail.com> (Orgad
	Shaneh's message of "Wed, 12 Mar 2014 22:03:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B07FCD72-AA23-11E3-AA67-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243985>

Orgad Shaneh <orgads@gmail.com> writes:

> +--verbose::
> +	This option is valid for add and update commands. Display the progress
> +	of the actual submodule	checkout.

Hmm, is the "valid for add and update" part we want to keep?  I do
not think it is a crime if some other subcommand accepted --verbose
option but its output under verbose mode and normal mode happened to
be the same.

I doubt it would take a lot of imagination to see that people would
want to see "git submodule status --verbose" to get richer output,
and at that point, "progress of checkout" as part of the description
of the "--verbose" option does not make any sense.  Perhaps the
second part that is specific to "add" and "update" subcommands
should move to the description of these two subcommands?

I dunno.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index a33f68d..e1df2c8 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -5,11 +5,11 @@
>  # Copyright (c) 2007 Lars Hjemli
>  
>  dashless=$(basename "$0" | sed -e 's/-/ /')
> -USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
> +USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [-v|--verbose] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
>     or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
> -   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
> +   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [-v|--verbose] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
>     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
> @@ -319,12 +319,16 @@ module_clone()
>  	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
>  	(
>  		clear_local_git_env
> +		if test -z "$verbose"
> +		then
> +			subquiet=-q
> +		fi
>  		cd "$sm_path" &&
>  		GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
>  		# ash fails to wordsplit ${local_branch:+-B "$local_branch"...}
>  		case "$local_branch" in
> -		'') git checkout -f -q ${start_point:+"$start_point"} ;;
> -		?*) git checkout -f -q -B "$local_branch" ${start_point:+"$start_point"} ;;
> +		'') git checkout -f ${subquiet:+"$subquiet"} ${start_point:+"$start_point"} ;;
> +		?*) git checkout -f ${subquiet:+"$subquiet"} -B "$local_branch" ${start_point:+"$start_point"} ;;
>  		esac
>  	) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
>  }
> @@ -380,6 +384,9 @@ cmd_add()
>  		--depth=*)
>  			depth=$1
>  			;;
> +		-v|--verbose)
> +			verbose=1
> +			;;

Compare $depth and $verbose, and think what would happen if the end
user had an environment variable whose name happened to be $depth or
$verbose.  Does this script misbehave under such a stray $verbose?
What does the existing script do to prevent it from misbehaving when
a stray $depth exists in the environment?
