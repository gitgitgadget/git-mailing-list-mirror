From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 05/32] refs: add a backend method structure with transaction functions
Date: Wed, 24 Feb 2016 17:58:37 -0500
Message-ID: <1456354744-8022-6-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 24 23:59:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPH-0003fn-RV
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759069AbcBXW7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:20 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33033 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759048AbcBXW7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:18 -0500
Received: by mail-qg0-f54.google.com with SMTP id b35so27008080qge.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Tm7cliWVZf8MvAkzUQmdShb0u0iXDzHWaYCUBzov+c=;
        b=1fOyBWNsFmxDu+jN/wfvAuHk5nOjULYUeAy/l9MCdbMi8eEfDVs7q8kWtyaNpgqJr8
         GVJJlmw7oS86YjhWKEIDz0ZKFW+uNxioHi1IZ49Wy4kBLebG7XajW47r2f+6Leg653II
         rqZ0c8PXg/ynGcM/r3SDfZHuIqRfARdpbevfMjuQxxplll1xsEaGnA4SnvocZsYb+qvd
         FtgNahNY9w79cIGHezF7mIEVQc/JdtH8g+aLLMYXN6+CSBmURZeWQExd0mCzXL786jU8
         3bJ3niCpXXVI1ltDrEJWbVvFCKa6+I9bK6rEiX/y222//0dCIQ5iubGGtbKP6e4aWfnj
         Qfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Tm7cliWVZf8MvAkzUQmdShb0u0iXDzHWaYCUBzov+c=;
        b=DfJkb6tZCyWnfA6yRReo4x7FRAul0nvJwNLSsyGvM8SDSQeR0534dkunHz5eu0LkB0
         6yblVy7NRq8te3EjSKIsVKKpapW698Z3gkGV+HgxpcRn/lQD7PM4uWYE/+pq6sBpweS9
         qdyGuyc6mxHEmAlKDU4/fV6ZqqrcjxMGvEf0dZW1Muog4SoCr7uXxhMU8BankPKd4iHI
         0/WZLgPpHRJoAFktV2od1UQC3SYC8ORK9JTzX3P47Fy0/Z1Tkb4j9A1eaS0EHJPYqk6m
         LAOWKmA5vyqGk+FtrMte09u22kF6QnrGaznqiPDHtklujgcjMc8KxQEaOS1AQ3/nIMAx
         7xwg==
X-Gm-Message-State: AG10YOQpAc/RXgh/HR4iLi6Ibo2BkqCdATp2ULQSTAfd5bBBc7NFzvJ1siBxgJkc0ZLq+g==
X-Received: by 10.140.25.161 with SMTP id 30mr51778559qgt.73.1456354757981;
        Wed, 24 Feb 2016 14:59:17 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:17 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287255>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a ref structure for storage backend methods. Start by adding a
method pointer for the transaction commit function.

Add a function set_refs_backend to switch between storage
backends. The files based storage backend is the default.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 41 +++++++++++++++++++++++++++++++++++++++++
 refs.h               |  7 +++++++
 refs/files-backend.c | 10 ++++++++--
 refs/refs-internal.h | 12 ++++++++++++
 4 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index f4c0a85..6d16058 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,39 @@
 #include "tag.h"
 
 /*
+ * We always have a files backend and it is the default.
+ */
+static struct ref_storage_be *the_refs_backend = &refs_be_files;
+/*
+ * List of all available backends
+ */
+static struct ref_storage_be *refs_backends = &refs_be_files;
+
+int set_ref_storage_backend(const char *name)
+{
+	struct ref_storage_be *be;
+
+	for (be = refs_backends; be; be = be->next)
+		if (!strcmp(be->name, name)) {
+			the_refs_backend = be;
+			return 0;
+		}
+	return 1;
+}
+
+int ref_storage_backend_exists(const char *name)
+{
+	struct ref_storage_be *be;
+
+	for (be = refs_backends; be; be = be->next)
+		if (!strcmp(be->name, name)) {
+			the_refs_backend = be;
+			return 1;
+		}
+	return 0;
+}
+
+/*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
  * 1: End-of-component
@@ -1157,6 +1190,7 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(NULL, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
+
 /* This function needs to return a meaningful errno on failure */
 static const char *resolve_ref_1(const char *refname,
 				 int resolve_flags,
@@ -1261,3 +1295,10 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	strbuf_release(&sb_path);
 	return ret;
 }
+
+/* backend functions */
+int ref_transaction_commit(struct ref_transaction *transaction,
+			   struct strbuf *err)
+{
+	return the_refs_backend->transaction_commit(transaction, err);
+}
diff --git a/refs.h b/refs.h
index 3c3da29..5bc3fbc 100644
--- a/refs.h
+++ b/refs.h
@@ -508,4 +508,11 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 reflog_expiry_cleanup_fn cleanup_fn,
 			 void *policy_cb_data);
 
+/*
+ * Switch to an alternate ref storage backend.
+ */
+int set_ref_storage_backend(const char *name);
+
+int ref_storage_backend_exists(const char *name);
+
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5749eff..45b81cd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3012,8 +3012,8 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+static int files_transaction_commit(struct ref_transaction *transaction,
+				    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3399,3 +3399,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	unlock_ref(lock);
 	return -1;
 }
+
+struct ref_storage_be refs_be_files = {
+	NULL,
+	"files",
+	files_transaction_commit,
+};
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 979a136..62ba0c0 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -212,4 +212,16 @@ int do_for_each_ref(const char *submodule, const char *base,
 int read_raw_ref(const char *refname, unsigned char *sha1,
 		 struct strbuf *symref, struct strbuf *sb_path,
 		 unsigned int *flags);
+
+/* refs backends */
+typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
+				      struct strbuf *err);
+
+struct ref_storage_be {
+	struct ref_storage_be *next;
+	const char *name;
+	ref_transaction_commit_fn *transaction_commit;
+};
+
+extern struct ref_storage_be refs_be_files;
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.767.g62658d5-twtrsrc
