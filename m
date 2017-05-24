Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF7820281
	for <e@80x24.org>; Wed, 24 May 2017 05:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969188AbdEXFRV (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:17:21 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33752 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969127AbdEXFRA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:17:00 -0400
Received: by mail-oi0-f67.google.com with SMTP id h4so31067877oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U5Q19yBRcWz6+mAuG1ndaHlypOtAIMVYNWwHxI10KqQ=;
        b=HvCpyrbgb8b8gUFc8O8DnXQRb4T1YulrkWErYs0Kr7YdnePTMDv8WsAVdGK+myptms
         0bObv65jYJb8KQWC/ycMMNg1CqYXHxQvw7k7uhFzw1dKmJ7gRG1Dvfp/7wT6m506ZOpL
         2PSkuUOktf7Z/jKwefyWd49XPanJNI4rpnU51jKVHv/f1aBT4nGFmnCld/ELB8apolYT
         FjYZIhJYJs1QdbxyZJAieGHzDCGUFTO2qifx2NIWMeabKIIPXt9P5epi45RcRV24JM21
         kYeMBsWhPqgL/7pDvoC1eKxZ+rV/dERxZ1xe/8ELUgenGPAMl19/lSz1t7iPpHQwy+Xh
         lKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U5Q19yBRcWz6+mAuG1ndaHlypOtAIMVYNWwHxI10KqQ=;
        b=ZA4SMyV/CxINwi3NPrXZ6xbky3fUy/H9YaunEN+QLy4ifalHBqodIV2OTNC1DBDo7A
         auuKrI+ic9x03wvwRGYINGyDDVn58kkd8epfUM47zI08vGcgjkoQYfT9NoYVz67KynhK
         eJhojTsQmr5wzScS430iVk5nAZtSu72EsBiZOssqiAluNjB9abYpMP+2jiThWlUj6o2C
         sfo3hf+gOLmv0zQQLHrF2p99NVkTV/XC4Rr8s0azrB4kGqlk9Pv6vEn0e3mVmDCuuVGm
         pNgc8cb9q37PYiYfwmlwpZz+7YFmKg9UM9c7jdkC1JigFMVelkkcFgvHE3Tr83GejZkW
         Jjzw==
X-Gm-Message-State: AODbwcC/9eirJ8O5bdeQZVKI1I73snRzmANUmn7t5KyrYboPefHzqg5u
        icN8pWD5unh/iQ==
X-Received: by 10.157.80.47 with SMTP id a47mr3908143oth.220.1495603019393;
        Tue, 23 May 2017 22:16:59 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:58 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 28/29] blame: move scoreboard setup to libgit
Date:   Wed, 24 May 2017 00:15:36 -0500
Message-Id: <20170524051537.29978-29-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.c         | 279 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 blame.h         |  10 +-
 builtin/blame.c | 276 -------------------------------------------------------
 3 files changed, 281 insertions(+), 284 deletions(-)

diff --git a/blame.c b/blame.c
index 798e61b..f6c9cb7 100644
--- a/blame.c
+++ b/blame.c
@@ -4,6 +4,7 @@
 #include "mergesort.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "tag.h"
 #include "blame.h"
 
 void blame_origin_decref(struct blame_origin *o)
@@ -49,7 +50,7 @@ static struct blame_origin *make_origin(struct commit *commit, const char *path)
  * Locate an existing origin or create a new one.
  * This moves the origin to front position in the commit util list.
  */
-struct blame_origin *get_origin(struct commit *commit, const char *path)
+static struct blame_origin *get_origin(struct commit *commit, const char *path)
 {
 	struct blame_origin *o, *l;
 
@@ -142,9 +143,9 @@ static void set_commit_buffer_from_strbuf(struct commit *c, struct strbuf *sb)
  * Prepare a dummy commit that represents the work tree (or staged) item.
  * Note that annotating work tree item never works in the reverse.
  */
-struct commit *fake_working_tree_commit(struct diff_options *opt,
-					const char *path,
-					const char *contents_from)
+static struct commit *fake_working_tree_commit(struct diff_options *opt,
+					       const char *path,
+					       const char *contents_from)
 {
 	struct commit *commit;
 	struct blame_origin *origin;
@@ -410,6 +411,13 @@ void blame_sort_final(struct blame_scoreboard *sb)
 				  compare_blame_final);
 }
 
+static int compare_commits_by_reverse_commit_date(const void *a,
+						  const void *b,
+						  void *c)
+{
+	return -compare_commits_by_commit_date(a, b, c);
+}
+
 /*
  * For debugging -- origin is refcounted, and this asserts that
  * we do not underflow.
@@ -483,6 +491,32 @@ static void queue_blames(struct blame_scoreboard *sb, struct blame_origin *porig
 }
 
 /*
+ * Fill the blob_sha1 field of an origin if it hasn't, so that later
+ * call to fill_origin_blob() can use it to locate the data.  blob_sha1
+ * for an origin is also used to pass the blame for the entire file to
+ * the parent to detect the case where a child's blob is identical to
+ * that of its parent's.
+ *
+ * This also fills origin->mode for corresponding tree path.
+ */
+static int fill_blob_sha1_and_mode(struct blame_origin *origin)
+{
+	if (!is_null_oid(&origin->blob_oid))
+		return 0;
+	if (get_tree_entry(origin->commit->object.oid.hash,
+			   origin->path,
+			   origin->blob_oid.hash, &origin->mode))
+		goto error_out;
+	if (sha1_object_info(origin->blob_oid.hash, NULL) != OBJ_BLOB)
+		goto error_out;
+	return 0;
+ error_out:
+	oidclr(&origin->blob_oid);
+	origin->mode = S_IFINVALID;
+	return -1;
+}
+
+/*
  * We have an origin -- check if the same path exists in the
  * parent and return an origin structure to represent it.
  */
@@ -1574,3 +1608,240 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 			sanity_check_refcnt(sb);
 	}
 }
+
+static const char *get_next_line(const char *start, const char *end)
+{
+	const char *nl = memchr(start, '\n', end - start);
+	return nl ? nl + 1 : end;
+}
+
+/*
+ * To allow quick access to the contents of nth line in the
+ * final image, prepare an index in the scoreboard.
+ */
+static int prepare_lines(struct blame_scoreboard *sb)
+{
+	const char *buf = sb->final_buf;
+	unsigned long len = sb->final_buf_size;
+	const char *end = buf + len;
+	const char *p;
+	int *lineno;
+	int num = 0;
+
+	for (p = buf; p < end; p = get_next_line(p, end))
+		num++;
+
+	ALLOC_ARRAY(sb->lineno, num + 1);
+	lineno = sb->lineno;
+
+	for (p = buf; p < end; p = get_next_line(p, end))
+		*lineno++ = p - buf;
+
+	*lineno = len;
+
+	sb->num_lines = num;
+	return sb->num_lines;
+}
+
+static struct commit *find_single_final(struct rev_info *revs,
+					const char **name_p)
+{
+	int i;
+	struct commit *found = NULL;
+	const char *name = NULL;
+
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object *obj = revs->pending.objects[i].item;
+		if (obj->flags & UNINTERESTING)
+			continue;
+		obj = deref_tag(obj, NULL, 0);
+		if (obj->type != OBJ_COMMIT)
+			die("Non commit %s?", revs->pending.objects[i].name);
+		if (found)
+			die("More than one commit to dig from %s and %s?",
+			    revs->pending.objects[i].name, name);
+		found = (struct commit *)obj;
+		name = revs->pending.objects[i].name;
+	}
+	if (name_p)
+		*name_p = name;
+	return found;
+}
+
+static struct commit *dwim_reverse_initial(struct rev_info *revs,
+					   const char **name_p)
+{
+	/*
+	 * DWIM "git blame --reverse ONE -- PATH" as
+	 * "git blame --reverse ONE..HEAD -- PATH" but only do so
+	 * when it makes sense.
+	 */
+	struct object *obj;
+	struct commit *head_commit;
+	unsigned char head_sha1[20];
+
+	if (revs->pending.nr != 1)
+		return NULL;
+
+	/* Is that sole rev a committish? */
+	obj = revs->pending.objects[0].item;
+	obj = deref_tag(obj, NULL, 0);
+	if (obj->type != OBJ_COMMIT)
+		return NULL;
+
+	/* Do we have HEAD? */
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
+		return NULL;
+	head_commit = lookup_commit_reference_gently(head_sha1, 1);
+	if (!head_commit)
+		return NULL;
+
+	/* Turn "ONE" into "ONE..HEAD" then */
+	obj->flags |= UNINTERESTING;
+	add_pending_object(revs, &head_commit->object, "HEAD");
+
+	if (name_p)
+		*name_p = revs->pending.objects[0].name;
+	return (struct commit *)obj;
+}
+
+static struct commit *find_single_initial(struct rev_info *revs,
+					  const char **name_p)
+{
+	int i;
+	struct commit *found = NULL;
+	const char *name = NULL;
+
+	/*
+	 * There must be one and only one negative commit, and it must be
+	 * the boundary.
+	 */
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object *obj = revs->pending.objects[i].item;
+		if (!(obj->flags & UNINTERESTING))
+			continue;
+		obj = deref_tag(obj, NULL, 0);
+		if (obj->type != OBJ_COMMIT)
+			die("Non commit %s?", revs->pending.objects[i].name);
+		if (found)
+			die("More than one commit to dig up from, %s and %s?",
+			    revs->pending.objects[i].name, name);
+		found = (struct commit *) obj;
+		name = revs->pending.objects[i].name;
+	}
+
+	if (!name)
+		found = dwim_reverse_initial(revs, &name);
+	if (!name)
+		die("No commit to dig up from?");
+
+	if (name_p)
+		*name_p = name;
+	return found;
+}
+
+void init_scoreboard(struct blame_scoreboard *sb)
+{
+	memset(sb, 0, sizeof(struct blame_scoreboard));
+	sb->move_score = BLAME_DEFAULT_MOVE_SCORE;
+	sb->copy_score = BLAME_DEFAULT_COPY_SCORE;
+}
+
+void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blame_origin **orig)
+{
+	const char *final_commit_name = NULL;
+	struct blame_origin *o;
+	struct commit *final_commit = NULL;
+	enum object_type type;
+
+	if (sb->reverse && sb->contents_from)
+		die(_("--contents and --reverse do not blend well."));
+
+	if (!sb->reverse) {
+		sb->final = find_single_final(sb->revs, &final_commit_name);
+		sb->commits.compare = compare_commits_by_commit_date;
+	} else {
+		sb->final = find_single_initial(sb->revs, &final_commit_name);
+		sb->commits.compare = compare_commits_by_reverse_commit_date;
+	}
+
+	if (sb->final && sb->contents_from)
+		die(_("cannot use --contents with final commit object name"));
+
+	if (sb->reverse && sb->revs->first_parent_only)
+		sb->revs->children.name = NULL;
+
+	if (!sb->final) {
+		/*
+		 * "--not A B -- path" without anything positive;
+		 * do not default to HEAD, but use the working tree
+		 * or "--contents".
+		 */
+		setup_work_tree();
+		sb->final = fake_working_tree_commit(&sb->revs->diffopt,
+						     path, sb->contents_from);
+		add_pending_object(sb->revs, &(sb->final->object), ":");
+	}
+
+	if (sb->reverse && sb->revs->first_parent_only) {
+		final_commit = find_single_final(sb->revs, NULL);
+		if (!final_commit)
+			die(_("--reverse and --first-parent together require specified latest commit"));
+	}
+
+	/*
+	 * If we have bottom, this will mark the ancestors of the
+	 * bottom commits we would reach while traversing as
+	 * uninteresting.
+	 */
+	if (prepare_revision_walk(sb->revs))
+		die(_("revision walk setup failed"));
+
+	if (sb->reverse && sb->revs->first_parent_only) {
+		struct commit *c = final_commit;
+
+		sb->revs->children.name = "children";
+		while (c->parents &&
+		       oidcmp(&c->object.oid, &sb->final->object.oid)) {
+			struct commit_list *l = xcalloc(1, sizeof(*l));
+
+			l->item = c;
+			if (add_decoration(&sb->revs->children,
+					   &c->parents->item->object, l))
+				die("BUG: not unique item in first-parent chain");
+			c = c->parents->item;
+		}
+
+		if (oidcmp(&c->object.oid, &sb->final->object.oid))
+			die(_("--reverse --first-parent together require range along first-parent chain"));
+	}
+
+	if (is_null_oid(&sb->final->object.oid)) {
+		o = sb->final->util;
+		sb->final_buf = xmemdupz(o->file.ptr, o->file.size);
+		sb->final_buf_size = o->file.size;
+	}
+	else {
+		o = get_origin(sb->final, path);
+		if (fill_blob_sha1_and_mode(o))
+			die(_("no such path %s in %s"), path, final_commit_name);
+
+		if (DIFF_OPT_TST(&sb->revs->diffopt, ALLOW_TEXTCONV) &&
+		    textconv_object(path, o->mode, &o->blob_oid, 1, (char **) &sb->final_buf,
+				    &sb->final_buf_size))
+			;
+		else
+			sb->final_buf = read_sha1_file(o->blob_oid.hash, &type,
+						       &sb->final_buf_size);
+
+		if (!sb->final_buf)
+			die(_("cannot read blob %s for path %s"),
+			    oid_to_hex(&o->blob_oid),
+			    path);
+	}
+	sb->num_read_blob++;
+	prepare_lines(sb);
+
+	if (orig)
+		*orig = o;
+}
diff --git a/blame.h b/blame.h
index df824b2..76fd8ef 100644
--- a/blame.h
+++ b/blame.h
@@ -13,6 +13,9 @@
 #define PICKAXE_BLAME_COPY_HARDER	04
 #define PICKAXE_BLAME_COPY_HARDEST	010
 
+#define BLAME_DEFAULT_MOVE_SCORE	20
+#define BLAME_DEFAULT_COPY_SCORE	40
+
 /*
  * One blob in a commit that is being suspected
  */
@@ -158,14 +161,13 @@ static inline struct blame_origin *blame_origin_incref(struct blame_origin *o)
 }
 extern void blame_origin_decref(struct blame_origin *o);
 
-extern struct blame_origin *get_origin(struct commit *commit, const char *path);
-
-extern struct commit *fake_working_tree_commit(struct diff_options *opt, const char *path, const char *contents_from);
-
 extern void blame_coalesce(struct blame_scoreboard *sb);
 extern void blame_sort_final(struct blame_scoreboard *sb);
 extern unsigned blame_entry_score(struct blame_scoreboard *sb, struct blame_entry *e);
 extern void assign_blame(struct blame_scoreboard *sb, int opt);
 extern const char *blame_nth_line(struct blame_scoreboard *sb, long lno);
 
+extern void init_scoreboard(struct blame_scoreboard *sb);
+extern void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blame_origin **orig);
+
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index 461506c..7d9e322 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -6,11 +6,8 @@
  */
 
 #include "cache.h"
-#include "refs.h"
 #include "builtin.h"
 #include "commit.h"
-#include "tag.h"
-#include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
 #include "quote.h"
@@ -60,8 +57,6 @@ static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 
 static unsigned blame_move_score;
 static unsigned blame_copy_score;
-#define BLAME_DEFAULT_MOVE_SCORE	20
-#define BLAME_DEFAULT_COPY_SCORE	40
 
 /* Remember to update object flag allocation in object.h */
 #define METAINFO_SHOWN		(1u<<12)
@@ -72,39 +67,6 @@ struct progress_info {
 	int blamed_lines;
 };
 
-static int compare_commits_by_reverse_commit_date(const void *a,
-						  const void *b,
-						  void *c)
-{
-	return -compare_commits_by_commit_date(a, b, c);
-}
-
-/*
- * Fill the blob_sha1 field of an origin if it hasn't, so that later
- * call to fill_origin_blob() can use it to locate the data.  blob_sha1
- * for an origin is also used to pass the blame for the entire file to
- * the parent to detect the case where a child's blob is identical to
- * that of its parent's.
- *
- * This also fills origin->mode for corresponding tree path.
- */
-static int fill_blob_sha1_and_mode(struct blame_origin *origin)
-{
-	if (!is_null_oid(&origin->blob_oid))
-		return 0;
-	if (get_tree_entry(origin->commit->object.oid.hash,
-			   origin->path,
-			   origin->blob_oid.hash, &origin->mode))
-		goto error_out;
-	if (sha1_object_info(origin->blob_oid.hash, NULL) != OBJ_BLOB)
-		goto error_out;
-	return 0;
- error_out:
-	oidclr(&origin->blob_oid);
-	origin->mode = S_IFINVALID;
-	return -1;
-}
-
 static const char *nth_line_cb(void *data, long lno)
 {
 	return blame_nth_line((struct blame_scoreboard *)data, lno);
@@ -512,40 +474,6 @@ static void output(struct blame_scoreboard *sb, int option)
 	}
 }
 
-static const char *get_next_line(const char *start, const char *end)
-{
-	const char *nl = memchr(start, '\n', end - start);
-	return nl ? nl + 1 : end;
-}
-
-/*
- * To allow quick access to the contents of nth line in the
- * final image, prepare an index in the scoreboard.
- */
-static int prepare_lines(struct blame_scoreboard *sb)
-{
-	const char *buf = sb->final_buf;
-	unsigned long len = sb->final_buf_size;
-	const char *end = buf + len;
-	const char *p;
-	int *lineno;
-	int num = 0;
-
-	for (p = buf; p < end; p = get_next_line(p, end))
-		num++;
-
-	ALLOC_ARRAY(sb->lineno, num + 1);
-	lineno = sb->lineno;
-
-	for (p = buf; p < end; p = get_next_line(p, end))
-		*lineno++ = p - buf;
-
-	*lineno = len;
-
-	sb->num_lines = num;
-	return sb->num_lines;
-}
-
 /*
  * Add phony grafts for use with -S; this is primarily to
  * support git's cvsserver that wants to give a linear history
@@ -687,104 +615,6 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static struct commit *find_single_final(struct rev_info *revs,
-					const char **name_p)
-{
-	int i;
-	struct commit *found = NULL;
-	const char *name = NULL;
-
-	for (i = 0; i < revs->pending.nr; i++) {
-		struct object *obj = revs->pending.objects[i].item;
-		if (obj->flags & UNINTERESTING)
-			continue;
-		obj = deref_tag(obj, NULL, 0);
-		if (obj->type != OBJ_COMMIT)
-			die("Non commit %s?", revs->pending.objects[i].name);
-		if (found)
-			die("More than one commit to dig from %s and %s?",
-			    revs->pending.objects[i].name, name);
-		found = (struct commit *)obj;
-		name = revs->pending.objects[i].name;
-	}
-	if (name_p)
-		*name_p = name;
-	return found;
-}
-
-static struct commit *dwim_reverse_initial(struct rev_info *revs,
-					   const char **name_p)
-{
-	/*
-	 * DWIM "git blame --reverse ONE -- PATH" as
-	 * "git blame --reverse ONE..HEAD -- PATH" but only do so
-	 * when it makes sense.
-	 */
-	struct object *obj;
-	struct commit *head_commit;
-	unsigned char head_sha1[20];
-
-	if (revs->pending.nr != 1)
-		return NULL;
-
-	/* Is that sole rev a committish? */
-	obj = revs->pending.objects[0].item;
-	obj = deref_tag(obj, NULL, 0);
-	if (obj->type != OBJ_COMMIT)
-		return NULL;
-
-	/* Do we have HEAD? */
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
-		return NULL;
-	head_commit = lookup_commit_reference_gently(head_sha1, 1);
-	if (!head_commit)
-		return NULL;
-
-	/* Turn "ONE" into "ONE..HEAD" then */
-	obj->flags |= UNINTERESTING;
-	add_pending_object(revs, &head_commit->object, "HEAD");
-
-	if (name_p)
-		*name_p = revs->pending.objects[0].name;
-	return (struct commit *)obj;
-}
-
-static struct commit *find_single_initial(struct rev_info *revs,
-					  const char **name_p)
-{
-	int i;
-	const char *final_commit_name = NULL;
-	struct commit *found = NULL;
-
-	/*
-	 * There must be one and only one negative commit, and it must be
-	 * the boundary.
-	 */
-	for (i = 0; i < revs->pending.nr; i++) {
-		struct object *obj = revs->pending.objects[i].item;
-		if (!(obj->flags & UNINTERESTING))
-			continue;
-		obj = deref_tag(obj, NULL, 0);
-		if (obj->type != OBJ_COMMIT)
-			die("Non commit %s?", revs->pending.objects[i].name);
-		if (found)
-			die("More than one commit to dig up from, %s and %s?",
-			    revs->pending.objects[i].name,
-			    final_commit_name);
-		found = (struct commit *) obj;
-		final_commit_name = revs->pending.objects[i].name;
-	}
-
-	if (!final_commit_name)
-		found = dwim_reverse_initial(revs, &final_commit_name);
-	if (!final_commit_name)
-		die("No commit to dig up from?");
-
-	if (name_p)
-		*name_p = final_commit_name;
-	return found;
-}
-
 static int blame_copy_callback(const struct option *option, const char *arg, int unset)
 {
 	int *opt = option->value;
@@ -818,112 +648,6 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 	return 0;
 }
 
-void init_scoreboard(struct blame_scoreboard *sb)
-{
-	memset(sb, 0, sizeof(struct blame_scoreboard));
-	sb->move_score = BLAME_DEFAULT_MOVE_SCORE;
-	sb->copy_score = BLAME_DEFAULT_COPY_SCORE;
-}
-
-void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blame_origin **orig)
-{
-	const char *final_commit_name = NULL;
-	struct blame_origin *o;
-	struct commit *final_commit = NULL;
-	enum object_type type;
-
-	if (sb->reverse && sb->contents_from)
-		die(_("--contents and --reverse do not blend well."));
-
-	if (!sb->reverse) {
-		sb->final = find_single_final(sb->revs, &final_commit_name);
-		sb->commits.compare = compare_commits_by_commit_date;
-	} else {
-		sb->final = find_single_initial(sb->revs, &final_commit_name);
-		sb->commits.compare = compare_commits_by_reverse_commit_date;
-	}
-
-	if (sb->final && sb->contents_from)
-		die(_("cannot use --contents with final commit object name"));
-
-	if (sb->reverse && sb->revs->first_parent_only)
-		sb->revs->children.name = NULL;
-
-	if (!sb->final) {
-		/*
-		 * "--not A B -- path" without anything positive;
-		 * do not default to HEAD, but use the working tree
-		 * or "--contents".
-		 */
-		setup_work_tree();
-		sb->final = fake_working_tree_commit(&sb->revs->diffopt,
-						     path, sb->contents_from);
-		add_pending_object(sb->revs, &(sb->final->object), ":");
-	}
-
-	if (sb->reverse && sb->revs->first_parent_only) {
-		final_commit = find_single_final(sb->revs, NULL);
-		if (!final_commit)
-			die(_("--reverse and --first-parent together require specified latest commit"));
-	}
-
-	/*
-	 * If we have bottom, this will mark the ancestors of the
-	 * bottom commits we would reach while traversing as
-	 * uninteresting.
-	 */
-	if (prepare_revision_walk(sb->revs))
-		die(_("revision walk setup failed"));
-
-	if (sb->reverse && sb->revs->first_parent_only) {
-		struct commit *c = final_commit;
-
-		sb->revs->children.name = "children";
-		while (c->parents &&
-		       oidcmp(&c->object.oid, &sb->final->object.oid)) {
-			struct commit_list *l = xcalloc(1, sizeof(*l));
-
-			l->item = c;
-			if (add_decoration(&sb->revs->children,
-					   &c->parents->item->object, l))
-				die("BUG: not unique item in first-parent chain");
-			c = c->parents->item;
-		}
-
-		if (oidcmp(&c->object.oid, &sb->final->object.oid))
-			die(_("--reverse --first-parent together require range along first-parent chain"));
-	}
-
-	if (is_null_oid(&sb->final->object.oid)) {
-		o = sb->final->util;
-		sb->final_buf = xmemdupz(o->file.ptr, o->file.size);
-		sb->final_buf_size = o->file.size;
-	}
-	else {
-		o = get_origin(sb->final, path);
-		if (fill_blob_sha1_and_mode(o))
-			die(_("no such path %s in %s"), path, final_commit_name);
-
-		if (DIFF_OPT_TST(&sb->revs->diffopt, ALLOW_TEXTCONV) &&
-		    textconv_object(path, o->mode, &o->blob_oid, 1, (char **) &sb->final_buf,
-				    &sb->final_buf_size))
-			;
-		else
-			sb->final_buf = read_sha1_file(o->blob_oid.hash, &type,
-						       &sb->final_buf_size);
-
-		if (!sb->final_buf)
-			die(_("cannot read blob %s for path %s"),
-			    oid_to_hex(&o->blob_oid),
-			    path);
-	}
-	sb->num_read_blob++;
-	prepare_lines(sb);
-
-	if (orig)
-		*orig = o;
-}
-
 struct blame_entry *blame_entry_prepend(struct blame_entry *head,
 					long start, long end,
 					struct blame_origin *o)
-- 
2.9.3

