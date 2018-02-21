Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748E01F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeBUB4R (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:56:17 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35498 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeBUByu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:54:50 -0500
Received: by mail-pl0-f67.google.com with SMTP id bb3so91978plb.2
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LQDuA+WYIp55OeaTAU+dEW6lqqKggukAyA6sLb/4jUM=;
        b=Aw+mfw3AOv2KQ/xU8PhwrvM8QBgNR8varAIq0KPGHltykv+z9hpyXiLuInowqbuQfp
         uDY9CCv6rILTK4GUCwcMj/c8l3whdD2vftVCzpSWXvUGPjYBWKrDgf6jLGB8rUJsMf3X
         uaUHIObhOn5b5kw4CMCGp5JPf2LUjRzvNTzriPC7YNmEH4TtUsTSqTE2xxLYnXzhI5/R
         Fyo7oPIYm01+Zb9jdr+G7sb52V1yxaFvt8cg2Fs2o8ReRGXXw2bOf1O/cci0Hf9TB3Xl
         fP39pNOiCo+Dywchxat531PqORsgSE0JaDFA288ZOyU/w4TcHkdcjhVH9qWx8CRVhxaY
         eXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LQDuA+WYIp55OeaTAU+dEW6lqqKggukAyA6sLb/4jUM=;
        b=kLBHcZGqhNIv1pH31taaE8fh7drbGRGgtGwgNknNS8U1qeYljgvpAK80owni7J0C7S
         RTs3Vpwg7HbIgUgmYp0s2BmhipI9VHFbKUlMXdEJhO2WQBo1MYc+yVTChbs4KYas7YOc
         kBWLquz4lqerITqQ5fFh4rXWiPX34Qx9hphnNtxB9LLPTMqUUwtZfAGHCBKuVISaLD4n
         kHnPO1Ra4DffCZ2YlzI8FfwjZ481Qp2f9KMBpPvQPkAYKi7le1EUwY7koZFrhtxcX/xP
         vgp4yy8amPjdp1GY5DDRcL1kQ2iseR4qmy2e926a9i3svK7T6iw9gDNwIUN8gPpBHRt0
         E4HQ==
X-Gm-Message-State: APf1xPDiTvXgS59pdoDPFHalGeDGJ2DFkLWMxq64rtlYC5mzfW7awBWw
        /mizCwCB6NK30E/z9Yg+toi0uV3bCvE=
X-Google-Smtp-Source: AH8x225RY6WFZVWkrahLfuyNNbYvVHSbz3bAwedHeR76xHf3vIYls+mMq0uLwy0Q8XYThWaA26d+ag==
X-Received: by 2002:a17:902:9683:: with SMTP id n3-v6mr1485909plp.177.1519178089903;
        Tue, 20 Feb 2018 17:54:49 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z125sm59082429pfz.27.2018.02.20.17.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:49 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/27] pack: move prepare_packed_git_run_once to object store
Date:   Tue, 20 Feb 2018 17:54:10 -0800
Message-Id: <20180221015430.96054-8-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each repository's object store can be initialized independently, so
they must not share a run_once variable.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 8 +++++++-
 packfile.c     | 7 +++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/object-store.h b/object-store.h
index 1de9e07102..6cecba3951 100644
--- a/object-store.h
+++ b/object-store.h
@@ -92,6 +92,12 @@ struct raw_object_store {
 
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
+
+	/*
+	 * Whether packed_git has already been populated with this repository's
+	 * packs.
+	 */
+	unsigned packed_git_initialized : 1;
 };
 
 /*
@@ -101,7 +107,7 @@ struct raw_object_store {
  * that macro on member variables. Use NULL instead as that is defined
  * and accepted, deferring the real init to prepare_packed_git_mru(). */
 #define __MRU_INIT { NULL, NULL }
-#define RAW_OBJECT_STORE_INIT { NULL, NULL, __MRU_INIT, NULL, NULL }
+#define RAW_OBJECT_STORE_INIT { NULL, NULL, __MRU_INIT, NULL, NULL, 0 }
 
 void raw_object_store_clear(struct raw_object_store *o);
 
diff --git a/packfile.c b/packfile.c
index 511a2b0cdf..a8a2e7fe43 100644
--- a/packfile.c
+++ b/packfile.c
@@ -884,12 +884,11 @@ static void prepare_packed_git_mru(void)
 		list_add_tail(&p->mru, &the_repository->objects.packed_git_mru);
 }
 
-static int prepare_packed_git_run_once = 0;
 void prepare_packed_git(void)
 {
 	struct alternate_object_database *alt;
 
-	if (prepare_packed_git_run_once)
+	if (the_repository->objects.packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
@@ -897,13 +896,13 @@ void prepare_packed_git(void)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
-	prepare_packed_git_run_once = 1;
+	the_repository->objects.packed_git_initialized = 1;
 }
 
 void reprepare_packed_git(void)
 {
 	approximate_object_count_valid = 0;
-	prepare_packed_git_run_once = 0;
+	the_repository->objects.packed_git_initialized = 0;
 	prepare_packed_git();
 }
 
-- 
2.16.1.291.g4437f3f132-goog

