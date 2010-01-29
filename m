From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: threaded-grep cause msys build failure
Date: Fri, 29 Jan 2010 13:03:55 +0100
Message-ID: <4B62CEAB.5050608@viscovery.net>
References: <9ab80d151001290227u386616c5o6c825ff10d37f9fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?Wm9sdMOhbiBGw7x6ZXNp?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Fri Jan 29 13:04:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Napa2-0000W1-SC
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 13:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787Ab0A2MEA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 07:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105Ab0A2MEA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 07:04:00 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41897 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753412Ab0A2MD7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 07:03:59 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NapZs-0000Uf-Jd; Fri, 29 Jan 2010 13:03:56 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3828B1660F;
	Fri, 29 Jan 2010 13:03:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <9ab80d151001290227u386616c5o6c825ff10d37f9fd@mail.gmail.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138315>

Zolt=C3=A1n F=C3=BCzesi schrieb:
> Building git in msys environment fails:
> ...
>     LINK git.exe
> builtin-grep.o: In function `wait_all':
> D:\devel\msysgit\git/builtin-grep.c:260: undefined reference to
> `pthread_cond_broadcast'

Use this. I'll try to find a better solution over the weekend.

diff --git a/Makefile b/Makefile
index c591d70..bbee373 100644
--- a/Makefile
+++ b/Makefile
@@ -183,6 +183,9 @@ all::
 # Define THREADED_DELTA_SEARCH if you have pthreads and wish to exploi=
t
 # parallel delta searching when packing objects.
 #
+# Define THREADED_GREP if you have pthreads and wish to exploit a
+# parallelized grep.
+#
 # Define INTERNAL_QSORT to use Git's implementation of qsort(), which
 # is a simplified version of the merge sort used in glibc. This is
 # recommended if Git triggers O(n^2) behavior in your platform's qsort=
().
@@ -723,11 +726,13 @@ ifeq ($(uname_S),Linux)
 	NO_STRLCPY =3D YesPlease
 	NO_MKSTEMPS =3D YesPlease
 	THREADED_DELTA_SEARCH =3D YesPlease
+	THREADED_GREP =3D YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY =3D YesPlease
 	NO_MKSTEMPS =3D YesPlease
 	THREADED_DELTA_SEARCH =3D YesPlease
+	THREADED_GREP =3D YesPlease
 endif
 ifeq ($(uname_S),UnixWare)
 	CC =3D cc
@@ -782,6 +787,7 @@ ifeq ($(uname_S),Darwin)
 	endif
 	NO_MEMMEM =3D YesPlease
 	THREADED_DELTA_SEARCH =3D YesPlease
+	THREADED_GREP =3D YesPlease
 	USE_ST_TIMESPEC =3D YesPlease
 endif
 ifeq ($(uname_S),SunOS)
@@ -795,6 +801,7 @@ ifeq ($(uname_S),SunOS)
 	NO_MKSTEMPS =3D YesPlease
 	NO_REGEX =3D YesPlease
 	THREADED_DELTA_SEARCH =3D YesPlease
+	THREADED_GREP =3D YesPlease
 	ifeq ($(uname_R),5.7)
 		NEEDS_RESOLV =3D YesPlease
 		NO_IPV6 =3D YesPlease
@@ -851,6 +858,7 @@ ifeq ($(uname_S),FreeBSD)
 	DIR_HAS_BSD_GROUP_SEMANTICS =3D YesPlease
 	USE_ST_TIMESPEC =3D YesPlease
 	THREADED_DELTA_SEARCH =3D YesPlease
+	THREADED_GREP =3D YesPlease
 	ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
 		PTHREAD_LIBS =3D -pthread
 		NO_UINTMAX_T =3D YesPlease
@@ -865,6 +873,7 @@ ifeq ($(uname_S),OpenBSD)
 	BASIC_CFLAGS +=3D -I/usr/local/include
 	BASIC_LDFLAGS +=3D -L/usr/local/lib
 	THREADED_DELTA_SEARCH =3D YesPlease
+	THREADED_GREP =3D YesPlease
 endif
 ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
@@ -873,6 +882,7 @@ ifeq ($(uname_S),NetBSD)
 	BASIC_CFLAGS +=3D -I/usr/pkg/include
 	BASIC_LDFLAGS +=3D -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
 	THREADED_DELTA_SEARCH =3D YesPlease
+	THREADED_GREP =3D YesPlease
 	USE_ST_TIMESPEC =3D YesPlease
 	NO_MKSTEMPS =3D YesPlease
 endif
@@ -889,6 +899,7 @@ ifeq ($(uname_S),AIX)
 	BASIC_CFLAGS +=3D -D_LARGE_FILES
 	ifneq ($(shell expr "$(uname_V)" : '[1234]'),1)
 		THREADED_DELTA_SEARCH =3D YesPlease
+		THREADED_GREP =3D YesPlease
 	else
 		NO_PTHREADS =3D YesPlease
 	endif
@@ -916,6 +927,7 @@ ifeq ($(uname_S),IRIX)
 	SHELL_PATH =3D /usr/gnu/bin/bash
 	NEEDS_LIBGEN =3D YesPlease
 	THREADED_DELTA_SEARCH =3D YesPlease
+	THREADED_GREP =3D YesPlease
 endif
 ifeq ($(uname_S),IRIX64)
 	NO_SETENV=3DYesPlease
@@ -935,6 +947,7 @@ ifeq ($(uname_S),IRIX64)
 	SHELL_PATH=3D/usr/gnu/bin/bash
 	NEEDS_LIBGEN =3D YesPlease
 	THREADED_DELTA_SEARCH =3D YesPlease
+	THREADED_GREP =3D YesPlease
 endif
 ifeq ($(uname_S),HP-UX)
 	NO_IPV6=3DYesPlease
@@ -1334,6 +1347,7 @@ endif

 ifdef NO_PTHREADS
 	THREADED_DELTA_SEARCH =3D
+	THREADED_GREP =3D
 	BASIC_CFLAGS +=3D -DNO_PTHREADS
 else
 	EXTLIBS +=3D $(PTHREAD_LIBS)
@@ -1341,6 +1355,11 @@ endif

 ifdef THREADED_DELTA_SEARCH
 	BASIC_CFLAGS +=3D -DTHREADED_DELTA_SEARCH
+endif
+ifdef THREADED_GREP
+	BASIC_CFLAGS +=3D -DTHREADED_GREP
+endif
+ifneq (,$(THREADED_GREP)$(THREADED_DELTA_SEARCH))
 	LIB_OBJS +=3D thread-utils.o
 endif
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
diff --git a/builtin-grep.c b/builtin-grep.c
index 9bd467c..911d0da 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -16,7 +16,7 @@
 #include "quote.h"
 #include "dir.h"

-#ifndef NO_PTHREADS
+#ifdef THREADED_GREP
 #include "thread-utils.h"
 #include <pthread.h>
 #endif
@@ -28,7 +28,7 @@ static char const * const grep_usage[] =3D {

 static int use_threads =3D 1;

-#ifndef NO_PTHREADS
+#ifdef THREADED_GREP
 #define THREADS 8
 static pthread_t threads[THREADS];

@@ -274,7 +274,7 @@ static int wait_all(void)

 	return hit;
 }
-#else /* !NO_PTHREADS */
+#else /* THREADED_GREP */
 #define read_sha1_lock()
 #define read_sha1_unlock()

@@ -439,7 +439,7 @@ static int grep_sha1(struct grep_opt *opt, const un=
signed char *sha1,

 	name =3D strbuf_detach(&pathbuf, NULL);

-#ifndef NO_PTHREADS
+#ifdef THREADED_GREP
 	if (use_threads) {
 		grep_sha1_async(opt, name, sha1);
 		return 0;
@@ -501,7 +501,7 @@ static int grep_file(struct grep_opt *opt, const ch=
ar *filename)
 		strbuf_addstr(&buf, filename);
 	name =3D strbuf_detach(&buf, NULL);

-#ifndef NO_PTHREADS
+#ifdef THREADED_GREP
 	if (use_threads) {
 		grep_file_async(opt, name, filename);
 		return 0;
@@ -902,7 +902,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	if ((opt.regflags !=3D REG_NEWLINE) && opt.fixed)
 		die("cannot mix --fixed-strings and regexp");

-#ifndef NO_PTHREADS
+#ifdef THREADED_GREP
 	if (online_cpus() =3D=3D 1 || !grep_threads_ok(&opt))
 		use_threads =3D 0;

--=20
1.7.0.rc0.1096.g3300c.dirty
