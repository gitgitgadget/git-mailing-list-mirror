From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC PATCH 2/7] rebase -i: Teach do_pick the option --edit
Date: Fri, 20 Jun 2014 15:41:23 +0200
Message-ID: <53A43A03.5030506@alum.mit.edu>
References: <cover.1403146774.git.bafain@gmail.com> <53A258DE.10407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 15:41:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxz4M-0004V6-HS
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 15:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965676AbaFTNl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 09:41:27 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53803 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934326AbaFTNl0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jun 2014 09:41:26 -0400
X-AuditID: 1207440c-f79656d000000c83-2a-53a43a05df2b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 91.73.03203.50A34A35; Fri, 20 Jun 2014 09:41:25 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96616.dip0.t-ipconnect.de [79.201.102.22])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5KDfNgD002582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 20 Jun 2014 09:41:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <53A258DE.10407@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqMtqtSTYYN4WSYtDc++xW3Rd6WZy
	YPLYOesuu8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bn3z+YVXDCt+HF2AlMD4y/NLkZODgkBE4md
	k78zQ9hiEhfurWfrYuTiEBK4zCix4fJ+KOc8k8TBmfNYQap4BbQlvn+/BmazCKhKfNq2AKyb
	TUBXYlFPMxOILSoQJDH78zx2iHpBiZMzn7CA2CIC5hLHd8wCiwsLuEtMOdoGFhcS8JNYsuk9
	WJxTQF1i09JLQDYH0EXiEj2NQSBhZgEdiXd9D5ghbHmJ7W/nME9gFJiFZMMsJGWzkJQtYGRe
	xSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqJebWaKXmlK6iRESpjw7GL+tkznEKMDBqMTD22G6
	OFiINbGsuDL3EKMkB5OSKK+7zpJgIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8t2SBcrwpiZVV
	qUX5MClpDhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4lCV5bS6BGwaLU9NSKtMycEoQ0Ewcn
	yHAuKZHi1LyU1KLE0pKMeFCcxhcDIxUkxQO0VwGknbe4IDEXKArReopRl+PUnWNtTEIsefl5
	qVLivM0WQEUCIEUZpXlwK2BJ6RWjONDHwrzxIKN4gAkNbtIroCVMQEsW9ywCWVKSiJCSamBM
	vb8t/7y7g77XA7+A6UHpV6QO5Z78eDEnOEXfpnj6H4Y9WYLXtk97E5fj9UzpQ4+VRcblfsEN
	P2SUDgTmPJeZ82z1nq7IuSk99QdLb3Mdeem79olUy/1onllxWSvDuK7G+UkyPwz/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252225>

On 06/19/2014 05:28 AM, Fabian Ruch wrote:
> The to-do list command `reword` replays a commit like `pick` but lets
> the user also edit the commit's log message. If one thinks of `pick`
> entries as scheduled `cherry-pick` command lines, then `reword` becomes
> an alias for the command line `cherry-pick --edit`. The porcelain
> `rebase--interactive` defines a function `do_pick` for processing the
> `pick` entries on to-do lists. Teach `do_pick` to handle the option
> `--edit` and reimplement `reword` in terms of `do_pick --edit`. Refer to
> `pick_one` for the way options are parsed.
> 
> `do_pick` ought to act as a wrapper around `cherry-pick`. Unfortunately,
> it cannot just forward `--edit` to the `cherry-pick` command line. The
> assembled command line is executed within a command substitution for
> controlling the verbosity of `rebase--interactive`. Passing `--edit`
> would either hang the terminal or clutter the substituted command output
> with control sequences. Execute the `reword` code from `do_next` instead
> if the option `--edit` is specified. Adjust the fragment in two regards.
> Firstly, discard the additional message which is printed if an error
> occurs because
> 
>     Aborting commit due to empty commit message. (Duplicate Signed-off-by lines.)
>     Could not amend commit after successfully picking 1234567... Some change
> 
> is more readable than and contains (almost) the same information as
> 
>     Aborting commit due to empty commit message. (Duplicate Signed-off-by lines.)
>     Could not amend commit after successfully picking 1234567... Some change
>     This is most likely due to an empty commit message, or the pre-commit hook
>     failed. If the pre-commit hook failed, you may need to resolve the issue before
>     you are able to reword the commit.
> 
> (It is true that a hook might not output any diagnosis but the same
> problem arises when using git-commit directly. git-rebase at least
> prints a generic message saying that it failed to commit.) Secondly,
> sneak in additional git-commit arguments:
> 
>  - `--allow-empty` is missing: `rebase--interactive` suddenly fails if
>    an empty commit is picked using `reword` instead of `pick`. The
>    whether a commit is empty or not is not changed by an altered log
>    message, so do as `pick` does. Add test.
> 
>  - `-n`: Hide the fact that we are committing several times by not
>    executing the pre-commit hook. Caveat: The altered log message is not
>    verified because `-n` also skips the commit-msg hook. Either the log
>    message verification must be included in the post-rewrite hook or
>    git-commit must support more fine-grained control over which hooks
>    are executed.
> 
>  - `-q`: Hide the fact that we are committing several times by not
>    printing the commit summary.

It is preferable that each commit makes one logical change (though it
must always be a self-contained change; i.e., the code should never be
broken at the end of a commit).  It would be clearer if you would split
this commit into one refactoring commit (moving the handling of --edit
to do_pick) plus one commit for each "git commit" option change and
error message change.  That way,

* Each commit (and log message) becomes simpler, making it easier
  to review.
* The changes can be discussed separately.
* If there is an error, "git bisect" can help determine which of
  the changes is at fault.

> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  git-rebase--interactive.sh    | 52 ++++++++++++++++++++++++++++++++++++-------
>  t/t3404-rebase-interactive.sh |  8 +++++++
>  2 files changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index ea5514e..fffdfa5 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -490,7 +490,42 @@ record_in_rewritten() {
>  	esac
>  }
>  
> +# Apply the changes introduced by the given commit to the current head.
> +#
> +# do_pick [--edit] <commit> <title>
> +#
> +# Wrapper around git-cherry-pick.
> +#
> +# <title>
> +#     The commit message title of <commit>. Used for information
> +#     purposes only.
> +#
> +# <commit>
> +#     The commit to cherry-pick.

Unless there is a reason to do otherwise, please order the documentation
to match the order that the do_pick arguments appear.

> +#
> +# -e, --edit
> +#     After picking <commit>, open an editor and let the user edit the
> +#     commit message. The editor contents becomes the commit message of
> +#     the new head.
>  do_pick () {
> +	edit=
> +	while test $# -gt 0
> +	do
> +		case "$1" in
> +		-e|--edit)
> +			edit=y
> +			;;
> +		-*)
> +			warn "do_pick: ignored option -- $1"
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done
> +	test $# -ne 2 && die "do_pick: wrong number of arguments"
> +
>  	if test "$(git rev-parse HEAD)" = "$squash_onto"
>  	then
>  		# Set the correct commit message and author info on the
> @@ -512,6 +547,14 @@ do_pick () {
>  		pick_one $1 ||
>  			die_with_patch $1 "Could not apply $1... $2"
>  	fi
> +
> +	if test -n "$edit"
> +	then
> +		git commit --allow-empty --amend --no-post-rewrite -n -q ${gpg_sign_opt:+"$gpg_sign_opt"} || {
> +			warn "Could not amend commit after successfully picking $1... $2"
> +			exit_with_patch $1 1
> +		}
> +	fi
>  }
>  
>  do_next () {
> @@ -532,14 +575,7 @@ do_next () {
>  		comment_for_reflog reword
>  
>  		mark_action_done
> -		do_pick $sha1 "$rest"
> -		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
> -			warn "Could not amend commit after successfully picking $sha1... $rest"
> -			warn "This is most likely due to an empty commit message, or the pre-commit hook"
> -			warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
> -			warn "you are able to reword the commit."
> -			exit_with_patch $sha1 1
> -		}
> +		do_pick --edit $sha1 "$rest"
>  		record_in_rewritten $sha1
>  		;;
>  	edit|e)
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 8197ed2..9931143 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -75,6 +75,14 @@ test_expect_success 'rebase --keep-empty' '
>  	test_line_count = 6 actual
>  '
>  
> +test_expect_success 'rebase --keep-empty' '
> +	git checkout emptybranch &&
> +	set_fake_editor &&
> +	FAKE_LINES="1 reword 2" git rebase --keep-empty -i HEAD~2 &&
> +	git log --oneline >actual &&
> +	test_line_count = 6 actual
> +'
> +
>  test_expect_success 'rebase -i with the exec command' '
>  	git checkout master &&
>  	(
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
