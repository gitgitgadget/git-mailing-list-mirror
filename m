From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Modify mingw_main() workaround to avoid link errors
Date: Sun,  3 Aug 2008 21:55:28 +0200
Message-ID: <1217793328.48960d306d2b7@webmail.nextra.at>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?b?Qmr2cm4=?= Steinbrink <B.Steinbrink@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 03 21:56:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPjgw-0005qn-Mq
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 21:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbYHCTzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Aug 2008 15:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbYHCTzc
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 15:55:32 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:34347 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbYHCTzb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 15:55:31 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp2.srv.eunet.at (Postfix) with ESMTPS id 80132BEF18;
	Sun,  3 Aug 2008 21:55:29 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m73JtSH5001353;
	Sun, 3 Aug 2008 21:55:28 +0200
Received: from 77.117.24.121 ([77.117.24.121]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Sun,  3 Aug 2008 21:55:28 +0200
In-Reply-To: <1217065304-27815-1-git-send-email-prohaska@zib.de>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.117.24.121
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91262>

Zitat von Steffen Prohaska <prohaska@zib.de>:
> With MinGW's
>
>    gcc.exe (GCC) 3.4.5 (mingw special)
>    GNU ld version 2.17.50 20060824
>
> the old define caused link errors:
>
>    git.o: In function `main':
>    C:/msysgit/git/git.c:500: undefined reference to `mingw_main'
>    collect2: ld returned 1 exit status
>
> The modified define works.
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>

Acked-by: Johannes Sixt <johannes.sixt@telecom.at>

I was not aware that my version (block-scoped static function forward
declaration) is not valid C. Thanks, Bj=F6rn, for pointing out the gcc =
bugzilla
entries.

-- Hannes

> ---
>  compat/mingw.h |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 290a9e6..a52e657 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -228,9 +228,10 @@ char **env_setenv(char **env, const char *name);
>   * A replacement of main() that ensures that argv[0] has a path
>   */
>
> -#define main(c,v) main(int argc, const char **argv) \
> +#define main(c,v) dummy_decl_mingw_main(); \
> +static int mingw_main(); \
> +int main(int argc, const char **argv) \
>  { \
> -	static int mingw_main(); \
>  	argv[0] =3D xstrdup(_pgmptr); \
>  	return mingw_main(argc, argv); \
>  } \
> --
> 1.6.0.rc0.42.g186458
