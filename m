From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH] guilt: force the use of bare branches
Date: Tue, 21 May 2013 23:29:47 -0400
Message-ID: <20130522032946.GA101217@meili.valhalla.31bits.net>
References: <1369191357-6777-1-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed May 22 05:39:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeztE-0001kV-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 05:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab3EVDi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 23:38:56 -0400
Received: from josefsipek.net ([64.9.206.49]:1608 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754695Ab3EVDiz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 23:38:55 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2013 23:38:55 EDT
Received: from meili.valhalla.31bits.net (c-68-62-19-111.hsd1.mi.comcast.net [68.62.19.111])
	by josefsipek.net (Postfix) with ESMTPSA id 3E072185C;
	Tue, 21 May 2013 23:29:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1369191357-6777-1-git-send-email-tytso@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225126>

On Tue, May 21, 2013 at 10:55:57PM -0400, Theodore Ts'o wrote:
> To make it harder to accidentally do "git push" with a guilt patch
> applied, "guilt push" changes branch from e.g. "master" to
> "guilt/master" starting with commit 67d3af63f422.  This is a feature
> which I use for ext4 development; I actually *do* want to be able to
> push patches to the dev branch, which is a rewindable branch much like
> git's "pu" branch.
> 
> Allow the use of the environment variable GUILT_FORCE_BARE_BRANCH
> which disables the new behavior introduced by commit 67d3af63f422.

Would it make sense to make it git-config-able instead?  As an added bonus,
one can then make the decision on per-repository basis.

Jeff.

> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Per Cederqvist <cederp@opera.com>
> ---
>  guilt | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/guilt b/guilt
> index 309437a..9953bdf 100755
> --- a/guilt
> +++ b/guilt
> @@ -914,13 +914,22 @@ else
>  	die "Unsupported operating system: $UNAME_S"
>  fi
>  
> -if [ "$branch" = "$raw_git_branch" ] && [ -n "`get_top 2>/dev/null`" ]
> -then
> -    # This is for compat with old repositories that still have a
> -    # pushed patch without the new-style branch prefix.
> +if [ -n "`get_top 2>/dev/null`" ]; then
> +  #
> +  # If we have repositories patches pushed, then use whatever scheme
> +  # is currently in use
> +  #
> +  if [ "$branch" = "$raw_git_branch" ]; then
>      old_style_prefix=true
> +  else
> +    old_style_prefix=false
> +  fi
>  else
> +  if [ -n "$GUILT_FORCE_BARE_BRANCH" ]; then
> +    old_style_prefix=true
> +  else
>      old_style_prefix=false
> +  fi
>  fi
>  
>  _main "$@"
> -- 
> 1.7.12.rc0.22.gcdd159b
> 

-- 
Linux, n.:
  Generous programmers from around the world all join forces to help
  you shoot yourself in the foot for free. 
