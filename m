From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] svn-git: Use binmode for reading/writing binary rev maps
Date: Tue, 22 Apr 2008 16:21:51 -0700
Message-ID: <20080422232151.GA3532@hand.yhbt.net>
References: <20080418131204.GA53634@roadkill.foldr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Weber <michaelw@foldr.org>
X-From: git-owner@vger.kernel.org Wed Apr 23 01:22:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoRow-0002Zg-US
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 01:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbYDVXVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 19:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbYDVXVy
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 19:21:54 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59790 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbYDVXVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 19:21:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 5E2FE2DC08B;
	Tue, 22 Apr 2008 16:21:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080418131204.GA53634@roadkill.foldr.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80172>

Michael Weber <michaelw@foldr.org> wrote:
> Otherwise, there is a possible interaction with UTF-8 locales in
> combination with PERL_UNICODE, resulting in "inconsistent size: 40" or
> "read:"-type errors.
> 
> See also:
> perldoc -f binmode
> <http://perldoc.perl.org/perl581delta.html#UTF-8-no-longer-default-under-UTF-8-locales>
> 
> Signed-off-by: Michael Weber <michaelw@foldr.org>

Thanks, sorry for the latency.

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index b864b54..3d80b23 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2519,6 +2519,7 @@ sub rebuild_from_rev_db {
>  	my ($self, $path) = @_;
>  	my $r = -1;
>  	open my $fh, '<', $path or croak "open: $!";
> +	binmode $fh or croak "binmode: $!";
>  	while (<$fh>) {
>  		length($_) == 41 or croak "inconsistent size in ($_) != 41";
>  		chomp($_);
> @@ -2616,6 +2617,7 @@ sub rebuild {
>  sub _rev_map_set {
>  	my ($fh, $rev, $commit) = @_;
>  
> +	binmode $fh or croak "binmode: $!";
>  	my $size = (stat($fh))[7];
>  	($size % 24) == 0 or croak "inconsistent size: $size";
>  
> @@ -2719,6 +2721,7 @@ sub rev_map_max {
>  	my $map_path = $self->map_path;
>  	stat $map_path or return $want_commit ? (0, undef) : 0;
>  	sysopen(my $fh, $map_path, O_RDONLY) or croak "open: $!";
> +	binmode $fh or croak "binmode: $!";
>  	my $size = (stat($fh))[7];
>  	($size % 24) == 0 or croak "inconsistent size: $size";
>  
> @@ -2751,6 +2754,7 @@ sub rev_map_get {
>  	return undef unless -e $map_path;
>  
>  	sysopen(my $fh, $map_path, O_RDONLY) or croak "open: $!";
> +	binmode $fh or croak "binmode: $!";
>  	my $size = (stat($fh))[7];
>  	($size % 24) == 0 or croak "inconsistent size: $size";
>  
> -- 
