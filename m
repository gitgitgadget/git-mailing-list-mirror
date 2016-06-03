From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 34/38] refs: add method for delete_refs
Date: Fri,  3 Jun 2016 23:04:09 +0200
Message-ID: <17da5760ac671c98811cc5a3ec46a61f8261d8d9.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJ2-00025e-GC
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbcFCVGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:32 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61312 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932946AbcFCVF1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:27 -0400
X-AuditID: 1207440c-c3fff70000000b85-22-5751f1174cd7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C4.65.02949.711F1575; Fri,  3 Jun 2016 17:05:27 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kd0003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:25 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqCv+MTDc4OpBQYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGf8OT2FqeCUeMWO5jWsDYybhLsY
	OTkkBEwkdkxsZ+pi5OIQEtjKKDHnfyszhHOcSWLenpssIFVsAroSi3qamUBsEYEIiYZXLYwg
	RcwCc5gkbj/sZAZJCAuYS7T/WQNWxCKgKtHa+gOsmVcgSmLesauMEOvkJC5Pf8AGYnMKWEi0
	fF7FCmILAfU2njrMMoGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXUO93MwSvdSU0k2M
	kLDj2cH4bZ3MIUYBDkYlHt6CZ4HhQqyJZcWVuYcYJTmYlER5994BCvEl5adUZiQWZ8QXleak
	Fh9ilOBgVhLhTXkNlONNSaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfAu
	eg/UKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KgvhiYByApHiA9p4DaectLkjM
	BYpCtJ5iVJQS5z0EkhAASWSU5sGNhSWTV4ziQF8K894GqeIBJiK47ldAg5mABhc88gcZXJKI
	kJJqYCzMvSpc7n7T8lKuiAzT7ZMv0xKlb3TaegdNLz6W4n9BdNY917nfJ1zPvmfV9dkgftqG
	rg9N57/fuvUszZ9Lj/XiuegZz9bYf3oYtyz79+HajIOHNjtv367yyGvDk7nNCyNU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296408>

From: David Turner <dturner@twopensource.com>

In the file-based backend, delete_refs has some special optimization
to deal with packed refs.  In other backends, we might be able to make
ref deletion faster by putting all deletions into a single
transaction.  So we need a special backend function for this.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
I think that we could get away without this method if we make
ref_transactions a bit smarter (for example, by supporting best-effort
updates that can fail without causing the entire transaction to be
aborted). But that would be a significant detour, so let's leave it
here for now.

 refs.c               | 7 +++++++
 refs/files-backend.c | 6 ++++--
 refs/refs-internal.h | 3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 6c1e899..8ab9862 100644
--- a/refs.c
+++ b/refs.c
@@ -1529,3 +1529,10 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 
 	return refs->be->initial_transaction_commit(refs, transaction, err);
 }
+
+int delete_refs(struct string_list *refnames, unsigned int flags)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->delete_refs(refs, refnames, flags);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 253899f..5681141 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2455,10 +2455,11 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_refs(struct string_list *refnames, unsigned int flags)
+static int files_delete_refs(struct ref_store *ref_store,
+			     struct string_list *refnames, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "delete_refs");
+		files_downcast(ref_store, 0, "delete_refs");
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
 
@@ -4070,6 +4071,7 @@ struct ref_storage_be refs_be_files = {
 	files_pack_refs,
 	files_peel_ref,
 	files_create_symref,
+	files_delete_refs,
 
 	files_ref_iterator_begin,
 	files_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index e462b54..f944b7a 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -485,6 +485,8 @@ typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *ref_target,
 			     const char *refs_heads_master,
 			     const char *logmsg);
+typedef int delete_refs_fn(struct ref_store *ref_store,
+			   struct string_list *refnames, unsigned int flags);
 
 /*
  * Iterate over the references in the specified ref_store that are
@@ -582,6 +584,7 @@ struct ref_storage_be {
 	pack_refs_fn *pack_refs;
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
+	delete_refs_fn *delete_refs;
 
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
-- 
2.8.1
