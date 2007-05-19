From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Fix "Use of uninitialized value" warning in git_feed
Date: Fri, 18 May 2007 18:45:25 -0700
Message-ID: <7vtzu937t6.fsf@assigned-by-dhcp.cox.net>
References: <1179535671566-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 03:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpE0n-0006VH-UN
	for gcvg-git@gmane.org; Sat, 19 May 2007 03:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbXESBp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 21:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbXESBp1
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 21:45:27 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42482 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbXESBp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 21:45:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519014527.DLGV15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 18 May 2007 21:45:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0plR1X00E1kojtg0000000; Fri, 18 May 2007 21:45:25 -0400
In-Reply-To: <1179535671566-git-send-email-jnareb@gmail.com> (Jakub Narebski's
	message of "Sat, 19 May 2007 02:47:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47703>

Jakub Narebski <jnareb@gmail.com> writes:

> Initial (root) commit has no parents, and $co{'parent'} is
> undefined. Use '--root' for initial commit.
>
> This fixes "Use of uninitialized value in open at gitweb/gitweb.perl
> line 4925." warning.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index fa8cc02..091cf9c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4923,7 +4923,8 @@ XML
>  
>  		# get list of changed files
>  		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
> -			$co{'parent'}, $co{'id'}, "--", (defined $file_name ? $file_name : ())
> +			$co{'parent'} || "--root",
> +			$co{'id'}, "--", (defined $file_name ? $file_name : ())
>  			or next;
>  		my @difftree = map { chomp; $_ } <$fd>;
>  		close $fd

I do not think you would need to make --root conditional...
