From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 33/38] refs: add method for initial ref transaction commit
Date: Fri,  3 Jun 2016 23:04:08 +0200
Message-ID: <51a0083346b1107333fd2bf032a0b87f9ab86896.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Ronnie Sahlberg <rsahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJ3-00025e-24
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbcFCVGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:36 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47056 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932224AbcFCVF0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:26 -0400
X-AuditID: 1207440d-bb3ff7000000090b-86-5751f1157e6e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E5.42.02315.511F1575; Fri,  3 Jun 2016 17:05:25 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcx003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:23 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqCv6MTDc4O5UeYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbdHy9B2LxZk3jYwOnB5/339g8tg56y67x4JNpR7P
	evcwely8pOyxf+k2No/FD7w8Fjy/z+7xeZNcAGcUt01SYklZcGZ6nr5dAnfGk0dLWQteC1U8
	vryTtYHxNn8XIyeHhICJxIyJF9hAbCGBrYwSHb/Yuxi5gOzjTBKbr1xjBkmwCehKLOppZgKx
	RQQiJBpetTCCFDELnGWSmHp6BVhCWMBLYvX2JYwgNouAqsTqQ69ZQGxegSiJGS2H2SG2yUlc
	nv4AbBungIVEy+dVrBCbzSUaTx1mmcDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFe
	bmaJXmpK6SZGSBjy7mD8v07mEKMAB6MSD++JF4HhQqyJZcWVuYcYJTmYlER5994BCvEl5adU
	ZiQWZ8QXleakFh9ilOBgVhLhTXkNlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgt
	gsnKcHAoSfDO/QDUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KgfhiYBSApHiA
	9jaBtPMWFyTmAkUhWk8xKkqJ8x56D5QQAElklObBjYUll1eM4kBfCvMGgrTzABMTXPcroMFM
	QIMLHvmDDC5JREhJNTDKfdf99kIxqGn/jJ3/dy3IlEuoen128b+r6YsimM3jukISW9ivvjq/
	2WE/96XH7pIpB9x3RAltDJuzd4Gr1QvtYu1lJ5JNS1nWLnvQsEXu5so5tqUtaw0/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296400>

From: David Turner <dturner@twopensource.com>

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 8 ++++++++
 refs/files-backend.c | 8 +++++---
 refs/refs-internal.h | 1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 77d3986..6c1e899 100644
--- a/refs.c
+++ b/refs.c
@@ -1521,3 +1521,11 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 				       prepare_fn, should_prune_fn,
 				       cleanup_fn, policy_cb_data);
 }
+
+int initial_ref_transaction_commit(struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->initial_transaction_commit(refs, transaction, err);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b19ea02..253899f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3832,11 +3832,12 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
+static int files_initial_transaction_commit(struct ref_store *ref_store,
+					    struct ref_transaction *transaction,
+					    struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "initial_ref_transaction_commit");
+		files_downcast(ref_store, 0, "initial_ref_transaction_commit");
 	int ret = 0, i;
 	struct ref_update **updates = transaction->updates;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
@@ -4064,6 +4065,7 @@ struct ref_storage_be refs_be_files = {
 	"files",
 	files_ref_store_create,
 	files_transaction_commit,
+	files_initial_transaction_commit,
 
 	files_pack_refs,
 	files_peel_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 7d84984..e462b54 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -577,6 +577,7 @@ struct ref_storage_be {
 	const char *name;
 	ref_store_init_fn *init;
 	ref_transaction_commit_fn *transaction_commit;
+	ref_transaction_commit_fn *initial_transaction_commit;
 
 	pack_refs_fn *pack_refs;
 	peel_ref_fn *peel_ref;
-- 
2.8.1
