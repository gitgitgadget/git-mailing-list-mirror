Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC38C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01ECB206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMI0SGdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfLUV5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:57:22 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40144 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfLUV5V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 16:57:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id b8so12013040edx.7
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 13:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QIK/yWi2mHNX1QYUxJ0dJdvq/O6XJmG+5dnCmVm3Gb8=;
        b=oMI0SGddBVjnCuFHsYD2h1ZQRr3sXp1OMrVKj5gA/XeN3HPw9Lo44220MR8F1iru8J
         FO1w05WCdtnY2uhc6DuzibLxZthtHfaHuMfhHzaPhPcmFnYxe8kXow2Azo03ihE9wZpq
         APUOxdjcSFP+74P6GmytFWPpwfaO7p5pNCc5ATd3TUhR3e3LCxBA6JvDxUUoKnX4UmC0
         S0GxszuhZpHNgt5xGw6D89SCGn+/Wv5BvH5CR+g6DBodj+t4NXLFd/NK7ZH3Av89X3ll
         k8cni1E5vYzjNxPZpq2i2l2c3f9wBYM3JbwWvcYis8SSabncNjP0jn1wJuiXfrE0xdNj
         rRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QIK/yWi2mHNX1QYUxJ0dJdvq/O6XJmG+5dnCmVm3Gb8=;
        b=Qj16nwkH3GZere9oC9nfH4oy+t7Hg1SR6zDUkJLbwMkL8mTQ4MPW176WGTyUybkRKQ
         7+l/2ds44qXB5reM95uITfiMZkX3+uggzNE29Hz4kMCmVNcSa4U7e5vIYdXfEEPDSOoO
         5flFdi3biqQCdTRp4eJI71cQJq4zyVw9X1984mGSMNWNhb2ZPjKFZhqIl6WWxgRJz75M
         1FFygUqMrbjqFjW2Ekw/E7fxXDU+lcOtNnOazLcBhduLi+3Cy26/Fe35+5fqE3ChOi2V
         BRtjxwe52n267LsVGQPKiolpAlZFvPq57gXmi+7xvH5TcSbkcePlSpF/QnoNq5DsuZ9t
         ytcg==
X-Gm-Message-State: APjAAAXqbMcoP1wmgHssomm0yB/FHfwFT0Ex6MIo/diM9D1HRH6Zy+sr
        lQ49oh4/oAWxxCfkoUpNuoJ0xy4d
X-Google-Smtp-Source: APXvYqwImCpbE47sDKLTPkIEZJ1T4iTcHJLb6HgYYGxt6r0VaJfwbhwKXBuGWY601zQ40T85taOx1A==
X-Received: by 2002:a17:906:2e47:: with SMTP id r7mr23925900eji.215.1576965439370;
        Sat, 21 Dec 2019 13:57:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay24sm1543757edb.29.2019.12.21.13.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 13:57:19 -0800 (PST)
Message-Id: <6977bede86608636265c069e21779de706d0b917.1576965436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
        <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 21:57:11 +0000
Subject: [PATCH v2 2/7] built-in add -p: implement the "stash" and "reset"
 patch modes
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
 add-patch.c       | 83 ++++++++++++++++++++++++++++++++++++++++++++---
 builtin/add.c     |  4 +++
 3 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/add-interactive.h b/add-interactive.h
index e29a769aba..1f6a61326e 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -25,6 +25,8 @@ int run_add_i(struct repository *r, const struct pathspec *ps);
 
 enum add_p_mode {
 	ADD_P_ADD,
+	ADD_P_STASH,
+	ADD_P_RESET,
 };
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
diff --git a/add-patch.c b/add-patch.c
index 71356fbd9a..af0a86f0f7 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -19,7 +19,7 @@ struct patch_mode {
 	 * trailing `NULL`.
 	 */
 	const char *diff_cmd[4], *apply_args[4], *apply_check_args[4];
-	unsigned is_reverse:1, apply_for_checkout:1;
+	unsigned is_reverse:1, index_only:1, apply_for_checkout:1;
 	const char *prompt_mode[PROMPT_MODE_MAX];
 	const char *edit_hunk_hint, *help_patch_text;
 };
@@ -45,6 +45,72 @@ static struct patch_mode patch_mode_add = {
 			"the file\n")
 };
 
+static struct patch_mode patch_mode_stash = {
+	.diff_cmd = { "diff-index", "HEAD", NULL },
+	.apply_args = { "--cached", NULL },
+	.apply_check_args = { "--cached", NULL },
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
+	.diff_cmd = { "diff-index", "--cached", NULL },
+	.apply_args = { "-R", "--cached", NULL },
+	.apply_check_args = { "-R", "--cached", NULL },
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
+	.diff_cmd = { "diff-index", "-R", "--cached", NULL },
+	.apply_args = { "--cached", NULL },
+	.apply_check_args = { "--cached", NULL },
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
@@ -1350,12 +1416,21 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 
 	init_add_i_state(&s.s, r);
 
-	s.mode = &patch_mode_add;
+	if (mode == ADD_P_STASH)
+		s.mode = &patch_mode_stash;
+	else if (mode == ADD_P_RESET) {
+		if (!revision || !strcmp(revision, "HEAD"))
+			s.mode = &patch_mode_reset_head;
+		else
+			s.mode = &patch_mode_reset_nothead;
+	} else
+		s.mode = &patch_mode_add;
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
index 006016267e..b0d6891479 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -201,6 +201,10 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 
 		if (!strcmp(patch_mode, "--patch"))
 			mode = ADD_P_ADD;
+		else if (!strcmp(patch_mode, "--patch=stash"))
+			mode = ADD_P_STASH;
+		else if (!strcmp(patch_mode, "--patch=reset"))
+			mode = ADD_P_RESET;
 		else
 			die("'%s' not yet supported in the built-in add -p",
 			    patch_mode);
-- 
gitgitgadget

