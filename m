Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 514A71F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeDERew (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:34:52 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38376 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750786AbeDERew (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Apr 2018 13:34:52 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w35HWYLs021380;
        Thu, 5 Apr 2018 10:34:49 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h277s7bsr-1;
        Thu, 05 Apr 2018 10:34:49 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 15BEE2212A86;
        Thu,  5 Apr 2018 10:34:49 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 0C3682CDEB1;
        Thu,  5 Apr 2018 10:34:49 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sxlijin@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 7/7] If we do not want globs to recurse into subdirs without -d...
Date:   Thu,  5 Apr 2018 10:34:46 -0700
Message-Id: <20180405173446.32372-8-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.7.g0b50f94d69
In-Reply-To: <20180405173446.32372-1-newren@gmail.com>
References: <20180405173446.32372-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=692 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804050181
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If folks prefer this behavior, I'll squash this patch into the previous.
Otherwise, I'll just drop this patch from the series.
---
 dir.c            | 2 +-
 t/t7300-clean.sh | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index f55e24f149..bad75e9fbd 100644
--- a/dir.c
+++ b/dir.c
@@ -403,7 +403,7 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 		 * The submodules themselves will be able to perform more
 		 * accurate matching to determine if the pathspec matches.
 		 */
-		return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
+		return MATCHED_RECURSIVELY;
 	}
 
 	return 0;
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 889b3401e4..913ea6bda3 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -685,12 +685,12 @@ test_expect_success 'git clean handles being told what to clean, with -d' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_success 'git clean handles being told a glob to clean' '
+test_expect_success 'git clean will not recurse with globs without -d' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -f "*ut" &&
-	test_path_is_missing d1/ut &&
-	test_path_is_missing d2/ut
+	test_path_is_file d1/ut &&
+	test_path_is_file d2/ut
 '
 
 test_expect_success 'git clean handles being told a glob to clean with -d' '
-- 
2.17.0.7.g0b50f94d69

