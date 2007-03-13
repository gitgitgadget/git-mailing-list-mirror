From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, 2nd version] git-fetch, git-branch: Support local --track via a special remote `.'
Date: Tue, 13 Mar 2007 02:29:26 -0700
Message-ID: <7v4poplceh.fsf@assigned-by-dhcp.cox.net>
References: <45F58A84.2000503@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Tue Mar 13 10:29:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR3Jz-0004dH-Bv
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 10:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965622AbXCMJ32 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 05:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965638AbXCMJ32
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 05:29:28 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54833 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965622AbXCMJ31 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 05:29:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070313092928.SRXG321.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Mar 2007 05:29:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a9VS1W00F1kojtg0000000; Tue, 13 Mar 2007 05:29:27 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42111>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

> 	I hope this is what you meant in your reply to my message.

Almost, except I wouldn't have made this part of fetch_native()
like this:

> diff --git a/git-fetch.sh b/git-fetch.sh
> index b9d7a75..e2a6878 100755
> --- a/git-fetch.sh
> +++ b/git-fetch.sh
> @@ -164,6 +164,12 @@ then
>  fi
>  
>  fetch_native () {
> +  if test "$(get_data_source $remote_nick)" = builtin; then
> +    for name in $(get_remote_fetch_branches "$remote_nick"); do
> +      append_fetch_head $(git-rev-parse "$name") . "$name" "$name" || exit
> +    done
> +    return
> +  fi
>  
>    eval=$(echo "$1" | git-fetch--tool parse-reflist "-")
>    eval "$eval"

but probably would have created another sub, fetch_fake.

> 	I removed completely the configuration variable since it made
> 	no sense to me, either.

I think that is sensible.

Currently the patch is parked at the tip of 'pu' after merging
all the other topics, as the test t9101 seems to expose breakage
in "git pull . remotes/git-svn".
