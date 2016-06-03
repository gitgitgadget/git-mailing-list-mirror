From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 19/38] refs: make read_raw_ref() virtual
Date: Fri,  3 Jun 2016 23:03:54 +0200
Message-ID: <ca7ba1938c725ae936a9f5f82935674d1d582366.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHc-0000uA-6A
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965AbcFCVFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:16 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52595 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161001AbcFCVFA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:00 -0400
X-AuditID: 12074413-487ff700000008c7-f5-5751f0fbd9eb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id B9.8F.02247.BF0F1575; Fri,  3 Jun 2016 17:04:59 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcj003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:57 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqPv7Q2C4wa6VkhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M44P+85U8EJxYpVbb2MDYw/pLoY
	OTkkBEwkNnU9Y+pi5OIQEtjKKNHz9BUjhHOcSeJW8z02kCo2AV2JRT3NTCC2iECERMOrFrAi
	ZoE5TBK3H3YygySEBSwkXnW3sILYLAKqEq8v7wCyOTh4BaIk1t1whdgmJ3F5+gOwmZxA5S2f
	V4GVCwmYSzSeOswygZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQ
	oBPewbjrpNwhRgEORiUe3oJngeFCrIllxZW5hxglOZiURHn33gEK8SXlp1RmJBZnxBeV5qQW
	H2KU4GBWEuFNeQ2U401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8C56
	D9QoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qB+GJgFICkeID2cn8A2VtckJgL
	FIVoPcWoKCXOewhkrgBIIqM0D24sLJW8YhQH+lKYVwyknQeYhuC6XwENZgIaXPDIH2RwSSJC
	SqqBUX/2y5hVl0+mX/w/2WP23u1OK7ZwXs7KTpndeS7PQkRryuR9aXWPdxX0z1y4+v2Z2gsp
	a/6JWpu5R7zberTtHIP4lSyr5JtXSnymn3DT/PJsVwff1P97zoW1789a7rHxcaKZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296382>

Reference backends will be able to customize this function to implement
reference reading.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               |  4 ++--
 refs/files-backend.c | 14 ++++++++------
 refs/refs-internal.h | 36 +++++++++++++++++++-----------------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index c39f85a..1798f66 100644
--- a/refs.c
+++ b/refs.c
@@ -1251,8 +1251,8 @@ static const char *resolve_ref_recursively(struct ref_store *refs,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 
-		if (read_raw_ref(refs, refname,
-				 sha1, &sb_refname, &read_flags)) {
+		if (refs->be->read_raw_ref(refs, refname,
+					   sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
 			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d6d83d2..5b6d388 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1353,9 +1353,9 @@ static int resolve_packed_ref(struct files_ref_store *refs,
 	return -1;
 }
 
-int read_raw_ref(struct ref_store *ref_store,
-		 const char *refname, unsigned char *sha1,
-		 struct strbuf *referent, unsigned int *type)
+static int files_read_raw_ref(struct ref_store *ref_store,
+			      const char *refname, unsigned char *sha1,
+			      struct strbuf *referent, unsigned int *type)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, 1, "read_raw_ref");
@@ -1627,8 +1627,8 @@ retry:
 	 * fear that its value will change.
 	 */
 
-	if (read_raw_ref(ref_store, refname,
-			 lock->old_oid.hash, referent, type)) {
+	if (files_read_raw_ref(ref_store, refname,
+			       lock->old_oid.hash, referent, type)) {
 		if (errno == ENOENT) {
 			if (mustexist) {
 				/* Garden variety missing reference. */
@@ -4023,5 +4023,7 @@ struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_ref_store_create,
-	files_transaction_commit
+	files_transaction_commit,
+
+	files_read_raw_ref
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8c45ee3..8d4287c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -481,6 +481,20 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 
 struct ref_store;
 
+/* refs backends */
+
+/*
+ * Initialize the ref_store for the specified submodule, or for the
+ * main repository if submodule == NULL. These functions should call
+ * base_ref_store_init() to initialize the shared part of the
+ * ref_store and to record the ref_store for later lookup.
+ */
+typedef struct ref_store *ref_store_init_fn(const char *submodule);
+
+typedef int ref_transaction_commit_fn(struct ref_store *refs,
+				      struct ref_transaction *transaction,
+				      struct strbuf *err);
+
 /*
  * Read a reference from the specified reference store, non-recursively.
  * Set type to describe the reference, and:
@@ -519,29 +533,17 @@ struct ref_store;
  * - in all other cases, referent will be untouched, and therefore
  *   refname will still be valid and unchanged.
  */
-int read_raw_ref(struct ref_store *ref_store,
-		 const char *refname, unsigned char *sha1,
-		 struct strbuf *referent, unsigned int *type);
-
-/* refs backends */
-
-/*
- * Initialize the ref_store for the specified submodule, or for the
- * main repository if submodule == NULL. These functions should call
- * base_ref_store_init() to initialize the shared part of the
- * ref_store and to record the ref_store for later lookup.
- */
-typedef struct ref_store *ref_store_init_fn(const char *submodule);
-
-typedef int ref_transaction_commit_fn(struct ref_store *refs,
-				      struct ref_transaction *transaction,
-				      struct strbuf *err);
+typedef int read_raw_ref_fn(struct ref_store *ref_store,
+			    const char *refname, unsigned char *sha1,
+			    struct strbuf *referent, unsigned int *type);
 
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_store_init_fn *init;
 	ref_transaction_commit_fn *transaction_commit;
+
+	read_raw_ref_fn *read_raw_ref;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.8.1
