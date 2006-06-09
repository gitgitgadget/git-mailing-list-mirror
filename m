From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rm: fix possible segfault
Date: Thu, 08 Jun 2006 21:15:39 -0700
Message-ID: <7vverbnevo.fsf@assigned-by-dhcp.cox.net>
References: <20060609111044.451c94b1@namsh.wimo.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 06:15:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoYPQ-00007V-P6
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 06:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWFIEPm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 00:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWFIEPm
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 00:15:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:13191 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965116AbWFIEPl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 00:15:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060609041540.FNCG19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Jun 2006 00:15:40 -0400
To: SungHyun Nam <goweol@gmail.com>
In-Reply-To: <20060609111044.451c94b1@namsh.wimo.co.kr> (SungHyun Nam's
	message of "Fri, 9 Jun 2006 11:10:44 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21526>

SungHyun Nam <goweol@gmail.com> writes:

> Signed-off-by: SungHyun Nam <goweol@gmail.com>
>
> ---
>  builtin-rm.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-rm.c b/builtin-rm.c
> index ef2f8b5..aeda415 100644
> --- a/builtin-rm.c
> +++ b/builtin-rm.c
> @@ -83,6 +83,9 @@ int cmd_rm(int argc, const char **argv, 
>  		}
>  		die(builtin_rm_usage);
>  	}
> +	if (i >= argc)
> +		usage(builtin_rm_usage);
> +
>  	pathspec = get_pathspec(prefix, argv + i);
>  
>  	seen = NULL;

Thanks.  The real problem is it uses pathspec even when no paths
is specified, but "git rm" without any arguments would remove
everything under the sun with the normal pathspec semantics, so
refusing to run when no paths are specified like you did makes
sense.

There is a more grave bug in git-rm (I do not use this command
myself at all, so I did not spot it earlier).  I'll push out a
fix soonish.
