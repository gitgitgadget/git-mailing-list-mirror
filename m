From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: check_cherry_pick should exclude commits
	already in our history
Date: Thu, 2 Sep 2010 14:47:55 -0700
Message-ID: <20100902214707.GA2761@dcvr.yhbt.net>
References: <1283446008-10858-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Steven Walter <swalter@lpdev.prtdev.lexmark.com>,
	Sam Vilain <sam@vilain.net>
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 23:48:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrHdZ-00079W-SZ
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 23:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab0IBVr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 17:47:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36246 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626Ab0IBVrz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 17:47:55 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 751F01F4F3;
	Thu,  2 Sep 2010 21:47:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1283446008-10858-1-git-send-email-stevenrwalter@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155212>

Steven Walter <stevenrwalter@gmail.com> wrote:
> From: Steven Walter <swalter@lpdev.prtdev.lexmark.com>
> 
> The merge-base between @$parents and $merge_tip may have been reached
> through a merge commit.  This means that some commits that are ancestors
> of @$parents will not be ancestors of $merge_base.  The mergeinfo
> property will not list commits that are ancestors of @$parents, so we
> need to explicitly exclude them.

Thanks Steven, looks reasonable to me.  Sign-off?

Sam: any objections?

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 7a72f75..70edf80 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3087,9 +3087,10 @@ sub _rev_list {
>  sub check_cherry_pick {
>  	my $base = shift;
>  	my $tip = shift;
> +	my $parents = shift;
>  	my @ranges = @_;
>  	my %commits = map { $_ => 1 }
> -		_rev_list("--no-merges", $tip, "--not", $base);
> +		_rev_list("--no-merges", $tip, "--not", $base, @$parents);
>  	for my $range ( @ranges ) {
>  		delete @commits{_rev_list($range)};
>  	}
> @@ -3249,6 +3250,7 @@ sub find_extra_svn_parents {
>  		# double check that there are no missing non-merge commits
>  		my (@incomplete) = check_cherry_pick(
>  			$merge_base, $merge_tip,
> +			$parents,
>  			@$ranges,
>  		       );
>  
> -- 
