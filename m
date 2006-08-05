From: Shawn Pearce <spearce@spearce.org>
Subject: Re: update-ref logs: problem with committer info?
Date: Fri, 4 Aug 2006 22:56:00 -0400
Message-ID: <20060805025600.GA18223@spearce.org>
References: <000501c6b809$2b18cd60$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 04:56:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9CKg-0004BU-Mw
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 04:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422721AbWHEC4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 22:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422722AbWHEC4H
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 22:56:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44474 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1422721AbWHEC4G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 22:56:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9CKN-0004Rr-CA; Fri, 04 Aug 2006 22:55:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 43F8A20FB77; Fri,  4 Aug 2006 22:56:01 -0400 (EDT)
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <000501c6b809$2b18cd60$c47eedc1@ramsay1.demon.co.uk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24874>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
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
> diff --git a/refs.c b/refs.c
> index 713ca46..a4060d8 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -379,7 +379,6 @@ static int log_ref_write(struct ref_lock
>  			lock->log_file, strerror(errno));
>  	}
>  
> -	setup_ident();
>  	comitter = git_committer_info(1);
>  	if (msg) {
>  		maxlen = strlen(comitter) + strlen(msg) + 2*40 + 5;

These two changes were already fixed by me in 0b0fe4a6 on July
10th.  That change is in `next`, in `master` and in v1.4.2-rc3.
So I expect it to be available in a final release real-soon-now.
Maybe you should consider running a newer version of GIT?

> diff --git a/http-fetch.c b/http-fetch.c
> index 44eba5f..fe3a4fd 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -1222,6 +1222,7 @@ int main(int argc, char **argv)
>  	int arg = 1;
>  	int rc = 0;
>  
> +	setup_ident();
>  	setup_git_directory();
>  	git_config(git_default_config);
>  
> diff --git a/local-fetch.c b/local-fetch.c
> index ffa4887..d059a51 100644
> --- a/local-fetch.c
> +++ b/local-fetch.c
> @@ -207,6 +207,7 @@ int main(int argc, char **argv)
>  	char *commit_id;
>  	int arg = 1;
>  
> +	setup_ident();
>  	setup_git_directory();
>  	git_config(git_default_config);
>  
> diff --git a/ssh-fetch.c b/ssh-fetch.c
> index 1e59cd2..a42d17e 100644
> --- a/ssh-fetch.c
> +++ b/ssh-fetch.c
> @@ -131,6 +131,7 @@ int main(int argc, char **argv)
>  	prog = getenv("GIT_SSH_PUSH");
>  	if (!prog) prog = "git-ssh-upload";
>  
> +	setup_ident();
>  	setup_git_directory();
>  	git_config(git_default_config);
>  

These changes aren't in `next` right now, but should be.  Junio,
can you apply them?

-- 
Shawn.
