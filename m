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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E50620248
	for <e@80x24.org>; Fri,  5 Apr 2019 15:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfDEPBB (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 11:01:01 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:45644 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731020AbfDEPBA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Apr 2019 11:01:00 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35EwPFL001918;
        Fri, 5 Apr 2019 08:00:42 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rmg26mf48-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 05 Apr 2019 08:00:41 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 5 Apr 2019 08:00:42 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 5 Apr 2019 08:00:39 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 449CD220CB29;
        Fri,  5 Apr 2019 08:00:39 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 06/15] merge-recursive: move some struct declarations together
Date:   Fri, 5 Apr 2019 08:00:17 -0700
Message-ID: <20190405150026.5260-7-newren@gmail.com>
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904050102
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These structs are related and reference each other, so move them
together to make it easier for folks to determine what they hold and
what their purpose is.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 78 +++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ea5646debd..c4a2ef2a37 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -196,18 +196,6 @@ enum rename_type {
 	RENAME_TWO_FILES_TO_ONE
 };
 
-struct rename_conflict_info {
-	enum rename_type rename_type;
-	struct diff_filepair *pair1;
-	struct diff_filepair *pair2;
-	const char *branch1;
-	const char *branch2;
-	struct stage_data *dst_entry1;
-	struct stage_data *dst_entry2;
-	struct diff_filespec ren1_other;
-	struct diff_filespec ren2_other;
-};
-
 /*
  * Since we want to write the index eventually, we cannot reuse the index
  * for these (temporary) data.
@@ -221,6 +209,45 @@ struct stage_data {
 	unsigned processed:1;
 };
 
+struct rename {
+	struct diff_filepair *pair;
+	/*
+	 * Purpose of src_entry and dst_entry:
+	 *
+	 * If 'before' is renamed to 'after' then src_entry will contain
+	 * the versions of 'before' from the merge_base, HEAD, and MERGE in
+	 * stages 1, 2, and 3; dst_entry will contain the respective
+	 * versions of 'after' in corresponding locations.  Thus, we have a
+	 * total of six modes and oids, though some will be null.  (Stage 0
+	 * is ignored; we're interested in handling conflicts.)
+	 *
+	 * Since we don't turn on break-rewrites by default, neither
+	 * src_entry nor dst_entry can have all three of their stages have
+	 * non-null oids, meaning at most four of the six will be non-null.
+	 * Also, since this is a rename, both src_entry and dst_entry will
+	 * have at least one non-null oid, meaning at least two will be
+	 * non-null.  Of the six oids, a typical rename will have three be
+	 * non-null.  Only two implies a rename/delete, and four implies a
+	 * rename/add.
+	 */
+	struct stage_data *src_entry;
+	struct stage_data *dst_entry;
+	unsigned add_turned_into_rename:1;
+	unsigned processed:1;
+};
+
+struct rename_conflict_info {
+	enum rename_type rename_type;
+	struct diff_filepair *pair1;
+	struct diff_filepair *pair2;
+	const char *branch1;
+	const char *branch2;
+	struct stage_data *dst_entry1;
+	struct stage_data *dst_entry2;
+	struct diff_filespec ren1_other;
+	struct diff_filespec ren2_other;
+};
+
 static inline void setup_rename_conflict_info(enum rename_type rename_type,
 					      struct diff_filepair *pair1,
 					      struct diff_filepair *pair2,
@@ -645,33 +672,6 @@ static void record_df_conflict_files(struct merge_options *opt,
 	string_list_clear(&df_sorted_entries, 0);
 }
 
-struct rename {
-	struct diff_filepair *pair;
-	/*
-	 * Purpose of src_entry and dst_entry:
-	 *
-	 * If 'before' is renamed to 'after' then src_entry will contain
-	 * the versions of 'before' from the merge_base, HEAD, and MERGE in
-	 * stages 1, 2, and 3; dst_entry will contain the respective
-	 * versions of 'after' in corresponding locations.  Thus, we have a
-	 * total of six modes and oids, though some will be null.  (Stage 0
-	 * is ignored; we're interested in handling conflicts.)
-	 *
-	 * Since we don't turn on break-rewrites by default, neither
-	 * src_entry nor dst_entry can have all three of their stages have
-	 * non-null oids, meaning at most four of the six will be non-null.
-	 * Also, since this is a rename, both src_entry and dst_entry will
-	 * have at least one non-null oid, meaning at least two will be
-	 * non-null.  Of the six oids, a typical rename will have three be
-	 * non-null.  Only two implies a rename/delete, and four implies a
-	 * rename/add.
-	 */
-	struct stage_data *src_entry;
-	struct stage_data *dst_entry;
-	unsigned add_turned_into_rename:1;
-	unsigned processed:1;
-};
-
 static int update_stages(struct merge_options *opt, const char *path,
 			 const struct diff_filespec *o,
 			 const struct diff_filespec *a,
-- 
2.21.0.211.g719c25afaf.dirty

