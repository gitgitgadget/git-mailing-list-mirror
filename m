From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 1/5] refs.c: allow passing raw git_committer_info as email to _update_reflog
Date: Wed, 30 Jul 2014 14:52:44 -0700
Message-ID: <1406757168-3729-2-git-send-email-sahlberg@google.com>
References: <1406757168-3729-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 23:53:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCbnw-0005eJ-Tb
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 23:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbaG3Vw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 17:52:57 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:43611 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbaG3Vwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 17:52:55 -0400
Received: by mail-ob0-f202.google.com with SMTP id wp18so403208obc.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 14:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uEMY1Qm51K+FMMXaeM+jLGdfS1RVD5Y1cFi5yrATYgA=;
        b=n5N7xFWszWiw+Vdlnw1Ivx47gi5Ggor3Rnu16zPXQRr6ToFslSz5mw1d8K08gMBjJZ
         Gc/9/+VDn/NxVoCmNeb5fnDo5/AkSpCnfcJsFahOMrNcXoxcmxZ31SauZOX63Wk7oTty
         RVPx3sr7OO224L8vrh9bN2Jxo0ziWriYGldyTQuzON3lbH56Fgnw5UceCnBTPBGEjeOs
         ZGrylWZHGZkYvh9m/5wq3GRvzCeYV/n6X5R2fJklZjRwjait+3wQORYItONVaAO9Cmzc
         B44Idwska661DrSerBJsC8/N+y1zSyihVuAIjPaiOiUFboTRAo85qvBH/V/7+nfW3ohA
         SPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uEMY1Qm51K+FMMXaeM+jLGdfS1RVD5Y1cFi5yrATYgA=;
        b=V9Vbqb22XyV68T9ZFrw16U5qXUC44YLk9Fze1FcW5UYCHMNa60lnnqR2B6YSrEuWW9
         itp29R2BzPLNVUzeQbwFjSCvQlk9cGrhy8f0f2+MV+BddWpKkv75SQGiFmYZTK5iu8Le
         jkwS4/tE28Aoq7812SgdEzu311LLm6x52d9S+DP251NkrRSuUUnASXmYcgVK3Hn+gMgK
         pWpHRneWHh9r1yH39WqLke3u8e+kKN4hg1UofYFMCcgWf4Egy3dUxklf3SKjEoWDbi1N
         weHjuztQ0OQBeqoUAhbjq88gpxKzbR3DLPEmX/LST3wZb8gStzgOhw83GBFViMBKX+CE
         fe5g==
X-Gm-Message-State: ALoCoQn7aHXog5abACbmHU7sknw94nIKLNHD2kOgftOc9+otUTj91/RZxtdjAqFXpGZDyRb8bdYM
X-Received: by 10.182.27.35 with SMTP id q3mr2948838obg.34.1406757174493;
        Wed, 30 Jul 2014 14:52:54 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a66si223473yhg.7.2014.07.30.14.52.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jul 2014 14:52:54 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 407E75A4308;
	Wed, 30 Jul 2014 14:52:54 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DD882E08CB; Wed, 30 Jul 2014 14:52:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g0041e8a
In-Reply-To: <1406757168-3729-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254518>

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
---
 builtin/reflog.c | 19 +++++++++++++------
 refs.c           | 21 ++++++++++++---------
 refs.h           | 25 +++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index f11fee3..c6f3a2f 100644
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
@@ -671,7 +678,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 }
 
 static int count_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *id, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cb = cb_data;
diff --git a/refs.c b/refs.c
index 2662ef6..41cb51d 100644
--- a/refs.c
+++ b/refs.c
@@ -3096,7 +3096,7 @@ struct read_ref_at_cb {
 };
 
 static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *id, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
@@ -3143,7 +3143,7 @@ static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
 }
 
 static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
-				  const char *email, unsigned long timestamp,
+				  const char *id, unsigned long timestamp,
 				  int tz, const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
@@ -3491,8 +3491,7 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const char *email,
-			      unsigned long timestamp, int tz,
+			      struct reflog_committer_info *ci,
 			      const char *msg, int flags,
 			      struct strbuf *err)
 {
@@ -3521,13 +3520,17 @@ int transaction_update_reflog(struct ref_transaction *transaction,
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
index 0172f48..23067a2 100644
--- a/refs.h
+++ b/refs.h
@@ -309,6 +309,28 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
  * Flags >= 0x100 are reserved for internal use.
  */
 #define REFLOG_TRUNCATE 0x01
+#define REFLOG_COMMITTER_INFO_IS_VALID 0x02
+
+/*
+ * Committer data provided to reflog updates.
+ * If flags contain REFLOG_COMMITTER_DATA_IS_VALID then
+ * then the structure contains a prebaked committer string
+ * just like git_committer_info() would return.
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
@@ -318,8 +340,7 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const char *email,
-			      unsigned long timestamp, int tz,
+			      struct reflog_committer_info *ci,
 			      const char *msg, int flags,
 			      struct strbuf *err);
 
-- 
2.0.1.523.g0041e8a
