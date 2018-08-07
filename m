Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9867208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 16:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389095AbeHGTE1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 15:04:27 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37068 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389005AbeHGTE1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Aug 2018 15:04:27 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w77Gms7q014553;
        Tue, 7 Aug 2018 09:49:07 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kna0jdagp-1;
        Tue, 07 Aug 2018 09:49:07 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 763BF22FCFB5;
        Tue,  7 Aug 2018 09:49:07 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 6A2CD2CDEB1;
        Tue,  7 Aug 2018 09:49:07 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com, martin.agren@gmail.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 5/5] t7406: fix call that was failing for the wrong reason
Date:   Tue,  7 Aug 2018 09:49:05 -0700
Message-Id: <20180807164905.3859-6-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.550.geb414df874.dirty
In-Reply-To: <20180807164905.3859-1-newren@gmail.com>
References: <20180806152524.27516-1-newren@gmail.com>
 <20180807164905.3859-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=884 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808070167
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7406-submodule-update.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 5b42bbe9fa..7dd1c86b02 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -603,7 +603,8 @@ test_expect_success 'submodule update - update=3Dnone=
 in .git/config but --checkou
 	 git diff --name-only >out &&
 	 grep submodule out &&
 	 git submodule update --checkout &&
-	 test_must_fail git diff --name-only \| grep submodule &&
+	 git diff --name-only >out &&
+	 ! grep submodule out &&
 	 (cd submodule &&
 	  ! compare_head
 	 ) &&
--=20
2.18.0.550.geb414df874.dirty

