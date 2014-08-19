From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 07/23] refs.c: move read_ref_at to the common refs file
Date: Tue, 19 Aug 2014 09:30:31 -0700
Message-ID: <1408465847-30384-8-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKX-0002zZ-MR
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbaHSQbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:05 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:42717 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbaHSQay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:54 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so216255ieb.2
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IBBFyaiFx4oCSMkPD/FLJCY6iaRJQSzx6kJeJfgKDqo=;
        b=jlOBNLv0nk7/UyJ534E6i4+w6Abo7VqucMjs9Y3VvUPQ3dsXUzkn0C0hBvXUQQcTsk
         xUfhyEWtV9D+JqWPW1Jb31V+7O/7uRFYR2yOgo1DVqefIaT8D+xHYW+mPrS51iG39IfJ
         duZp/Y0wBZXbc5Gq+rfXEDe0EBBClnTrLbyyxuNfHLG3wEfKp2faQleSO6uekmXOqgEA
         K9t3hLoON6x3ulxvXLDtMMfiOpXj7EtElvz50K46JGkHUeipftbqyot35xRaf8wYRive
         4jrN9AXm/d3RLJj9ircG7p5paGcZYkfroxMhkzUGyupWopeHFnV+8s8YiTCJ6I3SSFQ0
         +fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IBBFyaiFx4oCSMkPD/FLJCY6iaRJQSzx6kJeJfgKDqo=;
        b=CskivltTO8YBBQKkjV+NZysVSvWrMCrdSKrYM2fEtwkVMc3hfvVm88sloZZrFI5Ms9
         2Bov2uvx6Gt0wubJxSOEJ9r0NVI+iR4SoTUV2wksD26VkMGT3Te5wwBQ0GgBmzyidT92
         YCkgelx+g9m7VX+gh+Rn26BaEhC794AwoXqOm79MRFFp5WzSWJ3KZAM/OhluoLKZjXQ8
         lF8+La5vr5bmcUB4CiEw7r+c8wURLSWlzi86pMT3zXVp8WArOtpPT+Lsl7lWmAqRmJwe
         x80jVP/g/+6rPA48TNsRB+LI4XcvxsE+4/btIKA8Zv9YJq6Cx/22wT3IWRjOhbDkWBvj
         3Gow==
X-Gm-Message-State: ALoCoQkgri92fQy4OLmTVNJpijIwVLV6GWqIoIJ7TF+BCJkGa9GlD0gZmuUKX8i2hdBaRc7/pKHI
X-Received: by 10.42.225.77 with SMTP id ir13mr1729686icb.3.1408465853266;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si329349yhk.4.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E8E435A4428;
	Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 96595E11B0; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255485>

This change moves read_ref_at() to the refs.c file since this function
does not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 114 --------------------------------------------------------
 refs.c          | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 114 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 7d579be..52ca0bb 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2935,120 +2935,6 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
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
-		const char *id, unsigned long timestamp, int tz,
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
-					cb->refname, show_date(cb->date, cb->tz, DATE_RFC2822));
-		}
-		else if (cb->date == cb->at_time)
-			hashcpy(cb->sha1, nsha1);
-		else if (hashcmp(nsha1, cb->sha1))
-			warning("Log for ref %s unexpectedly ended on %s.",
-				cb->refname, show_date(cb->date, cb->tz,
-						   DATE_RFC2822));
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
-				  const char *id, unsigned long timestamp,
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
-int read_ref_at(const char *refname, unsigned long at_time, int cnt,
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
-	if (!cb.reccnt)
-		die("Log for %s is empty.", refname);
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
diff --git a/refs.c b/refs.c
index 319eafa..072cd39 100644
--- a/refs.c
+++ b/refs.c
@@ -137,3 +137,117 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	transaction_free(transaction);
 	return 1;
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
+		const char *id, unsigned long timestamp, int tz,
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
+					cb->refname, show_date(cb->date, cb->tz, DATE_RFC2822));
+		}
+		else if (cb->date == cb->at_time)
+			hashcpy(cb->sha1, nsha1);
+		else if (hashcmp(nsha1, cb->sha1))
+			warning("Log for ref %s unexpectedly ended on %s.",
+				cb->refname, show_date(cb->date, cb->tz,
+						   DATE_RFC2822));
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
+				  const char *id, unsigned long timestamp,
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
+int read_ref_at(const char *refname, unsigned long at_time, int cnt,
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
+	if (!cb.reccnt)
+		die("Log for %s is empty.", refname);
+	if (cb.found_it)
+		return 0;
+
+	for_each_reflog_ent(refname, read_ref_at_ent_oldest, &cb);
+
+	return 1;
+}
-- 
2.0.1.552.g1af257a
