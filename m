From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/2] submodule update: continue when a checkout fails
Date: Sun, 15 May 2011 14:26:37 -0700
Message-ID: <7viptbodte.fsf@alter.siamese.dyndns.org>
References: <cover.1305462132.git.iveqy@iveqy.com>
 <551b190565139229c6f374eeba11dd8486375a1d.1305462132.git.iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun May 15 23:27:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLiqJ-0004xy-1Q
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 23:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783Ab1EOV0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 17:26:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41952 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab1EOV0x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 17:26:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED3505407;
	Sun, 15 May 2011 17:28:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Z5puqNG2rtwolrVxAFzaKO4Zl4=; b=Puq15P
	8GTx760KRNEJZPS+tElD2txgqqE+ea8pOzpHJ4WdXO+GlnXqXtCPSeBW/GO2mOlD
	KUM1Jtt1egag8hzUOUcbd8jd7GdnAjALCkniNI4DL+musBd9Jf1K33mU8A9jVGAn
	e1Bo70RTowkMSbqsNujfWXxupCkWI/jQ8PIIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FF1XBSsIsnGxFapE6Q22Nr3jWxKnYrON
	vH6F7LV4ERtcC8X7PDN1afea/qVys0jDOyqS/lODnoRpPQx+GQZCu/vrtPE+uPtG
	LxdgoACWDX5n9nq5PaR2rMSM1bNprrnSrDFE+CuK9UOqJgHLY8QO51tcQf+R4cf7
	4QrQwjtGJ9Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A0C4F5405;
	Sun, 15 May 2011 17:28:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E990D5401; Sun, 15 May 2011
 17:28:44 -0400 (EDT)
In-Reply-To: <551b190565139229c6f374eeba11dd8486375a1d.1305462132.git.iveqy@iveqy.com>
 (Fredrik Gustafsson's message of "Sun, 15 May 2011 14:42:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 536CE866-7F3A-11E0-859D-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173666>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> When running git submodule update the submodules are checked out in
> alphabetic order. When an update of a submodule fails because of a
> checkout error, continue to the next submodule and when done with all
> submodules, exit with an error.
>
> We only do this for 'safe' case when a submodule is not marked as
> rebase or merge. When the update of a submodule fails because of a merge
> or rebase, the update will still die immediately to give the user an
> opportunity to resolve any conflicts before continuing.
>
> Since submodule 'b' does not necessarily need to be dependent on
> submodule 'a' this behavior is helpful if we have a lot of submodules.
> For example if some submodules currently experience network problems
> we can securely continue with the other submodules and the user can
> revisit the failed one later on.
>
> It also is helpful if a checkout fails because a submodules working
> directory is dirty. Now the user can cleanup the submodule in question
> and another git submodule update will just update the failed submodule
> instead of all submodules that are ordered alphabetically afterwards.
>
> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
> Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
> Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>

Thanks, even though I find that the logic does not flow as smoothly as it
could in the above description, it now has sufficient information. Compared
to the previous round, it is a vast improvement.

I would rephrase it differently though. The problem description at the
highest level should come first.

	"git submodule update" stops at the first error and gives control
	back to the user. Only after the user fixes the problematic
	submodule and runs "git submodule update" again, the second error
	is found. And the user needs to repeat until all the problems are
	found and fixed one by one. This is tedious.

Then give a high level description of the proposed approach.

	Instead, the command can remember which submodules it had trouble
	with, continue updating the ones it can, and report which ones had
	errors at the end. The user can run "git submodule update", find
	all the ones that need minor fixing (e.g. working tree was dirty)
	to fix them in a single pass. Then another "git submodule update"
	can be run to update all.

And follow up with minor details.

	Note that the problematic submodules are skipped only when they
	are to be integrated with a safer value of submodule.<name>.update
	option, namely "checkout". Fixing a failure in a submodule that
	uses "rebase" or "merge" may need an involved conflict resolution
	by the user, and leaving too many submodules in states that need
	resolution would not reduce the mental burden on the user.

Wouldn't that be easier to understand? After all "alphabetical" is not an
essential part of the problem, but "stopping at the first error, with an
arbitrary definition of order of the submodules (which happens to be
alphabetical)" is the problem you are addressing, no?

Expressed that way, it may become clearer that it is dubious that stopping
on "rebase/merge" is something you should unilaterally enforce; instead,
the user may want to be able to configure if the command should skip and
continue in such a case.

>  git-submodule.sh            |   42 ++++++++++++++++++++++++++++++++++++------
>  t/t7406-submodule-update.sh |   29 +++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 6 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index bf110e9..02c41c7 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -525,17 +526,46 @@ cmd_update()
>  				;;
>  			esac
>  
> -			(clear_local_git_env; cd "$path" && $command "$sha1") ||
> -			die "Unable to $action '$sha1' in submodule path '$path'"
> -			say "Submodule path '$path': $msg '$sha1'"
> +			if (clear_local_git_env; cd "$path" && $command "$sha1")
> +			then
> +				say "Submodule path '$path': $msg '$sha1'"
> +			else
> +				case $action in
> +				rebase|merge)
> +					die "Unable to $action '$sha1' in submodule path '$path'" 2

Per my comments to your 1/2, this would become

					die_with_status 2 "Unable to $action '$sha1' in" \
				        	"submodule path '$path'"

I think.  And 1/2 would result in something like this:

	die_with_status () {
		status=$1
                shift
                echo >&2 "$*"
                exit $status
	}

        die () {
        	die_with_status 1 "$@"
	}

> +					err="Failed to $action one or more submodule(s)"
> +					continue

See below...

>  		if test -n "$recursive"
>  		then
> +			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_flags")
> +			res=$?
> +			if test $res -gt 0
> +			then
> +				if test $res -eq 1
> +				then
> +					say "Failed to recurse into submodule path '$path'"
> +					continue

Hmm, should this case be err="..."?

> +				else
> +					die "Failed to recurse into submodule path '$path'" $res
> +				fi
> +			fi
>  		fi
>  	done
> +
> +	if test -n "$err"
> +	then
> +		die "$err"

I am not sure if you are properly addressing the original problem that you
are trying to solve.

When the first error stops the user, the user needs to fix the situation
with that submodule and continue to get another error, and then needs to
continue until all the errors are fixed incrementally, which is tedious.
But at least in the current code, when the user gets control back, the
error message clearly says which submodule was troublesome, so the user
knows where to go to fix things to make progress.

But after your change, the user essentially gets "Many submodules were
updated but there were a few that were skipped. Scroll up and read reams
of output to find out which ones they were".  Aren't you converting one
form of tedium with another?

How about making $err variable to accumulate the names/paths of submodules
you had trouble updating:

	punted_submodules= ;# initialization
	...

	if (... $command "$sha1")
        then
        	case "$action" in
                $unsafe_actions)
                	die_with_status 2 "Unable to $action '$sha1' ..." ;;
		*)
                	punted_submodules="$punted_submodules$path "
                        continue ;;
		esac

and formulate the error message here to list all of them, perhaps like:

	if test -n "$punted_modules"
        then
		die "Failed to update some modules: $punted_modules"
	fi
