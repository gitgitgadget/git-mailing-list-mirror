From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] compat/mingw.h: Set S_ISUID to prevent a fast-import
 test failure
Date: Wed, 18 Apr 2012 22:22:00 +0200
Message-ID: <4F8F2268.8020803@kdbg.org>
References: <4F8DAFA4.2050502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:22:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKbOF-0007ug-8e
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 22:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab2DRUWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 16:22:05 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:42443 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab2DRUWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 16:22:04 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B129713004C;
	Wed, 18 Apr 2012 22:22:00 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AA3B519F6C0;
	Wed, 18 Apr 2012 22:22:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <4F8DAFA4.2050502@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195900>

Am 17.04.2012 20:00, schrieb Ramsay Jones:
> 
> The current t9300-fast-import.sh test number 62 ("L: nested tree
> copy does not corrupt deltas") was introduced in commit 9a0edb79
> ("fast-import: add a test for tree delta base corruption",
> 15-08-2011). A fix for the demonstrated problem was introduced
> by commit 8fb3ad76 ("fast-import: prevent producing bad delta",
> 15-08-2011). However, this fix didn't work on MinGW and so this
> test has always failed on MinGW.
> 
> Part of the solution in commit 8fb3ad76 was to add an NO_DELTA
> preprocessor constant which was defined as follows:
> 
>   +/*
>   + * We abuse the setuid bit on directories to mean "do not delta".
>   + */
>   +#define NO_DELTA S_ISUID
>   +
> 
> Unfortunately, the S_ISUID constant on MinGW is defined as zero.
> 
> In order to fix the problem, we simply alter the definition of
> S_ISUID in the mingw header file to a more appropriate value.
> Also, we take the opportunity to similarly define S_ISGID and
> S_ISVTX.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  compat/mingw.h |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/compat/mingw.h b/compat/mingw.h
> index ef5b150..61a6521 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -22,9 +22,10 @@ typedef int socklen_t;
>  #define S_IWOTH 0
>  #define S_IXOTH 0
>  #define S_IRWXO (S_IROTH | S_IWOTH | S_IXOTH)
> -#define S_ISUID 0
> -#define S_ISGID 0
> -#define S_ISVTX 0
> +
> +#define S_ISUID 0004000
> +#define S_ISGID 0002000
> +#define S_ISVTX 0001000
>  
>  #define WIFEXITED(x) 1
>  #define WIFSIGNALED(x) 0

I've submitted a similar patch, but it was suggested to solve the
inherent problem in a cleaner way, but no patch came forward.

-- Hannes

See http://thread.gmane.org/gmane.comp.version-control.git/181817
