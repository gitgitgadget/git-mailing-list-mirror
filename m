From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-{pull,rebase} message without tracking
 information friendlier
Date: Wed, 29 Feb 2012 12:14:31 -0800
Message-ID: <7vobshs8go.fsf@alter.siamese.dyndns.org>
References: <vpqbooit61u.fsf@bauges.imag.fr>
 <1330540914-14515-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Feb 29 21:14:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2pv7-0001hL-NT
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 21:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151Ab2B2UOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 15:14:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755067Ab2B2UOf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 15:14:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4837B7C42;
	Wed, 29 Feb 2012 15:14:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3I64EZYFhzf8
	Y7ww3Cy6sYlARZc=; b=LHtOGSlmKq9+nmn/SMiuuF8cf+XZX6uhN66Ij2usOunx
	AxHmy5SbBtx7Mn0N/F8i+H6lOG8QbrYs7hw7fUxrvxbNxlcwPuVlqbQupsyoiCNu
	c9WGxfLundGfT67nAgwXqkcfnfafgW97hzoPkK1hmBHnI1fRzDC1/yt4ldnPn1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NSFbSd
	+yJQUcOQl5v/s9/zP4sG7RZPh8GDo5txEpNekfnEQ0xnjFdK7wqBI7KHVDez5E5G
	nmP9ykK+JP6P6yDokO3yLGoeGhcqkn+2RS21fhxGnlp2dNoQEyO5qc89SRxK0DnK
	9FDh0auuCKtnse9p2cyE3gmfJHC7Ts5VmmdhQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FAA37C41;
	Wed, 29 Feb 2012 15:14:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6F6B7C3E; Wed, 29 Feb 2012
 15:14:32 -0500 (EST)
In-Reply-To: <1330540914-14515-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 29 Feb 2012 19:41:54
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE34712C-6311-11E1-9DCE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191850>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> The current message is too long and at too low a level for anybody to
> understand it if they don't know about the configuration format
> already.
>
> The text about setting up a remote is superfluous and doesn't help
> understand the error that has happened. Explain how to set up the
> tracking information, as it's the most likely way to get to the state
> the user was expecting.
>
> Also simplify the message we print on detached HEAD to remove clutter
> and a reference to branch.<branchname>.merge which is better left for
> the documentation.
> ---
> This still needs some shell scripting to figure out whether we'd want
> to replace <remote> with a real value. The text gets to the matter of
> things and even tells you how to fix it. More text doesn't really add
> more useful information, and this isn't a manpage.

Exactly.

This made me thinking again.  On the "detached HEAD" side of your patch=
,
the concluding "Please specify which branch you mean" is the most usefu=
l
information; ", so I cannot use any tracking information in your
configuration file" may help _education_, but does not immediately help
the user to do what the user wanted to do.

Perhaps it may read it better if we remove that part; the result become=
s
even more concise and to the point.

Oh the "on a branch" side of your patch, the updated message is trying =
to
help the user by doing two things:

 - tell him to explicitly name the branch (by the way, you seem to have
   lost the $example---is it intended) in order to immediately perform
   what he wanted to.

 - educate him that he can configure upstream information and avoid
   typing in a later invocation of the same command.

I think it is easier to read if we have clear separation between the tw=
o,
as the hasty users would want to stop reading after the first help.

So after "See git-${cmd}(1) for details.", have a paragraph break, add
an indented "$example" just like you have for the "detached HEAD" case,
another paragraph break and then "To set the tracking information" as a
new pargraph, perhaps?

> I've left the branch --set-upstream in this version as it's probably
> the most usual fix for a failing git push.
>
>  git-parse-remote.sh |   32 ++++++++++----------------------
>  git-pull.sh         |    2 +-
>  git-rebase.sh       |    2 +-
>  3 files changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index b24119d..08adc90 100644
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -60,31 +60,19 @@ error_on_missing_default_upstream () {
>  	if test -z "$branch_name"
>  	then
>  		echo "You are not currently on a branch, so I cannot use any
> +tracking information in your configuration file.
> +Please specify which branch you want to $op_type $op_prep.
>  See git-${cmd}(1) for details.
> =20
> +    $example"
> +	else
> +		echo "You asked me to $cmd without specifying a branch to
> +$op_type $op_prep, and the current branch doesn't have any tracking
> +information. Please specify a branch and try again. See git-${cmd}(1=
)
> +for details. To set the tracking information, you can use
> =20
> -See git-config(1) for details."
> +    git branch --set-upstream ${branch_name#refs/heads/} <remote>/<b=
ranch>
> +"
>  	fi
>  	exit 1
>  }
> diff --git a/git-pull.sh b/git-pull.sh
> index d8b64d7..309c7db 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -176,7 +176,7 @@ error_on_no_merge_candidates () {
>  	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
>  		. git-parse-remote
>  		error_on_missing_default_upstream "pull" $op_type $op_prep \
> -			"git pull <repository> <refspec>"
> +			"git pull <remote> <branch>"
>  	else
>  		echo "Your configuration specifies to $op_type $op_prep the ref '$=
{upstream#refs/heads/}'"
>  		echo "from the remote, but no such ref was fetched."
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 00ca7b9..69c1374 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -380,7 +380,7 @@ then
>  		then
>  			. git-parse-remote
>  			error_on_missing_default_upstream "rebase" "rebase" \
> -				"against" "git rebase <upstream branch>"
> +				"against" "git rebase <branch>"
>  		fi
>  		;;
>  	*)	upstream_name=3D"$1"
