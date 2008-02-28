From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Thu, 28 Feb 2008 12:05:11 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281159550.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 13:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUhWl-0006hA-JY
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 13:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757834AbYB1MFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 07:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757868AbYB1MFn
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 07:05:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:54728 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755694AbYB1MFm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 07:05:42 -0500
Received: (qmail invoked by alias); 28 Feb 2008 12:05:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 28 Feb 2008 13:05:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YGpR6ODxYpkqqu4TvGbtvpskB8SIPP5wd+EiRC7
	8yZ2W9XBB3JlD0
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75389>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> +int gettimeofday(struct timeval *tv, void *tz)
> +{
> +	return 0;
> +}

Should it not return -1, for failure?  (I know, I know, probably a few 
programs do not work, then, but it is not correct that it succeeded.)

The same goes for a few other functions.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 2a40703..b1f3f92 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -357,6 +359,10 @@ static inline FILE *xfdopen(int fd, const char *mode)
>  	return stream;
>  }
>  
> +#ifdef __MINGW32__
> +int mkstemp(char *template);
> +#endif
> +
>  static inline int xmkstemp(char *template)
>  {
>  	int fd;

Could we have this...

> @@ -437,4 +443,140 @@ void git_qsort(void *base, size_t nmemb, size_t size,
>  #define qsort git_qsort
>  #endif
>  
> +#ifdef __MINGW32__
> +
> +#include <winsock2.h>
> +
> +/*
> + * things that are not available in header files
> + */
> +
> [...]

... and this in compat/mingw.h?  And then, we'd only have

#ifdef __MINGW32__
#include "mingw.h"
#endif

in git-compat-util.h?

Ciao,
Dscho
