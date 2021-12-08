Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5995C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhLHPBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbhLHPBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:39 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296BEC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u1so4487792wru.13
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xd+ypywzVV3tFJRAOUFQPGA4Cg9J597K3h9Tvzl3Q3g=;
        b=e+/dm3INuaPkzd+dLxPMADsr4YZoXRxvD4rHtnzii+jc6F9NeR3322gYczDWz6/eGY
         dnY6qLDN+L4XaoBrFYdiyort5TajZVVNgHwKFaa65avj+4nvg4lUSjV/gUBkO4TwbwTx
         sUcS5pdFksFwk5uGomohIw3PeLqVdos9MaTH3NhvMFPhYESVaM5Rb3V91nOH2ZIzxBg5
         cp5x6B31aRBY/Jg0FYw5GLN4+UW011QtGrfgMYqTm/PFMPBIaLoLkIt3ZiIUnMEeggDR
         aG7yofBER68VAXZ9WVWA5Mp1dM1D8yeWCEzugv6bEU7KkSw94DvZ3OQA0q17cZhN68RI
         jy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xd+ypywzVV3tFJRAOUFQPGA4Cg9J597K3h9Tvzl3Q3g=;
        b=NyRnsDrknfjMXhmkV0D+1RL3x3S1Z7rrZzIXYk0sv5cX/MoL2A7wgF47jQ43O8mWCT
         MCOozWT718WbixqL2raBv9Rpgz3d5WKcI7KKmAT3o3Exg/rrV2PXMCZPKIFdTxjFb7FF
         2JQtjKgQnEKTF6YwBa/Vr3iBIaIk0D+Cq47mIPTEv31Ql29vzrXzvSsyWbbNJ+Q0W9PE
         hdvnOMXRVb7bZqIceoLir2vYsUEhh9GQ/SiK227rDxsInt6C5LVE9Gtkf4tx5krwRiD0
         t4omQBo0KWtWnvwVwEe+Y8RsbLEUxzram9I3qkceN3v5E6v1fs7cg0xImFvezLi+VgBa
         EXFw==
X-Gm-Message-State: AOAM533mH2lqNffnovEh1mE5y75fxQ2LkVjyQisYS9uF8m8KDmsF81zl
        DCH55C+c4KIwp+GGYWlVZoemfbdoAuU=
X-Google-Smtp-Source: ABdhPJxTgNss+J0Hf7dlQV0Y3+OEOwMZYaaPOdbIbb1o1fjKQy68lN8cwz6s9KLmhAWE5aHR5xAbUg==
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr59202846wrs.270.1638975485578;
        Wed, 08 Dec 2021 06:58:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm2895172wrt.36.2021.12.08.06.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:05 -0800 (PST)
Message-Id: <07867760e68a6b28f718bdcb33094461592affaa.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:57:50 +0000
Subject: [PATCH v2 03/14] rebase: pass correct arguments to post-checkout hook
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

If a rebase started with "rebase [--apply|--merge] <upstream> <branch>"
detects that <upstream> is an ancestor of <branch> then it fast-forwards
and checks out <branch>. Unfortunately in that case it passed the null
oid as the first argument to the post-checkout hook rather than the oid
of HEAD.

A side effect of this change is that the call to update_ref() which
updates HEAD now always receives the old value of HEAD. This provides
protection against another process updating HEAD during the checkout.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 reset.c                       | 18 +++++++++---------
 t/t5403-post-checkout-hook.sh | 13 +++++++++++++
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/reset.c b/reset.c
index f214df3d96c..315fef91d33 100644
--- a/reset.c
+++ b/reset.c
@@ -18,7 +18,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
 	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
-	struct object_id head_oid;
+	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
 	struct unpack_trees_options unpack_tree_opts = { 0 };
@@ -26,8 +26,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	const char *reflog_action;
 	struct strbuf msg = STRBUF_INIT;
 	size_t prefix_len;
-	struct object_id *orig = NULL, oid_orig,
-		*old_orig = NULL, oid_old_orig;
+	struct object_id *old_orig = NULL, oid_old_orig;
 	int ret = 0, nr = 0;
 
 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
@@ -38,7 +37,9 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 		goto leave_reset_head;
 	}
 
-	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
+	if (!get_oid("HEAD", &head_oid)) {
+		head = &head_oid;
+	} else if (!oid || !reset_hard) {
 		ret = error(_("could not determine HEAD revision"));
 		goto leave_reset_head;
 	}
@@ -98,13 +99,12 @@ reset_head_refs:
 	if (update_orig_head) {
 		if (!get_oid("ORIG_HEAD", &oid_old_orig))
 			old_orig = &oid_old_orig;
-		if (!get_oid("HEAD", &oid_orig)) {
-			orig = &oid_orig;
+		if (head) {
 			if (!reflog_orig_head) {
 				strbuf_addstr(&msg, "updating ORIG_HEAD");
 				reflog_orig_head = msg.buf;
 			}
-			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
+			update_ref(reflog_orig_head, "ORIG_HEAD", head,
 				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
 		} else if (old_orig)
 			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
@@ -116,7 +116,7 @@ reset_head_refs:
 		reflog_head = msg.buf;
 	}
 	if (!switch_to_branch)
-		ret = update_ref(reflog_head, "HEAD", oid, orig,
+		ret = update_ref(reflog_head, "HEAD", oid, head,
 				 detach_head ? REF_NO_DEREF : 0,
 				 UPDATE_REFS_MSG_ON_ERR);
 	else {
@@ -128,7 +128,7 @@ reset_head_refs:
 	}
 	if (run_hook)
 		run_hook_le(NULL, "post-checkout",
-			    oid_to_hex(orig ? orig : null_oid()),
+			    oid_to_hex(head ? head : null_oid()),
 			    oid_to_hex(oid), "1", NULL);
 
 leave_reset_head:
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 272b02687ba..17ab518f268 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -72,6 +72,19 @@ test_rebase () {
 		test_cmp_rev rebase-on-me $new &&
 		test $flag = 1
 	'
+
+	test_expect_success "rebase $args fast-forward branch checkout runs post-checkout hook" '
+		test_when_finished "test_might_fail git rebase --abort" &&
+		test_when_finished "rm -f .git/post-checkout.args" &&
+		git update-ref refs/heads/rebase-fast-forward three &&
+		git checkout two  &&
+		rm -f .git/post-checkout.args &&
+		git rebase $args HEAD rebase-fast-forward  &&
+		read old new flag <.git/post-checkout.args &&
+		test_cmp_rev two $old &&
+		test_cmp_rev three $new &&
+		test $flag = 1
+	'
 }
 
 test_rebase --apply &&
-- 
gitgitgadget

