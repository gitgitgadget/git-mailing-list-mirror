Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7469C3526D
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiAZNGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbiAZNGB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:06:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D150C061755
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:58 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso4217899wms.4
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7frHrKSDoOqyYfdgR4JQWSleb705I+rDNQOnW/uiuno=;
        b=WInRqxLMDgHWpCPQ5A3MWdlDdECnQpHy3mcp7E4KLCnrG+9MW1n5EA0sz7poHMdXIR
         J68BBpzFR3Dlpj/ezqBcQOrU9w/C3+hBsAIJhEWkPQk9Vaf9iStPsLCAjJUIfaXVbsGf
         GziG8KNVdGcZpkRYF5uxBcCBoRR8MF/IquAAmpbdOlt7CeShfU/HQDokBh355ALXCqbu
         M5tRlPNVKKAwRdL2Hekg9dE4upwegRD28eYCs6AdXISm4dfuzGEJerMxaYor8hFucFqJ
         E1L5mqGYSMvIkZQmHVeq2KusmlPWUffTbs1ZlJbRefmzbrNMEz4a2cYNB4422aP/R6+s
         w/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7frHrKSDoOqyYfdgR4JQWSleb705I+rDNQOnW/uiuno=;
        b=e7WpwK9juPGwLZ32j0KA06ER2FZ9gQW0RcxtOcMa+h7S1NqQcU0CaIcw/wa0rw5eZl
         Qs+CG1EsndQzRmaDQDkJL4xqvQe9e2koORqblR/ZOCpoKriCe5akDzxp4oKCRuZzBEwV
         h3HxA/F12wyuG6kKOCfFAFb6GCmYpX6T2HBMaWnyWFWqhalk8S5RsOcXdkXVKLwyeISO
         QZUNtzBoOh5dnZSRUxuEP6pGgEb+Y+DD1glqJ1GbPYUzDt0nhYz8J/wD9UgN7ETtGymE
         R0DXT8lOjhQCDGxjTOI9uPtWFpTX4yibTSeUMXWduKblrudg7kj57AytJLgUM5bokyzG
         i24w==
X-Gm-Message-State: AOAM5332hXXbYTsvd7DT7pXDb4qYGl/FV4cqA65ffEwzzKPkDSr5gQwM
        vZ3XmoHQZKqHEJXHuZDBVJSBlRDCvek=
X-Google-Smtp-Source: ABdhPJzHeIwy0AxsANoXRW7egSU7TMupoXyfLhgVWWQ7Fl1Q5CXTywvW2AwwSkvwlNDvKIIb9MgWNA==
X-Received: by 2002:a05:600c:5028:: with SMTP id n40mr7211376wmr.10.1643202357002;
        Wed, 26 Jan 2022 05:05:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm20738928wrp.14.2022.01.26.05.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:05:56 -0800 (PST)
Message-Id: <688ebc45bf7410dea4c3454f98f69fb2212938e5.1643202349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 13:05:42 +0000
Subject: [PATCH v3 07/14] reset_head(): factor out ref updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In the next commit we will stop trying to update HEAD when we are
removing uncommitted changes from the working tree. Move the code that
updates the refs to its own function in preparation for that.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 reset.c | 110 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 62 insertions(+), 48 deletions(-)

diff --git a/reset.c b/reset.c
index 7841b2b2a02..56d6e2a06d9 100644
--- a/reset.c
+++ b/reset.c
@@ -8,25 +8,75 @@
 #include "tree.h"
 #include "unpack-trees.h"
 
+static int update_refs(const struct object_id *oid, const char *switch_to_branch,
+		       const struct object_id *head, const char *reflog_head,
+		       const char *reflog_orig_head,
+		       const char *default_reflog_action, unsigned flags)
+{
+	unsigned detach_head = flags & RESET_HEAD_DETACH;
+	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
+	struct object_id *old_orig = NULL, oid_old_orig;
+	struct strbuf msg = STRBUF_INIT;
+	const char *reflog_action;
+	size_t prefix_len;
+	int ret;
+
+	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
+	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
+	prefix_len = msg.len;
+
+	if (update_orig_head) {
+		if (!get_oid("ORIG_HEAD", &oid_old_orig))
+			old_orig = &oid_old_orig;
+		if (head) {
+			if (!reflog_orig_head) {
+				strbuf_addstr(&msg, "updating ORIG_HEAD");
+				reflog_orig_head = msg.buf;
+			}
+			update_ref(reflog_orig_head, "ORIG_HEAD", head,
+				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
+		} else if (old_orig)
+			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+	}
+
+	if (!reflog_head) {
+		strbuf_setlen(&msg, prefix_len);
+		strbuf_addstr(&msg, "updating HEAD");
+		reflog_head = msg.buf;
+	}
+	if (!switch_to_branch)
+		ret = update_ref(reflog_head, "HEAD", oid, head,
+				 detach_head ? REF_NO_DEREF : 0,
+				 UPDATE_REFS_MSG_ON_ERR);
+	else {
+		ret = update_ref(reflog_head, switch_to_branch, oid,
+				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+		if (!ret)
+			ret = create_symref("HEAD", switch_to_branch,
+					    reflog_head);
+	}
+	if (!ret && run_hook)
+		run_hook_le(NULL, "post-checkout",
+			    oid_to_hex(head ? head : null_oid()),
+			    oid_to_hex(oid), "1", NULL);
+	strbuf_release(&msg);
+	return ret;
+}
+
 int reset_head(struct repository *r, struct object_id *oid,
 	       const char *switch_to_branch, unsigned flags,
 	       const char *reflog_orig_head, const char *reflog_head,
 	       const char *default_reflog_action)
 {
-	unsigned detach_head = flags & RESET_HEAD_DETACH;
 	unsigned reset_hard = flags & RESET_HEAD_HARD;
-	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
-	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
 	struct unpack_trees_options unpack_tree_opts = { 0 };
 	struct tree *tree;
-	const char *action, *reflog_action;
-	struct strbuf msg = STRBUF_INIT;
-	size_t prefix_len;
-	struct object_id *old_orig = NULL, oid_old_orig;
+	const char *action;
 	int ret = 0, nr = 0;
 
 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
@@ -48,7 +98,9 @@ int reset_head(struct repository *r, struct object_id *oid,
 		oid = &head_oid;
 
 	if (refs_only)
-		goto reset_head_refs;
+		return update_refs(oid, switch_to_branch, head, reflog_head,
+				   reflog_orig_head, default_reflog_action,
+				   flags);
 
 	action = reset_hard ? "reset" : "checkout";
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
@@ -92,48 +144,10 @@ int reset_head(struct repository *r, struct object_id *oid,
 		goto leave_reset_head;
 	}
 
-reset_head_refs:
-	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
-	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
-	prefix_len = msg.len;
-
-	if (update_orig_head) {
-		if (!get_oid("ORIG_HEAD", &oid_old_orig))
-			old_orig = &oid_old_orig;
-		if (head) {
-			if (!reflog_orig_head) {
-				strbuf_addstr(&msg, "updating ORIG_HEAD");
-				reflog_orig_head = msg.buf;
-			}
-			update_ref(reflog_orig_head, "ORIG_HEAD", head,
-				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
-		} else if (old_orig)
-			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
-	}
-
-	if (!reflog_head) {
-		strbuf_setlen(&msg, prefix_len);
-		strbuf_addstr(&msg, "updating HEAD");
-		reflog_head = msg.buf;
-	}
-	if (!switch_to_branch)
-		ret = update_ref(reflog_head, "HEAD", oid, head,
-				 detach_head ? REF_NO_DEREF : 0,
-				 UPDATE_REFS_MSG_ON_ERR);
-	else {
-		ret = update_ref(reflog_head, switch_to_branch, oid,
-				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
-		if (!ret)
-			ret = create_symref("HEAD", switch_to_branch,
-					    reflog_head);
-	}
-	if (!ret && run_hook)
-		run_hook_le(NULL, "post-checkout",
-			    oid_to_hex(head ? head : null_oid()),
-			    oid_to_hex(oid), "1", NULL);
+	ret = update_refs(oid, switch_to_branch, head, reflog_head,
+			  reflog_orig_head, default_reflog_action, flags);
 
 leave_reset_head:
-	strbuf_release(&msg);
 	rollback_lock_file(&lock);
 	clear_unpack_trees_porcelain(&unpack_tree_opts);
 	while (nr)
-- 
gitgitgadget

