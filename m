From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/3] instaweb: use 'browser.<tool>.path' config option if it's set.
Date: Tue, 29 Jan 2008 00:46:18 -0800
Message-ID: <20080129084618.GA15141@hand.yhbt.net>
References: <20080129070844.30781cd3.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 09:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJm7I-0008PU-2w
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 09:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbYA2IqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 03:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbYA2IqV
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 03:46:21 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60223 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbYA2IqU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 03:46:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 678122DC08B;
	Tue, 29 Jan 2008 00:46:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080129070844.30781cd3.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71966>

Christian Couder <chriscool@tuxfamily.org> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Thanks Christian,

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  Documentation/config.txt |    3 ++-
>  git-instaweb.sh          |   10 +++++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 477b2d9..4e222f1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -369,7 +369,8 @@ branch.<name>.rebase::
>  
>  browser.<tool>.path::
>  	Override the path for the given tool that may be used to
> -	browse HTML help. See '-w' option in linkgit:git-help[1].
> +	browse HTML help (see '-w' option in linkgit:git-help[1]) or a
> +	working repository in gitweb (see linkgit:git-instaweb[1]).
>  
>  clean.requireForce::
>  	A boolean to make git-clean do nothing unless given -f
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index ad0723c..3e4452b 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -274,6 +274,14 @@ webrick)
>  	;;
>  esac
>  
> +init_browser_path() {
> +	browser_path="`git config browser.$1.path`"
> +	test -z "$browser_path" && browser_path="$1"
> +}
> +
>  start_httpd
>  url=http://127.0.0.1:$port
> -test -n "$browser" && "$browser" $url || echo $url
> +test -n "$browser" && {
> +	init_browser_path "$browser"
> +	"$browser_path" $url
> +} || echo $url
> -- 
> 1.5.4.rc1.24.gf78d
