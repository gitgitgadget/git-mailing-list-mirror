From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] entry.c: Use strerror() to print error info when possible
Date: Sun, 15 Apr 2007 15:54:47 -0700
Message-ID: <7v7isd2qq0.fsf@assigned-by-dhcp.cox.net>
References: <20070415185619.3fa90f3a@gnut>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Mon Apr 16 00:54:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdDcU-00085V-F9
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 00:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbXDOWyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 18:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754047AbXDOWyt
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 18:54:49 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:63091 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbXDOWys (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 18:54:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415225449.LENF1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 18:54:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id naun1W00r1kojtg0000000; Sun, 15 Apr 2007 18:54:48 -0400
In-Reply-To: <20070415185619.3fa90f3a@gnut> (Luiz Fernando N. Capitulino's
	message of "Sun, 15 Apr 2007 18:56:19 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44537>

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
writes:

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
>  		}
>  	}
>  	free(buf);

This hunk is wrong; stat() you see in the context could have
been what failed the last before this die().

I do not think other places you patched do not share the issue.
