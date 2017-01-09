Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA85E1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 19:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbdAITq5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 14:46:57 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35665 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763998AbdAITqg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 14:46:36 -0500
Received: by mail-pg0-f50.google.com with SMTP id 194so16692197pgd.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 11:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yCZiW3/JS+Efy6IYWCoXjnnJjxBWCvbvJH0ZSVG+YXc=;
        b=DRAD7tFATAHmWVFGowwimM/zdwIZ9ukmijee19YxU+GKJnIXykQX3qBhX/sCwthlLM
         mo3FZJkuX7XIxIQmJW2HS3TFOPTBvbb6xlDEG4ZdoysqgT+55/hRY56KugbSChESvvbv
         bsrFDbbZx+Mw7FIYtqPZJBq0TJ4b/6hrAaC5smsTJjslPieXHQX03yptyutgza+pFVaL
         vpdTtWDfkv0aDRNjFsJgYfjrBRBbGFYx8HalgS6lZNBt0UhlArXudK8cVqx6Hq5seZiz
         Pw6MEvnF9ntN+3oXLQWtN+MIoVSpTCDjRnCP4YycgCMLjGmZgmCG3q4+UQ+5wU9FedIh
         mtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yCZiW3/JS+Efy6IYWCoXjnnJjxBWCvbvJH0ZSVG+YXc=;
        b=revMTK8kvYAEwTS3b19i9buTvnjezKA0YdvTbcIa085vRuwqJkyoD9FCwfPBcx+3eM
         jvse6TPz36gIyyEVlVXvbVksgWIj7GkziCt88ymihDpObjGtRXOTNhO1THjN2QqZKMIT
         VH7VfSrDGp0dwwPBey5wROp0tF2Cqu3ajYcsbm6zHmLewaUR8yGe7HpMWJklBIYR72HN
         AqH/tIfeR4hi//P6OIdshc4CutEHQwq3tQDEzZaI3ZAp/NVmQYFXHz4+Y4sTfnvdSK6H
         jiEZl/e5Weotg0xWImfzdcYyJ0Xbw/Osh6x1EyD0xYQeBUU1neK4F75fbFtbZQ8GHU6m
         LTHA==
X-Gm-Message-State: AIkVDXI/ctRTBBn9DjbPtIMxHI/m93xnvZV8ccKlhCaFi8JscywtmXmRC0h1SmBmJY3T6Qzw
X-Received: by 10.84.217.19 with SMTP id o19mr188761580pli.21.1483991196197;
        Mon, 09 Jan 2017 11:46:36 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:45b6:2235:29e9:acb7])
        by smtp.gmail.com with ESMTPSA id 135sm182768327pgc.7.2017.01.09.11.46.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 11:46:35 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/5] unpack-trees: factor file removal out of check_updates
Date:   Mon,  9 Jan 2017 11:46:20 -0800
Message-Id: <20170109194621.17013-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
In-Reply-To: <20170109194621.17013-1-sbeller@google.com>
References: <20170109194621.17013-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes check_updates shorter and easier to understand.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index b564024472..ac59510251 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -218,6 +218,26 @@ static void unlink_entry(const struct cache_entry *ce)
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
 
+static unsigned remove_workingtree_files(struct unpack_trees_options *o,
+					 struct progress *progress)
+{
+	int i;
+	unsigned cnt = 0;
+	struct index_state *index = &o->result;
+
+	for (i = 0; i < index->cache_nr; i++) {
+		const struct cache_entry *ce = index->cache[i];
+
+		if (ce->ce_flags & CE_WT_REMOVE) {
+			display_progress(progress, ++cnt);
+			if (o->update && !o->dry_run)
+				unlink_entry(ce);
+		}
+	}
+
+	return cnt;
+}
+
 static struct progress *get_progress(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
@@ -254,15 +274,8 @@ static int check_updates(struct unpack_trees_options *o)
 
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
-	for (i = 0; i < index->cache_nr; i++) {
-		const struct cache_entry *ce = index->cache[i];
 
-		if (ce->ce_flags & CE_WT_REMOVE) {
-			display_progress(progress, ++cnt);
-			if (o->update && !o->dry_run)
-				unlink_entry(ce);
-		}
-	}
+	cnt = remove_workingtree_files(o, progress);
 	remove_marked_cache_entries(index);
 	remove_scheduled_dirs();
 
-- 
2.11.0.rc2.30.g7c4be45.dirty

