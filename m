Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF9DC2D0CD
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191C32072D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs9zdCnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLQKlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:41:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52631 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfLQKlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 05:41:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so2409436wmc.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 02:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E3FHiZK8wtbKuvN9mna1zOdfJOu4O5V2V0mZJhUNj4k=;
        b=Qs9zdCnkM/TvF1aE5UVTtwv6oamu5mp/xySqE0e69RbGg/UYKaAfP9gY9AjYN69SXN
         9FprtERQPaA6LNvPgUFRNaofdN2RS5ocOKLxfb7Yy+TexZN6Zq7w5fwPUyeGwA5Hnfrg
         mzEgO7S5KlFQetJTw+nYFicDnOmUWWCaCaPZn40/SF5gSHIuVNuxhoHl2FavNHbO946h
         uVGxVGvqXiSXrRLOfaMpJqlzWMnkLXs+oX6Uoj3HpAHEWZwGi8oMz7SEa0absHB8z1S0
         I7UDQNSokljGwghhAA2ovpQaKybf0eZlYXMeqgAZVo5O79YAQU+6UZDnbBS4XsMCgd5H
         Zf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E3FHiZK8wtbKuvN9mna1zOdfJOu4O5V2V0mZJhUNj4k=;
        b=ZgLT8nelomrBFkEF+k6FLJXxtsgtKLR0WdYgESDRy+iinDPtwKuxRlAKbLMNeA8vl/
         ugTsjRAXGFcKyYMrsHhcqN9LFGT3qcUNzdTDzK1vc4aPP9J2uf4cQ6WECYgef5rpt0d0
         dlRX0HSmjKlr1bXkULhSCkIR9aNnG8kscZdW0c+yhvT2dqXXTDcZzputwxDOpQkTYzbR
         GgrtT6HTrD9nGFlfBw5tQKYGHSCx5TsMiueZKNsRmIJPI9KfwvaMuLKiK5WkN+APVh6E
         +NmkV1WTR/rCIVz9KW9AvqPN/5yzr8qM3HxI25y8MR4XgjGA82o2SmibA8NWHGnc8SoB
         rbPg==
X-Gm-Message-State: APjAAAVxeXStVnx7hU+ddlLwDc6egbJAn1dkaABE/Dz/YLYlBOjNj4TR
        ec+J/vzQk3O4JrrxJ7NL0CA3Hc2N
X-Google-Smtp-Source: APXvYqxv1/Q1stlw8JwGc9K2dJ3Z0Z13kjAXnW8XboyYluuKzFL9LPrNxtlg+L4ggwTncTyeO7+SfA==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr4937034wmg.34.1576579268174;
        Tue, 17 Dec 2019 02:41:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s82sm2637412wms.28.2019.12.17.02.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 02:41:07 -0800 (PST)
Message-Id: <846cf16e77f4af39310902129be40fda664ace72.1576579264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.git.1576579264.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 10:40:59 +0000
Subject: [PATCH 2/7] built-in add -p: implement the "stash" and "reset" patch
 modes
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

The `git stash` and `git reset` commands support a `--patch` option, and
both simply hand off to `git add -p` to perform that work. Let's teach
the built-in version of that command to be able to perform that work, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.h |  2 ++
 add-patch.c       | 85 ++++++++++++++++++++++++++++++++++++++++++++---
 builtin/add.c     |  4 +++
 3 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/add-interactive.h b/add-interactive.h
index 3defa2ff3d..c278f3e26f 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -25,6 +25,8 @@ int run_add_i(struct repository *r, const struct pathspec *ps);
 
 enum add_p_mode {
 	ADD_P_STAGE,
+	ADD_P_STASH,
+	ADD_P_RESET,
 };
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
diff --git a/add-patch.c b/add-patch.c
index 8a691f07da..694e8e6624 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -13,7 +13,7 @@ enum prompt_mode_type {
 
 struct patch_mode {
 	const char *diff[4], *apply[4], *apply_check[4];
-	unsigned is_reverse:1, apply_for_checkout:1;
+	unsigned is_reverse:1, index_only:1, apply_for_checkout:1;
 	const char *prompt_mode[PROMPT_HUNK + 1];
 	const char *edit_hunk_hint, *help_patch_text;
 };
@@ -40,6 +40,74 @@ static struct patch_mode patch_mode_stage = {
 			"the file\n")
 };
 
+static struct patch_mode patch_mode_stash = {
+	.diff = { "diff-index", "HEAD", NULL },
+	.apply = { "--cached", NULL },
+	.apply_check = { "--cached", NULL },
+	.is_reverse = 0,
+	.prompt_mode = {
+		N_("Stash mode change [y,n,q,a,d%s,?]? "),
+		N_("Stash deletion [y,n,q,a,d%s,?]? "),
+		N_("Stash this hunk [y,n,q,a,d%s,?]? "),
+	},
+	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+			     "will immediately be marked for stashing."),
+	.help_patch_text =
+		N_("y - stash this hunk\n"
+		   "n - do not stash this hunk\n"
+		   "q - quit; do not stash this hunk or any of the remaining "
+			"ones\n"
+		   "a - stash this hunk and all later hunks in the file\n"
+		   "d - do not stash this hunk or any of the later hunks in "
+			"the file\n"),
+};
+
+static struct patch_mode patch_mode_reset_head = {
+	.diff = { "diff-index", "--cached", NULL },
+	.apply = { "-R", "--cached", NULL },
+	.apply_check = { "-R", "--cached", NULL },
+	.is_reverse = 1,
+	.index_only = 1,
+	.prompt_mode = {
+		N_("Unstage mode change [y,n,q,a,d%s,?]? "),
+		N_("Unstage deletion [y,n,q,a,d%s,?]? "),
+		N_("Unstage this hunk [y,n,q,a,d%s,?]? "),
+	},
+	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+			     "will immediately be marked for unstaging."),
+	.help_patch_text =
+		N_("y - unstage this hunk\n"
+		   "n - do not unstage this hunk\n"
+		   "q - quit; do not unstage this hunk or any of the remaining "
+			"ones\n"
+		   "a - unstage this hunk and all later hunks in the file\n"
+		   "d - do not unstage this hunk or any of the later hunks in "
+			"the file\n"),
+};
+
+static struct patch_mode patch_mode_reset_nothead = {
+	.diff = { "diff-index", "-R", "--cached", NULL },
+	.apply = { "--cached", NULL },
+	.apply_check = { "--cached", NULL },
+	.is_reverse = 0,
+	.index_only = 1,
+	.prompt_mode = {
+		N_("Apply mode change to index [y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to index [y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to index [y,n,q,a,d%s,?]? "),
+	},
+	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+			     "will immediately be marked for applying."),
+	.help_patch_text =
+		N_("y - apply this hunk to index\n"
+		   "n - do not apply this hunk to index\n"
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
@@ -1345,12 +1413,21 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 
 	init_add_i_state(&s.s, r);
 
-	s.mode = &patch_mode_stage;
+	if (mode == ADD_P_STASH)
+		s.mode = &patch_mode_stash;
+	else if (mode == ADD_P_RESET) {
+		if (!revision || !strcmp(revision, "HEAD"))
+			s.mode = &patch_mode_reset_head;
+		else
+			s.mode = &patch_mode_reset_nothead;
+	} else
+		s.mode = &patch_mode_stage;
 	s.revision = revision;
 
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0 ||
-	    repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
-					 NULL, NULL, NULL) < 0 ||
+	    (!s.mode->index_only &&
+	     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
+					  NULL, NULL, NULL) < 0) ||
 	    parse_diff(&s, ps) < 0) {
 		strbuf_release(&s.plain);
 		strbuf_release(&s.colored);
diff --git a/builtin/add.c b/builtin/add.c
index 05b727a426..583d8aab0d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -201,6 +201,10 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 
 		if (!strcmp(patch_mode, "--patch"))
 			mode = ADD_P_STAGE;
+		else if (!strcmp(patch_mode, "--patch=stash"))
+			mode = ADD_P_STASH;
+		else if (!strcmp(patch_mode, "--patch=reset"))
+			mode = ADD_P_RESET;
 		else
 			die("'%s' not yet supported in the built-in add -p",
 			    patch_mode);
-- 
gitgitgadget

