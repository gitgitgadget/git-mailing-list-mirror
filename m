From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Mark win32's pthread_exit() as NORETURN
Date: Tue, 1 Mar 2016 08:57:09 -0500
Message-ID: <20160301135708.GA29303@sigill.intra.peff.net>
References: <69eef72cfc77e62ad7ad17c6df5f2d2396c64991.1456840324.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 01 14:57:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aakne-0004kQ-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 14:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbcCAN5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 08:57:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:52362 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752636AbcCAN5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 08:57:14 -0500
Received: (qmail 25436 invoked by uid 102); 1 Mar 2016 13:57:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 08:57:13 -0500
Received: (qmail 7717 invoked by uid 107); 1 Mar 2016 13:57:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 08:57:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 08:57:09 -0500
Content-Disposition: inline
In-Reply-To: <69eef72cfc77e62ad7ad17c6df5f2d2396c64991.1456840324.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288014>

On Tue, Mar 01, 2016 at 02:53:04PM +0100, Johannes Schindelin wrote:

> The pthread_exit() function is not expected to return. Ever.
> 
> Pointed out by Jeff King.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/win32/pthread.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
> index 20b35a2..148db60 100644
> --- a/compat/win32/pthread.h
> +++ b/compat/win32/pthread.h
> @@ -78,7 +78,7 @@ extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
>  #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
>  extern pthread_t pthread_self(void);
>  
> -static inline int pthread_exit(void *ret)
> +static inline int NORETURN pthread_exit(void *ret)
>  {
>  	ExitThread((DWORD)(intptr_t)ret);
>  }

Looks obviously correct to me (I'll assume Windows isn't so crazy as to
let ExitThread ever return :) ).

-Peff
> -- 
> 2.7.2.windows.1.5.g64acc33
