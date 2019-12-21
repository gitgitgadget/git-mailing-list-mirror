Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D62C2D0D2
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B32206D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZSDqMR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLUV51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:57:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38956 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfLUV5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 16:57:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id t17so12013485eds.6
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 13:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c+3zDRjxVCZpalkUADyNLTen8xjdhpH88ydy+uKwmHE=;
        b=MZSDqMR24kjaVyU9ezkpRrvpFCmTdfdxMfATxHwANsEmgdiQWBgnmDjQKRVYPmrQrH
         TmBW26PjzcIw0IfDow86DyuCzbJ1PrXOdjTyvGE32OQPnE7ybbjToxEzUUlwQR3QwDGl
         JiUSGh54WpACo5hw8C1HNku8O0FcFK4Gj7Hh1dMj+WameS3DLRKuiCZ92wkPmqEBOqg2
         9Ju5MQkoFnxvZq8JpSLxua7Z1lm7lJpWXE50tRbXGf1T+jR6ZFuWsgk5wdzwj6U+aCtc
         OACrr2PDP4wUX7guA2tZADWG7Y/0cw1GGYvbMcLRBR7j9cCE2PCARukgeadhFSIb/pMS
         bXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c+3zDRjxVCZpalkUADyNLTen8xjdhpH88ydy+uKwmHE=;
        b=M0tbHOwOF6Wxv1dYLxeHOaZXSi4aLLia+3uyJf9Ws4gzzAD2RaKKdXN3s9ezfm/gzl
         5c4hs+LOmiR9nuarzaxvrupI0gHroVBR5mcW6xsDudyirf8S/H7L+HVvCNmPs8Wd0r1L
         7gLkOl4TEjSI6OJZvuvtYMDzfKlbOtWdJDsMNi2D5tlgby0zXqX6eXCi3ql0Wc/HzxUb
         o1c4TJzTTXj3bhTwdcRIy/+a/SWqzZv7xlW3ennkgekjoy7uuydBLXRdMMP4pGumraZq
         jPpyUIvgTsHK3u0S/sALmlhrJt7v65d03lBwaKjSA0qT//9W4mccxmjIYhGQu7v1j2t6
         U5og==
X-Gm-Message-State: APjAAAVv+I2yvNY8Oyf0W8tL2S/CGqc1DW4b0YJjXulRRMcKE4s+aGnM
        7ry5WEliaWFZz/srIU+EcQDz43AE
X-Google-Smtp-Source: APXvYqzre6O16i2jqxiAv0wIae1cWFDbIdoebk5o9N3/8ImEkvv1cnUsSH7NpVs/NwUyaDeIhkxrbA==
X-Received: by 2002:a05:6402:1611:: with SMTP id f17mr24172032edv.266.1576965441733;
        Sat, 21 Dec 2019 13:57:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm1649638ejx.20.2019.12.21.13.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 13:57:21 -0800 (PST)
Message-Id: <b3672b35e694660a57ba1201ec79ecf561d27704.1576965436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
        <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 21:57:14 +0000
Subject: [PATCH v2 5/7] built-in add -p: implement the "checkout" patch modes
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

This patch teaches the built-in `git add -p` machinery all the tricks it
needs to know in order to act as the work horse for `git checkout -p`.

Apart from the minor changes (slightly reworded messages, different
`diff` and `apply --check` invocations), it requires a new function to
actually apply the changes, as `git checkout -p` is a bit special in
that respect: when the desired changes do not apply to the index, but
apply to the work tree, Git does not fail straight away, but asks the
user whether to apply the changes to the worktree at least.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.h |   1 +
 add-patch.c       | 138 ++++++++++++++++++++++++++++++++++++++++++++--
 builtin/add.c     |   5 +-
 3 files changed, 137 insertions(+), 7 deletions(-)

diff --git a/add-interactive.h b/add-interactive.h
index 1f6a61326e..77907f6e21 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -27,6 +27,7 @@ enum add_p_mode {
 	ADD_P_ADD,
 	ADD_P_STASH,
 	ADD_P_RESET,
+	ADD_P_CHECKOUT,
 };
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
diff --git a/add-patch.c b/add-patch.c
index af0a86f0f7..ec5116c187 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -111,6 +111,71 @@ static struct patch_mode patch_mode_reset_nothead = {
 			"the file\n"),
 };
 
+static struct patch_mode patch_mode_checkout_index = {
+	.diff_cmd = { "diff-files", NULL },
+	.apply_args = { "-R", NULL },
+	.apply_check_args = { "-R", NULL },
+	.is_reverse = 1,
+	.prompt_mode = {
+		N_("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
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
+static struct patch_mode patch_mode_checkout_head = {
+	.diff_cmd = { "diff-index", NULL },
+	.apply_for_checkout = 1,
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
+		N_("y - discard this hunk from index and worktree\n"
+		   "n - do not discard this hunk from index and worktree\n"
+		   "q - quit; do not discard this hunk or any of the remaining "
+			"ones\n"
+		   "a - discard this hunk and all later hunks in the file\n"
+		   "d - do not discard this hunk or any of the later hunks in "
+			"the file\n"),
+};
+
+static struct patch_mode patch_mode_checkout_nothead = {
+	.diff_cmd = { "diff-index", "-R", NULL },
+	.apply_for_checkout = 1,
+	.apply_check_args = { NULL },
+	.prompt_mode = {
+		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
+	},
+	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+			     "will immediately be marked for applying."),
+	.help_patch_text =
+		N_("y - apply this hunk to index and worktree\n"
+		   "n - do not apply this hunk to index and worktree\n"
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
@@ -1067,6 +1132,57 @@ static int edit_hunk_loop(struct add_p_state *s,
 	}
 }
 
+static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
+			      int is_reverse)
+{
+	const char *reverse = is_reverse ? "-R" : NULL;
+	struct child_process check_index = CHILD_PROCESS_INIT;
+	struct child_process check_worktree = CHILD_PROCESS_INIT;
+	struct child_process apply_index = CHILD_PROCESS_INIT;
+	struct child_process apply_worktree = CHILD_PROCESS_INIT;
+	int applies_index, applies_worktree;
+
+	setup_child_process(s, &check_index,
+			    "apply", "--cached", "--check", reverse, NULL);
+	applies_index = !pipe_command(&check_index, diff->buf, diff->len,
+				      NULL, 0, NULL, 0);
+
+	setup_child_process(s, &check_worktree,
+			    "apply", "--check", reverse, NULL);
+	applies_worktree = !pipe_command(&check_worktree, diff->buf, diff->len,
+					 NULL, 0, NULL, 0);
+
+	if (applies_worktree && applies_index) {
+		setup_child_process(s, &apply_index,
+				    "apply", "--cached", reverse, NULL);
+		pipe_command(&apply_index, diff->buf, diff->len,
+			     NULL, 0, NULL, 0);
+
+		setup_child_process(s, &apply_worktree,
+				    "apply", reverse, NULL);
+		pipe_command(&apply_worktree, diff->buf, diff->len,
+			     NULL, 0, NULL, 0);
+
+		return 1;
+	}
+
+	if (!applies_index) {
+		err(s, _("The selected hunks do not apply to the index!"));
+		if (prompt_yesno(s, _("Apply them to the worktree "
+					  "anyway? ")) > 0) {
+			setup_child_process(s, &apply_worktree,
+					    "apply", reverse, NULL);
+			return pipe_command(&apply_worktree, diff->buf,
+					    diff->len, NULL, 0, NULL, 0);
+		}
+		err(s, _("Nothing was applied.\n"));
+	} else
+		/* As a last resort, show the diff to the user */
+		fwrite(diff->buf, diff->len, 1, stderr);
+
+	return 0;
+}
+
 #define SUMMARY_HEADER_WIDTH 20
 #define SUMMARY_LINE_WIDTH 80
 static void summarize_hunk(struct add_p_state *s, struct hunk *hunk,
@@ -1392,11 +1508,16 @@ static int patch_update_file(struct add_p_state *s,
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
 		discard_index(s->s.r->index);
-		setup_child_process(s, &cp, "apply", NULL);
-		argv_array_pushv(&cp.args, s->mode->apply_args);
-		if (pipe_command(&cp, s->buf.buf, s->buf.len,
-				 NULL, 0, NULL, 0))
-			error(_("'git apply' failed"));
+		if (s->mode->apply_for_checkout)
+			apply_for_checkout(s, &s->buf,
+					   s->mode->is_reverse);
+		else {
+			setup_child_process(s, &cp, "apply", NULL);
+			argv_array_pushv(&cp.args, s->mode->apply_args);
+			if (pipe_command(&cp, s->buf.buf, s->buf.len,
+					 NULL, 0, NULL, 0))
+				error(_("'git apply' failed"));
+		}
 		if (!repo_read_index(s->s.r))
 			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
 						     1, NULL, NULL, NULL);
@@ -1423,6 +1544,13 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 			s.mode = &patch_mode_reset_head;
 		else
 			s.mode = &patch_mode_reset_nothead;
+	} else if (mode == ADD_P_CHECKOUT) {
+		if (!revision)
+			s.mode = &patch_mode_checkout_index;
+		else if (!strcmp(revision, "HEAD"))
+			s.mode = &patch_mode_checkout_head;
+		else
+			s.mode = &patch_mode_checkout_nothead;
 	} else
 		s.mode = &patch_mode_add;
 	s.revision = revision;
diff --git a/builtin/add.c b/builtin/add.c
index fa8bf6b10a..191856b036 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -206,9 +206,10 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 			mode = ADD_P_STASH;
 		else if (!strcmp(patch_mode, "--patch=reset"))
 			mode = ADD_P_RESET;
+		else if (!strcmp(patch_mode, "--patch=checkout"))
+			mode = ADD_P_CHECKOUT;
 		else
-			die("'%s' not yet supported in the built-in add -p",
-			    patch_mode);
+			die("'%s' not supported", patch_mode);
 
 		return !!run_add_p(the_repository, mode, revision, pathspec);
 	}
-- 
gitgitgadget

