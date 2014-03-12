From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: add verbose mode for add/update
Date: Wed, 12 Mar 2014 17:15:50 +0100
Message-ID: <53208836.4050900@web.de>
References: <1394631731-4678-1-git-send-email-orgad.shaneh@audiocodes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Orgad Shaneh <orgads@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 17:15:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNloy-0006i9-V1
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 17:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbaCLQPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 12:15:53 -0400
Received: from mout.web.de ([212.227.15.14]:62896 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbaCLQPw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 12:15:52 -0400
Received: from [192.168.178.41] ([84.132.147.182]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M7bUB-1XKqeH2eDX-00xL1b; Wed, 12 Mar 2014 17:15:50
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1394631731-4678-1-git-send-email-orgad.shaneh@audiocodes.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:KQ6rrUafKUVr5pSXnT2+qJ8KL2sUnGmJ6kxi7NbECZZYtOAFs7S
 A2w+1FIPYhjStluiKF2Ye0DDM2dgICm8PdAXyGaqcTCt535UqHtMEccXNTW0icbs9GQbiWE
 4mMlCs7a9igM/1fM/orv3r5XzwrFg6LAnV9GFe9eXzXO0iEGer88SfTlq6m47ZpwjciYYjM
 4eeH7LF9n9yUF+qkv2ckw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243942>

Am 12.03.2014 14:42, schrieb Orgad Shaneh:
> From: Orgad Shaneh <orgads@gmail.com>

You don't need the line above when you are the sender ;-)

> Executes checkout without -q

That's a bit terse. What about:

"Add the verbose flag to add and update which displays the
 progress of the actual submodule checkout when given. This
 is useful for checkouts that take a long time, as the user
 can then see the progress."

> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>  Documentation/git-submodule.txt |  7 +++++--
>  git-submodule.sh                | 24 +++++++++++++++++++-----
>  t/t7406-submodule-update.sh     |  9 +++++++++
>  3 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 21cb59a..1867e94 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -10,13 +10,13 @@ SYNOPSIS
>  --------
>  [verse]
>  'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
> -	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
> +	      [--reference <repository>] [--depth <depth>] [-v|--verbose] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
>  'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
>  	      [-f|--force] [--rebase|--merge|--checkout] [--reference <repository>]
> -	      [--depth <depth>] [--recursive] [--] [<path>...]
> +	      [--depth <depth>] [--recursive] [-v|--verbose] [--] [<path>...]
>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
>  	      [commit] [--] [<path>...]
>  'git submodule' [--quiet] foreach [--recursive] <command>
> @@ -363,6 +363,9 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
>  	clone with a history truncated to the specified number of revisions.
>  	See linkgit:git-clone[1]
>  
> +--verbose::
> +  This option is valid for add and update commands. Show output of
> +  checkout.

The above looks whitespace-damaged, you should use TABs here to
indent (just like the other options do).

>  <path>...::
>  	Paths to submodule(s). When specified this will restrict the command
> diff --git a/git-submodule.sh b/git-submodule.sh
> index a33f68d..5c4e057 100755
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
> +		'') git checkout -f $subquiet ${start_point:+"$start_point"} ;;
> +		?*) git checkout -f $subquiet -B "$local_branch" ${start_point:+"$start_point"} ;;

Wouldn't it be better to use the ${subquiet:+"$subquiet"} notation
here like the other optional arguments do? After all the subquiet
isn't always set.

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
>  		--)
>  			shift
>  			break
> @@ -786,6 +793,9 @@ cmd_update()
>  		--depth=*)
>  			depth=$1
>  			;;
> +		-v|--verbose)
> +			verbose=1
> +			;;
>  		--)
>  			shift
>  			break
> @@ -913,7 +923,11 @@ Maybe you want to use 'update --init'?")"
>  			must_die_on_failure=
>  			case "$update_module" in
>  			checkout)
> -				command="git checkout $subforce -q"
> +				if test -z "$verbose"
> +				then
> +					subquiet=-q
> +				fi
> +				command="git checkout $subforce $subquiet"

Same as above.

>  				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
>  				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
>  				;;
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 28ca763..04a0fcc 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -83,6 +83,15 @@ test_expect_success 'submodule update detaching the HEAD ' '
>  	)
>  '
>  
> +test_expect_success 'submodule update verbose' '
> +	(cd super/submodule &&
> +	 git checkout master
> +	) &&
> +	(cd super &&
> +	 git submodule update --verbose submodule 2>&1 | grep -q "HEAD is now at"

This string is translated, so you need to use test_i18ngrep.
Please see t7201-co.sh for an example of how to pipe the
output into a file and then compare it.

> +	)
> +'
> +
>  test_expect_success 'submodule update from subdirectory' '
>  	(cd super/submodule &&
>  	 git reset --hard HEAD~1
> 
