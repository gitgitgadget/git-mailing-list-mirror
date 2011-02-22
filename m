From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 01/73] gettext: add no-op _() and N_() wrappers
Date: Tue, 22 Feb 2011 23:41:20 +0000
Message-ID: <1298418152-27789-2-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:43:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1tS-0007sP-1o
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab1BVXnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:43 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab1BVXnc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:32 -0500
Received: by bwz10 with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rNE/O8Df8iIBSCOo+OQNjd2fGVEmsv+zi8qpPYE9Sl0=;
        b=BZVoYl7tknfpzooTS4U0vsiUkUvgwt382nfrLtR/X5ywZ+KuiMICPBmM4487zrkXmw
         KUWfxuvgqrqpPkBpLLmZt3P1NA59nWUHX+f35hG/V46UqKE89ubCutHq79050xFvnZKc
         RsIDLFYXKAVNhkijTMrvkJ5wk6LJOA+R5qOic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uxy+fmCLHAzeKMv6AwtjBFTMMKTWRJP5XSfEElLbnVpCcnqSkO288bwa5UdBNe+XDp
         gPTFg6s+uQPEmc9KnBgpUSYm+xLP6mnY95nG6lEfrxgr0jH9lsaJAlvXATkbs3p8P1bF
         Z6/oM7nX7Lf1dAC20ibUig38s/6Gb5rOIw6MY=
Received: by 10.204.123.12 with SMTP id n12mr2987931bkr.174.1298418210804;
        Tue, 22 Feb 2011 15:43:30 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.29
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:30 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167592>

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
index 0000000..6949d73
--- /dev/null
+++ b/gettext.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2010-2011 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+ *
+ * This is a skeleton no-op implementation of gettext for Git.
+ * You can replace it with something that uses libintl.h and wraps
+ * gettext() to try out the translations.
+ */
+
+#ifndef GETTEXT_H
+#define GETTEXT_H
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
1.7.2.3
