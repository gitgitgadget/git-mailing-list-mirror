From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Enable Visual Studio 2008 Build Git
Date: Sun, 16 Aug 2009 14:49:14 +0400
Message-ID: <20090816104913.GA29884@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 12:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McdMW-0006nb-RY
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 12:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbZHPKxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 06:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbZHPKxI
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 06:53:08 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:37421 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbZHPKxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 06:53:07 -0400
Received: by ewy10 with SMTP id 10so2374285ewy.37
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 03:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=pxBa9oy0gWfk4WP7bVqY4FdzoGSPPE+7M9KHbiykl9M=;
        b=F/+R73D6g6dM1kDqDP4Ro3WRgHQ3hhZ2SwaAGlTtVxTYJOVN1i2z7o6j3a+dOLPJuo
         bxSjbND2O3u1Rapq6I6shBBQmoUKvHvU7CnKGpsVM7D0S5SkZQU5BDp/eg0N3ylm0QbA
         YcP02t8qtgrEuBB0NSxIUCitR9x0jXLaABixA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Tx7GMhEQ8HO6XhVju+yBaWB7bbHj+5Xd97B1iA0xvrimzDYLDrsnXeORb4UQuoBvje
         9xPCdwg9HoSE5pqBl6RXScVnDe5v2OM1NDCaEntZvfQjhf0/3te/V8B6yoQBCwg6zN+X
         5+DP0k/JQoSv31GJJwwJneh/+Qq6aQFX4GQxA=
Received: by 10.210.81.3 with SMTP id e3mr5514509ebb.12.1250419986919;
        Sun, 16 Aug 2009 03:53:06 -0700 (PDT)
Received: from localhost (ppp91-76-19-248.pppoe.mtu-net.ru [91.76.19.248])
        by mx.google.com with ESMTPS id 10sm7766425eyz.41.2009.08.16.03.53.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 03:53:06 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126055>

Hi,

In addition to what Johannes wrote above, I have a few more remarks:

On Tue, Aug 04, 2009 at 11:53:38PM +0800, Frank Li wrote:
> diff --git a/compat/mingw.c b/compat/mingw.c
[...]
> @@ -1011,7 +1021,9 @@ static sig_handler_t timer_fn = SIG_DFL;
>   * But ticktack() interrupts the wait state after the timer's interval
>   * length to call the signal handler.
>   */
> -
> +#if defined(_MSC_VER)
> +#define __stdcall
> +#endif

It is a very dirty hack to change __stdcall in this way, and more
importantly, it is not clear why you did this.

>  static __stdcall unsigned ticktack(void *dummy)

Accordingly to MSDN:
http://msdn.microsoft.com/en-us/library/kdzttdcb(VS.80).aspx
The routine given to _beginthreadex as the start address should be
either __stdcall or  __clrcall.

> --- /dev/null
> +++ b/compat/vcbuild/libgit/libgit.vcproj
[...]
> +		<Filter
> +			Name="compat"
> +			>
> +			<File
> +				RelativePath="..\..\..\compat\basename.c"
> +				>
> +			</File>
> +			<File
> +				RelativePath="..\..\..\compat\cygwin.h"
> +				>
> +			</File>

I am not sure what cygwin.h is doing here.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 9f941e4..3b683e6 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -87,7 +87,7 @@
>  #include <assert.h>
>  #include <regex.h>
>  #include <utime.h>
> -#ifndef __MINGW32__
> +#if !defined(__MINGW32__) && !defined(_MSC_VER)

IMHO, it should be:

#ifndef _WIN32

because it has nothing to do with a particular compiler but with the
target platform. (Note: Cygwin GCC does not have _WIN32 defined, but
MinGW GCC does, so it should not break anything.)


Dmitry
