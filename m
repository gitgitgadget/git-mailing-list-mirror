From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn clone -s was not prefixing 'branches/'
Date: Sat, 17 Jan 2009 02:54:27 -0800
Message-ID: <20090117105427.GA15801@dcvr.yhbt.net>
References: <1232050647-2870-1-git-send-email-snowblink@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Lim <snowblink@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 11:55:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO8qG-0005dc-T1
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 11:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031AbZAQKy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 05:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbZAQKy2
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 05:54:28 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:37033 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529AbZAQKy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 05:54:28 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A021F44D;
	Sat, 17 Jan 2009 10:54:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1232050647-2870-1-git-send-email-snowblink@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106040>

Jonathan Lim <snowblink@gmail.com> wrote:
> All branches in the subversion repository would appear at the same
> level as trunk.  The should now appear with a 'branches/' prefix.
> 
> Signed-off-by: Jonathan Lim <snowblink@gmail.com>

This is too ugly for the common existing cases.  For the rare case where
this could lead to a namespace conflict[1], it's possible to work around
it by editing .git/config.

I would accept a --tags-prefix= and --branches-prefix= patch to make
this possible w/o having to edit .git/config, but I don't want the
default prefixes changed.

Thanks,

[1] - "/branches/trunk" vs "/trunk", which I've yet to see evidence of...

> ---
>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index ad01e18..17d65cb 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -789,7 +789,7 @@ sub cmd_multi_init {
>  	}
>  	return unless defined $_branches || defined $_tags;
>  	my $ra = $url ? Git::SVN::Ra->new($url) : undef;
> -	complete_url_ls_init($ra, $_branches, '--branches/-b', $_prefix);
> +	complete_url_ls_init($ra, $_branches, '--branches/-b', $_prefix . 'branches/');
>  	complete_url_ls_init($ra, $_tags, '--tags/-t', $_prefix . 'tags/');
>  }
