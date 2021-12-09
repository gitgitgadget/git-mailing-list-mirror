Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF33C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhLITXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhLITXN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:23:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A0BC0617A1
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 11:19:39 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso7368166wml.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 11:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=soEG8FjrNLymnyUbqt0cAIgGHU6sN7MijO46uT9zSs8=;
        b=YUqzrRQg9sSAwK7jCgYH7U43+la0L9BgeFyUg9k8CJA2R45bgqSgPsX2ZObxa//Tqy
         oIGbhpuaBGpYNftAKNrAmAXATaWFH73lyZMflCMvnzqpI9sSMmi/EeWeobR37XR0ceqP
         mzZ3EHRYnZWF6ht780R9fVr3nWxiP96DYVmIRONcSxTq9kdyPfujVT/AqRioqGJHOCKa
         H3o7lZAbBoiRAoAHX6psxMyymx1lT7X11rOmMLCOTN3saMZ90wG+ULxLvbEQgsDXYlyf
         zO3IN7QRHcTNtx6oOjlHZ2Xq1dim5QdfAGtizifywH/4763EDlAgy6MaD4FedprvN70l
         L/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=soEG8FjrNLymnyUbqt0cAIgGHU6sN7MijO46uT9zSs8=;
        b=SkGIbPt3eHrsQOH/D0K4EN1GiwEC8JaMLEmXUmAj2QYjLiTv4vmY40qkke1nrsJ+Ow
         Tb52zzp7PkXjrV09XZOdE5rOKl05lWn9KSbDlCFLzxxHn1tAGqSR7xn02APNcf9WcGYj
         2djphWoMGyk264sxkIRF0KnHUCFi8m3xlpH1naRCWllMjcCFD7jGbOl/mq2fY3hx0+Pf
         vvAZY5YtdHg+2KQ4XGSSThYoA8muMB4VtiqWbHz2MTh0KlK1WCZ3RP4T/YYsr1AAOqYA
         SdqOEfXtZiKuHWFzZdbqpPuSo66AG7zMc2tR+r9fVW/MFxO6b8WbKy++8eAjqrWyO9OR
         W+Rw==
X-Gm-Message-State: AOAM532LIAnMmfMZ/e8mlTYQZ0o1rLeiKMeZWqHByXKBthaD/GHAhPST
        CimqfqzTKGnnOaX89zW97pY1QdJa1AraVw==
X-Google-Smtp-Source: ABdhPJzfjtoo8mgBGWxbYCeJamWzUVojhXIiIhWwSXCJmFFYvCIEbzGliI8nyaO/Puz9tTZmUQ5p0g==
X-Received: by 2002:a1c:20d3:: with SMTP id g202mr9683401wmg.129.1639077577397;
        Thu, 09 Dec 2021 11:19:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x13sm562180wrr.47.2021.12.09.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:19:36 -0800 (PST)
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
Subject: [RFC PATCH 06/10] linear-assignment.c: take "size_t", not "int" for *_count
Date:   Thu,  9 Dec 2021 20:19:23 +0100
Message-Id: <RFC-patch-06.10-9b697720e00-20211209T191653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g0f9292b224d
In-Reply-To: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
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
2.34.1.930.g0f9292b224d

