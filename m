From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] cvsserver: imitate git-update-ref when committing
Date: Wed, 26 Jul 2006 20:21:30 -0400
Message-ID: <20060727002130.GA32492@spearce.org>
References: <Pine.LNX.4.63.0607262249010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 27 02:21:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5tdL-000381-Pg
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 02:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWG0AVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 20:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWG0AVf
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 20:21:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:27844 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751830AbWG0AVf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 20:21:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G5tcx-00014I-1q; Wed, 26 Jul 2006 20:21:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F2CD620FB77; Wed, 26 Jul 2006 20:21:30 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607262249010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24263>

You might want to also consider appending to the reflog, if it
exists/is enabled.  I still need to get upload-pack to do this but it
may be useful for some heads for some people...  or maybe not.  :-)

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> git-update-ref writes into the lockfile, and renames it afterwards. Like 
> commit v1.3.0-rc3~22, it is not only cleaner, but also helps with shared 
> setups: every developer can have a different primary group; what matters 
> is that $GIT_DIR/refs/heads has to be writable by a group you are in.
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  git-cvsserver.perl |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 1b70cd9..2c1b0c7 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -1144,9 +1144,7 @@ sub req_ci
>          exit;
>      }
>  
> -    open FILE, ">", "$ENV{GIT_DIR}refs/heads/$state->{module}";
> -    print FILE $commithash;
> -    close FILE;
> +    print LOCKFILE $commithash;
>  
>      $updater->update();
>  
> @@ -1173,7 +1171,9 @@ sub req_ci
>      }
>  
>      close LOCKFILE;
> -    unlink($lockfile);
> +    my $reffile = "$ENV{GIT_DIR}refs/heads/$state->{module}";
> +    unlink($reffile);
> +    rename($lockfile, $reffile);
>      chdir "/";
>  
>      print "ok\n";
> -- 
> 1.4.2.rc2.g2b3d-dirty

-- 
Shawn.
