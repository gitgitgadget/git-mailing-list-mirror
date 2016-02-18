From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 03/27] refs: add a backend method structure with transaction functions
Date: Thu, 18 Feb 2016 00:17:26 -0500
Message-ID: <1455772670-21142-4-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:20:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWH1D-0002qb-3I
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424711AbcBRFSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:33 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36158 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424477AbcBRFS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:29 -0500
Received: by mail-qg0-f43.google.com with SMTP id y9so29815011qgd.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s2Y3nwP/To/iwJ+8d14p40CIGdm6gbIsJOgHf4l/nbQ=;
        b=UlJO8c5dts5+TF9KMgs88BrM7EV+BsbwhOBjk3b88d21ciOH8qf1KuAdU2Q/S5WTjg
         Gwleyeqk95n2TZn65ZbWIxubtLfTQ/fAMNEX9a+tBE+qPGMZ4gUgW/dE/cDTDcR1Lo0N
         NEQBmtMhOfrgwv9cbsB/RMxaEldGQO9VRxwYvGnU/Tpj2gUT0HKKGjPDQj9Wi5gEjgv5
         OwNxU1XJ4/n5U6dkc6i3RlqUtOs8qWY1E/NxLf0cHbq5fi0ZMbQCLxe0vw0nDy6Sat9h
         YqU6/YLeLcpz9KwEzIgB2DPLctKhsFxc1AaR8QfgRszS4ZGO1m5WISGtcyjBGVAIFc7V
         Umig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s2Y3nwP/To/iwJ+8d14p40CIGdm6gbIsJOgHf4l/nbQ=;
        b=fEXxxr36iTw34y18xZPMibLhY6jpewL2baMZwrhD9HEfxy/6bVSKUnY+I4A/hok8F+
         Gs/QiIp3T9YIcRY/pWUI2dbOKLQy846vnuwwYtXew/VoOT4zod+Vn6efIb0QgYxrKVdL
         xbqjnR2llhpq8ly2zrPt9G2iDuYrzD44x94Cen0joX5Spnp+MqHhLuXPCUuiLKwBJAHn
         50wAsCRW7cFXdRA1UopcQAVMnrjzZEDbEU3FA4vqpgsiNETTTLL47NmR4TUZPVkZl2ak
         ZIz1EDXumWXZFEuWQpMjbFOARhpWycZVJovdO4+IWzC4rNiR3ECaCWkPPMG1grtJkVPh
         8aXA==
X-Gm-Message-State: AG10YOSTc4xoLiEPnAB+HsT+xSoGyOZscpwkRFfNx6zDDY8zdkwj6e8Qpz4wB9gm3v9NPw==
X-Received: by 10.140.107.70 with SMTP id g64mr6563513qgf.75.1455772708853;
        Wed, 17 Feb 2016 21:18:28 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:28 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286598>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a ref structure for storage backend methods. Start by adding a
method pointer for the transaction commit function.

Add a function set_refs_backend to switch between storage
backends. The files based storage backend is the default.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 40 ++++++++++++++++++++++++++++++++++++++++
 refs.h               |  7 +++++++
 refs/files-backend.c | 10 ++++++++--
 refs/refs-internal.h | 14 +++++++++++++-
 4 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index c38311b..ac885cb 100644
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
@@ -1157,3 +1190,10 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(NULL, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
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
index fd664d6..caeb478 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3066,8 +3066,8 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+static int files_transaction_commit(struct ref_transaction *transaction,
+				    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3453,3 +3453,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
index 92aae80..c240ca6 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -197,7 +197,6 @@ const char *find_descendant_ref(const char *dirname,
 
 int rename_ref_available(const char *oldname, const char *newname);
 
-
 /* Include broken references in a do_for_each_ref*() iteration: */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
@@ -206,4 +205,17 @@ int rename_ref_available(const char *oldname, const char *newname);
  */
 int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
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
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.767.g62658d5-twtrsrc
