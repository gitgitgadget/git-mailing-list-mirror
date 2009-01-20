From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] bash completion: refactor diff options
Date: Tue, 20 Jan 2009 00:36:14 -0800
Message-ID: <7vwscqjrwh.fsf@gitster.siamese.dyndns.org>
References: <20090119173153.GB14053@spearce.org>
 <1232399880-22036-1-git-send-email-trast@student.ethz.ch>
 <1232399880-22036-2-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 20 09:37:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPC7K-00085M-SB
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 09:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbZATIgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 03:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbZATIgY
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 03:36:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbZATIgY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 03:36:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D736191C20;
	Tue, 20 Jan 2009 03:36:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C8A7691C1F; Tue,
 20 Jan 2009 03:36:17 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A655A42-E6CD-11DD-B6E7-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106457>

Thomas Rast <trast@student.ethz.ch> writes:

> diff, log and show all take the same diff options.  Refactor them from
> __git_diff and __git_log into a variable, and complete them in
> __git_show too.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>
> ---
>  contrib/completion/git-completion.bash |   36 ++++++++++++++++++-------------
>  1 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 096603b..bfae953 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -773,14 +773,7 @@ _git_describe ()
>  	__gitcomp "$(__git_refs)"
>  }
>  
> -_git_diff ()
> -{
> -	__git_has_doubledash && return
> -
> -	local cur="${COMP_WORDS[COMP_CWORD]}"
> -	case "$cur" in
> -	--*)
> -		__gitcomp "--cached --stat --numstat --shortstat --summary
> +__git_diff_common_options="--stat --numstat --shortstat --summary
>  			--patch-with-stat --name-only --name-status --color
>  			--no-color --color-words --no-renames --check
>  			--full-index --binary --abbrev --diff-filter=
> @@ -789,9 +782,21 @@ _git_diff ()
>  			--ignore-all-space --exit-code --quiet --ext-diff
>  			--no-ext-diff
>  			--no-prefix --src-prefix= --dst-prefix=
> -			--base --ours --theirs
>  			--inter-hunk-context=
>  			--patience
> +			--raw
> +"
> +
> +_git_diff ()
> +{
> +	__git_has_doubledash && return
> +
> +	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	case "$cur" in
> +	--*)
> +		__gitcomp "--cached --pickaxe-all --pickaxe-regex
> +			--base --ours --theirs
> +			$__git_diff_common_options
>  			"
>  		return
>  		;;
> @@ -977,17 +982,16 @@ _git_log ()
>  			--relative-date --date=
>  			--author= --committer= --grep=
>  			--all-match
> -			--pretty= --name-status --name-only --raw
> +			--pretty=
>  			--not --all
>  			--left-right --cherry-pick
>  			--graph
> -			--stat --numstat --shortstat
> -			--decorate --diff-filter=
> -			--color-words --walk-reflogs
> +			--decorate
> +			--walk-reflogs
>  			--parents --children --full-history
>  			--merge
>  			--inter-hunk-context=
> -			--patience
> +			$__git_diff_common_options
>  			--pickaxe-all --pickaxe-regex
>  			"

I'll tweak this part to drop duplicated --ihc; other than that it looked
good.  Thanks.
