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
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F0E20248
	for <e@80x24.org>; Fri,  5 Apr 2019 15:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbfDEPA7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 11:00:59 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40158 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731020AbfDEPA6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Apr 2019 11:00:58 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35EwSnt001751;
        Fri, 5 Apr 2019 08:00:43 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rmg324g4c-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 05 Apr 2019 08:00:43 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 5 Apr 2019 08:00:39 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 5 Apr 2019 08:00:39 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 3FE47220CB28;
        Fri,  5 Apr 2019 08:00:39 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 05/15] merge-recursive: use 'ci' for rename_conflict_info variable name
Date:   Fri, 5 Apr 2019 08:00:16 -0700
Message-ID: <20190405150026.5260-6-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.211.g719c25afaf.dirty
In-Reply-To: <20190405150026.5260-1-newren@gmail.com>
References: <20190330003336.21940-1-newren@gmail.com>
 <20190405150026.5260-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904050102
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We used a couple different names, but used 'ci' the most.  Use the same
variable name throughout for a little extra consistency.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4ed1b48630..ea5646debd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3098,7 +3098,7 @@ static int handle_content_merge(struct merge_options *opt,
 				struct object_id *o_oid, int o_mode,
 				struct object_id *a_oid, int a_mode,
 				struct object_id *b_oid, int b_mode,
-				struct rename_conflict_info *rename_conflict_info)
+				struct rename_conflict_info *ci)
 {
 	const char *reason = _("content");
 	const char *path1 = NULL, *path2 = NULL;
@@ -3118,17 +3118,17 @@ static int handle_content_merge(struct merge_options *opt,
 	oidcpy(&b.oid, b_oid);
 	b.mode = b_mode;
 
-	if (rename_conflict_info) {
-		struct diff_filepair *pair1 = rename_conflict_info->pair1;
+	if (ci) {
+		struct diff_filepair *pair1 = ci->pair1;
 
-		path1 = (opt->branch1 == rename_conflict_info->branch1) ?
+		path1 = (opt->branch1 == ci->branch1) ?
 			pair1->two->path : pair1->one->path;
-		/* If rename_conflict_info->pair2 != NULL, we are in
+		/* If ci->pair2 != NULL, we are in
 		 * RENAME_ONE_FILE_TO_ONE case.  Otherwise, we have a
 		 * normal rename.
 		 */
-		path2 = (rename_conflict_info->pair2 ||
-			 opt->branch2 == rename_conflict_info->branch1) ?
+		path2 = (ci->pair2 ||
+			 opt->branch2 == ci->branch1) ?
 			pair1->two->path : pair1->one->path;
 		one.path = pair1->one->path;
 		a.path = (char *)path1;
@@ -3180,7 +3180,7 @@ static int handle_content_merge(struct merge_options *opt,
 			reason = _("submodule");
 		output(opt, 1, _("CONFLICT (%s): Merge conflict in %s"),
 				reason, path);
-		if (rename_conflict_info && !df_conflict_remains)
+		if (ci && !df_conflict_remains)
 			if (update_stages(opt, path, &one, &a, &b))
 				return -1;
 	}
@@ -3206,7 +3206,7 @@ static int handle_content_merge(struct merge_options *opt,
 			}
 
 		}
-		new_path = unique_path(opt, path, rename_conflict_info->branch1);
+		new_path = unique_path(opt, path, ci->branch1);
 		if (is_dirty) {
 			output(opt, 1, _("Refusing to lose dirty file at %s"),
 			       path);
@@ -3251,8 +3251,8 @@ static int process_entry(struct merge_options *opt,
 
 	entry->processed = 1;
 	if (entry->rename_conflict_info) {
-		struct rename_conflict_info *conflict_info = entry->rename_conflict_info;
-		switch (conflict_info->rename_type) {
+		struct rename_conflict_info *ci = entry->rename_conflict_info;
+		switch (ci->rename_type) {
 		case RENAME_NORMAL:
 		case RENAME_ONE_FILE_TO_ONE:
 			clean_merge = handle_rename_normal(opt,
@@ -3260,13 +3260,11 @@ static int process_entry(struct merge_options *opt,
 							   o_oid, o_mode,
 							   a_oid, a_mode,
 							   b_oid, b_mode,
-							   conflict_info);
+							   ci);
 			break;
 		case RENAME_VIA_DIR:
 			clean_merge = 1;
-			if (handle_rename_via_dir(opt,
-						  conflict_info->pair1,
-						  conflict_info->branch1))
+			if (handle_rename_via_dir(opt, ci->pair1, ci->branch1))
 				clean_merge = -1;
 			break;
 		case RENAME_ADD:
@@ -3276,19 +3274,17 @@ static int process_entry(struct merge_options *opt,
 			 * two-way merged cleanly with the added file, I
 			 * guess it's a clean merge?
 			 */
-			clean_merge = handle_rename_add(opt, conflict_info);
+			clean_merge = handle_rename_add(opt, ci);
 			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
-			if (handle_rename_delete(opt,
-						 conflict_info->pair1,
-						 conflict_info->branch1,
-						 conflict_info->branch2))
+			if (handle_rename_delete(opt, ci->pair1,
+						 ci->branch1, ci->branch2))
 				clean_merge = -1;
 			break;
 		case RENAME_ONE_FILE_TO_TWO:
 			clean_merge = 0;
-			if (handle_rename_rename_1to2(opt, conflict_info))
+			if (handle_rename_rename_1to2(opt, ci))
 				clean_merge = -1;
 			break;
 		case RENAME_TWO_FILES_TO_ONE:
@@ -3298,8 +3294,7 @@ static int process_entry(struct merge_options *opt,
 			 * can then be two-way merged cleanly, I guess it's
 			 * a clean merge?
 			 */
-			clean_merge = handle_rename_rename_2to1(opt,
-								conflict_info);
+			clean_merge = handle_rename_rename_2to1(opt, ci);
 			break;
 		default:
 			entry->processed = 0;
-- 
2.21.0.211.g719c25afaf.dirty

