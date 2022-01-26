Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ACBC3526D
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiAZNGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiAZNGF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:06:05 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02972C06176E
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:06:03 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r126so3542189wma.0
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EH+9PPT/YqzgF/M/po1DbJcl4pDjiNsu6hqRdVAbWOQ=;
        b=ATCIG8idNqwEcYKAsemi9Lhqeg+QcWXmtShxttmDp/aSDwEB3c2aRyND6a/mj5xZh/
         UHGscGZNh61nzs2t4ORygizlRTOoNvpVys8kEGx2XlQwpyC8pyb7XzgQeFMV6DPewF3X
         4izm+wW2hQrWr9Y1oFIAj6gdoXJC4vpaNJtJDnmTF7rGQ/5MAIF4L0tKBtlck0dDZ/dZ
         2N3NNwPtYh/H6HbfSO/B6KcYxwis6TxxERa9mGCtPk1SWtBJMdLdpjk6Abow0kysBc/6
         3HK2H5StNFNTVUrH4+gAEnILX+rwdG/CIeyA6vNRtI4HfdcvpsQZnBliqidb6NbvuDlu
         bquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EH+9PPT/YqzgF/M/po1DbJcl4pDjiNsu6hqRdVAbWOQ=;
        b=1ORnIsTo4CwzNkF8eIRdrnlhSO5tudjlGsXqCWIbUSpevhx1jpta0KqLeJBxhh0bAg
         C/2//s4Rx7pzHNJtUInpe/HCsRoXQxI0KiltpdNSBcnwKR87DgjyuE4/VXGvEtoJ/86Z
         TkXFOhvTAB1rkmIpqBZpZr2uQA+5aEse1RhojWuWMt4jMpZG98zmidj37brVSz23nuAF
         XQKVIOZQnft5MyRJXnolPbTI+Hcp2eR79qV63JLrzl+/ekBhhbp8A7Y/Z38jo635rNB6
         gTFSIXNIboA52G69zXqehBxmdiaG0lIU90uJvZZ+GYzS6IIbx56wmWOqErckPN9KOB+p
         +V6A==
X-Gm-Message-State: AOAM532NumNWzv2FOG2h8YtYJIe7kyv9gjYKfwwMPC841AqibI6EjskI
        0rSZmYNkX+RNrRCUdxU+iB3fJVgGQUI=
X-Google-Smtp-Source: ABdhPJx5oDogbLwhCPiPCyUzQrXEUbHHxAY6L/4AntsspXCtHavQnkXMLo1gmYrHX1AIW1J+6JH4vw==
X-Received: by 2002:a1c:f309:: with SMTP id q9mr7268088wmq.173.1643202361467;
        Wed, 26 Jan 2022 05:06:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u19sm2920383wmm.39.2022.01.26.05.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:06:00 -0800 (PST)
Message-Id: <4973892561e4c527aa167ca190d59e7b3a489133.1643202349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 13:05:47 +0000
Subject: [PATCH v3 12/14] rebase --apply: fix reflog
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

move_to_original_branch() passes the message intended for the branch
reflog as `orig_head_msg`. Fix this by adding a `branch_msg` member to
struct reset_head_opts and add a regression test.  Note that these
reflog messages do not respect GIT_REFLOG_ACTION. They are not alone
in that and will be fixed in a future series.

The "merge" backend already has tests that check both the branch and
HEAD reflogs.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          |  8 ++++----
 reset.c                   | 12 ++++++++++--
 reset.h                   |  4 ++++
 t/t3406-rebase-message.sh | 23 +++++++++++++++++++++++
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index ecc368dd4f4..b55a9cff05d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -570,7 +570,7 @@ static int finish_rebase(struct rebase_options *opts)
 
 static int move_to_original_branch(struct rebase_options *opts)
 {
-	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
+	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
 	struct reset_head_opts ropts = { 0 };
 	int ret;
 
@@ -580,17 +580,17 @@ static int move_to_original_branch(struct rebase_options *opts)
 	if (!opts->onto)
 		BUG("move_to_original_branch without onto");
 
-	strbuf_addf(&orig_head_reflog, "rebase finished: %s onto %s",
+	strbuf_addf(&branch_reflog, "rebase finished: %s onto %s",
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
 	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
 		    opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_HEAD_REFS_ONLY;
-	ropts.orig_head_msg = orig_head_reflog.buf;
+	ropts.branch_msg = branch_reflog.buf;
 	ropts.head_msg = head_reflog.buf;
 	ret = reset_head(the_repository, &ropts);
 
-	strbuf_release(&orig_head_reflog);
+	strbuf_release(&branch_reflog);
 	strbuf_release(&head_reflog);
 	return ret;
 }
diff --git a/reset.c b/reset.c
index 78145d5c456..e02915c0f65 100644
--- a/reset.c
+++ b/reset.c
@@ -16,6 +16,7 @@ static int update_refs(const struct reset_head_opts *opts,
 	unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
 	const char *switch_to_branch = opts->branch;
+	const char *reflog_branch = opts->branch_msg;
 	const char *reflog_head = opts->head_msg;
 	const char *reflog_orig_head = opts->orig_head_msg;
 	const char *default_reflog_action = opts->default_reflog_action;
@@ -58,8 +59,9 @@ static int update_refs(const struct reset_head_opts *opts,
 				 detach_head ? REF_NO_DEREF : 0,
 				 UPDATE_REFS_MSG_ON_ERR);
 	else {
-		ret = update_ref(reflog_head, switch_to_branch, oid,
-				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+		ret = update_ref(reflog_branch ? reflog_branch : reflog_head,
+				 switch_to_branch, oid, NULL, 0,
+				 UPDATE_REFS_MSG_ON_ERR);
 		if (!ret)
 			ret = create_symref("HEAD", switch_to_branch,
 					    reflog_head);
@@ -90,6 +92,12 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
 		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
 
+	if (opts->orig_head_msg && !update_orig_head)
+		BUG("ORIG_HEAD reflog message given without updating ORIG_HEAD");
+
+	if (opts->branch_msg && !opts->branch)
+		BUG("branch reflog message given without a branch");
+
 	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
diff --git a/reset.h b/reset.h
index a205be2fb85..7ef7e43ea8c 100644
--- a/reset.h
+++ b/reset.h
@@ -30,6 +30,10 @@ struct reset_head_opts {
 	 * Flags defined above.
 	 */
 	unsigned flags;
+	/*
+	 * Optional reflog message for branch, defaults to head_msg.
+	 */
+	const char *branch_msg;
 	/*
 	 * Optional reflog message for HEAD, if this omitted but oid or branch
 	 * are given then default_reflog_action must be given.
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 77a313f62eb..d17b450e811 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -105,6 +105,29 @@ test_expect_success 'GIT_REFLOG_ACTION' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase --apply reflog' '
+	git checkout -b reflog-apply start &&
+	old_head_reflog="$(git log -g --format=%gs -1 HEAD)" &&
+
+	git rebase --apply Y &&
+
+	git log -g --format=%gs -4 HEAD >actual &&
+	cat >expect <<-EOF &&
+	rebase finished: returning to refs/heads/reflog-apply
+	rebase: Z
+	rebase: checkout Y
+	$old_head_reflog
+	EOF
+	test_cmp expect actual &&
+
+	git log -g --format=%gs -2 reflog-apply >actual &&
+	cat >expect <<-EOF &&
+	rebase finished: refs/heads/reflog-apply onto $(git rev-parse Y)
+	branch: Created from start
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase -i onto unrelated history' '
 	git init unrelated &&
 	test_commit -C unrelated 1 &&
-- 
gitgitgadget

