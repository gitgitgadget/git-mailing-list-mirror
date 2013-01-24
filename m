From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9902: Instruct git-completion.bash about a test mode
Date: Thu, 24 Jan 2013 13:46:13 -0800
Message-ID: <7vtxq68day.fsf@alter.siamese.dyndns.org>
References: <201301242220.09067.jn.avila@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Thu Jan 24 22:46:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyUd4-0002ua-OF
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 22:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab3AXVqR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 16:46:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52962 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278Ab3AXVqP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 16:46:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63A7DCC98;
	Thu, 24 Jan 2013 16:46:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tekXYkowfVNC
	S9YP+baIz9ySuDA=; b=O1pQ6w/2YEcntfgy7uZp5KPfFWslvSboY6tzcuJy2gD2
	8qqWvlLfp66krKnd/CSZ3rchUoAyZiWgR9QFJsh9y/WCV28vCSpr+Qe5IcQx5/9L
	/+Kk9aETRYwFK359w60Dt71C89YwFwP0x9cMxjQPMW6Qb1ramgr5Oh8I2YTXl6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=j1ikJ6
	l94bCvuXY4vDQFWgXvio1jIPUsS4n3PjVmN4hA1hQlF0NX/srOBenE8NHfcPlZ3i
	6+8gXfQT9YspMVnIML6BGc7qJFfrDqhI6+uVgYRWYMCVoigs8M+OI0ajRShL9ivb
	Zux5fEAxL1jhj6vdWihjjfqLp2K3fOq9ErvFg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 594B2CC97;
	Thu, 24 Jan 2013 16:46:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA8B4CC95; Thu, 24 Jan 2013
 16:46:14 -0500 (EST)
In-Reply-To: <201301242220.09067.jn.avila@free.fr> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message of "Thu, 24 Jan 2013 22:20:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79E63560-666F-11E2-AB52-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214462>

"Jean-No=C3=ABl AVILA" <jn.avila@free.fr> writes:

> In test mode, git completion should propose commands only if they
> belong to the list of authorized commands.
>
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>
> Better show some code than try to explain. Here is what I mean by
> "filter the output git help -a".=20

Why do you have to make an extra shell function call for each and
every possible Git subcommand to slow down everybody's work when not
in testing mode?

Comparing it with Peff's suggestion, it is fairly clear which one we
should pick, I think.



>  contrib/completion/git-completion.bash | 16 +++++++++++++++-
>  t/t9902-completion.sh                  |  4 ++--
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 14dd5e7..6490553 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -531,6 +531,20 @@ __git_complete_strategy ()
>  	return 1
>  }
> =20
> +if test -z "$AUTHORIZED_CMD_LIST"; then
> +	__git_cmdlist ()
> +	{=20
> +		echo $1;
> +	}
> +else
> +	__git_cmdlist ()
> +	{=20
> +		if [[ " $AUTHORIZED_CMD_LIST " =3D~ " $1 " ]] ; then
> +				echo $1
> +		fi
> +	}
> +fi
> +
>  __git_list_all_commands ()
>  {
>  	local i IFS=3D" "$'\n'
> @@ -538,7 +552,7 @@ __git_list_all_commands ()
>  	do
>  		case $i in
>  		*--*)             : helper pattern;;
> -		*) echo $i;;
> +		*) __git_cmdlist $i;;
>  		esac
>  	done
>  }
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 3cd53f8..5e7d81e 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -12,8 +12,8 @@ complete ()
>  	# do nothing
>  	return 0
>  }
> -
> -. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
> +AUTHORIZED_CMD_LIST=3D" checkout show add filter-branch ls-files sen=
d-email describe"
> +. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"=20
> =20
>  # We don't need this function to actually join words or do anything =
special.
>  # Also, it's cleaner to avoid touching bash's internal completion va=
riables.
