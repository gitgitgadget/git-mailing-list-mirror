Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C461FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 23:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbcFXXJ7 (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 19:09:59 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52558 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462AbcFXXJm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 19:09:42 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.18.82.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1717D280A5;
	Fri, 24 Jun 2016 23:09:41 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466809781;
	bh=Wu3bILnP7m7cWfaI6zgT2yD5cDL57qZRbP98NfIEoWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJQ96/kmVcNgSGw66Ay2s2nLbrBL8YwqUq8mTA7gqXr/ByhwoXe1eJtrX2FkD3oKp
	 +snhtGpQMnkcdHKEJquhwNz/EaBgbhrI/hlOxdjoqt/0/KxcTDDF3I+9cWJ4iViB3h
	 2DtdRf90KtTmSWapWLlAmlqyHnOCJTB6Q0NR/O5ja/fHD6/b1aaGHQxVmQ7U3d5aIC
	 bUBrzpxQTkgJC+ArK+qmG0HSfS1XVx4QgUyqFq6zJphqGthT5D7T81al7cTRUG2ggH
	 KiQbFUT0HznBU5kgtsXMHB/7dai+JxS0B4JgQOfcR5l3BSQXdRqRZXVHk73pH8LIRQ
	 6CJSh8uQAqlk7YbLWeSikS2R+rOY6agxz7hhbWzmEeUOXgRPpzlxE1gvSlWhS2YQu2
	 CyOwHqPHvPjorIy9V64f4igYii2vEyxo5XkVsngCYOebnCYYi4ZzYYTj9E+qdec0mA
	 swnAFqXiX21155eJbsE3YglUIRA6tmO0vbwRWuRAtpCnHU+/n9M
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	git@vger.kernel.org
Cc:	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 06/11] diff: rename struct diff_filespec's sha1_valid member
Date:	Fri, 24 Jun 2016 23:09:24 +0000
Message-Id: <20160624230929.82222-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160624230929.82222-1-sandals@crustytoothpaste.net>
References: <20160624230929.82222-1-sandals@crustytoothpaste.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Now that this struct's sha1 member is called "oid", update the comment
and the sha1_valid member to be called "oid_valid" instead.  The
following Coccinelle semantic patch was used to implement this, followed
by the transformations in object_id.cocci:

@@
struct diff_filespec o;
@@
- o.sha1_valid
+ o.oid_valid

@@
struct diff_filespec *p;
@@
- p->sha1_valid
+ p->oid_valid

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 combine-diff.c    |  4 ++--
 diff.c            | 28 ++++++++++++++--------------
 diffcore-break.c  |  2 +-
 diffcore-rename.c |  4 ++--
 diffcore.h        |  2 +-
 line-log.c        | 10 +++++-----
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 1e1ad1c0..8e2a577b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1269,7 +1269,7 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 		pair->one[i].path = p->path;
 		pair->one[i].mode = p->parent[i].mode;
 		oidcpy(&pair->one[i].oid, &p->parent[i].oid);
-		pair->one[i].sha1_valid = !is_null_oid(&p->parent[i].oid);
+		pair->one[i].oid_valid = !is_null_oid(&p->parent[i].oid);
 		pair->one[i].has_more_entries = 1;
 	}
 	pair->one[num_parent - 1].has_more_entries = 0;
@@ -1277,7 +1277,7 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 	pair->two->path = p->path;
 	pair->two->mode = p->mode;
 	oidcpy(&pair->two->oid, &p->oid);
-	pair->two->sha1_valid = !is_null_oid(&p->oid);
+	pair->two->oid_valid = !is_null_oid(&p->oid);
 	return pair;
 }
 
diff --git a/diff.c b/diff.c
index ae9edc30..9abb54ad 100644
--- a/diff.c
+++ b/diff.c
@@ -1933,7 +1933,7 @@ static void show_dirstat(struct diff_options *options)
 
 		name = p->two->path ? p->two->path : p->one->path;
 
-		if (p->one->sha1_valid && p->two->sha1_valid)
+		if (p->one->oid_valid && p->two->oid_valid)
 			content_changed = oidcmp(&p->one->oid, &p->two->oid);
 		else
 			content_changed = 1;
@@ -2640,7 +2640,7 @@ void fill_filespec(struct diff_filespec *spec, const unsigned char *sha1,
 	if (mode) {
 		spec->mode = canon_mode(mode);
 		hashcpy(spec->oid.hash, sha1);
-		spec->sha1_valid = sha1_valid;
+		spec->oid_valid = sha1_valid;
 	}
 }
 
@@ -2766,7 +2766,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 	if (S_ISGITLINK(s->mode))
 		return diff_populate_gitlink(s, size_only);
 
-	if (!s->sha1_valid ||
+	if (!s->oid_valid ||
 	    reuse_worktree_file(s->path, s->oid.hash, 0)) {
 		struct strbuf buf = STRBUF_INIT;
 		struct stat st;
@@ -2915,7 +2915,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 	}
 
 	if (!S_ISGITLINK(one->mode) &&
-	    (!one->sha1_valid ||
+	    (!one->oid_valid ||
 	     reuse_worktree_file(name, one->oid.hash, 1))) {
 		struct stat st;
 		if (lstat(name, &st) < 0) {
@@ -2928,16 +2928,16 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 			if (strbuf_readlink(&sb, name, st.st_size) < 0)
 				die_errno("readlink(%s)", name);
 			prep_temp_blob(name, temp, sb.buf, sb.len,
-				       (one->sha1_valid ?
+				       (one->oid_valid ?
 					one->oid.hash : null_sha1),
-				       (one->sha1_valid ?
+				       (one->oid_valid ?
 					one->mode : S_IFLNK));
 			strbuf_release(&sb);
 		}
 		else {
 			/* we can borrow from the file in the work tree */
 			temp->name = name;
-			if (!one->sha1_valid)
+			if (!one->oid_valid)
 				sha1_to_hex_r(temp->hex, null_sha1);
 			else
 				sha1_to_hex_r(temp->hex, one->oid.hash);
@@ -3134,7 +3134,7 @@ static void run_diff_cmd(const char *pgm,
 static void diff_fill_sha1_info(struct diff_filespec *one)
 {
 	if (DIFF_FILE_VALID(one)) {
-		if (!one->sha1_valid) {
+		if (!one->oid_valid) {
 			struct stat st;
 			if (one->is_stdin) {
 				oidclr(&one->oid);
@@ -4172,11 +4172,11 @@ int diff_unmodified_pair(struct diff_filepair *p)
 	/* both are valid and point at the same path.  that is, we are
 	 * dealing with a change.
 	 */
-	if (one->sha1_valid && two->sha1_valid &&
+	if (one->oid_valid && two->oid_valid &&
 	    !oidcmp(&one->oid, &two->oid) &&
 	    !one->dirty_submodule && !two->dirty_submodule)
 		return 1; /* no change */
-	if (!one->sha1_valid && !two->sha1_valid)
+	if (!one->oid_valid && !two->oid_valid)
 		return 1; /* both look at the same file on the filesystem. */
 	return 0;
 }
@@ -4237,7 +4237,7 @@ void diff_debug_filespec(struct diff_filespec *s, int x, const char *one)
 		s->path,
 		DIFF_FILE_VALID(s) ? "valid" : "invalid",
 		s->mode,
-		s->sha1_valid ? oid_to_hex(&s->oid) : "");
+		s->oid_valid ? oid_to_hex(&s->oid) : "");
 	fprintf(stderr, "queue[%d] %s size %lu\n",
 		x, one ? one : "",
 		s->size);
@@ -4822,7 +4822,7 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
 	 */
 	if (!DIFF_FILE_VALID(p->one) || /* (1) */
 	    !DIFF_FILE_VALID(p->two) ||
-	    (p->one->sha1_valid && p->two->sha1_valid) ||
+	    (p->one->oid_valid && p->two->oid_valid) ||
 	    (p->one->mode != p->two->mode) ||
 	    diff_populate_filespec(p->one, CHECK_SIZE_ONLY) ||
 	    diff_populate_filespec(p->two, CHECK_SIZE_ONLY) ||
@@ -5118,7 +5118,7 @@ size_t fill_textconv(struct userdiff_driver *driver,
 	if (!driver->textconv)
 		die("BUG: fill_textconv called with non-textconv driver");
 
-	if (driver->textconv_cache && df->sha1_valid) {
+	if (driver->textconv_cache && df->oid_valid) {
 		*outbuf = notes_cache_get(driver->textconv_cache,
 					  df->oid.hash,
 					  &size);
@@ -5130,7 +5130,7 @@ size_t fill_textconv(struct userdiff_driver *driver,
 	if (!*outbuf)
 		die("unable to read files to diff");
 
-	if (driver->textconv_cache && df->sha1_valid) {
+	if (driver->textconv_cache && df->oid_valid) {
 		/* ignore errors, as we might be in a readonly repository */
 		notes_cache_put(driver->textconv_cache, df->oid.hash, *outbuf,
 				size);
diff --git a/diffcore-break.c b/diffcore-break.c
index a3e79608..881a74f2 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -57,7 +57,7 @@ static int should_break(struct diff_filespec *src,
 		return 1; /* even their types are different */
 	}
 
-	if (src->sha1_valid && dst->sha1_valid &&
+	if (src->oid_valid && dst->oid_valid &&
 	    !oidcmp(&src->oid, &dst->oid))
 		return 0; /* they are the same */
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 22b239a4..58ac0a53 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -60,7 +60,7 @@ static int add_rename_dst(struct diff_filespec *two)
 		memmove(rename_dst + first + 1, rename_dst + first,
 			(rename_dst_nr - first - 1) * sizeof(*rename_dst));
 	rename_dst[first].two = alloc_filespec(two->path);
-	fill_filespec(rename_dst[first].two, two->oid.hash, two->sha1_valid,
+	fill_filespec(rename_dst[first].two, two->oid.hash, two->oid_valid,
 		      two->mode);
 	rename_dst[first].pair = NULL;
 	return 0;
@@ -261,7 +261,7 @@ struct file_similarity {
 
 static unsigned int hash_filespec(struct diff_filespec *filespec)
 {
-	if (!filespec->sha1_valid) {
+	if (!filespec->oid_valid) {
 		if (diff_populate_filespec(filespec, 0))
 			return 0;
 		hash_sha1_file(filespec->data, filespec->size, "blob",
diff --git a/diffcore.h b/diffcore.h
index c40e5b6c..c11b8465 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -33,7 +33,7 @@ struct diff_filespec {
 	int count;               /* Reference count */
 	int rename_used;         /* Count of rename users */
 	unsigned short mode;	 /* file mode */
-	unsigned sha1_valid : 1; /* if true, use sha1 and trust mode;
+	unsigned oid_valid : 1;  /* if true, use oid and trust mode;
 				  * if false, use the name and read from
 				  * the filesystem.
 				  */
diff --git a/line-log.c b/line-log.c
index 02938639..93407baa 100644
--- a/line-log.c
+++ b/line-log.c
@@ -894,14 +894,14 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 	if (!pair || !diff)
 		return;
 
-	if (pair->one->sha1_valid)
+	if (pair->one->oid_valid)
 		fill_line_ends(pair->one, &p_lines, &p_ends);
 	fill_line_ends(pair->two, &t_lines, &t_ends);
 
 	printf("%s%sdiff --git a/%s b/%s%s\n", prefix, c_meta, pair->one->path, pair->two->path, c_reset);
 	printf("%s%s--- %s%s%s\n", prefix, c_meta,
-	       pair->one->sha1_valid ? "a/" : "",
-	       pair->one->sha1_valid ? pair->one->path : "/dev/null",
+	       pair->one->oid_valid ? "a/" : "",
+	       pair->one->oid_valid ? pair->one->path : "/dev/null",
 	       c_reset);
 	printf("%s%s+++ b/%s%s\n", prefix, c_meta, pair->two->path, c_reset);
 	for (i = 0; i < range->ranges.nr; i++) {
@@ -1011,12 +1011,12 @@ static int process_diff_filepair(struct rev_info *rev,
 	if (rg->ranges.nr == 0)
 		return 0;
 
-	assert(pair->two->sha1_valid);
+	assert(pair->two->oid_valid);
 	diff_populate_filespec(pair->two, 0);
 	file_target.ptr = pair->two->data;
 	file_target.size = pair->two->size;
 
-	if (pair->one->sha1_valid) {
+	if (pair->one->oid_valid) {
 		diff_populate_filespec(pair->one, 0);
 		file_parent.ptr = pair->one->data;
 		file_parent.size = pair->one->size;
