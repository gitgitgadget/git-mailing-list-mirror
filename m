From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2 1/3] git-svn: Support retrieving passwords with
	GIT_ASKPASS
Date: Fri, 26 Feb 2010 02:05:25 -0800
Message-ID: <20100226100525.GC22579@dcvr.yhbt.net>
References: <1267142845-3040-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 11:05:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkx4e-0000HX-JS
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 11:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab0BZKF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 05:05:26 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:46264 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388Ab0BZKF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 05:05:26 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C270F1F488;
	Fri, 26 Feb 2010 10:05:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1267142845-3040-1-git-send-email-lznuaa@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141121>

Frank Li <lznuaa@gmail.com> wrote:
> git-svn reads passwords from an interactive terminal.
> This behavior cause GUIs to hang waiting for git-svn to
> complete
> 
> Fix this problem by allowing a password-retrieving command
> to be specified in GIT_ASKPASS. SSH_ASKPASS is supported
> as a fallback when GIT_ASKPASS is not provided.
> 
> Signed-off-by: Frank Li <lznuaa@gmail.com>
> ---
>  git-svn.perl |   37 +++++++++++++++++++++++++++----------
>  1 files changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 265852f..cd39792 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -31,6 +31,16 @@ if (! exists $ENV{SVN_SSH}) {
>  	}
>  }
>  
> +if (! exists $ENV{GIT_ASKPASS}) {
> +	if (exists $ENV{SSH_ASKPASS}) {
> +		$ENV{GIT_ASKPASS} = $ENV{SSH_ASKPASS};
> +		if ($^O eq 'msys') {
> +                        $ENV{GIT_ASKPASS} =~ s/\\/\\\\/g;
> +                        $ENV{GIT_ASKPASS} =~ s/(.*)/"$1"/;
> +                }
> +	}
> +}
> +

Hi Frank,

Since this logic isn't SVN-specific, can we get this in Git.pm
and/or git-var so other tools can use it?

Thanks

-- 
Eric Wong
