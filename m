Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0BD520248
	for <e@80x24.org>; Sat, 30 Mar 2019 00:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfC3AeQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 20:34:16 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36366 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729982AbfC3AeQ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Mar 2019 20:34:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2U0XVDm015420;
        Fri, 29 Mar 2019 17:34:00 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rht7wrarh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 29 Mar 2019 17:34:00 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Mar 2019 17:33:58 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 29 Mar 2019 17:33:55 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id D93B3220CB27;
        Fri, 29 Mar 2019 17:33:55 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 03/15] merge-recursive: rename diff_filespec 'one' to 'o'
Date:   Fri, 29 Mar 2019 17:33:24 -0700
Message-ID: <20190330003336.21940-4-newren@gmail.com>
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

In the previous commit, we noted that several places throughout merge
recursive both had a reason to use 'o'; some for a merge_options struct,
and others for a diff_filespec struct.  Some places had both, forcing
one of the two to be renamed, though the choice was inconsistent.  Now
that the merge_options struct has been renamed to 'opt' everywhere, we
can replace the few places that used 'one' for the diff_filespec to 'o'.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 09b76d596e..36af5d9cc6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1050,7 +1050,7 @@ struct merge_file_info {
 
 static int merge_3way(struct merge_options *opt,
 		      mmbuffer_t *result_buf,
-		      const struct diff_filespec *one,
+		      const struct diff_filespec *o,
 		      const struct diff_filespec *a,
 		      const struct diff_filespec *b,
 		      const char *branch1,
@@ -1084,9 +1084,9 @@ static int merge_3way(struct merge_options *opt,
 	}
 
 	if (strcmp(a->path, b->path) ||
-	    (opt->ancestor != NULL && strcmp(a->path, one->path) != 0)) {
+	    (opt->ancestor != NULL && strcmp(a->path, o->path) != 0)) {
 		base_name = opt->ancestor == NULL ? NULL :
-			mkpathdup("%s:%s", opt->ancestor, one->path);
+			mkpathdup("%s:%s", opt->ancestor, o->path);
 		name1 = mkpathdup("%s:%s", branch1, a->path);
 		name2 = mkpathdup("%s:%s", branch2, b->path);
 	} else {
@@ -1096,7 +1096,7 @@ static int merge_3way(struct merge_options *opt,
 		name2 = mkpathdup("%s", branch2);
 	}
 
-	read_mmblob(&orig, &one->oid);
+	read_mmblob(&orig, &o->oid);
 	read_mmblob(&src1, &a->oid);
 	read_mmblob(&src2, &b->oid);
 
@@ -1295,7 +1295,7 @@ static int merge_submodule(struct merge_options *opt,
 }
 
 static int merge_mode_and_contents(struct merge_options *opt,
-				   const struct diff_filespec *one,
+				   const struct diff_filespec *o,
 				   const struct diff_filespec *a,
 				   const struct diff_filespec *b,
 				   const char *filename,
@@ -1310,7 +1310,7 @@ static int merge_mode_and_contents(struct merge_options *opt,
 		 * side of the conflict markers and the other branch on the
 		 * top.  Fix that.
 		 */
-		return merge_mode_and_contents(opt, one, b, a,
+		return merge_mode_and_contents(opt, o, b, a,
 					       filename,
 					       branch2, branch1,
 					       extra_marker_size, result);
@@ -1329,31 +1329,31 @@ static int merge_mode_and_contents(struct merge_options *opt,
 			oidcpy(&result->oid, &b->oid);
 		}
 	} else {
-		if (!oid_eq(&a->oid, &one->oid) && !oid_eq(&b->oid, &one->oid))
+		if (!oid_eq(&a->oid, &o->oid) && !oid_eq(&b->oid, &o->oid))
 			result->merge = 1;
 
 		/*
 		 * Merge modes
 		 */
-		if (a->mode == b->mode || a->mode == one->mode)
+		if (a->mode == b->mode || a->mode == o->mode)
 			result->mode = b->mode;
 		else {
 			result->mode = a->mode;
-			if (b->mode != one->mode) {
+			if (b->mode != o->mode) {
 				result->clean = 0;
 				result->merge = 1;
 			}
 		}
 
-		if (oid_eq(&a->oid, &b->oid) || oid_eq(&a->oid, &one->oid))
+		if (oid_eq(&a->oid, &b->oid) || oid_eq(&a->oid, &o->oid))
 			oidcpy(&result->oid, &b->oid);
-		else if (oid_eq(&b->oid, &one->oid))
+		else if (oid_eq(&b->oid, &o->oid))
 			oidcpy(&result->oid, &a->oid);
 		else if (S_ISREG(a->mode)) {
 			mmbuffer_t result_buf;
 			int ret = 0, merge_status;
 
-			merge_status = merge_3way(opt, &result_buf, one, a, b,
+			merge_status = merge_3way(opt, &result_buf, o, a, b,
 						  branch1, branch2,
 						  extra_marker_size);
 
@@ -1372,8 +1372,8 @@ static int merge_mode_and_contents(struct merge_options *opt,
 			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
 			result->clean = merge_submodule(opt, &result->oid,
-							one->path,
-							&one->oid,
+							o->path,
+							&o->oid,
 							&a->oid,
 							&b->oid);
 		} else if (S_ISLNK(a->mode)) {
@@ -1750,7 +1750,7 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 	struct merge_file_info mfi;
 	struct diff_filespec other;
 	struct diff_filespec *add;
-	struct diff_filespec *one = ci->pair1->one;
+	struct diff_filespec *o = ci->pair1->one;
 	struct diff_filespec *a = ci->pair1->two;
 	struct diff_filespec *b = ci->pair2->two;
 	char *path_desc;
@@ -1758,13 +1758,13 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 	output(opt, 1, _("CONFLICT (rename/rename): "
 	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
 	       "rename \"%s\"->\"%s\" in \"%s\"%s"),
-	       one->path, a->path, ci->branch1,
-	       one->path, b->path, ci->branch2,
+	       o->path, a->path, ci->branch1,
+	       o->path, b->path, ci->branch2,
 	       opt->call_depth ? _(" (left unresolved)") : "");
 
 	path_desc = xstrfmt("%s and %s, both renamed from %s",
-			    a->path, b->path, one->path);
-	if (merge_mode_and_contents(opt, one, a, b, path_desc,
+			    a->path, b->path, o->path);
+	if (merge_mode_and_contents(opt, o, a, b, path_desc,
 				    ci->branch1, ci->branch2,
 				    opt->call_depth * 2, &mfi))
 		return -1;
@@ -1777,7 +1777,7 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 		 * pathname and then either rename the add-source file to that
 		 * unique path, or use that unique path instead of src here.
 		 */
-		if (update_file(opt, 0, &mfi.oid, mfi.mode, one->path))
+		if (update_file(opt, 0, &mfi.oid, mfi.mode, o->path))
 			return -1;
 
 		/*
@@ -2863,10 +2863,10 @@ static int process_renames(struct merge_options *opt,
 			if (clean_merge < 0)
 				goto cleanup_and_return;
 			if (try_merge) {
-				struct diff_filespec *one, *a, *b;
+				struct diff_filespec *o, *a, *b;
 				src_other.path = (char *)ren1_src;
 
-				one = ren1->pair->one;
+				o = ren1->pair->one;
 				if (a_renames == renames1) {
 					a = ren1->pair->two;
 					b = &src_other;
@@ -2874,7 +2874,7 @@ static int process_renames(struct merge_options *opt,
 					b = ren1->pair->two;
 					a = &src_other;
 				}
-				update_entry(ren1->dst_entry, one, a, b);
+				update_entry(ren1->dst_entry, o, a, b);
 				setup_rename_conflict_info(RENAME_NORMAL,
 							   ren1->pair,
 							   NULL,
-- 
2.21.0.211.g078f4bef79.dirty

