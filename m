Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D862CC2D0D4
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5BA206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dybsOX+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLUV51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:57:27 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46295 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfLUV5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 16:57:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id m8so11996502edi.13
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 13:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mkDlbzPKrBS8LfcJwDp7Qe0PWMD3QZohIR3qlH735Zs=;
        b=dybsOX+GQpsLu0B58CZFKPhu8TV2gKVDj+bYgtIz68jaaLA1thyf1ktvvfu3S8+sQy
         Ozanrv19crEUt2FnJwuM/jr86iUoa2wBXaJXcxIPZ6nDRVRYPnFU2Mmfavm65TC/GpTQ
         VjGWlTfOKCECCaVlk7zuBLtPJQ2lfOhaMn606PQs/WbiiIKRMlYR3UtddBzVQEBVeqnj
         XCfGlrRXlQEsEcPUldnyJEGMghycsu3pKED3/aUEMmX/k9seRWmilvjDxJhD2R31zHQb
         iODHqQHyz+DR6ZuX+w3Ns8RDY+iUyx6QwrVfvmTM49EpSD394wz03wHKxFdYYYpboS2n
         wgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mkDlbzPKrBS8LfcJwDp7Qe0PWMD3QZohIR3qlH735Zs=;
        b=aFH7sgg0MxMm5YQy7lZu5hKk+fkkfIzDZucp+wJhkt2oeW7Vi9XvE8MVomL323sFdU
         6X3SBNe2/rHTXGNDF5TzB/di6G5RVcc3XyTuIxTq6merF/PsMu85pkJW1X0sFOUJu63I
         o9xw3PzJ+xMerQhKb4KlnT7QCOAqI8GsLCoPyoIA7EXe2/fpro/YMjDZvz2+F7ghXM+5
         zPffGpeiqys8/sW34Qp/dcrQ0utOmIKkjsoN1lU2xyAERzFiu5TmEyq8E4IzuupwyjH3
         8oC9CZ4hBv59ssh4glz3uO9UxVGsFVtvHoqj3D6/aJD0wDucxv6SnvRaa3VyaPz/8cWT
         YAbA==
X-Gm-Message-State: APjAAAWuaT6YyJrHNhD4GUEghBDUY3/pUECkR7Al8lmPryEotSrJmobB
        Mz3GHfLiT2rNyRN1DJSUi3hpXqI8
X-Google-Smtp-Source: APXvYqyYbksGjA8SayIVmh36t/U4+3i5zN1+owkwOxe5o8X4AO51F5dWZNKA8+xRnADta7nviieLJQ==
X-Received: by 2002:a05:6402:305b:: with SMTP id bu27mr24534219edb.191.1576965442649;
        Sat, 21 Dec 2019 13:57:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m24sm1562548edr.83.2019.12.21.13.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 13:57:21 -0800 (PST)
Message-Id: <83e2ac6e67bd92850c2e0cfe628a20176eac4670.1576965436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
        <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 21:57:15 +0000
Subject: [PATCH v2 6/7] built-in add -p: implement the "worktree" patch modes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a straight-forward port of 2f0896ec3ad4 (restore: support
--patch, 2019-04-25) which added support for `git restore -p`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.h |  1 +
 add-patch.c       | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 builtin/add.c     |  2 ++
 3 files changed, 53 insertions(+)

diff --git a/add-interactive.h b/add-interactive.h
index 77907f6e21..b2f23479c5 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -28,6 +28,7 @@ enum add_p_mode {
 	ADD_P_STASH,
 	ADD_P_RESET,
 	ADD_P_CHECKOUT,
+	ADD_P_WORKTREE,
 };
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
diff --git a/add-patch.c b/add-patch.c
index ec5116c187..46c6c183d5 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -176,6 +176,49 @@ static struct patch_mode patch_mode_checkout_nothead = {
 			"the file\n"),
 };
 
+static struct patch_mode patch_mode_worktree_head = {
+	.diff_cmd = { "diff-index", NULL },
+	.apply_args = { "-R", NULL },
+	.apply_check_args = { "-R", NULL },
+	.is_reverse = 1,
+	.prompt_mode = {
+		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
+	},
+	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+			     "will immediately be marked for discarding."),
+	.help_patch_text =
+		N_("y - discard this hunk from worktree\n"
+		   "n - do not discard this hunk from worktree\n"
+		   "q - quit; do not discard this hunk or any of the remaining "
+			"ones\n"
+		   "a - discard this hunk and all later hunks in the file\n"
+		   "d - do not discard this hunk or any of the later hunks in "
+			"the file\n"),
+};
+
+static struct patch_mode patch_mode_worktree_nothead = {
+	.diff_cmd = { "diff-index", "-R", NULL },
+	.apply_args = { NULL },
+	.apply_check_args = { NULL },
+	.prompt_mode = {
+		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
+	},
+	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+			     "will immediately be marked for applying."),
+	.help_patch_text =
+		N_("y - apply this hunk to worktree\n"
+		   "n - do not apply this hunk to worktree\n"
+		   "q - quit; do not apply this hunk or any of the remaining "
+			"ones\n"
+		   "a - apply this hunk and all later hunks in the file\n"
+		   "d - do not apply this hunk or any of the later hunks in "
+			"the file\n"),
+};
+
 struct hunk_header {
 	unsigned long old_offset, old_count, new_offset, new_count;
 	/*
@@ -1551,6 +1594,13 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 			s.mode = &patch_mode_checkout_head;
 		else
 			s.mode = &patch_mode_checkout_nothead;
+	} else if (mode == ADD_P_WORKTREE) {
+		if (!revision)
+			s.mode = &patch_mode_checkout_index;
+		else if (!strcmp(revision, "HEAD"))
+			s.mode = &patch_mode_worktree_head;
+		else
+			s.mode = &patch_mode_worktree_nothead;
 	} else
 		s.mode = &patch_mode_add;
 	s.revision = revision;
diff --git a/builtin/add.c b/builtin/add.c
index 191856b036..b5927105aa 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -208,6 +208,8 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 			mode = ADD_P_RESET;
 		else if (!strcmp(patch_mode, "--patch=checkout"))
 			mode = ADD_P_CHECKOUT;
+		else if (!strcmp(patch_mode, "--patch=worktree"))
+			mode = ADD_P_WORKTREE;
 		else
 			die("'%s' not supported", patch_mode);
 
-- 
gitgitgadget

