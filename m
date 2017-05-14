Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C9420188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758875AbdENDQo (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:44 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36743 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758836AbdENDQe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:34 -0400
Received: by mail-oi0-f66.google.com with SMTP id w138so14313908oiw.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4CYvR7jI0cnSaNI3X3kWlKjdbXYuQoKi847bAhim6pA=;
        b=l5jg6PZK83iqTC3ofvuIV+OjqnZ7UzkuH7fWHVf9SrNdCWAYWTHsXm9C50FAZh89oq
         9yEsEQzJJOnNIj6Eie3+Ugec714XxXCdStxP7D3GjVg+fbi6wZvDT9Zf59hK+rT2Vfe+
         nuS1cjHPOAtdjA5LvSBHv1RivH7SCwgErUFsPCHgOmUwcuTteiLJN2uB9A+3GbiUR9L4
         ICDgF1lGILAGXe8GbPtlVRweqydwyERKQyz0LghuUo84keJnvRSE6/eqEPmKsmz/vpfl
         PTCUb04cYHIcB0eeaoD0f0puXrm1gMM7hns4eXuE/6S7T9yJrnvnOV977tmkjY/ALFe/
         ICKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4CYvR7jI0cnSaNI3X3kWlKjdbXYuQoKi847bAhim6pA=;
        b=ihApnd2UF2PptrJI/sIC2H5B7ykJLZq4AbBFV7CSfrVGAasGUVAa5NkYglIZeC17By
         s5ULPNakaj0v9HNxAMQdThKLVh4pfBPQfhZbN+m//BrkUFa7SFoSTYFLPQuaoKL/YyIN
         oShhZfoRzLOgMIQFNJmH/hpkvRq+QqC235uLlJklxlKofCu8iwuVPXr4YV96ALemwX7K
         tJs/1nrCBtqYJY530nL09IaD4Wgz0Mpzp9fkrArNXAXfpiQsLIxSF6o7tx+2qJc793+S
         y36RsvHD81p320gp4xLBmwmN17kwNhxJgBgUqkX0tx7duNM8Vsb1ZpAFZzgwyvpugpN1
         WsiQ==
X-Gm-Message-State: AODbwcBZ3ZrU2EeLjGd6i0FKuV2WeGrGQuJQPDfKr5lhR8Sl6I0uohCE
        skR66+ug0CoeMw==
X-Received: by 10.157.1.118 with SMTP id 109mr6067309otu.251.1494731793539;
        Sat, 13 May 2017 20:16:33 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:32 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 21/22] blame: create scoreboard setup function in libgit
Date:   Sat, 13 May 2017 22:15:12 -0500
Message-Id: <20170514031513.9042-22-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.c         | 272 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 blame.h         |   5 +-
 builtin/blame.c | 259 +----------------------------------------------------
 3 files changed, 271 insertions(+), 265 deletions(-)

diff --git a/blame.c b/blame.c
index 17ebf64..f6c9cb7 100644
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
@@ -1575,9 +1609,239 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 	}
 }
 
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
 void init_scoreboard(struct blame_scoreboard *sb)
 {
 	memset(sb, 0, sizeof(struct blame_scoreboard));
 	sb->move_score = BLAME_DEFAULT_MOVE_SCORE;
 	sb->copy_score = BLAME_DEFAULT_COPY_SCORE;
 }
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
index 9477b6e..76fd8ef 100644
--- a/blame.h
+++ b/blame.h
@@ -161,10 +161,6 @@ static inline struct blame_origin *blame_origin_incref(struct blame_origin *o)
 }
 extern void blame_origin_decref(struct blame_origin *o);
 
-extern struct blame_origin *get_origin(struct commit *commit, const char *path);
-
-extern struct commit *fake_working_tree_commit(struct diff_options *opt, const char *path, const char *contents_from);
-
 extern void blame_coalesce(struct blame_scoreboard *sb);
 extern void blame_sort_final(struct blame_scoreboard *sb);
 extern unsigned blame_entry_score(struct blame_scoreboard *sb, struct blame_entry *e);
@@ -172,5 +168,6 @@ extern void assign_blame(struct blame_scoreboard *sb, int opt);
 extern const char *blame_nth_line(struct blame_scoreboard *sb, long lno);
 
 extern void init_scoreboard(struct blame_scoreboard *sb);
+extern void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blame_origin **orig);
 
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index e01265a..7ec5a73 100644
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
@@ -70,39 +67,6 @@ struct progress_info {
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
@@ -510,40 +474,6 @@ static void output(struct blame_scoreboard *sb, int option)
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
@@ -685,104 +615,6 @@ static int git_blame_config(const char *var, const char *value, void *cb)
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
@@ -824,9 +656,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct blame_origin *o;
 	struct blame_entry *ent = NULL;
 	long dashdash_pos, lno;
-	const char *final_commit_name = NULL;
-	enum object_type type;
-	struct commit *final_commit = NULL;
 	struct progress_info pi = { NULL, 0 };
 
 	struct string_list range_list = STRING_LIST_INIT_NODUP;
@@ -1031,92 +860,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.revs = &revs;
 	sb.contents_from = contents_from;
 	sb.reverse = reverse;
-
-	if (!reverse) {
-		sb.final = find_single_final(&revs, &final_commit_name);
-		sb.commits.compare = compare_commits_by_commit_date;
-	}
-	else if (contents_from)
-		die(_("--contents and --reverse do not blend well."));
-	else {
-		sb.final = find_single_initial(&revs, &final_commit_name);
-		sb.commits.compare = compare_commits_by_reverse_commit_date;
-		if (revs.first_parent_only)
-			revs.children.name = NULL;
-	}
-
-	if (!sb.final) {
-		/*
-		 * "--not A B -- path" without anything positive;
-		 * do not default to HEAD, but use the working tree
-		 * or "--contents".
-		 */
-		setup_work_tree();
-		sb.final = fake_working_tree_commit(&sb.revs->diffopt,
-						    path, contents_from);
-		add_pending_object(&revs, &(sb.final->object), ":");
-	}
-	else if (contents_from)
-		die(_("cannot use --contents with final commit object name"));
-
-	if (reverse && revs.first_parent_only) {
-		final_commit = find_single_final(sb.revs, NULL);
-		if (!final_commit)
-			die(_("--reverse and --first-parent together require specified latest commit"));
-	}
-
-	/*
-	 * If we have bottom, this will mark the ancestors of the
-	 * bottom commits we would reach while traversing as
-	 * uninteresting.
-	 */
-	if (prepare_revision_walk(&revs))
-		die(_("revision walk setup failed"));
-
-	if (reverse && revs.first_parent_only) {
-		struct commit *c = final_commit;
-
-		sb.revs->children.name = "children";
-		while (c->parents &&
-		       oidcmp(&c->object.oid, &sb.final->object.oid)) {
-			struct commit_list *l = xcalloc(1, sizeof(*l));
-
-			l->item = c;
-			if (add_decoration(&sb.revs->children,
-					   &c->parents->item->object, l))
-				die("BUG: not unique item in first-parent chain");
-			c = c->parents->item;
-		}
-
-		if (oidcmp(&c->object.oid, &sb.final->object.oid))
-			die(_("--reverse --first-parent together require range along first-parent chain"));
-	}
-
-	if (is_null_oid(&sb.final->object.oid)) {
-		o = sb.final->util;
-		sb.final_buf = xmemdupz(o->file.ptr, o->file.size);
-		sb.final_buf_size = o->file.size;
-	}
-	else {
-		o = get_origin(sb.final, path);
-		if (fill_blob_sha1_and_mode(o))
-			die(_("no such path %s in %s"), path, final_commit_name);
-
-		if (DIFF_OPT_TST(&sb.revs->diffopt, ALLOW_TEXTCONV) &&
-		    textconv_object(path, o->mode, &o->blob_oid, 1, (char **) &sb.final_buf,
-				    &sb.final_buf_size))
-			;
-		else
-			sb.final_buf = read_sha1_file(o->blob_oid.hash, &type,
-						      &sb.final_buf_size);
-
-		if (!sb.final_buf)
-			die(_("cannot read blob %s for path %s"),
-			    oid_to_hex(&o->blob_oid),
-			    path);
-	}
-	sb.num_read_blob++;
-	lno = prepare_lines(&sb);
+	setup_scoreboard(&sb, path, &o);
+	lno = sb.num_lines;
 
 	if (lno && !range_list.nr)
 		string_list_append(&range_list, "1");
-- 
2.9.3

