From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] entry.c: Use strerror() to print error info when possible
Date: Mon, 16 Apr 2007 01:00:20 +0200
Message-ID: <20070415230020.GC4417@steel.home>
References: <20070415185619.3fa90f3a@gnut>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:00:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdDi0-0001Xh-Ju
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbXDOXAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbXDOXAX
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:00:23 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:57572 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbXDOXAW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:00:22 -0400
Received: from tigra.home (Fcb1d.f.strato-dslnet.de [195.4.203.29])
	by post.webmailer.de (klopstock mo46) (RZmta 5.5)
	with ESMTP id G022c2j3FJLgB1 ; Mon, 16 Apr 2007 01:00:21 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BDA8B277BD;
	Mon, 16 Apr 2007 01:00:20 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 25DDBD439; Mon, 16 Apr 2007 01:00:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070415185619.3fa90f3a@gnut>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg2oA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44538>

Luiz Fernando N. Capitulino, Sun, Apr 15, 2007 23:56:19 +0200:
> 
> Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
> ---
>  entry.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/entry.c b/entry.c
> index d72f811..c36c09d 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -19,7 +19,8 @@ static void create_directories(const char *path, struct checkout *state)
>  				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
>  					continue; /* ok */
>  			}
> -			die("cannot create directory at %s", buf);
> +			die("cannot create directory at %s (%s)", buf,
> +			    strerror(errno));

This errno is not very useful, as it may come from the stat above, and
you provided no way to figure out what was the syscall (the mkdir or
the stat) which failed. Also, the errnos of unlink or mkdir just above
the stat are just lost.

It is not worse than before, but not very much better either, and
probably confusing. I suggest you just leave this one as it is.
