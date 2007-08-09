From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Documentation/git-svn: Instructions for cloning a git-svn-created repository
Date: Thu, 9 Aug 2007 12:37:59 -0700
Message-ID: <20070809193759.GA4545@untitled>
References: <1186388203181-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 21:38:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJDq4-000377-Dy
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 21:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbXHITi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 15:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbXHITi1
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 15:38:27 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33088 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbXHITi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 15:38:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 0A93C2DC08D;
	Thu,  9 Aug 2007 12:38:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1186388203181-git-send-email-aroben@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55468>

Adam Roben <aroben@apple.com> wrote:
> These instructions tell you how to create a clone of a repository created with
> git-svn, that can in turn be used with git-svn.
> 
> Signed-off-by: Adam Roben <aroben@apple.com>
> ---
> > gitster: (3) you prepare one git-svn managed git repository, allow others to
> > clone it via git, and have each of these cloned git repositories to interact
> > with svn via git-svn -- this third mode of operation is not supported.
> > 
> > spearce: be nice if someone who cared about git-svn supporting (3) either wrote
> > a patch for the documentation, or taught the tool how to do this more
> > automatically.
> 
> Here's that patch. Maybe I'll get around to Shawn's second (far more ideal)
> suggestion sometime.
> 
>  Documentation/git-svn.txt |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 0a210e4..3e3b597 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -435,6 +435,25 @@ Tracking and contributing to an entire Subversion-managed project
>  # of dcommit/rebase/show-ignore should be the same as above.
>  ------------------------------------------------------------------------
>  
> +The initial 'git-svn clone' Subversion can be quite time-consuming (especially
> +for large repositories). If multiple people (or one person with multiple
> +machines) want to use git-svn to interact with the same Subversion repository,
> +you can do the initial 'git-svn clone' to a repository on a server and have
> +each person clone that repository with 'git clone':
> +
> +------------------------------------------------------------------------
> +# Do the initial import on a server
> +	ssh server "cd /pub && git-svn clone http://svn.foo.org/project
> +# Clone locally
> +	git clone server:/pub/project
> +# Tell git-svn which branch contains the Subversion commits
> +	git update-ref refs/remotes/git-svn origin/master
> +# Initialize git-svn locally (be sure to use the same URL and -T/-b/-t options as were used on server)
> +	git-svn init http://svn.foo.org/project
> +# Pull the latest changes from Subversion
> +	git-svn rebase
> +------------------------------------------------------------------------
> +
>  REBASE VS. PULL/MERGE
>  ---------------------

This method won't get branches and tags under the refs/remotes/
namespace, will it?

I personally believe using rsync to clone repositories created with
git-svn is the simplest and best method for now.

-- 
Eric Wong
