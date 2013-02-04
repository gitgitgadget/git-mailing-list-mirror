From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] submodule: add 'deinit' command
Date: Mon, 04 Feb 2013 12:55:25 -0800
Message-ID: <7vlib32402.fsf@alter.siamese.dyndns.org>
References: <5110157A.2040402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Phil Hord <phil.hord@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 21:55:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2T4z-0008Qs-8l
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 21:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab3BDUza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 15:55:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753983Ab3BDUza (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 15:55:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36EE7B1D3;
	Mon,  4 Feb 2013 15:55:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pt2Kjj0+0xLmqwWcX1G/tSLroIQ=; b=R83ojw
	yrsIUBvlyAcFI76Bntm/ln8bNkJBCZnN2Duc3zzAPXgTZveXC147ExNsV6NoOKFo
	YbpNbLjqkmTOBTTYlCkrfaomxIN8ZloCXHSQCR8RC2u5SndrY2PdXbJPotRG2b6r
	EyZwi51JTbwrAtSAJTjCUXtXlGxE0MGrkHGYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kXoNbXr/MYsRZboWlBWgX/Mgq+eSXWSB
	G/885skgknlYdRhechJyW4hDIZ/ddJZed47LOtTDRbIkKOHUA7mgfCKNp1hZY3kB
	Rj7TydaLQjpqXDBWd2ackRav6FfTnYSXwZInkl9FFw8XLNU8g53JPKwgTUf5IgvE
	0YnqA3IQ/R8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AF49B1D1;
	Mon,  4 Feb 2013 15:55:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E791B1CE; Mon,  4 Feb 2013
 15:55:28 -0500 (EST)
In-Reply-To: <5110157A.2040402@web.de> (Jens Lehmann's message of "Mon, 04
 Feb 2013 21:09:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34AD1012-6F0D-11E2-B4F4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215418>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> With "git submodule init" the user is able to tell git he cares about one
> or more submodules and wants to have it populated on the next call to "git
> submodule update". But currently there is no easy way he could tell git he
> does not care about a submodule anymore and wants to get rid of his local
> work tree (except he knows a lot about submodule internals and removes the
> "submodule.$name.url" setting from .git/config together with the work tree
> himself).
>
> Help those users by providing a 'deinit' command. This removes the whole
> submodule.<name> section from .git/config either for the given
> submodule(s) (or for all those which have been initialized if '.' is
> given). Fail if the current work tree contains modifications unless
> forced. Complain when for a submodule given on the command line the url
> setting can't be found in .git/config, but nonetheless don't fail.
>
> Add tests and link the man pages of "git submodule deinit" and "git rm"
> to assist the user in deciding whether removing or unregistering the
> submodule is the right thing to do for him.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> Ok, here is the reroll following the discussion in $gmane/212884.
>
> Changes since v2 are:
> - deinit always needs an argument; if the user wants to deinit all initialized
>   submodules he can use "." (and we tell him that when failing without any
>   arguments).
> - We also remove the work tree of the submodule. When it contains local changes
>   (tested with "git rm -n") this fails unless forced.
>
>
>  Documentation/git-rm.txt        |  4 +++
>  Documentation/git-submodule.txt | 18 ++++++++++-
>  git-submodule.sh                | 70 ++++++++++++++++++++++++++++++++++++++++-
>  t/t7400-submodule-basic.sh      | 24 ++++++++++++++
>  4 files changed, 114 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
> index 262436b..8ae72f7 100644
> --- a/Documentation/git-rm.txt
> +++ b/Documentation/git-rm.txt
> @@ -149,6 +149,10 @@ files that aren't ignored are present in the submodules work tree.
>  Ignored files are deemed expendable and won't stop a submodule's work
>  tree from being removed.
>
> +If you only want to remove the local checkout of a submodule from your
> +work tree without committing that use linkgit:git-submodule[1] `deinit`
> +instead.
> +
>  EXAMPLES
>  --------
>  `git rm Documentation/\*.txt`::
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index b1996f1..9a20e1d 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -13,6 +13,7 @@ SYNOPSIS
>  	      [--reference <repository>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> +'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch] [--rebase]
>  	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
> @@ -134,6 +135,19 @@ init::
>  	the explicit 'init' step if you do not intend to customize
>  	any submodule locations.
>
> +deinit::
> +	Unregister the given submodules, i.e. remove the whole
> +	`submodule.$name` section from .git/config together with their work
> +	tree. Further calls to `git submodule update`, `git submodule foreach`
> +	and `git submodule sync` will skip any unregistered submodules until
> +	they are initialized again, so use this command if you don't want to
> +	have a local checkout of the submodule in your work tree anymore. If
> +	you really want to remove a submodule from the repository and commit
> +	that use linkgit:git-rm[1] instead.
> ++
> +If `--force` is specified, the submodule's work tree will be removed even if
> +it contains local modifications.
> +
>  update::
>  	Update the registered submodules, i.e. clone missing submodules and
>  	checkout the commit specified in the index of the containing repository.
> @@ -213,8 +227,10 @@ OPTIONS
>
>  -f::
>  --force::
> -	This option is only valid for add and update commands.
> +	This option is only valid for add, deinit and update commands.
>  	When running add, allow adding an otherwise ignored submodule path.
> +	When running deinit the submodule work trees will be removed even if
> +	they contain local changes.
>  	When running update, throw away local changes in submodules when
>  	switching to a different commit; and always run a checkout operation
>  	in the submodule, even if the commit listed in the index of the
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 22ec5b6..e01f6b5 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -8,6 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
>  USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
> +   or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
>     or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
> @@ -547,6 +548,73 @@ cmd_init()
>  }
>
>  #
> +# Unregister submodules from .git/config and remove their work tree
> +#
> +# $@ = requested paths (use '.' to deinit all submodules)
> +#
> +cmd_deinit()
> +{
> +	# parse $args after "submodule ... init".
> +	while test $# -ne 0
> +	do
> +		case "$1" in
> +		-f|--force)
> +			force=$1
> +			;;
> +		-q|--quiet)
> +			GIT_QUIET=1
> +			;;
> +		--)
> +			shift
> +			break
> +			;;
> +		-*)
> +			usage
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done
> +
> +	if test "$#" == "0"

No need to quote either of these (imitate what you did above with
"while"); also use single "=" for string comparison.

> +	then
> +		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
> +	fi
> +
> +	module_list "$@" |
> +	while read mode sha1 stage sm_path
> +	do
> +		die_if_unmatched "$mode"
> +		name=$(module_name "$sm_path") || exit
> +		url=$(git config submodule."$name".url)
> +		if test -z "$url"
> +		then
> +			# Only mention uninitialized submodules when its
> +			# path have been specified
> +			test "$@" != "." &&

If your $# is not 1, "test" will fail with "too many arguments"
here, I think.

I would probably set a variable before running module_list,

	needs_uninitialized_warning=
        if $# = 1 || $1 != .
	then
		needs_uninitialized_warning=yes
	fi

and check that variable here, perhaps.

But stepping back a bit, why does it warn only for non '.' case?

Shouldn't

	git submodule deinit 'foo*'

behave the same way between foo1 and foo2 when it sees foo1 has been
initialized but foo2 hasn't?

> +			say "$(eval_gettext "No url found for submodule path '\$sm_path' in .git/config")"
> +			continue
> +		fi
> +
> +		# Remove the submodule work tree
> +		if test -z $force

As $force is initialized to an empty string, this without dq around
it will become a syntax error, feeding "test" with a single argument
"-z".

> +		then
> +			git rm -n "$sm_path" ||
> +			die "$(eval_gettext "Submodule work tree $sm_path contains local modifications, use '-f' to discard them")"
> +		fi
> +		rm -rf "$sm_path"

Do we want to make sure that $sm_path/.git is a gitfile here?  I do
not think it matters that much, but the user may have local commits
that he has not pushed out, in which case it would be nicer to give
a way to preserve them.

> +		mkdir "$sm_path"

Also can these rm -rf or mkdir fail, and what would we want to do
when they do?

I think it is preferrable to run "config --remove-section"
regardless, but we may want to tell the user what happened (i.e. the
submodule has been unregistered as far as Git is concerned, but the
worktree may have some cruft we couldn't remove).

> +
> +		# Remove the whole section so we have a clean state when the
> +		# user later decides to init this submodule again
> +		git config --remove-section submodule."$name" &&
> +		say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$sm_path'")"
> +	done
> +}
> +
> +#
>  # Update each submodule path to correct revision, using clone and checkout as needed
>  #
>  # $@ = requested paths (default to all)
> @@ -1157,7 +1225,7 @@ cmd_sync()
>  while test $# != 0 && test -z "$command"
>  do
>  	case "$1" in
> -	add | foreach | init | update | status | summary | sync)
> +	add | foreach | init | deinit | update | status | summary | sync)
>  		command=$1
>  		;;
>  	-q|--quiet)
