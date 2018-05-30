Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4591F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968489AbeE3As2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:48:28 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43724 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966552AbeE3AsW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:22 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so9939644plj.10
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k/xME4y7VfkqEfutzbSzO15uXlVkIwEgwQRH4kokzdU=;
        b=W1jmH+Is5YJUk2Trz4CZoHBIcbzGyb0ohUl6pdgMpAgEH83MzVZAVXhn9kqp8MWs8p
         G3vExuIUV12rl4YgJ9Mn3ikLsP8T98TfgwI4laIZ59KJDuvYztB4UyLmU1ltOII6EFvk
         1DV5zLz2ctQZpfWFqSWpwuWIRu6WJ4gecPVnhE1rX4H/uCcbYCQusPg/9NbRg99eWjHk
         ak+wdVqrNgiLLLCajc+9jM1GTi59PP/4TwWRT+wwLGqCCtt/8dpE4KPJEveyfyWeJWSv
         l+C2dX/ANhvp0hOW9TYeG9PPxx47qVO4Jz9gqs/O8wmQFx77F6+ELCEom9tBmiBIn5I9
         xfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k/xME4y7VfkqEfutzbSzO15uXlVkIwEgwQRH4kokzdU=;
        b=JDn7U/6axyPw/Wl4OsqM9vzEv2Ror4b3HQgewrlx7GwHA507eykHy3CT+dj2xFd7rF
         wt8TR3kND9waRQl1IMWRTB92t/fBbVgqitUIya8JgVYjG82qiYyNiC/5vBpsYx42iOve
         m0a+9eaa05hB3nYdawynQHPDxA4jHla7hq/4BXrQkJjb1DalgJUch60CMS/wKkapW5e4
         t5dopj5kMHSzaFFMcoKtQMGzfllZE6gAK2qj5oOQ3s7hpEsyBl13wWtsm83mzuf2de1U
         hMyvHC1mqjuVoTIVb958HuDZv+mdWZxf0Am3ilS8u06Tkdpi5H3Fg8KYXrn96cpXd8nC
         bo0g==
X-Gm-Message-State: ALKqPwdrebvxN2XbDvKFxgo1lzrJOXMECPKJeFVHLFWJTxCLEW+IVVvy
        mcgqNGfAtq9L7XJnhYPb4UTdzWwDGJw=
X-Google-Smtp-Source: ADUXVKKlFiGGFJwLSjzoCdVei3w1fJdYq4Gabo4nuEMbiK3gFgBDwNVdoihhr5yUogYad7GcRbw1Bw==
X-Received: by 2002:a17:902:848e:: with SMTP id c14-v6mr613825plo.129.1527641300816;
        Tue, 29 May 2018 17:48:20 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k84-v6sm24153745pfh.110.2018.05.29.17.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:19 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/35] object: add repository argument to parse_object
Date:   Tue, 29 May 2018 17:47:36 -0700
Message-Id: <20180530004810.30076-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of parse_object
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/diff-tree.c     |  3 ++-
 builtin/diff.c          |  2 +-
 builtin/fast-export.c   |  2 +-
 builtin/fmt-merge-msg.c |  6 ++++--
 builtin/fsck.c          |  4 ++--
 builtin/log.c           |  3 ++-
 builtin/name-rev.c      |  7 ++++---
 builtin/receive-pack.c  |  6 +++---
 builtin/reflog.c        |  3 ++-
 builtin/rev-list.c      |  2 +-
 bundle.c                |  5 +++--
 commit.c                |  5 +++--
 fetch-pack.c            | 18 ++++++++++--------
 fsck.c                  |  3 ++-
 http-backend.c          |  2 +-
 http-push.c             |  6 ++++--
 log-tree.c              |  7 ++++---
 merge-recursive.c       |  4 +++-
 object.c                |  4 ++--
 object.h                |  3 ++-
 packfile.c              |  2 +-
 pretty.c                |  2 +-
 ref-filter.c            |  3 ++-
 reflog-walk.c           |  3 ++-
 refs/files-backend.c    |  2 +-
 remote.c                |  4 ++--
 revision.c              | 14 +++++++-------
 server-info.c           |  2 +-
 sha1-name.c             | 14 +++++++-------
 tag.c                   |  5 +++--
 tree.c                  |  5 +++--
 upload-pack.c           | 13 +++++++------
 walker.c                |  3 ++-
 33 files changed, 95 insertions(+), 72 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 473615117e0..d8db8f682f0 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -5,6 +5,7 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "submodule.h"
+#include "repository.h"
 
 static struct rev_info log_tree_opt;
 
@@ -68,7 +69,7 @@ static int diff_tree_stdin(char *line)
 	line[len-1] = 0;
 	if (parse_oid_hex(line, &oid, &p))
 		return -1;
-	obj = parse_object(&oid);
+	obj = parse_object(the_repository, &oid);
 	if (!obj)
 		return -1;
 	if (obj->type == OBJ_COMMIT)
diff --git a/builtin/diff.c b/builtin/diff.c
index 16bfb22f738..ed6092ef1a3 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -393,7 +393,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		const char *name = entry->name;
 		int flags = (obj->flags & UNINTERESTING);
 		if (!obj->parsed)
-			obj = parse_object(&obj->oid);
+			obj = parse_object(the_repository, &obj->oid);
 		obj = deref_tag(obj, NULL, 0);
 		if (!obj)
 			die(_("invalid object '%s' given."), name);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index cb4b1c7f815..0da875b58c9 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -802,7 +802,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
 
 		/* handle nested tags */
 		while (tag && tag->object.type == OBJ_TAG) {
-			parse_object(&tag->object.oid);
+			parse_object(the_repository, &tag->object.oid);
 			string_list_append(&extra_refs, full_name)->util = tag;
 			tag = (struct tag *)tag->tagged;
 		}
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 1b526adb3a9..5e44589b545 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -11,6 +11,7 @@
 #include "branch.h"
 #include "fmt-merge-msg.h"
 #include "gpg-interface.h"
+#include "repository.h"
 
 static const char * const fmt_merge_msg_usage[] = {
 	N_("git fmt-merge-msg [-m <message>] [--log[=<n>] | --no-log] [--file <file>]"),
@@ -343,7 +344,8 @@ static void shortlog(const char *name,
 	const struct object_id *oid = &origin_data->oid;
 	int limit = opts->shortlog_len;
 
-	branch = deref_tag(parse_object(oid), oid_to_hex(oid), GIT_SHA1_HEXSZ);
+	branch = deref_tag(parse_object(the_repository, oid), oid_to_hex(oid),
+			   GIT_SHA1_HEXSZ);
 	if (!branch || branch->type != OBJ_COMMIT)
 		return;
 
@@ -563,7 +565,7 @@ static void find_merge_parents(struct merge_parents *result,
 		 * "name" here and we do not want to contaminate its
 		 * util field yet.
 		 */
-		obj = parse_object(&oid);
+		obj = parse_object(the_repository, &oid);
 		parent = (struct commit *)peel_to_type(NULL, 0, obj, OBJ_COMMIT);
 		if (!parent)
 			continue;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9d59d7d5a21..4b410cba54e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -452,7 +452,7 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 {
 	struct object *obj;
 
-	obj = parse_object(oid);
+	obj = parse_object(the_repository, oid);
 	if (!obj) {
 		if (is_promisor_object(oid)) {
 			/*
@@ -616,7 +616,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 		fprintf(stderr, "Checking cache tree\n");
 
 	if (0 <= it->entry_count) {
-		struct object *obj = parse_object(&it->oid);
+		struct object *obj = parse_object(the_repository, &it->oid);
 		if (!obj) {
 			error("%s: invalid sha1 pointer in cache-tree",
 			      oid_to_hex(&it->oid));
diff --git a/builtin/log.c b/builtin/log.c
index cff0d58d698..063057e45de 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -30,6 +30,7 @@
 #include "gpg-interface.h"
 #include "progress.h"
 #include "commit-slab.h"
+#include "repository.h"
 
 #define MAIL_DEFAULT_WRAP 72
 
@@ -619,7 +620,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			rev.shown_one = 1;
 			if (ret)
 				break;
-			o = parse_object(&t->tagged->oid);
+			o = parse_object(the_repository, &t->tagged->oid);
 			if (!o)
 				ret = error(_("Could not read object %s"),
 					    oid_to_hex(&t->tagged->oid));
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 0eb440359dd..de54fa93e4f 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "commit.h"
 #include "tag.h"
@@ -203,7 +204,7 @@ static int tipcmp(const void *a_, const void *b_)
 
 static int name_ref(const char *path, const struct object_id *oid, int flags, void *cb_data)
 {
-	struct object *o = parse_object(oid);
+	struct object *o = parse_object(the_repository, oid);
 	struct name_ref_data *data = cb_data;
 	int can_abbreviate_output = data->tags_only && data->name_only;
 	int deref = 0;
@@ -261,7 +262,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
 			break; /* broken repository */
-		o = parse_object(&t->tagged->oid);
+		o = parse_object(the_repository, &t->tagged->oid);
 		deref = 1;
 		taggerdate = t->date;
 	}
@@ -451,7 +452,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		}
 
 		commit = NULL;
-		object = parse_object(&oid);
+		object = parse_object(the_repository, &oid);
 		if (object) {
 			struct object *peeled = deref_tag(object, *argv, 0);
 			if (peeled && peeled->type == OBJ_COMMIT)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7adb61a37f2..0a74fcc7b0a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1108,8 +1108,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		struct object *old_object, *new_object;
 		struct commit *old_commit, *new_commit;
 
-		old_object = parse_object(old_oid);
-		new_object = parse_object(new_oid);
+		old_object = parse_object(the_repository, old_oid);
+		new_object = parse_object(the_repository, new_oid);
 
 		if (!old_object || !new_object ||
 		    old_object->type != OBJ_COMMIT ||
@@ -1132,7 +1132,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 	if (is_null_oid(new_oid)) {
 		struct strbuf err = STRBUF_INIT;
-		if (!parse_object(old_oid)) {
+		if (!parse_object(the_repository, old_oid)) {
 			old_oid = NULL;
 			if (ref_exists(name)) {
 				rp_warning("Allowing deletion of corrupt ref.");
diff --git a/builtin/reflog.c b/builtin/reflog.c
index bee4795a936..3a751fbaa60 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "lockfile.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "refs.h"
 #include "dir.h"
@@ -129,7 +130,7 @@ static int commit_is_complete(struct commit *commit)
 		struct commit_list *parent;
 
 		c = (struct commit *)object_array_pop(&study);
-		if (!c->object.parsed && !parse_object(&c->object.oid))
+		if (!c->object.parsed && !parse_object(the_repository, &c->object.oid))
 			c->object.flags |= INCOMPLETE;
 
 		if (c->object.flags & INCOMPLETE) {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index e9bd4e378ad..cbaaae83eae 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -239,7 +239,7 @@ static int finish_object(struct object *obj, const char *name, void *cb_data)
 		return 1;
 	}
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
-		parse_object(&obj->oid);
+		parse_object(the_repository, &obj->oid);
 	return 0;
 }
 
diff --git a/bundle.c b/bundle.c
index 00ada05f46c..9ef55f6bdb0 100644
--- a/bundle.c
+++ b/bundle.c
@@ -2,6 +2,7 @@
 #include "lockfile.h"
 #include "bundle.h"
 #include "object-store.h"
+#include "repository.h"
 #include "object.h"
 #include "commit.h"
 #include "diff.h"
@@ -142,7 +143,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	init_revisions(&revs, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		struct object *o = parse_object(&e->oid);
+		struct object *o = parse_object(the_repository, &e->oid);
 		if (o) {
 			o->flags |= PREREQ_MARK;
 			add_pending_object(&revs, o, e->name);
@@ -167,7 +168,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		struct object *o = parse_object(&e->oid);
+		struct object *o = parse_object(the_repository, &e->oid);
 		assert(o); /* otherwise we'd have returned early */
 		if (o->flags & SHOWN)
 			continue;
diff --git a/commit.c b/commit.c
index ddb6c04738b..11db72e9db2 100644
--- a/commit.c
+++ b/commit.c
@@ -26,7 +26,8 @@ const char *commit_type = "commit";
 struct commit *lookup_commit_reference_gently(const struct object_id *oid,
 					      int quiet)
 {
-	struct object *obj = deref_tag(parse_object(oid), NULL, 0);
+	struct object *obj = deref_tag(parse_object(the_repository, oid),
+				       NULL, 0);
 
 	if (!obj)
 		return NULL;
@@ -1616,7 +1617,7 @@ struct commit *get_merge_parent(const char *name)
 	struct object_id oid;
 	if (get_oid(name, &oid))
 		return NULL;
-	obj = parse_object(&oid);
+	obj = parse_object(the_repository, &oid);
 	commit = (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
 	if (commit && !merge_remote_util(commit))
 		set_merge_remote_desc(commit, name, obj);
diff --git a/fetch-pack.c b/fetch-pack.c
index 44e50b57d98..fa39ada77ee 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -84,7 +84,7 @@ static void cache_one_alternate(const char *refname,
 				void *vcache)
 {
 	struct alternate_object_cache *cache = vcache;
-	struct object *obj = parse_object(oid);
+	struct object *obj = parse_object(the_repository, oid);
 
 	if (!obj || (obj->flags & ALTERNATE))
 		return;
@@ -126,7 +126,8 @@ static void rev_list_push(struct commit *commit, int mark)
 
 static int rev_list_insert_ref(const char *refname, const struct object_id *oid)
 {
-	struct object *o = deref_tag(parse_object(oid), refname, 0);
+	struct object *o = deref_tag(parse_object(the_repository, oid),
+				     refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		rev_list_push((struct commit *)o, SEEN);
@@ -143,7 +144,8 @@ static int rev_list_insert_ref_oid(const char *refname, const struct object_id *
 static int clear_marks(const char *refname, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
-	struct object *o = deref_tag(parse_object(oid), refname, 0);
+	struct object *o = deref_tag(parse_object(the_repository, oid),
+				     refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		clear_commit_marks((struct commit *)o,
@@ -437,7 +439,7 @@ static int find_common(struct fetch_pack_args *args,
 				if (!lookup_object(oid.hash))
 					die(_("object not found: %s"), line);
 				/* make sure that it is parsed as shallow */
-				if (!parse_object(&oid))
+				if (!parse_object(the_repository, &oid))
 					die(_("error in object: %s"), line);
 				if (unregister_shallow(&oid))
 					die(_("no shallow found: %s"), line);
@@ -570,14 +572,14 @@ static struct commit_list *complete;
 
 static int mark_complete(const struct object_id *oid)
 {
-	struct object *o = parse_object(oid);
+	struct object *o = parse_object(the_repository, oid);
 
 	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
 			break; /* broken repository */
 		o->flags |= COMPLETE;
-		o = parse_object(&t->tagged->oid);
+		o = parse_object(the_repository, &t->tagged->oid);
 	}
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
@@ -768,7 +770,7 @@ static int everything_local(struct fetch_pack_args *args,
 
 		if (!has_object_file_with_flags(&ref->old_oid, flags))
 			continue;
-		o = parse_object(&ref->old_oid);
+		o = parse_object(the_repository, &ref->old_oid);
 		if (!o)
 			continue;
 
@@ -1296,7 +1298,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 			if (!lookup_object(oid.hash))
 				die(_("object not found: %s"), reader->line);
 			/* make sure that it is parsed as shallow */
-			if (!parse_object(&oid))
+			if (!parse_object(the_repository, &oid))
 				die(_("error in object: %s"), reader->line);
 			if (unregister_shallow(&oid))
 				die(_("no shallow found: %s"), reader->line);
diff --git a/fsck.c b/fsck.c
index 104c3c0a434..f9476f56e93 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "object-store.h"
+#include "repository.h"
 #include "object.h"
 #include "blob.h"
 #include "tree.h"
@@ -462,7 +463,7 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
 		return -1;
 
 	if (obj->type == OBJ_NONE)
-		parse_object(&obj->oid);
+		parse_object(the_repository, &obj->oid);
 
 	switch (obj->type) {
 	case OBJ_BLOB:
diff --git a/http-backend.c b/http-backend.c
index adaef16fadf..50ba4d53d54 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -436,7 +436,7 @@ static int show_text_ref(const char *name, const struct object_id *oid,
 {
 	const char *name_nons = strip_namespace(name);
 	struct strbuf *buf = cb_data;
-	struct object *o = parse_object(oid);
+	struct object *o = parse_object(the_repository, oid);
 	if (!o)
 		return 0;
 
diff --git a/http-push.c b/http-push.c
index f308ce0195a..311b6295359 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "commit.h"
 #include "tag.h"
 #include "blob.h"
@@ -14,6 +15,7 @@
 #include "packfile.h"
 #include "object-store.h"
 
+
 #ifdef EXPAT_NEEDS_XMLPARSE_H
 #include <xmlparse.h>
 #else
@@ -722,7 +724,7 @@ static void one_remote_object(const struct object_id *oid)
 
 	obj = lookup_object(oid->hash);
 	if (!obj)
-		obj = parse_object(oid);
+		obj = parse_object(the_repository, oid);
 
 	/* Ignore remote objects that don't exist locally */
 	if (!obj)
@@ -1459,7 +1461,7 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 		return;
 	}
 
-	o = parse_object(&ref->old_oid);
+	o = parse_object(the_repository, &ref->old_oid);
 	if (!o) {
 		fprintf(stderr,
 			"Unable to parse object %s for remote ref %s\n",
diff --git a/log-tree.c b/log-tree.c
index 9c3053600a4..e8d2857bf06 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "diff.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "tag.h"
 #include "graph.h"
@@ -111,13 +112,13 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			warning("invalid replace ref %s", refname);
 			return 0;
 		}
-		obj = parse_object(&original_oid);
+		obj = parse_object(the_repository, &original_oid);
 		if (obj)
 			add_name_decoration(DECORATION_GRAFTED, "replaced", obj);
 		return 0;
 	}
 
-	obj = parse_object(oid);
+	obj = parse_object(the_repository, oid);
 	if (!obj)
 		return 0;
 
@@ -138,7 +139,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 		if (!obj)
 			break;
 		if (!obj->parsed)
-			parse_object(&obj->oid);
+			parse_object(the_repository, &obj->oid);
 		add_name_decoration(DECORATION_REF_TAG, refname, obj);
 	}
 	return 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index 41cf9512d63..8ddedf79c0b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -9,6 +9,7 @@
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "blob.h"
 #include "builtin.h"
@@ -2183,7 +2184,8 @@ static struct commit *get_ref(const struct object_id *oid, const char *name)
 {
 	struct object *object;
 
-	object = deref_tag(parse_object(oid), name, strlen(name));
+	object = deref_tag(parse_object(the_repository, oid), name,
+			   strlen(name));
 	if (!object)
 		return NULL;
 	if (object->type == OBJ_TREE)
diff --git a/object.c b/object.c
index 30b8a721cf6..469e6126286 100644
--- a/object.c
+++ b/object.c
@@ -239,14 +239,14 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
 struct object *parse_object_or_die(const struct object_id *oid,
 				   const char *name)
 {
-	struct object *o = parse_object(oid);
+	struct object *o = parse_object(the_repository, oid);
 	if (o)
 		return o;
 
 	die(_("unable to parse object: %s"), name ? name : oid_to_hex(oid));
 }
 
-struct object *parse_object(const struct object_id *oid)
+struct object *parse_object_the_repository(const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
diff --git a/object.h b/object.h
index 998145de46a..f69095d3dde 100644
--- a/object.h
+++ b/object.h
@@ -121,7 +121,8 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet);
  *
  * Returns NULL if the object is missing or corrupt.
  */
-struct object *parse_object(const struct object_id *oid);
+#define parse_object(r, oid) parse_object_##r(oid)
+struct object *parse_object_the_repository(const struct object_id *oid);
 
 /*
  * Like parse_object, but will die() instead of returning NULL. If the
diff --git a/packfile.c b/packfile.c
index 1ec86930209..85ef0909087 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1924,7 +1924,7 @@ static int add_promisor_object(const struct object_id *oid,
 			       void *set_)
 {
 	struct oidset *set = set_;
-	struct object *obj = parse_object(oid);
+	struct object *obj = parse_object(the_repository, oid);
 	if (!obj)
 		return 1;
 
diff --git a/pretty.c b/pretty.c
index 34fe891fc03..c99f8243faf 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1146,7 +1146,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	/* these depend on the commit */
 	if (!commit->object.parsed)
-		parse_object(&commit->object.oid);
+		parse_object(the_repository, &commit->object.oid);
 
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
diff --git a/ref-filter.c b/ref-filter.c
index 7b9e44dcaba..6ebb4630f9c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -4,6 +4,7 @@
 #include "refs.h"
 #include "wildmatch.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "remote.h"
 #include "color.h"
@@ -1898,7 +1899,7 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 
 	if (oid_array_lookup(points_at, oid) >= 0)
 		return oid;
-	obj = parse_object(oid);
+	obj = parse_object(the_repository, oid);
 	if (!obj)
 		die(_("malformed object at '%s'"), refname);
 	if (obj->type == OBJ_TAG)
diff --git a/reflog-walk.c b/reflog-walk.c
index 5008bbf6ada..3561a8b9558 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -305,7 +305,8 @@ static struct commit *next_reflog_commit(struct commit_reflog *log)
 {
 	for (; log->recno >= 0; log->recno--) {
 		struct reflog_info *entry = &log->reflogs->items[log->recno];
-		struct object *obj = parse_object(&entry->noid);
+		struct object *obj = parse_object(the_repository,
+						  &entry->noid);
 
 		if (obj && obj->type == OBJ_COMMIT)
 			return (struct commit *)obj;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 49d8f67bf13..942f6a0c219 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1660,7 +1660,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 	struct object *o;
 	int fd;
 
-	o = parse_object(oid);
+	o = parse_object(the_repository, oid);
 	if (!o) {
 		strbuf_addf(err,
 			    "trying to write ref '%s' with nonexistent object %s",
diff --git a/remote.c b/remote.c
index db438cfbc56..92a17828d25 100644
--- a/remote.c
+++ b/remote.c
@@ -1994,12 +1994,12 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 	 * Both new_commit and old_commit must be commit-ish and new_commit is descendant of
 	 * old_commit.  Otherwise we require --force.
 	 */
-	o = deref_tag(parse_object(old_oid), NULL, 0);
+	o = deref_tag(parse_object(the_repository, old_oid), NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	old_commit = (struct commit *) o;
 
-	o = deref_tag(parse_object(new_oid), NULL, 0);
+	o = deref_tag(parse_object(the_repository, new_oid), NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	new_commit = (struct commit *) o;
diff --git a/revision.c b/revision.c
index a00c43219fb..f051c6c5806 100644
--- a/revision.c
+++ b/revision.c
@@ -187,7 +187,7 @@ void add_head_to_pending(struct rev_info *revs)
 	struct object *obj;
 	if (get_oid("HEAD", &oid))
 		return;
-	obj = parse_object(&oid);
+	obj = parse_object(the_repository, &oid);
 	if (!obj)
 		return;
 	add_pending_object(revs, obj, "HEAD");
@@ -199,7 +199,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 {
 	struct object *object;
 
-	object = parse_object(oid);
+	object = parse_object(the_repository, oid);
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
@@ -236,7 +236,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			add_pending_object(revs, object, tag->tag);
 		if (!tag->tagged)
 			die("bad tag");
-		object = parse_object(&tag->tagged->oid);
+		object = parse_object(the_repository, &tag->tagged->oid);
 		if (!object) {
 			if (revs->ignore_missing_links || (flags & UNINTERESTING))
 				return NULL;
@@ -1239,7 +1239,7 @@ static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	if (!is_null_oid(oid)) {
-		struct object *o = parse_object(oid);
+		struct object *o = parse_object(the_repository, oid);
 		if (o) {
 			o->flags |= cb->all_flags;
 			/* ??? CMDLINEFLAGS ??? */
@@ -1567,8 +1567,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		*dotdot = '\0';
 	}
 
-	a_obj = parse_object(&a_oid);
-	b_obj = parse_object(&b_oid);
+	a_obj = parse_object(the_repository, &a_oid);
+	b_obj = parse_object(the_repository, &b_oid);
 	if (!a_obj || !b_obj)
 		return dotdot_missing(arg, dotdot, revs, symmetric);
 
@@ -2872,7 +2872,7 @@ static int mark_uninteresting(const struct object_id *oid,
 			      uint32_t pos,
 			      void *unused)
 {
-	struct object *o = parse_object(oid);
+	struct object *o = parse_object(the_repository, oid);
 	o->flags |= UNINTERESTING | SEEN;
 	return 0;
 }
diff --git a/server-info.c b/server-info.c
index 83460ec0d6f..368fb547f4b 100644
--- a/server-info.c
+++ b/server-info.c
@@ -56,7 +56,7 @@ static int add_info_ref(const char *path, const struct object_id *oid,
 			int flag, void *cb_data)
 {
 	FILE *fp = cb_data;
-	struct object *o = parse_object(oid);
+	struct object *o = parse_object(the_repository, oid);
 	if (!o)
 		return -1;
 
diff --git a/sha1-name.c b/sha1-name.c
index b5406b6eb21..3e1c57e1539 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -239,7 +239,7 @@ static int disambiguate_committish_only(const struct object_id *oid, void *cb_da
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(parse_object(oid), NULL, 0);
+	obj = deref_tag(parse_object(the_repository, oid), NULL, 0);
 	if (obj && obj->type == OBJ_COMMIT)
 		return 1;
 	return 0;
@@ -263,7 +263,7 @@ static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(parse_object(oid), NULL, 0);
+	obj = deref_tag(parse_object(the_repository, oid), NULL, 0);
 	if (obj && (obj->type == OBJ_TREE || obj->type == OBJ_COMMIT))
 		return 1;
 	return 0;
@@ -857,7 +857,7 @@ struct object *peel_to_type(const char *name, int namelen,
 	if (name && !namelen)
 		namelen = strlen(name);
 	while (1) {
-		if (!o || (!o->parsed && !parse_object(&o->oid)))
+		if (!o || (!o->parsed && !parse_object(the_repository, &o->oid)))
 			return NULL;
 		if (expected_type == OBJ_ANY || o->type == expected_type)
 			return o;
@@ -930,12 +930,12 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	if (get_oid_1(name, sp - name - 2, &outer, lookup_flags))
 		return -1;
 
-	o = parse_object(&outer);
+	o = parse_object(the_repository, &outer);
 	if (!o)
 		return -1;
 	if (!expected_type) {
 		o = deref_tag(o, name, sp - name - 2);
-		if (!o || (!o->parsed && !parse_object(&o->oid)))
+		if (!o || (!o->parsed && !parse_object(the_repository, &o->oid)))
 			return -1;
 		oidcpy(oid, &o->oid);
 		return 0;
@@ -1062,7 +1062,7 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
 	struct commit_list **list = cb_data;
-	struct object *object = parse_object(oid);
+	struct object *object = parse_object(the_repository, oid);
 	if (!object)
 		return 0;
 	if (object->type == OBJ_TAG) {
@@ -1108,7 +1108,7 @@ static int get_oid_oneline(const char *prefix, struct object_id *oid,
 		int matches;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
-		if (!parse_object(&commit->object.oid))
+		if (!parse_object(the_repository, &commit->object.oid))
 			continue;
 		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
diff --git a/tag.c b/tag.c
index 3be7206e920..7d282df0697 100644
--- a/tag.c
+++ b/tag.c
@@ -68,7 +68,8 @@ struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
 		if (((struct tag *)o)->tagged)
-			o = parse_object(&((struct tag *)o)->tagged->oid);
+			o = parse_object(the_repository,
+					 &((struct tag *)o)->tagged->oid);
 		else
 			o = NULL;
 	if (!o && warn) {
@@ -82,7 +83,7 @@ struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 struct object *deref_tag_noverify(struct object *o)
 {
 	while (o && o->type == OBJ_TAG) {
-		o = parse_object(&o->oid);
+		o = parse_object(the_repository, &o->oid);
 		if (o && o->type == OBJ_TAG && ((struct tag *)o)->tagged)
 			o = ((struct tag *)o)->tagged;
 		else
diff --git a/tree.c b/tree.c
index dc20a2693fd..1033e69b590 100644
--- a/tree.c
+++ b/tree.c
@@ -8,6 +8,7 @@
 #include "tag.h"
 #include "alloc.h"
 #include "tree-walk.h"
+#include "repository.h"
 
 const char *tree_type = "tree";
 
@@ -244,7 +245,7 @@ void free_tree_buffer(struct tree *tree)
 
 struct tree *parse_tree_indirect(const struct object_id *oid)
 {
-	struct object *obj = parse_object(oid);
+	struct object *obj = parse_object(the_repository, oid);
 	do {
 		if (!obj)
 			return NULL;
@@ -257,6 +258,6 @@ struct tree *parse_tree_indirect(const struct object_id *oid)
 		else
 			return NULL;
 		if (!obj->parsed)
-			parse_object(&obj->oid);
+			parse_object(the_repository, &obj->oid);
 	} while (1);
 }
diff --git a/upload-pack.c b/upload-pack.c
index 3627e8fafa5..afe997c89ec 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -3,6 +3,7 @@
 #include "refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "repository.h"
 #include "object-store.h"
 #include "tag.h"
 #include "object.h"
@@ -311,7 +312,7 @@ static int got_oid(const char *hex, struct object_id *oid)
 	if (!has_object_file(oid))
 		return -1;
 
-	o = parse_object(oid);
+	o = parse_object(the_repository, oid);
 	if (!o)
 		die("oops (%s)", oid_to_hex(oid));
 	if (o->type == OBJ_COMMIT) {
@@ -349,7 +350,7 @@ static int reachable(struct commit *want)
 			break;
 		}
 		if (!commit->object.parsed)
-			parse_object(&commit->object.oid);
+			parse_object(the_repository, &commit->object.oid);
 		if (commit->object.flags & REACHABLE)
 			continue;
 		commit->object.flags |= REACHABLE;
@@ -798,7 +799,7 @@ static int process_shallow(const char *line, struct object_array *shallows)
 		struct object *object;
 		if (get_oid_hex(arg, &oid))
 			die("invalid shallow line: %s", line);
-		object = parse_object(&oid);
+		object = parse_object(the_repository, &oid);
 		if (!object)
 			return 1;
 		if (object->type != OBJ_COMMIT)
@@ -926,7 +927,7 @@ static void receive_needs(void)
 		if (allow_filter && parse_feature_request(features, "filter"))
 			filter_capability_requested = 1;
 
-		o = parse_object(&oid_buf);
+		o = parse_object(the_repository, &oid_buf);
 		if (!o) {
 			packet_write_fmt(1,
 					 "ERR upload-pack: not our ref %s",
@@ -1168,7 +1169,7 @@ static int parse_want(const char *line)
 			die("git upload-pack: protocol error, "
 			    "expected to get oid, not '%s'", line);
 
-		o = parse_object(&oid);
+		o = parse_object(the_repository, &oid);
 		if (!o) {
 			packet_write_fmt(1,
 					 "ERR upload-pack: not our ref %s",
@@ -1274,7 +1275,7 @@ static int process_haves(struct oid_array *haves, struct oid_array *common)
 
 		oid_array_append(common, oid);
 
-		o = parse_object(oid);
+		o = parse_object(the_repository, oid);
 		if (!o)
 			die("oops (%s)", oid_to_hex(oid));
 		if (o->type == OBJ_COMMIT) {
diff --git a/walker.c b/walker.c
index a80811f6d5e..3678e344312 100644
--- a/walker.c
+++ b/walker.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "walker.h"
+#include "repository.h"
 #include "object-store.h"
 #include "commit.h"
 #include "tree.h"
@@ -178,7 +179,7 @@ static int loop(struct walker *walker)
 			}
 		}
 		if (!obj->type)
-			parse_object(&obj->oid);
+			parse_object(the_repository, &obj->oid);
 		if (process_object(walker, obj))
 			return -1;
 	}
-- 
2.17.0.582.gccdcbd54c44.dirty

