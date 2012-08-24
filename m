From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
Date: Fri, 24 Aug 2012 15:05:26 +0200
Message-ID: <004001cd81f9$21e68e10$65b3aa30$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Erik Faye-Lund" <kusmabite@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 15:05:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4ta9-0005wN-LD
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 15:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759358Ab2HXNFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 09:05:42 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:60013 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab2HXNFk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 09:05:40 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0M8pIq-1Sx9Hf3e2e-00CrfA; Fri, 24 Aug 2012 15:05:36 +0200
References: 
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2B3N3Lx3QEXop1QJeuCeNNx9/SoQAGekGw
Content-Language: de
X-Provags-ID: V02:K0:l+x4TNhPpH5SyBHvvCtPhQc9yvLxPoZVVChXegADUqV
 QTrZ/K92iC75HSz9aNX7lCNdoe++urjn1oXRIkMNkcKUeEx+hU
 rAryJ656Bt7xOOmXnJdMMMXUT8WBzjxy+rOO7aLivoGCjPRlMM
 73GCj/y05PwXrfJkqEm0eudg9GaezyWs3runMBlRAU46Omu4xO
 p+1TI+82fU/PVO41IzFfSVEANNQ7OlkdQ7Tb8cR7ZKOLz5HzUh
 XJaOxIq3Umo7NDfkE7U/yHNyZk+8lwmc3oL126x0JnpcuwP2A0
 SL5A0LLLYW80Sj8/j8X3hgUMs/aFKdubjg9uTowjZURclspfUm
 DcHYsH2aXuPqiQKHnRutvMQp0/088CzPkgJxRAuOamUP5lqlcH
 HveB6KbQtIwtA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204209>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Friday, August 24, 2012 11:45 AM
> To: Junio C Hamano (gitster@pobox.com)
> Cc: git@vger.kernel.org; Erik Faye-Lund (kusmabite@gmail.com)
> Subject: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
> 
> 
> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
> This time I hopefully didn't screw up whitespace and line breaks.
> 
>  Makefile            | 18 ++++++++++++++----
>  compat/win32/poll.c |  8 ++++++--
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 66e8216..e150816 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -152,6 +152,11 @@ all::
>  #
>  # Define NO_MMAP if you want to avoid mmap.
>  #
> +# Define NO_SYS_POLL_H if you don't have sys/poll.h.
> +#
> +# Define NO_POLL if you do not have or do not want to use poll.
> +# This also implies NO_SYS_POLL_H.
> +#
>  # Define NO_PTHREADS if you do not have or do not want to use Pthreads.
>  #
>  # Define NO_PREAD if you have a problem with pread() system call (e.g.
> @@ -1216,7 +1221,7 @@ ifeq ($(uname_S),Windows)
>  	NO_PREAD = YesPlease
>  	NEEDS_CRYPTO_WITH_SSL = YesPlease
>  	NO_LIBGEN_H = YesPlease
> -	NO_SYS_POLL_H = YesPlease
> +	NO_POLL = YesPlease
>  	NO_SYMLINK_HEAD = YesPlease
>  	NO_IPV6 = YesPlease
>  	NO_UNIX_SOCKETS = YesPlease
> @@ -1257,7 +1262,7 @@ ifeq ($(uname_S),Windows)
>  	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -
> D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
>  	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
>  		compat/win32/pthread.o compat/win32/syslog.o \
> -		compat/win32/poll.o compat/win32/dirent.o
> +		compat/win32/dirent.o
>  	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -
> Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
>  	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
>  	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
> @@ -1312,7 +1317,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	NO_PREAD = YesPlease
>  	NEEDS_CRYPTO_WITH_SSL = YesPlease
>  	NO_LIBGEN_H = YesPlease
> -	NO_SYS_POLL_H = YesPlease
> +	NO_POLL = YesPlease
>  	NO_SYMLINK_HEAD = YesPlease
>  	NO_UNIX_SOCKETS = YesPlease
>  	NO_SETENV = YesPlease
> @@ -1347,7 +1352,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
>  	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
>  		compat/win32/pthread.o compat/win32/syslog.o \
> -		compat/win32/poll.o compat/win32/dirent.o
> +		compat/win32/dirent.o
>  	EXTLIBS += -lws2_32
>  	PTHREAD_LIBS =
>  	X = .exe
> @@ -1601,6 +1606,11 @@ ifdef NO_GETTEXT
>  	BASIC_CFLAGS += -DNO_GETTEXT
>  	USE_GETTEXT_SCHEME ?= fallthrough
>  endif
> +ifdef NO_POLL
> +	NO_SYS_POLL_H = YesPlease
> +	COMPAT_CFLAGS += -DNO_POLL -Icompat/win32 # so it finds poll.h
> +	COMPAT_OBJS += compat/win32/poll.o
> +endif
>  ifdef NO_STRCASESTR
>  	COMPAT_CFLAGS += -DNO_STRCASESTR
>  	COMPAT_OBJS += compat/strcasestr.o
> diff --git a/compat/win32/poll.c b/compat/win32/poll.c
> index 403eaa7..49541f1 100644
> --- a/compat/win32/poll.c
> +++ b/compat/win32/poll.c
> @@ -24,7 +24,9 @@
>  # pragma GCC diagnostic ignored "-Wtype-limits"
>  #endif
> 
> -#include <malloc.h>
> +#if defined(WIN32)
> +# include <malloc.h>
> +#endif
> 
>  #include <sys/types.h>
> 
> @@ -48,7 +50,9 @@
>  #else
>  # include <sys/time.h>
>  # include <sys/socket.h>
> -# include <sys/select.h>
> +# ifndef NO_SYS_SELECT_H
> +#  include <sys/select.h>
> +# endif
>  # include <unistd.h>
>  #endif
> 
> --
> 1.7.12


There is a downside with this: In order to make use of it, in Makefile it 
adds "-Icompat/win32" to COMPAR_CFLAGS. This results in 
compat/win32/dirent.h to be found, rather than /usr/include/dirent.h. 
This should be fine for WIN32, but for everybody else may not. 
For HP NonStop in particular it results in a warning:

        };
         ^
"... /compat/win32/dirent.h", line 17: warning(133): expected an identifier

And this is because there it uses an unnamed union, which is a GCC extension 
(just like unnamed struct), but not part of C89/C99/POSIX.

One possible solution might be to move compat/win32/poll.[ch] to compat/.
Another is to just ignore the warning, at least here it seems to work just fine?
Or to avoid using an unnamed union. But the later 2 cases would still mean that
we include the wrong dirent.h, so the 1st solution seems the cleanest.

Any other idea?
Let me know your thoughts...

Bye, Jojo
