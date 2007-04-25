From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Ignore usernames in URLs in find_by_url
Date: Wed, 25 Apr 2007 14:01:16 -0700
Message-ID: <20070425210116.GB12375@untitled>
References: <1177530178545-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 23:01:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgoc8-0001Pp-D7
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 23:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbXDYVBV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 17:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbXDYVBV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 17:01:21 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33225 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370AbXDYVBU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 17:01:20 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 192707DC0A0;
	Wed, 25 Apr 2007 14:01:19 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 25 Apr 2007 14:01:16 -0700
Content-Disposition: inline
In-Reply-To: <1177530178545-git-send-email-aroben@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45575>

Adam Roben <aroben@apple.com> wrote:
> Usernames don't matter for the purposes of find_by_url, so always remove them
> before doing any comparisons.
 
> Signed-off-by: Adam Roben <aroben@apple.com>
> ---
>  git-svn.perl |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 90f3bc1..59008cc 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1064,6 +1064,8 @@ sub init_remote_config {
>  
>  sub find_by_url { # repos_root and, path are optional
>  	my ($class, $full_url, $repos_root, $path) = @_;
> +	remove_username($full_url);
> +	remove_username($repos_root) if defined $repos_root;
>  	return undef unless defined $full_url;
	^-- this line should probably be moved up

Otherwise,
Acked-by: Eric Wong <normalperson@yhbt.net>

>  	my $remotes = read_all_remotes();
>  	if (defined $full_url && defined $repos_root && !defined $path) {
> @@ -1072,6 +1074,7 @@ sub find_by_url { # repos_root and, path are optional
>  	}
>  	foreach my $repo_id (keys %$remotes) {
>  		my $u = $remotes->{$repo_id}->{url} or next;
> +		remove_username($u);
>  		next if defined $repos_root && $repos_root ne $u;
>  
>  		my $fetch = $remotes->{$repo_id}->{fetch} || {};
> -- 
> 1.5.2.rc0.16.ge10ca-dirty
-- 
Eric Wong
