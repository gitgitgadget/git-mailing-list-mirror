From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: Fix merge detecting with rewrite-root
Date: Fri, 26 Feb 2010 01:43:17 -0800
Message-ID: <20100226094317.GA22579@dcvr.yhbt.net>
References: <1267034942-31581-1-git-send-email-tuomas.suutari@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>,
	Tuomas Suutari <tuomas.suutari@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 10:43:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkwjF-0007Lt-G2
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 10:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935722Ab0BZJnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 04:43:19 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36739 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935739Ab0BZJnS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 04:43:18 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 206501F488;
	Fri, 26 Feb 2010 09:43:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1267034942-31581-1-git-send-email-tuomas.suutari@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141118>

Tuomas Suutari <tuomas.suutari@gmail.com> wrote:
> Detecting of merges from svn:mergeinfo or svk merge tickets failed
> with rewrite-root option. This fixes it.
> 
> Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>
> ---
> Hi again,
> 
> now I found another problem while importing SVN repo with git-svn.
> 
> To speed-up the import, I copied the SVN repo with rsync to localhost
> and used file:// URL for the import, but because I want to be able to
> track the history with svn+ssh:// later, I used the rewrite-root
> option. That seemed to break the merge detecting.
> 
> With this patch the merge detecting works also with rewrite-root
> option, but since there are no comments why the $self->rewrite_root
> was used in the first place, I have no idea, if this is the right
> thing to do.

Hi Tuomas,

I'm not sure why rewrite_root is used here, either.  Ignoring it
seems correct but I'll wait for Sam to chime in.

>  git-svn.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 265852f..1cbddca 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2993,7 +2993,7 @@ sub find_extra_svk_parents {
>  	for my $ticket ( @tickets ) {
>  		my ($uuid, $path, $rev) = split /:/, $ticket;
>  		if ( $uuid eq $self->ra_uuid ) {
> -			my $url = $self->rewrite_root || $self->{url};
> +			my $url = $self->{url};
>  			my $repos_root = $url;
>  			my $branch_from = $path;
>  			$branch_from =~ s{^/}{};
> @@ -3201,7 +3201,7 @@ sub find_extra_svn_parents {
>  	# are now marked as merge, we can add the tip as a parent.
>  	my @merges = split "\n", $mergeinfo;
>  	my @merge_tips;
> -	my $url = $self->rewrite_root || $self->{url};
> +	my $url = $self->{url};
>  	my $uuid = $self->ra_uuid;
>  	my %ranges;
>  	for my $merge ( @merges ) {
> -- 
> 1.7.0.2.ged48
