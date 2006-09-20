From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] describe: fall back to 'HEAD' if no appropriate tag exists
Date: Wed, 20 Sep 2006 15:46:00 -0700
Message-ID: <7v8xkef97b.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609202324210.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Sep 21 00:46:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQApT-0005qU-K2
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 00:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWITWqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 18:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWITWqD
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 18:46:03 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:56726 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932306AbWITWqB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 18:46:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920224600.MCQS6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 18:46:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qmlm1V00h1kojtg0000000
	Wed, 20 Sep 2006 18:45:47 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27422>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, if no tag exists to say something like '<tag>-gfffffff', say
> 'HEAD-gfffffff' instead of erroring out.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  describe.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/describe.c b/describe.c
> index ab192f8..8b08a3f 100644
> --- a/describe.c
> +++ b/describe.c
> @@ -136,7 +136,7 @@ static void describe(const char *arg, in
>  			return;
>  		}
>  	}
> -	die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
> +	printf("HEAD-g%s\n", find_unique_abbrev(cmit->object.sha1, abbrev));
>  }

Hmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm.

At least with tags, the user can assume NAME-gREV means commit
whose abbrev is REV that is descendant of NAME.  HEAD is not
necessarily so.

Having said that, in order to avoid barfing, we have to have
something there, and HEAD is already special in many aspects
anyway (e.g. by only saying HEAD you cannot tell which branch's
tip you are talking about), it might be good enough.

I am just wondering if there is some other obvious substitute
that is better than HEAD.  "GIT-g%s" is not it ("g" already
stands for GIT).

Another possibility is just to do

        puts(sha1_to_hex(cmit->object.sha1))

in this case.  I tend to like that better somehow; it makes
things more explicit.
