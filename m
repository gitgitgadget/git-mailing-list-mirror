Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903A820248
	for <e@80x24.org>; Sat, 30 Mar 2019 00:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfC3AeR (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 20:34:17 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36372 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730162AbfC3AeR (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Mar 2019 20:34:17 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2U0XVDn015420;
        Fri, 29 Mar 2019 17:34:00 -0700
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rht7wrark-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 29 Mar 2019 17:34:00 -0700
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Mar 2019 20:33:56 -0400
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 29 Mar 2019 20:33:56 -0400
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id AE1C6220CB1F;
        Fri, 29 Mar 2019 17:33:55 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 01/15] Use 'unsigned short' for mode, like diff_filespec does
Date:   Fri, 29 Mar 2019 17:33:22 -0700
Message-ID: <20190330003336.21940-2-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.211.g078f4bef79.dirty
In-Reply-To: <20190330003336.21940-1-newren@gmail.com>
References: <20190306002744.14418-1-newren@gmail.com>
 <20190330003336.21940-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903300002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct diff_filespec defines mode to be an 'unsigned short'.  Several
other places in the API which we'd like to interact with using a
diff_filespec used a plain unsigned (or unsigned int).  This caused
problems when taking addresses, so switch to unsigned short.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 archive.c              | 2 +-
 blame.c                | 2 +-
 blame.h                | 2 +-
 builtin/rm.c           | 2 +-
 builtin/update-index.c | 2 +-
 cache.h                | 2 +-
 fsck.c                 | 2 +-
 line-log.c             | 2 +-
 match-trees.c          | 8 ++++----
 merge-recursive.c      | 6 +++---
 notes.c                | 2 +-
 sha1-name.c            | 2 +-
 tree-diff.c            | 2 +-
 tree-walk.c            | 6 +++---
 tree-walk.h            | 6 +++---
 15 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/archive.c b/archive.c
index 1f98324a93..92bc001545 100644
--- a/archive.c
+++ b/archive.c
@@ -415,7 +415,7 @@ static void parse_treeish_arg(const char **argv,
 
 	if (prefix) {
 		struct object_id tree_oid;
-		unsigned int mode;
+		unsigned short mode;
 		int err;
 
 		err = get_tree_entry(&tree->object.oid, prefix, &tree_oid,
diff --git a/blame.c b/blame.c
index 5c07dec190..326231476e 100644
--- a/blame.c
+++ b/blame.c
@@ -99,7 +99,7 @@ static void verify_working_tree_path(struct repository *r,
 	for (parents = work_tree->parents; parents; parents = parents->next) {
 		const struct object_id *commit_oid = &parents->item->object.oid;
 		struct object_id blob_oid;
-		unsigned mode;
+		unsigned short mode;
 
 		if (!get_tree_entry(commit_oid, path, &blob_oid, &mode) &&
 		    oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
diff --git a/blame.h b/blame.h
index be3a895043..2a285eb027 100644
--- a/blame.h
+++ b/blame.h
@@ -52,7 +52,7 @@ struct blame_origin {
 	struct blame_entry *suspects;
 	mmfile_t file;
 	struct object_id blob_oid;
-	unsigned mode;
+	unsigned short mode;
 	/* guilty gets set when shipping any suspects to the final
 	 * blame list instead of other commits
 	 */
diff --git a/builtin/rm.c b/builtin/rm.c
index db85b33982..90cbe896c9 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -110,7 +110,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 		const struct cache_entry *ce;
 		const char *name = list.entry[i].name;
 		struct object_id oid;
-		unsigned mode;
+		unsigned short mode;
 		int local_changes = 0;
 		int staged_changes = 0;
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1b6c42f748..0baf51c316 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -597,7 +597,7 @@ static struct cache_entry *read_one_ent(const char *which,
 					struct object_id *ent, const char *path,
 					int namelen, int stage)
 {
-	unsigned mode;
+	unsigned short mode;
 	struct object_id oid;
 	struct cache_entry *ce;
 
diff --git a/cache.h b/cache.h
index ac92421f3a..851c3e6945 100644
--- a/cache.h
+++ b/cache.h
@@ -1331,7 +1331,7 @@ static inline int hex2chr(const char *s)
 #define FALLBACK_DEFAULT_ABBREV 7
 
 struct object_context {
-	unsigned mode;
+	unsigned short mode;
 	/*
 	 * symlink_path is only used by get_tree_entry_follow_symlinks,
 	 * and only for symlinks that point outside the repository.
diff --git a/fsck.c b/fsck.c
index 2260adb71e..4703f55561 100644
--- a/fsck.c
+++ b/fsck.c
@@ -604,7 +604,7 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
 	o_name = NULL;
 
 	while (desc.size) {
-		unsigned mode;
+		unsigned short mode;
 		const char *name;
 		const struct object_id *oid;
 
diff --git a/line-log.c b/line-log.c
index 24e21731c4..f743592bc0 100644
--- a/line-log.c
+++ b/line-log.c
@@ -498,7 +498,7 @@ static struct commit *check_single_commit(struct rev_info *revs)
 
 static void fill_blob_sha1(struct commit *commit, struct diff_filespec *spec)
 {
-	unsigned mode;
+	unsigned short mode;
 	struct object_id oid;
 
 	if (get_tree_entry(&commit->object.oid, spec->path, &oid, &mode))
diff --git a/match-trees.c b/match-trees.c
index ddc4d39845..9d1ec8d6b0 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -140,7 +140,7 @@ static void match_trees(const struct object_id *hash1,
 	while (one.size) {
 		const char *path;
 		const struct object_id *elem;
-		unsigned mode;
+		unsigned short mode;
 		int score;
 
 		elem = tree_entry_extract(&one, &path, &mode);
@@ -196,7 +196,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	rewrite_here = NULL;
 	while (desc.size) {
 		const char *name;
-		unsigned mode;
+		unsigned short mode;
 
 		tree_entry_extract(&desc, &name, &mode);
 		if (strlen(name) == toplen &&
@@ -285,7 +285,7 @@ void shift_tree(const struct object_id *hash1,
 
 	if (add_score < del_score) {
 		/* We need to pick a subtree of two */
-		unsigned mode;
+		unsigned short mode;
 
 		if (!*del_prefix)
 			return;
@@ -313,7 +313,7 @@ void shift_tree_by(const struct object_id *hash1,
 		   const char *shift_prefix)
 {
 	struct object_id sub1, sub2;
-	unsigned mode1, mode2;
+	unsigned short mode1, mode2;
 	unsigned candidate = 0;
 
 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
diff --git a/merge-recursive.c b/merge-recursive.c
index 6c40c61c47..fcf37be2a7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -214,7 +214,7 @@ struct rename_conflict_info {
  */
 struct stage_data {
 	struct {
-		unsigned mode;
+		unsigned short mode;
 		struct object_id oid;
 	} stages[4];
 	struct rename_conflict_info *rename_conflict_info;
@@ -482,7 +482,7 @@ static void get_files_dirs(struct merge_options *o, struct tree *tree)
 static int get_tree_entry_if_blob(const struct object_id *tree,
 				  const char *path,
 				  struct object_id *hashy,
-				  unsigned int *mode_o)
+				  unsigned short *mode_o)
 {
 	int ret;
 
@@ -1935,7 +1935,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 static int tree_has_path(struct tree *tree, const char *path)
 {
 	struct object_id hashy;
-	unsigned int mode_o;
+	unsigned short mode_o;
 
 	return !get_tree_entry(&tree->object.oid, path,
 			       &hashy, &mode_o);
diff --git a/notes.c b/notes.c
index 7f7cc4d511..ba4cae7851 100644
--- a/notes.c
+++ b/notes.c
@@ -986,7 +986,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 		combine_notes_fn combine_notes, int flags)
 {
 	struct object_id oid, object_oid;
-	unsigned mode;
+	unsigned short mode;
 	struct leaf_node root_tree;
 
 	if (!t)
diff --git a/sha1-name.c b/sha1-name.c
index 6dda2c16df..d4b3d01f3c 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1577,7 +1577,7 @@ static void diagnose_invalid_oid_path(const char *prefix,
 				      int object_name_len)
 {
 	struct object_id oid;
-	unsigned mode;
+	unsigned short mode;
 
 	if (!prefix)
 		prefix = "";
diff --git a/tree-diff.c b/tree-diff.c
index e6d306f69f..f1f641eb6a 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -181,7 +181,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 	struct tree_desc *t, struct tree_desc *tp,
 	int imin)
 {
-	unsigned mode;
+	unsigned short mode;
 	const char *path;
 	const struct object_id *oid;
 	int pathlen;
diff --git a/tree-walk.c b/tree-walk.c
index 1e4bbc8a0e..ec32a47b2e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -500,7 +500,7 @@ struct dir_state {
 	struct object_id oid;
 };
 
-static int find_tree_entry(struct tree_desc *t, const char *name, struct object_id *result, unsigned *mode)
+static int find_tree_entry(struct tree_desc *t, const char *name, struct object_id *result, unsigned short *mode)
 {
 	int namelen = strlen(name);
 	while (t->size) {
@@ -535,7 +535,7 @@ static int find_tree_entry(struct tree_desc *t, const char *name, struct object_
 	return -1;
 }
 
-int get_tree_entry(const struct object_id *tree_oid, const char *name, struct object_id *oid, unsigned *mode)
+int get_tree_entry(const struct object_id *tree_oid, const char *name, struct object_id *oid, unsigned short *mode)
 {
 	int retval;
 	void *tree;
@@ -585,7 +585,7 @@ int get_tree_entry(const struct object_id *tree_oid, const char *name, struct ob
  * See the code for enum get_oid_result for a description of
  * the return values.
  */
-enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned *mode)
+enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned short *mode)
 {
 	int retval = MISSING_OBJECT;
 	struct dir_state *parents = NULL;
diff --git a/tree-walk.h b/tree-walk.h
index 8225171866..3aa381b6a3 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -16,7 +16,7 @@ struct tree_desc {
 	unsigned int size;
 };
 
-static inline const struct object_id *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
+static inline const struct object_id *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned short *modep)
 {
 	*pathp = desc->entry.path;
 	*modep = desc->entry.mode;
@@ -51,7 +51,7 @@ struct traverse_info;
 typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
 int traverse_trees(struct index_state *istate, int n, struct tree_desc *t, struct traverse_info *info);
 
-enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned *mode);
+enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned short *mode);
 
 struct traverse_info {
 	const char *traverse_path;
@@ -66,7 +66,7 @@ struct traverse_info {
 	int show_all_errors;
 };
 
-int get_tree_entry(const struct object_id *, const char *, struct object_id *, unsigned *);
+int get_tree_entry(const struct object_id *, const char *, struct object_id *, unsigned short *);
 extern char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n);
 extern void setup_traverse_info(struct traverse_info *info, const char *base);
 
-- 
2.21.0.211.g078f4bef79.dirty

