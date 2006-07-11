From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-update-ref (reflog) uses bogus author ident information
Date: Mon, 10 Jul 2006 20:32:28 -0400
Message-ID: <20060711003228.GC10700@spearce.org>
References: <e8uele$o7t$2@sea.gmane.org> <20060711002754.GB10700@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 02:32:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G06BG-00024a-Lq
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 02:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWGKAcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 20:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWGKAcm
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 20:32:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:65440 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751354AbWGKAcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 20:32:41 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G06Av-0006Tx-1N; Mon, 10 Jul 2006 20:32:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1602520E43C; Mon, 10 Jul 2006 20:32:29 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060711002754.GB10700@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23675>

Shawn Pearce <spearce@spearce.org> wrote:
> Allow user.name and user.email to drive reflog entry.
> 
> Apparently calling setup_ident() after git_config causes the
> user.name and user.email values read from the config file to be
> replaced with the data obtained from the host.  This means that
> users who have setup their email address in user.email will instead
> be writing reflog entries with their hostname.
> 
> Moving setup_ident() to before git_config in update-ref resolves
> this ordering problem.

Whoops, I forgot this line:  :-)

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  builtin-update-ref.c |    1 +
>  refs.c               |    1 -
>  2 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-update-ref.c b/builtin-update-ref.c
> index 00333c7..83094ab 100644
> --- a/builtin-update-ref.c
> +++ b/builtin-update-ref.c
> @@ -12,6 +12,7 @@ int cmd_update_ref(int argc, const char 
>  	unsigned char sha1[20], oldsha1[20];
>  	int i;
>  
> +	setup_ident();
>  	setup_git_directory();
>  	git_config(git_default_config);
>  
> diff --git a/refs.c b/refs.c
> index 2d9c1dc..56db394 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -379,7 +379,6 @@ static int log_ref_write(struct ref_lock
>  			lock->log_file, strerror(errno));
>  	}
>  
> -	setup_ident();
>  	committer = git_committer_info(1);
>  	if (msg) {
>  		maxlen = strlen(committer) + strlen(msg) + 2*40 + 5;
> -- 
> 1.4.1.gc48f
