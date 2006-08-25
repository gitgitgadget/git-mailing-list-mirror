From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] cg-commit: Fix a typo that would inhibit running of post-commit script:
Date: Fri, 25 Aug 2006 02:20:13 +0200
Message-ID: <20060825002013.GG2817@diku.dk>
References: <8764giro6t.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 02:20:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGPR2-0001Fx-1j
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 02:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWHYAU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 20:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWHYAU2
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 20:20:28 -0400
Received: from [130.225.96.91] ([130.225.96.91]:43143 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751581AbWHYAU2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 20:20:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id DB66F77000E;
	Fri, 25 Aug 2006 02:20:14 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25290-07; Fri, 25 Aug 2006 02:20:13 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id B8D29770076;
	Fri, 25 Aug 2006 02:20:13 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 8B87C6DF88D; Fri, 25 Aug 2006 02:18:55 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 88885629FB; Fri, 25 Aug 2006 02:20:13 +0200 (CEST)
To: Jim Meyering <jim@meyering.net>
Content-Disposition: inline
In-Reply-To: <8764giro6t.fsf@rho.meyering.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25981>

Jim Meyering <jim@meyering.net> wrote Thu, Aug 24, 2006:
> I tried cg-commit with a commit hook, but the hook never ran.
> The problem was a typo:
> 
> Fix a typo that would inhibit running the post-commit script:
> s/commit-post/post-commit/.

If I remember correctly, historically, the commit-post existed before
the post-commit appeared. You can see that it is documented in the man
page so it is not a typo.

However, this should certainly be updated, but I think a better fix
would be to transitionally warn the user about the existence of the
commit-post hook before using it in favour of post-commit.

> diff --git a/cg-commit b/cg-commit
> index 9d3b1a1..82eea60 100755
> --- a/cg-commit
> +++ b/cg-commit
> @@ -604,15 +604,16 @@ if [ "$newhead" ]; then
>  		branchname="$(cat "$_git/branch-name")"
>  	fi
>  	[ -z "$branchname" ] && [ "$_git_head" != "master" ] && branchname="$_git_head"
> -	if [ -x "$_git/hooks/post-commit" -a ! "$no_hooks" ]; then
> +	post_commit="$_git/hooks/post-commit"
> +	if [ -x "$post_commit" -a ! "$no_hooks" ]; then
>  		if [ "$(git-repo-config --bool cogito.hooks.commit.post.allmerged)" = "true" ]; then
>  			# We just hope that for the initial commit, the user didn't
>  			# manage to install the hook yet.
>  			for merged in $(git-rev-list $newhead ^$oldhead | tac); do
> -				"$_git/hooks/post-commit" "$merged" "$branchname"
> +				"$post_commit" "$merged" "$branchname"
>  			done
>  		else
> -			"$_git/hooks/post-commit" "$newhead" "$branchname"
> +			"$post_commit" "$newhead" "$branchname"
>  		fi
>  	fi

The patch looks more like a refactoring of a previous commit that did
the commit-post -> post-commit replacement.

-- 
Jonas Fonseca
