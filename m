From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] i18n: add no-op _() and N_() wrappers
Date: Sun, 20 Feb 2011 22:02:05 -0600
Message-ID: <20110221040205.GC26968@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 05:02:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrMyW-0006Z8-Je
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 05:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166Ab1BUECM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 23:02:12 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50490 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768Ab1BUECJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 23:02:09 -0500
Received: by iwn8 with SMTP id 8so1482580iwn.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 20:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Br3RQHGJ2UbaX2yrK8u6wP7w0JQijPas/+X5omhgwFE=;
        b=X3SzKryZbN06ezPddWoD4Q8nnFqlJ5SZZ6kHAvWDUD+UIDF+AMxwJfC57SfpqmjG0J
         9u/fi97a7ChxPP4JQBmb4alQjfvbuvabuI/NhwkV79b9zoAJ7uNJPQASiQde2wKyTdaq
         SCGZMZ9k6zyzNKwmutLtsKT0+/C678xBEAWkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=C9QbS2IQiIVJXKAfYSBt19fNmylgXh6xE/K1vOSz6trxVe8EiiBdI10g2Qn33ccw0k
         QIjcqOJLQjXc2wguUPCCAU/mIBNJna2/MIzNwILSn5+O4ht+lgmhk2/EPpHWuUP1wUkX
         qHLZ4qNY0Z/R6y+KZfPSgcnTWk4CtGiSxgJD4=
Received: by 10.231.85.137 with SMTP id o9mr829510ibl.27.1298260929263;
        Sun, 20 Feb 2011 20:02:09 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id i16sm4726698ibl.12.2011.02.20.20.02.07
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 20:02:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221040012.GB26968@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167437>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

The _ function is meant to be used to translate strings into the
user's chosen language.

The N_ macro is a marker for xgettext to find translatable strings
in contexts where a function call cannot be used directly, like so:

	const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] =3D {
		/* ERROR_WOULD_OVERWRITE */
		N_("Entry '%s' would be overwritten by merge. Cannot merge."),
	[...]

Its result is still untranslated and should be fed to _ before it
is printed.

Making _ a function and N_ a macro avoids the temptation to use
_("foo") instead of N_("foo") as a string literal.

Define these in a new gettext.h and include it in cache.h, so they can
be used everywhere.  They just return their argument for now.  To
split up the gettext series I'm first submitting patches to gettextize
the source tree before I add any of the Makefile and C changes needed
to actually use translations.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile  |    1 +
 cache.h   |    1 +
 gettext.h |   26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 gettext.h

diff --git a/Makefile b/Makefile
index ade7923..c153f45 100644
--- a/Makefile
+++ b/Makefile
@@ -515,6 +515,7 @@ LIB_H +=3D diff.h
 LIB_H +=3D dir.h
 LIB_H +=3D exec_cmd.h
 LIB_H +=3D fsck.h
+LIB_H +=3D gettext.h
 LIB_H +=3D git-compat-util.h
 LIB_H +=3D graph.h
 LIB_H +=3D grep.h
diff --git a/cache.h b/cache.h
index 3abf895..a465f38 100644
--- a/cache.h
+++ b/cache.h
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 #include "hash.h"
 #include "advice.h"
+#include "gettext.h"
=20
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
diff --git a/gettext.h b/gettext.h
new file mode 100644
index 0000000..dc44825
--- /dev/null
+++ b/gettext.h
@@ -0,0 +1,26 @@
+#ifndef GETTEXT_H
+#define GETTEXT_H
+
+/*
+ * Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+ *
+ * This is a skeleton no-op implementation of gettext for Git.
+ * You can replace it with something that uses libintl.h and wraps
+ * gettext() to try out the translations.
+ */
+
+#ifdef _
+#error "namespace conflict: '_' is pre-defined?"
+#endif
+
+#define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
+
+static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
+{
+	return msgid;
+}
+
+/* Mark msgid for translation but do not translate it. */
+#define N_(msgid) (msgid)
+
+#endif
--=20
1.7.4.1
