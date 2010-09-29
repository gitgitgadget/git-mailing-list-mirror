From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] gettext: use libcharset when available
Date: Wed, 29 Sep 2010 13:07:17 +0000
Message-ID: <1285765637-16381-1-git-send-email-avarab@gmail.com>
References: <AANLkTikMWy2a0M6bFMj+Jb+2QewUGsUjMsbv=XyR1Tr9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 15:07:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0wNi-000097-ID
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 15:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab0I2NH3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 09:07:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59735 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab0I2NH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 09:07:28 -0400
Received: by fxm14 with SMTP id 14so400375fxm.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mH42SHN+iJOQgAsCHiSciHRy2v89aLsaq91TVGFA5jY=;
        b=SEwSF7ZJcNleKzmynZa1Bjm2Mz5WgrpibbL7IYpTScnCTM3xhZntBkrNdLw2iqsisF
         eL7tQ6p5h8qDZLLyTDCEGowE9FuO+4DoLt1eou797jBcnqh0nqlK5HTwJA9+SoaVbSFs
         g/++HaZaJEuyppu2mYv2qys04aRouwD4UVYKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cKcaL+QhGVy4U24EwwlYLfq13obmWNE8CQj3mlIoXygHGQuJHIDDGHhNw5xSZ6HVRC
         oNBFiEGsR5+FTnRTuS/1oZ9jlYTmuWYxvnERrrf4qvfYax01xbNbDlNRpyIt2xAoWDcD
         F84Tve+rzzPVZ1Vvjdh0hQwXNCE+OcKFv53rs=
Received: by 10.223.106.142 with SMTP id x14mr1716298fao.21.1285765646669;
        Wed, 29 Sep 2010 06:07:26 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p2sm3743764fak.22.2010.09.29.06.07.24
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 06:07:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <AANLkTikMWy2a0M6bFMj+Jb+2QewUGsUjMsbv=XyR1Tr9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157563>

=46rom: Erik Faye-Lund <kusmabite@gmail.com>

Change the git_setup_gettext function to use libcharset to query the
character set of the current locale if it's available. I.e. use it
instead of nl_langinfo if HAVE_LIBCHARSET_H is set.

The GNU gettext manual recommends using langinfo.h's
nl_langinfo(CODESET) to acquire the current character set, but on
systems that have libcharset.h's locale_charset() using the latter is
either saner, or the only option on those systems.

GNU and Solaris have a nl_langinfo(CODESET), FreeBSD can use either,
but MingW and some others need to use libcharset.h's locale_charset()
instead.

Since locale_charset returns a const char* instead of char* as
nl_langinfo does the type of the variable we're using to store the
charset in git_setup_gettext has been changed.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Junio, this goes on top of ab/i18n.

On Wed, Sep 29, 2010 at 11:41, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Wed, Sep 29, 2010 at 12:00 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
> <avarab@gmail.com> wrote:
>> On Tue, Sep 28, 2010 at 21:47, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
>>> On Tue, Sep 28, 2010 at 8:29 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason
>>>>  * Added defaults for NO_LIBCHARSET to the default, I only changed=
 the
>>>>   defaults for the MINGW entry, maybe it should be changed on Cygw=
in
>>>>   and Windows too? And probably on OpenBSD and NetBSD too.
>>>>
>>>
>>> I don't think NO_LIBCHARSET should be the default. libcharset is
>>> reported to be a bit better than nl_langinfo at normalizing the
>>> encoding, and GNU gettext depends on libcharset (through libiconv,
>>> which libcharset is distributed with). So in the case of a GNU
>>> gettext, libcharset should really be present.
>>
>> I can't find any package (with apt-file) on Debian or Ubuntu that
>> provides libcharset.h, but I have langinfo.h on those systems.
>>
>
> Strange. A 'make install' on libiconv installed libcharset.h to
> $prefix/include on my system. But looking a bit deeper, it seems that
> glibc supplies it's own iconv implementation (perhaps based on
> libiconv, I don't know). So yes, I tend to agree with you. GNU
> platforms should not be expected to have libcharset.

I asked around and none of Debian/Ubuntu/Fedora and other Linux
systems have libcharset.h, and using the gettext branch without
libcharset.h on FreeBSD works fine.

>> The GNU gettext manual also reccomends the use of nl_langinfo in
>> "11.2.4 How to specify the output character set `gettext' uses", so =
it
>> seems that using that and not libiconv is the default way of doing
>> things on GNU gettext + GNU libc systems.
>>
>
> OK, fair enough. I based my comment on some comment by the GNU gettex=
t
> maintainer (who is also the libcharset maintainer - libcharset does i=
n
> fact use nl_langinfo if present), but since this is in the manual I
> fully withdraw my comment.
>
> Then again, if this is an opt-in rather than an opt-out, perhaps we
> should change the switch to HAVE_LIBCHARSET? I don't mean to go in
> circles here, but it sounds more self-documenting to me.

Agreed, changed in this version. I also added a bit to config.mak.in
to make the configure.ac change actually do something, and changed the
docs & commit message.

 Makefile      |   17 +++++++++++++++++
 config.mak.in |    1 +
 configure.ac  |    6 ++++++
 gettext.c     |   10 +++++++++-
 4 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 680e578..a05396b 100644
--- a/Makefile
+++ b/Makefile
@@ -43,6 +43,12 @@ all::
 # on platforms where we don't expect glibc (Linux, Hurd,
 # GNU/kFreeBSD), which includes libintl.
 #
+# Define HAVE_LIBCHARSET_H if you haven't set NO_GETTEXT and you can't
+# trust the langinfo.h's nl_langinfo(CODESET) function to return the
+# current character set. GNU and Solaris have a nl_langinfo(CODESET),
+# FreeBSD can use either, but MingW and some others need to use
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
