Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E97AB1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 23:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeHDBMc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 21:12:32 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40928 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731991AbeHDBMc (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Aug 2018 21:12:32 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73NClXe015682;
        Fri, 3 Aug 2018 16:14:08 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2km9yaa4fj-1;
        Fri, 03 Aug 2018 16:14:08 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 89C06220F84E;
        Fri,  3 Aug 2018 16:14:08 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 7F7A62CDE46;
        Fri,  3 Aug 2018 16:14:08 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] t7406: Make a test_must_fail call fail for the right reason
Date:   Fri,  3 Aug 2018 16:14:07 -0700
Message-Id: <20180803231407.10662-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.548.gcd835b18f7
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=850 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030250
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A test making use of test_must_fail was failing like this:
  fatal: ambiguous argument '|': unknown revision or path not in the work=
ing tree.
when the intent was to verify that a specific string was not found
in the output of the git diff command, i.e. that grep returned
non-zero.  Fix the test to do that.
---
 t/t7406-submodule-update.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f604ef7a72..7be8b59569 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -599,7 +599,7 @@ test_expect_success 'submodule update - update=3Dnone=
 in .git/config but --checkou
 	 ) &&
 	 git diff --raw | grep "	submodule" &&
 	 git submodule update --checkout &&
-	 test_must_fail git diff --raw \| grep "	submodule" &&
+	 git diff --raw | test_must_fail grep "	submodule" &&
 	 (cd submodule &&
 	  test_must_fail compare_head
 	 ) &&
--=20
2.18.0.548.gcd835b18f7

