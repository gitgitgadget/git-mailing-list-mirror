Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578D61F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeBMBX4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:56 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39867 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933053AbeBMBWz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:22:55 -0500
Received: by mail-pl0-f65.google.com with SMTP id s13so2266514plq.6
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZsXWXpYXbPcttkvsU5/cRPqchZvuoXRh2Vc5UNZtO2U=;
        b=QaGLAhcc3eeAO33K4pZHjgRtT83g3dHa5KamPFhBDJb9ln2UdvYMobN7vm8dX5MfrR
         Fo6TKK1XynHngVjXXk8qNPvNKry1LT7JVO382TDUPZkC0Eos2pyDvXWQMi/nmwZ+GIkX
         MxWnnzKEXlxZD2LVkpz7E4RPLRWVMta3JrxC4fSUPA/Nh8z+XCO4aFpY1zJlVs91vJ+m
         j4CgBDxDcrp+gPD3kXfBcO5klGv8ar+0GPme6Z+4LFvRF0bO9mNgjY9o0U5Z1V0x3Vw5
         Ebj5UVd1wIsgZupIHsjAWcBJnzgx9zvweqLp4h8VQI92WH+e+UuQqmLmp3aOSmw6cC9J
         /dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZsXWXpYXbPcttkvsU5/cRPqchZvuoXRh2Vc5UNZtO2U=;
        b=Ea4tlPQZWJ9WvCI8nKAsTjWfVs59EBG0uEZC1PYc27Url77HWovLePgKMc8oUmvHvT
         m4ilfCrouaLuvnmrapzujX+A6166z6TuHlsz4ThrdV1dduDRaaavaMRsVLbFweKIpLFj
         Tgxl+mlA6s6aZy8zv/mwh9qpFptnqBJFnQXImQkp1qA0N8YEQYmMyVBme3kW5EWJtEY9
         eHYheJerfLLP5uPJ1MRCRzSJUOxEqQu0eBhyzU+HZkCrvh6ZjH5yLUZhGPq0x6fDt1Wh
         +srmn/yfj2HWV1kTYsODmd9WTcVb1iz1/9PwAFAnNGIkExD6Pd3ASDsBbSFJAtUUSVkO
         ezSA==
X-Gm-Message-State: APf1xPALFAIdKa2G5vZBOmqmtRKVjwbB7B7eDQy5LRGOoMKhG4Vp0GpY
        SetLaAqhqReqwr899sMpIohRDsfAr9k=
X-Google-Smtp-Source: AH8x2248ZL92H5Ve9YaD6AAVFrFG6QmT/cvctuqSAMt/WzH7pGbUrVkd8+saVT8Hri04SBSMBb4TDQ==
X-Received: by 2002:a17:902:a5c5:: with SMTP id t5-v6mr12531258plq.160.1518484974889;
        Mon, 12 Feb 2018 17:22:54 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e82sm70193pfk.114.2018.02.12.17.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:22:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/26] pack: move prepare_packed_git_run_once to object store
Date:   Mon, 12 Feb 2018 17:22:21 -0800
Message-Id: <20180213012241.187007-7-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Each repository's object store can be initialized independently, so
they must not share a run_once variable.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 8 +++++++-
 packfile.c     | 7 +++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/object-store.h b/object-store.h
index 8778ab9685..9fd109fa9c 100644
--- a/object-store.h
+++ b/object-store.h
@@ -20,8 +20,14 @@ struct raw_object_store {
 
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
+
+	/*
+	 * Whether packed_git has already been populated with this repository's
+	 * packs.
+	 */
+	unsigned packed_git_initialized : 1;
 };
-#define RAW_OBJECT_STORE_INIT { NULL, NULL, MRU_INIT, NULL, NULL }
+#define RAW_OBJECT_STORE_INIT { NULL, NULL, MRU_INIT, NULL, NULL, 0 }
 
 void raw_object_store_clear(struct raw_object_store *o);
 
diff --git a/packfile.c b/packfile.c
index 2ce1b2cef7..c107fce171 100644
--- a/packfile.c
+++ b/packfile.c
@@ -873,12 +873,11 @@ static void prepare_packed_git_mru(void)
 		mru_append(&the_repository->objects.packed_git_mru, p);
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
@@ -886,13 +885,13 @@ void prepare_packed_git(void)
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
2.16.1.73.ga2c3e9663f.dirty

