From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/5] compat: add strtok_r()
Date: Fri, 13 Aug 2010 18:59:40 -0500
Message-ID: <20100813235940.GD2153@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
 <20100813000848.GA8076@burratino>
 <4C65BA46.9010604@kdbg.org>
 <20100813234723.GC2153@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 14 02:02:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok4CO-00013G-PT
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 02:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114Ab0HNABw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 20:01:52 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64026 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab0HNABv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 20:01:51 -0400
Received: by vws3 with SMTP id 3so1671758vws.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 17:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aUjMMCL3HhRZsOpOJc8p/80XOg4Vd1cW420Ic9b+0V0=;
        b=Wj3AxYFHay4J0/dEYabKn8qhYZEuan5DQAEm/4/g7rHp7XbNXkgKInCLgO/SYRX4Ik
         yp5W2Fe9OGadBJHGNVlhDK35vASR2g+iZF6ETE0NgWPZkZIn82uMMC4eCFqX40xCDPfo
         xyYX44kQfKXg3gwuq2ec18I5fzRQaRzmE4cPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tGi2hIYoT9JSx5fuQzU6RtUqMEYoI8g5PvVOVpvCVLFRVN6tToHF16f491RgY9h1rG
         tqygAupJp94rznWtqOexbSo5f9wWj+exaKAVUyZGJe5P868/bBucUoWayF3wNwfl69Ft
         z5/Ql7GyiCpHcYYX0upURiNpynQJD+36b2TwM=
Received: by 10.220.60.70 with SMTP id o6mr1318129vch.2.1281744110298;
        Fri, 13 Aug 2010 17:01:50 -0700 (PDT)
Received: from burratino ([64.134.175.141])
        by mx.google.com with ESMTPS id d12sm1228658vcn.14.2010.08.13.17.01.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 17:01:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100813234723.GC2153@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153530>

Windows does not have strtok_r (and while it does have an identical
strtok_s, but it is not obvious how to use it).  Grab an
implementation from glibc.

The svn-fe tool uses strtok_r to parse paths.

Acked-by: Johannes Sixt <j6t@kdbg.org>
Helped-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I have carried over Hannes=E2=80=99s ack; hopefully that is okay.

 Makefile          |    8 +++++++
 compat/strtok_r.c |   61 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 config.mak.in     |    1 +
 configure.ac      |    6 +++++
 git-compat-util.h |    5 ++++
 5 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100644 compat/strtok_r.c

diff --git a/Makefile b/Makefile
index 9643b89..ec46ec4 100644
--- a/Makefile
+++ b/Makefile
@@ -68,6 +68,8 @@ all::
 #
 # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
 #
+# Define NO_STRTOK_R if you don't have strtok_r in the C library.
+#
 # Define NO_LIBGEN_H if you don't have libgen.h.
 #
 # Define NEEDS_LIBGEN if your libgen needs -lgen when linking
@@ -1041,6 +1043,7 @@ ifeq ($(uname_S),Windows)
 	NO_UNSETENV =3D YesPlease
 	NO_STRCASESTR =3D YesPlease
 	NO_STRLCPY =3D YesPlease
+	NO_STRTOK_R =3D YesPlease
 	NO_MEMMEM =3D YesPlease
 	# NEEDS_LIBICONV =3D YesPlease
 	NO_ICONV =3D YesPlease
@@ -1095,6 +1098,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_UNSETENV =3D YesPlease
 	NO_STRCASESTR =3D YesPlease
 	NO_STRLCPY =3D YesPlease
+	NO_STRTOK_R =3D YesPlease
 	NO_MEMMEM =3D YesPlease
 	NEEDS_LIBICONV =3D YesPlease
 	OLD_ICONV =3D YesPlease
@@ -1325,6 +1329,10 @@ endif
 ifdef NO_STRTOULL
 	COMPAT_CFLAGS +=3D -DNO_STRTOULL
 endif
+ifdef NO_STRTOK_R
+	COMPAT_CFLAGS +=3D -DNO_STRTOK_R
+	COMPAT_OBJS +=3D compat/strtok_r.o
+endif
 ifdef NO_SETENV
 	COMPAT_CFLAGS +=3D -DNO_SETENV
 	COMPAT_OBJS +=3D compat/setenv.o
diff --git a/compat/strtok_r.c b/compat/strtok_r.c
new file mode 100644
index 0000000..7b5d568
--- /dev/null
+++ b/compat/strtok_r.c
@@ -0,0 +1,61 @@
+/* Reentrant string tokenizer.  Generic version.
+   Copyright (C) 1991,1996-1999,2001,2004 Free Software Foundation, In=
c.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful=
,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include "../git-compat-util.h"
+
+/* Parse S into tokens separated by characters in DELIM.
+   If S is NULL, the saved pointer in SAVE_PTR is used as
+   the next starting point.  For example:
+	char s[] =3D "-abc-=3D-def";
+	char *sp;
+	x =3D strtok_r(s, "-", &sp);	// x =3D "abc", sp =3D "=3D-def"
+	x =3D strtok_r(NULL, "-=3D", &sp);	// x =3D "def", sp =3D NULL
+	x =3D strtok_r(NULL, "=3D", &sp);	// x =3D NULL
+		// s =3D "abc\0-def\0"
+*/
+char *
+gitstrtok_r (char *s, const char *delim, char **save_ptr)
+{
+  char *token;
+
+  if (s =3D=3D NULL)
+    s =3D *save_ptr;
+
+  /* Scan leading delimiters.  */
+  s +=3D strspn (s, delim);
+  if (*s =3D=3D '\0')
+    {
+      *save_ptr =3D s;
+      return NULL;
+    }
+
+  /* Find the end of the token.  */
+  token =3D s;
+  s =3D strpbrk (token, delim);
+  if (s =3D=3D NULL)
+    /* This token finishes the string.  */
+    *save_ptr =3D token + strlen (token);
+  else
+    {
+      /* Terminate the token and make *SAVE_PTR point past it.  */
+      *s =3D '\0';
+      *save_ptr =3D s + 1;
+    }
+  return token;
+}
diff --git a/config.mak.in b/config.mak.in
index b4e65c3..4ffd774 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -46,6 +46,7 @@ NO_IPV6=3D@NO_IPV6@
 NO_C99_FORMAT=3D@NO_C99_FORMAT@
 NO_HSTRERROR=3D@NO_HSTRERROR@
 NO_STRCASESTR=3D@NO_STRCASESTR@
+NO_STRTOK_R=3D@NO_STRTOK_R@
 NO_MEMMEM=3D@NO_MEMMEM@
 NO_STRLCPY=3D@NO_STRLCPY@
 NO_UINTMAX_T=3D@NO_UINTMAX_T@
diff --git a/configure.ac b/configure.ac
index 5601e8b..708e7b8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -783,6 +783,12 @@ GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=3DYesPlease])
 AC_SUBST(NO_STRCASESTR)
 #
+# Define NO_STRTOK_R if you don't have strtok_r
+GIT_CHECK_FUNC(strtok_r,
+[NO_STRTOK_R=3D],
+[NO_STRTOK_R=3DYesPlease])
+AC_SUBST(NO_STRTOK_R)
+#
 # Define NO_MEMMEM if you don't have memmem.
 GIT_CHECK_FUNC(memmem,
 [NO_MEMMEM=3D],
diff --git a/git-compat-util.h b/git-compat-util.h
index 02a73ee..28d6b00 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -312,6 +312,11 @@ extern size_t gitstrlcpy(char *, const char *, siz=
e_t);
 extern uintmax_t gitstrtoumax(const char *, char **, int);
 #endif
=20
+#ifdef NO_STRTOK_R
+#define strtok_r gitstrtok_r
+extern char *gitstrtok_r(char *s, const char *delim, char **save_ptr);
+#endif
+
 #ifdef NO_HSTRERROR
 #define hstrerror githstrerror
 extern const char *githstrerror(int herror);
--=20
1.7.2.1.544.ga752d.dirty
