Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9643B1F403
	for <e@80x24.org>; Sun, 10 Jun 2018 04:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932141AbeFJEQj (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 00:16:39 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:54358 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753693AbeFJEQZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 00:16:25 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5A4DmRK011512;
        Sat, 9 Jun 2018 21:16:19 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jgcrk97j4-1;
        Sat, 09 Jun 2018 21:16:19 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 83C77220F16C;
        Sat,  9 Jun 2018 21:16:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 7F6C02CDE75;
        Sat,  9 Jun 2018 21:16:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 6/6] merge-recursive: add pointer about unduly complex looking code
Date:   Sat,  9 Jun 2018 21:16:16 -0700
Message-Id: <20180610041616.4448-7-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.6.gffeb3ef585
In-Reply-To: <20180610041616.4448-1-newren@gmail.com>
References: <20180522004327.13085-1-newren@gmail.com>
 <20180610041616.4448-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806100048
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

handle_change_delete() has a block of code displaying one of four nearly
identical messages.  Each contains about half a dozen variable
interpolations, which use nearly identical variables as well.  Someone
trying to parse this may be slowed down trying to parse the differences
and why they are here; help them out by adding a comment explaining the
differences.

Further, point out that this code structure isn't collapsed into something
more concise and readable for the programmer, because we want to keep full
messages intact in order to make translators' jobs much easier.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7cf11dc04c..284b27d895 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1476,6 +1476,21 @@ static int handle_change_delete(struct merge_options *o,
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
2.18.0.rc1.6.gffeb3ef585

