Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DF7C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 12:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbhLJMe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 07:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241001AbhLJMeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 07:34:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92142C0617A1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:30:50 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o13so14608899wrs.12
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9OHywyrlpyOa56pRwrKUPo27WGu224KMVOZ17fDHcM=;
        b=Uy9WuBTAwmu4Yv+SYG6M33uWCuN3dmcOuPk1TJ2GuQOiYXe2gyWsyp6NzAep05QdnN
         9rEfghB50U96aGwLzGCWNAc5fKpebj6en0G6h0Ex09xLGmm/fr+si5VEeqKBqNNIgRaE
         L7W+OraUolFoRNUme+Eq2U34VR4mmXJz0mN5jDbMyHDJN3r+KiiwjxUt2KP8r7GsrYpU
         r9m+adDkSe658jqMawdpOzwr3U9M13WRpNc3dN4M24RILhwbAjukTFQrEy5Z0rCUB/iE
         QSCxdrl/O3Ms23XVN2MT0uLScWIzkfB6Qt+j7TA7KbQS600uVzJZMFhDzb5etP34PDFg
         EcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9OHywyrlpyOa56pRwrKUPo27WGu224KMVOZ17fDHcM=;
        b=N4UkEX2a2kLIUfsvwOl3EGoH7BBhbf5WLDceCGEoyaq+BM1XO/49cmZtk/j+hKzF/+
         R9F9JHlyLeXhQCRxtGU27iQyPmDUP6M+qK6oQntKj32kNoXW6ml4orWj0jNTUp7OqfLX
         hrb3JylwO9jqJ+QJjjAXKuuh+3Xx7D5JC46dRQYk1Psfrr5sXRD4Db94rYXjanbRbksD
         4t/x1UqRWJPtDPnrnd7sdTHuWBvakNTcIOp8i41kcosJKbMwGK8b+CQABLXBmK6haehS
         d1C97JgJ4wGAxFtnhl5w2xid1jqJUYD5CkaZZdMOMVEmwoulIZUJhxPTCgQoUzpBvrua
         RLyQ==
X-Gm-Message-State: AOAM530TFpsP+nwGd2GnH8WeLFAy0x+57D74vewQd5SDP62XGaSXSKq9
        9R15TwqeRKndSQsZxocsZwmneXTSJcdUvQ==
X-Google-Smtp-Source: ABdhPJzeF0jdUPK61TTh4MphvoO73mxFdeLQy8IxZ6Op6ZL7tQlieRfPUoY58Umikzoqtmio64fcZw==
X-Received: by 2002:adf:dc12:: with SMTP id t18mr13782572wri.566.1639139448930;
        Fri, 10 Dec 2021 04:30:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm11898982wmq.38.2021.12.10.04.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:30:48 -0800 (PST)
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
Subject: [RFC PATCH v2 3/5] linear-assignment.c: take "size_t", not "int" for *_count
Date:   Fri, 10 Dec 2021 13:30:40 +0100
Message-Id: <RFC-patch-v2-3.5-580b76c0759-20211210T122901Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.932.g36842105b61
In-Reply-To: <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com> <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Future-proof and clarify the compute_assignment() interface by having
it take a "size_t" for the count of its that it's processing. For the
content itself we need to be able to store a "-1", but there's no
reason we can't use a "size_t" for the size of the number of "int"'s
we've got.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 linear-assignment.c | 10 +++++-----
 linear-assignment.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/linear-assignment.c b/linear-assignment.c
index 7f85745e541..1f8329701a0 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -8,7 +8,7 @@
 
 #define COST(column, row) cost[(column) + column_count * (row)]
 
-static void columns_reduction(int column_count, int row_count,
+static void columns_reduction(size_t column_count, size_t row_count,
 			      int *cost,
 			      int *column2row, int *row2column,
 			      int *v)
@@ -35,7 +35,7 @@ static void columns_reduction(int column_count, int row_count,
 	}
 }
 
-static void reduction_transfer(int column_count, int row_count,
+static void reduction_transfer(size_t column_count, size_t row_count,
 			       int *cost,
 			       int *free_row, int *free_count,
 			       int *column2row, int *row2column,
@@ -60,7 +60,7 @@ static void reduction_transfer(int column_count, int row_count,
 	}
 }
 
-static void augmenting_row_reduction(int column_count,
+static void augmenting_row_reduction(size_t column_count,
 				     int *cost,
 				     int *column2row, int *row2column,
 				     int *free_row, int *free_count, int *saved_free_count,
@@ -123,7 +123,7 @@ static void augmenting_row_reduction(int column_count,
 	}
 }
 
-static void augmentation(int column_count,
+static void augmentation(size_t column_count,
 			 int *cost,
 			 int *column2row, int *row2column,
 			 int *free_row, int free_count,
@@ -218,7 +218,7 @@ static void augmentation(int column_count,
  * The parameter `cost` is the cost matrix: the cost to assign column j to row
  * i is `cost[j + column_count * i].
  */
-void compute_assignment(int column_count, int row_count,
+void compute_assignment(size_t column_count, size_t row_count,
 			int *cost,
 			int *column2row, int *row2column)
 {
diff --git a/linear-assignment.h b/linear-assignment.h
index ef9946bdbfc..9ff055baac1 100644
--- a/linear-assignment.h
+++ b/linear-assignment.h
@@ -13,7 +13,7 @@
  * assignments (-1 for unassigned, which can happen only if column_count !=
  * row_count).
  */
-void compute_assignment(int column_count, int row_count,
+void compute_assignment(size_t column_count, size_t row_count,
 			int *cost,
 			int *column2row, int *row2column);
 
-- 
2.34.1.932.g36842105b61

