From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 5/5] rebase -i: avoid exporting GIT_AUTHOR_* variables
Date: Wed, 26 Sep 2007 12:33:50 +0200
Message-ID: <46FA358E.40500@viscovery.net>
References: <Pine.LNX.4.64.0709251640360.28395@racer.site> <Pine.LNX.4.64.0709251643310.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 12:34:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaUDS-00019O-W1
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 12:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbXIZKd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 06:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754808AbXIZKdz
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 06:33:55 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:53027 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbXIZKdz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 06:33:55 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IaUDH-00016A-6U; Wed, 26 Sep 2007 12:33:51 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9CDAC54D; Wed, 26 Sep 2007 12:33:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709251643310.28395@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5, UPPERCASE_25_50=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59222>

Johannes Schindelin schrieb:
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 445a299..e3e89dd 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -174,7 +174,11 @@ pick_one_preserving_merges () {
>  			eval "$author_script"
>  			msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
>  			# NEEDSWORK: give rerere a chance
> -			if ! output git merge $STRATEGY -m "$msg" $new_parents
> +			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
> +				GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
> +				GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
> +				output git merge $STRATEGY -m "$msg" \
> +					$new_parents
>  			then
>  				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
>  				die Error redoing merge $sha1
> @@ -281,7 +285,9 @@ do_next () {
>  		f)
>  			# This is like --amend, but with a different message
>  			eval "$author_script"
> -			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
> +			GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
> +			GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
> +			GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
>  			$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
>  			;;
>  		t)

According to Herbert Xu's recent post 
(http://article.gmane.org/gmane.comp.version-control.git/59219) this won't 
export the variables in all shells since 'output' is a shell function. :-(

-- Hannes
