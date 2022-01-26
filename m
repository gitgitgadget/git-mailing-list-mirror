Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5987C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiAZNGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiAZNGB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:06:01 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D4C061757
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:59 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s9so9856524wrb.6
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TmOsCUVLv78UYpyjVr7J4dwjfsQMyUYkg6um8Pkpdps=;
        b=e/6+hthzBqeGp2F24cK+7m+liLVbTjRKwolZAWu0SzdM3Z/rda/pPc0g8VuQG9Y2Kf
         ikUCym1js6J0e9mRmO4dObK1m1P3R45EeMZIqo4/6twWrw9HTxAGPY8WV5M9A0HI2zeP
         aH+9nJnwecKri0cL5G6fYK8kgFf0XQcQME1ZOhmX7c+P2isHiKGuzP0K1XLt1j+xVIFd
         DiAom/4tF9vFS8HGhFOBNQBNoStBu5x8gd87IiKvlrVQ4G4JClQul1lCtfKuHmZ33oUj
         4kD4wEo/1wp4Tr8NIdjgDo/5e8aKu/rsCwqJUZpqbF/YCgXfbSCrjFJfedrmvQxCqsEG
         juCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TmOsCUVLv78UYpyjVr7J4dwjfsQMyUYkg6um8Pkpdps=;
        b=nCXfb98wad6Xn85X+TPuwDxbbLaV/PIZb4+liICzTC85LbNrndPhvKYblMjN66EamM
         7n/3e8nAMvs++bHmq122B0vo/nFmyKw+dGXR4KdNUSmimo7PfWFSS4FkyF8w+L6vM6kl
         /qfxvZGrQp/ewgBOASTfGwDXKUoFqMBnh3FRjcGg8LP+UImKvVpmvaqP122N+1gmqv5P
         +xQYXnCGUgKHjeEyumuumvS0s87UzhzWDk4tWgwURR0kYV4GJG/B9mH4+dfOPVAaWj2J
         UgDDlrRz3qhZl34GjYsLrkWhnMGWuov3pBEToD1v7nPXtnrM0y5gw+K2OgXsY7aFD+t+
         cseA==
X-Gm-Message-State: AOAM530HZH3EQTpyTor3gbpAn2Fd7n8iJGtnnHwzfNgoWj+fU/IeV/lk
        yS3IsVSYAMlsKQqKHRZzEuQjbk+en48=
X-Google-Smtp-Source: ABdhPJyQGOM/sT2J46hTnrWo0dGJ1Wa+ZuwOiRVLs70oWJ2Z2T/27Y+JFK17GP8ZqIlIiWCtz5skbw==
X-Received: by 2002:a05:6000:1b0e:: with SMTP id f14mr22879576wrz.100.1643202357827;
        Wed, 26 Jan 2022 05:05:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm3342625wmc.36.2022.01.26.05.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:05:57 -0800 (PST)
Message-Id: <a5cc7eaa9256dbb8bc5722a4324bf20b8f08bd5c.1643202349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 13:05:43 +0000
Subject: [PATCH v3 08/14] reset_head(): make default_reflog_action optional
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
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2e5a535b54e..82be965915c 100644
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
-- 
gitgitgadget

