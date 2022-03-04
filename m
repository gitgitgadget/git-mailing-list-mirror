Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50717C4332F
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiCDA7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbiCDA7K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:59:10 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229E1EFFBD
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:58:16 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id g72-20020a62524b000000b004f3e21965e8so4100752pfb.5
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bqdqXeJL9WT1k5g0viCfj7gJvexmtha42dMO/axoffw=;
        b=qM48TkLoXOqJGcMiV1a3AZheyzWTkf2d/lK5qwGT9KitX0nOzweJImh/SWqrEpje+3
         BpKuaQXZ4X6ScOC9lguYX3xoNgysdX7/jFpoUd8PNN4OZUxXW3zoFM/CHY/Lq+IFWwmN
         vnPZpRMT2H8V9ntZx/9rkoOpJfekdnYWe6AKgZdrlNYGc7T64KQmvGxeUol8GCmFPuT4
         uXgdsryp7NOPmi+VAcAS7R3Etyu5+Ie2yeyLNxNGZl4KROqso63+qJBnL7QIGO2KSn7/
         Pk9N+AS3cVLCmrF7MjHWiCgOoqyewukj1M8ff2Ff2U6/0b31gZDMiXKjzt6UECTjxrsB
         3EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bqdqXeJL9WT1k5g0viCfj7gJvexmtha42dMO/axoffw=;
        b=ijSGaRFKLRWF0Gsz/t3MvvzOZaUQDVUsa92I3rBW24EK4yN4bgk9aUxwuMVKMrpM85
         LCEThdqs3Inhas30Ed/rk3saIGlZhKTi1/NjSoR6t9jMUm5PQ2knFeo/YXyn5NX99vqs
         pYQIO4w0ZBh9ucPuE8aWYnndf+VCeez7x0S9O6zUsTvq7MJOQxTTp6Pqa094JPxjDfqm
         2LqnbNEVSe03BOafbhiQ/n8Wa8gpwBbo6upDdNc1HvodhkSCKgkuhA7SGJ3DspB728pj
         zmcErKigI9TWQHbULOK414P7tIUfBM1nC78vQd4S2xn3rgrnDBprickTolpoXMaoe344
         D3Bw==
X-Gm-Message-State: AOAM533lL6BYfkdi4ZoQDhXJbDY+v7u5TwIpAnmrUsM5mq7Z5LF2yTGO
        L9YmsNFTKxj32ACVa+rnbGj5hzwEoEZNOGCTbWuf6AqdQBj/T3+51qgIvV31OBjOSQs9q8IiXxR
        U9GPF5DinmamH6q38nPXuHL8n1bhyvwcijwwYTSBd8EZA23A6a81L9TqCN5wq2Yc=
X-Google-Smtp-Source: ABdhPJxm7BCVQjz5YPCEXkGgmmGI2Jfj9QIxRTMm4uBfau+N3mMiPeAqEhArdZQ0l8h4xR+JUMaBABXQcmtTMA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e051:b0:151:b485:3453 with SMTP
 id x17-20020a170902e05100b00151b4853453mr3342794plx.116.1646355495489; Thu,
 03 Mar 2022 16:58:15 -0800 (PST)
Date:   Thu,  3 Mar 2022 16:57:52 -0800
In-Reply-To: <20220304005757.70107-1-chooglen@google.com>
Message-Id: <20220304005757.70107-6-chooglen@google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com> <20220304005757.70107-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 05/10] submodule: inline submodule_commits() into caller
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When collecting the string_list of changed submodule names, the new
submodules commits are stored in the string_list_item.util as an
oid_array. A subsequent commit will replace the oid_array with a struct
that has more information.

Prepare for this change by inlining submodule_commits() (which inserts
into the string_list and initializes the string_list_item.util) into its
only caller so that the code is easier to refactor later.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/submodule.c b/submodule.c
index 4f3300f2cb..3bc189cf05 100644
--- a/submodule.c
+++ b/submodule.c
@@ -782,19 +782,6 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 	return submodule_from_path(the_repository, null_oid(), ce->name);
 }
 
-static struct oid_array *submodule_commits(struct string_list *submodules,
-					   const char *name)
-{
-	struct string_list_item *item;
-
-	item = string_list_insert(submodules, name);
-	if (item->util)
-		return (struct oid_array *) item->util;
-
-	/* NEEDSWORK: should we have oid_array_init()? */
-	item->util = xcalloc(1, sizeof(struct oid_array));
-	return (struct oid_array *) item->util;
-}
 
 struct collect_changed_submodules_cb_data {
 	struct repository *repo;
@@ -830,9 +817,9 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		struct oid_array *commits;
 		const struct submodule *submodule;
 		const char *name;
+		struct string_list_item *item;
 
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
@@ -859,8 +846,11 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		if (!name)
 			continue;
 
-		commits = submodule_commits(changed, name);
-		oid_array_append(commits, &p->two->oid);
+		item = string_list_insert(changed, name);
+		if (!item->util)
+			/* NEEDSWORK: should we have oid_array_init()? */
+			item->util = xcalloc(1, sizeof(struct oid_array));
+		oid_array_append(item->util, &p->two->oid);
 	}
 }
 
-- 
2.33.GIT

