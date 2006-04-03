From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Replace xmalloc+memset(0) with xcalloc.
Date: Mon, 3 Apr 2006 18:35:25 +0200
Message-ID: <20060403163525.GA23536@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 03 18:35:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQS1d-00006l-J7
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 18:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWDCQfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 12:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWDCQfa
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 12:35:30 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:56528 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1751044AbWDCQf3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 12:35:29 -0400
Received: (qmail 23971 invoked by uid 5842); 3 Apr 2006 18:35:25 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18342>

From: Peter Eriksen <s022018@student.dtu.dk>
Date: Mon Apr 3 19:30:46 2006 +0100
Subject: [PATCH] Replace xmalloc+memset(0) with xcalloc.

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

Is something like this considered a cleaup?

Regards,

Peter

 apply.c           |    9 +++------
 blob.c            |    3 +--
 commit.c          |    3 +--
 convert-objects.c |    3 +--
 http-push.c       |    6 ++----
 object.c          |    6 ++----
 read-tree.c       |    9 +++------
 tag.c             |    3 +--
 tree.c            |    7 ++-----
 update-index.c    |    6 ++----
 10 files changed, 18 insertions(+), 37 deletions(-)

d5c82aa8a2b9d776bb30efac17d15a8a596b47f4
diff --git a/apply.c b/apply.c
index c50b3a6..6623ae7 100644
--- a/apply.c
+++ b/apply.c
@@ -924,8 +924,7 @@ static int parse_single_patch(char *line
 		struct fragment *fragment;
 		int len;
 
-		fragment = xmalloc(sizeof(*fragment));
-		memset(fragment, 0, sizeof(*fragment));
+		fragment = xcalloc(1, sizeof(*fragment));
 		len = parse_fragment(line, size, patch, fragment);
 		if (len <= 0)
 			die("corrupt patch at line %d", linenr);
@@ -1651,8 +1650,7 @@ static void add_index_file(const char *p
 	if (!write_index)
 		return;
 
-	ce = xmalloc(ce_size);
-	memset(ce, 0, ce_size);
+	ce = xcalloc(1, ce_size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = htons(namelen);
@@ -1808,8 +1806,7 @@ static int apply_patch(int fd, const cha
 		struct patch *patch;
 		int nr;
 
-		patch = xmalloc(sizeof(*patch));
-		memset(patch, 0, sizeof(*patch));
+		patch = xcalloc(1, sizeof(*patch));
 		nr = parse_chunk(buffer + offset, size, patch);
 		if (nr < 0)
 			break;
diff --git a/blob.c b/blob.c
index 84ec121..c1fdd86 100644
--- a/blob.c
+++ b/blob.c
@@ -8,8 +8,7 @@ struct blob *lookup_blob(const unsigned 
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
-		struct blob *ret = xmalloc(sizeof(struct blob));
-		memset(ret, 0, sizeof(struct blob));
+		struct blob *ret = xcalloc(1, sizeof(struct blob));
 		created_object(sha1, &ret->object);
 		ret->object.type = blob_type;
 		return ret;
diff --git a/commit.c b/commit.c
index eb42d51..d4976fb 100644
--- a/commit.c
+++ b/commit.c
@@ -73,8 +73,7 @@ struct commit *lookup_commit(const unsig
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
-		struct commit *ret = xmalloc(sizeof(struct commit));
-		memset(ret, 0, sizeof(struct commit));
+		struct commit *ret = xcalloc(1, sizeof(struct commit));
 		created_object(sha1, &ret->object);
 		ret->object.type = commit_type;
 		return ret;
diff --git a/convert-objects.c b/convert-objects.c
index b49bce2..b2aafbb 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -18,8 +18,7 @@ static struct entry * convert_entry(unsi
 
 static struct entry *insert_new(unsigned char *sha1, int pos)
 {
-	struct entry *new = xmalloc(sizeof(struct entry));
-	memset(new, 0, sizeof(*new));
+	struct entry *new = xcalloc(1, sizeof(struct entry));
 	memcpy(new->old_sha1, sha1, 20);
 	memmove(convert + pos + 1, convert + pos, (nr_convert - pos) * sizeof(struct entry *));
 	convert[pos] = new;
diff --git a/http-push.c b/http-push.c
index ba7d9de..b60fa8d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1008,8 +1008,7 @@ static int fetch_indices(void)
 	struct active_request_slot *slot;
 	struct slot_results results;
 
-	data = xmalloc(4096);
-	memset(data, 0, 4096);
+	data = xcalloc(1, 4096);
 	buffer.size = 4096;
 	buffer.posn = 0;
 	buffer.buffer = data;
@@ -2042,8 +2041,7 @@ static void update_remote_info_refs(stru
 	char *if_header;
 	struct curl_slist *dav_headers = NULL;
 
-	buffer.buffer = xmalloc(4096);
-	memset(buffer.buffer, 0, 4096);
+	buffer.buffer = xcalloc(1, 4096);
 	buffer.size = 4096;
 	buffer.posn = 0;
 	remote_ls("refs/", (PROCESS_FILES | RECURSIVE),
diff --git a/object.c b/object.c
index c9ca481..71e15e1 100644
--- a/object.c
+++ b/object.c
@@ -85,8 +85,7 @@ struct object_refs *alloc_object_refs(un
 	struct object_refs *refs;
 	size_t size = sizeof(*refs) + count*sizeof(struct object *);
 
-	refs = xmalloc(size);
-	memset(refs, 0, size);
+	refs = xcalloc(1, size);
 	refs->count = count;
 	return refs;
 }
@@ -178,8 +177,7 @@ struct object *lookup_unknown_object(con
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
-		union any_object *ret = xmalloc(sizeof(*ret));
-		memset(ret, 0, sizeof(*ret));
+		union any_object *ret = xcalloc(1, sizeof(*ret));
 		created_object(sha1, &ret->object);
 		ret->object.type = NULL;
 		return &ret->object;
diff --git a/read-tree.c b/read-tree.c
index eaff444..58e5636 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -133,11 +133,9 @@ #endif
 		pathlen = strlen(first);
 		ce_size = cache_entry_size(baselen + pathlen);
 
-		src = xmalloc(sizeof(struct cache_entry *) * src_size);
-		memset(src, 0, sizeof(struct cache_entry *) * src_size);
+		src = xcalloc(src_size, sizeof(struct cache_entry *));
 
-		subposns = xmalloc(sizeof(struct tree_list_entry *) * len);
-		memset(subposns, 0, sizeof(struct tree_list_entry *) * len);
+		subposns = xcalloc(len, sizeof(struct tree_list_entry *));
 
 		if (cache_name && !strcmp(cache_name, first)) {
 			any_files = 1;
@@ -177,8 +175,7 @@ #endif
 			else
 				ce_stage = 2;
 
-			ce = xmalloc(ce_size);
-			memset(ce, 0, ce_size);
+			ce = xcalloc(1, ce_size);
 			ce->ce_mode = create_ce_mode(posns[i]->mode);
 			ce->ce_flags = create_ce_flags(baselen + pathlen,
 						       ce_stage);
diff --git a/tag.c b/tag.c
index ac0e573..f390ee7 100644
--- a/tag.c
+++ b/tag.c
@@ -19,8 +19,7 @@ struct tag *lookup_tag(const unsigned ch
 {
         struct object *obj = lookup_object(sha1);
         if (!obj) {
-                struct tag *ret = xmalloc(sizeof(struct tag));
-                memset(ret, 0, sizeof(struct tag));
+                struct tag *ret = xcalloc(1, sizeof(struct tag));
                 created_object(sha1, &ret->object);
                 ret->object.type = tag_type;
                 return ret;
diff --git a/tree.c b/tree.c
index 87e0d74..d599fb5 100644
--- a/tree.c
+++ b/tree.c
@@ -18,10 +18,8 @@ static int read_one_entry(unsigned char 
 
 	len = strlen(pathname);
 	size = cache_entry_size(baselen + len);
-	ce = xmalloc(size);
+	ce = xcalloc(1, size);
 
-	memset(ce, 0, size);
-
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = create_ce_flags(baselen + len, stage);
 	memcpy(ce->name, base, baselen);
@@ -130,8 +128,7 @@ struct tree *lookup_tree(const unsigned 
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
-		struct tree *ret = xmalloc(sizeof(struct tree));
-		memset(ret, 0, sizeof(struct tree));
+		struct tree *ret = xcalloc(1, sizeof(struct tree));
 		created_object(sha1, &ret->object);
 		ret->object.type = tree_type;
 		return ret;
diff --git a/update-index.c b/update-index.c
index 797245a..1efac27 100644
--- a/update-index.c
+++ b/update-index.c
@@ -114,8 +114,7 @@ static int add_file_to_cache(const char 
 
 	namelen = strlen(path);
 	size = cache_entry_size(namelen);
-	ce = xmalloc(size);
-	memset(ce, 0, size);
+	ce = xcalloc(1, size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_flags = htons(namelen);
 	fill_stat_cache_info(ce, &st);
@@ -312,8 +311,7 @@ static int add_cacheinfo(unsigned int mo
 
 	len = strlen(path);
 	size = cache_entry_size(len);
-	ce = xmalloc(size);
-	memset(ce, 0, size);
+	ce = xcalloc(1, size);
 
 	memcpy(ce->sha1, sha1, 20);
 	memcpy(ce->name, path, len);
-- 
1.3.0.rc1.g40e9
