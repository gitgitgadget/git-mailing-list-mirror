Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE6451F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeBEXzr (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:55:47 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41268 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeBEXzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:40 -0500
Received: by mail-pg0-f68.google.com with SMTP id 141so104865pgd.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zr1kRmrW3NSrxm8xmQqBsxEO0ckV0b41Zg9PSB4IytE=;
        b=JAeNGoNFQC+J/3aCcFeEn6JDUvxMcnxaj9S0mPLaXFvzyLKrju59X4CR7MbV7WJ0ar
         4EtQRNsMcrBmGalHdQMJ0ed/Nk5Q5SB7F2X1NhXyuqIrr02Zy8cA06hyOst+fCzTrrv7
         vcY5Ou7tcbHWBi00W6OfdU0P6fbYikpiEQlV5MawuC1/xXlqAhh17W6mh0NQXn4LAMRZ
         2PAIZNcDuIcTDkgJyQjQFG5+jm5u6vG8OfSHsKizg3OBCQfRO7pbQRou69G9pBPSWIpV
         jWTXyg3she9TslECpPfaWLt35MEAfOhc5azHCQFBxYldbvP9GpfmWlol9Y9k+mwJnrHP
         Ljpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zr1kRmrW3NSrxm8xmQqBsxEO0ckV0b41Zg9PSB4IytE=;
        b=UXA6Ggg1XbL+BBV9m1sNdhzHLN62x1DXd+qNrmEYUYEwbdo+1wBiGWnySF6I5mAuaU
         XWFDUGJhho6/JiRNVZJXV+dPHVtu45+BjCm5PR7GsHeKOhLWGCCGPLjpXc2qJY1iuFyQ
         VB79rZJkh3G8CkjvL1te0VbyQo+604xgq2pBq8eOjG+HJ/B1NZQt7fQ5qzM3L8jGe5hg
         sCe8eBvjRxA6fyRI/uBfpWBqInxDMoYdKUHHpRuKvyqFh90JhkTsSLnS0BJpC7sN8FOc
         /QnprFfDFSdTGu9P+FbPWXz9n4URfsu64FNhjbgVd+HC6uu/RKSYcpWbyKZX8bOFE/B3
         /QMg==
X-Gm-Message-State: APf1xPC2YXqZfuR9xWiJZo1KqV/MpZ4gbi64/qopibx6tevNuClbTy9g
        l6jUtxDrU6lUgCL6OzN1zwc4quqKoeg=
X-Google-Smtp-Source: AH8x227jHjRG5TAF9tcP6RzS0s15Zys1wUrOxVvh7Mz0yJWr4ABdNix8qVHzi5RQMzOdm6sE5qaAww==
X-Received: by 10.98.129.5 with SMTP id t5mr518154pfd.6.1517874939500;
        Mon, 05 Feb 2018 15:55:39 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m1sm5309141pfi.120.2018.02.05.15.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 005/194] pack: move approximate object count to object store
Date:   Mon,  5 Feb 2018 15:51:59 -0800
Message-Id: <20180205235508.216277-6-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

The approximate_object_count() function maintains a rough count of
objects in a repository to estimate how long object name abbreviates
should be.  Object names are scoped to a repository and the
appropriate length may differ by repository, so the object count
should not be global.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 10 +++++++++-
 packfile.c     | 11 +++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/object-store.h b/object-store.h
index 14129fbba1..99f77d10cd 100644
--- a/object-store.h
+++ b/object-store.h
@@ -16,13 +16,21 @@ struct object_store {
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
 
+	/*
+	 * A fast, rough count of the number of objects in the repository.
+	 * These two fields are not meant for direct access. Use
+	 * approximate_object_count() instead.
+	 */
+	unsigned long approximate_object_count;
+	unsigned approximate_object_count_valid : 1;
+
 	/*
 	 * Whether packed_git has already been populated with this repository's
 	 * packs.
 	 */
 	unsigned packed_git_initialized : 1;
 };
-#define OBJECT_STORE_INIT { NULL, MRU_INIT, NULL, NULL, 0 }
+#define OBJECT_STORE_INIT { NULL, MRU_INIT, NULL, NULL, 0, 0, 0 }
 
 struct packed_git {
 	struct packed_git *next;
diff --git a/packfile.c b/packfile.c
index 177aa219f9..31c4ea54ae 100644
--- a/packfile.c
+++ b/packfile.c
@@ -793,8 +793,6 @@ static void prepare_packed_git_one(char *objdir, int local)
 	strbuf_release(&path);
 }
 
-static int approximate_object_count_valid;
-
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -804,8 +802,8 @@ static int approximate_object_count_valid;
  */
 unsigned long approximate_object_count(void)
 {
-	static unsigned long count;
-	if (!approximate_object_count_valid) {
+	if (!the_repository->objects.approximate_object_count_valid) {
+		unsigned long count;
 		struct packed_git *p;
 
 		prepare_packed_git();
@@ -815,8 +813,9 @@ unsigned long approximate_object_count(void)
 				continue;
 			count += p->num_objects;
 		}
+		the_repository->objects.approximate_object_count = count;
 	}
-	return count;
+	return the_repository->objects.approximate_object_count;
 }
 
 static void *get_next_packed_git(const void *p)
@@ -890,7 +889,7 @@ void prepare_packed_git(void)
 
 void reprepare_packed_git(void)
 {
-	approximate_object_count_valid = 0;
+	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
 	prepare_packed_git();
 }
-- 
2.15.1.433.g936d1b9894.dirty

