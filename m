From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] tests: add GETTEXT_POISON to simulate unfriendly
 translator
Date: Sun, 20 Feb 2011 22:03:13 -0600
Message-ID: <20110221040313.GD26968@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 05:03:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrMzc-0006xW-BB
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 05:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182Ab1BUEDT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 23:03:19 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62712 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152Ab1BUEDS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 23:03:18 -0500
Received: by iwn8 with SMTP id 8so1483209iwn.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 20:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=d5FhuzKqb7mPPvoWESJdedU1G4BBjg1svhhin4k4rC0=;
        b=d7L7QsDCS3TZW6JHg51Gk7woyCRivGo1wGkSC7dM0KkpsOhMp2TJuV5r+NknzOnQ48
         3k0YzhKwU285uYboZadlfpaBe2ccIKPEZIvgQZuK9NxGmFzRc6O00gWksPN1H9x8mRVn
         6ITjhwIXDUlEhKrEv14LVm1RCYg+abRQsjHzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cjddlKOko62SDQyYT6GxfHKXqRGkRz4ncYgfJS8xgg55ss+DRwM10q1DQAWlkTdB0P
         SCd8/s9CE2Y28VnmpJ0YTWGG3SqN0E4+xFsWU5uUStFuJeGcc2IT7Xlel8SzF3NnEZ4y
         pL++hzw9rlMnUj4hAtDUOR/9CXOSEflO7kQRo=
Received: by 10.42.224.136 with SMTP id io8mr1353483icb.202.1298260998316;
        Sun, 20 Feb 2011 20:03:18 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id u9sm4731379ibe.8.2011.02.20.20.03.16
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 20:03:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221040012.GB26968@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167438>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Add a new GETTEXT_POISON Makefile parameter.  When it is set, every
invocation of _(s) will return a nonsense string instead of 's' or an
actual translation of 's'.  By setting this parameter, we can make
sure that none of the strings marked for translation are functionally
important.

When tests are checking specific (US English) output from Git, they
should add a C_LOCALE_OUTPUT prerequisite.  Running through tests in
this way can help to find messages that should not be translated
because they are part of the git plumbing.

The poison string is "# GETTEXT POISON #", so it is still a valid
comment that is safe to put at the end of the message shown by 'git
commit --amend' and so on.  That simplifies life until git can learn
to add the "# " comment markers itself instead of relying on
translators to remember them.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile      |    7 +++++++
 gettext.h     |    8 +++++++-
 t/test-lib.sh |    3 +++
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c153f45..c348bb7 100644
--- a/Makefile
+++ b/Makefile
@@ -216,6 +216,9 @@ all::
 #
 # Define NO_REGEX if you have no or inferior regex support in your C l=
ibrary.
 #
+# Define GETTEXT_POISON if you are debugging the choice of strings mar=
ked
+# for translation.  This will turn all strings that use gettext into g=
ibberish.
+#
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
 #
@@ -1370,6 +1373,9 @@ endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS +=3D -DNO_SYMLINK_HEAD
 endif
+ifdef GETTEXT_POISON
+	BASIC_CFLAGS +=3D -DGETTEXT_POISON
+endif
 ifdef NO_STRCASESTR
 	COMPAT_CFLAGS +=3D -DNO_STRCASESTR
 	COMPAT_OBJS +=3D compat/strcasestr.o
@@ -2089,6 +2095,7 @@ endif
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=3DYesPlease >>$@
 endif
+	@echo GETTEXT_POISON=3D\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POI=
SON)))'\' >>$@
=20
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/gettext.h b/gettext.h
index dc44825..6daa57c 100644
--- a/gettext.h
+++ b/gettext.h
@@ -15,9 +15,15 @@
=20
 #define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
=20
+#ifdef GETTEXT_POISON
+#define use_poison() 1
+#else
+#define use_poison() 0
+#endif
+
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
-	return msgid;
+	return use_poison() ? "# GETTEXT POISON #" : msgid;
 }
=20
 /* Mark msgid for translation but do not translate it. */
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fdc541..0840e4a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1079,6 +1079,9 @@ esac
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
=20
+# Can we rely on git's output in the C locale?
+test -z "$GETTEXT_POISON" && test_set_prereq C_LOCALE_OUTPUT
+
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
 rm -f y
--=20
1.7.4.1
