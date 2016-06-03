From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/38] refs: create a base class "ref_store" for files_ref_store
Date: Fri,  3 Jun 2016 23:03:40 +0200
Message-ID: <8ee7d7359f6763cba29dc788aba2f236204bb76e.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJ4-00025e-5y
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbcFCVGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:41 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52588 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752288AbcFCVEg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:36 -0400
X-AuditID: 12074413-473ff700000008c7-bb-5751f0e168a8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 73.8F.02247.1E0F1575; Fri,  3 Jun 2016 17:04:33 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4KcV003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:31 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqPvwQ2C4wfaFxhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M4429rKVnBkJWPF+zl9jA2M+zoZ
	uxg5OSQETCT67j1j62Lk4hAS2MooMWnafXaQhJDAcSaJPWcsQGw2AV2JRT3NTCC2iECERMOr
	FkaQBmaBOUwStx92MoMkhAUCJB41/AcrYhFQlfi+/BUriM0rECVxZNMZFohtchKXpz9gA7E5
	BSwkWj6vYoVYZi7ReOowywRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM31cjNL9FJT
	SjcxQgJPeAfjrpNyhxgFOBiVeHgLngWGC7EmlhVX5h5ilORgUhLl3XsHKMSXlJ9SmZFYnBFf
	VJqTWnyIUYKDWUmEN+U1UI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8Gh
	JMG76D1Qo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoDuKLgZEAkuIB2nsOpJ23
	uCAxFygK0XqKUVFKnPcQSEIAJJFRmgc3FpZOXjGKA30pzCsGTC5CPMBUBNf9CmgwE9Dggkf+
	IINLEhFSUg2MKj80VPRkXVbmnpD1Pa2ULynXF1LiNUW8eHpEadWCFXtUrbzUNRknC2/496jm
	2ZGoTf71F1sO2D166mSp8lbjacWt3W1vOS8dnZyZe+/civehy/6eeP7n1Gb56hWL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296401>

We want ref_stores to be polymorphic, so invent a base class of which
files_ref_store is a derived class. For now there is a one-to-one
relationship between ref_stores and submodules.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               |  91 ++++++++++++++++++++++++++
 refs/files-backend.c | 179 +++++++++++++++++++++++++++++----------------------
 refs/refs-internal.h |  78 ++++++++++++++++++++++
 3 files changed, 271 insertions(+), 77 deletions(-)

diff --git a/refs.c b/refs.c
index f57a93e..5e20ae0 100644
--- a/refs.c
+++ b/refs.c
@@ -1151,8 +1151,12 @@ int head_ref(each_ref_fn fn, void *cb_data)
 static int do_for_each_ref(const char *submodule, const char *prefix,
 			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
+	struct ref_store *refs = get_ref_store(submodule);
 	struct ref_iterator *iter;
 
+	if (!refs)
+		return 0;
+
 	iter = files_ref_iterator_begin(submodule, prefix, flags);
 	iter = prefix_ref_iterator_begin(iter, prefix, trim);
 
@@ -1284,3 +1288,90 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	errno = ELOOP;
 	return NULL;
 }
+
+static struct ref_store *main_ref_store = NULL;
+
+static struct ref_store *submodule_ref_stores = NULL;
+
+void base_ref_store_init(struct ref_store *refs,
+			 const struct ref_storage_be *be,
+			 const char *submodule)
+{
+	refs->be = be;
+	if (!submodule) {
+		if (main_ref_store)
+			die("BUG: main_ref_store initialized twice");
+
+		refs->submodule = "";
+		refs->next = NULL;
+		main_ref_store = refs;
+	} else {
+		if (lookup_ref_store(submodule))
+			die("BUG: ref_store for submodule '%s' initialized twice",
+			    submodule);
+
+		refs->submodule = xstrdup(submodule);
+		refs->next = submodule_ref_stores;
+		submodule_ref_stores = refs;
+	}
+}
+
+struct ref_store *ref_store_init(const char *submodule)
+{
+	const char *be_name = "files";
+	struct ref_storage_be *be = find_ref_storage_backend(be_name);
+
+	if (!be)
+		die("BUG: reference backend %s is unknown", be_name);
+
+	if (!submodule || !*submodule)
+		return be->init(NULL);
+	else
+		return be->init(submodule);
+}
+
+struct ref_store *lookup_ref_store(const char *submodule)
+{
+	struct ref_store *refs;
+
+	if (!submodule || !*submodule)
+		return main_ref_store;
+
+	for (refs = submodule_ref_stores; refs; refs = refs->next) {
+		if (!strcmp(submodule, refs->submodule))
+			return refs;
+	}
+
+	return NULL;
+}
+
+struct ref_store *get_ref_store(const char *submodule)
+{
+	struct ref_store *refs;
+
+	if (!submodule || !*submodule) {
+		refs = lookup_ref_store(NULL);
+
+		if (!refs)
+			refs = ref_store_init(NULL);
+	} else {
+		refs = lookup_ref_store(submodule);
+
+		if (!refs) {
+			struct strbuf submodule_sb = STRBUF_INIT;
+
+			strbuf_addstr(&submodule_sb, submodule);
+			if (is_nonbare_repository_dir(&submodule_sb))
+				refs = ref_store_init(submodule);
+			strbuf_release(&submodule_sb);
+		}
+	}
+
+	return refs;
+}
+
+void assert_main_repository(struct ref_store *refs, const char *caller)
+{
+	if (*refs->submodule)
+		die("BUG: %s called for a submodule", caller);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bde6f0e..8ef79c2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -910,17 +910,11 @@ struct packed_ref_cache {
  * Future: need to be in "struct repository"
  * when doing a full libification.
  */
-static struct files_ref_store {
-	struct files_ref_store *next;
+struct files_ref_store {
+	struct ref_store base;
 	struct ref_entry *loose;
 	struct packed_ref_cache *packed;
-	/*
-	 * The submodule name, or "" for the main repo. We allocate
-	 * length 1 rather than FLEX_ARRAY so that the main
-	 * files_ref_store is initialized correctly.
-	 */
-	char name[1];
-} ref_store, *submodule_ref_stores;
+};
 
 /* Lock used for the main packed-refs file: */
 static struct lock_file packlock;
@@ -973,53 +967,54 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
  */
-static struct files_ref_store *create_ref_store(const char *submodule)
+static struct ref_store *files_ref_store_create(const char *submodule)
 {
-	struct files_ref_store *refs;
-	if (!submodule)
-		submodule = "";
-	FLEX_ALLOC_STR(refs, name, submodule);
-	refs->next = submodule_ref_stores;
-	submodule_ref_stores = refs;
-	return refs;
+	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct ref_store *ref_store = (struct ref_store *)refs;
+
+	base_ref_store_init(ref_store, &refs_be_files, submodule);
+
+	return ref_store;
 }
 
-static struct files_ref_store *lookup_ref_store(const char *submodule)
+/*
+ * Downcast ref_store to files_ref_store. Die if ref_store is not a
+ * files_ref_store. If submodule_allowed is not true, then also die if
+ * files_ref_store is for a submodule (i.e., not for the main
+ * repository). caller is used in any necessary error messages.
+ */
+static struct files_ref_store *files_downcast(
+		struct ref_store *ref_store, int submodule_allowed,
+		const char *caller)
 {
 	struct files_ref_store *refs;
 
-	if (!submodule || !*submodule)
-		return &ref_store;
+	if (ref_store->be != &refs_be_files)
+		die("BUG: ref_store is type \"%s\" not \"files\" in %s",
+		    ref_store->be->name, caller);
 
-	for (refs = submodule_ref_stores; refs; refs = refs->next)
-		if (!strcmp(submodule, refs->name))
-			return refs;
-	return NULL;
+	refs = (struct files_ref_store *)ref_store;
+
+	if (!submodule_allowed)
+		assert_main_repository(ref_store, caller);
+
+	return refs;
 }
 
 /*
- * Return a pointer to a files_ref_store for the specified submodule. For
- * the main repository, use submodule==NULL; such a call cannot fail.
- * For a submodule, the submodule must exist and be a nonbare
- * repository, otherwise return NULL.
- *
- * The returned structure will be allocated and initialized but not
- * necessarily populated; it should not be freed.
+ * Return a pointer to the reference store for the specified
+ * submodule. For the main repository, use submodule==NULL; such a
+ * call cannot fail. For a submodule, the submodule must exist and be
+ * a nonbare repository, otherwise return NULL. Verify that the
+ * reference store is a files_ref_store, and cast it to that type
+ * before returning it.
  */
-static struct files_ref_store *get_ref_store(const char *submodule)
+static struct files_ref_store *get_files_ref_store(const char *submodule,
+						   const char *caller)
 {
-	struct files_ref_store *refs = lookup_ref_store(submodule);
+	struct ref_store *refs = get_ref_store(submodule);
 
-	if (!refs) {
-		struct strbuf submodule_sb = STRBUF_INIT;
-
-		strbuf_addstr(&submodule_sb, submodule);
-		if (is_nonbare_repository_dir(&submodule_sb))
-			refs = create_ref_store(submodule);
-		strbuf_release(&submodule_sb);
-	}
-
-	return refs;
+	return refs ? files_downcast(refs, 1, caller) : NULL;
 }
 
 /* The length of a peeled reference line in packed-refs, including EOL: */
@@ -1158,8 +1153,9 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 {
 	char *packed_refs_file;
 
-	if (*refs->name)
-		packed_refs_file = git_pathdup_submodule(refs->name, "packed-refs");
+	if (*refs->base.submodule)
+		packed_refs_file = git_pathdup_submodule(refs->base.submodule,
+							 "packed-refs");
 	else
 		packed_refs_file = git_pathdup("packed-refs");
 
@@ -1202,8 +1198,9 @@ static struct ref_dir *get_packed_refs(struct files_ref_store *refs)
  */
 static void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
-	struct packed_ref_cache *packed_ref_cache =
-		get_packed_ref_cache(&ref_store);
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "add_packed_ref");
+	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed refs not locked");
@@ -1226,8 +1223,8 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	struct strbuf path = STRBUF_INIT;
 	size_t path_baselen;
 
-	if (*refs->name)
-		strbuf_git_path_submodule(&path, refs->name, "%s", dirname);
+	if (*refs->base.submodule)
+		strbuf_git_path_submodule(&path, refs->base.submodule, "%s", dirname);
 	else
 		strbuf_git_path(&path, "%s", dirname);
 	path_baselen = path.len;
@@ -1262,10 +1259,10 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 		} else {
 			int read_ok;
 
-			if (*refs->name) {
+			if (*refs->base.submodule) {
 				hashclr(sha1);
 				flag = 0;
-				read_ok = !resolve_gitlink_ref(refs->name,
+				read_ok = !resolve_gitlink_ref(refs->base.submodule,
 							       refname.buf, sha1);
 			} else {
 				read_ok = !read_ref_full(refname.buf,
@@ -1355,8 +1352,8 @@ static int resolve_gitlink_ref_recursive(struct files_ref_store *refs,
 
 	if (recursion > SYMREF_MAXDEPTH || strlen(refname) > MAXREFLEN)
 		return -1;
-	path = *refs->name
-		? git_pathdup_submodule(refs->name, "%s", refname)
+	path = *refs->base.submodule
+		? git_pathdup_submodule(refs->base.submodule, "%s", refname)
 		: git_pathdup("%s", refname);
 	fd = open(path, O_RDONLY);
 	free(path);
@@ -1397,7 +1394,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 		return -1;
 
 	strbuf_add(&submodule, path, len);
-	refs = get_ref_store(submodule.buf);
+	refs = get_files_ref_store(submodule.buf, "resolve_gitlink_ref");
 	if (!refs) {
 		strbuf_release(&submodule);
 		return -1;
@@ -1413,7 +1410,10 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
  */
 static struct ref_entry *get_packed_ref(const char *refname)
 {
-	return find_ref(get_packed_refs(&ref_store), refname);
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "get_packed_ref");
+
+	return find_ref(get_packed_refs(refs), refname);
 }
 
 /*
@@ -1613,6 +1613,8 @@ static int lock_raw_ref(const char *refname, int mustexist,
 			unsigned int *type,
 			struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "lock_raw_ref");
 	struct ref_lock *lock;
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
@@ -1745,7 +1747,7 @@ retry:
 							  REMOVE_DIR_EMPTY_ONLY)) {
 				if (verify_refname_available_dir(
 						    refname, extras, skip,
-						    get_loose_refs(&ref_store),
+						    get_loose_refs(refs),
 						    err)) {
 					/*
 					 * The error message set by
@@ -1784,7 +1786,7 @@ retry:
 		 */
 		if (verify_refname_available_dir(
 				    refname, extras, skip,
-				    get_packed_refs(&ref_store),
+				    get_packed_refs(refs),
 				    err)) {
 			goto error_return;
 		}
@@ -1942,7 +1944,8 @@ struct ref_iterator *files_ref_iterator_begin(
 		const char *submodule,
 		const char *prefix, unsigned int flags)
 {
-	struct files_ref_store *refs = get_ref_store(submodule);
+	struct files_ref_store *refs =
+		get_files_ref_store(submodule, "ref_iterator_begin");
 	struct ref_dir *loose_dir, *packed_dir;
 	struct ref_iterator *loose_iter, *packed_iter;
 	struct files_ref_iterator *iter;
@@ -2065,6 +2068,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    unsigned int flags, int *type,
 					    struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "lock_ref_sha1_basic");
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
 	int last_errno = 0;
@@ -2095,8 +2100,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		 */
 		if (remove_empty_directories(&ref_file)) {
 			last_errno = errno;
-			if (!verify_refname_available_dir(refname, extras, skip,
-							  get_loose_refs(&ref_store), err))
+			if (!verify_refname_available_dir(
+					    refname, extras, skip,
+					    get_loose_refs(refs), err))
 				strbuf_addf(err, "there are still refs under '%s'",
 					    refname);
 			goto error_return;
@@ -2107,8 +2113,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	if (!resolved) {
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
-		    !verify_refname_available_dir(refname, extras, skip,
-						  get_loose_refs(&ref_store), err))
+		    !verify_refname_available_dir(
+				    refname, extras, skip,
+				    get_loose_refs(refs), err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
 				    refname, strerror(last_errno));
 
@@ -2123,7 +2130,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 */
 	if (is_null_oid(&lock->old_oid) &&
 	    verify_refname_available_dir(refname, extras, skip,
-					 get_packed_refs(&ref_store), err)) {
+					 get_packed_refs(refs),
+					 err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2212,9 +2220,10 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
  */
 static int lock_packed_refs(int flags)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "lock_packed_refs");
 	static int timeout_configured = 0;
 	static int timeout_value = 1000;
-
 	struct packed_ref_cache *packed_ref_cache;
 
 	if (!timeout_configured) {
@@ -2232,7 +2241,7 @@ static int lock_packed_refs(int flags)
 	 * this will automatically invalidate the cache and re-read
 	 * the packed-refs file.
 	 */
-	packed_ref_cache = get_packed_ref_cache(&ref_store);
+	packed_ref_cache = get_packed_ref_cache(refs);
 	packed_ref_cache->lock = &packlock;
 	/* Increment the reference count to prevent it from being freed: */
 	acquire_packed_ref_cache(packed_ref_cache);
@@ -2247,8 +2256,10 @@ static int lock_packed_refs(int flags)
  */
 static int commit_packed_refs(void)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "commit_packed_refs");
 	struct packed_ref_cache *packed_ref_cache =
-		get_packed_ref_cache(&ref_store);
+		get_packed_ref_cache(refs);
 	int error = 0;
 	int save_errno = 0;
 	FILE *out;
@@ -2281,15 +2292,17 @@ static int commit_packed_refs(void)
  */
 static void rollback_packed_refs(void)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "rollback_packed_refs");
 	struct packed_ref_cache *packed_ref_cache =
-		get_packed_ref_cache(&ref_store);
+		get_packed_ref_cache(refs);
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
 	rollback_lock_file(packed_ref_cache->lock);
 	packed_ref_cache->lock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
-	clear_packed_ref_cache(&ref_store);
+	clear_packed_ref_cache(refs);
 }
 
 struct ref_to_prune {
@@ -2422,15 +2435,17 @@ static void prune_refs(struct ref_to_prune *r)
 
 int pack_refs(unsigned int flags)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "pack_refs");
 	struct pack_refs_cb_data cbdata;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
 	lock_packed_refs(LOCK_DIE_ON_ERROR);
-	cbdata.packed_refs = get_packed_refs(&ref_store);
+	cbdata.packed_refs = get_packed_refs(refs);
 
-	do_for_each_entry_in_dir(get_loose_refs(&ref_store), 0,
+	do_for_each_entry_in_dir(get_loose_refs(refs), 0,
 				 pack_if_possible_fn, &cbdata);
 
 	if (commit_packed_refs())
@@ -2449,6 +2464,8 @@ int pack_refs(unsigned int flags)
  */
 static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "repack_without_refs");
 	struct ref_dir *packed;
 	struct string_list_item *refname;
 	int ret, needs_repacking = 0, removed = 0;
@@ -2471,7 +2488,7 @@ static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 		unable_to_lock_message(git_path("packed-refs"), errno, err);
 		return -1;
 	}
-	packed = get_packed_refs(&ref_store);
+	packed = get_packed_refs(refs);
 
 	/* Remove refnames from the cache */
 	for_each_string_list_item(refname, refnames)
@@ -2616,8 +2633,10 @@ int verify_refname_available(const char *newname,
 			     const struct string_list *skip,
 			     struct strbuf *err)
 {
-	struct ref_dir *packed_refs = get_packed_refs(&ref_store);
-	struct ref_dir *loose_refs = get_loose_refs(&ref_store);
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "verify_refname_available");
+	struct ref_dir *packed_refs = get_packed_refs(refs);
+	struct ref_dir *loose_refs = get_loose_refs(refs);
 
 	if (verify_refname_available_dir(newname, extras, skip,
 					 packed_refs, err) ||
@@ -2968,7 +2987,10 @@ static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     struct strbuf *err)
 {
-	clear_loose_ref_cache(&ref_store);
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "commit_ref_update");
+
+	clear_loose_ref_cache(refs);
 	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, 0, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot update the ref '%s': %s",
@@ -3683,6 +3705,8 @@ static int lock_ref_for_update(struct ref_update *update,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "ref_transaction_commit");
 	int ret = 0, i;
 	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
@@ -3790,7 +3814,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			}
 		}
 		if (update->flags & REF_NEEDS_COMMIT) {
-			clear_loose_ref_cache(&ref_store);
+			clear_loose_ref_cache(refs);
 			if (commit_ref(lock)) {
 				strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 				unlock_ref(lock);
@@ -3823,7 +3847,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 	for_each_string_list_item(ref_to_delete, &refs_to_delete)
 		unlink_or_warn(git_path("logs/%s", ref_to_delete->string));
-	clear_loose_ref_cache(&ref_store);
+	clear_loose_ref_cache(refs);
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
@@ -4069,5 +4093,6 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 
 struct ref_storage_be refs_be_files = {
 	NULL,
-	"files"
+	"files",
+	files_ref_store_create
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4d88849..d6c74cf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -521,11 +521,89 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
 		 struct strbuf *referent, unsigned int *type);
 
 /* refs backends */
+
+/*
+ * Initialize the ref_store for the specified submodule, or for the
+ * main repository if submodule == NULL. These functions should call
+ * base_ref_store_init() to initialize the shared part of the
+ * ref_store and to record the ref_store for later lookup.
+ */
+typedef struct ref_store *ref_store_init_fn(const char *submodule);
+
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
+	ref_store_init_fn *init;
 };
 
 extern struct ref_storage_be refs_be_files;
 
+/*
+ * A representation of the reference store for the main repository or
+ * a submodule. The ref_store instances for submodules are kept in a
+ * linked list.
+ */
+struct ref_store {
+	/* The backend describing this ref_store's storage scheme: */
+	const struct ref_storage_be *be;
+
+	/*
+	 * The name of the submodule represented by this object, or
+	 * the empty string if it represents the main repository's
+	 * reference store:
+	 */
+	const char *submodule;
+
+	/*
+	 * Submodule reference store instances are stored in a linked
+	 * list using this pointer.
+	 */
+	struct ref_store *next;
+};
+
+/*
+ * Fill in the generic part of refs for the specified submodule and
+ * add it to our collection of reference stores.
+ */
+void base_ref_store_init(struct ref_store *refs,
+			 const struct ref_storage_be *be,
+			 const char *submodule);
+
+/*
+ * Create, record, and return a ref_store instance for the specified
+ * submodule (or the main repository if submodule is NULL).
+ *
+ * For backwards compatibility, submodule=="" is treated the same as
+ * submodule==NULL.
+ */
+struct ref_store *ref_store_init(const char *submodule);
+
+/*
+ * Return the ref_store instance for the specified submodule (or the
+ * main repository if submodule is NULL). If that ref_store hasn't
+ * been initialized yet, return NULL.
+ *
+ * For backwards compatibility, submodule=="" is treated the same as
+ * submodule==NULL.
+ */
+struct ref_store *lookup_ref_store(const char *submodule);
+
+/*
+ * Return the ref_store instance for the specified submodule. For the
+ * main repository, use submodule==NULL; such a call cannot fail. For
+ * a submodule, the submodule must exist and be a nonbare repository,
+ * otherwise return NULL. If the requested reference store has not yet
+ * been initialized, initialize it first.
+ *
+ * For backwards compatibility, submodule=="" is treated the same as
+ * submodule==NULL.
+ */
+struct ref_store *get_ref_store(const char *submodule);
+
+/*
+ * Die if refs is for a submodule (i.e., not for the main repository).
+ * caller is used in any necessary error messages.
+ */
+void assert_main_repository(struct ref_store *refs, const char *caller);
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.8.1
