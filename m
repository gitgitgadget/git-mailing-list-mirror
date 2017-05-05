Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96DEE207D6
	for <e@80x24.org>; Fri,  5 May 2017 05:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755361AbdEEF2B (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 01:28:01 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35898 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755306AbdEEF1y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 01:27:54 -0400
Received: by mail-io0-f195.google.com with SMTP id x86so8560351ioe.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 22:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sZyFFwxfHGcLrp5kbiO1drQCQ5FqgaH1e9ylcsRRwFw=;
        b=PbDX6lVerSrwvjNKfdrpbvWukRJFrmGdcJNDqJpQyB+ZtXMPgREsw57PI7H10K0iyE
         QRHC3IO9kP5i6PUt7qBv7ZEMVt1Tb5w1Vsi/NJklYZITf+Wgjs4m1zQXk5KaA0p/if2r
         KjamL8Wb+32he7otMBvlr9DHMgxucZ/bg02WBKDf8sS8eMCXSE5dXp953P3SNDyB1SEx
         79OHYZ5h1yCt/W4cBcHA0d56R8RIqydPCLXUIpHqxhtGTPW85/K8WUn3im/jU2Kjfj7v
         +sBvILEk00IXCpXPm1YYSbKfIf90nryAinhCZQ/X+DQYOKXsDS4DEFg0ErEnvAU8FgYl
         7O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sZyFFwxfHGcLrp5kbiO1drQCQ5FqgaH1e9ylcsRRwFw=;
        b=TqChA6bUmR1D2eyc4zYpYMgdpkc63yqftgA96LIT4gMEzof13ueMR7b7as6CXZ15Zg
         1piLRyfcJ4hYHsvuoZ25Q36tDZPc124GXYfczeb9lxC+4L3TJyxhwfWJ+KxArpaGkTAa
         36+O7168Lx7wAJNNUCx6cHkas/aNGcW+3E/Sd2Dp5VJA05D4+3306TqPZvXa2ilItZCF
         vlisvc1uulYK/hl3vYmT2fJryit5knn+uVd4RawH/d2gZP8m85usbvn52lVdgMEBjqx0
         8gZURAtODxIKCQgN15Ti6YGgYlfmWyOh+62QHpGH/B6rUsaKdRJdOoGIP8CpiLlF/0RL
         aTwQ==
X-Gm-Message-State: AN3rC/6pT69jATyPC5UNB6Ms130Iz1WYFKhaeeGqjcpjD+Wnqtv4YOSW
        EyA2KZXQyTmusA==
X-Received: by 10.157.29.196 with SMTP id w4mr6626085otw.59.1493962067043;
        Thu, 04 May 2017 22:27:47 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 2sm2179586ota.46.2017.05.04.22.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 22:27:46 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH 10/10] Move scoreboard init and setup to lib
Date:   Fri,  5 May 2017 00:27:29 -0500
Message-Id: <20170505052729.7576-11-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170505052729.7576-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 274 --------------------------------------------------------
 scoreboard.c    | 273 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 scoreboard.h    |   2 +
 3 files changed, 275 insertions(+), 274 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 3bde5a6..4e3079f 100644
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
@@ -25,7 +22,6 @@
 #include "dir.h"
 #include "progress.h"
 #include "origin.h"
-#include "commit-fake.h"
 #include "scoreboard.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
@@ -72,39 +68,6 @@ struct progress_info {
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
-static int fill_blob_sha1_and_mode(struct origin *origin)
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
 	return nth_line((struct scoreboard *)data, lno);
@@ -512,40 +475,6 @@ static void output(struct scoreboard *sb, int option)
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
-static int prepare_lines(struct scoreboard *sb)
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
@@ -706,209 +635,6 @@ static int git_blame_config(const char *var, const char *value, void *cb)
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
-	struct commit *found = NULL;
-	const char *name = NULL;
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
-			    revs->pending.objects[i].name, name);
-		found = (struct commit *) obj;
-		name = revs->pending.objects[i].name;
-	}
-
-	if (!name)
-		found = dwim_reverse_initial(revs, &name);
-	if (!name)
-		die("No commit to dig up from?");
-
-	if (name_p)
-		*name_p = name;
-	return found;
-}
-
-void init_scoreboard(struct scoreboard *sb)
-{
-	memset(sb, 0, sizeof(struct scoreboard));
-	sb->blame_move_score = BLAME_DEFAULT_MOVE_SCORE;
-	sb->blame_copy_score = BLAME_DEFAULT_COPY_SCORE;
-}
-
-void setup_scoreboard(struct scoreboard *sb, const char *path, struct origin **orig)
-{
-	const char *final_commit_name = NULL;
-	struct origin *o;
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
 static int blame_copy_callback(const struct option *option, const char *arg, int unset)
 {
 	int *opt = option->value;
diff --git a/scoreboard.c b/scoreboard.c
index 0463688..01add1d 100644
--- a/scoreboard.c
+++ b/scoreboard.c
@@ -1,6 +1,9 @@
+#include "refs.h"
+#include "tag.h"
 #include "mergesort.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "commit-fake.h"
 #include "scoreboard.h"
 
 static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
@@ -151,6 +154,13 @@ void blame_sort_final(struct scoreboard *sb)
 	sb->ent = blame_sort(sb->ent, compare_blame_final);
 }
 
+static int compare_commits_by_reverse_commit_date(const void *a,
+						  const void *b,
+						  void *c)
+{
+	return -compare_commits_by_commit_date(a, b, c);
+}
+
 /*
  * If two blame entries that are next to each other came from
  * contiguous lines in the same origin (i.e. <commit, path> pair),
@@ -201,6 +211,32 @@ static void queue_blames(struct scoreboard *sb, struct origin *porigin,
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
+static int fill_blob_sha1_and_mode(struct origin *origin)
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
@@ -1294,3 +1330,240 @@ void assign_blame(struct scoreboard *sb, int opt)
 			sb->sanity_check(sb);
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
+static int prepare_lines(struct scoreboard *sb)
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
+void init_scoreboard(struct scoreboard *sb)
+{
+	memset(sb, 0, sizeof(struct scoreboard));
+	sb->blame_move_score = BLAME_DEFAULT_MOVE_SCORE;
+	sb->blame_copy_score = BLAME_DEFAULT_COPY_SCORE;
+}
+
+void setup_scoreboard(struct scoreboard *sb, const char *path, struct origin **orig)
+{
+	const char *final_commit_name = NULL;
+	struct origin *o;
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
diff --git a/scoreboard.h b/scoreboard.h
index 42d9aac..fb573a5 100644
--- a/scoreboard.h
+++ b/scoreboard.h
@@ -71,5 +71,7 @@ void blame_sort_final(struct scoreboard *sb);
 unsigned ent_score(struct scoreboard *sb, struct blame_entry *e);
 void assign_blame(struct scoreboard *sb, int opt);
 const char *nth_line(struct scoreboard *sb, long lno);
+void init_scoreboard(struct scoreboard *sb);
+void setup_scoreboard(struct scoreboard *sb, const char *path, struct origin **orig);
 
 #endif /* SCOREBOARD_H */
-- 
2.9.3

