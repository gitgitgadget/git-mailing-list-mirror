Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87CB0207E2
	for <e@80x24.org>; Mon, 24 Apr 2017 23:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979099AbdDXXEh (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 19:04:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33646 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S978909AbdDXXEf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 19:04:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id y10so9988392wmh.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=1uhTYfgKokNY24jt1IBzGVfmp8QnE0CThv/YR1OutzI=;
        b=AcDhyV+9NtBnHq6/Mpl0it7vQ3CibVdA918PF0DDM+zmcHa4I8gAzZ9h22Uz433N5B
         0gp2fLgDlN3wrWO24cvy9lqw0aKfGYzjMfXP33pGUILqdixXT7eCXLNKILWeNrzLuVFS
         F4egpJZlavPUkeA+tm2PqtXcBkZXPxCjJL3BRnZ5Oulxubqr0tGGe5Azq7CZBwEXoA+G
         6k9OfA50o4X51WeOFSSypgJLG1wQTv19yKPU7CfPfwUymb9UWSjAtHpyF98QTzob+lhB
         K94qpPTw+xWN2Fc48ATFVIp6Ox5Fvc9uyKmaBndiJmmMfCfHgl3vo8fhgl3CjX0ap8dP
         C9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=1uhTYfgKokNY24jt1IBzGVfmp8QnE0CThv/YR1OutzI=;
        b=Tx47knSVhwvsmpfDa9N+F6wiyvmfKjuU0z+fAdK3l9m6IiaB4SWb3i6WlyOddtN4ZM
         lDRoqxSmBooZXdcWSGN01/jFa2DhwSsxlHECGGrnANpKBrVeYYNKhv+ZX2zY2s0dp3yk
         58C7tTkIgXUh1RdQrr5FEtYh5LhIzygI1DA8QGxhsVQEQA7EDvhd8RTaa5sRM9z9dCTd
         2e3gBPhk8iVy9NoGSwOybM8ebxYyfqRmuYfQNfEIWz7ZVYyP44CoEGW+qD14jQWltQgD
         k+gnlAlqdBOrBdYn0gpSZuaSz1o+0aXORDMn0BWTZ+jBWpI3tVqs4v3+6WqIMi7awM/M
         mIaw==
X-Gm-Message-State: AN3rC/5xCNSMxnecGpIVCyLPJotPXHelzoa7dxt4vzJdpF8LCWztMWeM
        wHY6K32JoD9hzcxvIGA=
X-Received: by 10.28.63.148 with SMTP id m142mr33617wma.98.1493075074017;
        Mon, 24 Apr 2017 16:04:34 -0700 (PDT)
Received: from berenguela.telefonica.net (152.red-95-120-155.dynamicip.rima-tde.net. [95.120.155.152])
        by smtp.gmail.com with ESMTPSA id s27sm23920525wra.25.2017.04.24.16.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 16:04:33 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     git@vger.kernel.org
Cc:     Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH 1/2] fast-export: deletion action first
Date:   Tue, 25 Apr 2017 01:04:07 +0200
Message-Id: <1493075048-6665-1-git-send-email-miguel.torroja@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The delete operations of the fast-export output should precede any addition
belonging to the same commit, Addition and deletion with the same name
entry could happen in case of file to directory and viceversa.

The fast-export sorting was added in 060df62 (fast-export: Fix output
order of D/F changes). That change was made in order to fix the case of
directory to file in the same commit, but it broke the reverse case
(File to directory).

Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
---
 builtin/fast-export.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e022063..a3ab7da 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -260,26 +260,19 @@ static void export_blob(const struct object_id *oid)
 		free(buf);
 }
 
-static int depth_first(const void *a_, const void *b_)
+/*
+ * Compares two diff types to order based on output priorities.
+ */
+static int diff_type_cmp(const void *a_, const void *b_)
 {
 	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
 	const struct diff_filepair *b = *((const struct diff_filepair **)b_);
-	const char *name_a, *name_b;
-	int len_a, len_b, len;
 	int cmp;
 
-	name_a = a->one ? a->one->path : a->two->path;
-	name_b = b->one ? b->one->path : b->two->path;
-
-	len_a = strlen(name_a);
-	len_b = strlen(name_b);
-	len = (len_a < len_b) ? len_a : len_b;
-
-	/* strcmp will sort 'd' before 'd/e', we want 'd/e' before 'd' */
-	cmp = memcmp(name_a, name_b, len);
-	if (cmp)
-		return cmp;
-	cmp = len_b - len_a;
+	/*
+	 * Move Delete entries first so that an addition is always reported after
+	 */
+	cmp = (b->status == DIFF_STATUS_DELETED) - (a->status == DIFF_STATUS_DELETED);
 	if (cmp)
 		return cmp;
 	/*
@@ -347,7 +340,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 	 * Handle files below a directory first, in case they are all deleted
 	 * and the directory changes to a file or symlink.
 	 */
-	QSORT(q->queue, q->nr, depth_first);
+	QSORT(q->queue, q->nr, diff_type_cmp);
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *ospec = q->queue[i]->one;
-- 
2.1.4

