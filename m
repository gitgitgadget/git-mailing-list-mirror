From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3] gettext: use libcharset when available
Date: Wed, 29 Sep 2010 13:43:34 +0000
Message-ID: <1285767814-25857-1-git-send-email-avarab@gmail.com>
References: <1285767632-24852-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 15:44:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0wxU-0005vh-OO
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 15:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350Ab0I2Nnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 09:43:45 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62919 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201Ab0I2Nno (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 09:43:44 -0400
Received: by wwb39 with SMTP id 39so48653wwb.1
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ANAi1JH4x/zNAvghXEW+/S206NW0jR919aZhbTymn80=;
        b=ImVM87jxr/7VUhs/qlxzoYYQyJYD8Kmj5y7m7ERUMO6MTGr4dg3b57LqEbmdzjEfUH
         dGgncnS1Lo/NBycVPyspOshZSp2jULgs/8uvfxQVOMYaIwaTa+/4bWDF6T7MmmcoCvj3
         tBfldE4bP/j8c35XqX87clJuVbEhv7/npe2mE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=F8sBINDytC4IIPMjSa/GeZiZK4fYSslXfSnbkGuKVPYLo3Zlh3Z1Ltmiwq3cOJrQt4
         RLdQGB0+kh+YSi37z8pY9oQxZ/JKB8HpxXHb8uhPtMf0Kqym3ZPPt62+k1pZjkrVoR8o
         TfYPhVAA8egNfifccqzUm0b2dELTUcoDckbWM=
Received: by 10.227.145.66 with SMTP id c2mr1565987wbv.42.1285767822976;
        Wed, 29 Sep 2010 06:43:42 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id fz1sm7172437wbb.0.2010.09.29.06.43.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 06:43:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285767632-24852-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157570>

=46rom: Erik Faye-Lund <kusmabite@gmail.com>

Change the git_setup_gettext function to use libcharset to query the
character set of the current locale if it's available. I.e. use it
instead of nl_langinfo if HAVE_LIBCHARSET_H is set.

The GNU gettext manual recommends using langinfo.h's
nl_langinfo(CODESET) to acquire the current character set, but on
systems that have libcharset.h's locale_charset() using the latter is
either saner, or the only option on those systems.

GNU and Solaris have a nl_langinfo(CODESET), FreeBSD can use either,
but MinGW and some others need to use libcharset.h's locale_charset()
instead.

Since locale_charset returns a const char* instead of char* as
nl_langinfo does the type of the variable we're using to store the
charset in git_setup_gettext has been changed.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Wed, Sep 29, 2010 at 13:40, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> From: Erik Faye-Lund <kusmabite@gmail.com>
> On Wed, Sep 29, 2010 at 13:34, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>> Very minor nit: It's officially spelled MinGW, with an upper-case G.
>
> Did s/MingW/MinGW/ in the content & message in this v2.

Discard that one, I accidentally changed some unrelated mention of
MingW to MinGW.

 Makefile      |   17 +++++++++++++++++
 config.mak.in |    1 +
 configure.ac  |    6 ++++++
 gettext.c     |   10 +++++++++-
 4 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 680e578..49a3386 100644
--- a/Makefile
+++ b/Makefile
@@ -43,6 +43,12 @@ all::
 # on platforms where we don't expect glibc (Linux, Hurd,
 # GNU/kFreeBSD), which includes libintl.
 #
+# Define HAVE_LIBCHARSET_H if you haven't set NO_GETTEXT and you can't
+# trust the langinfo.h's nl_langinfo(CODESET) function to return the
+# current character set. GNU and Solaris have a nl_langinfo(CODESET),
+# FreeBSD can use either, but MinGW and some others need to use
+# libcharset.h's locale_charset() instead.
+#
 # Define GNU_GETTEXT if you're using the GNU implementation of
 # libintl. We define this everywhere except on Solaris, which has its
 # own gettext implementation. If GNU_GETTEXT is set we'll use GNU
@@ -792,6 +798,10 @@ ifndef NO_GETTEXT
 	# Systems that don't use GNU gettext are the exception. Only
 	# Solaris has a mature non-GNU gettext implementation.
 	GNU_GETTEXT =3D YesPlease
+
+	# Since we assume a GNU gettext by default we also assume a
+	# GNU-like langinfo.h by default
+	HAVE_LIBCHARSET_H =3D
 endif
=20
 # We choose to avoid "if .. else if .. else .. endif endif"
@@ -1180,6 +1190,9 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	EXTLIBS +=3D /mingw/lib/libz.a
 	NO_R_TO_GCC_LINKER =3D YesPlease
 	INTERNAL_QSORT =3D YesPlease
+ifndef NO_GETTEXT
+	HAVE_LIBCHARSET_H =3D YesPlease
+endif
 else
 	NO_CURL =3D YesPlease
 endif
@@ -1964,6 +1977,10 @@ config.s config.o: EXTRA_CPPFLAGS =3D -DETC_GITC=
ONFIG=3D'"$(ETC_GITCONFIG_SQ)"'
=20
 http.s http.o: EXTRA_CPPFLAGS =3D -DGIT_HTTP_USER_AGENT=3D'"git/$(GIT_=
VERSION)"'
=20
+ifdef HAVE_LIBCHARSET_H
+gettext.s gettext.o: EXTRA_CPPFLAGS =3D -DHAVE_LIBCHARSET_H
+endif
+
 ifdef NO_EXPAT
 http-walker.s http-walker.o: EXTRA_CPPFLAGS =3D -DNO_EXPAT
 endif
diff --git a/config.mak.in b/config.mak.in
index 9f47aa5..969cbaa 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -34,6 +34,7 @@ NO_CURL=3D@NO_CURL@
 NO_EXPAT=3D@NO_EXPAT@
 NO_LIBGEN_H=3D@NO_LIBGEN_H@
 HAVE_PATHS_H=3D@HAVE_PATHS_H@
+HAVE_LIBCHARSET_H=3D@HAVE_LIBCHARSET_H@
 NO_GETTEXT=3D@NO_GETTEXT@
 NEEDS_LIBICONV=3D@NEEDS_LIBICONV@
 NEEDS_SOCKET=3D@NEEDS_SOCKET@
diff --git a/configure.ac b/configure.ac
index 1821d89..b06bad1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -810,6 +810,12 @@ AC_CHECK_HEADER([libintl.h],
 [NO_GETTEXT=3DYesPlease])
 AC_SUBST(NO_GETTEXT)
 #
+# Define HAVE_LIBCHARSET_H if have libcharset.h
+AC_CHECK_HEADER([libcharset.h],
+[HAVE_LIBCHARSET_H=3DYesPlease],
+[HAVE_LIBCHARSET_H=3D])
+AC_SUBST(HAVE_LIBCHARSET_H)
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=3D],
diff --git a/gettext.c b/gettext.c
index 8644098..9bdac56 100644
--- a/gettext.c
+++ b/gettext.c
@@ -1,13 +1,17 @@
 #include "exec_cmd.h"
 #include <locale.h>
 #include <libintl.h>
+#ifdef HAVE_LIBCHARSET_H
+#include <libcharset.h>
+#else
 #include <langinfo.h>
+#endif
 #include <stdlib.h>
=20
 extern void git_setup_gettext(void) {
 	char *podir;
 	char *envdir =3D getenv("GIT_TEXTDOMAINDIR");
-	char *charset;
+	const char *charset;
=20
 	if (envdir) {
 		(void)bindtextdomain("git", envdir);
@@ -20,7 +24,11 @@ extern void git_setup_gettext(void) {
=20
 	(void)setlocale(LC_MESSAGES, "");
 	(void)setlocale(LC_CTYPE, "");
+#ifdef HAVE_LIBCHARSET_H
+	charset =3D locale_charset();
+#else
 	charset =3D nl_langinfo(CODESET);
+#endif
 	(void)bind_textdomain_codeset("git", charset);
 	(void)setlocale(LC_CTYPE, "C");
 	(void)textdomain("git");
--=20
1.7.3.159.g610493
