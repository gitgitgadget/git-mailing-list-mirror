Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9288C63686
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiAZNF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiAZNFz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:05:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2352C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:54 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w11so13503142wra.4
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xd+ypywzVV3tFJRAOUFQPGA4Cg9J597K3h9Tvzl3Q3g=;
        b=BUbIvk/xU0XGPEGhv6toJzZBiHJd8Kqa1P/gQVDH4ptAwW4IoJ7iE6ifUL1bOY777D
         6JJqlzILtQuK5xx/PjqcJU87wZhwDxcAc7Aopp1nJgJnG3iM0T2xHqsQwz5fCtimC8Lj
         jLV+XDWbReEPV0eeUzph7eL7GGhcWuax3CKVJEvt2UZbqkSZyas9japKMX8zvjmbWZWt
         fWlpsfzVPY3YFwg9lKFeWPtra4mstOCX5lMGMj8PB0cz5rn1vR/ONpYvDOvdTVxlG0qq
         1WgRFsPkd0Yts9amiIjRXIOm4KQyoxwTPxl/wybdA4B4epU+nf2b+0I3tZdRXXtVQjMu
         cbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xd+ypywzVV3tFJRAOUFQPGA4Cg9J597K3h9Tvzl3Q3g=;
        b=whnlRoOIyYypkEMd48J42qcBixecisKjcIVI18Ore6eKTgpssRVQJ8Wkoaauu4ZZG+
         pkuokKRyx3cOHqyFBD7vl0dax8cB2AEussd8f7wpfQ72hNxzuvIrCACnqVuz7h6dzXmF
         E2Em9A3L2tCgNeJ+YpTB63RLniqcgqi+nLr4Nb2N7m5JVFj05/8v9Nw59hFWwZ1J1nZ0
         dOeb81Jkvi25a2FQw7l8r3eTVM/J1JRiCu4VgP57Nv9nC4LGhQWsf4OAtuJ4vcre/40f
         Ss4PWHmioMOkxJ+FBsH70iy6wM+rEKk1axCv8dT80K088jUqjwG8CaxV9Y/jk333zgvW
         ZN/g==
X-Gm-Message-State: AOAM532oJaR++VFjmXdlMlk++fn7Cjmjzll1MiaVl2uOw5ywRGV4V420
        Q99PmYwf+IPbExgS+4kwOIJM/K+URFU=
X-Google-Smtp-Source: ABdhPJw8DqY9lB/fzW9DXx1ZzakzuHKwmzggXbKst0Ia4Z5QYNy3Lk1AVlE/IaObBg1R0AKDiWClMA==
X-Received: by 2002:adf:d1ed:: with SMTP id g13mr7526358wrd.495.1643202353325;
        Wed, 26 Jan 2022 05:05:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20sm4199453wms.24.2022.01.26.05.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:05:52 -0800 (PST)
Message-Id: <07867760e68a6b28f718bdcb33094461592affaa.1643202349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 13:05:38 +0000
Subject: [PATCH v3 03/14] rebase: pass correct arguments to post-checkout hook
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

