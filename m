From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Adapt tutorial to cygwin and add test case
Date: Tue, 11 Oct 2005 12:57:44 -0700
Message-ID: <7vu0fnsu6f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510111333160.27109@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 22:00:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPQFz-0001pD-Oq
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 21:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVJKT5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 15:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVJKT5s
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 15:57:48 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:14011 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751087AbVJKT5s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 15:57:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051011195724.EBEI2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Oct 2005 15:57:24 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9983>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> -And this is where we start using the `.git/HEAD` file. The `HEAD` file is
> +And this is where we create the `.git/refs/heads/master` file. This file is
>  supposed to contain the reference to the top-of-tree, and since that's
>  exactly what `git-commit-tree` spits out, we can do this all with a simple
>  shell pipeline:
>  
>  ------------------------------------------------
> -echo "Initial commit" | git-commit-tree $(git-write-tree) > .git/HEAD
> +echo "Initial commit" | \
> +	git-commit-tree $(git-write-tree) > .git/refs/heads/master
>  ------------------------------------------------

Hmm.  This is not wrong, but does not feel right.  The point we
are explaining here is that there is a HEAD pointer that knows
about the current branch, and after making a commit, we update
it to record the new tip of the branch.

The Kosher way would be

    tree=$(git-write-tree)
    commit=$(echo 'Initial commit' | git-commit-tree $tree)
    git-update-ref HEAD $(commit)

but looks quite intimidating as a tutorial material.  

> @@ -691,7 +695,9 @@ other point in the history than the curr
>  just telling `git checkout` what the base of the checkout would be.
>  In other words, if you have an earlier tag or branch, you'd just do
>  
> -	git checkout -b mybranch earlier-commit
> +------------
> +git checkout -b mybranch earlier-commit
> +------------

The original was both ugly and did not use boxquote.  There is
no excuse for ugliness, but not using boxquote was for a
reason.  The boxquoted "type this" examples were not to be
missed, lest the later steps we explain would either not work or
would produce results that is different from what we show.  This
particular step is "if you were doing something different, you
would do this", implying "but do not do that here if you are
following the tutorial steps because that is not what we are
doing here".  Maybe we should use boxquote but make an explicit
comment that this is a tangent here?

> @@ -699,17 +705,29 @@ and check out the state at that time.
>  
>  You can always just jump back to your original `master` branch by doing
>  
> -	git checkout master
> +------------
> +git checkout master
> +------------

Same here.

> @@ -870,8 +889,10 @@ Now, let's pretend you are the one who d
>  to the `master` branch. Let's go back to `mybranch`, and run
>  resolve to get the "upstream changes" back to your branch.
>  
> -	git checkout mybranch
> -	git resolve HEAD master "Merge upstream changes."
> +------------
> +git checkout mybranch
> +git resolve HEAD master "Merge upstream changes."
> +------------

But not here.

> diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
> new file mode 100644
> index 0000000..35db799

This is an extremely good addition, thanks.
