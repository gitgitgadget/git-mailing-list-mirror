From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 00:38:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911040031210.4985@pacific.mpi-cbg.de>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com> <1257283802-29726-2-git-send-email-ahaczewski@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 00:35:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5SuC-0006H3-66
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 00:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbZKCXe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 18:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbZKCXey
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 18:34:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:46118 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751792AbZKCXet (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 18:34:49 -0500
Received: (qmail invoked by alias); 03 Nov 2009 23:34:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 04 Nov 2009 00:34:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AR70dYN4Aw4g83Ip8E9gVdxSDz/HjpO5ADRrZyz
	mr/27Npm8UqzPf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1257283802-29726-2-git-send-email-ahaczewski@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132009>

Hi,

On Tue, 3 Nov 2009, Andrzej K. Haczewski wrote:

> ---

Could you please add the reasoning from the cover letter to this commit 
message?  And add a sign-off?

> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 02f9246..a8a4f59 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -18,8 +18,12 @@
>  #include "refs.h"
>  
>  #ifdef THREADED_DELTA_SEARCH
> -#include "thread-utils.h"
> -#include <pthread.h>
> +# include "thread-utils.h"
> +# ifndef _WIN32
> +#  include <pthread.h>
> +# else
> +#  include <winthread.h>
> +# endif
>  #endif
>  

It is unlikely that an #ifdef "contamination" of this extent will go 
through easily, but I have a suggestion that may make your patch both 
easier to read and more likely to be accepted into git.git: Try to wrap 
the win32 calls into pthread-compatible function signatures.  Then you can 
add a compat/win32/pthread.h and not even touch core files of git.git at 
all.

Oh, and you definitely do not want to copy-paste err_win_to_posix().  You 
definitely want to reuse the existing instance.

Ciao,
Dscho
