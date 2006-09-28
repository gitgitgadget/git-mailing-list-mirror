From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] http/ftp: optionally ask curl to not use EPSV command
Date: Thu, 28 Sep 2006 14:25:13 -0700
Message-ID: <7vejtvu1ja.fsf@assigned-by-dhcp.cox.net>
References: <20060928192605.GD10617@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 23:25:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT3Nh-0007hN-19
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 23:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbWI1VZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 17:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbWI1VZQ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 17:25:16 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:17585 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1161116AbWI1VZO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 17:25:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928212514.GLPP12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 17:25:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TxRG1V00K1kojtg0000000
	Thu, 28 Sep 2006 17:25:16 -0400
To: Sasha Khapyorsky <sashak@voltaire.com>
In-Reply-To: <20060928192605.GD10617@sashak.voltaire.com> (Sasha Khapyorsky's
	message of "Thu, 28 Sep 2006 22:26:05 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28051>

Sasha Khapyorsky <sashak@voltaire.com> writes:

> If GIT_CURL_FTP_NO_EPSV environment variable is defined, disable using
> of EPSV ftp command (PASV will be used instead). This is helpful with
> some "poor" ftp servers which doesn't support EPSV mode.
>
> Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
> ---
>  http.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/http.c b/http.c
> index 6c1937b..a966e6d 100644
> --- a/http.c
> +++ b/http.c
> @@ -196,6 +196,9 @@ #endif
>  
>  	curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);
>  
> +	if (getenv("GIT_CURL_FTP_NO_EPSV"))
> +		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
> +
>  	return result;
>  }
>  
> -- 
> 1.4.2.1

Care to match this with existing ones?

$ git grep -e GIT_CURL -e GIT_SSL -e GIT_HTTP

tells you how they are handled and documented.  If you spot
inconsistencies if any (e.g. some having config entry and some
only environment -- I haven't checked), correcting them while
you are at it might be a good thing as well.
