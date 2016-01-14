From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/5] config.mak.uname: support MSys2
Date: Thu, 14 Jan 2016 22:45:15 +0100
Message-ID: <569816EB.1060607@kdbg.org>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
 <cover.1452790142.git.johannes.schindelin@gmx.de>
 <e63d391a79396e095d2ebb139bb44c390e50bb62.1452790142.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 22:45:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJphr-0002bC-8d
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 22:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102AbcANVpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 16:45:19 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:22632 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755893AbcANVpR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 16:45:17 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3phK1l6xKSz5tlJ;
	Thu, 14 Jan 2016 22:45:15 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 76A2151ED;
	Thu, 14 Jan 2016 22:45:15 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <e63d391a79396e095d2ebb139bb44c390e50bb62.1452790142.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284096>

Am 14.01.2016 um 17:51 schrieb Johannes Schindelin:
> diff --git a/config.mak.uname b/config.mak.uname
> index f34dcaa..b0592c1 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -518,7 +518,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>   	NO_INET_NTOP = YesPlease
>   	NO_POSIX_GOODIES = UnfortunatelyYes
>   	DEFAULT_HELP_FORMAT = html
> -	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
> +	COMPAT_CFLAGS += -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
>   	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
>   	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
>   		compat/win32/pthread.o compat/win32/syslog.o \
> @@ -541,8 +541,25 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
>   	INTERNAL_QSORT = YesPlease
>   	HAVE_LIBCHARSET_H = YesPlease
>   	NO_GETTEXT = YesPlease
> +	COMPAT_CLFAGS += -D__USE_MINGW_ACCESS
>   else
> -	NO_CURL = YesPlease
> +	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
> +		# MSys2
> +		CC = gcc
> +		prefix = /mingw32

Hmm. Setting the prefix like this is certainly ideal for Git for Windows 
(the installer), but it is very uncommon to set the prefix in 
config.mak.uname.

> +		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0
> +		INSTALL = /bin/install
> +		NO_R_TO_GCC_LINKER = YesPlease
> +		INTERNAL_QSORT = YesPlease
> +		HAVE_LIBCHARSET_H = YesPlease
> +		NO_GETTEXT = YesPlease
> +		USE_LIBPCRE= YesPlease
> +		NO_CURL =
> +		USE_NED_ALLOCATOR = YesPlease

USE_NED_ALLOCATOR is already set in the common section (line 510).

> +	else
> +		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO

Did you mean to set -D__USE_MINGW_ACCESS here? But, as I noticed, it 
doesn't make a whole lot of a difference; my build (which picks this 
branch, if I'm not mistaken) still passes the test suite.

> +		NO_CURL = YesPlease
> +	endif
>   endif
>   endif
>   ifeq ($(uname_S),QNX)
>

-- Hannes
