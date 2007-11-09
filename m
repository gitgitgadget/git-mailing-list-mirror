From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add strchrnul()
Date: Fri, 9 Nov 2007 01:21:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711090119430.4362@racer.site>
References: <4733AEA0.1060602@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:21:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIZD-0000fV-MV
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbXKIBVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbXKIBVg
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:21:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:37012 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752494AbXKIBVf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:21:35 -0500
Received: (qmail invoked by alias); 09 Nov 2007 01:21:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 09 Nov 2007 02:21:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3bFo7FfP35JE07wqQoo0ZIToyJv4EzdAwaWWP8E
	pEkOM/nylzNuLn
X-X-Sender: gene099@racer.site
In-Reply-To: <4733AEA0.1060602@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64102>

Hi,

On Fri, 9 Nov 2007, Ren? Scharfe wrote:

> diff --git a/Makefile b/Makefile
> index 0d5590f..578c999 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -30,6 +30,8 @@ all::
>  #
>  # Define NO_MEMMEM if you don't have memmem.
>  #
> +# Define NO_STRCHRNUL if you don't have strchrnul.
> +#
>  # Define NO_STRLCPY if you don't have strlcpy.
>  #
>  # Define NO_STRTOUMAX if you don't have strtoumax in the C library.
> @@ -406,6 +408,7 @@ ifeq ($(uname_S),Darwin)
>  	OLD_ICONV = UnfortunatelyYes
>  	NO_STRLCPY = YesPlease
>  	NO_MEMMEM = YesPlease
> +	NO_STRCHRNUL = YesPlease
>  endif
>  ifeq ($(uname_S),SunOS)
>  	NEEDS_SOCKET = YesPlease
> @@ -413,6 +416,7 @@ ifeq ($(uname_S),SunOS)
>  	SHELL_PATH = /bin/bash
>  	NO_STRCASESTR = YesPlease
>  	NO_MEMMEM = YesPlease
> +	NO_STRCHRNUL = YesPlease
>  	NO_HSTRERROR = YesPlease
>  	ifeq ($(uname_R),5.8)
>  		NEEDS_LIBICONV = YesPlease
> @@ -438,6 +442,7 @@ ifeq ($(uname_O),Cygwin)
>  	NO_D_INO_IN_DIRENT = YesPlease
>  	NO_STRCASESTR = YesPlease
>  	NO_MEMMEM = YesPlease
> +	NO_STRCHRNUL = YesPlease
>  	NO_SYMLINK_HEAD = YesPlease
>  	NEEDS_LIBICONV = YesPlease
>  	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
> @@ -452,12 +457,14 @@ endif
>  ifeq ($(uname_S),FreeBSD)
>  	NEEDS_LIBICONV = YesPlease
>  	NO_MEMMEM = YesPlease
> +	NO_STRCHRNUL = YesPlease
>  	BASIC_CFLAGS += -I/usr/local/include
>  	BASIC_LDFLAGS += -L/usr/local/lib
>  endif
>  ifeq ($(uname_S),OpenBSD)
>  	NO_STRCASESTR = YesPlease
>  	NO_MEMMEM = YesPlease
> +	NO_STRCHRNUL = YesPlease
>  	NEEDS_LIBICONV = YesPlease
>  	BASIC_CFLAGS += -I/usr/local/include
>  	BASIC_LDFLAGS += -L/usr/local/lib
> @@ -473,6 +480,7 @@ endif
>  ifeq ($(uname_S),AIX)
>  	NO_STRCASESTR=YesPlease
>  	NO_MEMMEM = YesPlease
> +	NO_STRCHRNUL = YesPlease
>  	NO_STRLCPY = YesPlease
>  	NEEDS_LIBICONV=YesPlease
>  endif
> @@ -485,6 +493,7 @@ ifeq ($(uname_S),IRIX64)
>  	NO_SETENV=YesPlease
>  	NO_STRCASESTR=YesPlease
>  	NO_MEMMEM = YesPlease
> +	NO_STRCHRNUL = YesPlease
>  	NO_STRLCPY = YesPlease
>  	NO_SOCKADDR_STORAGE=YesPlease
>  	SHELL_PATH=/usr/gnu/bin/bash

Might be easier to define HAVE_STRCHRNUL ;-)

> diff --git a/compat/strchrnul.c b/compat/strchrnul.c
> new file mode 100644
> index 0000000..51839fe
> --- /dev/null
> +++ b/compat/strchrnul.c
> @@ -0,0 +1,8 @@
> +#include "../git-compat-util.h"
> +
> +char *gitstrchrnul(const char *s, int c)
> +{
> +	while (*s && *s != c)
> +		s++;
> +	return (char *)s;
> +}

This is so short, I think it is even better to inline it.

Ciao,
Dscho
