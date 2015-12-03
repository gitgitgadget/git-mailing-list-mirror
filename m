From: David Turner <dturner@twopensource.com>
Subject: [PATCH 01/16] refs: add a backend method structure with transaction functions
Date: Wed,  2 Dec 2015 19:35:06 -0500
Message-ID: <1449102921-7707-2-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Hsa-0006lr-TB
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757245AbbLCAfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:35:45 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34796 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717AbbLCAfh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:37 -0500
Received: by igvg19 with SMTP id g19so2206283igv.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UTZAxuDwxy2F8wJNkCE9itsWDeSqHu5DfXwolEAG91U=;
        b=eeWNII9OmE3funXRtKuMNXajpio+10wxP651NzMtg3Ve5y/Gw4n1v+xb5yBDwxuu1Y
         2dD0OrZC8HEfkyXwfK4rmhyRhJU3Cf5GCNVncEoY6AnG/UgeNT7Isp8zP+XqfIB9/tCA
         DDP1Hd5ieI+49HsclnFbt2lqkvi5WFJW6e932dI6nrr2v1QmuPgp1vS/f2pOltdXyc3k
         vbsv+8m7mEINf8f3Ioq62v0opzSHMrsTZWoiGvrZBF82drIj6h7O5U3KNPBzJVp4AR7J
         06sWJee6EOS4DCid56RZFAR9xI73A5Tygv+EugdQAvVORx09nzjqxcoDUzl+pPk1FF02
         4q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UTZAxuDwxy2F8wJNkCE9itsWDeSqHu5DfXwolEAG91U=;
        b=Z5TBgczfuDTKJfFvNYjmUjN/c6/ENhUwTLdTYDFoPQ2b2CK4pKavjz0xomKzVzjAas
         naO+Ya33RLDxkog4acRo9RTjfclBiYEHM0McHjvYuj4T1gBydrNDgVcdtqt4Bq0X0vs+
         hlKV4uX94SPdBij2GO2qYdRRS1cWfcFANrZrUXs897erkoDxNUz30Z6h2Nj2q7v0xDB0
         7TCHoeVPH04UjRTj2I1XqVyCz0GN3LZr0vauePuax64ncV++zhhDbsBoILkjzg6qyz2Y
         x0ZyFWj7yMMRlA8IMICPjZQxaovDxnaUlQLftlpdrGBy0/vRs/407gEY6NMkO0RZFkz1
         4/7A==
X-Gm-Message-State: ALoCoQkiaIbzR0o1Yn2VqySu6o6v/VZe8qIOOJOm0+NawQegL9oFcOQ9t+IR6Cnr8qWw9z/3UBvd
X-Received: by 10.50.60.41 with SMTP id e9mr13412091igr.2.1449102936828;
        Wed, 02 Dec 2015 16:35:36 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:35 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281926>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a ref structure for backend methods. Start by adding a method pointer
for the transaction commit function.

Add a function set_refs_backend to switch between backends. The files
based backend is the default.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 32 ++++++++++++++++++++++++++++++++
 refs.h               |  2 ++
 refs/files-backend.c | 10 ++++++++--
 refs/refs-internal.h | 10 ++++++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 0f7628d..babba8a 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,31 @@
 #include "tag.h"
 
 /*
+ * We always have a files backend and it is the default.
+ */
+extern struct ref_be refs_be_files;
+struct ref_be *the_refs_backend = &refs_be_files;
+/*
+ * List of all available backends
+ */
+struct ref_be *refs_backends = &refs_be_files;
+
+/*
+ * This function is used to switch to an alternate backend.
+ */
+int set_refs_backend(const char *name)
+{
+	struct ref_be *be;
+
+	for (be = refs_backends; be; be = be->next)
+		if (!strcmp(be->name, name)) {
+			the_refs_backend = be;
+			return 0;
+		}
+	return 1;
+}
+
+/*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
  * 1: End-of-component
@@ -1082,3 +1107,10 @@ int rename_ref_available(const char *oldname, const char *newname)
 	strbuf_release(&err);
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
index 7a04077..4e5477d 100644
--- a/refs.h
+++ b/refs.h
@@ -508,4 +508,6 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 reflog_expiry_cleanup_fn cleanup_fn,
 			 void *policy_cb_data);
 
+int set_refs_backend(const char *name);
+
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4db3e36..be34772 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3123,8 +3123,8 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+static int files_transaction_commit(struct ref_transaction *transaction,
+				    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3510,3 +3510,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	unlock_ref(lock);
 	return -1;
 }
+
+struct ref_be refs_be_files = {
+	NULL,
+	"files",
+	files_transaction_commit,
+};
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7dded3..f2c74f3 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -197,4 +197,14 @@ const char *find_descendant_ref(const char *dirname,
 
 int rename_ref_available(const char *oldname, const char *newname);
 
+/* refs backends */
+typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
+				      struct strbuf *err);
+
+struct ref_be {
+	struct ref_be *next;
+	const char *name;
+	ref_transaction_commit_fn *transaction_commit;
+};
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.749.g0ed01d8-twtrsrc
