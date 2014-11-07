From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 01/16] refs.c: allow passing raw git_committer_info as email to _update_reflog
Date: Fri,  7 Nov 2014 11:38:50 -0800
Message-ID: <1415389145-6391-2-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:39:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpNd-00048b-5u
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbaKGTj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:39:29 -0500
Received: from mail-ie0-f201.google.com ([209.85.223.201]:47456 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbaKGTjL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:39:11 -0500
Received: by mail-ie0-f201.google.com with SMTP id rd18so846478iec.0
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDR0hPMjAoMU5YUUlKQbuxp5m4yVcPrY/J7c0iXn+Ug=;
        b=kN2pLtPCA11ZQ9pPtxxcCKrqOzNq2a0otEuzMRaW9JgcAhrvJOk3EZDBywVCMhrwQl
         8WVGIAEA/VamHGifGEawvM7pKltYV1grzABRNAyBXgSDaLjRhhJrf2d4H6arXE6kqWZZ
         JRuNBlZqlOHSJrlmrVukhBiZlD+GiNb+HVc/XW4pEL3SnmaQchguQ82bOBiiTYz8L+lv
         Zm0J0mpddQ/nGqjLkWxA/MyCwem7pxjcZHLTwmY6+VYCj3Qclv9Lzgi3XqjlqoJHC3Qk
         Hu5j8QEza+T8m+x8jPnqNwwhbgg2A9hdnj36iVMV3wgcVNTrQSSJ6AIqqEz5KdBQTex5
         2rHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WDR0hPMjAoMU5YUUlKQbuxp5m4yVcPrY/J7c0iXn+Ug=;
        b=e5GcQkMQlVm/k5M49/K+zmoEP0eMrpfdNA3YXcV1SyVpzxkvlyvhk/hCF5wt9ysv9S
         P3kaRC4Z2t/zt6xUcfly98wtYApg/aZWacPmiVElNZVd7yDpC758A6aGF/bKndxQM4+Y
         6UgkvEb/bHYmxKTCxjerFuwceP6BV/ZjAjYUqBXpmdSegvU84bykcdhyUYMNHjKgj2/y
         8077C0p56CEHk6w5ypoAPAH4ojZ7FsInlqwRf2+NAUKfmymkwYKabjxTzkt239foAvQY
         jmptybkRnHe9qZ5XoIiry/I4aevr9pSUXYVDQAXfV+I7xoZFF8FZqhRX4qoIgb33bE9n
         Dxgw==
X-Gm-Message-State: ALoCoQmns/FM32J6sV3ztXUD0mwH6fm6sqVGWKbFLO03FDKihIbZtYeyEU6+9mH4Q04r9ZMt1v8J
X-Received: by 10.182.98.232 with SMTP id el8mr10679265obb.42.1415389150196;
        Fri, 07 Nov 2014 11:39:10 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si403894yhe.3.2014.11.07.11.39.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:39:10 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id kjF7Ar7h.1; Fri, 07 Nov 2014 11:39:09 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 59E75E07F8; Fri,  7 Nov 2014 11:39:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In many places in the code we do not have access to the individual fields
in the committer data. Instead we might only have access to prebaked data
such as what is returned by git_committer_info() containing a string
that consists of email, timestamp, zone etc.

This makes it inconvenient to use transaction_update_reflog since it means
you would have to first parse git_committer_info before you can call
update_reflog.

Add a new flag REFLOG_COMMITTER_INFO_IS_VALID to _update_reflog to tell it
that we pass in a fully prebaked committer info string that can be used as is.

At the same time, also go over and change all references from email
to id where the code actually refers to a committer id and not just an email
address. I.e. where the string is : NAME <EMAIL>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/reflog.c | 19 +++++++++++++------
 refs.c           | 21 ++++++++++++---------
 refs.h           | 25 +++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 6bb7454..be88a53 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -292,7 +292,7 @@ static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsig
 }
 
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *id, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct expire_reflog_cb *cb = cb_data;
@@ -320,9 +320,14 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		goto prune;
 
 	if (cb->t) {
+		struct reflog_committer_info ci;
+
+		memset(&ci, 0, sizeof(ci));
+		ci.id = id;
+		ci.timestamp = timestamp;
+		ci.tz = tz;
 		if (transaction_update_reflog(cb->t, cb->refname, nsha1, osha1,
-					      email, timestamp, tz, message, 0,
-					      &err))
+					      &ci, message, 0, &err))
 			return -1;
 		hashcpy(cb->last_kept_sha1, nsha1);
 	}
@@ -356,6 +361,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	struct expire_reflog_cb cb;
 	struct commit *tip_commit;
 	struct commit_list *tips;
+	struct reflog_committer_info ci;
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
@@ -368,9 +374,10 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		status |= error("%s", err.buf);
 		goto cleanup;
 	}
+
+	memset(&ci, 0, sizeof(ci));
 	if (transaction_update_reflog(cb.t, cb.refname, null_sha1, null_sha1,
-				      NULL, 0, 0, NULL, REFLOG_TRUNCATE,
-				      &err)) {
+				      &ci, NULL, REFLOG_TRUNCATE, &err)) {
 		status |= error("%s", err.buf);
 		goto cleanup;
 	}
@@ -672,7 +679,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 }
 
 static int count_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *id, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cb = cb_data;
diff --git a/refs.c b/refs.c
index f1ca9e4..1791166 100644
--- a/refs.c
+++ b/refs.c
@@ -3226,7 +3226,7 @@ struct read_ref_at_cb {
 };
 
 static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *id, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
@@ -3273,7 +3273,7 @@ static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
 }
 
 static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
-				  const char *email, unsigned long timestamp,
+				  const char *id, unsigned long timestamp,
 				  int tz, const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
@@ -3625,8 +3625,7 @@ int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const char *email,
-			      unsigned long timestamp, int tz,
+			      struct reflog_committer_info *ci,
 			      const char *msg, int flags,
 			      struct strbuf *err)
 {
@@ -3654,13 +3653,17 @@ int transaction_update_reflog(struct transaction *transaction,
 	hashcpy(update->new_sha1, new_sha1);
 	hashcpy(update->old_sha1, old_sha1);
 	update->reflog_fd = -1;
-	if (email) {
+	if (flags & REFLOG_COMMITTER_INFO_IS_VALID) {
+		if (!ci->committer_info)
+			die("BUG: committer_info is NULL in reflog update");
+		update->committer = xstrdup(ci->committer_info);
+	} else if (ci->id) {
 		struct strbuf buf = STRBUF_INIT;
-		char sign = (tz < 0) ? '-' : '+';
-		int zone = (tz < 0) ? (-tz) : tz;
+		char sign = (ci->tz < 0) ? '-' : '+';
+		int zone = (ci->tz < 0) ? (-ci->tz) : ci->tz;
 
-		strbuf_addf(&buf, "%s %lu %c%04d", email, timestamp, sign,
-			    zone);
+		strbuf_addf(&buf, "%s %lu %c%04d", ci->id,
+			    ci->timestamp, sign, zone);
 		update->committer = xstrdup(buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/refs.h b/refs.h
index 2e97f4f..9153e1d 100644
--- a/refs.h
+++ b/refs.h
@@ -318,6 +318,28 @@ int transaction_delete_ref(struct transaction *transaction,
  * Flags >= 0x100 are reserved for internal use.
  */
 #define REFLOG_TRUNCATE 0x01
+#define REFLOG_COMMITTER_INFO_IS_VALID 0x02
+
+/*
+ * Committer data provided to reflog updates.
+ * If flags contain REFLOG_COMMITTER_DATA_IS_VALID then the structure
+ * contains a prebaked committer string just like git_committer_info()
+ * would return.
+ *
+ * If flags does not contain REFLOG_COMMITTER_DATA_IS_VALID
+ * then the committer info string will be generated using the passed
+ * email, timestamp and tz fields.
+ * This is useful for example from reflog iterators where you are passed
+ * these fields individually and not as a prebaked git_committer_info()
+ * string.
+ */
+struct reflog_committer_info {
+	const char *committer_info;
+
+	const char *id;
+	unsigned long timestamp;
+	int tz;
+};
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
@@ -327,8 +349,7 @@ int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const char *email,
-			      unsigned long timestamp, int tz,
+			      struct reflog_committer_info *ci,
 			      const char *msg, int flags,
 			      struct strbuf *err);
 
-- 
2.1.0.rc2.206.gedb03e5
