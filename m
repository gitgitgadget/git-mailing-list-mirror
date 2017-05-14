Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D88A120188
	for <e@80x24.org>; Sun, 14 May 2017 03:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758897AbdENDRG (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:17:06 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33508 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758765AbdENDQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:28 -0400
Received: by mail-oi0-f66.google.com with SMTP id h4so14344393oib.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p+9qmXxp694JjRkw5e4XquzVfFRU3O6Cr9aHZtBL5TQ=;
        b=W16uKWAkpDhQuyt3U6fsEhM9FUMOgt3iqVm7T18U+dwdgJbXeX50Dk/4nxTFm8r+Ov
         ED8m4SJM1mMTsdjrn6o6Uq/qJm1oeh/ogWZ5+Nx8lpjpF8YnJWX5LKvNjKXzHYCkGGul
         QcPZbyrnePGxJHyZuHTDYK6Q3y+sZ4tUoIKGw7/KZGfmxDZXGo0/dNdZZSZbMS1gp/cZ
         b+Y1SBQ+NuWTScfr//zG8SQhT0YqH4Zx+S6xEZOoWDcBam8y268vFH4mVf1sgQjDwgyd
         rZr1sLF381yBa2KgEbNsc/cVGN2oxCUkJf3KY1OaSq0c17UuCDyzMtgBorsPjk3NIErf
         l6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p+9qmXxp694JjRkw5e4XquzVfFRU3O6Cr9aHZtBL5TQ=;
        b=o/ipN2TatBAEI1O5qcuZlnEme23EhdKf47oF483fGf7QLjkP1wZuZN3j3lpDL3gXH5
         oUY7CPE9NcnxMRhiqspQLqU1EaxQiX2+tXcvW6fmFZTA4x1uQgkgxu/GbRWwZ9wWdC00
         OY+n1ncL28+V2Gpam/2PJbgnXm274bwt2rTV6+AyU/YSNOlB1x2X0L8hPgR416qymMmE
         v3uwFrEz5ViVBp7450FzCFdy7fbNmiV+QJwlnAsWTUWi0g/l0ephlml6NNKDAjBVqcHQ
         dBDaESbYEXogjsQCkz+gI02ElLdfT3+rH2CZXh85cIW8KkdfN55qnLrhpF0ZABIHSpj0
         Z3Cg==
X-Gm-Message-State: AODbwcBQSBqzAa5INiZ6LDfvMk6fCvZoTqMLy8QrGq1/0fv3SL0S7QV8
        aP4IKtV0gyTlhi9n2dY=
X-Received: by 10.157.66.29 with SMTP id q29mr6204890ote.2.1494731787485;
        Sat, 13 May 2017 20:16:27 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:26 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 17/22] blame: move origin-related methods to libgit
Date:   Sat, 13 May 2017 22:15:08 -0500
Message-Id: <20170514031513.9042-18-whydoubt@gmail.com>
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
 Makefile        |   1 +
 blame.c         |  62 +++++++++++++++++++++++++++++
 blame.h         |  15 +++++++
 builtin/blame.c | 120 ++++++++++++--------------------------------------------
 4 files changed, 102 insertions(+), 96 deletions(-)
 create mode 100644 blame.c

diff --git a/Makefile b/Makefile
index e35542e..2d795ed 100644
--- a/Makefile
+++ b/Makefile
@@ -718,6 +718,7 @@ LIB_OBJS += argv-array.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
+LIB_OBJS += blame.o
 LIB_OBJS += blob.o
 LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
diff --git a/blame.c b/blame.c
new file mode 100644
index 0000000..4855d6d
--- /dev/null
+++ b/blame.c
@@ -0,0 +1,62 @@
+#include "blame.h"
+
+void blame_origin_decref(struct blame_origin *o)
+{
+	if (o && --o->refcnt <= 0) {
+		struct blame_origin *p, *l = NULL;
+		if (o->previous)
+			blame_origin_decref(o->previous);
+		free(o->file.ptr);
+		/* Should be present exactly once in commit chain */
+		for (p = o->commit->util; p; l = p, p = p->next) {
+			if (p == o) {
+				if (l)
+					l->next = p->next;
+				else
+					o->commit->util = p->next;
+				free(o);
+				return;
+			}
+		}
+		die("internal error in blame_origin_decref");
+	}
+}
+
+/*
+ * Given a commit and a path in it, create a new origin structure.
+ * The callers that add blame to the scoreboard should use
+ * get_origin() to obtain shared, refcounted copy instead of calling
+ * this function directly.
+ */
+struct blame_origin *make_origin(struct commit *commit, const char *path)
+{
+	struct blame_origin *o;
+	FLEX_ALLOC_STR(o, path, path);
+	o->commit = commit;
+	o->refcnt = 1;
+	o->next = commit->util;
+	commit->util = o;
+	return o;
+}
+
+/*
+ * Locate an existing origin or create a new one.
+ * This moves the origin to front position in the commit util list.
+ */
+struct blame_origin *get_origin(struct commit *commit, const char *path)
+{
+	struct blame_origin *o, *l;
+
+	for (o = commit->util, l = NULL; o; l = o, o = o->next) {
+		if (!strcmp(o->path, path)) {
+			/* bump to front */
+			if (l) {
+				l->next = o->next;
+				o->next = commit->util;
+				commit->util = o;
+			}
+			return blame_origin_incref(o);
+		}
+	}
+	return make_origin(commit, path);
+}
diff --git a/blame.h b/blame.h
index a0bd91b..39f8865 100644
--- a/blame.h
+++ b/blame.h
@@ -143,4 +143,19 @@ struct blame_scoreboard {
 	void *found_guilty_entry_data;
 };
 
+/*
+ * Origin is refcounted and usually we keep the blob contents to be
+ * reused.
+ */
+static inline struct blame_origin *blame_origin_incref(struct blame_origin *o)
+{
+	if (o)
+		o->refcnt++;
+	return o;
+}
+extern void blame_origin_decref(struct blame_origin *o);
+
+extern struct blame_origin *make_origin(struct commit *commit, const char *path);
+extern struct blame_origin *get_origin(struct commit *commit, const char *path);
+
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index 3d85f62..b60d604 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -122,39 +122,6 @@ static void fill_origin_blob(struct diff_options *opt,
 		*file = o->file;
 }
 
-/*
- * Origin is refcounted and usually we keep the blob contents to be
- * reused.
- */
-static inline struct blame_origin *origin_incref(struct blame_origin *o)
-{
-	if (o)
-		o->refcnt++;
-	return o;
-}
-
-static void origin_decref(struct blame_origin *o)
-{
-	if (o && --o->refcnt <= 0) {
-		struct blame_origin *p, *l = NULL;
-		if (o->previous)
-			origin_decref(o->previous);
-		free(o->file.ptr);
-		/* Should be present exactly once in commit chain */
-		for (p = o->commit->util; p; l = p, p = p->next) {
-			if (p == o) {
-				if (l)
-					l->next = p->next;
-				else
-					o->commit->util = p->next;
-				free(o);
-				return;
-			}
-		}
-		die("internal error in blame::origin_decref");
-	}
-}
-
 static void drop_origin_blob(struct blame_origin *o)
 {
 	if (o->file.ptr) {
@@ -278,7 +245,7 @@ static void coalesce(struct blame_scoreboard *sb)
 		    ent->s_lno + ent->num_lines == next->s_lno) {
 			ent->num_lines += next->num_lines;
 			ent->next = next->next;
-			origin_decref(next->suspect);
+			blame_origin_decref(next->suspect);
 			free(next);
 			ent->score = 0;
 			next = ent; /* again */
@@ -314,45 +281,6 @@ static void queue_blames(struct blame_scoreboard *sb, struct blame_origin *porig
 }
 
 /*
- * Given a commit and a path in it, create a new origin structure.
- * The callers that add blame to the scoreboard should use
- * get_origin() to obtain shared, refcounted copy instead of calling
- * this function directly.
- */
-static struct blame_origin *make_origin(struct commit *commit, const char *path)
-{
-	struct blame_origin *o;
-	FLEX_ALLOC_STR(o, path, path);
-	o->commit = commit;
-	o->refcnt = 1;
-	o->next = commit->util;
-	commit->util = o;
-	return o;
-}
-
-/*
- * Locate an existing origin or create a new one.
- * This moves the origin to front position in the commit util list.
- */
-static struct blame_origin *get_origin(struct commit *commit, const char *path)
-{
-	struct blame_origin *o, *l;
-
-	for (o = commit->util, l = NULL; o; l = o, o = o->next) {
-		if (!strcmp(o->path, path)) {
-			/* bump to front */
-			if (l) {
-				l->next = o->next;
-				o->next = commit->util;
-				commit->util = o;
-			}
-			return origin_incref(o);
-		}
-	}
-	return make_origin(commit, path);
-}
-
-/*
  * Fill the blob_sha1 field of an origin if it hasn't, so that later
  * call to fill_origin_blob() can use it to locate the data.  blob_sha1
  * for an origin is also used to pass the blame for the entire file to
@@ -396,7 +324,7 @@ static struct blame_origin *find_origin(struct commit *parent,
 			 * The same path between origin and its parent
 			 * without renaming -- the most common case.
 			 */
-			return origin_incref (porigin);
+			return blame_origin_incref (porigin);
 		}
 
 	/* See if the origin->path is different between parent
@@ -515,7 +443,7 @@ static void add_blame_entry(struct blame_entry ***queue,
 {
 	struct blame_entry *e = xmalloc(sizeof(*e));
 	memcpy(e, src, sizeof(*e));
-	origin_incref(e->suspect);
+	blame_origin_incref(e->suspect);
 
 	e->next = **queue;
 	**queue = e;
@@ -530,8 +458,8 @@ static void add_blame_entry(struct blame_entry ***queue,
 static void dup_entry(struct blame_entry ***queue,
 		      struct blame_entry *dst, struct blame_entry *src)
 {
-	origin_incref(src->suspect);
-	origin_decref(dst->suspect);
+	blame_origin_incref(src->suspect);
+	blame_origin_decref(dst->suspect);
 	memcpy(dst, src, sizeof(*src));
 	dst->next = **queue;
 	**queue = dst;
@@ -572,7 +500,7 @@ static void split_overlap(struct blame_entry *split,
 
 	if (e->s_lno < tlno) {
 		/* there is a pre-chunk part not blamed on parent */
-		split[0].suspect = origin_incref(e->suspect);
+		split[0].suspect = blame_origin_incref(e->suspect);
 		split[0].lno = e->lno;
 		split[0].s_lno = e->s_lno;
 		split[0].num_lines = tlno - e->s_lno;
@@ -586,7 +514,7 @@ static void split_overlap(struct blame_entry *split,
 
 	if (same < e->s_lno + e->num_lines) {
 		/* there is a post-chunk part not blamed on parent */
-		split[2].suspect = origin_incref(e->suspect);
+		split[2].suspect = blame_origin_incref(e->suspect);
 		split[2].lno = e->lno + (same - e->s_lno);
 		split[2].s_lno = e->s_lno + (same - e->s_lno);
 		split[2].num_lines = e->s_lno + e->num_lines - same;
@@ -602,7 +530,7 @@ static void split_overlap(struct blame_entry *split,
 	 */
 	if (split[1].num_lines < 1)
 		return;
-	split[1].suspect = origin_incref(parent);
+	split[1].suspect = blame_origin_incref(parent);
 }
 
 /*
@@ -652,7 +580,7 @@ static void decref_split(struct blame_entry *split)
 	int i;
 
 	for (i = 0; i < 3; i++)
-		origin_decref(split[i].suspect);
+		blame_origin_decref(split[i].suspect);
 }
 
 /*
@@ -715,10 +643,10 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			n->next = diffp;
 			diffp = n;
 		} else
-			origin_decref(e->suspect);
+			blame_origin_decref(e->suspect);
 		/* Pass blame for everything before the differing
 		 * chunk to the parent */
-		e->suspect = origin_incref(parent);
+		e->suspect = blame_origin_incref(parent);
 		e->s_lno += offset;
 		e->next = samep;
 		samep = e;
@@ -759,7 +687,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			 */
 			int len = same - e->s_lno;
 			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
-			n->suspect = origin_incref(e->suspect);
+			n->suspect = blame_origin_incref(e->suspect);
 			n->lno = e->lno + len;
 			n->s_lno = e->s_lno + len;
 			n->num_lines = e->num_lines - len;
@@ -885,7 +813,7 @@ static void copy_split_if_better(struct blame_scoreboard *sb,
 	}
 
 	for (i = 0; i < 3; i++)
-		origin_incref(this[i].suspect);
+		blame_origin_incref(this[i].suspect);
 	decref_split(best_so_far);
 	memcpy(best_so_far, this, sizeof(struct blame_entry [3]));
 }
@@ -1165,7 +1093,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 						     this);
 				decref_split(this);
 			}
-			origin_decref(norigin);
+			blame_origin_decref(norigin);
 		}
 
 		for (j = 0; j < num_ents; j++) {
@@ -1206,8 +1134,8 @@ static void pass_whole_blame(struct blame_scoreboard *sb,
 	suspects = origin->suspects;
 	origin->suspects = NULL;
 	for (e = suspects; e; e = e->next) {
-		origin_incref(porigin);
-		origin_decref(e->suspect);
+		blame_origin_incref(porigin);
+		blame_origin_decref(e->suspect);
 		e->suspect = porigin;
 	}
 	queue_blames(sb, porigin, suspects);
@@ -1305,7 +1233,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 				continue;
 			if (!oidcmp(&porigin->blob_oid, &origin->blob_oid)) {
 				pass_whole_blame(sb, origin, porigin);
-				origin_decref(porigin);
+				blame_origin_decref(porigin);
 				goto finish;
 			}
 			for (j = same = 0; j < i; j++)
@@ -1317,7 +1245,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 			if (!same)
 				sg_origin[i] = porigin;
 			else
-				origin_decref(porigin);
+				blame_origin_decref(porigin);
 		}
 	}
 
@@ -1329,7 +1257,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 		if (!porigin)
 			continue;
 		if (!origin->previous) {
-			origin_incref(porigin);
+			blame_origin_incref(porigin);
 			origin->previous = porigin;
 		}
 		pass_blame_to_parent(sb, origin, porigin);
@@ -1400,7 +1328,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	for (i = 0; i < num_sg; i++) {
 		if (sg_origin[i]) {
 			drop_origin_blob(sg_origin[i]);
-			origin_decref(sg_origin[i]);
+			blame_origin_decref(sg_origin[i]);
 		}
 	}
 	drop_origin_blob(origin);
@@ -1645,7 +1573,7 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 		 * We will use this suspect later in the loop,
 		 * so hold onto it in the meantime.
 		 */
-		origin_incref(suspect);
+		blame_origin_incref(suspect);
 		parse_commit(commit);
 		if (sb->reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
@@ -1678,7 +1606,7 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 				break;
 			}
 		}
-		origin_decref(suspect);
+		blame_origin_decref(suspect);
 
 		if (sb->debug) /* sanity */
 			sanity_check_refcnt(sb);
@@ -2743,13 +2671,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		ent->suspect = o;
 		ent->s_lno = bottom;
 		ent->next = next;
-		origin_incref(o);
+		blame_origin_incref(o);
 	}
 
 	o->suspects = ent;
 	prio_queue_put(&sb.commits, o->commit);
 
-	origin_decref(o);
+	blame_origin_decref(o);
 
 	range_set_release(&ranges);
 	string_list_clear(&range_list, 0);
-- 
2.9.3

