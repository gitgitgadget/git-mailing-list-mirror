From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 19/23] refs-be-files.c: add a backend method structure with transaction functions
Date: Tue, 19 Aug 2014 09:30:43 -0700
Message-ID: <1408465847-30384-20-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKZ-0002zZ-Nr
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbaHSQb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:29 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:58808 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbaHSQa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:57 -0400
Received: by mail-pd0-f202.google.com with SMTP id w10so1789151pde.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0mMfBsHSLZUD6jyCICyxmMuvEz3cpgP5LJrTaDVM4Rc=;
        b=WC8/9LQjDEM3iTugTAnbcPK5keBonEUUKEBNGirxKS9/anZQ0zY8bg8gEe7Iuc+RgS
         d+s5Kld7ffh+TteDypkn6b0NqKpb3cBtKMOtaDV0WkOhmh0dbb/AC0QZNEwnppU4adsh
         W1Lt7CR9GWED/e2f8hqcFSfBGaTRUTWA/6ePV9OekAYXTSbUtBCTngM3P1ImBXUYSNqh
         J/rdl0Vcfzqn4WKnuYkjkU5K3Ms7wfQEvuEzotNKLJGpoF+UmqXn2hBoxxqi+oqtYVDr
         R8gjRjFdEWAMNT6GWcRFkDtAG8Opc5anb3NqZ4jY+dvKLkj3/+03ufKVzrMDKDMUivRe
         67dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0mMfBsHSLZUD6jyCICyxmMuvEz3cpgP5LJrTaDVM4Rc=;
        b=WrievR6YyCt6E3vEaPhwusmmYg7nlqfcKyNtuidF27i00hc3e/EnletLww1sBUgYwf
         SX4KnjY4uoB/i3V3R/LRTA8dGOmIZYqqxFMsR+bXHRdR5k0uBg/HRAC3mdb853+04g1N
         GFLQDSvcYOLHsHDtJVdm0KWxOZtd+85EvcdQCB8UffoOman1nCvriIsy7OdFpZU6L9my
         tCPlNnBLdBlXiCRIOrKix33kmTBVezs0AXVspRgcuNBHS/uKdLPEHZXcGDSCKnFXow16
         3M8vE7WLIeIoi9QxbTwTJSEospS1NvRHFsDciw9YC2zI6INcqMjwjjVtWh1tzoOapA8s
         TN4g==
X-Gm-Message-State: ALoCoQn2f9GmQh8vrF06G7MuogKFzf7P2GCPdeaZ12e1mTK8BYgcK2JICKt/A+EFmhl6t5ueOuyK
X-Received: by 10.66.161.7 with SMTP id xo7mr22726112pab.14.1408465854005;
        Tue, 19 Aug 2014 09:30:54 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v20si329153yhe.2.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 882325A4406;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 354DEE0F40; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255487>

Add a ref structure for backend methods. Start by adding method pointers
for the transaction functions.

Rename the existing transaction functions to files_* and make them static.
Add new transaction functions that just pass through to the appropriate
methods for the backend.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 68 ++++++++++++++++++++++++++++++++++-----------------------
 refs.c          | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 refs.h          | 35 +++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 27 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index e58a7e1..27eafd0 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2777,12 +2777,12 @@ struct ref_transaction {
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
 
@@ -2812,13 +2812,13 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
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
@@ -2865,12 +2865,13 @@ int transaction_update_reflog(struct ref_transaction *transaction,
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
 
@@ -2897,11 +2898,11 @@ int transaction_update_sha1(struct ref_transaction *transaction,
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
@@ -2913,11 +2914,12 @@ int transaction_create_sha1(struct ref_transaction *transaction,
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
@@ -2959,8 +2961,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 	return 0;
 }
 
-int transaction_commit(struct ref_transaction *transaction,
-		       struct strbuf *err)
+static int files_transaction_commit(struct ref_transaction *transaction,
+				    struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i, df_conflict = 0, need_repack = 0;
 	int num_updates = 0;
@@ -3284,3 +3286,15 @@ cleanup:
 		ret = -2;
 	return ret;
 }
+
+struct ref_be refs_files = {
+	files_transaction_begin,
+	files_transaction_update_sha1,
+	files_transaction_create_sha1,
+	files_transaction_delete_sha1,
+	files_transaction_update_reflog,
+	files_transaction_commit,
+	files_transaction_free,
+};
+
+struct ref_be *refs = &refs_files;
diff --git a/refs.c b/refs.c
index 6b434ad..b8c942f 100644
--- a/refs.c
+++ b/refs.c
@@ -801,3 +801,58 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 
 	return ret;
 }
+
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
diff --git a/refs.h b/refs.h
index a14fc5d..4b669f5 100644
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
2.0.1.552.g1af257a
