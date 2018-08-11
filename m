Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276501F428
	for <e@80x24.org>; Sat, 11 Aug 2018 04:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeHKHFN (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 03:05:13 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:54293 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726889AbeHKHFJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Aug 2018 03:05:09 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7B4Ssbj027450;
        Fri, 10 Aug 2018 21:32:20 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kr347cmx6-1;
        Fri, 10 Aug 2018 21:32:20 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 957EA2237918;
        Fri, 10 Aug 2018 21:32:20 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 8D4A52CDEA7;
        Fri, 10 Aug 2018 21:32:20 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/9] alloc: make allocate_alloc_state and clear_alloc_state more consistent
Date:   Fri, 10 Aug 2018 21:32:11 -0700
Message-Id: <20180811043218.31456-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.549.gd4454f3f9b
In-Reply-To: <20180811043218.31456-1-newren@gmail.com>
References: <20180811043218.31456-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-11_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808110048
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since both functions are using the same data type, they should either bot=
h
refer to it as void *, or both use the real type (struct alloc_state *).
Opt for the latter.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 alloc.c | 2 +-
 alloc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/alloc.c b/alloc.c
index c2fc5d6888..e7aa81b7aa 100644
--- a/alloc.c
+++ b/alloc.c
@@ -36,7 +36,7 @@ struct alloc_state {
 	int slab_nr, slab_alloc;
 };
=20
-void *allocate_alloc_state(void)
+struct alloc_state *allocate_alloc_state(void)
 {
 	return xcalloc(1, sizeof(struct alloc_state));
 }
diff --git a/alloc.h b/alloc.h
index 7a41bb9eb3..ba356ed847 100644
--- a/alloc.h
+++ b/alloc.h
@@ -15,7 +15,7 @@ void *alloc_object_node(struct repository *r);
 void alloc_report(struct repository *r);
 unsigned int alloc_commit_index(struct repository *r);
=20
-void *allocate_alloc_state(void);
+struct alloc_state *allocate_alloc_state(void);
 void clear_alloc_state(struct alloc_state *s);
=20
 #endif
--=20
2.18.0.549.gd4454f3f9b

