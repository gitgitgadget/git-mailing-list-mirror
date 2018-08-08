Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43E3208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeHHSvm (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:51:42 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:56652 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727480AbeHHSvl (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 14:51:41 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78GN21F012008;
        Wed, 8 Aug 2018 09:31:09 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kr3478387-1;
        Wed, 08 Aug 2018 09:31:09 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 4FE8F229034E;
        Wed,  8 Aug 2018 09:31:09 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 457572CDEF0;
        Wed,  8 Aug 2018 09:31:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        martin.agren@gmail.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 2/5] t7406: simplify by using diff --name-only instead of diff --raw
Date:   Wed,  8 Aug 2018 09:31:04 -0700
Message-Id: <20180808163107.12329-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.556.g1604670984
In-Reply-To: <20180808163107.12329-1-newren@gmail.com>
References: <20180807164905.3859-1-newren@gmail.com>
 <20180808163107.12329-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=888 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080167
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can get rid of some quoted tabs and make a few tests slightly easier
to read and edit by just asking for the names of the files modified,
since that's all these tests were interested in anyway.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7406-submodule-update.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index ccdc2f9039..f821b01f15 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -579,9 +579,9 @@ test_expect_success 'submodule update - update=3Dnone=
 in .git/config' '
 	  git checkout master &&
 	  compare_head
 	 ) &&
-	 git diff --raw | grep "	submodule" &&
+	 git diff --name-only | grep ^submodule$ &&
 	 git submodule update &&
-	 git diff --raw | grep "	submodule" &&
+	 git diff --name-only | grep ^submodule$ &&
 	 (cd submodule &&
 	  compare_head
 	 ) &&
@@ -597,10 +597,10 @@ test_expect_success 'submodule update - update=3Dno=
ne in .git/config but --checkou
 	  git checkout master &&
 	  compare_head
 	 ) &&
-	 git diff --raw | grep "	submodule" &&
+	 git diff --name-only | grep ^submodule$ &&
 	 git submodule update --checkout &&
-	 git diff --raw >out &&
-	 ! grep "	submodule" out &&
+	 git diff --name-only >out &&
+	 ! grep ^submodule$ out &&
 	 (cd submodule &&
 	  test_must_fail compare_head
 	 ) &&
--=20
2.18.0.556.g1604670984

