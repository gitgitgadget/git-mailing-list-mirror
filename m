From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v3 1/8] Makefile & configure: add a NO_FNMATCH flag
Date: Sun,  3 Oct 2010 09:56:39 +0000
Message-ID: <1286099806-25774-2-git-send-email-avarab@gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Brandon Casey <drafnel@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 11:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2LJu-0005Ca-M6
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 11:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab0JCJ5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 05:57:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45079 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0JCJ5K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 05:57:10 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so4121914wyb.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/oM81W8QVul3dCsYsvFWtfGzYb9YpkwJzVYwsakygbE=;
        b=E0bwJgKoac3agNqTVnl36TPPCHV59EIyCWD4o9z9WhsEbChMH+DYgwQ/LU/i1nFxvi
         R2RwyL4PD7S+9gkHL4K230lD4QGb+0iBB4Pz7tHMwX6ptEpCexIKSXr0JbGJ1Onh2BV8
         I8a14PmIcnoPAAm57QUUjGZkkquV66jmjszs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aopkucEMdb1FUbm+J6DFqw3HYZfTN12kwPmumlPe17PWNt2SpKf3Qfq3X7BUel8hPK
         yek/M3d/2lF2MdLpNiDOukbedFN1LjEcn3NOAtuKHAp8hCDxjL8yijKk8RhJklpuNSuB
         9TN3qvsjLoTccmt47tbGnzQCHcjCtHg+50D7g=
Received: by 10.227.43.11 with SMTP id u11mr6050140wbe.200.1286099829429;
        Sun, 03 Oct 2010 02:57:09 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id h29sm2968435wbc.9.2010.10.03.02.57.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 02:57:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <4CA847D5.4000903@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157851>

Windows and MinGW both lack fnmatch() in their C library and needed
compat/fnmatch, but they had duplicate code for adding the compat
function, and there was no Makefile flag or configure check for
fnmatch.

Change the Makefile it so that it's now possible to compile the compat
function with a NO_FNMATCH=3DYesPlease flag, and add a configure probe
for it.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile      |   18 +++++++++++++-----
 config.mak.in |    1 +
 configure.ac  |    6 ++++++
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 8a56b9a..f7c4383 100644
--- a/Makefile
+++ b/Makefile
@@ -70,6 +70,8 @@ all::
 #
 # Define NO_STRTOK_R if you don't have strtok_r in the C library.
 #
+# Define NO_FNMATCH if you don't have fnmatch in the C library.
+#
 # Define NO_LIBGEN_H if you don't have libgen.h.
 #
 # Define NEEDS_LIBGEN if your libgen needs -lgen when linking
@@ -1052,6 +1054,7 @@ ifeq ($(uname_S),Windows)
 	NO_STRCASESTR =3D YesPlease
 	NO_STRLCPY =3D YesPlease
 	NO_STRTOK_R =3D YesPlease
+	NO_FNMATCH =3D YesPlease
 	NO_MEMMEM =3D YesPlease
 	# NEEDS_LIBICONV =3D YesPlease
 	NO_ICONV =3D YesPlease
@@ -1081,8 +1084,8 @@ ifeq ($(uname_S),Windows)
 	AR =3D compat/vcbuild/scripts/lib.pl
 	CFLAGS =3D
 	BASIC_CFLAGS =3D -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbu=
ild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNING=
S -D_CRT_NONSTDC_NO_DEPRECATE
-	COMPAT_OBJS =3D compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi=
=2Eo compat/win32/pthread.o
-	COMPAT_CFLAGS =3D -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE=
_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Ic=
ompat/win32 -DSTRIP_EXTENSION=3D\".exe\"
+	COMPAT_OBJS =3D compat/msvc.o compat/winansi.o compat/win32/pthread.o
+	COMPAT_CFLAGS =3D -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE=
_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=3D\"=
=2Eexe\"
 	BASIC_LDFLAGS =3D -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOL=
E -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS =3D advapi32.lib shell32.lib wininet.lib ws2_32.lib
 	PTHREAD_LIBS =3D
@@ -1107,6 +1110,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_STRCASESTR =3D YesPlease
 	NO_STRLCPY =3D YesPlease
 	NO_STRTOK_R =3D YesPlease
+	NO_FNMATCH =3D YesPlease
 	NO_MEMMEM =3D YesPlease
 	NEEDS_LIBICONV =3D YesPlease
 	OLD_ICONV =3D YesPlease
@@ -1128,10 +1132,9 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PYTHON =3D YesPlease
 	BLK_SHA1 =3D YesPlease
 	ETAGS_TARGET =3D ETAGS
-	COMPAT_CFLAGS +=3D -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnm=
atch -Icompat/win32
+	COMPAT_CFLAGS +=3D -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/win=
32
 	COMPAT_CFLAGS +=3D -DSTRIP_EXTENSION=3D\".exe\"
-	COMPAT_OBJS +=3D compat/mingw.o compat/fnmatch/fnmatch.o compat/winan=
si.o \
-		compat/win32/pthread.o
+	COMPAT_OBJS +=3D compat/mingw.o compat/winansi.o compat/win32/pthread=
=2Eo
 	EXTLIBS +=3D -lws2_32
 	PTHREAD_LIBS =3D
 	X =3D .exe
@@ -1342,6 +1345,11 @@ ifdef NO_STRTOK_R
 	COMPAT_CFLAGS +=3D -DNO_STRTOK_R
 	COMPAT_OBJS +=3D compat/strtok_r.o
 endif
+ifdef NO_FNMATCH
+	COMPAT_CFLAGS +=3D -Icompat/fnmatch
+	COMPAT_CFLAGS +=3D -DNO_FNMATCH
+	COMPAT_OBJS +=3D compat/fnmatch/fnmatch.o
+endif
 ifdef NO_SETENV
 	COMPAT_CFLAGS +=3D -DNO_SETENV
 	COMPAT_OBJS +=3D compat/setenv.o
diff --git a/config.mak.in b/config.mak.in
index a0c34ee..aaa70a8 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -47,6 +47,7 @@ NO_C99_FORMAT=3D@NO_C99_FORMAT@
 NO_HSTRERROR=3D@NO_HSTRERROR@
 NO_STRCASESTR=3D@NO_STRCASESTR@
 NO_STRTOK_R=3D@NO_STRTOK_R@
+NO_FNMATCH=3D@NO_FNMATCH@
 NO_MEMMEM=3D@NO_MEMMEM@
 NO_STRLCPY=3D@NO_STRLCPY@
 NO_UINTMAX_T=3D@NO_UINTMAX_T@
diff --git a/configure.ac b/configure.ac
index cc55b6d..7715f6c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -818,6 +818,12 @@ GIT_CHECK_FUNC(strtok_r,
 [NO_STRTOK_R=3DYesPlease])
 AC_SUBST(NO_STRTOK_R)
 #
+# Define NO_FNMATCH if you don't have fnmatch
+GIT_CHECK_FUNC(fnmatch,
+[NO_FNMATCH=3D],
+[NO_FNMATCH=3DYesPlease])
+AC_SUBST(NO_FNMATCH)
+#
 # Define NO_MEMMEM if you don't have memmem.
 GIT_CHECK_FUNC(memmem,
 [NO_MEMMEM=3D],
--=20
1.7.3.159.g610493
