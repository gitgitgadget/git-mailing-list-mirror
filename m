From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 06/22] refs-common.c: move read_ref_at to the refs common file
Date: Fri,  8 Aug 2014 09:44:53 -0700
Message-ID: <1407516309-27989-7-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:45:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnIU-0007cZ-4d
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756969AbaHHQpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:35 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:56241 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756456AbaHHQpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:17 -0400
Received: by mail-ig0-f201.google.com with SMTP id h3so194407igd.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uBiP9gijLbF3w8sb0xWM6R+cXHmYjPFMhI0VKCpwGys=;
        b=oxEXrYqjJcaPppYsXDP0SPEU3T/s3E35H8QL+acCnpTqNRfYAJm5fE0nRGoOT8RS4w
         +hDdFOxyHNSsOtJh0XkQs8Sggs7jGTetfzpVDuPZGmfx1P1vbvfnhf8FOq5uKAa6smTn
         ihjnFdn7RsGYwLhSnL1H5RJK2XbE9UZsn7vlUeohy8XMjARKs4hF1b61HOvRkf1d3twV
         M0aGMvmYbUJSeUrvWSpT4Rs1Bj1kSHrS4cv0Q8xeBKgljRojVI6CQrmcKM2xOqzZ4DrD
         qjJgXG2AbTkWvcyzVTqFsktJiqBBa3GduIQ/t3J9O0EVgXpLI2WfsIZLMWcoSIife66E
         7ANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uBiP9gijLbF3w8sb0xWM6R+cXHmYjPFMhI0VKCpwGys=;
        b=SozOSc44ZHIDtgUe+L9Ep19+Z7pjGq4ULNKkd64IkBGEPfIYEtBID8CEDN4rQj4H2b
         iDEoT8DIW8akTI+U+4SBVQYn49mFl9O5ElZSMKBiiP+HLhqqAucOdxxibgLzFQbzA3M7
         YrZEhd1GEJVD77YB6y0QDtj1Ag0jrVsK/6WZ4Co2JE5gnxFZhsFGCjbuYpHzE5VTL3WP
         uvpidotHSbKSmjLFILjB6cHZNbleku0jrsK1t8NtQGnjcSZVrkLCwJcxo4Kjvys218ay
         JRioe5MovFwyKmnEQaDWOm2VbZJrLuI8bT9zxUpOuL0jav7z6jCXMyLGnzAECdyCnMJr
         IQKA==
X-Gm-Message-State: ALoCoQlvtaMijc1dIAZPakIQAfgoZmKZQAvO62jm2HA5o4Vs22Oa7lPWD11Z64K8vz94QV1Wilo7
X-Received: by 10.43.153.196 with SMTP id lb4mr5629696icc.2.1407516315849;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si504807yhb.3.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 9C4925A4615;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 30D83E10B8; Fri,  8 Aug 2014 09:45:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255030>

This change moves read_ref_at() to the refs-common.c file since this function
does not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.c        | 114 ----------------------------------------------------------
 2 files changed, 114 insertions(+), 114 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index f99d83e..3d7354e 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -135,3 +135,117 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
diff --git a/refs.c b/refs.c
index 7d579be..52ca0bb 100644
--- a/refs.c
+++ b/refs.c
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
-- 
2.0.1.553.geee1b3e
