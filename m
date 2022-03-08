Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C7FC433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbiCHAQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243248AbiCHAP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:15:59 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7496F37A24
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:15:02 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id bh9-20020a056a02020900b0036c0d29eb3eso9283792pgb.9
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 16:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bqdqXeJL9WT1k5g0viCfj7gJvexmtha42dMO/axoffw=;
        b=OYRitHcEV1Fh8KENCf7PwMh8WaTNMzlOfhis/3pfSYvZr8PNaD/yeYKBC+D+i+7JGR
         5iJkLwjp18DRYrc5+Tn5oKRZ8pkmGG7MaJ2Q9qB/Xz7envoqlP4/z57BidYtRNhdiVlf
         SPkm5hxM3uxTEx1sbxzjsTwN1slvIcthbj2sOaE4uNfWF/Aj7DmTt3CBW4ISiZqnJnOq
         dLl3nL82GsCdQKxg1LfypKR3hku9V9lKDynjUd/NhJf0GkxB4degid657EhyfTR8wqYZ
         RK5l/ROJ8VmUOD6YXZuRQ1fyJSd/8h5vljckPAQDdJlPm/ZbSkYibzeWtlMsjqSgM5R/
         gPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bqdqXeJL9WT1k5g0viCfj7gJvexmtha42dMO/axoffw=;
        b=gcwA1CPnKwJ9XykVNVJkvv4Cge8L07zdgDIIwVWIu5OftZSwue00DkM2q62WG1coQp
         4sJG1ySAQFOW9gc6iVQy3pvmc9JbbaX0Vk+vYtsw/D8YwmwjqcQwSNuCoxmaqTJxrwLN
         d18y0z1bSz8t9vnEvN2CeVxUla+dsnWKgUsvzmcvfPdL79s8FOlFKGk/zetTHPsKeqp/
         lBQUAbDMwxwAkRCzei2VBUkBzwjH2Q31yyYkjlCrPDJUqNm0k2kJSTyzGXPZ2a5O6M+y
         updlK2Rq1OYH1duS/MUQH0p2AeZHqiLZQBEazPLF9IGV3Tw8ctANfgs2bcDbfr/mkD3+
         Y1Eg==
X-Gm-Message-State: AOAM533ergX5Oc84u+vi/HQJ8HjBA9bKjVJDA4a3sb16IvWiV8owejoy
        94aiD+7tiMNR2zCSSXST0KFNOT+lf3VvKyEbRsL7hc3tC1oqn3M8sEDMKGQ26yCJ2MZp1Ek/ymA
        O9OD6Rx+f2q1wKvnB2G+esTvsendIFZiQ3nlm/T9Mys/EdqiVkRcLsl6hGVbNTJk=
X-Google-Smtp-Source: ABdhPJx0oTxvmMH4vwloTr/3iBQbupuA9fRROPOPPbpjY8IZ6mvGBOFDf8QNBnR2Gzt8DLepcrZE7FiSmyD6rA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3506:b0:1bf:3dad:aebe with SMTP
 id ls6-20020a17090b350600b001bf3dadaebemr1647325pjb.235.1646698501502; Mon,
 07 Mar 2022 16:15:01 -0800 (PST)
Date:   Mon,  7 Mar 2022 16:14:28 -0800
In-Reply-To: <20220308001433.94995-1-chooglen@google.com>
Message-Id: <20220308001433.94995-6-chooglen@google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 05/10] submodule: inline submodule_commits() into caller
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

