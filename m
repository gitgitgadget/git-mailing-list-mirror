From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] display the subject of the commit just made
Date: Sun, 15 Apr 2007 22:16:24 -0700
Message-ID: <7vwt0cx5jr.fsf@assigned-by-dhcp.cox.net>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
	<20070404070135.GF31984@mellanox.co.il>
	<7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
	<20070415223909.GG15208@mellanox.co.il>
	<7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
	<20070416035325.GA20304@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Apr 16 07:16:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdJZm-0004Lc-4t
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 07:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbXDPFQ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 01:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733AbXDPFQ1
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 01:16:27 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62821 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687AbXDPFQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 01:16:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416051625.PQPA1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 01:16:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id nhGQ1W0051kojtg0000000; Mon, 16 Apr 2007 01:16:24 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44580>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> Better?
>
> diff --git a/git-commit.sh b/git-commit.sh
> index 9e0959a..32257b0 100755
> --- a/git-commit.sh
> +++ b/git-commit.sh
> @@ -649,8 +649,9 @@ then
>  	fi
>  	if test -z "$quiet"
>  	then
> +		commit=`git-diff-tree --shortstat --pretty="format:%h: %s"\
> +		       --summary --root HEAD --`
>  		echo "Created${initial_commit:+ initial} commit $commit"
> -		git-diff-tree --shortstat --summary --root --no-commit-id HEAD --
>  	fi
>  fi

Close but no cigar.  You broke it for a merge commit, I think.

Perhaps

	pretty="format:Created${initial_commit:+ initial} commit %h: %s%n"
	git-diff-tree --always --shortstart --summary --root --pretty="$pretty" HEAD
