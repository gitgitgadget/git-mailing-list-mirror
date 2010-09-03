From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/3] gettext: Add GETTEXT_POISON=YesPlease Makefile parameter
Date: Fri,  3 Sep 2010 23:24:55 +0000
Message-ID: <1283556296-7365-3-git-send-email-avarab@gmail.com>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 01:26:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrfeD-0005KR-Fh
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 01:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104Ab0ICXZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 19:25:31 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54452 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab0ICXZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 19:25:16 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so3265439wwj.1
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 16:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Ids+IBqS+h8cr0y/bqOlrqx2sOAQfKY1jiKOXGga4+M=;
        b=L7/XgTGBCKbt8lGhKMIEMD6EPoe6IkkV1ftbqivuOcbiXdgKxCML06qiqaifck/TxG
         5nKNrNo7ROA93UfB4SgztaIfukYAjwMbQM7CwaRFxS8ao6srAfAZJ0xrNQpUvv7yKE0V
         Yg03ztYMzDqDjtiX72b1IBg4LiDU0KHbJigPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=K3CvRSH6d+HwQt2S6X9avJ8fFgs6qlJTyCd+eKOyCd3duh9ZNh6O/IVLgoRfDGFQZy
         Q2l+LbFENpgf2F/5r87tcZHop/vImH2s15NuND/G+7actkGjh9e7HsAdVzTeN05ibQDZ
         N4MYSgz7Qrg74lbtT2BC7wkuMiexheuF4I2Tk=
Received: by 10.227.128.82 with SMTP id j18mr240175wbs.36.1283556315776;
        Fri, 03 Sep 2010 16:25:15 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm2047451wbb.2.2010.09.03.16.25.14
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 16:25:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.336.g704fc
In-Reply-To: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155286>

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
index 7fd43ec..b6a734c 100644
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
@@ -1506,6 +1510,10 @@ ifdef NEEDS_LIBINTL
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
@@ -2059,6 +2067,7 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
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
index 3a39c6f..dc55c78 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -921,6 +921,7 @@ esac
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
+test -z "$GETTEXT_POISON" && test_set_prereq NO_GETTEXT_POISON
=20
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
--=20
1.7.2.2.336.g704fc
