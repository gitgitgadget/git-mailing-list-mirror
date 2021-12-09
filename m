Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF03C433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhLITXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLITXL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:23:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DD3C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 11:19:36 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i5so11485202wrb.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 11:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oiYd6jcyHX5jW/fmuJ/Ezyf+0g77AohYCYFKYCeJ+MM=;
        b=amHaFkezDoUxr9+Z7CP5vJDxZJmBfCxDbS22FTYHPQ+uEDuCEzCymBYnPgFq8Vxrp+
         0kNPZdKzK9tjmocXDFCWMOevEPCpjtxN/9U8BbREYQpKJLCVaQI8RTXumlWvNWlJrW6k
         v8RKSexSOn1wf4P4f21rfIK/b0iMvTd82nPnOxO/kGu4KDPm3YEi0/R1d+WWMHach8MK
         hzu1tKJQgWzZNASK5MUvR1dUuNqHoEnwQFiAS1ANO6k1upDX/Oya600ZoLZEHJEFI/oD
         ilfuX2Ur18H1FdQiAdHBPwKhpxht/MIQGhBdSNdNodurcXGk928/DcIdLao/jvOyeBJd
         Rrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiYd6jcyHX5jW/fmuJ/Ezyf+0g77AohYCYFKYCeJ+MM=;
        b=FraD4ZqLOdZ8+8D/DZSNDDWlSMmjmITqpKI3q7QgHklac8gC8kdnEYWziWDhdai+Tf
         iIqgsJX7RtJ9X5ZNmDIae1dRlawQz0PC+HRq/GoFIhZx7zt4xiYr66D/Ej0Lgq+U46/b
         I/b0rpm1ZklqvQq2Mt0hSU3RP492Ma8i7LxuWJ9rwOc2glpMZMcR3maCbgjpcM/+aM1l
         V9fvzFv8eBY3ziqJi/i4FBw2Y57uHrtstyxCiY0aXA1W3Ktlf5sZDogLXQeKDzOpIY+v
         WX8c04s2YON09SCwV1JmPAQkqsyw3e6Bk4W/6Cj3Ov7y8U64Ursm9wklyz2p6wne/ZHF
         qtGQ==
X-Gm-Message-State: AOAM533peZtiMKTJBlvgvedoLviTuxGgbGzQ+7Suk4a6ppF5n9lE14IU
        G7pbGNlnjOnJvzw9NXHHG6bWrfm31/XdSw==
X-Google-Smtp-Source: ABdhPJyeaeC2MPF6zjP1bOBPnQgBOboV7kdIOqSy2g+nn2Zl37RT5Nq0yJR+n8FrGbBKZ3qTJFbBlQ==
X-Received: by 2002:adf:f6cf:: with SMTP id y15mr8451284wrp.56.1639077575332;
        Thu, 09 Dec 2021 11:19:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x13sm562180wrr.47.2021.12.09.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:19:34 -0800 (PST)
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
Subject: [RFC PATCH 04/10] range-diff: zero out elements in "cost" first
Date:   Thu,  9 Dec 2021 20:19:21 +0100
Message-Id: <RFC-patch-04.10-fe9dcb2d453-20211209T191653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g0f9292b224d
In-Reply-To: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the get_correspondences() function use CALLOC_ARRAY instead of
looping over the newly allocated "cost" to zero out some of its
elements.

The for-loop that zero'd out elements in "cost" wasn't the first loop
in that function, nor did it cover all of its elements, but regardless
of that this change doesn't affect its end-state. None of the
for-loops touched the same items in the array, so we could have (and
an earlier WIP version of this change did) moved the for-loop we're
deleting to come first in get_correspondences().

This can be seen from a careful reading of this code added in in
d9c66f0b5bf (range-diff: first rudimentary implementation,
2018-08-13) (as well as adding some printf-debugging) we'll set all
elements in the in the "n * n" allocated array. That's "n = A+B" where
"A" and "B" are the number of commits in our respective ranges.

So let's just allocate this with CALLOC_ARRAY(), and skip these two
for-loops. Furthermore let's remove the early exit condition from
compute_assignment() in favor of an assert that it must be called with
"column_count > 1", then "get_correspondences()" can skip calling it
when no further filling of the "a2b" and "b2a" arrays is needed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 linear-assignment.c |  7 +------
 range-diff.c        | 13 +++++--------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/linear-assignment.c b/linear-assignment.c
index ecffc09be6e..0c0786a63b6 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -19,12 +19,7 @@ void compute_assignment(int column_count, int row_count, int *cost,
 	int *free_row, free_count = 0, saved_free_count, *pred, *col;
 	int i, j, phase;
 
-	if (column_count < 2) {
-		memset(column2row, 0, sizeof(int) * column_count);
-		memset(row2column, 0, sizeof(int) * row_count);
-		return;
-	}
-
+	assert(column_count > 1);
 	memset(column2row, -1, sizeof(int) * column_count);
 	memset(row2column, -1, sizeof(int) * row_count);
 	ALLOC_ARRAY(v, column_count);
diff --git a/range-diff.c b/range-diff.c
index 41003033752..b0ccb46ff4c 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -312,9 +312,9 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 	int *cost, c, *a2b, *b2a;
 	size_t i, j;
 
-	ALLOC_ARRAY(cost, st_mult(n, n));
-	ALLOC_ARRAY(a2b, n);
-	ALLOC_ARRAY(b2a, n);
+	CALLOC_ARRAY(cost, st_mult(n, n));
+	CALLOC_ARRAY(a2b, n);
+	CALLOC_ARRAY(b2a, n);
 
 	for (i = 0; i < a->nr; i++) {
 		struct patch_util *a_util = a->items[i].util;
@@ -346,11 +346,8 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 			cost[i + n * j] = c;
 	}
 
-	for (i = a->nr; i < n; i++)
-		for (j = b->nr; j < n; j++)
-			cost[i + n * j] = 0;
-
-	compute_assignment(n, n, cost, a2b, b2a);
+	if (n > 1)
+		compute_assignment(n, n, cost, a2b, b2a);
 
 	for (i = 0; i < a->nr; i++)
 		if (a2b[i] >= 0 && a2b[i] < b->nr) {
-- 
2.34.1.930.g0f9292b224d

