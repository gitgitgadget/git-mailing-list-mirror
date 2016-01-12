From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 01/21] refs: add a backend method structure with transaction functions
Date: Mon, 11 Jan 2016 20:22:00 -0500
Message-ID: <1452561740-8668-2-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:22:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aInfO-00036D-1e
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761751AbcALBWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:31 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35359 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761337AbcALBW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:28 -0500
Received: by mail-qg0-f45.google.com with SMTP id o11so417838932qge.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M1rkbeyYGAf4SXzqFpbo1t67bGrbVpZmpTG50PEzJjw=;
        b=krnbsV855L+Ac2LThAsVlrYoKm4sLSHbSjOOpaloOG5FAqCoMNZr3qZRoNNQdjbg99
         39RyRQNc4ARqDqKNTTp1TLfW6shfQhVisuF33FHXQIKP9LzU0l6G0SIdntF3194w+etI
         gWD/0ZVeqkV7myqHVXOYmOMB+nq2NsB/LHnF+iqbnMA+wveYifSMIiFAezsP863WuhxT
         FrbVkgZrpcvOew2/mKF74tRxwo/9Ps9pc6NTmecEUBKEC6jccI27l0Eufw+KCW7rn/9G
         78355KN+WiINLuM0jBSNCbig/rdWYSwxnzBb8BDGNoPLtHS1488lglrKXyvNjDo4Mdoi
         nqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M1rkbeyYGAf4SXzqFpbo1t67bGrbVpZmpTG50PEzJjw=;
        b=h/gqs/SLEFDtIy0+LWuYXNFk9CzZoUrNlPpjpIqSoQbhEb5Ff8jXfOoe0w31vovxLC
         lRnCjiwBlAwzkQIsmCbS+iiBsuvdO6Npxgsa5kqdfQmH2fl0LAZeBlPp9v0FGhwRpGxM
         YeYSiyuH7i+Y945CSWicMCC+4fqoX4L/KCdfq4ejg8Kbr7mnehD88Ho65e1HCFEuj4dn
         fKXlnqjsNnQOnw7YyebnGDMKmEXPFtJdthoBjR5AZ8Tt/P0v8EMUFztW9iKNuBrNt89T
         7ysML1EHm0CpzHkBWLenprpcXVXhM1WppCs0rbH7WVc48SyEbr3faJuu1HFxJ7ULsDLG
         T0Iw==
X-Gm-Message-State: ALoCoQmbD0Ugb94w+cBvF8LuiIqqsQbCT8WK+GwkJSepXzxRFHa6rfZYBBIUbkFcjUTgeDl8zeYPKRvcjNokSNbTk0tAjqJK6A==
X-Received: by 10.140.39.210 with SMTP id v76mr104111258qgv.8.1452561747956;
        Mon, 11 Jan 2016 17:22:27 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:26 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283738>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a ref structure for storage backend methods. Start by adding a
method pointer for the transaction commit function.

Add a function set_refs_backend to switch between storage
backends. The files based storage backend is the default.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 29 +++++++++++++++++++++++++++++
 refs.h               |  5 +++++
 refs/files-backend.c | 10 ++++++++--
 refs/refs-internal.h | 10 ++++++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 0f7628d..831ee12 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,28 @@
 #include "tag.h"
 
 /*
+ * We always have a files backend and it is the default.
+ */
+struct ref_storage_be refs_be_files;
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
+/*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
  * 1: End-of-component
@@ -1082,3 +1104,10 @@ int rename_ref_available(const char *oldname, const char *newname)
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
index 7a04077..3464a79 100644
--- a/refs.h
+++ b/refs.h
@@ -508,4 +508,9 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 reflog_expiry_cleanup_fn cleanup_fn,
 			 void *policy_cb_data);
 
+/*
+ * Switch to an alternate ref storage backend.
+ */
+int set_ref_storage_backend(const char *name);
+
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4db3e36..684a517 100644
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
+struct ref_storage_be refs_be_files = {
+	NULL,
+	"files",
+	files_transaction_commit,
+};
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7dded3..b110c77 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -197,4 +197,14 @@ const char *find_descendant_ref(const char *dirname,
 
 int rename_ref_available(const char *oldname, const char *newname);
 
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
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.749.g730654d-twtrsrc
