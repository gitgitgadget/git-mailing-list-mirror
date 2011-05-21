From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] convert.h: move declarations for conversion from cache.h
Date: Fri, 20 May 2011 23:58:44 -0700
Message-ID: <1305961127-26540-2-git-send-email-gitster@pobox.com>
References: <1305961127-26540-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:59:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg9T-0006eL-HV
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341Ab1EUG7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:59:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab1EUG7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:59:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 164AA5DE8
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:01:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=v71/
	Mp+hCfy6fDUddq5Dx4qgVEY=; b=fj6gTpF+hgDQJsyavMNyelR28BKO4MkHLxE0
	jIKI1nplorY1Gi2xu3FDTr3J7jOpuraXrzfSY1UIifMxidBDVWqYmxLnPaBUMByN
	g8H6BlFqWuFd5B/5ev0fpl7RQ+oJsGjGyAsvF8vejV1LD02n1nOalJNe/Ue6bkO9
	O2uqCWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=UZNJNc
	gOl73pGrKqhp0ZJRsntDxuF5dxxMvXC8t+2lxmPqKPvje3BYTW/a8Ay3ekrqae73
	E9KbLYRhvGSShHctxREFSAb1I4/67ZV00zK61iLhA9MEH47dfGvN5ePW2+9grAm9
	CDQ5Zfgmw+B/otOC2yhNhYbC679fSFL0FwzYM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13E7F5DE7
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:01:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2E4715DE6 for
 <git@vger.kernel.org>; Sat, 21 May 2011 03:01:04 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305961127-26540-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 19028590-8378-11E0-A3A1-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174108>

Before adding the streaming filter API to the conversion layer,
move the existing declarations related to the conversion to its
own header file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h   |   38 +-------------------------------------
 convert.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 37 deletions(-)
 create mode 100644 convert.h

diff --git a/cache.h b/cache.h
index a5067ba..c781c11 100644
--- a/cache.h
+++ b/cache.h
@@ -6,6 +6,7 @@
 #include "hash.h"
 #include "advice.h"
 #include "gettext.h"
+#include "convert.h"
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
@@ -582,35 +583,6 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 
-enum safe_crlf {
-	SAFE_CRLF_FALSE = 0,
-	SAFE_CRLF_FAIL = 1,
-	SAFE_CRLF_WARN = 2
-};
-
-extern enum safe_crlf safe_crlf;
-
-enum auto_crlf {
-	AUTO_CRLF_FALSE = 0,
-	AUTO_CRLF_TRUE = 1,
-	AUTO_CRLF_INPUT = -1
-};
-
-extern enum auto_crlf auto_crlf;
-
-enum eol {
-	EOL_UNSET,
-	EOL_CRLF,
-	EOL_LF,
-#ifdef NATIVE_CRLF
-	EOL_NATIVE = EOL_CRLF
-#else
-	EOL_NATIVE = EOL_LF
-#endif
-};
-
-extern enum eol core_eol;
-
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
@@ -1153,14 +1125,6 @@ extern void trace_strbuf(const char *key, const struct strbuf *buf);
 
 void packet_trace_identity(const char *prog);
 
-/* convert.c */
-/* returns 1 if *dst was used */
-extern int convert_to_git(const char *path, const char *src, size_t len,
-                          struct strbuf *dst, enum safe_crlf checksafe);
-extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
-extern int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst);
-extern int can_bypass_conversion(const char *path);
-
 /* add */
 /*
  * return 0 if success, 1 - if addition of a file failed and
diff --git a/convert.h b/convert.h
new file mode 100644
index 0000000..b1b4a38
--- /dev/null
+++ b/convert.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright (c) 2011, Google Inc.
+ */
+#ifndef CONVERT_H
+#define CONVERT_H
+
+enum safe_crlf {
+	SAFE_CRLF_FALSE = 0,
+	SAFE_CRLF_FAIL = 1,
+	SAFE_CRLF_WARN = 2
+};
+
+extern enum safe_crlf safe_crlf;
+
+enum auto_crlf {
+	AUTO_CRLF_FALSE = 0,
+	AUTO_CRLF_TRUE = 1,
+	AUTO_CRLF_INPUT = -1
+};
+
+extern enum auto_crlf auto_crlf;
+
+enum eol {
+	EOL_UNSET,
+	EOL_CRLF,
+	EOL_LF,
+#ifdef NATIVE_CRLF
+	EOL_NATIVE = EOL_CRLF
+#else
+	EOL_NATIVE = EOL_LF
+#endif
+};
+
+extern enum eol core_eol;
+
+/* returns 1 if *dst was used */
+extern int convert_to_git(const char *path, const char *src, size_t len,
+			  struct strbuf *dst, enum safe_crlf checksafe);
+extern int convert_to_working_tree(const char *path, const char *src,
+				   size_t len, struct strbuf *dst);
+extern int renormalize_buffer(const char *path, const char *src, size_t len,
+			      struct strbuf *dst);
+extern int can_bypass_conversion(const char *path);
+#endif /* CONVERT_H */
-- 
1.7.5.2.369.g8fc017
