Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 432E020188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758611AbdENDQT (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:19 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33448 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758139AbdENDQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:12 -0400
Received: by mail-oi0-f66.google.com with SMTP id h4so14343945oib.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q/OvvrXCNlyWo+oKBLJRAoTE0NYQJp6CAclDPJj8d0U=;
        b=A6ctKQomdfvlXnYmq0erBrsJbLMUaElLcGeAe1oNhHTXN/62mhKQ2fqLu7cjhAKcil
         S6ukZicL4OBzwwX8qLn051gf/AlTjPZFKLPewfb7AWIS5MayclgTt8RqbbleqXq7R1Ju
         gj+arO6CReVkb3+n4dqGKUJBqTQDWSVHIaITIG0Z3IT5d682Jl2qqOPW1c5Sfjtk5qnu
         XX57rcup1+tkKlGA5M4S3Kw/2f1kMViXScLm3li6rqfMGgPQ505H9C3bgae9HTpmv+35
         NOKe/8PY5j0OG5uu4sswhhrIV/1uu/dvwf2fiR53gGFO5zFVqJkJy0O4dFPO6o/OWkWo
         8rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q/OvvrXCNlyWo+oKBLJRAoTE0NYQJp6CAclDPJj8d0U=;
        b=oKRV5iLjcHlpYSpo35ZJwAJSKpXaXwoSN98gzVO6m5jhfAf/qPi677NSAayX9sEpeP
         rnqjdwJ8UebOlLUUT8TMF/GYI9ynCqMNxtDta/l+1ff8wUp/AiPjm8/4RW+qWZ3ouNW5
         i/H/Sh7WRKkyNiOr28wz/C7W/xLl3tUFfJIPJ8a4TUa9soOtvGEXFR0Xn955zaM+1UIy
         A15DhA3zt+pUXysXe1ACS41FkoB9y5bwqFaHuS32KBOFgb3JIRZHCgAPIdoKmFyBo8iq
         EMAt5m2lmr0W9VISv+qKUpGDFSp+SAjZ2+hfZUxYXtbm9RolhS/+41uNJYDtG6a+z7t0
         ukwA==
X-Gm-Message-State: AODbwcALS49YEA1XrDbLPo5Uqi7RLUbWzgo1x9Ek/tbY9OiVWNfEN9yU
        61icrV+VBooE9w==
X-Received: by 10.202.245.194 with SMTP id t185mr5629922oih.102.1494731770836;
        Sat, 13 May 2017 20:16:10 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:10 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 04/22] blame: move origin and entry structures to header
Date:   Sat, 13 May 2017 22:14:55 -0500
Message-Id: <20170514031513.9042-5-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The origin and blame_entry structures are core to the blame interface
and reference each other. Since origin will be more exposed, rename it
to blame_origin to clarify what it is a part of.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.h         |  86 ++++++++++++++++++++++++++
 builtin/blame.c | 185 +++++++++++++++++---------------------------------------
 2 files changed, 140 insertions(+), 131 deletions(-)
 create mode 100644 blame.h

diff --git a/blame.h b/blame.h
new file mode 100644
index 0000000..f52d0fc
--- /dev/null
+++ b/blame.h
@@ -0,0 +1,86 @@
+#ifndef BLAME_H
+#define BLAME_H
+
+#include "cache.h"
+#include "commit.h"
+#include "xdiff-interface.h"
+
+/*
+ * One blob in a commit that is being suspected
+ */
+struct blame_origin {
+	int refcnt;
+	/* Record preceding blame record for this blob */
+	struct blame_origin *previous;
+	/* origins are put in a list linked via `next' hanging off the
+	 * corresponding commit's util field in order to make finding
+	 * them fast.  The presence in this chain does not count
+	 * towards the origin's reference count.  It is tempting to
+	 * let it count as long as the commit is pending examination,
+	 * but even under circumstances where the commit will be
+	 * present multiple times in the priority queue of unexamined
+	 * commits, processing the first instance will not leave any
+	 * work requiring the origin data for the second instance.  An
+	 * interspersed commit changing that would have to be
+	 * preexisting with a different ancestry and with the same
+	 * commit date in order to wedge itself between two instances
+	 * of the same commit in the priority queue _and_ produce
+	 * blame entries relevant for it.  While we don't want to let
+	 * us get tripped up by this case, it certainly does not seem
+	 * worth optimizing for.
+	 */
+	struct blame_origin *next;
+	struct commit *commit;
+	/* `suspects' contains blame entries that may be attributed to
+	 * this origin's commit or to parent commits.  When a commit
+	 * is being processed, all suspects will be moved, either by
+	 * assigning them to an origin in a different commit, or by
+	 * shipping them to the scoreboard's ent list because they
+	 * cannot be attributed to a different commit.
+	 */
+	struct blame_entry *suspects;
+	mmfile_t file;
+	struct object_id blob_oid;
+	unsigned mode;
+	/* guilty gets set when shipping any suspects to the final
+	 * blame list instead of other commits
+	 */
+	char guilty;
+	char path[FLEX_ARRAY];
+};
+
+/*
+ * Each group of lines is described by a blame_entry; it can be split
+ * as we pass blame to the parents.  They are arranged in linked lists
+ * kept as `suspects' of some unprocessed origin, or entered (when the
+ * blame origin has been finalized) into the scoreboard structure.
+ * While the scoreboard structure is only sorted at the end of
+ * processing (according to final image line number), the lists
+ * attached to an origin are sorted by the target line number.
+ */
+struct blame_entry {
+	struct blame_entry *next;
+
+	/* the first line of this group in the final image;
+	 * internally all line numbers are 0 based.
+	 */
+	int lno;
+
+	/* how many lines this group has */
+	int num_lines;
+
+	/* the commit that introduced this group into the final image */
+	struct blame_origin *suspect;
+
+	/* the line number of the first line of this group in the
+	 * suspect's file; internally all line numbers are 0 based.
+	 */
+	int s_lno;
+
+	/* how significant this entry is -- cached to avoid
+	 * scanning the lines over and over.
+	 */
+	unsigned score;
+};
+
+#endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index e30b3ef..caa5ee0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -28,6 +28,7 @@
 #include "line-log.h"
 #include "dir.h"
 #include "progress.h"
+#include "blame.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
 
@@ -84,50 +85,6 @@ static unsigned blame_copy_score;
 #define METAINFO_SHOWN		(1u<<12)
 #define MORE_THAN_ONE_PATH	(1u<<13)
 
-/*
- * One blob in a commit that is being suspected
- */
-struct origin {
-	int refcnt;
-	/* Record preceding blame record for this blob */
-	struct origin *previous;
-	/* origins are put in a list linked via `next' hanging off the
-	 * corresponding commit's util field in order to make finding
-	 * them fast.  The presence in this chain does not count
-	 * towards the origin's reference count.  It is tempting to
-	 * let it count as long as the commit is pending examination,
-	 * but even under circumstances where the commit will be
-	 * present multiple times in the priority queue of unexamined
-	 * commits, processing the first instance will not leave any
-	 * work requiring the origin data for the second instance.  An
-	 * interspersed commit changing that would have to be
-	 * preexisting with a different ancestry and with the same
-	 * commit date in order to wedge itself between two instances
-	 * of the same commit in the priority queue _and_ produce
-	 * blame entries relevant for it.  While we don't want to let
-	 * us get tripped up by this case, it certainly does not seem
-	 * worth optimizing for.
-	 */
-	struct origin *next;
-	struct commit *commit;
-	/* `suspects' contains blame entries that may be attributed to
-	 * this origin's commit or to parent commits.  When a commit
-	 * is being processed, all suspects will be moved, either by
-	 * assigning them to an origin in a different commit, or by
-	 * shipping them to the scoreboard's ent list because they
-	 * cannot be attributed to a different commit.
-	 */
-	struct blame_entry *suspects;
-	mmfile_t file;
-	struct object_id blob_oid;
-	unsigned mode;
-	/* guilty gets set when shipping any suspects to the final
-	 * blame list instead of other commits
-	 */
-	char guilty;
-	char path[FLEX_ARRAY];
-};
-
 struct progress_info {
 	struct progress *progress;
 	int blamed_lines;
@@ -151,7 +108,7 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
  * diff machinery
  */
 static void fill_origin_blob(struct diff_options *opt,
-			     struct origin *o, mmfile_t *file)
+			     struct blame_origin *o, mmfile_t *file)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
@@ -180,17 +137,17 @@ static void fill_origin_blob(struct diff_options *opt,
  * Origin is refcounted and usually we keep the blob contents to be
  * reused.
  */
-static inline struct origin *origin_incref(struct origin *o)
+static inline struct blame_origin *origin_incref(struct blame_origin *o)
 {
 	if (o)
 		o->refcnt++;
 	return o;
 }
 
-static void origin_decref(struct origin *o)
+static void origin_decref(struct blame_origin *o)
 {
 	if (o && --o->refcnt <= 0) {
-		struct origin *p, *l = NULL;
+		struct blame_origin *p, *l = NULL;
 		if (o->previous)
 			origin_decref(o->previous);
 		free(o->file.ptr);
@@ -209,7 +166,7 @@ static void origin_decref(struct origin *o)
 	}
 }
 
-static void drop_origin_blob(struct origin *o)
+static void drop_origin_blob(struct blame_origin *o)
 {
 	if (o->file.ptr) {
 		free(o->file.ptr);
@@ -218,40 +175,6 @@ static void drop_origin_blob(struct origin *o)
 }
 
 /*
- * Each group of lines is described by a blame_entry; it can be split
- * as we pass blame to the parents.  They are arranged in linked lists
- * kept as `suspects' of some unprocessed origin, or entered (when the
- * blame origin has been finalized) into the scoreboard structure.
- * While the scoreboard structure is only sorted at the end of
- * processing (according to final image line number), the lists
- * attached to an origin are sorted by the target line number.
- */
-struct blame_entry {
-	struct blame_entry *next;
-
-	/* the first line of this group in the final image;
-	 * internally all line numbers are 0 based.
-	 */
-	int lno;
-
-	/* how many lines this group has */
-	int num_lines;
-
-	/* the commit that introduced this group into the final image */
-	struct origin *suspect;
-
-	/* the line number of the first line of this group in the
-	 * suspect's file; internally all line numbers are 0 based.
-	 */
-	int s_lno;
-
-	/* how significant this entry is -- cached to avoid
-	 * scanning the lines over and over.
-	 */
-	unsigned score;
-};
-
-/*
  * Any merge of blames happens on lists of blames that arrived via
  * different parents in a single suspect.  In this case, we want to
  * sort according to the suspect line numbers as opposed to the final
@@ -410,13 +333,13 @@ static void coalesce(struct scoreboard *sb)
  * the commit priority queue of the score board.
  */
 
-static void queue_blames(struct scoreboard *sb, struct origin *porigin,
+static void queue_blames(struct scoreboard *sb, struct blame_origin *porigin,
 			 struct blame_entry *sorted)
 {
 	if (porigin->suspects)
 		porigin->suspects = blame_merge(porigin->suspects, sorted);
 	else {
-		struct origin *o;
+		struct blame_origin *o;
 		for (o = porigin->commit->util; o; o = o->next) {
 			if (o->suspects) {
 				porigin->suspects = sorted;
@@ -434,9 +357,9 @@ static void queue_blames(struct scoreboard *sb, struct origin *porigin,
  * get_origin() to obtain shared, refcounted copy instead of calling
  * this function directly.
  */
-static struct origin *make_origin(struct commit *commit, const char *path)
+static struct blame_origin *make_origin(struct commit *commit, const char *path)
 {
-	struct origin *o;
+	struct blame_origin *o;
 	FLEX_ALLOC_STR(o, path, path);
 	o->commit = commit;
 	o->refcnt = 1;
@@ -449,9 +372,9 @@ static struct origin *make_origin(struct commit *commit, const char *path)
  * Locate an existing origin or create a new one.
  * This moves the origin to front position in the commit util list.
  */
-static struct origin *get_origin(struct commit *commit, const char *path)
+static struct blame_origin *get_origin(struct commit *commit, const char *path)
 {
-	struct origin *o, *l;
+	struct blame_origin *o, *l;
 
 	for (o = commit->util, l = NULL; o; l = o, o = o->next) {
 		if (!strcmp(o->path, path)) {
@@ -476,7 +399,7 @@ static struct origin *get_origin(struct commit *commit, const char *path)
  *
  * This also fills origin->mode for corresponding tree path.
  */
-static int fill_blob_sha1_and_mode(struct origin *origin)
+static int fill_blob_sha1_and_mode(struct blame_origin *origin)
 {
 	if (!is_null_oid(&origin->blob_oid))
 		return 0;
@@ -497,10 +420,10 @@ static int fill_blob_sha1_and_mode(struct origin *origin)
  * We have an origin -- check if the same path exists in the
  * parent and return an origin structure to represent it.
  */
-static struct origin *find_origin(struct commit *parent,
-				  struct origin *origin)
+static struct blame_origin *find_origin(struct commit *parent,
+				  struct blame_origin *origin)
 {
-	struct origin *porigin;
+	struct blame_origin *porigin;
 	struct diff_options diff_opts;
 	const char *paths[2];
 
@@ -585,10 +508,10 @@ static struct origin *find_origin(struct commit *parent,
  * We have an origin -- find the path that corresponds to it in its
  * parent and return an origin structure to represent it.
  */
-static struct origin *find_rename(struct commit *parent,
-				  struct origin *origin)
+static struct blame_origin *find_rename(struct commit *parent,
+				  struct blame_origin *origin)
 {
-	struct origin *porigin = NULL;
+	struct blame_origin *porigin = NULL;
 	struct diff_options diff_opts;
 	int i;
 
@@ -680,7 +603,7 @@ static const char *nth_line_cb(void *data, long lno)
 static void split_overlap(struct blame_entry *split,
 			  struct blame_entry *e,
 			  int tlno, int plno, int same,
-			  struct origin *parent)
+			  struct blame_origin *parent)
 {
 	int chunk_end_lno;
 	memset(split, 0, sizeof(struct blame_entry [3]));
@@ -804,7 +727,7 @@ static struct blame_entry *reverse_blame(struct blame_entry *head,
  */
 static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			int tlno, int offset, int same,
-			struct origin *parent)
+			struct blame_origin *parent)
 {
 	struct blame_entry *e = **srcq;
 	struct blame_entry *samep = NULL, *diffp = NULL;
@@ -895,7 +818,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 }
 
 struct blame_chunk_cb_data {
-	struct origin *parent;
+	struct blame_origin *parent;
 	long offset;
 	struct blame_entry **dstq;
 	struct blame_entry **srcq;
@@ -920,8 +843,8 @@ static int blame_chunk_cb(long start_a, long count_a,
  * which lines came from parent and pass blame for them.
  */
 static void pass_blame_to_parent(struct scoreboard *sb,
-				 struct origin *target,
-				 struct origin *parent)
+				 struct blame_origin *target,
+				 struct blame_origin *parent)
 {
 	mmfile_t file_p, file_o;
 	struct blame_chunk_cb_data d;
@@ -1023,7 +946,7 @@ static void copy_split_if_better(struct scoreboard *sb,
 static void handle_split(struct scoreboard *sb,
 			 struct blame_entry *ent,
 			 int tlno, int plno, int same,
-			 struct origin *parent,
+			 struct blame_origin *parent,
 			 struct blame_entry *split)
 {
 	if (ent->num_lines <= tlno)
@@ -1041,7 +964,7 @@ static void handle_split(struct scoreboard *sb,
 struct handle_split_cb_data {
 	struct scoreboard *sb;
 	struct blame_entry *ent;
-	struct origin *parent;
+	struct blame_origin *parent;
 	struct blame_entry *split;
 	long plno;
 	long tlno;
@@ -1065,7 +988,7 @@ static int handle_split_cb(long start_a, long count_a,
  */
 static void find_copy_in_blob(struct scoreboard *sb,
 			      struct blame_entry *ent,
-			      struct origin *parent,
+			      struct blame_origin *parent,
 			      struct blame_entry *split,
 			      mmfile_t *file_p)
 {
@@ -1129,8 +1052,8 @@ static struct blame_entry **filter_small(struct scoreboard *sb,
 static void find_move_in_parent(struct scoreboard *sb,
 				struct blame_entry ***blamed,
 				struct blame_entry **toosmall,
-				struct origin *target,
-				struct origin *parent)
+				struct blame_origin *target,
+				struct blame_origin *parent)
 {
 	struct blame_entry *e, split[3];
 	struct blame_entry *unblamed = target->suspects;
@@ -1205,9 +1128,9 @@ static struct blame_list *setup_blame_list(struct blame_entry *unblamed,
 static void find_copy_in_parent(struct scoreboard *sb,
 				struct blame_entry ***blamed,
 				struct blame_entry **toosmall,
-				struct origin *target,
+				struct blame_origin *target,
 				struct commit *parent,
-				struct origin *porigin,
+				struct blame_origin *porigin,
 				int opt)
 {
 	struct diff_options diff_opts;
@@ -1254,7 +1177,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 
 		for (i = 0; i < diff_queued_diff.nr; i++) {
 			struct diff_filepair *p = diff_queued_diff.queue[i];
-			struct origin *norigin;
+			struct blame_origin *norigin;
 			mmfile_t file_p;
 			struct blame_entry this[3];
 
@@ -1309,7 +1232,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
  * origin is suspected for can be blamed on the parent.
  */
 static void pass_whole_blame(struct scoreboard *sb,
-			     struct origin *origin, struct origin *porigin)
+			     struct blame_origin *origin, struct blame_origin *porigin)
 {
 	struct blame_entry *e, *suspects;
 
@@ -1361,7 +1284,7 @@ static void distribute_blame(struct scoreboard *sb, struct blame_entry *blamed)
 	blamed = blame_sort(blamed, compare_blame_suspect);
 	while (blamed)
 	{
-		struct origin *porigin = blamed->suspect;
+		struct blame_origin *porigin = blamed->suspect;
 		struct blame_entry *suspects = NULL;
 		do {
 			struct blame_entry *next = blamed->next;
@@ -1376,14 +1299,14 @@ static void distribute_blame(struct scoreboard *sb, struct blame_entry *blamed)
 
 #define MAXSG 16
 
-static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
+static void pass_blame(struct scoreboard *sb, struct blame_origin *origin, int opt)
 {
 	struct rev_info *revs = sb->revs;
 	int i, pass, num_sg;
 	struct commit *commit = origin->commit;
 	struct commit_list *sg;
-	struct origin *sg_buf[MAXSG];
-	struct origin *porigin, **sg_origin = sg_buf;
+	struct blame_origin *sg_buf[MAXSG];
+	struct blame_origin *porigin, **sg_origin = sg_buf;
 	struct blame_entry *toosmall = NULL;
 	struct blame_entry *blames, **blametail = &blames;
 
@@ -1400,7 +1323,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * common cases, then we look for renames in the second pass.
 	 */
 	for (pass = 0; pass < 2 - no_whole_file_rename; pass++) {
-		struct origin *(*find)(struct commit *, struct origin *);
+		struct blame_origin *(*find)(struct commit *, struct blame_origin *);
 		find = pass ? find_rename : find_origin;
 
 		for (i = 0, sg = first_scapegoat(revs, commit);
@@ -1438,7 +1361,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	for (i = 0, sg = first_scapegoat(revs, commit);
 	     i < num_sg && sg;
 	     sg = sg->next, i++) {
-		struct origin *porigin = sg_origin[i];
+		struct blame_origin *porigin = sg_origin[i];
 		if (!porigin)
 			continue;
 		if (!origin->previous) {
@@ -1459,7 +1382,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 			for (i = 0, sg = first_scapegoat(revs, commit);
 			     i < num_sg && sg;
 			     sg = sg->next, i++) {
-				struct origin *porigin = sg_origin[i];
+				struct blame_origin *porigin = sg_origin[i];
 				if (!porigin)
 					continue;
 				find_move_in_parent(sb, &blametail, &toosmall, origin, porigin);
@@ -1486,7 +1409,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 		for (i = 0, sg = first_scapegoat(revs, commit);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
-			struct origin *porigin = sg_origin[i];
+			struct blame_origin *porigin = sg_origin[i];
 			find_copy_in_parent(sb, &blametail, &toosmall,
 					    origin, sg->item, porigin, opt);
 			if (!origin->suspects)
@@ -1665,10 +1588,10 @@ static void get_commit_info(struct commit *commit,
  * To allow LF and other nonportable characters in pathnames,
  * they are c-style quoted as needed.
  */
-static void write_filename_info(struct origin *suspect)
+static void write_filename_info(struct blame_origin *suspect)
 {
 	if (suspect->previous) {
-		struct origin *prev = suspect->previous;
+		struct blame_origin *prev = suspect->previous;
 		printf("previous %s ", oid_to_hex(&prev->commit->object.oid));
 		write_name_quoted(prev->path, stdout, '\n');
 	}
@@ -1682,7 +1605,7 @@ static void write_filename_info(struct origin *suspect)
  * the first time each commit appears in the output (unless the
  * user has specifically asked for us to repeat).
  */
-static int emit_one_suspect_detail(struct origin *suspect, int repeat)
+static int emit_one_suspect_detail(struct blame_origin *suspect, int repeat)
 {
 	struct commit_info ci;
 
@@ -1716,7 +1639,7 @@ static void found_guilty_entry(struct blame_entry *ent,
 			   struct progress_info *pi)
 {
 	if (incremental) {
-		struct origin *suspect = ent->suspect;
+		struct blame_origin *suspect = ent->suspect;
 
 		printf("%s %d %d %d\n",
 		       oid_to_hex(&suspect->commit->object.oid),
@@ -1745,7 +1668,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 
 	while (commit) {
 		struct blame_entry *ent;
-		struct origin *suspect = commit->util;
+		struct blame_origin *suspect = commit->util;
 
 		/* find one suspect to break down */
 		while (suspect && !suspect->suspects)
@@ -1842,7 +1765,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 #define OUTPUT_SHOW_EMAIL	0400
 #define OUTPUT_LINE_PORCELAIN 01000
 
-static void emit_porcelain_details(struct origin *suspect, int repeat)
+static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 {
 	if (emit_one_suspect_detail(suspect, repeat) ||
 	    (suspect->commit->object.flags & MORE_THAN_ONE_PATH))
@@ -1855,7 +1778,7 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 	int repeat = opt & OUTPUT_LINE_PORCELAIN;
 	int cnt;
 	const char *cp;
-	struct origin *suspect = ent->suspect;
+	struct blame_origin *suspect = ent->suspect;
 	char hex[GIT_MAX_HEXSZ + 1];
 
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
@@ -1892,7 +1815,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 {
 	int cnt;
 	const char *cp;
-	struct origin *suspect = ent->suspect;
+	struct blame_origin *suspect = ent->suspect;
 	struct commit_info ci;
 	char hex[GIT_MAX_HEXSZ + 1];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
@@ -1974,7 +1897,7 @@ static void output(struct scoreboard *sb, int option)
 	if (option & OUTPUT_PORCELAIN) {
 		for (ent = sb->ent; ent; ent = ent->next) {
 			int count = 0;
-			struct origin *suspect;
+			struct blame_origin *suspect;
 			struct commit *commit = ent->suspect->commit;
 			if (commit->object.flags & MORE_THAN_ONE_PATH)
 				continue;
@@ -2052,7 +1975,7 @@ static int read_ancestry(const char *graft_file)
 	return 0;
 }
 
-static int update_auto_abbrev(int auto_abbrev, struct origin *suspect)
+static int update_auto_abbrev(int auto_abbrev, struct blame_origin *suspect)
 {
 	const char *uniq = find_unique_abbrev(suspect->commit->object.oid.hash,
 					      auto_abbrev);
@@ -2076,7 +1999,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
 	int auto_abbrev = DEFAULT_ABBREV;
 
 	for (e = sb->ent; e; e = e->next) {
-		struct origin *suspect = e->suspect;
+		struct blame_origin *suspect = e->suspect;
 		int num;
 
 		if (compute_auto_abbrev)
@@ -2268,7 +2191,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 					       const char *contents_from)
 {
 	struct commit *commit;
-	struct origin *origin;
+	struct blame_origin *origin;
 	struct commit_list **parent_tail, *parent;
 	struct object_id head_oid;
 	struct strbuf buf = STRBUF_INIT;
@@ -2523,7 +2446,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct rev_info revs;
 	const char *path;
 	struct scoreboard sb;
-	struct origin *o;
+	struct blame_origin *o;
 	struct blame_entry *ent = NULL;
 	long dashdash_pos, lno;
 	char *final_commit_name = NULL;
-- 
2.9.3

