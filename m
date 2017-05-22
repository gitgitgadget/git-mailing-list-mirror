Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0541D2023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934691AbdEVOS3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:29 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42970 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934683AbdEVOSZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:25 -0400
X-AuditID: 12074413-0e1ff70000001dc3-67-5922f330f057
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 81.20.07619.033F2295; Mon, 22 May 2017 10:18:24 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24G023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:22 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/25] refs: use `size_t` indexes when iterating over ref transaction updates
Date:   Mon, 22 May 2017 16:17:37 +0200
Message-Id: <affc4f0ef831e70009bdcecbcc1320eb78bb8cf8.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqGvwWSnSoPEAr8XaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8WTuXeZLW6vmM9sseTha2aL7ilvGS1+tPQwW2ze3M7iwOXx9/0HJo+ds+6y
        eyzYVOrx8FUXu0dX+xE2j2e9exg9Ll5S9vi8SS6AI4rLJiU1J7MstUjfLoEr4/ZNnoI2nopj
        q26xNzC+4Oxi5OSQEDCR2PX/O3sXIxeHkMAOJonvjW1sEM4pJomjHRNYQKrYBHQlFvU0M4HY
        IgJqEhPbDrGAFDELbGCWeDN9NVhCWCBBYsHG74wgNouAqsSr86vYQWxegSiJyz9bWCHWyUvs
        arsIZnMKWEj8nnUArFdIwFyi999qlgmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr
        5WaW6KWmlG5ihASi8A7GXSflDjEKcDAq8fBqPFaKFGJNLCuuzD3EKMnBpCTKe/QNUIgvKT+l
        MiOxOCO+qDQntfgQowQHs5IIr/ZdoBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFq
        EUxWhoNDSYL3+EegRsGi1PTUirTMnBKENBMHJ8hwHqDhaz6ADC8uSMwtzkyHyJ9iVJQS590B
        khAASWSU5sH1whLFK0ZxoFeEeU0+AVXxAJMMXPcroMFMQIOtn8mDDC5JREhJNTDOWNFTMoVP
        XXTzjvCkh+9+Tz8UabFwskx+zabcDbFPpv/QzS7V7eh/rGRatf/tQ5ki9cJF7n9Ee112P2ie
        eM72lAW77eJLrk9dpD55tN5xavRo/ZVdvzjrSxm3qwTzq20JXEkSnwUnr/H29tc/wJt7V797
        n5BKlXlDwFHP07UXi+30ui8bPVJiKc5INNRiLipOBABIpzDZ7wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eliminate any chance of integer overflow on platforms where the two
types have different sizes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 2 +-
 refs/files-backend.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 8494b1f20d..71139ba74e 100644
--- a/refs.c
+++ b/refs.c
@@ -848,7 +848,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 
 void ref_transaction_free(struct ref_transaction *transaction)
 {
-	int i;
+	size_t i;
 
 	if (!transaction)
 		return;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index fa5d2b6f08..b2559b5585 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2850,7 +2850,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE,
 			       "ref_transaction_commit");
-	int ret = 0, i;
+	size_t i;
+	int ret = 0;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
@@ -3057,7 +3058,8 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE,
 			       "initial_ref_transaction_commit");
-	int ret = 0, i;
+	size_t i;
+	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
 	assert(err);
-- 
2.11.0

