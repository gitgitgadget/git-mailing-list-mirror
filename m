Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5138C4320E
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2DF60E09
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhGaCmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhGaCml (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 22:42:41 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524EDC0613D3
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g11so7811952qts.11
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1SyOISdkElOPM7n0bzDUfpIASL6wpbMQYplYMMY2wk=;
        b=VaicHJ2giloDsDX3bdU4UU2nho1OYLtJQGSj4Q0dsEAoQ8snLg0Fc7ocbmkG5a2I7P
         2oj3qOlAeQpBOuYINGXjkwtzobWNQ3qDJ8IMnVpLZu4FhminQs/cWjaIKO75pX4alabU
         OMf5QzU441TTrPZNtRynKLrMjuQY3ZV7s3x+2gBcJofHyV+goWCjjChigXmdBeH3qCuy
         Gcr6SLxixTPQ39BiFNNu0ALFNGu21LUea797qotkyMVWf9WvLnIQfg/0l1L82G9F7zW6
         9dm5JKyfZ+icZXeWd/uO0TrQUnIS4btMOESdqte6eCHZ7XfMdBC1QsjPhMpTWiWgoZ3q
         Oirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1SyOISdkElOPM7n0bzDUfpIASL6wpbMQYplYMMY2wk=;
        b=U3KAG3tmTpf0MaFqkNzL3Or5pbSD7+ffr/FDYzTDEjf3JOpn9tHfhj/hMpUXOSRvol
         AW50nmJgVvbULSPAJZ6Fhufhiwhyyxub/yV54NDo/LGNdBTPbYB/6+LlENf+dN+FJug2
         /bSFCiIAjnpCEnAEDZXPPDZNASXxxFEpUsOCnF8w1OLlz7PBmTCtRhLDa/TQ5oB85VNL
         mLp1kZ/kRQYW9BqVH954XYMU0FJLpAZUNKbkrB80v3SXh3Hg0EZtyMHEbrFx8bwL+NXn
         3qb3x9kzhPHUMFQxY0l0pYD7cSwxqZi4JK9oov5XG+BvUGsi5zBFfg1N2BGEs6NZ5ohF
         YCVQ==
X-Gm-Message-State: AOAM532nD1UfRQV4WChplRGLDvz3iXyecz4lS8dOrW79m0wdx9neYz3L
        fFNxZMyoobnGPsGZYsvLrSgz/8AmPlFjgQ==
X-Google-Smtp-Source: ABdhPJxCK68TGaEA85bPYzHaQZ25qZIyXKPh4OlRjHSaf8Uoczd7dqp34l5e901y42qSnNJTAHwxVQ==
X-Received: by 2002:ac8:7388:: with SMTP id t8mr5043805qtp.96.1627699355410;
        Fri, 30 Jul 2021 19:42:35 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id w20sm1958498qkj.27.2021.07.30.19.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 19:42:35 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 6/6] globals: remove explicit `0` initialization from globals
Date:   Fri, 30 Jul 2021 22:42:21 -0400
Message-Id: <20210731024221.2113906-7-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731024221.2113906-1-mathstuf@gmail.com>
References: <20210731024221.2113906-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git relies on implicit zero-initialization of global variables.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 object-file.c | 2 +-
 progress.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index ecca5a8da0..6a04013342 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1503,7 +1503,7 @@ static int loose_object_info(struct repository *r,
 	return (status < 0) ? status : 0;
 }
 
-int obj_read_use_lock = 0;
+int obj_read_use_lock;
 pthread_mutex_t obj_read_mutex;
 
 void enable_obj_read_lock(void)
diff --git a/progress.c b/progress.c
index 680c6a8bf9..4fb4233b67 100644
--- a/progress.c
+++ b/progress.c
@@ -52,7 +52,7 @@ static volatile sig_atomic_t progress_update;
  * for 'test-tool progress'.
  */
 int progress_testing;
-uint64_t progress_test_ns = 0;
+uint64_t progress_test_ns;
 void progress_test_force_update(void)
 {
 	progress_update = 1;
-- 
2.31.1

