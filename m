From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: add support for path completion
Date: Sun, 16 Dec 2012 20:50:30 -0800
Message-ID: <7vy5gxnuy1.fsf@alter.siamese.dyndns.org>
References: <1355693080-4765-1-git-send-email-manlio.perillo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 05:50:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkSfE-0006Yn-2g
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 05:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab2LQEue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 23:50:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47613 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab2LQEue (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 23:50:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1361EA439;
	Sun, 16 Dec 2012 23:50:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1geoAakfPmLZANPhiJpwAc9WikI=; b=aPaYfc
	59wP/59hAoL3s5V6W5cQ4yY/VHpM9mccVtwZXA88YN7blqL5tkk04Jd2Ax1o1tZi
	YY/whI86opDHz/nuWu4jXEnDHTyQLVB365cDrsFTHBGeFLlbi8UOhiQcEZ10Abiv
	7EgN2E7o8EL4pzmrLfe77Wv4W6c8yPr0BnPxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a81DtH/4UqKP91UYTDnLdpzvdM/RtLPf
	E5XiWqRPUpqws1FWawMBxcfvM6WKbJlVDNbjMjWC9vjEtBVbQyDAyeltURr2RHxa
	o9gxGsHOT1928/WcJrVjkAPF7Zx7URy9fOtZfCHXblAEscnh/g3E/qh2zimN/nP1
	5CB3WOvCYUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8065A437;
	Sun, 16 Dec 2012 23:50:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3E7EA42B; Sun, 16 Dec 2012
 23:50:31 -0500 (EST)
In-Reply-To: <1355693080-4765-1-git-send-email-manlio.perillo@gmail.com>
 (Manlio Perillo's message of "Sun, 16 Dec 2012 22:24:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 497B9DB2-4805-11E2-8B30-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211628>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> The git-completion.bash script did not implemented full support for
> completion, for git commands that operate on files from the current
> working directory or the index.
>
> For these commands, only options completion was available.

Hrm, "git mv CO<TAB>" completes it to "COPYING" for me.  Same for:

    git rm CO<TAB>
    git clean Doc<TAB>
    git commit --edit Doc<TAB>

There must be something missing from the above description, and the
claim the above two paragraphs make does no make sense without that
something that is missing.

> * the path completion for the "git mv" and "git rm" commands is provided
>   using "git ls-files --exclude-standard"

Does the above mean "git mv COPYING Doc<TAB>" would complete the
command line to move it to Documentation/ directory?  

I think "using X" is of secondary importance.  Reviewers and future
developers (who are reading "git log" output) can read it from the
patch.  What is expected in the log message is why the implemenation
was chosen, and in order to achieve what effect.

For example, something like:

    Each parameter between the first one and the one before the last
    one to 'git mv' is completed to a tracked path or a leading
    directory of a tracked path

should come first to explain what your patch wanted to do.  It of
course is helpful to explain how you implemented that behaviour, by
appending ", using 'ls-files --exclude-standard'" at the end.

> * the path completion for the "git add" command is provided using
>   "git ls-files --exclude-standard -o -m"

Likewise.  You are adding "either a modified, or a new and
unignored" and use "ls-files --exclude-standard -o -m" to achieve
it.

> * the path completion for the "git clean" command is provided using
>   "git ls-files --exclude-standard -o"
>
> * the path completion for the "git commit" command is provides using
>   "git diff-index --name-only HEAD"

As long as all of the above stops completion at directory boundary,
I think the above sounds like a sensible thing to do.  e.g. when
"ls-files" gives Documentation/Makefile and Documentation/git.txt,
"git cmd Doc<TAB>" first would give "git cmd Documentation/" and
then the second <TAB> would offer these two paths as choices.  That
way, the user can choose to just execute "git cmd Documentation/"
without even looking at these individual paths.

I am not sure how you would handle the last parameter to "git mv",
though.  That is by definition a path that does not exist,
i.e. cannot be completed.

> Signed-off-by: Manlio Perillo <manlio.perillo@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 39 ++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0b77eb1..8b348c3 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -233,6 +233,25 @@ __gitcomp_nl ()
>  	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
>  }
>  
> +__git_files ()
> +{
> +	local dir="$(__gitdir)"
> +	if [ -d "$dir" ]; then
> +		git --git-dir="$dir" ls-files --exclude-standard $*
> +		return
> +	fi
> +}
> +
> +# Return all staged files with modification from current HEAD
> +__git_commit_files ()
> +{
> +	local dir="$(__gitdir)"
> +	if [ -d "$dir" ]; then
> +		git --git-dir="$dir" diff-index --name-only HEAD
> +		return
> +	fi
> +}
> +
>  __git_heads ()
>  {
>  	local dir="$(__gitdir)"
> @@ -770,8 +789,6 @@ _git_apply ()
>  
>  _git_add ()
>  {
> -	__git_has_doubledash && return
> -
>  	case "$cur" in
>  	--*)
>  		__gitcomp "
> @@ -780,7 +797,8 @@ _git_add ()
>  			"
>  		return
>  	esac
> -	COMPREPLY=()
> +	# XXX should we care for --update and --all options ?
> +	__gitcomp_nl "$(__git_files -o -m)" "" "$cur" ""
>  }
>  
>  _git_archive ()
> @@ -930,15 +948,14 @@ _git_cherry_pick ()
>  
>  _git_clean ()
>  {
> -	__git_has_doubledash && return
> -
>  	case "$cur" in
>  	--*)
>  		__gitcomp "--dry-run --quiet"
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	# TODO: check for -x option
> +	__gitcomp_nl "$(__git_files -o)" "" "$cur" ""
>  }
>  
>  _git_clone ()
> @@ -969,8 +986,6 @@ _git_clone ()
>  
>  _git_commit ()
>  {
> -	__git_has_doubledash && return
> -
>  	case "$cur" in
>  	--cleanup=*)
>  		__gitcomp "default strip verbatim whitespace
> @@ -998,7 +1013,7 @@ _git_commit ()
>  			"
>  		return
>  	esac
> -	COMPREPLY=()
> +	__gitcomp_nl "$(__git_commit_files)" "" "$cur" ""
>  }
>  
>  _git_describe ()
> @@ -1362,7 +1377,7 @@ _git_mv ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__gitcomp_nl "$(__git_files)" "" "$cur" ""
>  }
>  
>  _git_name_rev ()
> @@ -2068,15 +2083,13 @@ _git_revert ()
>  
>  _git_rm ()
>  {
> -	__git_has_doubledash && return
> -
>  	case "$cur" in
>  	--*)
>  		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__gitcomp_nl "$(__git_files)" "" "$cur" ""
>  }
>  
>  _git_shortlog ()
