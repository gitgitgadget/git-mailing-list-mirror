From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cloning from a repo without "current branch"
Date: Sat, 16 Jun 2007 20:41:39 -0700
Message-ID: <7vbqff1c3w.fsf@assigned-by-dhcp.pobox.com>
References: <200706162226.l5GMQBss004492@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 05:41:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzle6-0005jT-U8
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 05:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758590AbXFQDll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 23:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbXFQDlk
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 23:41:40 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42755 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbXFQDlk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 23:41:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070617034138.SUBL3133.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Jun 2007 23:41:38 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CThf1X0051kojtg0000000; Sat, 16 Jun 2007 23:41:39 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50331>

Nanako Shiraishi <nanako3@bluebottle.com> writes:

> diff --git a/git-clone.sh b/git-clone.sh
> index 3a41062..bd44ce1 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -377,6 +377,13 @@ then
>  		)
>  	)
>  
> +	# Upstream URL
> +	git-config remote."$origin".url "$repo" &&
> +
> +	# Set up the mappings to track the remote branches.
> +	git-config remote."$origin".fetch \
> +		"+refs/heads/*:$remote_top/*" '^$' &&
> +
>  	# Write out remote.$origin config, and update our
> "$head_points_at".
>  	case "$head_points_at" in
>  	?*)

Whitespace breakage?

> @@ -384,21 +391,20 @@ then
>  		git-symbolic-ref HEAD "refs/heads/$head_points_at" &&
>  
>  		# Tracking branch for the primary branch at the remote.
> -		origin_track="$remote_top/$head_points_at" &&
>  		git-update-ref HEAD "$head_sha1" &&
>  
> -		# Upstream URL
> -		git-config remote."$origin".url "$repo" &&
> -
> -		# Set up the mappings to track the remote branches.
> -		git-config remote."$origin".fetch \
> -			"+refs/heads/*:$remote_top/*" '^$' &&
>  		rm -f "refs/remotes/$origin/HEAD"
>  		git-symbolic-ref "refs/remotes/$origin/HEAD" \
>  			"refs/remotes/$origin/$head_points_at" &&
>  
>  		git-config branch."$head_points_at".remote "$origin" &&
>  		git-config branch."$head_points_at".merge
> "refs/heads/$head_points_at"
> +		;;

Again...?

> +	'')
> +		# Source had detached HEAD pointing nowhere
> +		git-update-ref --no-deref HEAD "$head_sha1" &&
> +		rm -f "refs/remotes/$origin/HEAD"
> +		;;
>  	esac
>  
>  	case "$no_checkout" in
> -- 
> 1.5.2
