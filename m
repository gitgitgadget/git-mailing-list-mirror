From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-submodule: respect -q for add/update
Date: Tue, 04 Sep 2012 17:28:24 +0200
Message-ID: <50461E18.6020400@web.de>
References: <1346743880-11379-1-git-send-email-orgads@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 17:28:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8v3R-0006kK-8F
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 17:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756931Ab2IDP2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 11:28:32 -0400
Received: from mout.web.de ([212.227.15.3]:51940 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756909Ab2IDP2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 11:28:31 -0400
Received: from [192.168.178.41] ([91.3.176.45]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MT8fq-1SyZD81liA-00SDt2; Tue, 04 Sep 2012 17:28:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <1346743880-11379-1-git-send-email-orgads@gmail.com>
X-Provags-ID: V02:K0:t+XLSPJyNjLUXmJDhpZUFviSyjlyaV7zQXuozgA3Mvd
 /9iCBuojthvxO89DScN+kCzG65+8hMPFDW2P7AlKgJC0T+mB9j
 ZvPFNW5O3/KhwoSod8zFnxCjXXuc5nusV/216/li5VFkbFRDxh
 RbZOk+wfk0oxnD4TZoZztcENARXdwOr8WV8idflWj5eoLWPinZ
 QwtMx1kP6kqEnQ+xGpVJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204747>

Am 04.09.2012 09:31, schrieb Orgad Shaneh:
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>

Before the "Signed-off-by" is the place where you should have
explained why this would be a worthwhile change ;-)

To me this looks like you make the default noisier and require an
explicit "-q" to make it quiet again. There is a reason you don't
normally get bothered with the output of the checkout command run
under the hood of git submodule add/update, so I don't think this
change makes things better.

But you might want to think about adding a "-v/--verbose" flag to
make the submodule add/update checkouts more verbose, in case you
care about the output of the checkout command. That would be a
sane thing to do, so what about changing your patch into this
direction?

> ---
>  git-submodule.sh |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index aac575e..dd57abb 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -266,6 +266,11 @@ cmd_add()
>  
>  	repo=$1
>  	sm_path=$2
> +	quiet=
> +	if test -n "$GIT_QUIET"
> +	then
> +		quiet=-q
> +	fi
>  
>  	if test -z "$sm_path"; then
>  		sm_path=$(echo "$repo" |
> @@ -332,8 +337,8 @@ Use -f if you really want to add it." >&2
>  			cd "$sm_path" &&
>  			# ash fails to wordsplit ${branch:+-b "$branch"...}
>  			case "$branch" in
> -			'') git checkout -f -q ;;
> -			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> +			'') git checkout -f $quiet ;;
> +			?*) git checkout -f $quiet -B "$branch" "origin/$branch" ;;
>  			esac
>  		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
>  	fi
> @@ -527,6 +532,12 @@ cmd_update()
>  		shift
>  	done
>  
> +	quiet=
> +	if test -n "$GIT_QUIET"
> +	then
> +		quiet=-q
> +	fi
> +
>  	if test -n "$init"
>  	then
>  		cmd_init "--" "$@" || return
> @@ -619,7 +630,7 @@ Maybe you want to use 'update --init'?")"
>  				must_die_on_failure=yes
>  				;;
>  			*)
> -				command="git checkout $subforce -q"
> +				command="git checkout $subforce $quiet"
>  				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$sm_path'")"
>  				say_msg="$(eval_gettext "Submodule path '\$sm_path': checked out '\$sha1'")"
>  				;;
> 
