From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/15] i18n: add no-op _() and N_() wrappers
Date: Mon, 21 Feb 2011 04:13:21 -0600
Message-ID: <20110221101321.GB32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:18:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSqv-0002Qo-M9
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056Ab1BUKSd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:18:33 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61870 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab1BUKSc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:18:32 -0500
Received: by iwn8 with SMTP id 8so1729136iwn.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mcucD19y9w6ziSAaSzIY+l9r71taUMV3DIK+eTzOCDA=;
        b=VINs0SZjR5LESa0eRev5OmrJ8y8SZH5UjiDu66GFEu0h7ANJ8qCPvrNmuhbgHGpCf1
         b63iOev947gJnWCud/3/czfhUBv4TejnvNegB16bQX0n33BEWH3gjTWI1haoTHtvbGLU
         NodVpJ+ffCMuBRfzo2r6RdYg1VkeZFQ08iZ/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kzpVHU+MRMGSMSZRa9yXAG/Hh2QhED7AWLH4CtC4tpM1ykYVKTRw+FKQJWK/xc/jhJ
         YPk5MaeGnFvQtnxd82dluvsYFtniqPLN+FRE2R2FezkA0uunIgg2xPbzLD1aZCWnRP07
         RVb6OD2cEBbCPF7ZPItGv6Wx9OhPexSHa7qac=
Received: by 10.43.58.146 with SMTP id wk18mr1722708icb.263.1298283206505;
        Mon, 21 Feb 2011 02:13:26 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id gy41sm970181ibb.11.2011.02.21.02.13.24
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:13:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167462>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

The _ function is for translating strings into the user's chosen
language.  The N_ macro just marks translatable strings for the
xgettext(1) tool without translating them; it is intended for use in
contexts where a function call cannot be used.  So, for example:

	fprintf(stderr, _("Expansion of alias '%s' failed; "
		"'%s' is not a git command\n"),
		cmd, argv[0]);

and

	const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] =3D {
		/* ERROR_WOULD_OVERWRITE */
		N_("Entry '%s' would be overwritten by merge. Cannot merge."),
	[...]

Define such _ and N_ in a new gettext.h and include it in cache.h, so
they can be used everywhere.  Each just returns its argument for now.
_ is a function rather than a macro like N_ to avoid the temptation to
use _("foo") as a string literal (which would be a compile-time error
once _(s) expands to an expression for the translation of s).

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
