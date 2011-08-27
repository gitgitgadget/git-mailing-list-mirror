From: David Aguilar <davvid@gmail.com>
Subject: Re: obstack fails to compile on OS X 10.7
Date: Sat, 27 Aug 2011 03:14:43 -0700
Message-ID: <20110827101418.GA8074@gmail.com>
References: <4A1A024F-C5D5-4E5F-8474-DA3D87412C8A@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Fredrik Kuivinen <frekui@gmail.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 12:15:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxFux-0008Ex-E4
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 12:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993Ab1H0KO7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Aug 2011 06:14:59 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:44922 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab1H0KO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 06:14:58 -0400
Received: by pzk37 with SMTP id 37so5593225pzk.1
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZcWFlnKMVQGG8Tubq8tHfMLrLo4a22BbahqIHdqfx1M=;
        b=psLQUKoCTf2APYQ6xVw0bv+URq9SPDATxp2u+u9JJTHO0GawnazEEb/z16ZKElIIwC
         AQhCuScxuWdE6FoADHbe+yW7cJNfo6/pEbe7Uj0BZPWv+W5q7CsfHIIyVWyF5nW1mmxg
         b7w+A6VfnpzjZSQEP07UStS+oB0/GEukx4gkM=
Received: by 10.142.172.16 with SMTP id u16mr724425wfe.286.1314440097539;
        Sat, 27 Aug 2011 03:14:57 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net. [208.106.56.2])
        by mx.google.com with ESMTPS id i1sm6263200pbi.10.2011.08.27.03.14.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Aug 2011 03:14:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A1A024F-C5D5-4E5F-8474-DA3D87412C8A@gernhardtsoftware.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180227>

On Sat, Aug 27, 2011 at 02:21:40AM -0400, Brian Gernhardt wrote:
> Some of the errors look like things I could track down, but some just=
 confuse me.  If anyone else could take a look into this, it would be m=
uch appreciated.
>=20
> ~~ Brian G.
>=20
> gcc -o compat/obstack.o -c -MF compat/.depend/obstack.o.d -MMD -MP  -=
Wall -Wdeclaration-after-statement -Werror -Wno-deprecated-declarations=
 -I. -DUSE_ST_TIMESPEC  -DSHA1_HEADER=3D'"block-sha1/sha1.h"'  -DNO_MEM=
MEM  compat/obstack.c
> In file included from compat/obstack.c:30:
> compat/obstack.h:190: error: __block attribute can be specified on va=
riables only
> compat/obstack.c:70: error: expected specifier-qualifier-list before =
=E2=80=98uintmax_t=E2=80=99
> compat/obstack.c:111:24: error: exitfail.h: No such file or directory
> cc1: warnings being treated as errors
> compat/obstack.c: In function =E2=80=98print_and_abort=E2=80=99:
> compat/obstack.c:436: warning: implicit declaration of function =E2=80=
=98gettext=E2=80=99
> compat/obstack.c:436: warning: incompatible implicit declaration of b=
uilt-in function =E2=80=98gettext=E2=80=99
> compat/obstack.c:438: error: =E2=80=98exit_failure=E2=80=99 undeclare=
d (first use in this function)
> compat/obstack.c:438: error: (Each undeclared identifier is reported =
only once
> compat/obstack.c:438: error: for each function it appears in.)
> compat/obstack.c:439: warning: =E2=80=98noreturn=E2=80=99 function do=
es return
> make: *** [compat/obstack.o] Error 1
>=20
> $ gcc --version
> i686-apple-darwin11-llvm-gcc-4.2 (GCC) 4.2.1 (Based on Apple Inc. bui=
ld 5658) (LLVM build 2335.15.00)

I ran into the same thing.

This fixes it for me, but we might want to rearrange the
#includes a bit.  I think this needs more work.. including
compat/obstack.h from kwset.c seems wrong.
Should we just include obstack.h in git-compat-util instead?

I suspect that more exotic platforms may have problems
with obstack.h as well.  This probably needs some testing
on SunOS, AIX, IRIX, etc.

-- 8< --
Subject: [RFC PATCH] obstack: Fix portability issues

i686-apple-darwin10-gcc-4.2.1 (GCC) 4.2.1 and possibly others
do not have exit.h, exitfail.h, or obstack.h.  Add compat
versions of these headers as well as exitfail.c from glibc.

The ELIDE_CODE check in obstack.c is not sufficient so add a
separate NEEDS_OBSTACK variable to allow platforms to opt into
using the compatibility versions of these files.

The __block variable was renamed to __blk to avoid a gcc error:

compat/obstack.h:190: error: __block attribute can be specified on vari=
ables only

Signed-off-by: David Aguilar <davvid@gmail.com>
Reported-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 Makefile          |   11 +++++++++++
 compat/exit.h     |   32 ++++++++++++++++++++++++++++++++
 compat/exitfail.c |   24 ++++++++++++++++++++++++
 compat/exitfail.h |   20 ++++++++++++++++++++
 compat/obstack.c  |   19 +++----------------
 compat/obstack.h  |    2 +-
 kwset.c           |    3 ++-
 7 files changed, 93 insertions(+), 18 deletions(-)
 create mode 100644 compat/exit.h
 create mode 100644 compat/exitfail.c
 create mode 100644 compat/exitfail.h

diff --git a/Makefile b/Makefile
index 30f3812..87ad4a2 100644
--- a/Makefile
+++ b/Makefile
@@ -517,6 +517,8 @@ LIB_H +=3D compat/bswap.h
 LIB_H +=3D compat/cygwin.h
 LIB_H +=3D compat/mingw.h
 LIB_H +=3D compat/obstack.h
+LIB_H +=3D compat/exitfail.h
+LIB_H +=3D compat/exit.h
 LIB_H +=3D compat/win32/pthread.h
 LIB_H +=3D compat/win32/syslog.h
 LIB_H +=3D compat/win32/sys/poll.h
@@ -599,6 +601,7 @@ LIB_OBJS +=3D cache-tree.o
 LIB_OBJS +=3D color.o
 LIB_OBJS +=3D combine-diff.o
 LIB_OBJS +=3D commit.o
+LIB_OBJS +=3D compat/exitfail.o
 LIB_OBJS +=3D compat/obstack.o
 LIB_OBJS +=3D config.o
 LIB_OBJS +=3D connect.o
@@ -872,6 +875,8 @@ ifeq ($(uname_S),Darwin)
 	NEEDS_CRYPTO_WITH_SSL =3D YesPlease
 	NEEDS_SSL_WITH_CRYPTO =3D YesPlease
 	NEEDS_LIBICONV =3D YesPlease
+	NEEDS_OBSTACK =3D YesPlease
+	NEEDS_EXITFAIL =3D YesPlease
 	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
 		OLD_ICONV =3D UnfortunatelyYes
 	endif
@@ -1416,6 +1421,12 @@ endif
 ifdef NEEDS_RESOLV
 	EXTLIBS +=3D -lresolv
 endif
+ifdef NEEDS_OBSTACK
+	BASIC_CFLAGS +=3D -DNEEDS_OBSTACK
+endif
+ifdef NEEDS_EXITFAIL
+	BASIC_CFLAGS +=3D -DNEEDS_EXITFAIL
+endif
 ifdef NO_D_TYPE_IN_DIRENT
 	BASIC_CFLAGS +=3D -DNO_D_TYPE_IN_DIRENT
 endif
diff --git a/compat/exit.h b/compat/exit.h
new file mode 100644
index 0000000..9dbfb7c
--- /dev/null
+++ b/compat/exit.h
@@ -0,0 +1,32 @@
+/* exit() function.
+   Copyright (C) 1995, 2001 Free Software Foundation, Inc.
+
+   This program is free software; you can redistribute it and/or modif=
y
+   it under the terms of the GNU General Public License as published b=
y
+   the Free Software Foundation; either version 2, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software Foundat=
ion,
+   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA. =
 */
+
+#ifndef _EXIT_H
+#define _EXIT_H
+
+/* Get exit() declaration.  */
+#include <stdlib.h>
+
+/* Some systems do not define EXIT_*, even with STDC_HEADERS.  */
+#ifndef EXIT_SUCCESS
+# define EXIT_SUCCESS 0
+#endif
+#ifndef EXIT_FAILURE
+# define EXIT_FAILURE 1
+#endif
+
+#endif /* _EXIT_H */
diff --git a/compat/exitfail.c b/compat/exitfail.c
new file mode 100644
index 0000000..a2dd5dd
--- /dev/null
+++ b/compat/exitfail.c
@@ -0,0 +1,24 @@
+/* Failure exit status
+
+   Copyright (C) 2002, 2003 Free Software Foundation, Inc.
+
+   This program is free software; you can redistribute it and/or modif=
y
+   it under the terms of the GNU General Public License as published b=
y
+   the Free Software Foundation; either version 2, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; see the file COPYING.
+   If not, write to the Free Software Foundation,
+   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  */
+#ifdef NEEDS_EXITFAIL
+#include "exitfail.h"
+#include "exit.h"
+
+int volatile exit_failure =3D EXIT_FAILURE;
+#endif
diff --git a/compat/exitfail.h b/compat/exitfail.h
new file mode 100644
index 0000000..e46cf9c
--- /dev/null
+++ b/compat/exitfail.h
@@ -0,0 +1,20 @@
+/* Failure exit status
+
+   Copyright (C) 2002 Free Software Foundation, Inc.
+
+   This program is free software; you can redistribute it and/or modif=
y
+   it under the terms of the GNU General Public License as published b=
y
+   the Free Software Foundation; either version 2, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; see the file COPYING.
+   If not, write to the Free Software Foundation,
+   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  */
+
+extern int volatile exit_failure;
diff --git a/compat/obstack.c b/compat/obstack.c
index 75440d9..825658c 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -18,15 +18,12 @@
    Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.  */
=20
-
-#ifdef HAVE_CONFIG_H
-# include <config.h>
-#endif
-
 #ifdef _LIBC
 # include <obstack.h>
 # include <shlib-compat.h>
 #else
+# include <gettext.h>
+# include "git-compat-util.h"
 # include "obstack.h"
 #endif
=20
@@ -54,7 +51,7 @@
=20
 #include <stddef.h>
=20
-#ifndef ELIDE_CODE
+#if !defined ELIDE_CODE || defined NEEDS_OBSTACK
=20
=20
 # if HAVE_INTTYPES_H
@@ -400,16 +397,6 @@ _obstack_memory_used (struct obstack *h)
   return nbytes;
 }
 =0C
-/* Define the error handler.  */
-# ifdef _LIBC
-#  include <libintl.h>
-# else
-#  include "gettext.h"
-# endif
-# ifndef _
-#  define _(msgid) gettext (msgid)
-# endif
-
 # ifdef _LIBC
 #  include <libio/iolibio.h>
 # endif
diff --git a/compat/obstack.h b/compat/obstack.h
index 449070e..5636b91 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -187,7 +187,7 @@ extern int _obstack_begin_1 (struct obstack *, int,=
 int,
 			     void (*) (void *, void *), void *);
 extern int _obstack_memory_used (struct obstack *);
=20
-void obstack_free (struct obstack *__obstack, void *__block);
+void obstack_free (struct obstack *__obstack, void *__blk);
=20
 =0C
 /* Error handler called when `obstack_chunk_alloc' failed to allocate
diff --git a/kwset.c b/kwset.c
index fd4515a..d01c562 100644
--- a/kwset.c
+++ b/kwset.c
@@ -37,7 +37,8 @@
 #include "cache.h"
=20
 #include "kwset.h"
-#include "obstack.h"
+#include "git-compat-util.h"
+#include "compat/obstack.h"
=20
 #define NCHAR (UCHAR_MAX + 1)
 #define obstack_chunk_alloc xmalloc
--=20
1.7.6.476.g57292
