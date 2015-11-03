From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 06/25] refs: move read_ref_at to the common refs file
Date: Tue,  3 Nov 2015 08:39:50 +0100
Message-ID: <d7a4044eab7dc4d56172bb43c2e68dba0d40037b.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:47:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWJY-0005FN-Dy
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbbKCHra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:47:30 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53839 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752252AbbKCHr3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:47:29 -0500
X-AuditID: 1207440f-f79df6d000007c0f-a3-563864e674eb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 28.B2.31759.6E468365; Tue,  3 Nov 2015 02:40:23 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDd3016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:22 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqPs8xSLMYPcFJov5m04wWnRd6Way
	aOi9wmxxe8V8Zot/E2ocWD3+vv/A5LFgU6nHxUvKHgue32f3+LxJLoA1itsmKbGkLDgzPU/f
	LoE7Y8/NXywFLZYVL6Z3MDcwHtLtYuTkkBAwkdjY8owVwhaTuHBvPVsXIxeHkMBlRomWjReZ
	IZxjTBLP9/xkAqliE9CVWNTTDGaLCKhJTGw7xAJSxCywiFGi9c10sISwgIdE6+2/jCA2i4Cq
	xLWuv2AreAWiJF5NfsQCsU5OYsr9drB6TgELiQd3/7CD2EIC5hKb7i1jm8DIu4CRYRWjXGJO
	aa5ubmJmTnFqsm5xcmJeXmqRrolebmaJXmpK6SZGSEjx72DsWi9ziFGAg1GJh3fBEvMwIdbE
	suLK3EOMkhxMSqK862IswoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8BYEAuV4UxIrq1KL8mFS
	0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK88clAjYJFqempFWmZOSUIaSYOTpDhXFIi
	xal5KalFiaUlGfGg6IgvBsYHSIoHaG9tEsje4oLEXKAoROspRkUpcd6HIAkBkERGaR7cWFii
	eMUoDvSlMO8FkO08wCQD1/0KaDAT0ODwbaYgg0sSEVJSDYx+kwqu6t0V0Ll7kr8loWWpgauo
	gofjOpvcmTK6RTWvcu5XCtwxn35F+cCv+iltVY9edP49sWxH+mXFhE1umn+cWY8X+CYf89tY
	/mLWDMED1S6HD806sXnSUw07JUeFlJdCX5LKlryNDbmYrT77x38rufyryQ++fom1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280767>

From: Ronnie Sahlberg <sahlberg@google.com>

Move read_ref_at() to refs/refs.c since this function does not contain
any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 118 ---------------------------------------------------
 refs/refs.c          | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6d502ac..8eba347 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3469,124 +3469,6 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	return 0;
 }
 
-struct read_ref_at_cb {
-	const char *refname;
-	unsigned long at_time;
-	int cnt;
-	int reccnt;
-	unsigned char *sha1;
-	int found_it;
-
-	unsigned char osha1[20];
-	unsigned char nsha1[20];
-	int tz;
-	unsigned long date;
-	char **msg;
-	unsigned long *cutoff_time;
-	int *cutoff_tz;
-	int *cutoff_cnt;
-};
-
-static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
-		const char *message, void *cb_data)
-{
-	struct read_ref_at_cb *cb = cb_data;
-
-	cb->reccnt++;
-	cb->tz = tz;
-	cb->date = timestamp;
-
-	if (timestamp <= cb->at_time || cb->cnt == 0) {
-		if (cb->msg)
-			*cb->msg = xstrdup(message);
-		if (cb->cutoff_time)
-			*cb->cutoff_time = timestamp;
-		if (cb->cutoff_tz)
-			*cb->cutoff_tz = tz;
-		if (cb->cutoff_cnt)
-			*cb->cutoff_cnt = cb->reccnt - 1;
-		/*
-		 * we have not yet updated cb->[n|o]sha1 so they still
-		 * hold the values for the previous record.
-		 */
-		if (!is_null_sha1(cb->osha1)) {
-			hashcpy(cb->sha1, nsha1);
-			if (hashcmp(cb->osha1, nsha1))
-				warning("Log for ref %s has gap after %s.",
-					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
-		}
-		else if (cb->date == cb->at_time)
-			hashcpy(cb->sha1, nsha1);
-		else if (hashcmp(nsha1, cb->sha1))
-			warning("Log for ref %s unexpectedly ended on %s.",
-				cb->refname, show_date(cb->date, cb->tz,
-						       DATE_MODE(RFC2822)));
-		hashcpy(cb->osha1, osha1);
-		hashcpy(cb->nsha1, nsha1);
-		cb->found_it = 1;
-		return 1;
-	}
-	hashcpy(cb->osha1, osha1);
-	hashcpy(cb->nsha1, nsha1);
-	if (cb->cnt > 0)
-		cb->cnt--;
-	return 0;
-}
-
-static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
-				  const char *email, unsigned long timestamp,
-				  int tz, const char *message, void *cb_data)
-{
-	struct read_ref_at_cb *cb = cb_data;
-
-	if (cb->msg)
-		*cb->msg = xstrdup(message);
-	if (cb->cutoff_time)
-		*cb->cutoff_time = timestamp;
-	if (cb->cutoff_tz)
-		*cb->cutoff_tz = tz;
-	if (cb->cutoff_cnt)
-		*cb->cutoff_cnt = cb->reccnt;
-	hashcpy(cb->sha1, osha1);
-	if (is_null_sha1(cb->sha1))
-		hashcpy(cb->sha1, nsha1);
-	/* We just want the first entry */
-	return 1;
-}
-
-int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time, int cnt,
-		unsigned char *sha1, char **msg,
-		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
-{
-	struct read_ref_at_cb cb;
-
-	memset(&cb, 0, sizeof(cb));
-	cb.refname = refname;
-	cb.at_time = at_time;
-	cb.cnt = cnt;
-	cb.msg = msg;
-	cb.cutoff_time = cutoff_time;
-	cb.cutoff_tz = cutoff_tz;
-	cb.cutoff_cnt = cutoff_cnt;
-	cb.sha1 = sha1;
-
-	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
-
-	if (!cb.reccnt) {
-		if (flags & GET_SHA1_QUIETLY)
-			exit(128);
-		else
-			die("Log for %s is empty.", refname);
-	}
-	if (cb.found_it)
-		return 0;
-
-	for_each_reflog_ent(refname, read_ref_at_ent_oldest, &cb);
-
-	return 1;
-}
-
 int reflog_exists(const char *refname)
 {
 	struct stat st;
diff --git a/refs/refs.c b/refs/refs.c
index 96d5c6d..99221a3 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -173,3 +173,121 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
 	strbuf_release(&err);
 	return 0;
 }
+
+struct read_ref_at_cb {
+	const char *refname;
+	unsigned long at_time;
+	int cnt;
+	int reccnt;
+	unsigned char *sha1;
+	int found_it;
+
+	unsigned char osha1[20];
+	unsigned char nsha1[20];
+	int tz;
+	unsigned long date;
+	char **msg;
+	unsigned long *cutoff_time;
+	int *cutoff_tz;
+	int *cutoff_cnt;
+};
+
+static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
+		const char *email, unsigned long timestamp, int tz,
+		const char *message, void *cb_data)
+{
+	struct read_ref_at_cb *cb = cb_data;
+
+	cb->reccnt++;
+	cb->tz = tz;
+	cb->date = timestamp;
+
+	if (timestamp <= cb->at_time || cb->cnt == 0) {
+		if (cb->msg)
+			*cb->msg = xstrdup(message);
+		if (cb->cutoff_time)
+			*cb->cutoff_time = timestamp;
+		if (cb->cutoff_tz)
+			*cb->cutoff_tz = tz;
+		if (cb->cutoff_cnt)
+			*cb->cutoff_cnt = cb->reccnt - 1;
+		/*
+		 * we have not yet updated cb->[n|o]sha1 so they still
+		 * hold the values for the previous record.
+		 */
+		if (!is_null_sha1(cb->osha1)) {
+			hashcpy(cb->sha1, nsha1);
+			if (hashcmp(cb->osha1, nsha1))
+				warning("Log for ref %s has gap after %s.",
+					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
+		}
+		else if (cb->date == cb->at_time)
+			hashcpy(cb->sha1, nsha1);
+		else if (hashcmp(nsha1, cb->sha1))
+			warning("Log for ref %s unexpectedly ended on %s.",
+				cb->refname, show_date(cb->date, cb->tz,
+						       DATE_MODE(RFC2822)));
+		hashcpy(cb->osha1, osha1);
+		hashcpy(cb->nsha1, nsha1);
+		cb->found_it = 1;
+		return 1;
+	}
+	hashcpy(cb->osha1, osha1);
+	hashcpy(cb->nsha1, nsha1);
+	if (cb->cnt > 0)
+		cb->cnt--;
+	return 0;
+}
+
+static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
+				  const char *email, unsigned long timestamp,
+				  int tz, const char *message, void *cb_data)
+{
+	struct read_ref_at_cb *cb = cb_data;
+
+	if (cb->msg)
+		*cb->msg = xstrdup(message);
+	if (cb->cutoff_time)
+		*cb->cutoff_time = timestamp;
+	if (cb->cutoff_tz)
+		*cb->cutoff_tz = tz;
+	if (cb->cutoff_cnt)
+		*cb->cutoff_cnt = cb->reccnt;
+	hashcpy(cb->sha1, osha1);
+	if (is_null_sha1(cb->sha1))
+		hashcpy(cb->sha1, nsha1);
+	/* We just want the first entry */
+	return 1;
+}
+
+int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time, int cnt,
+		unsigned char *sha1, char **msg,
+		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
+{
+	struct read_ref_at_cb cb;
+
+	memset(&cb, 0, sizeof(cb));
+	cb.refname = refname;
+	cb.at_time = at_time;
+	cb.cnt = cnt;
+	cb.msg = msg;
+	cb.cutoff_time = cutoff_time;
+	cb.cutoff_tz = cutoff_tz;
+	cb.cutoff_cnt = cutoff_cnt;
+	cb.sha1 = sha1;
+
+	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
+
+	if (!cb.reccnt) {
+		if (flags & GET_SHA1_QUIETLY)
+			exit(128);
+		else
+			die("Log for %s is empty.", refname);
+	}
+	if (cb.found_it)
+		return 0;
+
+	for_each_reflog_ent(refname, read_ref_at_ent_oldest, &cb);
+
+	return 1;
+}
-- 
2.6.2
