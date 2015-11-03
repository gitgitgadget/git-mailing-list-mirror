From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 09/25] refs: move warn_if_dangling_symref* to the common code
Date: Tue,  3 Nov 2015 08:39:53 +0100
Message-ID: <4b1de143c01feee0d9195820196c3d350c809b14.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:48:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWKI-0005wr-P4
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbbKCHsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:48:12 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44588 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752078AbbKCHsI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:48:08 -0500
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2015 02:48:07 EST
X-AuditID: 12074414-f794f6d000007852-9e-563864eafdf2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 49.2D.30802.AE468365; Tue,  3 Nov 2015 02:40:26 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDd6016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:25 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqPsqxSLM4E2TtsX8TScYLbqudDNZ
	NPReYba4vWI+s8W/CTUOrB5/339g8liwqdTj4iVljwXP77N7fN4kF8AaxW2TlFhSFpyZnqdv
	l8CdceJCB1vBDLmKvhuNLA2MnyS6GDk5JARMJP4+OcYGYYtJXLi3Hsjm4hASuMwoseXCZxYI
	5xiTxKvfW8Gq2AR0JRb1NDOB2CICahIT2w6BFTELLGKUaH0zHSjBwSEsECDx7FgkiMkioCqx
	5q0ASDmvQJTEq5fX2CGWyUlMud8ONoZTwELiwd0/YHEhAXOJTfeWsU1g5F3AyLCKUS4xpzRX
	NzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIyScRHYwHjkpd4hRgINRiYd3wRLzMCHWxLLi
	ytxDjJIcTEqivOtiLMKE+JLyUyozEosz4otKc1KLDzFKcDArifAWBALleFMSK6tSi/JhUtIc
	LErivN8Wq/sJCaQnlqRmp6YWpBbBZGU4OJQkeC8lAzUKFqWmp1akZeaUIKSZODhBhnNJiRSn
	5qWkFiWWlmTEgyIjvhgYGyApHqC9CSkge4sLEnOBohCtpxgVpcR5L4LMFQBJZJTmwY2FJYlX
	jOJAXwrzTgSp4gEmGLjuV0CDmYAGh28zBRlckoiQkmpg9Dly6bGU3PwdOuxMRqfFti2XmCN6
	XEw22e/4trSv03Zl/u9L0bdln9X9cNnxr9WmBjs9DJ9eWL2gQPDpDt3DN3bO0D9+qlPg9VpJ
	YxkWxzD3FuPDi71j6qUd96Wyc3xf/OTOy7zSmGff6vgPX/lzQMWA83wGU8lzD641 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280775>

From: Ronnie Sahlberg <sahlberg@google.com>

These functions do not use any backend specific code so move them to
the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 52 ----------------------------------------------------
 refs/refs.c          | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8809595..9fb77c2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1956,58 +1956,6 @@ int peel_ref(const char *refname, unsigned char *sha1)
 	return peel_object(base, sha1);
 }
 
-struct warn_if_dangling_data {
-	FILE *fp;
-	const char *refname;
-	const struct string_list *refnames;
-	const char *msg_fmt;
-};
-
-static int warn_if_dangling_symref(const char *refname, const struct object_id *oid,
-				   int flags, void *cb_data)
-{
-	struct warn_if_dangling_data *d = cb_data;
-	const char *resolves_to;
-	struct object_id junk;
-
-	if (!(flags & REF_ISSYMREF))
-		return 0;
-
-	resolves_to = resolve_ref_unsafe(refname, 0, junk.hash, NULL);
-	if (!resolves_to
-	    || (d->refname
-		? strcmp(resolves_to, d->refname)
-		: !string_list_has_string(d->refnames, resolves_to))) {
-		return 0;
-	}
-
-	fprintf(d->fp, d->msg_fmt, refname);
-	fputc('\n', d->fp);
-	return 0;
-}
-
-void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
-{
-	struct warn_if_dangling_data data;
-
-	data.fp = fp;
-	data.refname = refname;
-	data.refnames = NULL;
-	data.msg_fmt = msg_fmt;
-	for_each_rawref(warn_if_dangling_symref, &data);
-}
-
-void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames)
-{
-	struct warn_if_dangling_data data;
-
-	data.fp = fp;
-	data.refname = NULL;
-	data.refnames = refnames;
-	data.msg_fmt = msg_fmt;
-	for_each_rawref(warn_if_dangling_symref, &data);
-}
-
 /*
  * Call fn for each reference in the specified ref_cache, omitting
  * references not in the containing_dir of base.  fn is called for all
diff --git a/refs/refs.c b/refs/refs.c
index 40d7831..6d9ea7c 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -545,3 +545,55 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	free(short_name);
 	return xstrdup(refname);
 }
+
+struct warn_if_dangling_data {
+	FILE *fp;
+	const char *refname;
+	const struct string_list *refnames;
+	const char *msg_fmt;
+};
+
+static int warn_if_dangling_symref(const char *refname, const struct object_id *oid,
+				   int flags, void *cb_data)
+{
+	struct warn_if_dangling_data *d = cb_data;
+	const char *resolves_to;
+	struct object_id junk;
+
+	if (!(flags & REF_ISSYMREF))
+		return 0;
+
+	resolves_to = resolve_ref_unsafe(refname, 0, junk.hash, NULL);
+	if (!resolves_to
+	    || (d->refname
+		? strcmp(resolves_to, d->refname)
+		: !string_list_has_string(d->refnames, resolves_to))) {
+		return 0;
+	}
+
+	fprintf(d->fp, d->msg_fmt, refname);
+	fputc('\n', d->fp);
+	return 0;
+}
+
+void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
+{
+	struct warn_if_dangling_data data;
+
+	data.fp = fp;
+	data.refname = refname;
+	data.refnames = NULL;
+	data.msg_fmt = msg_fmt;
+	for_each_rawref(warn_if_dangling_symref, &data);
+}
+
+void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames)
+{
+	struct warn_if_dangling_data data;
+
+	data.fp = fp;
+	data.refname = NULL;
+	data.refnames = refnames;
+	data.msg_fmt = msg_fmt;
+	for_each_rawref(warn_if_dangling_symref, &data);
+}
-- 
2.6.2
