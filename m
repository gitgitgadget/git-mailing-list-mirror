From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'git submodule update --force' always check out
 submodules.
Date: Wed, 22 Aug 2012 18:43:16 -0700
Message-ID: <7v8vd65qob.fsf@alter.siamese.dyndns.org>
References: <20120822233610.710C01C2DAF@stefro.sfo.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 03:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4MSt-0003wy-RO
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 03:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab2HWBnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 21:43:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48130 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333Ab2HWBnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 21:43:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C98EC8691;
	Wed, 22 Aug 2012 21:43:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3J8ptECgNZUC9IP2wNox6pEO0GU=; b=mrTvRf
	p43MK2F4n2nA8+Vk7bZvD37L+x+J8Kn28B0FyDQDksIHu+jL3KmzmJsRGfKqkrGX
	yJF23JVtyWmLjI0K8M8XttIYJrc3xNyS4UMNBj4TMs6ORA4kCs/tZyOohKPtEyVM
	V/5WqPfFT1yGrbT1cZl8NANszu174M1nbpbt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tfGVSb2HSldZ4JdXPEp+ne/50Qy+WCPw
	X1w51zh/U/LcKpufKxEJoFBUehFuw0/KerxJ5AyUGgmdJfCMo98vm4XbMTuGAs3X
	g6SIs2unY0yXmGJ4GjPbglkI25q138TEP1lI34hJFZdeykfGxyFGgd0ApkstEW9Y
	HIZ176/a9yc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7AD58690;
	Wed, 22 Aug 2012 21:43:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD716868F; Wed, 22 Aug 2012
 21:43:18 -0400 (EDT)
In-Reply-To: <20120822233610.710C01C2DAF@stefro.sfo.corp.google.com> (Stefan
 Zager's message of "Wed, 25 Jul 2012 10:41:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA0AC340-ECC3-11E1-9748-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204107>

Stefan Zager <szager@google.com> writes:

> Currently, it will only do a checkout if the sha1 registered in the containing
> repository doesn't match the HEAD of the submodule, regardless of whether the
> submodule is dirty.  As discussed on the mailing list, the '--force' flag is a
> strong indicator that the state of the submodule is suspect, and should be reset
> to HEAD.
>
> Signed-off-by: Stefan Zager <szager@google.com>
> ---

Thanks for a reroll.  Will queue; looking good ;-)

>  Documentation/git-submodule.txt |  9 ++++++++-
>  git-submodule.sh                |  2 +-
>  t/t7406-submodule-update.sh     | 12 ++++++++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index fbbbcb2..2de7bf0 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -149,6 +149,11 @@ submodule with the `--init` option.
>  +
>  If `--recursive` is specified, this command will recurse into the
>  registered submodules, and update any nested submodules within.
> ++
> +If `--force` is specified, the submodule will be checked out (using
> +`git checkout --force` if appropriate), even if the commit specified in the
> +index of the containing repository already matches the commit checked out in
> +the submodule.
>  
>  summary::
>  	Show commit summary between the given commit (defaults to HEAD) and
> @@ -210,7 +215,9 @@ OPTIONS
>  	This option is only valid for add and update commands.
>  	When running add, allow adding an otherwise ignored submodule path.
>  	When running update, throw away local changes in submodules when
> -	switching to a different commit.
> +	switching to a different commit; and always run a checkout operation
> +	in the submodule, even if the commit listed in the index of the
> +	containing repository matches the commit checked out in the submodule.
>  
>  --cached::
>  	This option is only valid for status and summary commands.  These
> diff --git a/git-submodule.sh b/git-submodule.sh
> index aac575e..3aa7644 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -578,7 +578,7 @@ Maybe you want to use 'update --init'?")"
>  			die "$(eval_gettext "Unable to find current revision in submodule path '\$sm_path'")"
>  		fi
>  
> -		if test "$subsha1" != "$sha1"
> +		if test "$subsha1" != "$sha1" -o -n "$force"
>  		then
>  			subforce=$force
>  			# If we don't already have a -f flag and the submodule has never been checked out
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index ce61d4c..9706436 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -123,6 +123,18 @@ test_expect_success 'submodule update should throw away changes with --force ' '
>  	)
>  '
>  
> +test_expect_success 'submodule update --force forcibly checks out submodules' '
> +	(cd super &&
> +	 (cd submodule &&
> +	  rm -f file
> +	 ) &&
> +	 git submodule update --force submodule &&
> +	 (cd submodule &&
> +	  test "$(git status -s file)" = ""
> +	 )
> +	)
> +'
> +
>  test_expect_success 'submodule update --rebase staying on master' '
>  	(cd super/submodule &&
>  	  git checkout master
