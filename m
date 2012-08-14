From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: git on HP NonStop
Date: Tue, 14 Aug 2012 17:52:50 +0200
Message-ID: <004b01cd7a34$dbf2c160$93d84420$@schmitz-digital.de>
References: <001101cd79f2$f21b3bd0$d651b370$@schmitz-digital.de> <7vr4r98rfd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 17:53:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1JQW-0002Rq-Du
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 17:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab2HNPw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 11:52:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:53190 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab2HNPw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 11:52:57 -0400
Received: from DualCore (dsdf-4d0a02a3.pool.mediaWays.net [77.10.2.163])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0Lsaqr-1ThQfG2VdB-012KbH; Tue, 14 Aug 2012 17:52:55 +0200
In-Reply-To: <7vr4r98rfd.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHB61oVp3im4Dlw7d/lKpMa4E4AEgJhlvNkl11zgdA=
Content-Language: de
X-Provags-ID: V02:K0:qFMhoQTqdlA/wHX5BXE7JmGZtRiWXCE50VTeQdN2jns
 8H9hj5uJjaGcWXwBLtTQm95y8oUpHDh1hr3C+2whpdXRP1mJPP
 9JQGRtSyZO49T4nZX8y4rGaRkJbIpAICVxJVnZ22Lqz1EOFivJ
 Yph2zyz4mwZtsoom8Z7WfKulkUTXEcAnZ32ucX47w5WIeB2CK4
 XiNES71qAUMZKkQGidK4fCvSioTyYqxeo+aeZs5JC4++h/f2Sb
 N2r8UzK0bulfGUrLkMCQK0MLyA3gWo4WU8B/8eWxvO6jmHpMtK
 RPIqAKpxrEkd3DXXzvw5jyEARr6yfvyhwZANVTjZ3aqLPRiPlE
 vVL3DmvZJAn70FHH+LkToFvOGueMj0MkudQwNiMNIKk6pJCID9
 DqH90EcxwtiMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203406>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, August 14, 2012 4:44 PM
> To: Joachim Schmitz
> Subject: Re: git on HP NonStop
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Interesting, I never mentioned Tandem did I, But still you recognized
> > HP NonStop as that.
> 
> No, *you* did in your patch "#ifdef".

Ah, I see.

> > Well, I do care about that platform,  but if you don't, there's not
> > much point in me trying to get Tandem specific patches applied, is it?
> 
> As long as the change is isolated (i.e. compilation without "#define
TANDEM"

__TANDEM actually

> for other people will produce byte-for-byte identical result as before),
and
> cleanly made (i.e. the resulting source code is not littered with "#ifdef
> TANDEM" in many places), I do not think there is a reason not to have such
a
> patchset.

It isn't in many places, only 2 places in git-compat-util.h so far:
/usr/local/bin/diff -EBbu ./git-compat-util.h.orig ./git-compat-util.h
--- ./git-compat-util.h.orig    2012-07-30 15:50:38 -0500
+++ ./git-compat-util.h 2012-08-12 11:26:46 -0500
@@ -74,7 +74,8 @@
 # define _XOPEN_SOURCE 500
 # endif
 #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) &&
\
-      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__)
+      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
+      !defined(__TANDEM)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs
600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
 @@ -98,6 +99,11 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
+#ifdef __TANDEM
+# include <strings.h> /* for strcasecmp() */
+  typedef int intptr_t; /* not "int *" ?!? */
+  typedef unsigned int uintptr_t; /* not "unsigned int *" ?!? */
+#endif
 #include <errno.h>
 #include <limits.h>
 #include <sys/param.h>

Too much? The 2nd part is not necessary NonStop specific, any idea for a
better way?

There there's Makefile:
/usr/local/bin/diff -EBbu ./Makefile.orig ./Makefile
--- ./Makefile.orig     2012-07-30 15:50:38 -0500
+++ ./Makefile  2012-08-14 06:07:16 -0500
@@ -1297,6 +1297,45 @@
        NO_CURL =
        NO_EXPAT =
 endif
+ifeq ($(uname_S),NONSTOP_KERNEL)
+       CC = cc -c99 # needs some C99 features, "inline" is just one of them
+       CFLAGS= -g -O
+       prefix = /usr/local
+
+       # as detected by './configure'
+       #NO_CURL = YesPlease # missdetected, disabled, see below
+       NEEDS_SSL_WITH_CURL = YesPlease # added manually, see above
+       HAVE_LIBCHARSET_H=YesPlease
+       NEEDS_LIBICONV = YesPlease # needs libiconv first, changed further
down
+       NO_SYS_SELECT_H=UnfortunatelyYes
+       NO_D_TYPE_IN_DIRENT = YesPlease
+       NO_HSTRERROR=YesPlease
+       NO_STRCASESTR=YesPlease
+       NO_FNMATCH_CASEFOLD = YesPlease
+       NO_MEMMEM = YesPlease
+       NO_STRLCPY = YesPlease
+       NO_SETENV = YesPlease
+       NO_UNSETENV = YesPlease
+       NO_MKDTEMP = YesPlease
+       NO_MKSTEMPS = YesPlease
+       OLD_ICONV=UnfortunatelyYes # currently libiconv-1.9.1
+       NO_REGEX=YesPlease # Why? ToDo?
+       NO_PTHREADS=UnfortunatelyYes # ToDo? Using PUT, maybe?
+
+       # our's are in ${prefix}/bin
+       PERL_PATH = ${prefix}/bin/perl
+       PYTHON_PATH = ${prefix}/bin/python
+
+       # not detected (nor checked for) by './configure'
+       COMPAT_CFLAGS += -DSA_RESTART=0 # we don't have SA_RESTART on
NonStop
+       COMPAT_CFLAGS += -DHAVE_STRING_H=1 # needed in
compat/fnmatch/fnmatch.c
+       NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease # we don't have that on
NonStop
+       NO_NSEC = YesPlease # we don't have that on NonStop
+       NO_PREAD = YesPlease # we could use floss_pread though?
+       NO_MMAP = YesPlease # we could use floss_mmap though?
+       # newly implemented further down
+       NO_POLL = YesPlease # we could use floss_poll though?
+endif
 ifneq (,$(findstring MINGW,$(uname_S)))
        pathsep = ;
        NO_PREAD = YesPlease
@@ -1526,6 +1565,11 @@
        LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto
 endif
 endif
+ifndef NO_GETTEXT
+ifndef LIBC_CONTAINS_LIBINTL
+       EXTLIBS += -lintl
+endif
+endif
 ifdef NEEDS_LIBICONV
        ifdef ICONVDIR
                BASIC_CFLAGS += -I$(ICONVDIR)/include
@@ -1538,11 +1582,6 @@
 ifdef NEEDS_LIBGEN
        EXTLIBS += -lgen
 Endif
-ifndef NO_GETTEXT
-ifndef LIBC_CONTAINS_LIBINTL
-       EXTLIBS += -lintl
-endif
-endif
 ifdef NEEDS_SOCKET
        EXTLIBS += -lsocket
 endif
@@ -1591,6 +1630,11 @@
        BASIC_CFLAGS += -DNO_GETTEXT
        USE_GETTEXT_SCHEME ?= fallthrough
 endif
+ifdef NO_POLL
+       NO_SYS_POLL_H = YesPlease
+       COMPAT_CFLAGS += -DNO_POLL -Icompat/win32 # so it finds poll.h
+       COMPAT_OBJS += compat/win32/poll.o
+endif
 ifdef NO_STRCASESTR
        COMPAT_CFLAGS += -DNO_STRCASESTR
        COMPAT_OBJS += compat/strcasestr.o

How das that look to you?

> >> Finally, I would prefer to see any message that is addressed to me as
> >> the project maintainer to be Cc'ed to the list.  I feel 80% of my
> >> time writing
> > this
> >> message wasted, as the contents of it would have helped not just you
> >> but 4 other people who want to get their toes in the development
> >> community, but you robbed them the chance of seeing it.
> >
> > Sorry for having wasted your time, but you could just as easily have
> > CCed the list on your reply, couldn't you?
> 
> No, responding to a private message in public without permission goes
against
> generally accepted netiquette (I am OK if you respond to this or to the
previous
> message from me in public).

OK, understood and accepted. Herewith you have my permission ;-)

> > The use of getrlimit(RLIMIT_NOFILE, ...) vs. sysconf(_SC_OPEN_MAX) in
> > sha1_file.c, I believe the later to be more portable, also it is used
> > in other places already (namely compat/win32/poll.c)
> 
> Careful.  Getting rid of the use of getrlimit() from shared code by
introducing
> our own abstraction to be implemented in compat/* for each platform is
fine,
> but that does not mean sysconf() is acceptable by all platforms (your
finding
> use of sysconf() in compat/win32 merely means Win is OK with it).

Well. NonStop is OK with it too. 
And I've brackets with #ifdef _SC_OPEN_MAX, just like in compat/win23:
/usr/local/bin/diff -EBbu ./sha1_file.c.orig ./sha1_file.c
--- ./sha1_file.c.orig  2012-07-30 15:50:38 -0500
+++ ./sha1_file.c       2012-08-14 02:42:03 -0500
@@ -747,6 +747,9 @@
                return error("packfile %s index unavailable", p->pack_name);

        if (!pack_max_fds) {
+#ifdef _SC_OPEN_MAX
+               unsigned int max_fds = sysconf(_SC_OPEN_MAX);
+#else
                struct rlimit lim;
                unsigned int max_fds;

@@ -754,6 +757,7 @@
                        die_errno("cannot get RLIMIT_NOFILE");

                max_fds = lim.rlim_cur;
+#endif

                /* Save 3 for stdin/stdout/stderr, 22 for work */
                if (25 < max_fds)
 
Can it get any better?

> > The use of curl_easy_strerror() in help.c without checking for a
> > proper curl version (>=7.12.0)
> 
> I do not recall the minimum version of curl we support offhand, but if
there is a
> clean workaround that would be good.

Well, I really have none but to disable that part:
/usr/local/bin/diff -EBbu ./http.c.orig ./http.c
--- ./http.c.orig       2012-07-30 15:50:38 -0500
+++ ./http.c    2012-08-14 02:49:43 -0500
@@ -805,10 +805,12 @@
                                ret = HTTP_REAUTH;
                        }
                } else {
+#if LIBCURL_VERSION_NUM >= 0x070c00 /* no curl_easy_strerror() before that
*/
                        if (!curl_errorstr[0])
                                strlcpy(curl_errorstr,
 
curl_easy_strerror(results.curl_result),
                                        sizeof(curl_errorstr));
+#endif
                        ret = HTTP_ERROR;
                }
        } else {


It certainly is a workaround, whether it is clean or clean enough for now is
to you to decide ;-)

Bye, Jojo
