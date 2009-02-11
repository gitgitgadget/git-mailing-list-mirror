From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/3] completion: More fixes to prevent unbound variable
	errors.
Date: Wed, 11 Feb 2009 08:28:14 -0800
Message-ID: <20090211162814.GH30949@spearce.org>
References: <1234366634-17900-4-git-send-email-ted@tedpavlic.com> <1234369132-22063-1-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 17:29:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHy2-0007Z8-Od
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 17:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152AbZBKQ2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 11:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756161AbZBKQ2Q
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 11:28:16 -0500
Received: from george.spearce.org ([209.20.77.23]:43097 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756152AbZBKQ2P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 11:28:15 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D26A038211; Wed, 11 Feb 2009 16:28:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234369132-22063-1-git-send-email-ted@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109440>

Ted Pavlic <ted@tedpavlic.com> wrote:
> Several functions make use of "test -n" and "test -z". In many cases,
> the variables being tested were declared with "local." However, several
> __variables are not, and so they must be replaced with their ${__-}
> equivalents.
> 
> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
> ---
> 
> This patch depends on:
> 
>     <1234366634-17900-3-git-send-email-ted@tedpavlic.com>
>     "[PATCH 2/3] completion: Change "if [...]" to "if test ..." to 
>                              match git convention"
> 
> If that patch is not applied, I can submit a new patch.

Looks OK to me, but I NAK'd the dependency, so you'll have to rebase
it without the dependency in there.  Or talk me into why that much
churn is a good thing.

 
>  contrib/completion/git-completion.bash |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ffde82a..055e4ac 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -62,7 +62,7 @@ esac
>  __gitdir ()
>  {
>  	if test -z "${1-}"; then
> -		if test -n "$__git_dir"; then
> +		if test -n "${__git_dir-}"; then
>  			echo "$__git_dir"
>  		elif test -d .git; then
>  			echo .git
> @@ -294,7 +294,7 @@ __git_remotes ()
>  
>  __git_merge_strategies ()
>  {
> -	if test -n "$__git_merge_strategylist"; then
> +	if test -n "${__git_merge_strategylist-}"; then
>  		echo "$__git_merge_strategylist"
>  		return
>  	fi
> @@ -380,7 +380,7 @@ __git_complete_revlist ()
>  
>  __git_all_commands ()
>  {
> -	if test -n "$__git_all_commandlist"; then
> +	if test -n "${__git_all_commandlist-}"; then
>  		echo "$__git_all_commandlist"
>  		return
>  	fi
> @@ -398,7 +398,7 @@ __git_all_commandlist="$(__git_all_commands 2>/dev/null)"
>  
>  __git_porcelain_commands ()
>  {
> -	if test -n "$__git_porcelain_commandlist"; then
> +	if test -n "${__git_porcelain_commandlist-}"; then
>  		echo "$__git_porcelain_commandlist"
>  		return
>  	fi
> -- 
> 1.6.1.2.390.gba743
> 

-- 
Shawn.
