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
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A3E207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 00:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979438AbdDYAM0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 20:12:26 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33804 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979431AbdDYAMX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 20:12:23 -0400
Received: by mail-wr0-f196.google.com with SMTP id 6so8871841wrb.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 17:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=1uhTYfgKokNY24jt1IBzGVfmp8QnE0CThv/YR1OutzI=;
        b=QU7dYLj6YAdKMPt8PrBqU0dUfhd3im3Ef95R46vD7bgHYJQhAt7T+3+tW9MzYO1iFS
         8jBq2AlnGArK5/hbppUH7q5LjlvCFgdhu//KMlEt7+zeixAdZ1xMutShMbgPzJc8FN3l
         9mo/ujZ5pRxi18VtUA3FA0gkT1XVIiKsCmv5P6J90AFWh07ZqFCWeZY4kSNRFkaiFLAB
         +jCexUG99RdeCs+5w30hnMEgum6JVaLc/RsZFYMnxf9YMndoz1ikK2b8c+G+XZ4/NGr+
         /kltkCdM91OJK5H68HJKN1U9SbpoJT93nb58FhonaaulTqy3WbeFIm6KETRFaRYT0phU
         ZkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=1uhTYfgKokNY24jt1IBzGVfmp8QnE0CThv/YR1OutzI=;
        b=XhtwiZ2Q4JW75+VPQsfPktdm9OQJzVQTGKJ1hWYSiC2cpekdgxdOPFuWh9LjXqep5p
         zagdy4Ya+gAaphtsi4xtIu7Ss5WYe2nksoo8oGEDPPW5xGp9/5M5uZfh8WNxWa3ytx0o
         buCPY9UQU/d+dMgdaKtSOTkglOPmAS9hUsfPnoHmIKHVwpcroPjL2/1hu6+6pUD1pD+S
         A8FOAdZkfmsIZesWr1huJVSXini/jfUdUGICr0UQB7GygFJ9zJX2bSMhEvbNPWb7aZlN
         CT20VBEwUiPjuWQNsSWwTZtGnGDREidDfTtXxEKidYF0XguueNKADnHB/TmYcIB6d5SA
         hKtw==
X-Gm-Message-State: AN3rC/5Q4xYzeLWsKFrDInu0v0ZopnIZjnudE+uRpmF1wPQf8+iWHfvM
        XLr6VuF/wmnf7A==
X-Received: by 10.223.152.238 with SMTP id w101mr8602633wrb.151.1493079142513;
        Mon, 24 Apr 2017 17:12:22 -0700 (PDT)
Received: from localhost.localdomain (66.red-88-8-179.dynamicip.rima-tde.net. [88.8.179.66])
        by smtp.gmail.com with ESMTPSA id y190sm1007142wmy.15.2017.04.24.17.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 17:12:21 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     git@vger.kernel.org
Cc:     Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH 1/2] fast-export: deletion action first
Date:   Tue, 25 Apr 2017 02:12:16 +0200
Message-Id: <1493079137-1838-1-git-send-email-miguel.torroja@gmail.com>
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

