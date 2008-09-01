From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: catch lack of upstream info for dcommit earlier
Date: Sun, 31 Aug 2008 20:26:57 -0700
Message-ID: <20080901032657.GC25876@hand.yhbt.net>
References: <c7d83d0d0808310029s15c1413m49cad5c68a568271@mail.gmail.com> <1220190659-5955-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Sep 01 05:28:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka05M-0002GN-Pg
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 05:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbYIAD07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 23:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbYIAD07
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 23:26:59 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35022 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbYIAD06 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 23:26:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id C4C092DC01B;
	Sun, 31 Aug 2008 20:26:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1220190659-5955-1-git-send-email-trast@student.ethz.ch>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94525>

Thomas Rast <trast@student.ethz.ch> wrote:
> Since 711521e 'git svn dcommit' attempts to use the upstream
> information to determine the SVN URL, before it verifies that it even
> found an upstream.  Move up the corresponding check.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Thanks,

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
> 
> Weyert de Boer wrote:
> > Can't call method "full_url" on an undefined value at
> > /opt/local/libexec/git-core/git-svn line 425.
> 
> After resolving the problem on IRC, here's the fix to avoid the
> unhelpful message.
> 
> 
>  git-svn.perl |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 7a1d26d..43bf201 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -421,15 +421,15 @@ sub cmd_dcommit {
>  	$head ||= 'HEAD';
>  	my @refs;
>  	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
> +	unless ($gs) {
> +		die "Unable to determine upstream SVN information from ",
> +		    "$head history.\nPerhaps the repository is empty.";
> +	}
>  	$url = defined $_commit_url ? $_commit_url : $gs->full_url;
>  	my $last_rev = $_revision if defined $_revision;
>  	if ($url) {
>  		print "Committing to $url ...\n";
>  	}
> -	unless ($gs) {
> -		die "Unable to determine upstream SVN information from ",
> -		    "$head history.\nPerhaps the repository is empty.";
> -	}
>  	my ($linear_refs, $parents) = linearize_history($gs, \@refs);
>  	if ($_no_rebase && scalar(@$linear_refs) > 1) {
>  		warn "Attempting to commit more than one change while ",
> -- 
> 1.6.0.1.278.g5a622
