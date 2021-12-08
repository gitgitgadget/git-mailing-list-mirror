Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFBFC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhLHPBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbhLHPBn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6684C061D5E
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:10 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d9so4561722wrw.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7frHrKSDoOqyYfdgR4JQWSleb705I+rDNQOnW/uiuno=;
        b=La7n4kxJOp/1UUEd8B9LGRFZKrEuy+8J7ebdcCXb1SHObEKt93/CexyaoCpQaz1s/o
         VXenijT+tKB5T9WZjDUCXdnlcMcB7D8R613z787/sunXbJ0xM3SlRlke/d79E19HD8WG
         oox9Kmro975ecOSIf7ENmJb0W13uAbaDksRaXDALk9n8PE3Uz4MZAHl+18Cgi3qm7jbo
         FxPFSwrY15FG1sQ7DNpH09XotkEyfibjqYckBh/ekgEjphmHyGLWQQKsfitaz7RCMP7I
         irqmZcp09bNnbh1z1jR7mdyN4taOxZuRaItrBcYCGBLS6GtQYeodpKrKKK1W5siOyDMQ
         Rd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7frHrKSDoOqyYfdgR4JQWSleb705I+rDNQOnW/uiuno=;
        b=pVecaxAmeBNIL/ljERBDP/BA3XzgyDeJj1ron0yYCLEVaZWMN0VIjVubcU0OVzv5gd
         vUsdIlmYaTNUHi6r4Z4cwciMAh011MkxPdXmp5M0w1Ntq73hCOLr2eqJNBxxDs877d9t
         zIk4f0bAX3Bj6n2ndEnGydyLFQMZ0gpgTKkd0BfCAwjByUYebgt3B7yDwUjYhy5qMpKb
         33eODq426Muz3iFDySK1lNScFyXv0RjKwDNVdi/Z/S7xEV60iBiwgc41IeqLzoF2m2P+
         e12HKCtMSGZZAz4Yzu+theMu+uxGuOBm6oecdMqxREKEzSKD2vULErtQmXfYj5rO5IkV
         ROaw==
X-Gm-Message-State: AOAM533HZOqvznMJp7TZfCT39PpEH/OEh2ipwVm+mNuH6rolXlpEkoip
        lwMHldrAcqY7AEjnYfpi4ANKBicB/jc=
X-Google-Smtp-Source: ABdhPJzISbj6dhzaF/4IVYnj6A1b04NGiGchKxwKVLfnlqQq12YH3CkN19FzfNH06ztXwIfckI1gGw==
X-Received: by 2002:adf:fb4f:: with SMTP id c15mr60738339wrs.507.1638975489206;
        Wed, 08 Dec 2021 06:58:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm2941941wru.40.2021.12.08.06.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:08 -0800 (PST)
Message-Id: <29e06e7d36de454da18de9fde871cbaf491cefc6.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:57:55 +0000
Subject: [PATCH v2 08/14] reset_head(): factor out ref updates
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

