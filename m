From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn - return original format_svn_date semantics
Date: Fri, 27 Feb 2009 19:22:19 -0800
Message-ID: <20090228032219.GA28606@dcvr.yhbt.net>
References: <1235790705-12903-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sat Feb 28 04:24:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdFoR-0001im-VP
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 04:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbZB1DWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 22:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbZB1DWV
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 22:22:21 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:34975 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbZB1DWU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 22:22:20 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 542791F799;
	Sat, 28 Feb 2009 03:22:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1235790705-12903-1-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111743>

Ben Walton <bwalton@artsci.utoronto.ca> wrote:
> When %z was removed from the strftime call and subsituted with a
> local gmt offset calculation, time() was no longer the default for
> all time functions as it was with the previous localtime(shift).
> This is now corrected so that format_svn_time behaves as it used to.
> 
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>

Thanks Ben,

I'm pretty sure there's another bug lurking in there with the "info"
command, but this should at least cleanup the output as a stopgap
measure until somebody has time to properly fix it.

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index d967594..55702d0 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -4738,7 +4738,7 @@ sub run_pager {
>  
>  sub format_svn_date {
>  	# some systmes don't handle or mishandle %z, so be creative.
> -	my $t = shift;
> +	my $t = shift || time;
>  	my $gm = timelocal(gmtime($t));
>  	my $sign = qw( + + - )[ $t <=> $gm ];
>  	my $gmoff = sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
> -- 
> 1.6.0.4
