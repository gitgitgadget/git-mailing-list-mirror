From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/38] read_raw_ref(): take a (struct ref_store *) argument
Date: Fri,  3 Jun 2016 23:03:49 +0200
Message-ID: <14f4d208f5fde3d758a65f388749b01b79698cce.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHK-0000Yi-5z
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932959AbcFCVFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:10 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52595 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932944AbcFCVE4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:56 -0400
X-AuditID: 12074413-487ff700000008c7-e2-5751f0f28823
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 47.8F.02247.2F0F1575; Fri,  3 Jun 2016 17:04:50 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kce003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:48 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqPvpQ2C4wambEhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M54eb2NseC3fMXC049ZGxi/SHYx
	cnJICJhI/Pz/jR3EFhLYyihxZTOUfZxJYvUWXRCbTUBXYlFPMxOILSIQIdHwqoWxi5GLg1lg
	DpPE7YedzCAJYQFvid8z28BsFgFViVtLLoI18ApESUxfcoAJYpmcxOXpD9hAbE4BC4mWz6tY
	IZaZSzSeOswygZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQkBPe
	wbjrpNwhRgEORiUe3oJngeFCrIllxZW5hxglOZiURHn33gEK8SXlp1RmJBZnxBeV5qQWH2KU
	4GBWEuFNeQ2U401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8C56D9Qo
	WJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qA+GJgDICkeID2cn8A2VtckJgLFIVo
	PcWoKCXOewhkrgBIIqM0D24sLJG8YhQH+lKYVwyknQeYhOC6XwENZgIaXPDIH2RwSSJCSqqB
	Mebol0QPv1MfBGbyuk5/FemUcikosUNVOeyBx4kjJxnPZakeWPD4y7zOO/qrNzzVCu9MzrG4
	d76u03nhcT1F38kb9VMjPmSuWypktyYlqH6J+wPNoE1HTEuO16xbmWXNp5Ttbatw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296378>

And make the function work for submodules.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               |  4 +++-
 refs/files-backend.c | 18 +++++++++++++-----
 refs/refs-internal.h |  9 ++++++---
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 904e758..9d36dfe 100644
--- a/refs.c
+++ b/refs.c
@@ -1222,6 +1222,7 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	static struct strbuf sb_refname = STRBUF_INIT;
 	int unused_flags;
 	int symref_count;
+	struct ref_store *refs = get_ref_store(NULL);
 
 	if (!flags)
 		flags = &unused_flags;
@@ -1249,7 +1250,8 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 
-		if (read_raw_ref(refname, sha1, &sb_refname, &read_flags)) {
+		if (read_raw_ref(refs, refname,
+				 sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
 			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5f14227..ff7ee7d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1353,11 +1353,12 @@ static int resolve_packed_ref(struct files_ref_store *refs,
 	return -1;
 }
 
-int read_raw_ref(const char *refname, unsigned char *sha1,
+int read_raw_ref(struct ref_store *ref_store,
+		 const char *refname, unsigned char *sha1,
 		 struct strbuf *referent, unsigned int *type)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "read_raw_ref");
+		files_downcast(ref_store, 1, "read_raw_ref");
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *path;
@@ -1369,7 +1370,12 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
 
 	*type = 0;
 	strbuf_reset(&sb_path);
-	strbuf_git_path(&sb_path, "%s", refname);
+
+	if (*refs->base.submodule)
+		strbuf_git_path_submodule(&sb_path, refs->base.submodule, "%s", refname);
+	else
+		strbuf_git_path(&sb_path, "%s", refname);
+
 	path = sb_path.buf;
 
 stat_ref:
@@ -1596,8 +1602,9 @@ static int lock_raw_ref(const char *refname, int mustexist,
 			unsigned int *type,
 			struct strbuf *err)
 {
+	struct ref_store *ref_store = get_ref_store(NULL);
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "lock_raw_ref");
+		files_downcast(ref_store, 0, "lock_raw_ref");
 	struct ref_lock *lock;
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
@@ -1687,7 +1694,8 @@ retry:
 	 * fear that its value will change.
 	 */
 
-	if (read_raw_ref(refname, lock->old_oid.hash, referent, type)) {
+	if (read_raw_ref(ref_store, refname,
+			 lock->old_oid.hash, referent, type)) {
 		if (errno == ENOENT) {
 			if (mustexist) {
 				/* Garden variety missing reference. */
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index e24366b..8c45ee3 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -479,9 +479,11 @@ extern struct ref_iterator *current_ref_iter;
 int do_for_each_ref_iterator(struct ref_iterator *iter,
 			     each_ref_fn fn, void *cb_data);
 
+struct ref_store;
+
 /*
- * Read the specified reference from the filesystem or packed refs
- * file, non-recursively. Set type to describe the reference, and:
+ * Read a reference from the specified reference store, non-recursively.
+ * Set type to describe the reference, and:
  *
  * - If refname is the name of a normal reference, fill in sha1
  *   (leaving referent unchanged).
@@ -517,7 +519,8 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
  * - in all other cases, referent will be untouched, and therefore
  *   refname will still be valid and unchanged.
  */
-int read_raw_ref(const char *refname, unsigned char *sha1,
+int read_raw_ref(struct ref_store *ref_store,
+		 const char *refname, unsigned char *sha1,
 		 struct strbuf *referent, unsigned int *type);
 
 /* refs backends */
-- 
2.8.1
