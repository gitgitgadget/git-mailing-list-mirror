Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D039C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhLHPBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbhLHPBn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:43 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89961C0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d24so4660903wra.0
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iHqRyCmXb+qp8S8EUX8N/yQFZfDqd+mO2lKyBZHuzbc=;
        b=jZBoehAg7nT8iS0p1pRPtLO5cjY7grrF9GHtNNOnWxHNi6iSLyUvNniRF4F+/ceLMy
         4Bp/2ApJ/w7F1uUcT3VmZf4Utth9lSOgrzBrg5nj5YGJPWmNIAJMY2ujB7O4tbIoYogv
         W7tMi13PakPwMOnrVleleeCeAYuDlHXGCZdoA6wONJZCT+3UR8kLEmyHteQfdQOavvKd
         PMLLyp2fM/JVkiOzCaBG4e12vN92D+jwQ8GU7Qn1trD1OWBbsuydnxpPFROnn9b5DK55
         mcAK6mIo4cXY5Ahytx374C8p/IhrQu72JGL/hZMnzeAX07m9J/4zAi4dwNpE0iexcg3D
         wUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iHqRyCmXb+qp8S8EUX8N/yQFZfDqd+mO2lKyBZHuzbc=;
        b=nBB0ZJ95T402YlTp2tWGLWh/p4jFMny94BDxmNetoG8E7Ca1PhB7N27S4n3HXHPKCT
         +k12FV+x9+nJbWP/Oqp9OSQR4YlzOzqYnqZmY2FwbJPkEvCtoUjvyc5Inu/dheOR6MtP
         SQtkGs5bMvdfkCjeTDBMQ6+nHyDZrzrP/+yIdrhwiBTKqIptReys8Am664qVMLda1/fk
         fqWnkONAubN5dJfZrI1FeZCO0SIChTpbjd1Pe8TVrQqlf1SFvvrR17hPa89WCVi4cVLT
         gQnO98hs+YXGq/MbVOhHNwKP+9r19aYkXuJnsDWoyv29D8HgJ0pW4OG5t4908AwLf/dm
         G1Og==
X-Gm-Message-State: AOAM530xIGL1KoRx0VBYc5jM/+/A3AjjMDKJxdnfx89BRobgcIugjseK
        GGKI7Ksgisp5/wmB8YrIwrUyl41kVRs=
X-Google-Smtp-Source: ABdhPJx9w8+equIq2xeqgO1suf8sJmpLBIYODGTrvXLInoQXRI8FW8f2Yxp4v3F2uq1y+1azwKloeA==
X-Received: by 2002:a5d:5272:: with SMTP id l18mr59626192wrc.208.1638975489895;
        Wed, 08 Dec 2021 06:58:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm2895336wrt.36.2021.12.08.06.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:09 -0800 (PST)
Message-Id: <9d00a218daf68a86e5dfba0c0cd66d6aaa6706b3.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:57:56 +0000
Subject: [PATCH v2 09/14] reset_head(): make default_reflog_action optional
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

This parameter is only needed when a ref is going to be updated and
the caller does not pass an explicit reflog message. Callers that are
only discarding uncommitted changes in the working tree such as such
as "rebase --skip" or create_autostash() do not update any refs so
should not have to worry about passing this parameter.

This change is not intended to have any user visible changes. The
pointer comparison between `oid` and `&head_oid` checks that the
caller did not pass an oid to be checked out. As no callers pass
RESET_HEAD_RUN_POST_CHECKOUT_HOOK without passing an oid there are
no changes to when the post-checkout hook is run. As update_ref() only
updates the ref if the oid passed to it differs from the current ref
there are no changes to when HEAD is updated.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 10 ++++------
 reset.c          | 16 ++++++++++++----
 sequencer.c      |  2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 832e6954827..3d78b5c8bef 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -585,8 +585,7 @@ static int move_to_original_branch(struct rebase_options *opts)
 		    opts->head_name);
 	ret = reset_head(the_repository, NULL, opts->head_name,
 			 RESET_HEAD_REFS_ONLY,
-			 orig_head_reflog.buf, head_reflog.buf,
-			 DEFAULT_REFLOG_ACTION);
+			 orig_head_reflog.buf, head_reflog.buf, NULL);
 
 	strbuf_release(&orig_head_reflog);
 	strbuf_release(&head_reflog);
@@ -822,7 +821,7 @@ static int checkout_up_to_date(struct rebase_options *options)
 		    options->switch_to);
 	if (reset_head(the_repository, &options->orig_head,
 		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
-		       NULL, buf.buf, DEFAULT_REFLOG_ACTION) < 0)
+		       NULL, buf.buf, NULL) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
 	strbuf_release(&buf);
 
@@ -1273,7 +1272,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		string_list_clear(&merge_rr, 1);
 
 		if (reset_head(the_repository, NULL, NULL, RESET_HEAD_HARD,
-			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
+			       NULL, NULL, NULL) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
 		if (read_basic_state(&options))
@@ -1778,8 +1777,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
 		reset_head(the_repository, NULL, options.head_name,
-			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf,
-			   DEFAULT_REFLOG_ACTION);
+			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf, NULL);
 		strbuf_release(&msg);
 		ret = finish_rebase(&options);
 		goto cleanup;
diff --git a/reset.c b/reset.c
index 56d6e2a06d9..4a92e4bc30b 100644
--- a/reset.c
+++ b/reset.c
@@ -22,8 +22,13 @@ static int update_refs(const struct object_id *oid, const char *switch_to_branch
 	size_t prefix_len;
 	int ret;
 
-	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
-	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
+	if ((update_orig_head && !reflog_orig_head) || !reflog_head) {
+		if (!default_reflog_action)
+			BUG("default_reflog_action must be given when reflog messages are omitted");
+		reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
+		strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action :
+							  default_reflog_action);
+	}
 	prefix_len = msg.len;
 
 	if (update_orig_head) {
@@ -71,6 +76,7 @@ int reset_head(struct repository *r, struct object_id *oid,
 {
 	unsigned reset_hard = flags & RESET_HEAD_HARD;
 	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
+	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
@@ -144,8 +150,10 @@ int reset_head(struct repository *r, struct object_id *oid,
 		goto leave_reset_head;
 	}
 
-	ret = update_refs(oid, switch_to_branch, head, reflog_head,
-			  reflog_orig_head, default_reflog_action, flags);
+	if (oid != &head_oid || update_orig_head || switch_to_branch)
+		ret = update_refs(oid, switch_to_branch, head, reflog_head,
+				  reflog_orig_head, default_reflog_action,
+				  flags);
 
 leave_reset_head:
 	rollback_lock_file(&lock);
diff --git a/sequencer.c b/sequencer.c
index 5c65f5f1ac5..78d203dec47 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4131,7 +4131,7 @@ void create_autostash(struct repository *r, const char *path)
 		write_file(path, "%s", oid_to_hex(&oid));
 		printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
-			       "") < 0)
+			       NULL) < 0)
 			die(_("could not reset --hard"));
 
 		if (discard_index(r->index) < 0 ||
-- 
gitgitgadget

