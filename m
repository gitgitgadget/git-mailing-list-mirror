Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF8A1F403
	for <e@80x24.org>; Sun, 10 Jun 2018 04:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753701AbeFJEQ0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 00:16:26 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:54352 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753658AbeFJEQY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 00:16:24 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5A4Dw24011530;
        Sat, 9 Jun 2018 21:16:19 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jgcrk97j0-1;
        Sat, 09 Jun 2018 21:16:18 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 69296220D188;
        Sat,  9 Jun 2018 21:16:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 61F7D2CDE75;
        Sat,  9 Jun 2018 21:16:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 2/6] merge-recursive: fix numerous argument alignment issues
Date:   Sat,  9 Jun 2018 21:16:12 -0700
Message-Id: <20180610041616.4448-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.6.gffeb3ef585
In-Reply-To: <20180610041616.4448-1-newren@gmail.com>
References: <20180522004327.13085-1-newren@gmail.com>
 <20180610041616.4448-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806100048
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various refactorings throughout the code have left lots of alignment
issues that were driving me crazy; fix them.

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 75 ++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 921f8e2d2d..09c249b93e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -309,8 +309,8 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 }
 
 static int add_cacheinfo(struct merge_options *o,
-		unsigned int mode, const struct object_id *oid,
-		const char *path, int stage, int refresh, int options)
+			 unsigned int mode, const struct object_id *oid,
+			 const char *path, int stage, int refresh, int options)
 {
 	struct cache_entry *ce;
 	int ret;
@@ -417,8 +417,8 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 }
 
 static int save_files_dirs(const struct object_id *oid,
-		struct strbuf *base, const char *path,
-		unsigned int mode, int stage, void *context)
+			   struct strbuf *base, const char *path,
+			   unsigned int mode, int stage, void *context)
 {
 	struct path_hashmap_entry *entry;
 	int baselen = base->len;
@@ -913,7 +913,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	 */
 	if (would_lose_untracked(path))
 		return err(o, _("refusing to lose untracked file at '%s'"),
-			     path);
+			   path);
 
 	/* Successful unlink is good.. */
 	if (!unlink(path))
@@ -992,7 +992,7 @@ static int update_file_flags(struct merge_options *o,
 			unlink(path);
 			if (symlink(lnk, path))
 				ret = err(o, _("failed to symlink '%s': %s"),
-					path, strerror(errno));
+					  path, strerror(errno));
 			free(lnk);
 		} else
 			ret = err(o,
@@ -1090,7 +1090,7 @@ static int merge_3way(struct merge_options *o,
 }
 
 static int find_first_merges(struct object_array *result, const char *path,
-		struct commit *a, struct commit *b)
+			     struct commit *a, struct commit *b)
 {
 	int i, j;
 	struct object_array merges = OBJECT_ARRAY_INIT;
@@ -1108,7 +1108,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 
 	/* get all revisions that merge commit a */
 	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
-			oid_to_hex(&a->object.oid));
+		  oid_to_hex(&a->object.oid));
 	init_revisions(&revs, NULL);
 	rev_opts.submodule = path;
 	/* FIXME: can't handle linked worktrees in submodules yet */
@@ -1250,12 +1250,12 @@ static int merge_submodule(struct merge_options *o,
 		output(o, 2, _("Found a possible merge resolution for the submodule:\n"));
 		print_commit((struct commit *) merges.objects[0].item);
 		output(o, 2, _(
-			"If this is correct simply add it to the index "
-			"for example\n"
-			"by using:\n\n"
-			"  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
-			"which will accept this suggestion.\n"),
-			oid_to_hex(&merges.objects[0].item->oid), path);
+		       "If this is correct simply add it to the index "
+		       "for example\n"
+		       "by using:\n\n"
+		       "  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
+		       "which will accept this suggestion.\n"),
+		       oid_to_hex(&merges.objects[0].item->oid), path);
 		break;
 
 	default:
@@ -1332,10 +1332,10 @@ static int merge_file_1(struct merge_options *o,
 			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
 			result->clean = merge_submodule(o, &result->oid,
-						       one->path,
-						       &one->oid,
-						       &a->oid,
-						       &b->oid);
+							one->path,
+							&one->oid,
+							&a->oid,
+							&b->oid);
 		} else if (S_ISLNK(a->mode)) {
 			switch (o->recursive_variant) {
 			case MERGE_RECURSIVE_NORMAL:
@@ -1443,13 +1443,13 @@ static int conflict_rename_dir(struct merge_options *o,
 }
 
 static int handle_change_delete(struct merge_options *o,
-				 const char *path, const char *old_path,
-				 const struct object_id *o_oid, int o_mode,
-				 const struct object_id *changed_oid,
-				 int changed_mode,
-				 const char *change_branch,
-				 const char *delete_branch,
-				 const char *change, const char *change_past)
+				const char *path, const char *old_path,
+				const struct object_id *o_oid, int o_mode,
+				const struct object_id *changed_oid,
+				int changed_mode,
+				const char *change_branch,
+				const char *delete_branch,
+				const char *change, const char *change_past)
 {
 	char *alt_path = NULL;
 	const char *update_path = path;
@@ -1510,9 +1510,9 @@ static int handle_change_delete(struct merge_options *o,
 }
 
 static int conflict_rename_delete(struct merge_options *o,
-				   struct diff_filepair *pair,
-				   const char *rename_branch,
-				   const char *delete_branch)
+				  struct diff_filepair *pair,
+				  const char *rename_branch,
+				  const char *delete_branch)
 {
 	const struct diff_filespec *orig = pair->one;
 	const struct diff_filespec *dest = pair->two;
@@ -1615,7 +1615,7 @@ static int handle_file(struct merge_options *o,
 }
 
 static int conflict_rename_rename_1to2(struct merge_options *o,
-					struct rename_conflict_info *ci)
+				       struct rename_conflict_info *ci)
 {
 	/* One file was renamed in both branches, but to different names. */
 	struct diff_filespec *one = ci->pair1->one;
@@ -1677,7 +1677,7 @@ static int conflict_rename_rename_1to2(struct merge_options *o,
 }
 
 static int conflict_rename_rename_2to1(struct merge_options *o,
-					struct rename_conflict_info *ci)
+				       struct rename_conflict_info *ci)
 {
 	/* Two files, a & b, were renamed to the same thing, c. */
 	struct diff_filespec *a = ci->pair1->one;
@@ -2904,7 +2904,8 @@ static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
 }
 
 static int read_oid_strbuf(struct merge_options *o,
-	const struct object_id *oid, struct strbuf *dst)
+			   const struct object_id *oid,
+			   struct strbuf *dst)
 {
 	void *buf;
 	enum object_type type;
@@ -2957,10 +2958,10 @@ static int blob_unchanged(struct merge_options *opt,
 }
 
 static int handle_modify_delete(struct merge_options *o,
-				 const char *path,
-				 struct object_id *o_oid, int o_mode,
-				 struct object_id *a_oid, int a_mode,
-				 struct object_id *b_oid, int b_mode)
+				const char *path,
+				struct object_id *o_oid, int o_mode,
+				struct object_id *a_oid, int a_mode,
+				struct object_id *b_oid, int b_mode)
 {
 	const char *modify_branch, *delete_branch;
 	struct object_id *changed_oid;
@@ -3493,14 +3494,14 @@ int merge_recursive_generic(struct merge_options *o,
 			struct commit *base;
 			if (!(base = get_ref(base_list[i], oid_to_hex(base_list[i]))))
 				return err(o, _("Could not parse object '%s'"),
-					oid_to_hex(base_list[i]));
+					   oid_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
 		}
 	}
 
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
-			result);
+				result);
 	if (clean < 0) {
 		rollback_lock_file(&lock);
 		return clean;
-- 
2.18.0.rc1.6.gffeb3ef585

