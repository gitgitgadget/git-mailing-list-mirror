From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: sanitize_remote_name should accept underscores.
Date: Tue, 24 Jun 2008 23:44:35 -0700
Message-ID: <20080625064435.GL21299@hand.yhbt.net>
References: <1214322898-9272-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 08:45:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBOlN-0005Gt-QF
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 08:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbYFYGoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 02:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbYFYGoh
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 02:44:37 -0400
Received: from hand.yhbt.net ([66.150.188.102]:39384 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbYFYGog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 02:44:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id DBCBC2DC095;
	Tue, 24 Jun 2008 23:44:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1214322898-9272-1-git-send-email-apenwarr@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86243>

Avery Pennarun <apenwarr@gmail.com> wrote:
> Without this patch, git-svn failed with the error:
>  config --get svn-remote.D2007.Win32.url: command returned error: 1
> 
> ...upon trying to automatically follow a link from a child branch back to
> its parent branch D2007_Win32 (note the underscore, not dot, separating the
> two words).
> 
> Note that I have each of my branches defined (by hand) as separate
> svn-remote entries in .git/config since my svn repository layout is
> nonstandard.
> 
> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>

Thanks,

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
> I'm not sure why sanitize_remote_name is so picky about allowed characters,
> but underscore should certainly be allowed.  I'm worried that this has
> revealed a more serious problem, since presumably sanitizing the name
> shouldn't break anything in any case.

Weird.  It looks like a stupid bug on my part.  I'm surprised
it took this long to find, since underscore is pretty common...

> ---
>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 4c9c59b..263d66c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1465,7 +1465,7 @@ sub verify_remotes_sanity {
>  # we allow more chars than remotes2config.sh...
>  sub sanitize_remote_name {
>  	my ($name) = @_;
> -	$name =~ tr{A-Za-z0-9:,/+-}{.}c;
> +	$name =~ tr{A-Za-z0-9:,_/+-}{.}c;
>  	$name;
>  }
>  
> -- 
> 1.5.6.56.g29b0d
