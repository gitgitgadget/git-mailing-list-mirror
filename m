Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70ED1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936483AbeF2BXN (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:13 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:34576 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936475AbeF2BXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:08 -0400
Received: by mail-vk0-f74.google.com with SMTP id x67-v6so2814908vke.1
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=T3Uuva2ULeNz+XNzf3yGjSlRpyv3+btssV0xZz8AWyU=;
        b=GD57GV59OPoRHCyIAqzlPAS/by1vojJs4El32CMPhQ/enmrCZlHQxkmoFoS6Q+Nlzc
         6i16wi8SS4r9Lza1lmRHWnyQNYtvTDyrG31Y+Ye5dCbYwmFSagmoDa9JGCytQ+/RHiIm
         2l9agMX/2w4kPoV4oaEyo3MluqzRgSppLAiMfZd4XO9j/dDheRoNOQVobf1DVyLfASr6
         KxW7wRx6RwxeRe3QRN+BEO8Ot7ZtBM6JwrYyz3bv/EniH9fIwRHlYWCMOAUfqi40ciVy
         zJYIhIPMYMihbT2D+bQ86eltTr/ZnUK2VxUKOp9sYH9UYxFf9DuG8U0FHXHAHpFDtoDG
         8Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=T3Uuva2ULeNz+XNzf3yGjSlRpyv3+btssV0xZz8AWyU=;
        b=A++Lu3+EixprclEO6ACwMBtu3UDJN85vLmps0lRW/pZn0tzdOpiXt/hrmznl/PHXnL
         zmgkYtF0/HNTaCvZe8gDQuZ0bTh9/hy6S+YH3cOba/4jhYgfU3qvN0iqhVRTiQA1yJ1o
         yPHYi3sASKAA09+tzGCUQ5XkKxSKy86Yjrdn5u+vfahDtgniP9N7cAst7VVZEqXTx0td
         9Jo+EaksJ9Fp031MoZkprLJQfKV4D/noEeAn6u+lNbpU5D1unyHRa49dSZtRYKTO0ZPa
         HyGHfxYQ5xYjBHiwbiyqedPQg1RdgWPsuVob5QJ4xnqghnkzyTafwCwpTON4enbNDN9i
         YoHA==
X-Gm-Message-State: APt69E2oKM8qwprAWGYcOXrOfyW1dPBKzwCSciWlGd9M0rRcn5LJSdaI
        hFMpSLLEaxeJs8b1/hrN2qLwUFcfHHVZQ5iQUTWXSxhrnSOvt1JhoK+oU5wD1+O2GnbbOpd4ftg
        0m5+Bbb9bttlYhaSyT4gzu27CdA1t+1NCJhsKh1rxr19uK2l92mnanjrlx8gp
X-Google-Smtp-Source: AAOMgpeB4vPtrmC0Dys+Xm8CQAqgjUTCbDECwGoiRbbJP9kWNou/Sqrv9O1qP6syi+wcKSUrZBDjK33xD/4F
MIME-Version: 1.0
X-Received: by 2002:ab0:250:: with SMTP id 74-v6mr3237554uas.74.1530235387461;
 Thu, 28 Jun 2018 18:23:07 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:05 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-16-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 15/32] tag: add repository argument to deref_tag
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of deref_tag
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blame.c                 |  6 +++---
 builtin/diff.c          |  2 +-
 builtin/fmt-merge-msg.c |  3 ++-
 builtin/grep.c          |  3 ++-
 builtin/name-rev.c      |  3 ++-
 commit.c                |  3 ++-
 fetch-pack.c            |  9 ++++++---
 http-backend.c          |  2 +-
 http-push.c             |  2 +-
 line-log.c              |  2 +-
 merge-recursive.c       |  3 ++-
 remote.c                |  6 ++++--
 server-info.c           |  2 +-
 sha1-name.c             | 11 +++++++----
 shallow.c               |  4 +++-
 tag.c                   |  2 +-
 tag.h                   |  3 ++-
 upload-pack.c           |  2 +-
 18 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/blame.c b/blame.c
index cf102276bea..4229bcd384c 100644
--- a/blame.c
+++ b/blame.c
@@ -1674,7 +1674,7 @@ static struct commit *find_single_final(struct rev_info *revs,
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags & UNINTERESTING)
 			continue;
-		obj = deref_tag(obj, NULL, 0);
+		obj = deref_tag(the_repository, obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (found)
@@ -1705,7 +1705,7 @@ static struct commit *dwim_reverse_initial(struct rev_info *revs,
 
 	/* Is that sole rev a committish? */
 	obj = revs->pending.objects[0].item;
-	obj = deref_tag(obj, NULL, 0);
+	obj = deref_tag(the_repository, obj, NULL, 0);
 	if (obj->type != OBJ_COMMIT)
 		return NULL;
 
@@ -1741,7 +1741,7 @@ static struct commit *find_single_initial(struct rev_info *revs,
 		struct object *obj = revs->pending.objects[i].item;
 		if (!(obj->flags & UNINTERESTING))
 			continue;
-		obj = deref_tag(obj, NULL, 0);
+		obj = deref_tag(the_repository, obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (found)
diff --git a/builtin/diff.c b/builtin/diff.c
index 7971530b9b3..361a3c3ed38 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -402,7 +402,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		int flags = (obj->flags & UNINTERESTING);
 		if (!obj->parsed)
 			obj = parse_object(the_repository, &obj->oid);
-		obj = deref_tag(obj, NULL, 0);
+		obj = deref_tag(the_repository, obj, NULL, 0);
 		if (!obj)
 			die(_("invalid object '%s' given."), name);
 		if (obj->type == OBJ_COMMIT)
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 36318ef46e7..ff165c0fcd2 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -344,7 +344,8 @@ static void shortlog(const char *name,
 	const struct object_id *oid = &origin_data->oid;
 	int limit = opts->shortlog_len;
 
-	branch = deref_tag(parse_object(the_repository, oid), oid_to_hex(oid),
+	branch = deref_tag(the_repository, parse_object(the_repository, oid),
+			   oid_to_hex(oid),
 			   GIT_SHA1_HEXSZ);
 	if (!branch || branch->type != OBJ_COMMIT)
 		return;
diff --git a/builtin/grep.c b/builtin/grep.c
index ee753a403eb..538a818e6dd 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -647,7 +647,8 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
-		real_obj = deref_tag(list->objects[i].item, NULL, 0);
+		real_obj = deref_tag(the_repository, list->objects[i].item,
+				     NULL, 0);
 
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f6eb419a029..f1cb45c2274 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -455,7 +455,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		commit = NULL;
 		object = parse_object(the_repository, &oid);
 		if (object) {
-			struct object *peeled = deref_tag(object, *argv, 0);
+			struct object *peeled = deref_tag(the_repository,
+							  object, *argv, 0);
 			if (peeled && peeled->type == OBJ_COMMIT)
 				commit = (struct commit *)peeled;
 		}
diff --git a/commit.c b/commit.c
index 9e2899bd5ad..aa5557dee84 100644
--- a/commit.c
+++ b/commit.c
@@ -27,7 +27,8 @@ const char *commit_type = "commit";
 struct commit *lookup_commit_reference_gently_the_repository(
 		const struct object_id *oid, int quiet)
 {
-	struct object *obj = deref_tag(parse_object(the_repository, oid),
+	struct object *obj = deref_tag(the_repository,
+				       parse_object(the_repository, oid),
 				       NULL, 0);
 
 	if (!obj)
diff --git a/fetch-pack.c b/fetch-pack.c
index 9f3aa4a88fd..d60d83f174b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -126,7 +126,8 @@ static void rev_list_push(struct commit *commit, int mark)
 
 static int rev_list_insert_ref(const char *refname, const struct object_id *oid)
 {
-	struct object *o = deref_tag(parse_object(the_repository, oid),
+	struct object *o = deref_tag(the_repository,
+				     parse_object(the_repository, oid),
 				     refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
@@ -144,7 +145,8 @@ static int rev_list_insert_ref_oid(const char *refname, const struct object_id *
 static int clear_marks(const char *refname, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
-	struct object *o = deref_tag(parse_object(the_repository, oid),
+	struct object *o = deref_tag(the_repository,
+				     parse_object(the_repository, oid),
 				     refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
@@ -802,7 +804,8 @@ static int everything_local(struct fetch_pack_args *args,
 		 * Don't mark them common yet; the server has to be told so first.
 		 */
 		for (ref = *refs; ref; ref = ref->next) {
-			struct object *o = deref_tag(lookup_object(the_repository,
+			struct object *o = deref_tag(the_repository,
+						     lookup_object(the_repository,
 						     ref->old_oid.hash),
 						     NULL, 0);
 
diff --git a/http-backend.c b/http-backend.c
index 50ba4d53d54..bd0442a805a 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -442,7 +442,7 @@ static int show_text_ref(const char *name, const struct object_id *oid,
 
 	strbuf_addf(buf, "%s\t%s\n", oid_to_hex(oid), name_nons);
 	if (o->type == OBJ_TAG) {
-		o = deref_tag(o, name, 0);
+		o = deref_tag(the_repository, o, name, 0);
 		if (!o)
 			return 0;
 		strbuf_addf(buf, "%s\t%s^{}\n", oid_to_hex(&o->oid),
diff --git a/http-push.c b/http-push.c
index f7b70c4efb1..5eaf551b51e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1477,7 +1477,7 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 		    oid_to_hex(&ref->old_oid), ls->dentry_name);
 
 	if (o->type == OBJ_TAG) {
-		o = deref_tag(o, ls->dentry_name, 0);
+		o = deref_tag(the_repository, o, ls->dentry_name, 0);
 		if (o)
 			strbuf_addf(buf, "%s\t%s^{}\n",
 				    oid_to_hex(&o->oid), ls->dentry_name);
diff --git a/line-log.c b/line-log.c
index fa9cfd5bdbb..7fa0f16eba6 100644
--- a/line-log.c
+++ b/line-log.c
@@ -479,7 +479,7 @@ static struct commit *check_single_commit(struct rev_info *revs)
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags & UNINTERESTING)
 			continue;
-		obj = deref_tag(obj, NULL, 0);
+		obj = deref_tag(the_repository, obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (commit)
diff --git a/merge-recursive.c b/merge-recursive.c
index fa1981be972..3d6b34b4f74 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3489,7 +3489,8 @@ static struct commit *get_ref(const struct object_id *oid, const char *name)
 {
 	struct object *object;
 
-	object = deref_tag(parse_object(the_repository, oid), name,
+	object = deref_tag(the_repository, parse_object(the_repository, oid),
+			   name,
 			   strlen(name));
 	if (!object)
 		return NULL;
diff --git a/remote.c b/remote.c
index 8c75c45fe65..26b1fbd9a88 100644
--- a/remote.c
+++ b/remote.c
@@ -1802,12 +1802,14 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 	 * Both new_commit and old_commit must be commit-ish and new_commit is descendant of
 	 * old_commit.  Otherwise we require --force.
 	 */
-	o = deref_tag(parse_object(the_repository, old_oid), NULL, 0);
+	o = deref_tag(the_repository, parse_object(the_repository, old_oid),
+		      NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	old_commit = (struct commit *) o;
 
-	o = deref_tag(parse_object(the_repository, new_oid), NULL, 0);
+	o = deref_tag(the_repository, parse_object(the_repository, new_oid),
+		      NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	new_commit = (struct commit *) o;
diff --git a/server-info.c b/server-info.c
index 2abd0dca088..41050c2449b 100644
--- a/server-info.c
+++ b/server-info.c
@@ -64,7 +64,7 @@ static int add_info_ref(const char *path, const struct object_id *oid,
 		return -1;
 
 	if (o->type == OBJ_TAG) {
-		o = deref_tag(o, path, 0);
+		o = deref_tag(the_repository, o, path, 0);
 		if (o)
 			if (fprintf(fp, "%s	%s^{}\n",
 				oid_to_hex(&o->oid), path) < 0)
diff --git a/sha1-name.c b/sha1-name.c
index 5854bc75fe2..009faab4aef 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -239,7 +239,8 @@ static int disambiguate_committish_only(const struct object_id *oid, void *cb_da
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(parse_object(the_repository, oid), NULL, 0);
+	obj = deref_tag(the_repository, parse_object(the_repository, oid),
+			NULL, 0);
 	if (obj && obj->type == OBJ_COMMIT)
 		return 1;
 	return 0;
@@ -263,7 +264,8 @@ static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(parse_object(the_repository, oid), NULL, 0);
+	obj = deref_tag(the_repository, parse_object(the_repository, oid),
+			NULL, 0);
 	if (obj && (obj->type == OBJ_TREE || obj->type == OBJ_COMMIT))
 		return 1;
 	return 0;
@@ -968,7 +970,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	if (!o)
 		return -1;
 	if (!expected_type) {
-		o = deref_tag(o, name, sp - name - 2);
+		o = deref_tag(the_repository, o, name, sp - name - 2);
 		if (!o || (!o->parsed && !parse_object(the_repository, &o->oid)))
 			return -1;
 		oidcpy(oid, &o->oid);
@@ -1100,7 +1102,8 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 	if (!object)
 		return 0;
 	if (object->type == OBJ_TAG) {
-		object = deref_tag(object, path, strlen(path));
+		object = deref_tag(the_repository, object, path,
+				   strlen(path));
 		if (!object)
 			return 0;
 	}
diff --git a/shallow.c b/shallow.c
index e9ce55bba08..dbe8a2a2906 100644
--- a/shallow.c
+++ b/shallow.c
@@ -96,7 +96,9 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 			if (i < heads->nr) {
 				int **depth_slot;
 				commit = (struct commit *)
-					deref_tag(heads->objects[i++].item, NULL, 0);
+					deref_tag(the_repository,
+						  heads->objects[i++].item,
+						  NULL, 0);
 				if (!commit || commit->object.type != OBJ_COMMIT) {
 					commit = NULL;
 					continue;
diff --git a/tag.c b/tag.c
index 4971fd4dfc9..fbb4659325b 100644
--- a/tag.c
+++ b/tag.c
@@ -64,7 +64,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 	return ret;
 }
 
-struct object *deref_tag(struct object *o, const char *warn, int warnlen)
+struct object *deref_tag_the_repository(struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
 		if (((struct tag *)o)->tagged)
diff --git a/tag.h b/tag.h
index 149959c81ba..45b0b08b1f6 100644
--- a/tag.h
+++ b/tag.h
@@ -17,7 +17,8 @@ extern struct tag *lookup_tag_the_repository(const struct object_id *oid);
 extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
-extern struct object *deref_tag(struct object *, const char *, int);
+#define deref_tag(r, o, w, l) deref_tag_##r(o, w, l)
+extern struct object *deref_tag_the_repository(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
 extern int gpg_verify_tag(const struct object_id *oid,
 		const char *name_to_report, unsigned flags);
diff --git a/upload-pack.c b/upload-pack.c
index 45e3a94788f..4ca052d0b64 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -380,7 +380,7 @@ static int ok_to_give_up(void)
 
 		if (want->flags & COMMON_KNOWN)
 			continue;
-		want = deref_tag(want, "a want line", 0);
+		want = deref_tag(the_repository, want, "a want line", 0);
 		if (!want || want->type != OBJ_COMMIT) {
 			/* no way to tell if this is reachable by
 			 * looking at the ancestry chain alone, so
-- 
2.18.0.399.gad0ab374a1-goog

