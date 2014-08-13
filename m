From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 06/23] refs-common.c: move read_ref_at to the refs common file
Date: Wed, 13 Aug 2014 13:14:50 -0700
Message-ID: <1407960907-18189-7-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:16:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHey9-0000KJ-Mi
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbaHMUQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:16:02 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:34249 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so70771obb.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XoyHHLhbd9dGJC84xZ6477TedbmpVbmrVRe2tHLp5gA=;
        b=dgM2E7fiIxgYFikkJ+qZEDlS+0QvY2YQBc3HJFRQmGkKkT6Zejl7h3S+yxOU6tkfLm
         ztBx8RST38L+wMjcRpm7lJAV3OjHdnmYoDwlEaFJQfJ6KWZ0XGR8LlNWQD1uHx74DMKO
         fuPBn3ybIX8iRkBIRtAfBuqXsM5qF9c6C+uxFOoC4kW1dkyO0M1kYaeacebT01RCetQE
         vYu4q0fJcdYki/ZXVPeYT1WiD6439z5eB8KQciWtWaBMkaaAnGJkC6RFyJ5u0E+M2jla
         8VEoB9AuFxYqG9/THFcHT0KhctEX1x9vJkPfSn2EXvbXQn2Cqyas5OQGqTJ/peeSWDyX
         +PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XoyHHLhbd9dGJC84xZ6477TedbmpVbmrVRe2tHLp5gA=;
        b=cTdI0dn+LxtS3H/otMk3/HoDcZPM9XXzhLzVA//ACUA3dmPkiK1BA0TVoJZO9IKPEd
         j2Sty2GX6zq6uhNsCq98UDoP7rHF138wWclcZ9/9mlWXVnSNC2gsCQPW74ZvJ6Z/afJO
         NLWscq+V+0P+x3e4wvplA7SNMmxIDowsv/NxhQYpzgrPFeDWIUeXHOhXL1JoWR21oNvZ
         JLZzyj1aNqSkAyd/DiUpUaFgVijFUZCo+Gs/Oqx9wUmI6iofeK215YTlSGDIgUTLIF72
         t+wePMINLHwp3iUSRjPxE5vGr+TQkHPO5qsHmFGcQHC/uHkq9sF99hh76TK3QjYRZLJu
         VLRQ==
X-Gm-Message-State: ALoCoQni1mDkQhPXdk820oiN18wipw2cO8iHp4QWImv2Yillo4BD6vBkwqOD0X58kNQdESQ3T6AM
X-Received: by 10.182.112.202 with SMTP id is10mr1414741obb.47.1407960910390;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h42si209641yhj.3.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 300DC5A43D3;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BEF31E10E3; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255248>

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
2.0.1.556.g3edca4c
