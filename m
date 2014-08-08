From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 17/22] refs.c: add a backend method structure with transaction functions
Date: Fri,  8 Aug 2014 09:45:04 -0700
Message-ID: <1407516309-27989-18-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:46:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnIu-00085S-99
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756933AbaHHQpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:34 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:35217 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756611AbaHHQpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:17 -0400
Received: by mail-yk0-f202.google.com with SMTP id q9so764635ykb.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6BZKNU0WMprLTjKEKAOSosx2Ts6dVyRzEM3pJtEA3t8=;
        b=m6ZPWYYAz6jHjtvKSSAY0vTOaa5MF0Gvd1XunNR+IrY66o++YOTF4lYrg/f0L8N2dR
         LRQJfrHTP+bR33yOgAFkMYaPGxxJbnash934JDRV/WshQEAc2avJWGpaEL+TBWLl+ipM
         qtY65Av5NnwDK1z1cce+AC4sQMLNuD83FzfBJ0n1in5C0a8ZCz/1TjfmwQ2og6cYbFVS
         ODw7p9YztMLDt7BaXBwI2D2oQOyF5kZqSkcwLHL2FcvLwVN6ClvihtKv8DGm5pq3xjNE
         ojFDnLGUWritzuziBn/dZjIg74XhRHmdKYs69kznkJXygTc2qBPezPcZhgjRtNmNt64J
         Pfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6BZKNU0WMprLTjKEKAOSosx2Ts6dVyRzEM3pJtEA3t8=;
        b=EzVq2o1EguottVXN1NfDq7cGfyNSHBDiXt+QSpp6Sr88IxtDPtGmJZqSfzluEEv9qj
         a6WKvNr8CYwadE668VbSwr2Vc2ZlN8i5vyM6K2zmcjPSL8HGMBdEFnOOGvAs/qc1Hm0X
         g2SVyyPHoU2odcus0WP4Znmi2OfZvX5VnvGweXdkkhZKZgl5J4YTwWKCxBEj4l+0fzum
         BBYKFJdL4bokS9gqu5Eh5jir0sd/Y3qQmj3bOUocan98KRxMPnYcnmw8DES2o46gQOXH
         3tyTQ1hi53qDIoYSXU7w2FVEwy/ZelbZw/UNybtGXpkQQR+O4Whv9j3xTDaIKI8S0RFv
         XlEw==
X-Gm-Message-State: ALoCoQns7vJ1YYHKd+jh2HSZbrEtNAJUYQXUnuFebfy8YxxoDr44d69+bnk4OEecrKXzf8fPjbTp
X-Received: by 10.236.1.198 with SMTP id 46mr5255844yhd.16.1407516316105;
        Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l23si505698yhg.1.2014.08.08.09.45.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DB6FE5A4615;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BD823E0C50; Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255037>

Add a ref structure for backend methods. Start by adding method pointers
for the transaction functions.

Rename the existing transaction functions to files_* and make them static.
Add new transaction functions that just pass through to the appropriate
methods for the backend.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 refs.c        | 68 +++++++++++++++++++++++++++++++++++------------------------
 refs.h        | 35 ++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 27 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 3b20db3..d4782ad 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -784,3 +784,57 @@ int check_refname_format(const char *refname, int flags)
 		return -1; /* Refname has only one component. */
 	return 0;
 }
+
+/* backend functions */
+struct ref_transaction *transaction_begin(struct strbuf *err)
+{
+	return refs->transaction_begin(err);
+}
+
+int transaction_update_sha1(struct ref_transaction *transaction,
+			    const char *refname, const unsigned char *new_sha1,
+			    const unsigned char *old_sha1, int flags,
+			    int have_old, const char *msg, struct strbuf *err)
+{
+	return refs->transaction_update_sha1(transaction, refname, new_sha1,
+					     old_sha1, flags, have_old, msg,
+					     err);
+}
+
+int transaction_create_sha1(struct ref_transaction *transaction,
+			    const char *refname, const unsigned char *new_sha1,
+			    int flags, const char *msg, struct strbuf *err)
+{
+	return refs->transaction_create_sha1(transaction, refname, new_sha1,
+					     flags, msg, err);
+}
+int transaction_delete_sha1(struct ref_transaction *transaction,
+			    const char *refname, const unsigned char *old_sha1,
+			    int flags, int have_old, const char *msg,
+			    struct strbuf *err)
+{
+	return refs->transaction_delete_sha1(transaction, refname, old_sha1,
+					     flags, have_old, msg, err);
+}
+
+int transaction_update_reflog(struct ref_transaction *transaction,
+			      const char *refname,
+			      const unsigned char *new_sha1,
+			      const unsigned char *old_sha1,
+			      struct reflog_committer_info *ci,
+			      const char *msg, int flags,
+			      struct strbuf *err)
+{
+	return refs->transaction_update_reflog(transaction, refname, new_sha1,
+					       old_sha1, ci, msg, flags, err);
+}
+
+int transaction_commit(struct ref_transaction *transaction, struct strbuf *err)
+{
+	return refs->transaction_commit(transaction, err);
+}
+
+void transaction_free(struct ref_transaction *transaction)
+{
+	return refs->transaction_free(transaction);
+}
diff --git a/refs.c b/refs.c
index 9aa88ef..bfb42d8 100644
--- a/refs.c
+++ b/refs.c
@@ -2792,12 +2792,12 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 };
 
-struct ref_transaction *transaction_begin(struct strbuf *err)
+static struct ref_transaction *files_transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-void transaction_free(struct ref_transaction *transaction)
+static void files_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -2827,13 +2827,13 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-int transaction_update_reflog(struct ref_transaction *transaction,
-			      const char *refname,
-			      const unsigned char *new_sha1,
-			      const unsigned char *old_sha1,
-			      struct reflog_committer_info *ci,
-			      const char *msg, int flags,
-			      struct strbuf *err)
+static int files_transaction_update_reflog(struct ref_transaction *transaction,
+					   const char *refname,
+					   const unsigned char *new_sha1,
+					   const unsigned char *old_sha1,
+					   struct reflog_committer_info *ci,
+					   const char *msg, int flags,
+					   struct strbuf *err)
 {
 	struct ref_update *update;
 	int i;
@@ -2880,12 +2880,13 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 	return 0;
 }
 
-int transaction_update_sha1(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old, const char *msg,
-			    struct strbuf *err)
+static int files_transaction_update_sha1(struct ref_transaction *transaction,
+					 const char *refname,
+					 const unsigned char *new_sha1,
+					 const unsigned char *old_sha1,
+					 int flags, int have_old,
+					 const char *msg,
+					 struct strbuf *err)
 {
 	struct ref_update *update;
 
@@ -2912,11 +2913,11 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 	return 0;
 }
 
-int transaction_create_sha1(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags, const char *msg,
-			    struct strbuf *err)
+static int files_transaction_create_sha1(struct ref_transaction *transaction,
+					 const char *refname,
+					 const unsigned char *new_sha1,
+					 int flags, const char *msg,
+					 struct strbuf *err)
 {
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: create called for transaction that is not open");
@@ -2928,11 +2929,12 @@ int transaction_create_sha1(struct ref_transaction *transaction,
 				       null_sha1, flags, 1, msg, err);
 }
 
-int transaction_delete_sha1(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old, const char *msg,
-			    struct strbuf *err)
+static int files_transaction_delete_sha1(struct ref_transaction *transaction,
+					 const char *refname,
+					 const unsigned char *old_sha1,
+					 int flags, int have_old,
+					 const char *msg,
+					 struct strbuf *err)
 {
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: delete called for transaction that is not open");
@@ -2974,8 +2976,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 	return 0;
 }
 
-int transaction_commit(struct ref_transaction *transaction,
-		       struct strbuf *err)
+static int files_transaction_commit(struct ref_transaction *transaction,
+				    struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i, df_conflict = 0, need_repack = 0;
 	int num_updates = 0;
@@ -3299,3 +3301,15 @@ cleanup:
 		ret = -2;
 	return ret;
 }
+
+struct ref_be refs_files = {
+	.transaction_begin		= files_transaction_begin,
+	.transaction_update_sha1	= files_transaction_update_sha1,
+	.transaction_create_sha1	= files_transaction_create_sha1,
+	.transaction_delete_sha1	= files_transaction_delete_sha1,
+	.transaction_update_reflog	= files_transaction_update_reflog,
+	.transaction_commit		= files_transaction_commit,
+	.transaction_free		= files_transaction_free,
+};
+
+struct ref_be *refs = &refs_files;
diff --git a/refs.h b/refs.h
index 5577824..7b92241 100644
--- a/refs.h
+++ b/refs.h
@@ -350,4 +350,39 @@ int update_ref(const char *action, const char *refname,
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
 
+
+/* refs backends */
+typedef struct ref_transaction *(*transaction_begin_fn)(struct strbuf *err);
+typedef int (*transaction_update_sha1_fn)(struct ref_transaction *transaction,
+		const char *refname, const unsigned char *new_sha1,
+		const unsigned char *old_sha1, int flags, int have_old,
+		const char *msg, struct strbuf *err);
+typedef int (*transaction_create_sha1_fn)(struct ref_transaction *transaction,
+		const char *refname, const unsigned char *new_sha1,
+		int flags, const char *msg, struct strbuf *err);
+typedef int (*transaction_delete_sha1_fn)(struct ref_transaction *transaction,
+		const char *refname, const unsigned char *old_sha1,
+		int flags, int have_old, const char *msg, struct strbuf *err);
+typedef int (*transaction_update_reflog_fn)(
+		struct ref_transaction *transaction,
+		const char *refname, const unsigned char *new_sha1,
+		const unsigned char *old_sha1,
+		struct reflog_committer_info *ci,
+		const char *msg, int flags, struct strbuf *err);
+typedef int (*transaction_commit_fn)(struct ref_transaction *transaction,
+				       struct strbuf *err);
+typedef void (*transaction_free_fn)(struct ref_transaction *transaction);
+
+struct ref_be {
+	transaction_begin_fn transaction_begin;
+	transaction_update_sha1_fn transaction_update_sha1;
+	transaction_create_sha1_fn transaction_create_sha1;
+	transaction_delete_sha1_fn transaction_delete_sha1;
+	transaction_update_reflog_fn transaction_update_reflog;
+	transaction_commit_fn transaction_commit;
+	transaction_free_fn transaction_free;
+};
+
+extern struct ref_be *refs;
+
 #endif /* REFS_H */
-- 
2.0.1.553.geee1b3e
