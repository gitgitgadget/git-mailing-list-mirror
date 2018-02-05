Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DEBE1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeBFAER (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:04:17 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44334 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeBFAEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:04:15 -0500
Received: by mail-pg0-f66.google.com with SMTP id r1so118173pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JsfQ6iG/RyHorv8bBZdSFiLbXnnMSBQ/xT/+g/7FoNc=;
        b=MGy86kKll7+E9u0QyZTgfAx6jN9vrrmP4xyHO62meKj8o8zbePmZJp9s97OVnWe8cs
         uEw4d9GDuWPrLIRmY9HCEgLrUcVjq7auaYb5EWUy7Ivgw7sfzQD51Af9GeZgDXjzWXgg
         AfGy4A7kJEhUL3BzFkQS9j6qCC9yOEeqfcNOTpeRk67V8tC8kcs+39ANSCUkDENucUzv
         4WeFexrhLMP3Sj8LuZ2ZbT7gXI9iDa5b2Gyqa8qqX6KwbKQ2vYi3JyGGarf3UtM7aVYr
         BfTR0lWit3I5kT1x+orbhhvb6X5Jbnrc2owRDehQNArHqaOP4m8e4qYSmV/LtazRp20o
         jSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JsfQ6iG/RyHorv8bBZdSFiLbXnnMSBQ/xT/+g/7FoNc=;
        b=RSXs3cOpiqQ8Z+QOX9cJvZzWc2AahXCyssiV5cIZJQQUO+h7RDIUznn4zH96m8CtFn
         zJDgS3wXQUKtbuNJpRY2pq0ujMJf7gUIi107wXnEO84vJWfEPeEL7JXSOr7BJDKT4yB3
         f3rAtpSCLayk0PZuEfEQgq1jxj7HkdbtQzfhFTkRocsDe0suB/d6R6/f2mrtvT0596P/
         j+TnYIC71iR7bqlODuXRxS3nIJHm+Zd2C0AL7fxnu1fGJ8l18EOP8deqvY1EDCUewW+d
         TrI6c2oJj/tt7jZkWV0Vmyoq7XHjJatOPBXP0sWuK15NNJTBoxejdk0V51fmfBtMhnXb
         J6Sw==
X-Gm-Message-State: APf1xPBFE8/7zwWL9Gj/hIKYO+VHGRCQdTp98NdzsvfuKReKYRNO48M6
        9TcPnl66RmNU7ASapNHNsrzFLbAh4ZA=
X-Google-Smtp-Source: AH8x227rRqQBJwJyNMnw9I0PBC5YDRQUOcgfE8PLm/HVNSraerNojequcmVXbDKrF7O6iXypJhiMJg==
X-Received: by 10.98.31.131 with SMTP id l3mr523315pfj.116.1517875454549;
        Mon, 05 Feb 2018 16:04:14 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f80sm17576098pfa.1.2018.02.05.16.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:04:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 049/194] replace-object: move replace objects prepared flag to object store
Date:   Mon,  5 Feb 2018 15:55:10 -0800
Message-Id: <20180205235735.216710-29-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove another global variable on the way.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h   | 4 +++-
 replace-object.c | 6 ++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/object-store.h b/object-store.h
index 4ac0ffdb98..e1e592bdd5 100644
--- a/object-store.h
+++ b/object-store.h
@@ -39,6 +39,8 @@ struct object_store {
 		struct replace_object **items;
 
 		int alloc, nr;
+
+		unsigned prepared : 1;
 	} replacements;
 
 	/*
@@ -56,7 +58,7 @@ struct object_store {
 	unsigned packed_git_initialized : 1;
 };
 #define OBJECT_STORE_INIT \
-	{ NULL, MRU_INIT, ALTERNATES_INIT, { NULL, 0, 0 }, 0, 0, 0 }
+	{ NULL, MRU_INIT, ALTERNATES_INIT, { NULL, 0, 0, 0 }, 0, 0, 0 }
 
 struct packed_git {
 	struct packed_git *next;
diff --git a/replace-object.c b/replace-object.c
index cf38c3df00..c865eff0ba 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -73,13 +73,11 @@ static int register_replace_ref(const char *refname,
 
 static void prepare_replace_object(void)
 {
-	static int replace_object_prepared;
-
-	if (replace_object_prepared)
+	if (the_repository->objects.replacements.prepared)
 		return;
 
 	for_each_replace_ref(register_replace_ref, NULL);
-	replace_object_prepared = 1;
+	the_repository->objects.replacements.prepared = 1;
 	if (!the_repository->objects.replacements.nr)
 		check_replace_refs = 0;
 }
-- 
2.15.1.433.g936d1b9894.dirty

