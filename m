From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 26/63] gettext tests: add GETTEXT_POISON=YesPlease Makefile parameter
Date: Sat,  4 Sep 2010 22:10:25 +0000
Message-ID: <1283638229-14199-6-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Sam Reed <sam@reedyboy.net>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 00:11:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os0x4-0003Lx-SO
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab0IDWK7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 18:10:59 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37424 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab0IDWK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 18:10:58 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so4554637wwj.1
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 15:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Ous4fBUsysq/kI2YqCspwIObAvy4lWtMF+nZN0J33qw=;
        b=N2JatWC/Pd0zrVKQuP82BbmcCp3OtJMNYakjFNyK4zODgvBlJIazF/wiFIE3QzR6bm
         Ac/24lFY0oyvtZ1cyYv3EYgndyfyoUufmw4AC/X/NYLM5t1QiJniWV0vd3Nxydb7igEk
         N34bE+boz0XPtVWIJrQZ1BFPheOuiisUQ6dew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uIN/R3m+LbzB74FugxddGdgrIH7ILEKJOxABRTYPYE0nn/1flNYCbNyYEJ8UNWOJI4
         DMNU85vtBGf8oEoCYVuk5wF3seSLkclQquHRNGFi8a0Jy10WHJ+iHdKWjbKC4WCWCo17
         JkjtTod+dEYoEUD4t8v1Thqyiv02+LWmSRh6U=
Received: by 10.216.237.100 with SMTP id x78mr1516290weq.114.1283638257854;
        Sat, 04 Sep 2010 15:10:57 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k15sm2261604wer.23.2010.09.04.15.10.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 15:10:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155369>

Add a new GETTEXT_POISON=3DYesPlease Makefile debug target. With this
target every invocation of _(s) will return "# GETTEXT POISON #"
instead of `s' or the msgstr that `s` would look up.

This target is intended to sanity check the gettextization series
against the test suite.

If the test suite is relying on the US English output of Git the test
should either have a NO_GETTEXT_POISON prerequisite, or the message in
question shouldn't be translated because it's a plumbing message.

We won't catch everything with this since we don't have 100% test
coverage, but the chances of us doing so are much larger.

The reason I'm using "# GETTEXT POISON #" is that a lot of tests that
rely on the fake editor would break if it wasn't a comment, since the
comment message that's inserted on e.g. `git commit --amend' is
translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile      |    9 +++++++++
 gettext.h     |    4 ++++
 t/test-lib.sh |    1 +
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 4d2d4c7..f26fca3 100644
--- a/Makefile
+++ b/Makefile
@@ -43,6 +43,10 @@ all::
 # on platforms where we don't expect glibc (Linux, Hurd,
 # GNU/kFreeBSD), which includes libintl.
 #
+# Define GETTEXT_POISON to turn all strings that use gettext into
+# gibberish. This option should only be used by the Git developers to
+# check that the Git gettext implementation itself is sane.
+#
 # Define EXPATDIR=3D/foo/bar if your expat header and library files ar=
e in
 # /foo/bar/include and /foo/bar/lib directories.
 #
@@ -1507,6 +1511,10 @@ ifdef NEEDS_LIBINTL
 	EXTLIBS +=3D -lintl
 endif
=20
+ifdef GETTEXT_POISON
+	COMPAT_CFLAGS +=3D -DGETTEXT_POISON
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=3DNoThanks
 endif
@@ -2065,6 +2073,7 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=3DYesPlease >>$@
 endif
 	@echo NO_GETTEXT=3D\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\=
' >>$@
+	@echo GETTEXT_POISON=3D\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POI=
SON)))'\' >>$@
=20
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/gettext.h b/gettext.h
index e02939a..94ab0f3 100644
--- a/gettext.h
+++ b/gettext.h
@@ -11,8 +11,12 @@ extern void git_setup_gettext(void);
 #ifdef NO_GETTEXT
 #define _(s) (s)
 #else
+#ifndef GETTEXT_POISON
 #include <libintl.h>
 #define _(s) gettext(s)
+#else
+#define _(s) "# GETTEXT POISON #"
+#endif
 #endif
=20
 #endif
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3fcb272..b297ef6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -963,6 +963,7 @@ esac
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
+test -z "$GETTEXT_POISON" && test_set_prereq NO_GETTEXT_POISON
=20
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
--=20
1.7.2.3.313.gcd15
