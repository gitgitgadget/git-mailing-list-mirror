Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351861F597
	for <e@80x24.org>; Wed, 18 Jul 2018 22:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeGRXbU (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 19:31:20 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:55384 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728626AbeGRXbU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Jul 2018 19:31:20 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6IMiLoH022127;
        Wed, 18 Jul 2018 15:51:14 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ka270h9rn-1;
        Wed, 18 Jul 2018 15:51:14 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 0430C2237908;
        Wed, 18 Jul 2018 15:51:14 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id E9B2D2CDE60;
        Wed, 18 Jul 2018 15:51:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH] fix-v2: make OE_DELTA_SIZE_BITS a bit bigger
Date:   Wed, 18 Jul 2018 15:51:10 -0700
Message-Id: <20180718225110.17639-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.1.gd83e732e4e
In-Reply-To: <20180718225110.17639-1-newren@gmail.com>
References: <20180718225110.17639-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180247
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
builtin/pack-objects.c | 2 +-
 pack-objects.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 71056d8294..49b7af295d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2023,7 +2023,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
-	if (delta_size >= (1U << OE_DELTA_SIZE_BITS)) {
+	if (delta_size >= (1UL << OE_DELTA_SIZE_BITS)) {
 		free(delta_buf);
 		return 0;
 	}
diff --git a/pack-objects.h b/pack-objects.h
index edf74dabdd..26021328aa 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -14,7 +14,7 @@
  * above this limit. Don't lower it too much.
  */
 #define OE_SIZE_BITS		31
-#define OE_DELTA_SIZE_BITS	20
+#define OE_DELTA_SIZE_BITS	32
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
-- 
2.18.0.1.gd83e732e4e

