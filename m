From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 1/3] cg-admin-rewritehist: catch git-rev-list returning no commit
Date: Sun, 18 Jun 2006 01:21:43 +0200
Message-ID: <20060617232143.GN11941@pasky.or.cz>
References: <20060611120431.12116.74005.stgit@gandelf.nowhere.earth> <20060611120459.12116.87606.stgit@gandelf.nowhere.earth> <20060611120431.12116.74005.stgit@gandelf.nowhere.earth> <20060611120457.12116.81253.stgit@gandelf.nowhere.earth> <20060611120431.12116.74005.stgit@gandelf.nowhere.earth> <20060611120455.12116.14042.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 01:21:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frk65-0008Nq-3L
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 01:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWFQXUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 19:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWFQXUm
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 19:20:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30593 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750987AbWFQXUl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 19:20:41 -0400
Received: (qmail 22459 invoked by uid 2001); 18 Jun 2006 01:21:43 +0200
To: Yann Dirson <ydirson@altern.org>
Content-Disposition: inline
In-Reply-To: <20060611120459.12116.87606.stgit@gandelf.nowhere.earth> <20060611120457.12116.81253.stgit@gandelf.nowhere.earth> <20060611120455.12116.14042.stgit@gandelf.nowhere.earth>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22041>

Dear diary, on Sun, Jun 11, 2006 at 02:04:55PM CEST, I got a letter
where Yann Dirson <ydirson@altern.org> said that...
> Signed-off-by: Yann Dirson <ydirson@altern.org>
> ---
> 
>  cg-admin-rewritehist |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/cg-admin-rewritehist b/cg-admin-rewritehist
> index 861c7f6..fe3f210 100755
> --- a/cg-admin-rewritehist
> +++ b/cg-admin-rewritehist
> @@ -199,6 +199,10 @@ done
>  git-rev-list --topo-order HEAD $startrev | tac >../revs
>  commits=$(cat ../revs | wc -l)
>  
> +if [ $commits -eq 0 ]; then
> +    die "Found nothing to rewrite"
> +fi
> +
>  i=0
>  while read commit; do
>  	i=$((i+1))

Thanks, applied.

Dear diary, on Sun, Jun 11, 2006 at 02:04:57PM CEST, I got a letter
where Yann Dirson <ydirson@altern.org> said that...
> Signed-off-by: Yann Dirson <ydirson@altern.org>
> ---
> 
>  cg-admin-rewritehist |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/cg-admin-rewritehist b/cg-admin-rewritehist
> index fe3f210..7cbdb30 100755
> --- a/cg-admin-rewritehist
> +++ b/cg-admin-rewritehist
> @@ -154,6 +154,8 @@ while optparse; do
>  	if optparse -d=; then
>  		tempdir="$OPTARG"
>  	elif optparse -r=; then
> +		git-rev-parse "$OPTARG" >/dev/null || die "Unknown revision '$OPTARG'"
> +		git-rev-parse "$OPTARG^" >/dev/null || die "Revision '$OPTARG' does not have parents, check what you really want"
>  		startrev="^$OPTARG^ $OPTARG $startrev"
>  		startrevparents="$OPTARG $startrevparents"
>  	elif optparse --env-filter=; then

Thanks, I've adapted it to the current codebase.

Dear diary, on Sun, Jun 11, 2006 at 02:05:00PM CEST, I got a letter
where Yann Dirson <ydirson@altern.org> said that...
> This is a fix for 95621e54cedef1c4a270af5570a72fc1331b5fcb.
> 
> Signed-off-by: Yann Dirson <ydirson@altern.org>
> ---
> 
>  cg-admin-rewritehist |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/cg-admin-rewritehist b/cg-admin-rewritehist
> index 7cbdb30..6dd8b92 100755
> --- a/cg-admin-rewritehist
> +++ b/cg-admin-rewritehist
> @@ -157,7 +157,7 @@ while optparse; do
>  		git-rev-parse "$OPTARG" >/dev/null || die "Unknown revision '$OPTARG'"
>  		git-rev-parse "$OPTARG^" >/dev/null || die "Revision '$OPTARG' does not have parents, check what you really want"
>  		startrev="^$OPTARG^ $OPTARG $startrev"
> -		startrevparents="$OPTARG $startrevparents"
> +		startrevparents="$OPTARG^ $startrevparents"
>  	elif optparse --env-filter=; then
>  		filter_env="$OPTARG"
>  	elif optparse --tree-filter=; then

Thanks; I've already applied a patch similar in spirit from someone
else.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
