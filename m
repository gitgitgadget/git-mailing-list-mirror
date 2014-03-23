From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 04/28] Allow "guilt import-commit" to run from a dir
 which contains spaces.
Date: Sun, 23 Mar 2014 13:04:09 -0400
Message-ID: <20140323170409.GG1661@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-5-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 18:04:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRloX-0004W5-CU
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 18:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbaCWRD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 13:03:56 -0400
Received: from josefsipek.net ([64.9.206.49]:1707 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477AbaCWRDz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 13:03:55 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 6EDA8554D8;
	Sun, 23 Mar 2014 13:03:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-5-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244794>

On Fri, Mar 21, 2014 at 08:31:42AM +0100, Per Cederqvist wrote:
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-import-commit | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/guilt-import-commit b/guilt-import-commit
> index 20dcee2..9488ded 100755
> --- a/guilt-import-commit
> +++ b/guilt-import-commit
> @@ -23,7 +23,7 @@ if ! must_commit_first; then
>  fi
>  
>  disp "About to begin conversion..." >&2
> -disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
> +disp "Current head: `cat \"$GIT_DIR\"/refs/heads/\`git_branch\``" >&2

I wonder if it'd be better to use 'git rev-parse' here instead of looking at
the refs directly.

IOW,

disp "Current head: `git rev-parse \`git_branch\``" >&2

Maybe even $() instead of the inner `` to clean it up some more.

Jeff.

>  
>  for rev in `git rev-list $rhash`; do
>  	s=`git log --pretty=oneline -1 $rev | cut -c 42-`
> @@ -46,7 +46,7 @@ for rev in `git rev-list $rhash`; do
>  		do_make_header $rev
>  		echo ""
>  		git diff --binary $rev^..$rev
> -	) > $GUILT_DIR/$branch/$fname
> +	) > "$GUILT_DIR/$branch/$fname"
>  
>  	# FIXME: grab the GIT_AUTHOR_DATE from the commit object and set the
>  	# timestamp on the patch
> @@ -68,6 +68,6 @@ for rev in `git rev-list $rhash`; do
>  done
>  
>  disp "Done." >&2
> -disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
> +disp "Current head: `cat \"$GIT_DIR\"/refs/heads/\`git_branch\``" >&2
>  
>  }
> -- 
> 1.8.3.1
> 

-- 
It used to be said [...] that AIX looks like one space alien discovered
Unix, and described it to another different space alien who then implemented
AIX. But their universal translators were broken and they'd had to gesture a
lot.
		- Paul Tomblin 
