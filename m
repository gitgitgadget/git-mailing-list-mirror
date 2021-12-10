Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED9DC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 12:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbhLJMe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 07:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240926AbhLJMeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 07:34:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B677BC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:30:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j3so14720729wrp.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdgLkQmkRKfOKXfrTqA8Z3c6Omvzbsf4nYhIJ6o6UTA=;
        b=ggereknQjtguSSz+M8rOew3EueUK0iWbL2qj+THNq1vYNwR4CfvUd4RsGuE0eXovet
         E9Lnq1LNUIyijUCuDkun5PlyQtEmaIDJ6TG/ARISBUE7PgBtcquh99BuOx4S9kf2PbEN
         fR/rmA8XEcXkgMxYdrzrJs2oYaiEH3jlbyEJsKQUz89MvvG/+QDRfs9V6pBfDIjYxi5E
         SddQ13/crzozfWhMRe0kRH/bbYgQDFj+QjTjnfPaA0OSCg+GASJ2E7swVTW/FdCSuCOT
         5k3vpb8z92SMbg6fhoykjDEVEUIoQLP0PFZl1iqsHFEwM8Jo+RGZF2M5S0I8eeFgUMBR
         uyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdgLkQmkRKfOKXfrTqA8Z3c6Omvzbsf4nYhIJ6o6UTA=;
        b=l3bkD6hoocFb0iop8HVQeXGWTCc4NPjPN5nxxr30VuCozXGh+dYz3hMUiRshzQPoI7
         Mg5v7NR3Ea1mzTIaOiE26bzWC9eGnRwUONlQ5Z3PJf0SgvUuUGpYTG1Q/RR2Fn/A7Ynr
         +ONmUacFU4f7U7oKM4BVjEEc2tiVil+vQg+bxWaI19M7uiWmWvTOJHJ0sdILIVORpFd+
         sTbYehET4SmKBLPqMU4NyWSZVxE7LiiNMoal56mTXohP5UsATUQ3WGJCZWqd684tZw98
         lDPIsZvNSEqdvxVU6HQ730cdHSMzDvwHGEPMf5VzHe+0T4/YLJfh9AB9z1uu3TXqInyZ
         w/9A==
X-Gm-Message-State: AOAM530mgQrH0z3q7FDXXxsUKSUyVWhAtu5Il8xNoCCGRoJOWfeKTtyx
        DspOkw30QpL19YPcU1VASsetRmx5LeicMA==
X-Google-Smtp-Source: ABdhPJzZBjrUi2KgeyyDA6lkDIpVJ/Zu7OmymH3OIPrkQTpS7D+ET9aLM+fZSAy1AM6JdIwM0XIvFQ==
X-Received: by 2002:adf:f151:: with SMTP id y17mr13782740wro.153.1639139447923;
        Fri, 10 Dec 2021 04:30:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm11898982wmq.38.2021.12.10.04.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:30:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 2/5] linear-assignment.c: split up compute_assignment() function
Date:   Fri, 10 Dec 2021 13:30:39 +0100
Message-Id: <RFC-patch-v2-2.5-2233872545e-20211210T122901Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.932.g36842105b61
In-Reply-To: <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com> <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the the long compute_assignment() function to make it easier
to reason about, particularly when it comes to what variables are used
later, and which aren't.

The grouping of "int" v.s. "int *" in function signatures is there to
make subsequent diffs smaller, if we're ever going to have a "nr"
member with a "size_t", but allocate e.g. "int *", and in anticipation
of the type names becoming longer than "int", which would require
re-wrapping.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 linear-assignment.c | 103 +++++++++++++++++++++++++++++++++-----------
 linear-assignment.h |   3 +-
 2 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/linear-assignment.c b/linear-assignment.c
index 0c0786a63b6..7f85745e541 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -8,21 +8,12 @@
 
 #define COST(column, row) cost[(column) + column_count * (row)]
 
-/*
- * The parameter `cost` is the cost matrix: the cost to assign column j to row
- * i is `cost[j + column_count * i].
- */
-void compute_assignment(int column_count, int row_count, int *cost,
-			int *column2row, int *row2column)
+static void columns_reduction(int column_count, int row_count,
+			      int *cost,
+			      int *column2row, int *row2column,
+			      int *v)
 {
-	int *v, *d;
-	int *free_row, free_count = 0, saved_free_count, *pred, *col;
-	int i, j, phase;
-
-	assert(column_count > 1);
-	memset(column2row, -1, sizeof(int) * column_count);
-	memset(row2column, -1, sizeof(int) * row_count);
-	ALLOC_ARRAY(v, column_count);
+	int i, j;
 
 	/* column reduction */
 	for (j = column_count - 1; j >= 0; j--) {
@@ -42,13 +33,21 @@ void compute_assignment(int column_count, int row_count, int *cost,
 			column2row[j] = -1;
 		}
 	}
+}
+
+static void reduction_transfer(int column_count, int row_count,
+			       int *cost,
+			       int *free_row, int *free_count,
+			       int *column2row, int *row2column,
+			       int *v)
+{
+	int i, j;
 
 	/* reduction transfer */
-	ALLOC_ARRAY(free_row, row_count);
 	for (i = 0; i < row_count; i++) {
 		int j1 = row2column[i];
 		if (j1 == -1)
-			free_row[free_count++] = i;
+			free_row[(*free_count)++] = i;
 		else if (j1 < -1)
 			row2column[i] = -2 - j1;
 		else {
@@ -59,21 +58,25 @@ void compute_assignment(int column_count, int row_count, int *cost,
 			v[j1] -= min;
 		}
 	}
+}
 
-	if (free_count ==
-	    (column_count < row_count ? row_count - column_count : 0)) {
-		free(v);
-		free(free_row);
-		return;
-	}
+static void augmenting_row_reduction(int column_count,
+				     int *cost,
+				     int *column2row, int *row2column,
+				     int *free_row, int *free_count, int *saved_free_count,
+				     int *v)
+{
+	int phase;
 
 	/* augmenting row reduction */
 	for (phase = 0; phase < 2; phase++) {
+		int i;
 		int k = 0;
 
-		saved_free_count = free_count;
-		free_count = 0;
-		while (k < saved_free_count) {
+		*saved_free_count = *free_count;
+		*free_count = 0;
+		while (k < *saved_free_count) {
+			int j;
 			int u1, u2;
 			int j1 = 0, j2, i0;
 
@@ -112,12 +115,24 @@ void compute_assignment(int column_count, int row_count, int *cost,
 				if (u1 < u2)
 					free_row[--k] = i0;
 				else
-					free_row[free_count++] = i0;
+					free_row[(*free_count)++] = i0;
 			}
 			row2column[i] = j1;
 			column2row[j1] = i;
 		}
 	}
+}
+
+static void augmentation(int column_count,
+			 int *cost,
+			 int *column2row, int *row2column,
+			 int *free_row, int free_count,
+			 int *v)
+{
+	int i, j;
+	int *d;
+	int *pred, *col;
+	int saved_free_count;
 
 	/* augmentation */
 	saved_free_count = free_count;
@@ -197,6 +212,42 @@ void compute_assignment(int column_count, int row_count, int *cost,
 	free(col);
 	free(pred);
 	free(d);
+}
+
+/*
+ * The parameter `cost` is the cost matrix: the cost to assign column j to row
+ * i is `cost[j + column_count * i].
+ */
+void compute_assignment(int column_count, int row_count,
+			int *cost,
+			int *column2row, int *row2column)
+{
+	int *v;
+	int *free_row, free_count = 0, saved_free_count;
+
+	assert(column_count > 1);
+	memset(column2row, -1, sizeof(int) * column_count);
+	memset(row2column, -1, sizeof(int) * row_count);
+	ALLOC_ARRAY(v, column_count);
+
+	columns_reduction(column_count, row_count, cost, column2row,
+			  row2column, v);
+
+	ALLOC_ARRAY(free_row, row_count);
+	reduction_transfer(column_count, row_count, cost, free_row,
+			   &free_count, column2row, row2column, v);
+	if (free_count ==
+	    (column_count < row_count ? row_count - column_count : 0))
+		goto cleanup;
+
+	augmenting_row_reduction(column_count, cost, column2row,
+				 row2column, free_row, &free_count,
+				 &saved_free_count,v);
+
+	augmentation(column_count, cost, column2row, row2column,
+		     free_row, free_count, v);
+
+cleanup:
 	free(v);
 	free(free_row);
 }
diff --git a/linear-assignment.h b/linear-assignment.h
index 1dfea766290..ef9946bdbfc 100644
--- a/linear-assignment.h
+++ b/linear-assignment.h
@@ -13,7 +13,8 @@
  * assignments (-1 for unassigned, which can happen only if column_count !=
  * row_count).
  */
-void compute_assignment(int column_count, int row_count, int *cost,
+void compute_assignment(int column_count, int row_count,
+			int *cost,
 			int *column2row, int *row2column);
 
 /* The maximal cost in the cost matrix (to prevent integer overflows). */
-- 
2.34.1.932.g36842105b61

