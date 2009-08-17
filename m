From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/11] Place __stdcall to correct position.
Date: Mon, 17 Aug 2009 19:01:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171859060.4991@intel-tinevez-2-302>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <1250525103-5184-2-git-send-email-lznuaa@gmail.com> <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:01:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5ad-0001wy-8Z
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757602AbZHQRBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 13:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757563AbZHQRBi
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:01:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:49257 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756895AbZHQRBh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 13:01:37 -0400
Received: (qmail invoked by alias); 17 Aug 2009 17:01:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 17 Aug 2009 19:01:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/w0+gq+YbwLwJJWMsG83AYEImBfrQbNAj1NQfBsz
	3yB7KBdzLq+70y
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126232>

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> MSVC require __stdcall is between return value and function name.
> ALL Win32 API definition is as TYPE WINAPI function name
> 
> Signed-off-by: Frank Li <lznuaa@gmail.com>

How about "... to the correct ..." and "MSVC requires _stdcall to be 
between return value..." and "All Win32 API functions are declared with 
the WINAPI attribute."?

> diff --git a/compat/mingw.c b/compat/mingw.c
> index d5fa0ed..0c9c793 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1146,7 +1146,7 @@ void mingw_open_html(const char *unixpath)
>  
>  int link(const char *oldpath, const char *newpath)
>  {
> -	typedef BOOL WINAPI (*T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
> +	typedef  BOOL (WINAPI *T)(const char*, const char*, LPSECURITY_ATTRIBUTES);

An extra space slipped in, there.

> diff --git a/run-command.c b/run-command.c
> index df139da..423b506 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -295,12 +295,12 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
>  }
>  
>  #if defined(__MINGW32__) || defined(_MSC_VER)
> -static __stdcall unsigned run_thread(void *data)
> +static unsigned __stdcall run_thread(void *data)
>  {
>  	struct async *async = data;
>  	return async->proc(async->fd_for_proc, async->data);
>  }
> -#endif
> +#endif /* __MINGW32__ || _MSC_VER */

I do not think this is necessary.  There are only 5 lines wrapped into 
those #ifdef guards, the developer should be able to see that far.

Ciao,
Dscho
