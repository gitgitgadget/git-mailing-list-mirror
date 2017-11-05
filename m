Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB9C20450
	for <e@80x24.org>; Sun,  5 Nov 2017 08:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbdKEImv (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 03:42:51 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45870 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752593AbdKEImY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 03:42:24 -0500
X-AuditID: 1207440f-a5bff70000007960-d3-59feceece174
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E9.45.31072.DEECEF95; Sun,  5 Nov 2017 03:42:21 -0500 (EST)
Received: from bagpipes.fritz.box (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA58gCCs018723
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 03:42:19 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/9] ref_transaction_update(): die on disallowed flags
Date:   Sun,  5 Nov 2017 09:42:03 +0100
Message-Id: <10901328af1e6e04e8c7c7b39977ec85f6c58142.1509870243.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509870243.git.mhagger@alum.mit.edu>
References: <cover.1509870243.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqPv23L9Ig4M9hhZdV7qZLBp6rzBb
        /H3TxWhxe8V8ZoszbxoZHVg9/r7/wOSxc9Zddo+Ll5Q9Fj/w8vi8SS6ANYrLJiU1J7MstUjf
        LoEr49aKPvaCj6wVD059ZGpgfMbSxcjJISFgIrFy2QIgm4tDSGAHk0TzgaPsEM4JJom5bxYz
        glSxCehKLOppZgKxRQTUJCa2HQLrYBbYyijxt7uZGSQhLOAp8fvWQTYQm0VAVeLM3N2sIDav
        QJRE88TLrBDr5CXOPbgNVs8pYCHx5+M8sHohAXOJT592sk5g5FnAyLCKUS4xpzRXNzcxM6c4
        NVm3ODkxLy+1SNdELzezRC81pXQTIyR0+Hcwdq2XOcQowMGoxMN7wuNfpBBrYllxZe4hRkkO
        JiVR3isv/0QK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuENWgxUzpuSWFmVWpQPk5LmYFES51Vf
        ou4nJJCeWJKanZpakFoEk5Xh4FCS4L12FqhRsCg1PbUiLTOnBCHNxMEJMpwHaPhjkBre4oLE
        3OLMdIj8KUZLjhsPr/9h4ng283UDM8e0q61NzEIsefl5qVLivMdAGgRAGjJK8+BmwlLBK0Zx
        oBeFeeWBiUGIB5hG4Ka+AlrIBLRwNscfkIUliQgpqQZGbsE2dbXLkkqpZ9/vvMV2ROWPyGEv
        ZqEdxoJfpNkfHfLOblj62EPFdB/7i0lPObi6Ny+df/pdbtpS3invJzrxvly/y+H4Fp6ZORtZ
        uD+Gim46ufLk+X8Jr3lOPJnv8/mfJX/DRwlRpfWRV+dyfRBkdnk95dniczf2SYZ2JNw8dI1X
        5vIUd7WT65RYijMSDbWYi4oTASdjB5LgAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Callers shouldn't be passing disallowed flags into
`ref_transaction_update()`. So instead of masking them off, treat it
as a bug if any are set.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 62a7621025..7c1e206e08 100644
--- a/refs.c
+++ b/refs.c
@@ -940,7 +940,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
+	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
+		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
 
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 
-- 
2.14.1

