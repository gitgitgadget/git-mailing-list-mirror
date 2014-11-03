From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 01/17] refs.c: allow passing raw git_committer_info as email to _update_reflog
Date: Mon,  3 Nov 2014 11:02:03 -0800
Message-ID: <1415041339-18450-2-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:02:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMtr-0001Xv-8j
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbaKCTCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:34 -0500
Received: from mail-pa0-f73.google.com ([209.85.220.73]:41746 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbaKCTCY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:24 -0500
Received: by mail-pa0-f73.google.com with SMTP id lj1so1997141pab.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDR0hPMjAoMU5YUUlKQbuxp5m4yVcPrY/J7c0iXn+Ug=;
        b=gLV03G65JVY6uUDK5NyjP6WVHmXb69H9onACaWdGtGJP4aAK7GV/pO62cL2bHplu+F
         /loyaUqkrz+g/aBCpXyUSVMJ3pRWg52glCgjzr/rt09wWkT24TjUC8EPrr70D1Davq3I
         jNrTimIcysTy9cNAdsD0FqjJbyeq0ZEwNZ7zbiMIo3T8/xfIgMMwN9CZB5jQU2s/C7qw
         S/1zMCktmJVB0zuTiwfeN8CkwiySD6NTOm43fIfPux96rSu1ZC5VxTq+HtSOQPPK7Qae
         vAaGmNbug+w05kzDsSZijzwQyZt93lJiHw9PYIxp4f6j4HVhD/frisXn7bUpfE0FgTvP
         TDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WDR0hPMjAoMU5YUUlKQbuxp5m4yVcPrY/J7c0iXn+Ug=;
        b=kY4iWkCcsgwjDNwoeoLApCQRbduU3WM/A7djTYVZq89jkLu590iFxjabLXTeoqjta5
         dMoZcOReA5kNfZCmdeAI8aIIjYbW1WtSHignLHEpVUbn0sramcbVZCgrBQI6ZsDBzcMa
         XUejYGqhoOcVQPNcITc/JUtvlXTbobPReIjcu+bAemRVfoOpLoC9PalugCZ4pguOnJOq
         Hca3cmIZbyQVRBALQtAOXwDFHrNr46Rmo1m24mgeX4vXy9x1J/X3ETgkLaIpeELLrPu5
         +SzVIhXWx0WJIhcxAUx4YQLAWhrgKGrna88DMOOBgTiTjn7FsmBnDX7AJkQ/8JAdwD3x
         brWQ==
X-Gm-Message-State: ALoCoQn8MkgxNtvlRCyTUCxXDLxvoVb0HqJ7kcqQ9QDs9bSXpWvyUxdErW4YM+9tQMcvB9mpV3BA
X-Received: by 10.66.246.109 with SMTP id xv13mr32830806pac.15.1415041343739;
        Mon, 03 Nov 2014 11:02:23 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id 30si494571yhw.1.2014.11.03.11.02.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:23 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id bW9Y5Mmj.1; Mon, 03 Nov 2014 11:02:23 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BC256E0C1B; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
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
