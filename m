From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 16:11:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181605370.4680@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	bonzini@gnu.org, kusmabite@googlemail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 16:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdPPJ-0007si-Gl
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 16:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759168AbZHROLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 10:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758866AbZHROLN
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 10:11:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:52368 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759127AbZHROLK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 10:11:10 -0400
Received: (qmail invoked by alias); 18 Aug 2009 14:11:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp024) with SMTP; 18 Aug 2009 16:11:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hEOFB9bahVAIbs5DIYNe3zwsgIh7kNwHovXJzGg
	X6skHpn+V0hGDf
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250600335-8642-1-git-send-email-mstormo@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126399>

Hi,

On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:

>  So, instead of rely on these vcproj files which *will* go stale, we can 
>  simply use the same Makefile system which everyone else is using. :) 
>  After all, we're just compiling with a different compiler. The end 
>  result will still rely on the *msysGit environment* to function, so we 
>  already require it. Thus, GNU Make is present, and we can use it.

We can also use sed or perl to generate/modify the .vcproj files, or run 
CMake (once Pau got it to build), and package the stuff using zip (once I 
got that to build).

> diff --git a/Makefile b/Makefile
> index daf4296..2e14976 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -214,9 +214,13 @@ uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
>  
>  CFLAGS = -g -O2 -Wall
>  LDFLAGS =
> +ARFLAGS = rcs\ # whitespace intentional
>  ALL_CFLAGS = $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
>  STRIP ?= strip
> +COMPFLAG = -c
> +COBJFLAG = -o\ # whitespace intended
> +LOBJFLAG = -o\ # whitespace intended

These probably want to go into the Microsoft Visual C++ specific section.

> @@ -874,6 +878,58 @@ ifneq (,$(findstring CYGWIN,$(uname_S)))
>  	COMPAT_OBJS += compat/cygwin.o
>  	UNRELIABLE_FSTAT = UnfortunatelyYes
>  endif
> +ifneq (,$(findstring Microsoft Visual Studio, $(INCLUDE)))
> +	pathsep = ;
> +	MOZILLA_SHA1 = 1
> +	NO_PREAD = YesPlease
> +	NO_OPENSSL = YesPlease
> +	NO_LIBGEN_H = YesPlease
> +	NO_SYMLINK_HEAD = YesPlease
> +	NO_IPV6 = YesPlease
> +	NO_SETENV = YesPlease
> +	NO_UNSETENV = YesPlease
> +	NO_STRCASESTR = YesPlease
> +	NO_STRLCPY = YesPlease
> +	NO_MEMMEM = YesPlease
> +	NEEDS_LIBICONV = YesPlease
> +	OLD_ICONV = YesPlease
> +	NO_C99_FORMAT = YesPlease
> +	NO_STRTOUMAX = YesPlease
> +	NO_MKDTEMP = YesPlease
> +	NO_MKSTEMPS = YesPlease
> +	SNPRINTF_RETURNS_BOGUS = YesPlease
> +	NO_SVN_TESTS = YesPlease
> +	NO_PERL_MAKEMAKER = YesPlease
> +	RUNTIME_PREFIX = YesPlease
> +	NO_POSIX_ONLY_PROGRAMS = YesPlease
> +	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
> +	NO_NSEC = YesPlease
> +	USE_WIN32_MMAP = YesPlease
> +	UNRELIABLE_FSTAT = UnfortunatelyYes
> +	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
> +	NO_REGEX = YesPlease
> +
> +	NO_CURL = YesPlease
> +	NO_PTHREADS = YesPlease
> +        
> +	CC = cl 
> +	COBJFLAG = -Fo
> +	LOBJFLAG = -OUT:
> +	CFLAGS =
> +	BASIC_CFLAGS += -nologo -MT -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE
> +	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch
> +	COMPAT_OBJS += compat/mingw.o compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o
> +	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
> +
> +	LINK = link
> +	BASIC_LDFLAGS += -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib ../zlib/projects/vc9/Win32_LIB_Release/zlib.lib
> +	NO_CFLAGS_TO_LINKER = YesPlease
> +	EXTLIBS = 
> +	AR = lib
> +	ARFLAGS = -OUT:
> +
> +	X = .exe
> +else
>  ifneq (,$(findstring MINGW,$(uname_S)))
>  	pathsep = ;
>  	NO_PREAD = YesPlease

This means that gcc is never used when Visual C++ is available?  Hmm.

> diff --git a/compat/msvc.h b/compat/msvc.h
> index 6071565..a9d5f7f 100644
> --- a/compat/msvc.h
> +++ b/compat/msvc.h
> @@ -10,50 +10,120 @@
>  
>  /*Configuration*/
>  
> +#ifndef NO_PREAD
>  #define NO_PREAD
> +#endif

Why?  You now have the stuff in two places.  If you want to keep them in 
compat/msvc.h to be able to generate .vcproj files, I'd rather not have 
them duplicated in the Makefile.

Ciao,
Dscho
