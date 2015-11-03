From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 10/25] refs: move read_ref, read_ref_full and ref_exists to the common code
Date: Tue,  3 Nov 2015 08:39:54 +0100
Message-ID: <467939ca5f0943f8e776ee236a24d7d991c54d70.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:47:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWJo-0005V4-Rh
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbbKCHrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:47:45 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53842 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752340AbbKCHro (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:47:44 -0500
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2015 02:47:44 EST
X-AuditID: 1207440f-f79df6d000007c0f-ad-563864eb1446
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 88.B2.31759.BE468365; Tue,  3 Nov 2015 02:40:27 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDd7016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:26 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqPs6xSLMYNoaE4v5m04wWnRd6Way
	aOi9wmxxe8V8Zot/E2ocWD3+vv/A5LFgU6nHxUvKHgue32f3+LxJLoA1itsmKbGkLDgzPU/f
	LoE749fSWWwF+wUqPu2eydzA+Ji3i5GTQ0LARGJJ8y9GCFtM4sK99WxdjFwcQgKXGSU2zt/F
	AuEcY5JYOfEpE0gVm4CuxKKeZjBbREBNYmLbIbAiZoFFjBKtb6aDJYQF4iT61n9gAbFZBFQl
	Tk2eywpi8wpESRw+OZUFYp2cxJT77WD1nAIWEg/u/mEHsYUEzCU23VvGNoGRdwEjwypGucSc
	0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwSvdSU0k2MkJDi38HYtV7mEKMAB6MSD++CJeZhQqyJ
	ZcWVuYcYJTmYlER518VYhAnxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4S0IBMrxpiRWVqUW5cOk
	pDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR4ZycDNQoWpaanVqRl5pQgpJk4OEGGc0mJ
	FKfmpaQWJZaWZMSDoiO+GBgfICkeoL0rQdp5iwsSc4GiEK2nGBWlxHkjQBICIImM0jy4sbBE
	8YpRHOhLYd4LIFU8wCQD1/0KaDAT0ODwbaYgg0sSEVJSDYwTox+vLlnJ2VkwNaszJNvKU1Di
	uHrEsY8bTQ2llE/+cdq93dH2d+JJseS48oQ5M6KvCM+6xb64KI/rzc0nixwtWF9v7Li+imuv
	wb+EFt6uu8t2XTZT2ioUe+DBeY2OIxOTg4MWZia9jLM+I7hCPqnax0nXoEkk91tc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280769>

From: Ronnie Sahlberg <sahlberg@google.com>

These functions do not depend on the backend implementation so move
them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 18 ------------------
 refs/refs.c          | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9fb77c2..6940d54 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1803,24 +1803,6 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
-{
-	if (resolve_ref_unsafe(refname, resolve_flags, sha1, flags))
-		return 0;
-	return -1;
-}
-
-int read_ref(const char *refname, unsigned char *sha1)
-{
-	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
-}
-
-int ref_exists(const char *refname)
-{
-	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
-}
-
 static int filter_refs(const char *refname, const struct object_id *oid,
 			   int flags, void *data)
 {
diff --git a/refs/refs.c b/refs/refs.c
index 6d9ea7c..ae55d85 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -597,3 +597,21 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
 	data.msg_fmt = msg_fmt;
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
+
+int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
+{
+	if (resolve_ref_unsafe(refname, resolve_flags, sha1, flags))
+		return 0;
+	return -1;
+}
+
+int read_ref(const char *refname, unsigned char *sha1)
+{
+	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
+}
+
+int ref_exists(const char *refname)
+{
+	unsigned char sha1[20];
+	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
+}
-- 
2.6.2
