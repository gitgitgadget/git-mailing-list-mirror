From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 01/15] refs.c: allow passing raw git_committer_info as email to _update_reflog
Date: Tue, 21 Oct 2014 13:36:46 -0700
Message-ID: <1413923820-14457-2-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:37:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggBg-0000wA-Ih
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933329AbaJUUhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:37:35 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:59490 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933092AbaJUUhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:37:05 -0400
Received: by mail-ob0-f202.google.com with SMTP id wp4so305383obc.5
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GmxZqHbTiOQZ5dND6KcpLAogZ9qaWOJn6prGIQEywDw=;
        b=gVoXKevGeVqeuNcFn0T1qqpPCbuk/vYrqc/TKqdh6IgihNsZ6gK0BrZZOVzUCRDImn
         gSItMuD0PalL6/avnwT5y3KCErvMCFe2sQ9nxAJlMLq5xEu9wW+zC5MJcJrFjgpcZ0Rq
         UNGM5x0O1i7Qkkm5V16rrfhY5o0m84kx8UaTTZ2c5Yftdhjsn0zcetjAhB4/fbUJY2Q5
         l4p+zqPuSzSYoDAz9ntXVE70u+kjeCWsFZo4x4LCJ+zNdy+HhiUIgPLKEqyWrGgZteX4
         OoZCL0qdB1/wAKPYaxLIGZj4UzRKaQMCpIwAkeYkvL4Vd8hZ2Og2MAMVpOKHUMz5hQ+f
         REmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GmxZqHbTiOQZ5dND6KcpLAogZ9qaWOJn6prGIQEywDw=;
        b=SvdcdRO9jUXUG6C96LXNXVo8mDgWEMVmtlVdFIZkIY8eh/dsf8E+D6xDurae8tEckP
         bQv8FenSe0dgI686iZ56cLSd4nTJqfKaOjR5bNpGwgqOL7bfiLz1gRQ2WtCv0IqiTM06
         c7sXmtVOdXePA+mb7bDpNZEYnfHZQK+CHM9F/s0MgDLfEjFiNjX0eeMqY+FbwknN2hQf
         r7o/8Cb9M5srvglJ6UXJJnfSkM726+uBybz6fj50LjVhEYueyFiPQQurpO1T6zd8ILro
         ohS80CnMcf6BD88pmyTQ5IwXPaJGAuSGCc6pIAnDMKWVWLTJarRe/R5yOhBIxGlGa8QG
         4U7A==
X-Gm-Message-State: ALoCoQmE8o8oxK5TGjdPQmYWCkxUFLbKcxbnXHFE3tiBb5tU1/8nRMmtCuL++4IUmaM1vM6rm8U3
X-Received: by 10.43.91.72 with SMTP id bl8mr442893icc.21.1413923823580;
        Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id s23si596479yhf.0.2014.10.21.13.37.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 8Q2KqFng.1; Tue, 21 Oct 2014 13:37:03 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BBBD3E0A43; Tue, 21 Oct 2014 13:37:02 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 167e0c6d205ed785cc17b96e22d9366accfa1665 upstream.

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

Change-Id: I179cd8cc88570801ce6ef1daa8f738e7d20851fa
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
index ae29d11..e49fbe9 100644
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
@@ -3623,8 +3623,7 @@ int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const char *email,
-			      unsigned long timestamp, int tz,
+			      struct reflog_committer_info *ci,
 			      const char *msg, int flags,
 			      struct strbuf *err)
 {
@@ -3652,13 +3651,17 @@ int transaction_update_reflog(struct transaction *transaction,
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
