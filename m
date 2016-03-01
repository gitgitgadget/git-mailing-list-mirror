From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 07/33] refs: add methods for misc ref operations
Date: Mon, 29 Feb 2016 19:52:40 -0500
Message-ID: <1456793586-22082-8-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYaP-0007bz-V9
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbcCAAyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:47 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36079 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbcCAAxe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:34 -0500
Received: by mail-qg0-f51.google.com with SMTP id u110so1410424qge.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IGw1LlPtH9ts7XY8vFr+JaZW3AxNx9TNZQNkUYUfcJ4=;
        b=nxeu/dTh3Gu8fC6efzjWgcSWQL5avWRn6fzQTUgTQukan2uZpAv8TsRrgalKQvHN1s
         FqBlspwBLBz2hZlahCD9FEFP2eJ/06DWYIzaFkrk4YcwGNQuzfsYYi7J6bq9dJyzDGLn
         TPq1KwTiVSzlDVOaa5NnwYt+x9NAiZDqvnBrWqsq7DLameaw0B/SST+1C3kIVsJ2u7qw
         jjpNQ2PgFghF8sW5ImvXBqagzu8d0E1btISJHVfOMIsq0p92nMn0Ux+Ug99j98GmP53l
         LNUeG1C7hJ29Ocm+QnShYNkAKG4fIpfqGKKzUaStsiPpW/60Pc1X4zQHJVA2FiNidCi5
         9inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IGw1LlPtH9ts7XY8vFr+JaZW3AxNx9TNZQNkUYUfcJ4=;
        b=YcoRInINi/v3objklkxC2udAhPSbtFvq2P7XnFiwPUUaK8tQS6rfEF1XOgwvDuTPcz
         tcYgDt2hcGjGkrg6uaT1oaR12+9VxUaiTF8JbTXrsdrFhZBzNe72EBpHCLj7AbtpogQS
         R/FDhdjjyuS22324h623/Th3MSy4YDs6xzlsrP03wzjrk7+YyP6Y0OUTPAvUf9OoLlIN
         QVFgEgvJP8BbRNskaFWpE66pg0SveDgK7zHVb7yg7N04rNBotrcV+k9nPs/XDM3LtuUi
         DSGpz9zilcYCqVnWH1aUpdgK15KA8Es/hSx4M7bx4Ij1kAiOaJ4kFLha2R+tFWyh1DM/
         GAEQ==
X-Gm-Message-State: AD7BkJL+ymLupHURoBwAnh9axNkUzjaPv5FziHxnSRCRbYUMMMNM1n3bmdkRv6PCaKK4iQ==
X-Received: by 10.140.155.196 with SMTP id b187mr24470741qhb.14.1456793613358;
        Mon, 29 Feb 2016 16:53:33 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:32 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287972>

From: Ronnie Sahlberg <sahlberg@google.com>

Add ref backend methods for:
read_raw_ref, verify_refname_available, pack_refs, peel_ref,
create_symref, resolve_gitlink_ref.

read_raw_ref becomes static because it's not used outside refs.c

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 37 +++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 33 ++++++++++++++++++++++-----------
 refs/refs-internal.h | 27 +++++++++++++++++++++++----
 3 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 2e8efa9..f4873d6 100644
--- a/refs.c
+++ b/refs.c
@@ -1194,6 +1194,14 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
+static int read_raw_ref(const char *refname, unsigned char *sha1,
+			struct strbuf *symref, struct strbuf *sb_path,
+			unsigned int *flags)
+{
+	return the_refs_backend->read_raw_ref(refname, sha1, symref, sb_path,
+					      flags);
+}
+
 /* This function needs to return a meaningful errno on failure */
 static const char *resolve_ref_1(const char *refname,
 				 int resolve_flags,
@@ -1305,3 +1313,32 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 {
 	return the_refs_backend->transaction_commit(transaction, err);
 }
+
+int verify_refname_available(const char *refname, struct string_list *extra,
+			     struct string_list *skip, struct strbuf *err)
+{
+	return the_refs_backend->verify_refname_available(refname, extra, skip, err);
+}
+
+int pack_refs(unsigned int flags)
+{
+	return the_refs_backend->pack_refs(flags);
+}
+
+int peel_ref(const char *refname, unsigned char *sha1)
+{
+	return the_refs_backend->peel_ref(refname, sha1);
+}
+
+int create_symref(const char *ref_target, const char *refs_heads_master,
+		  const char *logmsg)
+{
+	return the_refs_backend->create_symref(ref_target, refs_heads_master,
+					       logmsg);
+}
+
+int resolve_gitlink_ref(const char *path, const char *refname,
+			unsigned char *sha1)
+{
+	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a509240..96be63c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1330,7 +1330,8 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+static int files_resolve_gitlink_ref(const char *path, const char *refname,
+				     unsigned char *sha1)
 {
 	int len = strlen(path), retval;
 	struct strbuf submodule = STRBUF_INIT;
@@ -1413,9 +1414,9 @@ static int resolve_missing_loose_ref(const char *refname,
  *
  * sb_path is workspace: the caller should allocate and free it.
  */
-int read_raw_ref(const char *refname, unsigned char *sha1,
-		 struct strbuf *symref, struct strbuf *sb_path,
-		 unsigned int *flags)
+static int files_read_raw_ref(const char *refname, unsigned char *sha1,
+			      struct strbuf *symref, struct strbuf *sb_path,
+			      unsigned int *flags)
 {
 	struct strbuf sb_contents = STRBUF_INIT;
 	int ret = -1;
@@ -1568,7 +1569,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
@@ -2127,7 +2128,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags)
+static int files_pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
 
@@ -2318,10 +2319,10 @@ out:
 	return ret;
 }
 
-int verify_refname_available(const char *newname,
-			     struct string_list *extras,
-			     struct string_list *skip,
-			     struct strbuf *err)
+static int files_verify_refname_available(const char *newname,
+					  struct string_list *extras,
+					  struct string_list *skip,
+					  struct strbuf *err)
 {
 	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
@@ -2741,7 +2742,9 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 	return 0;
 }
 
-int create_symref(const char *refname, const char *target, const char *logmsg)
+static int files_create_symref(const char *refname,
+			       const char *target,
+			       const char *logmsg)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
@@ -3395,4 +3398,12 @@ struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_transaction_commit,
+
+	files_pack_refs,
+	files_peel_ref,
+	files_create_symref,
+
+	files_read_raw_ref,
+	files_verify_refname_available,
+	files_resolve_gitlink_ref,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 62ba0c0..c5f5ef7 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -209,18 +209,37 @@ int rename_ref_available(const char *oldname, const char *newname);
 int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
 
-int read_raw_ref(const char *refname, unsigned char *sha1,
-		 struct strbuf *symref, struct strbuf *sb_path,
-		 unsigned int *flags);
-
 /* refs backends */
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
 
+/* misc methods */
+typedef int pack_refs_fn(unsigned int flags);
+typedef int peel_ref_fn(const char *refname, unsigned char *sha1);
+typedef int create_symref_fn(const char *ref_target,
+			     const char *refs_heads_master,
+			     const char *logmsg);
+
+/* resolution methods */
+typedef int read_raw_ref_fn(const char *refname, unsigned char *sha1,
+			    struct strbuf *symref, struct strbuf *sb_path,
+			    unsigned int *flags);
+typedef int verify_refname_available_fn(const char *refname, struct string_list *extra, struct string_list *skip, struct strbuf *err);
+typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
+				   unsigned char *sha1);
+
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_transaction_commit_fn *transaction_commit;
+
+	pack_refs_fn *pack_refs;
+	peel_ref_fn *peel_ref;
+	create_symref_fn *create_symref;
+
+	read_raw_ref_fn *read_raw_ref;
+	verify_refname_available_fn *verify_refname_available;
+	resolve_gitlink_ref_fn *resolve_gitlink_ref;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.4.2.767.g62658d5-twtrsrc
