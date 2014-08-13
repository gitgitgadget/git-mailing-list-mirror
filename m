From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 12/23] refs-common.c: move check_refname_component to the common code
Date: Wed, 13 Aug 2014 13:14:56 -0700
Message-ID: <1407960907-18189-13-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:15:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexd-0008V4-S0
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbaHMUPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:44 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:56960 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so35921qcz.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pyxEKQs6ks07PXABs1uvrvkwhtro/n8gKVnf00IkiHI=;
        b=MzPTjk3t4NPh3oziDCE+xt9VvEVKzYecqS9L5DWvpDGISWJJ+XD4P7AqrEA91ufjl6
         bVpGBG6Dok0VWtGxDFIPYt08uDS3JGz1AZ/qdmLSew8b8rnNAqZsT0vRgFbokLq0F8xD
         rm+8zxd8Y0z8b6/UM/sEmdgb6CsRrlEgFy8fSMSW1u8aFUcmAGyVtsw5CIeG1cQ1E4HI
         Ow2xkWAZELfTUAxm2Ia4hCcayIeC2/99XQ9J6EWyZ+CuCjgm7wuEquKs52iwGpgxduqa
         sKG+TkW2dykOjz/9KMZXD25Ka3RIOQKnko/LGfXvfcVkw9TAeW02qIDtTeC/ptQnhVlq
         cbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pyxEKQs6ks07PXABs1uvrvkwhtro/n8gKVnf00IkiHI=;
        b=YhQimG40yDXgNUxhQzkKOlVFipn6nxrE3wx8sssvfbpUmdbmizlF1PpQrMa7YdM9TK
         tf/dMBOeYXebBmECEPWAFU8MzDQOtzLDzdmAno/gr7FWf5y6mIjaC7qsvUPAEsoEmyx8
         JcpRmHO7OaOgSr9DbWKEACViDwszpOSjyKiHkyxAQ/L9yUBYxYcHEO4PpoZxi+eHFGbO
         Q802DGL+CtkG5T8sbFoChw24A0u4dRVdpS53bK857zfgeHlLwlNoKTLEPk3dzg/faUTW
         HXod3rGlJXFOEbjUmm9A2g6z+vpBOMSfwOeW7ISXTKrS7zOSVhnjHK0kVT+QdxOn2Oti
         ilrQ==
X-Gm-Message-State: ALoCoQnLZo9hJDfaVEsWPv2JiEhMR3Bt20EwjC6kuSW+2UXnZGSEVgOhcqz+Pm778G0AMp7Px3iH
X-Received: by 10.224.14.82 with SMTP id f18mr3524359qaa.2.1407960910679;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x19si210825yhg.0.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7873831C3D9;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4E326E09F4; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255238>

This function does not contain any backend specific code so we
can move it to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.c        | 110 ----------------------------------------------------------
 2 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 655a1a0..f8b79e0 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -571,3 +571,113 @@ char *resolve_refdup(const char *ref, unsigned char *sha1, int flags, int *ref_f
 	const char *ret = resolve_ref_unsafe(ref, sha1, flags, ref_flag);
 	return ret ? xstrdup(ret) : NULL;
 }
+
+/*
+ * How to handle various characters in refnames:
+ * 0: An acceptable character for refs
+ * 1: End-of-component
+ * 2: ., look for a preceding . to reject .. in refs
+ * 3: {, look for a preceding @ to reject @{ in refs
+ * 4: A bad character: ASCII control characters, "~", "^", ":" or SP
+ */
+static unsigned char refname_disposition[256] = {
+	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
+	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
+	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 2, 1,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
+};
+
+/*
+ * Try to read one refname component from the front of refname.
+ * Return the length of the component found, or -1 if the component is
+ * not legal.  It is legal if it is something reasonable to have under
+ * ".git/refs/"; We do not like it if:
+ *
+ * - any path component of it begins with ".", or
+ * - it has double dots "..", or
+ * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
+ * - it ends with a "/".
+ * - it ends with ".lock"
+ * - it contains a "\" (backslash)
+ */
+static int check_refname_component(const char *refname, int flags)
+{
+	const char *cp;
+	char last = '\0';
+
+	for (cp = refname; ; cp++) {
+		int ch = *cp & 255;
+		unsigned char disp = refname_disposition[ch];
+		switch (disp) {
+		case 1:
+			goto out;
+		case 2:
+			if (last == '.')
+				return -1; /* Refname contains "..". */
+			break;
+		case 3:
+			if (last == '@')
+				return -1; /* Refname contains "@{". */
+			break;
+		case 4:
+			return -1;
+		}
+		last = ch;
+	}
+out:
+	if (cp == refname)
+		return 0; /* Component has zero length. */
+	if (refname[0] == '.') {
+		if (!(flags & REFNAME_DOT_COMPONENT))
+			return -1; /* Component starts with '.'. */
+		/*
+		 * Even if leading dots are allowed, don't allow "."
+		 * as a component (".." is prevented by a rule above).
+		 */
+		if (refname[1] == '\0')
+			return -1; /* Component equals ".". */
+	}
+	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
+		return -1; /* Refname ends with ".lock". */
+	return cp - refname;
+}
+
+int check_refname_format(const char *refname, int flags)
+{
+	int component_len, component_count = 0;
+
+	if (!strcmp(refname, "@"))
+		/* Refname is a single character '@'. */
+		return -1;
+
+	while (1) {
+		/* We are at the start of a path component. */
+		component_len = check_refname_component(refname, flags);
+		if (component_len <= 0) {
+			if ((flags & REFNAME_REFSPEC_PATTERN) &&
+					refname[0] == '*' &&
+					(refname[1] == '\0' || refname[1] == '/')) {
+				/* Accept one wildcard as a full refname component. */
+				flags &= ~REFNAME_REFSPEC_PATTERN;
+				component_len = 1;
+			} else {
+				return -1;
+			}
+		}
+		component_count++;
+		if (refname[component_len] == '\0')
+			break;
+		/* Skip to next component. */
+		refname += component_len + 1;
+	}
+
+	if (refname[component_len - 1] == '.')
+		return -1; /* Refname ends with '.'. */
+	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
+		return -1; /* Refname has only one component. */
+	return 0;
+}
diff --git a/refs.c b/refs.c
index ed7bc61..55bced9 100644
--- a/refs.c
+++ b/refs.c
@@ -6,25 +6,6 @@
 #include "string-list.h"
 
 /*
- * How to handle various characters in refnames:
- * 0: An acceptable character for refs
- * 1: End-of-component
- * 2: ., look for a preceding . to reject .. in refs
- * 3: {, look for a preceding @ to reject @{ in refs
- * 4: A bad character: ASCII control characters, "~", "^", ":" or SP
- */
-static unsigned char refname_disposition[256] = {
-	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 2, 1,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
-};
-
-/*
  * Used as a flag to transaction_delete_sha1 when a loose ref is being
  * pruned.
  */
@@ -35,97 +16,6 @@ static unsigned char refname_disposition[256] = {
  */
 #define UPDATE_REFLOG_NOLOCK 0x0200
 
-/*
- * Try to read one refname component from the front of refname.
- * Return the length of the component found, or -1 if the component is
- * not legal.  It is legal if it is something reasonable to have under
- * ".git/refs/"; We do not like it if:
- *
- * - any path component of it begins with ".", or
- * - it has double dots "..", or
- * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
- * - it ends with a "/".
- * - it ends with ".lock"
- * - it contains a "\" (backslash)
- */
-static int check_refname_component(const char *refname, int flags)
-{
-	const char *cp;
-	char last = '\0';
-
-	for (cp = refname; ; cp++) {
-		int ch = *cp & 255;
-		unsigned char disp = refname_disposition[ch];
-		switch (disp) {
-		case 1:
-			goto out;
-		case 2:
-			if (last == '.')
-				return -1; /* Refname contains "..". */
-			break;
-		case 3:
-			if (last == '@')
-				return -1; /* Refname contains "@{". */
-			break;
-		case 4:
-			return -1;
-		}
-		last = ch;
-	}
-out:
-	if (cp == refname)
-		return 0; /* Component has zero length. */
-	if (refname[0] == '.') {
-		if (!(flags & REFNAME_DOT_COMPONENT))
-			return -1; /* Component starts with '.'. */
-		/*
-		 * Even if leading dots are allowed, don't allow "."
-		 * as a component (".." is prevented by a rule above).
-		 */
-		if (refname[1] == '\0')
-			return -1; /* Component equals ".". */
-	}
-	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
-		return -1; /* Refname ends with ".lock". */
-	return cp - refname;
-}
-
-int check_refname_format(const char *refname, int flags)
-{
-	int component_len, component_count = 0;
-
-	if (!strcmp(refname, "@"))
-		/* Refname is a single character '@'. */
-		return -1;
-
-	while (1) {
-		/* We are at the start of a path component. */
-		component_len = check_refname_component(refname, flags);
-		if (component_len <= 0) {
-			if ((flags & REFNAME_REFSPEC_PATTERN) &&
-					refname[0] == '*' &&
-					(refname[1] == '\0' || refname[1] == '/')) {
-				/* Accept one wildcard as a full refname component. */
-				flags &= ~REFNAME_REFSPEC_PATTERN;
-				component_len = 1;
-			} else {
-				return -1;
-			}
-		}
-		component_count++;
-		if (refname[component_len] == '\0')
-			break;
-		/* Skip to next component. */
-		refname += component_len + 1;
-	}
-
-	if (refname[component_len - 1] == '.')
-		return -1; /* Refname ends with '.'. */
-	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
-		return -1; /* Refname has only one component. */
-	return 0;
-}
-
 struct ref_entry;
 
 /*
-- 
2.0.1.556.g3edca4c
