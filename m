Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037111F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeDERtr (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:49:47 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41428 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751534AbeDERtq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Apr 2018 13:49:46 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w35HnjU7018248;
        Thu, 5 Apr 2018 10:49:45 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h286rvwy6-1;
        Thu, 05 Apr 2018 10:49:44 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id DE7E022153A4;
        Thu,  5 Apr 2018 10:49:37 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id D2CE52CDEB1;
        Thu,  5 Apr 2018 10:49:37 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] Make running git under other debugger-like programs easy
Date:   Thu,  5 Apr 2018 10:49:35 -0700
Message-Id: <20180405174935.598-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.7.g0b50f94d69
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=620 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804050184
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows us to run git, when using the script from bin-wrappers, under
other programs.  A few examples:
   GIT_WRAPPER=nemiver git $ARGS
   GIT_WRAPPER="valgrind --tool=memcheck --track-origins=yes" git $ARGS

Yes, we already have GIT_TEST_GDB (which could potentially be replaced
with GIT_WRAPPER="gdb --args"), and a bunch of options for running
a testcase or multiple testcases under valgrind, but I find the extra
flexibility useful.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 wrap-for-bin.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 5842408817..1b34d44193 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -25,5 +25,5 @@ then
 	unset GIT_TEST_GDB
 	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
 else
-	exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+	exec ${GIT_WRAPPER} "${GIT_EXEC_PATH}/@@PROG@@" "$@"
 fi
-- 
2.17.0.7.g0b50f94d69

