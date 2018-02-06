Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845211F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeBFAYQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:24:16 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38978 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeBFAYP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:24:15 -0500
Received: by mail-pl0-f67.google.com with SMTP id o13so128192pli.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ge5WgeDpaNWB78TAuW6XeiL9l3fJAyJhL2S5DQoWspE=;
        b=PXfbYnSJECVAa4W7El0Be9jmHMiVrMWZuNMhyRl4eeGIx6GOJ9f567Xfzxfxbq9Rhs
         4v9EEWiH/5maJ8IndmccwU+b+7/Tuint5+LlIaT3884nvm2/wlcCLB0K5BUkj02e/xHm
         DmPXv/HGWsN0yMrEfijunWMpevR1wEo0pP6ylvH93frdfQWg/ODPi+xKsFIavrzQxx++
         8UkNoiqDq+jmIypTKJXTnl8YMo+K4XFNRtk4HsJ/uO5Ph8Vu3x0FD7qIjI+bhSj+weRw
         lBM8E/JiHaqk2pTEdKW+1p7Fd4xgwujmQr9HpPSeutMlhin8cUryvditOPiFIlOVjXEz
         j3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ge5WgeDpaNWB78TAuW6XeiL9l3fJAyJhL2S5DQoWspE=;
        b=Z/IcaraSyJ2IWVKUIdTuqz2+3iXExed/YeXQvJbwMKZzgt7/aJ7UAEPoSBnRRD/dBb
         IrYThK8fNbYSBpeWPtS6c4Mqiau4R8rd2GuX9amLzAbAI02ztpL9FaDncEqNekHldEH1
         wNpnYrk24rLsY4JyX5LeXk7A1S1Hr9W6QjGOPuA2WKudN/1MEfCfli07LbZZq2VOQ2Sy
         2H0IJS/sTzC5XgmXbvZmrlqDEIMgVBAGoigsEDIALzBerS9KgfAVRRISlCiMB2Zdw093
         639Y+iAya0vCvsxVgH47uoKZYD7R+rvIhgv0tDd9SkU2bMTft0xZd9rhHU/P/keSfMU4
         GWlQ==
X-Gm-Message-State: APf1xPCnZKyYPdc16gzwai7QisTyj8yP5NwGHqopNuR1Eb3vD+EMWDwB
        wJG8m59Zl05L3I/NBMdK3gxhR0JO+Rg=
X-Google-Smtp-Source: AH8x226uGZRmucZxNDjBEjxhZayl1tgRJaawC7eBP7k0VmILnwgJe5s89Mq6/vtexpeYKBcng+gGNA==
X-Received: by 2002:a17:902:788c:: with SMTP id q12-v6mr553010pll.259.1517876654601;
        Mon, 05 Feb 2018 16:24:14 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e12sm15390835pgu.48.2018.02.05.16.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:24:14 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 138/194] commit: allow lookup_commit to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:53 -0800
Message-Id: <20180206001749.218943-40-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 10 +++++-----
 commit.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 17bdd13e0d..435735ed2c 100644
--- a/commit.c
+++ b/commit.c
@@ -50,13 +50,13 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 	return c;
 }
 
-struct commit *lookup_commit_the_repository(const struct object_id *oid)
+struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(r, oid->hash);
 	if (!obj)
-		return create_object(the_repository, oid->hash,
-				     alloc_commit_node(the_repository));
-	return object_as_type(the_repository, obj, OBJ_COMMIT, 0);
+		return create_object(r, oid->hash,
+				     alloc_commit_node(r));
+	return object_as_type(r, obj, OBJ_COMMIT, 0);
 }
 
 struct commit *lookup_commit_reference_by_name(const char *name)
diff --git a/commit.h b/commit.h
index f791a55379..41a8947b33 100644
--- a/commit.h
+++ b/commit.h
@@ -46,8 +46,7 @@ enum decoration_type {
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
-#define lookup_commit(r, o) lookup_commit_##r(o)
-struct commit *lookup_commit_the_repository(const struct object_id *oid);
+struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
 #define lookup_commit_reference(r, o) \
 		lookup_commit_reference_##r(o)
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
-- 
2.15.1.433.g936d1b9894.dirty

