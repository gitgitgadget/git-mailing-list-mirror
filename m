From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 18/23] refs.c: add a backend method structure with transaction functions
Date: Wed, 13 Aug 2014 13:15:02 -0700
Message-ID: <1407960907-18189-19-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:15:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexd-0008V4-5z
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbaHMUPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:46 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:34340 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-pd0-f202.google.com with SMTP id w10so83821pde.3
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tY1bax9oZComHJHPDPQzbTK2zSlsT/cpOmU/Y7SmGws=;
        b=fHoZJh260xU6obCdSzrU1kH4cDxbUS69O0u4+w+KXVkN/RYjFcnwOzvPYaKZC28Iq9
         FWTwWUVpTTl49hNzLPwT4HCGywFkvo7joMI8OVQ+2kRF5geG+XT7SXI4ahj1JJER5erl
         IWVssdmdA0QsurYXeCXIjKGPNphe47L/SDmgy4Va+ifeugdDXfcoxLgyek7olO1c7WGs
         Ta8Zi9rn5PcretpEMqaHJjo3sX4pQS+VMibaNmf/p8tA8PhcJ8aIl9NT1jZkWLlyTkw+
         4cNlI+zoUdMnFKsPvMmyfiuVubIuAt5kGyGkC7CXH1CJiPLh06JvMrSni4WZyltfBDl0
         +fnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tY1bax9oZComHJHPDPQzbTK2zSlsT/cpOmU/Y7SmGws=;
        b=U314TLg7ySF4NYo5VgzBiNGDzhpBakFcc9pI3SnXPS0wjEXyzUo+gjb9yXpAevuj/6
         lKtlxbMMR6jMaQX4xdrh2kITI3XCA9aW/Ts5hyaHyfJJExj/O1920Tmb+4F/LcYWQDos
         E1KTQ/E/ITSgmI9I0Nkh+X9g820kuAs7EglydK45baCGzv6/SBxYNf5JG3QMAgnd029h
         NdFk+9ANlCYHA1iQMuAy4ziZNxV73ULQJf8A4/WnPqRJ9+42JXT8CqgTjT70zgQsKFsB
         ykQhu3J3ix74/MR3bEptlVeZTLtTWYXmr2cQt7+RG/dm+LOX5+CMHhX0Tls2JKlYe7OQ
         Y9nA==
X-Gm-Message-State: ALoCoQmM30oOgtuw4J5HkUPKr4/ohfdYTlgyfEy2fsGCno/SIQGCQn0yPPDgWZyE/Ry7zGERSTqz
X-Received: by 10.68.69.98 with SMTP id d2mr3553859pbu.0.1407960910871;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v20si209971yhe.2.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 9D9ED5A453F;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 79A46E0AA0; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255239>

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
index aafc4c8..e7cea02 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -799,3 +799,57 @@ int check_refname_format(const char *refname, int flags)
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
index e58a7e1..27eafd0 100644
--- a/refs.c
+++ b/refs.c
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
2.0.1.556.g3edca4c
