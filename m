Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A731F51C
	for <e@80x24.org>; Tue, 22 May 2018 00:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeEVAnl (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 20:43:41 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:53502 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751171AbeEVAng (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 21 May 2018 20:43:36 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4M0hOh3027579;
        Mon, 21 May 2018 17:43:29 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2j2gtkjv5u-1;
        Mon, 21 May 2018 17:43:29 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 1869B2277E88;
        Mon, 21 May 2018 17:43:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 0FE302CDE66;
        Mon, 21 May 2018 17:43:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 5/5] merge-recursive: add pointer about unduly complex looking code
Date:   Mon, 21 May 2018 17:43:27 -0700
Message-Id: <20180522004327.13085-6-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.847.g20b8963732
In-Reply-To: <20180522004327.13085-1-newren@gmail.com>
References: <20180519020700.2241-1-newren@gmail.com>
 <20180522004327.13085-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1805220005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

handle_change_delete() has a block of code displaying one of four nearly
identical messages.  Each contains about half a dozen variable interpolations,
which use nearly identical variables as well.  Someone trying to parse this
may be slowed down trying to parse the differences and why they are here; help
them out by adding a comment explaining the differences.

Further, point out that this code structure isn't collapsed into something
more concise and readable for the programmer, because we want to keep full
messages intact in order to make translators' jobs much easier.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 270a4d2aad..28f39b3e9f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1290,6 +1290,21 @@ static int handle_change_delete(struct merge_options *o,
 		if (!ret)
 			ret = update_file(o, 0, o_oid, o_mode, update_path);
 	} else {
+		/*
+		 * Despite the four nearly duplicate messages and argument
+		 * lists below and the ugliness of the nested if-statements,
+		 * having complete messages makes the job easier for
+		 * translators.
+		 *
+		 * The slight variance among the cases is due to the fact
+		 * that:
+		 *   1) directory/file conflicts (in effect if
+		 *      !alt_path) could cause us to need to write the
+		 *      file to a different path.
+		 *   2) renames (in effect if !old_path) could mean that
+		 *      there are two names for the path that the user
+		 *      may know the file by.
+		 */
 		if (!alt_path) {
 			if (!old_path) {
 				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-- 
2.17.0.847.g20b8963732

